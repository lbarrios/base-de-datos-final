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