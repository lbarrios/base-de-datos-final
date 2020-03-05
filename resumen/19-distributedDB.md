# Distributed Databases
Una base de datos distribuída es una colección de múltiples bases de datos que están lógicamente relacionadas y se encuentran distribuídas en una red de computadoras.

Condiciones que debe satisfacer:
- Interconexión entre BDs.
- Relación lógica entre BDs interconectadas.
- Heterogeneidad entre nodos.

## Interconexión
- Tipo: LAN, WAN, etc
- Topología: "caminos" de comunicación, formas en que se conecta.
- Todo esto impacta en la estrategia y el diseño de la DDB

## Transparencia
Ocultar detalles de implementación a usuarios finales

- BD Centralizadas
    + Independencia entre datos físicos y lógicos
- **BD Distribuídas: nuevos tipos de transparencia**
    + Organización de los datos
    + Fragentación
    + Replicación
    + Otras

### Organización de los datos
(también distribución u organización de red)

- Libera al usuario de conocer los detalles de red y ubicación de datos
- Se divide en:
    + **Transparencia de ubicación**: el comando utilizado para realizar una tarea no es afectado por la ubicación de los datos, ni tampoco por desde dónde se lanza el mismo.
    + **Transparencia de nombres**: una vez asociado un nombre a un objeto, este puede ser accedido de manera unívoca desde cualquier ubicación, sin requerir datos adicionales.

### Fragentación

- Libera al usuario de conocer detalles de fragmentación de los datos.
- Se divide en:
    + **Horizontal** (sharding): distribuye la relación (tabla) en subrelaciones que son subconjuntos de las tuplas (filas) de la relación original
        * Para reconstruir una relación que fue fragmentada horizontalmente se debe aplicar UNION a todos los fragmentos
    + **Vertical**: distribuye la relación en subrelaciones donde cada subrelación es definida por un subconjnto de columnas de la relación original
        * Para reconstruir una relación que fue fragmentada verticalmente se debe aplicar JOIN a los fragmentos.
    + **Mixta**: distribuye la relación en subrelaciones que son una mezcla de fragmentación vertical y horizontal.
- En ambos casos el usuario desconoce la existencia de fragmentos

### Replicación

- Libera al usuario de conocer la existencia de **copias de los datos**.
- Los objetos pueden ser almacenados en varios sitios simultáneamente para mejorar disponibilidad, performance, confiabilidad.

### Otras
- Diseño: libera al usuario de conocer cómo está diseñada la DDB
- Ejecución: libera al usuario de conocer dónde o cómo es ejecutada una transacción

## Disponibilidad y Confiabilidad

- Disponibilidad: probabilidad de que un sistema se encuentre contínuamente disponible en un intervalo de tiempo.
- Confiabilidad: probabilidad de que un sistema se encuentre operando en un momento determinado de tiempo.

- Fallos asociados:
    + Failure (fallo): desviación del comportamiento esperado del sistema
    + Errores: subconjunto de estados del sistema que causan failures
    + Fault (falla): causa de un error

- Para construir un sistema confiable
    + Stresses fault tolerance: reconocer fallos, detectarlos y removerlos previos a que ocurran
    + Alternativa: asegurar que el sistema no tenga faults, siguiendo procesos de desarrollo que tengan QA y testing

- **Un DDBMS debe tolerar fallos de componentes subyacentes sin alterar el procesamiento de pedidos ni la consistencia de la DB**.

- Recovery Manager: componente que trata con los fallos.
- Disponibilidad y confiabilidad se usan indistintamente en DDB.

## Escalabilidad y Particiones

- Escalabilidad determina la medida en que el sistema puede expandirse
    + Horizontal: expandir la cantidad de nodos
    + Vertical: expandir la capacidad individual de los nodos
- La tolerancia a partición o a falla es la capacidad de continuar operando a pesar de que la red sea particionada (nodos o mensajes retrasados o descartados). Es uno de los componentes del teorema CAP (Consistency, Availability, Partition Tolerance).

## Autonomía
Determina en qué medida los nodos individuales pueden operar independientemente

- Es deseable un alto grado de autonomía.
    + Diseño: independencia del modelo entre los nodos
    + Comunicación: en qué medida los nodos pueden compartir o no información
    + Ejecución: que los usuarios puedan realizar todo tipo de acciones

## Ventajas

- Mejora el desarrollo de aplicaciones: se pueden mantener aplicaciones en sitios geográficamente distribuídos debido a la transparencia de control y distribución de datos
- Aumento de la disponibilidad: los fallos son aislados a su nodo, sin afectar a otros nodos
- Mejora de la performance: debido a la fragmentación horizontal
- Escalabilidad: agregar más datos (vertical) o agregar nodos (horizontal).

## Transparencia total
Provee al usuario una visión de la DDB como si fuera un sistema centralizado.

- **Hay un tradeoff entre facilidad de uso y costo de proveer la transparencia**.

## Esquemas de fragmentación

- Incluye a todos los atributos y tuplas de la DB fragmentada
- La totalidad de la BD puede ser construida a partir de fragmentos aplicando operaciones (union o join + union)
- Es útil (pero no necesario) que los fragmentos sean disjuntos (excepto por la PK)
- Esquema de asignación describe la ubicación de los fragmentos en los nodos
- Si un fragmento está en más de un lugar, está **replicado**

