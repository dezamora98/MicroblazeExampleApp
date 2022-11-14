Los LTC1407-1/LTC1407A-1 son ADC de 12 bits/14 bits con dos entradas diferenciales muestreadas simultáneamente a un máximo de 1.5 Msps por cada frente de subida de la señal CONV. En la placa de desarrollo se encuentra el LTC1407A-1 de 14 bits.

![[Pasted image 20221114143435.png]]

**SDO**, Salida de datos en serie de tres estados: Cada par de palabras (16 bits) de datos de salida representan los dos canales analógicos al inicio de la conversión anterior. El formato de salida es **complemento a 2**.
**SCK**, Entrada de reloj externo: Avanza el proceso de conversión y secuencia los datos de salida en el flanco de subida. Uno o más pulsos despiertan del sueño.
**CONV**, Inicio de conversión: Mantiene las dos señales de entrada analógica y comienza la conversión en el flanco ascendente. Dos dos pulsos con SCK en estado fijo alto o fijo bajo inicia el modo de suspensión. Cuatro o más pulsos con SCK en estado fijo alto o fijo bajo bajo, se inicia el modo de reposo. 

![[Pasted image 20221114145748.png]]

La figura [[Pasted image 20221114145748.png]] muestra la temporización detallada de la transacción. La señal AD_CONV no es una habilitación de selección de esclavo SPI tradicional. Es necesario proporcionar suficientes ciclos de reloj SPI_SCK para que el ADC deje la señal SPI_MISO en el estado de alta impedancia. De lo contrario, el ADC bloquea la comunicación con los otros periféricos SPI. Como se muestra en la Figura, debe utilizarce una secuencia de comunicación de 34 ciclos de reloj. El ADC pone en estado 3 su salida de datos durante dos ciclos de reloj antes y después de cada transferencia de datos de 14 bits y envía los datos desde el bit más significativo al menos significativo.