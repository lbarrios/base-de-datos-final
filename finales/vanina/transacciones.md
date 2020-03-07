## - Definir transacción.

Una transacción es un conjunto de operaciones que se realizan de forma atómica, cumpliendo las propiedades ACID.

## - Explicar las propiedades ACID.

Atomicity / Atomicidad: es la propiedad de que las operaciones en una transacción se ejecuten de forma atómica, es decir, como si fuesen una sola operación. Dicho de otro modo, o bien todas las operaciones son aplicadas, o bien ninguna lo es.

Consistency / Consistencia: si la base era consistente antes de iniciar una transacción, esta debe seguir siendo consistente al finalizar la transacción.

Isolation / Aislamiento: distintas transacciones ejecutándose concurrentemente no deben afectar unas a otras. Las transacciones no deberían tener que considerar la posible existencia de otras transacciones.

Durability / Durabilidad: cuando una transacción es commiteada, esta es persistida, y los cambios realizados se van a mantener incluso ante la presencia de una falla posterior.

## - Dar un ejemplo de transacciones de algún dominio. ¿Por qué es importante el control de concurrencia?

(de cubawiki)

Una transacción es un conjunto de instrucciones que se ejecutan formando una unidad lógica de procesamiento. Una transacción puede incluir uno o más accesos a la BD a través del uso de diversas operaciones (inserción, eliminación, modificación, etc.).

Diversos sistemas como los bancarios, los de reservas de vuelos o del mercado de valores, usan transacciones para garantizar la consistencia de los datos. Por ejemplo, un sistema bancario que usa una transacción para actualizar dos saldos a causa una transferencia evita la pérdida o creación de dinero en caso de fallas. En este caso, la atomicidad de la transacción garantiza que se ejecuta completo o se deshace por completo.

Este tipo de sistemas requieren rápida respuesta y alta disponibilidad para muchos usuarios que acceden de manera concurrente. En este escenario, un motor de base de datos hace uso de la multiprogramación, intercalando operaciones de distintas transacciones que se ejecutan concurrentemente. El control de concurrencia resulta importante pues queremos evitar que una transacción interfiera con otra: para el usuario, las transacciones se comportan como si se hubieran ejecutado una a continuación de la otra. De no manejar la concurrencia, pueden aparecer distintos problemas como:

- Lost update
- Dirty read
- Incorrect summary
- Unrepeatable read

