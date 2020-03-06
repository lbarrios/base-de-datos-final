# 15. Control de Concurrencia

## Problemas básicos

- Tres problemas básicos
    + Modificación perdida
    + Falsa sumarización
    + Falsa modificación (dirty read)

- Decisiones del scheduler frente a una operación:
    + Rechazarla
    + Procesarla
    + Demorarla

- Scheduler agresivo: favorece el procesamiento de la operación
- Scheduler conservador: favorece el rechazo o la demora de las operaciones.

## Lock binario
Utiliza el concepto de Lock/Unlock asociado a una variable.

- La variable tiene dos estados (locked, unlocked).

- Notación:
    + lᵢ(X): Tᵢ lockea el item X
    + uᵢ(X): Tᵢ libera el item X

- Cuando una transacción lee o escribe un ítem, antes solicita un lock sobre el mismo.

## Shared lock (lock ternario)
Extensión del lock binario, permite que el lock sea exclusivo o compartido

- Notación:
    + rlᵢ(X): Tᵢ lockea X - compartido
        * "Read Lock"
    + wlᵢ(X): Tᵢ lockea X - exclusivo
        * "Write Lock"
    + ulᵢ(X): Tᵢ actualiza el lock de X, de compartido a exclusivo
        * "Read Lock" ⟹ "Write Lock"

## Two Phase Locking (2PL)
Protocolo que asegura la serialización. Requiere que cada transacción emita los pedidos de lock y unlock en dos fases.

- Fases del Two Phase Lock:
    + **Growing phase** (fase de crecimiento): una transacción puede pedir locks, pero no puede liberar locks.
    + **Shrinking phase** (fase de decrecimiento): una transacción puede liberar locks, pero no puede obtener nuevos locks
- Inicialmente, una transacción está en la fase de crecimiento, y puede pedir locks.
- A partir del punto en que libera algún lock, ya no puede volver a pedir más locks.
- **Peligro: se pueden generar deadlocks**.

## Deadlocks
### Wait-For Graph (WFG)
Grafo que representa qué operaciones esperan de otras.

- Un nodo por cada transacción.
- Hay un arco entre dos nodos cuando una transacción está esperando a otra.
- Hay deadlock si se forma un ciclo.

Ejemplo WFG sin deadlock
```text
        --> T2 ---> T4
       /    ∧
      /     |
    T1      |
      \     |
       \    |
        --> T3
```

Ejemplo WFG con deadlock (T2->T4->T3->T2)
```text
        --> T2 -----> T4
       /    ∧         /
      /     |        /
    T1      |       /
      \     |      /
       \    |     /
        --> T3 <--
```

### Recuperación
Cuando se detecta un deadlock, se debe solucionar mediante una operación de recuperación.

- La solución más común es hacer un rollback (deshacer las operaciones) de una o más de las transaciones involucradas.
- Para hacer un rollback se deben tener en cuenta tres cosas:
    + Elegir una víctima: idealmente, deben elegirse deshacer las transacciones de tal forma que esto involucre un costo mínimo. Este costo es difícil de encontrar, y se tienen en cuenta entre otras cosas:
        * Cuántas operaciones lleva computadas la transacción, y cuántas le faltan para terminar.
        * Cuántos items de datos usó la transacción.
        * Cuántos items de datos le falta usar a la transacción para terminar.
        * Cuántas transacciones serán afectadas por el rollback.
    + Realizar el rollback.
        * Lo más simple es hacer un **rollback total** volviendo todo al estado original antes de realizar la transacción.
        * Existen soluciones como **rollback parcial** que requieren que el sistema mantenga información adicional (por ejemplo los distintos estados antes de pedir cada lock).
    + Debe evitarse el starvation de una transacción.
        * Por ejemplo, si una transacción es muy pesada, esta puede terminar siempre siendo elegida para hacer rollback, con lo cual nunca se ejecuta.
        * Una forma de evitar esto, es llevando un conteo de la cantidad de veces que fue rollbackeada cada transacción, y haciendo que este número forme parte de la función de costo a la hora de elegir la víctima.

## Timestamps
Se asocia un timestamp único a cada transacción, denotado TS(Tᵢ).

- Las dos formas comunes de implementar esto son:
    1. Usando el system clock.
    2. Usando un contador que es incrementado atómicamente cada vez que un timestamp se asigna.

- Los timestamp de las transacciones determinan el orden de serialiación.
    + Esto significa que si TS(Tᵢ) < TS(Tⱼ) entonces el planificador debe producir una historia que sea equivalente a una serialización en donde Tᵢ aparezca antes que Tⱼ.

- Para implementar esto, se asigna a cada data item dos timestamps:
    + W-timestamp(Q) denota el mayor timestamp de cualquier transacción que haya ejecutado write(Q) correctamente.
    + R-timestamp(Q) denota el mayor timestamp de cualquier transacción que haya ejecutado read(Q) correctamente.

### Timestamps - Protocolo de ordenamiento
Asegura que cualquier operación de lectura o escritura conflictiva se ejecute en el orden indicado por el timestamp.

