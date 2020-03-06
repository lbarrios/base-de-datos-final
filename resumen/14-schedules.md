# 14. Schedules

## Transacción
Una transacción es una colección de operaciones que deben aplicarse de forma atómica en una base de datos. Esta atomicidad, además aplica a la consistencia (las restricciones de la base), es decir que si una base de datos era consistente antes de una transacción, debe seguir siéndolo luego de aplicar la misma. La base puede volverse, sin embargo, inconsistente de forma temporal durante la aplicación de las operaciones internas de la transacción.

- Toda transacción termina, o bien con un ABORT (y su respectivo rollback), o bien con un COMMIT.

## Propiedades ACID
Propiedades que debe cumplir una transacción.

- **Atomicidad**: O bien todas las operaciones son aplicadas apropiadamente en la base de datos, o bien ninguna lo es. 
- **Consistencia** (integridad): La ejecución de una transacción preserva la consistencia de una base de datos.
- **Isolación** (aislamiento): Una transacción no puede afectar a otra. Cada transacción es independiente de otras transacciones ejecutándose concurrentemente en el sistema.
- **Durabilidad** (persistencia): Los cambios son correctamente persistidos una vez que la transacción termina, y no se podrá deshacer incluso ante una falla del sistema.


## Historia
Una historia es un orden en que se ejecuta un conjunto de transacciones en donde se respeta el orden parcial de cada transacción.

- Conflictos entre operaciones cuando:
    + Pertenecen a historias distintas
    + Operan sobre un mismo data item
    + Al menos una de ellas es un write

- Dos historias H1, H2 son conflicto-equivalente si se puede llegar desde H1 hasta H2 a través de swaps de operaciones consecutivas que no se encuentren en conflicto.

## Serialización
Una historia es conflicto-serializable cuando es conflicto-equivalente a una versión serial de la misma.

Ejemplo, si se tienen las siguientes transacciones:
- T1 = (T1a, T1b, T1c)
- T2 = (T2a, T2b)
- T3 = (T3a)

Y las siguientes historias:

- H1 = (T1a, T2a, T1b, T3a, T1c, T2b)

    | T1  | T2  | T3  |
    | --  | --  | --  |
    | T1a |     |     |
    |     | T2a |     |
    | T1b |     |     |
    |     |     | T3a |
    | T1c |     |     |
    |     | T2b |     |

- H2 = (T1, T2, T3)

    | T1  | T2  | T3  |
    | --  | --  | --  |
    | T1a |     |     |
    | T1b |     |     |
    | T1c |     |     |
    |     | T2a |     |
    |     | T2b |     |
    |     |     | T3a |
 
H1 es conflicto-serializable si es conflicto-equivalente a H2, es decir, si los swaps necesarios para llegar de una a otra son no conflictivos.

## Tipos de historia

- Recuperable (RC): Tᵢ lee de Tⱼ en H y cᵢ ∈ H ⟹ cⱼ < cᵢ
- Evita abort en cascada (ACA): Tᵢ lee x de Tⱼ en H ⟹ cⱼ < rᵢ(x).
- Estricta (ST): wⱼ(x) < oᵢ(x) ⟹ aⱼ < oᵢ(x), o cⱼ < oᵢ(x). (cuando hay una operación de escritura de la historia j sobre x que se encuentra antes que una operación de la historia i sobre x, entonces o bien hay un abort de j sobre x o bien hay un commit de j, y en todo caso se encuentra antes de la operación de la historia i sobre x).