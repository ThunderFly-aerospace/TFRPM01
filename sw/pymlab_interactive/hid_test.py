import hid

device = None
try:
    device = hid.device()
    device.open(0x10C4, 0xEA90)  # Vendor ID and Product ID for CP2112
    print("Device successfully opened")

    # Nastavení neblokujícího režimu
    device.set_nonblocking(1)

    # Odeslání jednoduchého požadavku (např. 0x00)
    try:
        device.write([0x00])  # Změňte podle protokolu zařízení
        print("Request sent.")
    except OSError as e:
        print("Failed to send request:", e)

    # Pokus o čtení odpovědi
    data = device.read(64)
    if data:
        print("Data read:", data)
    else:
        print("No data received (timeout)")

except OSError as e:
    print("Failed to open device:", e)

finally:
    if device is not None:
        device.close()
        print("Device closed")

