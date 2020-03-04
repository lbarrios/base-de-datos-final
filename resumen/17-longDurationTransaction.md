# Long Duration Transactions

- Existen transacciones que pueden durar o insumir mucho más tiempo o cómputo de lo normal.
    + Transacciones que afecten a una cantidad inmensa de registros.
        * No es razonable bloquear la base durante 2 días.
        * No es razonable la cantidad de información que hay que almacenar para hacer rollback en caso de que se use algún mecanismo de control de concurrencia de los mencionados previamente.
    + Sistemas de workflow, es decir en donde haya un flujo de trabajo en el que se vean involucrado varios procesos Pᵢ distintos, y en donde estos formen una cadena [P₁ ⟹ P₂ ⟹ ⋯ ⟹ Pₙ], en donde el resultado de cada proceso dependa del proceso anterior.
        * No es posible utilizar los mecanismos de control de concurrencia habituales.

## Sagas
Una saga es un conjunto de acciones [A₁ ⟹ A₂ ⟹ ⋯ ⟹ Aₙ] que conforman un long duration transaction.

- Una saga se compone de:
    + Una colección de acciones.
    + Un grafo dirigido en donde los nodos son, o bien acciones, o bien un nodo **terminal** del tipo ABORT o COMPLETE.
        * Ningún arco parte desde un nodo terminal.
    + Alguno de los nodos del grafo se denota como **nodo inicial**.

- Los caminos en el grafo de una saga representan secuencias de acciones.

- El control de concurrencia de la saga se realiza en dos partes
    + Cada acción se considera en sí misma como una pequeña transacción.
    + La sucesión de acciones se maneja con el mecanismo de **transacciones compensatorias**, que son acciones inversas a cada uno de los nodos de la saga.

### Acciones compensatorias
Sea A una acción, la acción de compensación A⁻¹ es tal que si se tiene una base en un estado S, al aplicarle A y luego A⁻¹ se vuelve a obtener el mismo estado S inicial. 

- Más aún, aplicar la secuencia de acciones ABA⁻¹ equivale a aplicar la acción B.
- Esto significa que si se tiene una secuencia de acciones correspondientes a una saga: `[A₁, A₂, ⋯, Aₙ]` y se aplican en ese orden sobre una base, generando un ABORT en `Aᵢ` con `0>i≤n`, se deben aplicar las acciones de compensación en el orden inverso, es decir `[Aᵢ⁻¹, ⋯, A₂⁻¹, A₁⁻¹]`.
    + Si suponemos que todas estas acciones se intercalan con otras acciones B₁, B₂, etc, en donde cada Bᵢ es un conjunto de operaciones correspondientes a otras transacciones, la secuencia resultante `[A₁, B₁, A₂, B₂, ⋯, Bᵢ Aᵢ, Aᵢ⁻¹, Bᵢ₊₁, ⋯, Bⱼ, A₂⁻¹, Bⱼ₊₁, A₁⁻¹]` termina siendo equivalente a haber aplicado todas las acciones B sin haber aplicado las acciones A, es decir `[B₁, B₂, ⋯, Bᵢ, Bᵢ₊₁, ⋯, Bⱼ, Bⱼ₊₁]`, lo cual significa que se mantiene la consistencia de la base.