## Replicación total

- Objetivo tener mayor disponibilidad de datos
- Ventajas
    + Se continúa operando mientras haya al menos un nodo disponible
    + Mejora la performance de lecturas
- Desventajas
    + Baja performance de escritura (debe realizarse en todas lsa copias)
    + Las técnicas de control de concurrencia y recuperación son más costosas

## Replicación parcial

- Algunos fragmentos se replican, otros no.
- Un esquema de replicación es una descripción de los esquemas de la DDB.
- Cada fragmento debe ser asignado a un sitio particular, esto se denomina distribución de datos.
- La elección de sitios y el grado de replicación depende de:
    + Metas de disponibilidad
    + Metas de performance
    + Tipo de transacciones realizadas

## Control de concurrencia y Recovery
Ambientes distribuídos traen nuevos problemas.

- Tratar con múltiples copias de un data item
    + CC: mantener consistencia entre copias
    + Recovery: realizar copia consistente con otras copias si falla el nodo
- El DDB debe continuar operando ante fallas
    + Nodo: cuando se recupera, debe ser actualizada con respecto a otros sitios
    + Fallas de comunicación: caso extremo partición de la red.
- Commit distribuído: cómo resolver si un nodo falla durante commit.
- Deadlock distribuído: cómo resolver un deadlock entre nodos.

## Control de Concurrencia
Responsable de mantener consistencia entre copias

- Locking: designar una copia de cada sitio como distinguida.
    + **Sitio primario**: todas las copias distinguidas se mantienen en un único sitio
        * Si T obtiene rlock(X) de sitio primario, puede acceder a cualquier copia de X
        * Si T obtiene wlock(X) de sitio primaria y actualiza X, el DDBMS es responsable de actualizar todas las copias de X antes de realizar unlock(X)
        * Two-phase Commit: si todas las T siguen protocolo 2PC, la seriabilidad está garantizada
        * Ventaja: simple, extiende al enfoque centralizado
        * Desventajas:
            1. Performance: Cuello de botella en el sitio primario.
            2. Disponibilidad: Single Point of failure, si falla el sitio primario, falla todo.
    + **Sitio primario con sitio de backup**:
        * El backup intenta solucionar desventaja de disponibilidad (2).
        * La información de los locks se mantiene en ambos sitios.
        * En caso de falla del Nodo Primario, Nodo Backup toma el control.
        * Ventaja: simplifica el proceso de recovery ante falla de Nodo Primario
        * Desventajas:
            1. Persiste cuello de botella
            2. Disminuye más performance en procesos de lock (por copia a sitio backup)
    + **Copia primaria**:
        * Intenta solucionar problema de performance (cuello de botella)
        * Admite copias distinguidas en diferentes sitios
        * Falla de un nodo sólo afecta a T con locks en data items cuya copia primaria se encuentra en dicho nodo.
        * Pueden agregarse nodos de backups para aumentar disponibilidad.

### Falla de Nodo Primario - Eleccion de nuevo coordinador
- Sitio primario: todas las T deben ser abortadas y reiniciadas
- Con backup: las T se suspenden mientras se designa al backup como nuevo primario

- Si fallan primario y backup: Proceso de elección (algoritmo complejo)
    + Si sitio Y intenta comunicarse con coordinador y no puede, asume que el coordinador falló y puede iniciar proceso de elección
    + Envía a todos los nodos activos que Y va a ser el nuevo coordinador
    + Si Y recibe mayoría de votos afirmativos, Y se declara coordinador
    + También se debe resolver intentos de dos o más sitios intentando ser coordinadores simultáneamente.

### Falla de Nodo Primario - Votación
- Se hace un pedido de lock(X) a todos los sitios que tienen una copia de X
- Cada copia de X es responsable de su propio lock, y puede aceptar o denegar
- Si T pide lock(X)
    + Si recibe OK de la mayoría de las copias, toma el lock y avisa a todas las copias que lo tomó
    + Si NO recibe el ok de la mayoría dentro de un período de timeout, cancela el pedido e informa a todos de la cancelación

- Ventaja: es considerado un método de control de concurrencia realmente distribuído (la decisión reside en los nodos)
- Desventajas:
    + Mayor tráfico de mensajes
    + El algoritmo es muy complejo, tiene que tener en cuenta cosas como la caída de nodos durante la votación

### Recovery - Problemas
1. Fallos en sitios y comunicaciones
    - En ciertos casos es muy difícil determinar cuándo un sitio se encuentra caído.
        + Ejemplo: sitio X envía un mensaje a sitio Y, del cual espera una respuesta. Posibles causas:
            * Nunca llegó mensaje a Y por problema en comunicación
            * Y está caído
            * Y se encuentra funcionando y envía respuesta, pero no llegó por problema en comunicación
    - En cualquier caso, también es complicado determinar la causa.
2. Commit distribuído
    - Si T actualiza información en varios sitios, no puede terminar el COMMIT hasta asegurarse de que los efectos de T no se van a perder en **ningún sitio** (grabación de log)
    - Es frecuente usar 2PC para asegurar correctitud de commit distribuído

