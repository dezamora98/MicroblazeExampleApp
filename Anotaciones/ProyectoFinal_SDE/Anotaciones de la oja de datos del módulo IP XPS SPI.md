La interfaz de periféricos en serie (SPI) de XPS se conecta al PLB V4.6 (_Bus Local del Procesador_ con simplificaciones de Xilinx) y proporciona una plataforma de abstracción a nivel de software y hardware para la comunicación con esclavos o maestros conectados a un bus SPI como memorias _EEPROMs_ y _Flash_, conversores ADC y DAC, y otros periféricos . El core SPI de XPS presenta las siguientes características:
* Se conecta como esclavo de 32 bits en buses PLB V4.6 de 32 64 o 128 bits.
- Soporta cuatro señales de interfaz (MOSI, MISO, SCK y SS).
- Soporta el bit de selección de esclavo (SS) para cada esclavo en el bus SPI.
- Admite los modos de selección automática o manual de esclavos
	- El code SPI de XPS soporta el modo de selección manual de esclavos como modo de operación por defecto. Este modo permite al usuario controlar manualmente la línea de selección de esclavos mediante los datos escritos en el registro de selección de esclavos. Esto permite transferir un número arbitrario de elementos sin alternar la línea de selección de esclavo entre los elementos. Sin embargo, el usuario debe conmutar la línea de selección de esclavos antes de iniciar una nueva transferencia.
	- El otro modo de funcionamiento es el de selección automática de esclavos. En este modo, la línea de selección de esclavo se conmuta automáticamente después de cada transferencia de elementos. Este modo se describe con más detalle en la sección **Protocolo SPI con Slave Select Assertion**.
- Soporta la comunicación full-duplex.
- Soporta modos SPI maestro y esclavo.
- Soporta fase y polaridad de reloj programable.
- Admite el modo de transferencia continua para la de un periférico.
	- El XPS SPI IP Core soporta el modo de transferencia continua, en el que cuando se configura como maestro la transferencia continúa hasta que los datos estén disponibles en el registro de transmisión/FIFO. Esta capacidad se proporciona tanto en el modo de selección manual como en el automático
- Admite transacciones consecutivas.

- Admite transacciones de MSB/LSB primero.
- Admite una longitud de transferencia de 8 bits, 16 bits o 32 bits.
- Admite la capacidad de bucle de retorno local para realizar pruebas.
- Admite múltiples maestros y esclavos entorno.
- Opción de 16 elementos de profundidad (un elemento es un byte, una media palabra o una palabra) para transmitir y recibir FIFOs








![[Pasted image 20221114230045.png]]