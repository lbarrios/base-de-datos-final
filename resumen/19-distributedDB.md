# 19. Distributed Databases
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

## Transacciones

### Propiedades ACID
Propiedades que debe cumplir una transacción.

- **Atomicidad**: O bien todas las operaciones son aplicadas apropiadamente en la base de datos, o bien ninguna lo es. 
- **Consistencia** (integridad): La ejecución de una transacción preserva la consistencia de una base de datos.
- **Isolación** (aislamiento): Una transacción no puede afectar a otra. Cada transacción es independiente de otras transacciones ejecutándose concurrentemente en el sistema.
- **Durabilidad** (persistencia): Los cambios son correctamente persistidos una vez que la transacción termina, y no se podrá deshacer incluso ante una falla del sistema.


## 2PC
- Problema: protocolo de bloqueo. Si falla el coordinador una vez pedido el lock, bloquea a todos los nodos participantes.

### 3PC
Divide segunda fase de commit en dos subfases.

1. Prepare to commit
    * Comunica resultado de la fase de votación a todos los participantes
    * El commit se debe preparar en esta fase
    * Si todos los participantes votan afirmativamente, pide que pasen a prepare-to-commit
2. Commit
    * Idéntico a commit en 2PC
    * Si el coordinador cae durante esta subfase, otro participante puede tomar asumir la coordinación del commit.
    * Se limita el tiempo requerido por T para realizar el commit, ya que se preparó en la fase anterior, por lo que solo debe ser aplicado. Esto asegura liberar los locks luego de un determinado tiempo.

- Tiene algunas desventajas, principalmente el overhead para asegurarse de que no hayan inconsistencias, por lo que no ampliamente muy usado debido a problemas de red (muchos nodos fallando a la vez).

## Queries distribuídos

1. Mapeo: se mapea la consulta SQL a una consulta de AR sobre las relaciones globales, referenciando al esquema global.
    - NO se utiliza la información de distribución y replicación.
    - El mapeo es idéntico al de las BD centralizadas: normalización, análisis de errores, simplificación, reestructuración.
2. Localización: se mapea el resultado anterior a múltiples consultas sobre fragmentos individuales.
    - Se utiliza la información de distribución y replicación.
3. Optimización global: se selecciona una estrategia de una lista de candidatos cercanos al óptimo.
    - Tiempo es la unidad más utilizada para medir costo
    - Costo total es ponderado entre CPU, I/O, comunicación/red.
    - Costo de comunicación/red suele ser muy significativo.
4. Optimización local: similar a las BD centralizadas, se optimiza cada query localmente. 

### Queries - Costos

- Problema: alto costo de transferencia sobre la red
- Solución: los algoritmos de optimización deben considerar reducir la cantidad de datos a transferir.

### Queries - Semijoin
Reducir cantidad de tuplas de una relación **antes** de que sean transferidas a otro nodo.

- Implementación:
    1. enviar sólo columna de JOIN
    2. realizar JOIN
    3. del resultado retornar columna de join + atributos necesarios
    4. completar consulta

- Ventaja: si solo una pequeña fracción de la relación participa en el JOIN, reduce mucho la transferencia de datos.

## Tipos de DDB

- Definición: Datos y sotware distribuídos en múltiples lugares, pero conectados a través de una red.

- Grado de homogeneidad: 
    + Homogéneo: si todos los servers y usuario utilizan el mismo software
    + Heterogéneo: si usan distinto software
        * Es necesario un lenguaje canónico y un traductor que haga de intermediario al lenguaje de cada uno de los servers.
- Grado de autonomía local:
    + Si se le permite al sitio funcionar como DBMS standalone o no
        * (ver arriba: autonomía de diseño, comunicación y ejecución).
    + Ejemplo: FDBS y p2pDBS: cada server es un DBMS independiente y autónomo que tiene sus propios usuarios, transacciones, DBA, y por lo tanto alto grado de autonomía.
        * p2pBS: no hay esquema global, se construye a medida que se requiere
        * FDBS: existe un esquema global federado

### Federated Databases - Heterogeneidad

- Origen
    + Diferencias en modelo de datos: DBs pueden venir de distintos modelos. 
        * Se requiere un mecanismo que procese las queries y relacione la información basado en metadata.
    + Diferencias en restricciones: varían de sistema en sistema.
        * Se debe lidiar con conflictos en restricciones (integridad, triggers, etc).
    + Diferencias en lenguajes: incluso dentro del mismo modelo, los lenguajes poseen varias versiones.
        * Ejemplo: SQL-89, SQL-92, SQL-99, SQL-2008.

- Heterogeneidad semántica: ocurre cuando existen diferencias en el significado, interpretación y uso de los datos.
    + Las DBS tienen autonomía de diseño y pueden tomar decisiones.

- Solución actual: utilizar software responsable de administrar queries y transacciones desde la aplicación global hacia las DBs individuales (pudiendo incorporar reglas de negocio).
    + Middleware
    + Application servers
    + Enterprise Resource Planning (ERP)
    + Modelos y herramintas para Data Integration y Data Exchange: para hacer integración y mapeo en un lenguaje de alto nivel.
    + Ontology-based Data Access/Query: modelo de más alto nivel que el relacional.
        * El acceso a los datos se hace mediante un lenguaje ontológico de fácil acceso para el usuario (sin entendimiento de BBDD).

### Federated Databases - Autonomía
- Comunicación: capacidad de decidir cuándo comunicarse con otras DBs
- Ejecución: capacidad para ejecutar operaciones locales sin interferir en operaciones externas, y también capacidad de decidir el orden
- Asociación: capacidad de decidir si compartir y cuánto compartir
    + Funcionalidad: operaciones que soporta
    + Recursos: datos que gestiona

## Arquitecturas Paralelas vs Distribuídas
- Prevalencia en industria: ambas
    + Paralela común en HPC
    + Distribuída común en grandes empresas
- Arquitecturas de sistema multiprocesador: se desarrollan Parallel Database Management Systems (PDBMS)
    + Red: no requieren compartir red
    + Memoria compartida: comparten memoria y disco
    + Disco compartido: comparten disco, pero cada uno tiene memoria propia
    + Shared-nothing: cada procesador posee su propia memoria y su propio disco

## Catálogo distribuído
El catálogo es una BD en sí misma

- Contiene metadata acerca del DDBMS
- Administración
    + Autonomía
    + Vistas
    + Distribución y replicación de datos
- Esquemas de administración
    + Centralizado: el catálogo completo se almacena en un único sitio
        * Ventaja: simple de implementar
        * Desventajas:
            - Poca confiabilidad
            - Poca disponiilidad
            - Poca autonomía de los nodos
            - Poca distribución de la carga de procesamiento
            - Los locks generan cuellos de botella cuando hay escrituras intensivas
    + Totalmente replicado: cada sitio almacena una copia del catálogo completo
        * Ventaja: lecturas pueden responderse localmente
        * Desventajas:
            - Overhead: actualizaciones deben ser transmitidas a todos los nodos
            - Esquema centralizado de 2PC para mantener consistencia del catálogo
            - Aplicaciones escritura-intensivas (con locks) pueden incrementar el tráfico de la red
    + Parcialmente replicado: cada sitio mantiene información completa del catálogo de los datos locales
        * Cada sitio permite almacenar en caché entradas obtenidas de otros sitios
            - Entradas en cache no garantiza información actualizada
        * Cada sistema lleva registro de las entradas del catálogo para los sitios donde se creó el objeto, y para los sitios que tienen copias del objeto
            - Cualquier cambio debe ser propagado al sitio original (de creación).
- 