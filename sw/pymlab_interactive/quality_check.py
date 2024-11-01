import curses
import time, datetime
from pymlab import config
import argparse
import os
import beepy

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
            print("Connecting...")
            if error:
                print("Configuring device...")  # Ladicí výpis
                
                # Ladicí výpis: vstupní parametry
                print(f"Port: {args.port}, Address: {address}")
                cfg = config.Config(
                    i2c = {
                        "port": args.port,
                        "device": "smbus2",
                    },
                    bus = [
                        {
                            "name": "TFRPM01",
                            "type": "rtc01",
                            "address": address
                        }
                    ]
                )

                # Ladicí výpis: počátek inicializace konfigurace
                print("Initializing configuration...")
                cfg.initialize()
                
                # Ladicí výpis: získávání zařízení
                print("Getting TFRPM01 device...")
                TFRPM01 = cfg.get_device("TFRPM01")
                print("Initializing TFRPM01...")
                TFRPM01.initialize()

                # Nastavení konfigurace zařízení
                print("Setting device configuration...")
                TFRPM01.set_config(TFRPM01.FUNCT_MODE_count)

                # Resetování čítače
                print("Resetting counter...")
                TFRPM01.reset_counter()

                # Získání čítače a výpis jeho hodnoty
                count = TFRPM01.get_count()
                print(f"Initial count value: {count}")

                connected = datetime.datetime.now()
                error = False
                print("Device connected successfully.")
                beepy.beep(sound=1)

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
                    beepy.beep(sound=5)
                else:
                    screen.addstr(11, 0, "In range: ERROR", curses.color_pair(3))

                screen.refresh()
                time.sleep(0.2)

                #if count >= TFRPM01.MAX_COUNT / 2:
                #    TFRPM01.reset_counter()
                #    #time.sleep(0.1)
                #    #screen.addstr(10, 0, "Counter reset due to half range exceeded")
                #if integration_time > 5:
                #    TFRPM01.reset_counter()
                #    #time.sleep(0.1)
                #    #screen.addstr(10, 0, "Counter reset due to integration time exceeded")

        except IOError as ioe:
            print(f"IO ERROR: {ioe}")  # Ladicí výpis chyby
            if not error:
                screen.clear()
                screen.addstr(0, 0, "IO ERROR: Check connection.")
                time.sleep(0.5)
                
                error = True

        except Exception as e:
            print(f"ERROR: {e}")  # Obecný výpis chyby
            if not error:
                screen.clear()
                screen.addstr(0, 0, f"General ERROR: {str(e)}")
                time.sleep(0.5)
                
                error = True

    curses.nocbreak()
    screen.keypad(False)
    curses.echo()
    curses.endwin()

if __name__ == "__main__":
    curses.wrapper(main)
