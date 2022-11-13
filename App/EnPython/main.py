from UartCom import UartCom
import matplotlib.pyplot as plt
import matplotlib.animation as animation
import threading
import tkinter


#main code:

gData = []
gData.append([0])
gData.append([0])

#Configuramos la gráfica

fig = plt.figure()
ax = fig.add_subplot()
hl, = plt.plot(gData[0], gData[1])

plt.ylim(-260, 260)
plt.xlim(0,3000)


#end maincode

# Función que actualizará los datos de la gráfica
def update_line(num, hl, data):
    hl.set_data(range(len(data[1])), data[1])
    return hl,

# Configuramos la función que "animará" nuestra gráfica
line_ani = animation.FuncAnimation(fig, update_line, fargs=(hl, gData), interval=50, blit=False)
# Configuramos y lanzamos el hilo encargado de leer datos del serial

dataCollector = threading.Thread(target = UartCom.GetData, args=(gData,3000,))
dataCollector.start()
plt.show()
dataCollector.join()