1. Lectura
    * Si TS(Tᵢ) < W-timestamp(Q): Tᵢ necesita leer un dato en Q que ya fue sobre-escrito. Se rechaza la operación, y se hace rollback a Tᵢ.
    * Si TS(Tᵢ) ≥ W-timestamp(Q): la operación es ejecutada, y el R-timestamp(Q) es actualizado a max(R-timestamp(Q), TS(Tᵢ)).
2. Escritura
    * Si TS(Tᵢ) < R-timestamp(Q): el valor de Q que Tᵢ está por escribir fue necesitado previamente en una lectura. Como no se puede escribir "hacia el pasado", se rechaza la operación y se hace rollback a Tᵢ.
    * Si TS(Tᵢ) < W-timestamp(Q): el valor de Q que Tᵢ está por escribir ya fue escrito por un valor más nuevo, por lo que el valor que se está intentado escribir es obsoleto. Se rechaza la operación y se hace rollback a Tᵢ.
        - Notar que este caso es posteriormente abordado por la **Thomas Write Rule**.
    * en cualquier otro caso: la operación es ejecutada, y el W-timestamp(Q) es actualizado a TS(Tᵢ).

### Thomas Write Rule
Modificación del protocolo de ordenamiento para timestamps que permite descartar operaciones write obsoletas (cuando el valor que tiene X es más nuevo al que se quiere escribir).

- Esto permite a veces ejecutar historias que no son conflicto-serializables, pero sí son _view-serializable_, eliminando las operaciones conflictivas.
- Notar que para que una escritura entre en el caso descrito previamente, esta debe ser un _blind write_, es decir, una escritura que no requirió una lectura previa. De lo contrario, a pesar de que se cumpliría TS(Tᵢ) < W-timestamp(Q) (con lo cual se podría ignorar el write), también se cumpliría Si TS(Tᵢ) < R-timestamp(Q), lo cual haría que se rollbackeara la operación de todos modos.
    + Esto permite descartar w1(x) en una historia como: `w2(x)w1(x)`, pero no en una historia como `r2(x)w2(x)w1(x)`, ya que en este último caso podría ser que al haber leído la variable, el valor guardado en w2(x) dependa del valor leído en r2(x) (que a su vez depende de w1(x)).

## Multiversión
Se guardan distintas versiones de los datos, una por cada transacción vigente.

- Cada versión Qₖ contiene tres datos:
    + Contenido: el valor de la versión Qₖ
    + W-timestamp(Qₖ): timestamp de la transacción que creó la versión.
    + R-timestamp(Qₖ): mayor timestamp de las transacciones que leyeron Qₖ.

- Si una transacción Tᵢ quiere hacer una operación, sea Qₖ la versión cuyo timestamp es el mayor tal que sea menor i igual a TS(Tᵢ).
    1. Si la operación es read(Q), entonces el valor retornado es Qₖ.
    2. Si la operación es write(Q)
        * si TS(Tᵢ) < R-timestamp(Qₖ), entonces el sistema rollbackea la transacción
        * si TS(Tᵢ) ≥ R-timestamp(Qₖ) y TS(Tᵢ) = W-timestamp(Qₖ), se sobreescriben los valores de Qₖ
        * si TS(Tᵢ) > R-timestamp(Qₖ) se crea una nueva versión de Q.

## Multiversión con Two Phase Lock
Se puede combinar multiversionado con Two Phase lock, obteniendo las ventajas de ambos protocolos.

- Las transacciones se diferencian entre transacciones de read y transacciones de write.
- Se utiliza un contador atómico _ts-counter_ que se actualiza con cada commit.
- Las transacciones de read se setean con un timestamp igual a _ts-counter)
- Las transaciones de update inicialmente setean los nuevos datos poniendo un timestamp infinito.
    + Cuando la transacción se commitea, guarda el timestamp correspondiente (ts-counter+1), aumentando asimismo dicho contador en 1.
    + La etapa de commit tiene un lock de forma tal que no pueden haber más de una operación realizando commit a la vez.
- Si Tᵢ realiza un read(Q), entonces el valor es retornado inmediatamente, y es el contenido de la versión Qₖ.

## Niveles de aislamiento (SQL)

### Fenómenos que violan el aislamiento (y la serialización)
- **Lost Updates**: se pierde un write, ya que se pisa posteriormente con un valor que debería haber sido escrito antes.
- **Dirty Read**: se lee un valor escrito por una transacción que todavía no commiteó.
- **Nonrepeatable Read**: una transacción lee el mismo dato dos veces, y encuentra un valor distinto la segunda vez a pesar de no haber hecho ninguna escritura a ese dato.
- **Phantom Read**: una transacción commitea una nueva tupla, que puede o no ser usada por una lectura concurrente.

### Comparación

Isolated level   | Lost Updates | Dirty Read | Non repeat. Read | Phantom Read
:---------------:|:------------:|:----------:|:----------------:|:------------:
Read Uncommitted | No           | Maybe      | Maybe            | Maybe
Read Committed   | No           | No         | Maybe            | Maybe
Repeated Read    | No           | No         | No               | Maybe
Serializable     | No           | No         | No               | No