import serial

def GetData(out_data,size):
    with serial.Serial('COM10',115200, timeout=1) as ser:
        print(ser.isOpen())
        while True:
            line = ser.readline().decode('utf-8')
            out_data[1].append( float(line) )
            if len(out_data[1]) > size:
                out_data[1].pop(0)