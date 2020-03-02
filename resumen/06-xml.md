# XML

## Introducción
### Datos estructurados
- Tienen un formato estricto
- Ejemplo: tablas

### Datos semiestructurados
- Tienen una cierta estructura
- No todos los "registros" tienen la misma estructura
- La información sobre la estructura está mezclada con los datos
- Son "autodescriptivos"
- Se pueden representar como grafos

### Datos no estructurados
- Sin estructura
- Ejemplo: XML

## Formato XML
- XML: **Extensible** Markup Language
    + Definido por la WC3
- Utilizado para el **intercambio de datos**
- Se puede **extender por el usuario**:
    + **Agregando nuevos tags** y especificando cómo el tag debe ser manejado y mostrado.
    + Los tags hacen que los **datos sean autodocumentados**.

## Comparación con datos relacionales
- Ineficiente. Cada tag representa información del esquema, y estos se repiten en todo el archivo.
- Mejor para el intercambio de datos
    + XML es autodocumentado
    + El formato no es rígido: se pueden agregar nuevos tags
    + Se permiten estructuras anidadas
    + Amplia aceptación, no solo en bases de datos, sino en navegadores y aplicaciones.

==TODO: Lo dejé acá porque es un embole esta diapo==.