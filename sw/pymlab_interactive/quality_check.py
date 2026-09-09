import curses
import time, datetime
from pymlab import config
import argparse
import os
import numpy as np
import sounddevice as sd

# Use a larger output buffer/latency so short beeps don't underrun the ALSA
# buffer (heard as crackling, and reported by ALSA as "PCM" errors on stderr).
sd.default.latency = 'high'


# Zpracování vstupních argumentů
parser = argparse.ArgumentParser(description='Callibration utility for TFRPM01 sensor')
parser.add_argument('--port', type=str, required=True, help='I2C port, e.g. /dev/i2c-1')
parser.add_argument('--address', type=lambda x: int(x, 0), required=True, help='I2C sensor address. e.g. 0x50')
parser.add_argument('--req_freq', type=int, required=True, help='Required frequency in Hz')
parser.add_argument('--max_deviation', type=int, required=True, help='Maximum deviation in Hz')

args = parser.parse_args()

req_freq = args.req_freq
max_deviation = args.max_deviation

address = args.address

error = True
connected = 0

SAMPLE_RATE = 44100
GAP_DURATION = 0.02  # short silence between notes, to avoid clicks merging notes together

# Kept open for the whole program run: opening/closing a stream per beep was
# causing the ALSA device to underrun (audible crackle + "PCM" errors on
# stderr) on every beep, since the device barely had time to warm up.
_audio_stream = sd.OutputStream(samplerate=SAMPLE_RATE, channels=1, dtype="float32", latency="high")
_audio_stream.start()


def generate_wave(frequency, duration, amplitude=0.3, sample_rate=SAMPLE_RATE):
    """
    Generates a beep waveform of specified frequency and duration, with a
    short fade in/out to avoid clicks at the edges.
    """
    n_samples = int(sample_rate * duration)
    t = np.linspace(0, duration, n_samples, endpoint=False)
    wave = amplitude * np.sin(2 * np.pi * frequency * t)

    fade_samples = min(n_samples // 2, int(sample_rate * 0.005))
    if fade_samples > 0:
        fade = np.linspace(0, 1, fade_samples)
        wave[:fade_samples] *= fade
        wave[-fade_samples:] *= fade[::-1]

    return wave


def play_melody(frequencies, durations, sample_rate=SAMPLE_RATE):
    """
    Concatenates all notes into a single waveform and writes it to the
    already-running output stream in one go, so there is no audible
    gap/stutter between notes and no per-beep stream open/close.
    """
    gap = np.zeros(int(sample_rate * GAP_DURATION))
    segments = []
    for freq, dur in zip(frequencies, durations):
        segments.append(generate_wave(freq, dur, sample_rate=sample_rate))
        segments.append(gap)
    wave = np.concatenate(segments).astype(np.float32).reshape(-1, 1)
    _audio_stream.write(wave)


def success_sound():
    """
    Plays a short melody for success/ok/ready.
    """
    # Sequence of frequencies to create a "success" melody
    frequencies = [523, 659, 784]  # Notes C5, E5, G5
    durations = [0.15, 0.15, 0.3]
    play_melody(frequencies, durations)

def error_sound():
    """
    Plays a sound indicating failure/error.
    """
    # A lower tone repeated to create a "error" effect
    frequencies = [300, 300]  # Lower frequency for error
    durations = [0.4, 0.4]
    play_melody(frequencies, durations)

def connection_sound():
    """
    Plays a simple connection sound to indicate device connection.
    """
    frequencies = [440, 494]  # A4, B4 (stoupající tón)
    durations = [0.2, 0.3]
    play_melody(frequencies, durations)

def main(screen):
    global error, req_freq, max_deviation

    curses.start_color()
    curses.init_pair(1, curses.COLOR_WHITE, curses.COLOR_BLACK)
    curses.init_pair(2, curses.COLOR_BLACK, curses.COLOR_GREEN)
    curses.init_pair(3, curses.COLOR_BLACK, curses.COLOR_RED)

    curses.cbreak()
    curses.noecho()
    screen.keypad(True)
    screen.clear()

    while True:
        try:
            screen.addstr(0, 0, "Connecting...")
            screen.refresh()
            if error:
                screen.addstr(1, 0, "Configuring device...")
                screen.addstr(2, 0, f"Port: {args.port}, Address: {address}")
                screen.refresh()
                
                cfg = config.Config(
                    i2c = {
                        "port": args.port,
                        "device": "hid",
                    },
                    bus = [
                        {
                            "name": "TFRPM01",
                            "type": "rtc01",
                            "address": address
                        }
                    ]
                )

                #print("Initializing configuration...")
                cfg.initialize()
                
                #print("Getting TFRPM01 device...")
                TFRPM01 = cfg.get_device("TFRPM01")
                #print("Initializing TFRPM01...")
                TFRPM01.initialize()

                #print("Setting device configuration...")
                TFRPM01.set_config(TFRPM01.FUNCT_MODE_count)

                #print("Resetting counter...")
                TFRPM01.reset_counter()
                count = TFRPM01.get_count()
                #print(f"Initial count value: {count}")

                connected = datetime.datetime.now()
                error = False
                #print("Device connected successfully.")
                connection_sound()  # Plays the success sound

            while True:
                count = TFRPM01.get_count()
                freq = TFRPM01.get_frequency()
                integration_time = TFRPM01.get_integration_time()
                    
                screen.clear()

                screen.addstr(0, 0, "TFRPM01 validator")
                screen.addstr(2, 0, f"Target frequency: {req_freq} HZ")
                screen.addstr(3, 0, f"Accepted range {req_freq - max_deviation} - {req_freq + max_deviation} Hz")

                screen.addstr(6, 0, f"Connected: {(datetime.datetime.now() - connected).seconds} s")
                screen.addstr(7, 0, f"Count: {count}")
                screen.addstr(8, 0, f"Frequency: {freq} Hz")
                screen.addstr(9, 0, f"Integration Time: {integration_time:.2f} s")

                in_range = bool(req_freq - max_deviation <= freq <= req_freq + max_deviation)
                if in_range:
                    screen.addstr(11, 0, "In range: OK", curses.color_pair(2))
                    success_sound()  # Plays the success sound
                else:
                    screen.addstr(11, 0, "In range: ERROR", curses.color_pair(3))
                    error_sound()

                screen.refresh()

                #if count >= TFRPM01.MAX_COUNT / 2:
                #    TFRPM01.reset_counter()
                #    #time.sleep(0.1)
                #    #screen.addstr(10, 0, "Counter reset due to half range exceeded")
                #if integration_time > 5:
                #    TFRPM01.reset_counter()
                #    #time.sleep(0.1)
                #    #screen.addstr(10, 0, "Counter reset due to integration time exceeded")

        except IOError as ioe:
            if not error:
                screen.clear()
                screen.addstr(0, 0, "IO ERROR: Communication issue detected.")
                screen.addstr(1, 0, f"Error details: {str(ioe)}")
                screen.refresh()

                error = True

            time.sleep(0.5)

        except Exception as e:
            if not error:
                screen.clear()
                screen.addstr(0, 0, f"General ERROR: {str(e)}")
                screen.refresh()

                error = True

            time.sleep(0.5)

    curses.nocbreak()
    screen.keypad(False)
    curses.echo()
    curses.endwin()

if __name__ == "__main__":
    curses.wrapper(main)
