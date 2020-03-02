# noSQL
Conjunto muy variado de base de datos no relacionales que fueron diseñadas tomando en cuenta la existencia de datos no estructurados.

## Características principales

- No relacionales.
- Distribuídas.
- Código abierto.
- Escalan horizontalmente.

## Características generalmente aceptadas

- No tienen esquema (schema free)
- Tienen mecanismos sencillos de replicación
- Tienen interfaces sencillas
- Pueden almacenar grandes volúmenes de datos
- Cumplen con las propiedades BASE, no ACID

## BASE
Basic Availability, Soft-state, Eventual consistency

- **Basic Availability**: garantiza la disponibilidad en términos del teorema CAP.
    + Los datos deben estar disponibles, aún cuando se produzcan fallas.
    + Esto se logra mediante el uso de una base de datos altamente distribuída.
    + Se distribuyen los datos en muchos discos diferentes con un alto grado de replicación.
    + Si sucede una falla que inhabilita el acceso a un grupo de datos, no afecta a toda la base de datos.
- **Soft-state**: el estado de la base de datos puede cambiar a lo largo del tiempo, aún sin intervención externa.
    + Se aleja del requerimiento de consistencia de ACID que implica una única "versión" de cada dato.
    + Esto se debe a la consistencia eventual.
    + En BASE la consistencia es problema de los desarrolladores, y no debe ser administrada por las bases de datos.
- **Eventual consistency**: el sistema va a ser consistente a lo largo del tiempo, siempre que no se reciba más inputs.
    + El único requisito en términos de consistencia es que los datos deben converger en _algún_ momento del futuro a un único estado. No hay garantías de en qué momento ocurrirá eso.

## Teorema CAP
Cualquier sistema que comparta datos a través de una red puede tener a lo sumo dos de las tres propiedades: consistencia (Consistency), alta disponibilidad (Availability), tolerancia a fallos/particiones (Partition tolerance).

- El objetivo de CAP hoy debería ser encontrar el balance entre consistencia y disponibilidad, estableciendo la forma de manejar las particiones y la manera en que se van a recuperar los errores que se produzcan durante las mismas.

### Estrategia para las particiones
1. Detectar la partición
2. Entrar al modo "particionado"
3. Recuperar del modo anterior

## Estructura
En lugar de usar tablas, noSQL usa el concepto de almacenamientos del tipo clave/valor.

- No hay un schema.
    + Al no tener esquema, pueden realizarse todo tipo de consultas complejas.
- Se almacenan los valores provistos para cada clave, y se los distribuye a lo largo de la base de datos.
    + Esto permite una recuperación muy eficiente

## Tipos de bases noSQL

- Desde KeyValue hacia Graph database disminuye el tamaño de los datos, pero aumenta la complejidad de los mismos.

### 1. Key-Value stores
La unidad atómica de modelado es el par clave-valor.

#### Características
- Es la más sencilla en cuanto a complejidad.
- Cada item es almacenado como un clave y su valor.
- Los datos pueden ser de distintos tipos: texto, XML, JSON, imágenes, etc.
- Son más adecuadas para la web o aplicaciones móviles.
- Están orientadas a items, y para cada item toda su información se almacena con su clave.
    * Los items pueden almacenarse en "dominios", que son similares a las tablas.
    * Los dominios no tienen schema, y pueden guardar items diferentes.
    * Los items no tienen esquema, y pueden guardar objetos diferentes.
- Puede producir redundancia entre los items.
    * Un par clave-valor perteneciente a un ítem A puede estar repetido en varios items B, C, D que de una forma u otra se vinculen con él.
- No existe integridad referencial (ni equivalente).
    * Es decir, no hay nada que garantice que la relación entre dos tablas permanezca sincronizada durante operaciones de actualización y eliminación.

#### Ventajas
- Adecuadas para la nube
    * Al ser simples y altamente distribuídas escalan mucho mejor que las relacionales
- Adecuadas para usar en OOP

#### Desventajas
- Integridad de datos y restricciones
    + Al no existir mecanismos similares a los de BD relacionales para la definición de restricciones, todo queda en mano de los programadores.
- Limitaciones para el análisis
    + Los datos carecen de estructura, por lo que para hacer un análisis de los mismos probablemente haya que pasarlos a una base donde se los pueda estructurar.
