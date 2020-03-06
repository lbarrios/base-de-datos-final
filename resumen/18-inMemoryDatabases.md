# 18. In-Memory databases
Una "in-memory database" es una base de datos que carga toda la base en memoria.

## Tipos
- Sin persistencia
    + Cuando se apaga la computadora, se pierden todos los datos.
    + Ej: Membase, Varnish, etc
- Con persistencia
    + Los datos además se persisten a disco
    + Ej: Redis, Sap Hanna, etc

## Persistencia
- Todas las interacciones con la DB se resuelven en memoria
- Se escribe constantemente en un log de transacciones
- Como las escrituras al log se realizan secuencialmente, es muy rápido

## Almacenamiento
- Por columnas o por filas
    + Las operaciones de agregación se benefician del almacenamiento "por columnas".