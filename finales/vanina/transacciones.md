## - Definir transacción.

Una transacción es un conjunto de operaciones que se realizan de forma atómica, cumpliendo las propiedades ACID.

## - Explicar las propiedades ACID.

Atomicity / Atomicidad: es la propiedad de que las operaciones en una transacción se ejecuten de forma atómica, es decir, como si fuesen una sola operación. Dicho de otro modo, o bien todas las operaciones son aplicadas, o bien ninguna lo es.

Consistency / Consistencia: si la base era consistente antes de iniciar una transacción, esta debe seguir siendo consistente al finalizar la transacción.

Isolation / Aislamiento: distintas transacciones ejecutándose concurrentemente no deben afectar unas a otras. Las transacciones no deberían tener que considerar la posible existencia de otras transacciones.

Durability / Durabilidad: cuando una transacción es commiteada, esta es persistida, y los cambios realizados se van a mantener incluso ante la presencia de una falla posterior.

## - Dar un ejemplo de transacciones de algún dominio. ¿Por qué es importante el control de concurrencia?

==TODO:==