- Escalabilidad vs Funcionalidad y Complejidad
    + A veces no tiene sentido poner la escalabilidad por delante de la funcionalidad.

### 2. Column Family databases
La unidad atómica de modelado es una familia de columnas.

#### Características
- Consisten en columnas de datos relacionados entre sí.
- Un grupo de columnas tiene función similar a las tablas relacionales.
    + Son grupos de datos que, con frecuencia, son accedidos juntos.
- Proveen mecanismos naturales de partición vertical.
- Tienen almacenamiento multidimensional (como mapas o vectores asociativos).

#### Standard Column Family
Son pares clave-valor en donde el valor está representado por un conjunto de columnas.

#### Super Column Family
Son pares clave-valor en donde el valor está representado por un conjunto de conjunto de columnas.

- Haciendo una analogía con las bases relacionales, los valores serían similares a las vistas.

#### Ventajas
- Diseñadas para almacenar grandes volúmenes de datos
- Soport datos semi-estructurados
- Permite indexar los datos
- Es escalable y provee alta disponibilidad

#### Desventajas
- No son adecuadas para datos relacionales
- No proveen consistencia inmediata

### 3. Document stores
La unidad atómica de modelado es un documento.

#### Características
- Son similares a clave-valor, pero con diferencias que les permiten una mayor claridad en los datos en detrimento de la libertad.
- Los valores (documentos) pueden diferir entre sí en término de datos como de estructura.
- Se tiene metadata sobre los datos, lo que permite efectuar indexaciones sobre algunos campos.

#### Ventajas
- Mayor claridad en los datos que clave-valor.
- Se pueden hacer indexaciones y búsquedas eficientes.

#### Desventajas
- Se pierde libertad en comparación con clave-valor.

### 4. Graph databases
Modela toda la estructura como un grafo.

- Almacenan los datos como nodos conectados por medio de relaciones dirigidas y tipadas.
    + Permite almacenar propiedades tanto en los nodos como en las relaciones.

#### Características
- Intuitivo
- Cumple ACID
- Escalable
- Alta disponibilidad
- Soporta lenguajes de consulta de grafos
- Puede ser accedido mediante servicios REST o una API orientada a objetos
- Muchos problemas se representan naturalmente como grafos

- Tanto SQL server como Oracle tienen en la actualidad funcionalidad de graph database.

#### Ventajas
==TODO:?==

#### Desventajas
==TODO:?==

## PROS y CONS

pros | cons
---  | ---
escalable | muchas opciones, por lo que resulta difícil elegir la base adecuada
esquema flexible | capacidad de query limitada
características distribuídas (confiable, escalable, recursos compartidos, velocidad) | consistencia eventual, hay entornos para el cual esto no es intuitivo (ej negocio bancario)
no tiene interrelaciones complicadas | no tiene joins, group by, order by, etc
menor costo por la facilidad de escalar en máquinas comunes | carece de ACID
open source | soporte limitado

## RDBMS vs noSQL

Características                 | noSQL                    | RDBMS
------------------------------- | ------------------------ | ------
**Volumen**                     | muchísimo volumen | volumen limitado
Validez de los datos            | poca garantía | mucha garantía
**Escalabilidad**               | horizontal | horizontal y vertical
Query Language                  | no tienen lenguaje | SQL
**Schema**                      | sin esquema o muy flexible | esquema rígido
Tipos de datos                  | no estructurado; no tiene límites | estructurado; han incorporado extensiones para permitir el almacenamiento de no estructurados
ACID/BASE                       | BASE (en general) | ACID
Administración de transacciones | garantía débil | garantía muy fuerte
**Requerimientos de hardware**  | sin grandes requerimientos | servers propietarios, costosos


## Bibliografía / referencias
- http://nosql-database.org/
- http://www.couchbase.com/why-nosql/nosql-database
- http://www.linuxjournal.com/article/3294
- http://www.christof-strauch.de/nosqldbs.pdf
- http://databases.about.com
- http://www.analyticsvidhya.com/blog/2014/05/hadoop-simplified/
- https://www.usenix.org/legacy/events/lisa11/tech/slides/stonebraker.pdf 32