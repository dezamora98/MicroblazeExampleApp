La interfaz de periféricos en serie (SPI) de XPS se conecta al PLB V4.6 (_Bus Local del Procesador_ con simplificaciones de Xilinx) y proporciona una plataforma de abstracción a nivel de software y hardware para la comunicación con esclavos o maestros conectados a un bus SPI como memorias _EEPROMs_ y _Flash_, conversores ADC y DAC, y otros periféricos . El core xps_SPI presenta las siguientes características:
* Se conecta como esclavo de 32 bits en buses PLB V4.6 de 32 64 o 128 bits.
- Soporta cuatro señales de interfaz (MOSI, MISO, SCK y SS).
- Soporta el bit de selección de esclavo (SS) para cada esclavo en el bus SPI.
- Soporta la comunicación full-duplex.
- Soporta modos SPI maestro y esclavo.
- Soporta fase y polaridad de reloj programable.
- Admite el modo de transferencia continua para la de un periférico.
- Admite transacciones consecutivas.
- Admite los modos de selección automática o manual de esclavos
- Admite transacciones de MSB/LSB primero.
- Admite una longitud de transferencia de 8 bits, 16 bits o 32 bits.
- Admite la capacidad de bucle de retorno local para realizar pruebas
- Admite múltiples maestros y esclavos entorno.
- Opción de 16 elementos de profundidad (un elemento es un byte, una
media palabra o una palabra) para transmitir y recibir FIFOs