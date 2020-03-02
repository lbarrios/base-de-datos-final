# Normalización

## Marco general
- Salida del diseño -> conjunto de relaciones
- Calidad del diseño -> ¿una forma de agrupar atributos es mejor que otra?
- Niveles
    + Lógico (o conceptual)
    + Implementación (o de almacenamiento físico)
- Objetivos
    + Preservar la información
    + Minimizar la redundancia

### Pautas de diseño
1. **Semántica**: Estar seguro de que la semántica de atributos en el esquema es clara
2. **Almacenamiento**: Reducir la información redundante en las tuplas
3. Reducir la cantidad de valores NULL en las tuplas
4. Deshabilitar la posibilidad de generar tuplas espúreas

- Estas pautas no son siempre independientes entre sí.

## Pauta 1: Semántica
Objetivo: cuanto más fácil es explicar la semántica en los esquemas, mejor es el diseño

- Mal diseño: `EMPLEADO_PROYECTO: {E_NOMBRE, E_DNI, E_NACIMIENTO, DIRECCION, P_NOMBRE, P_NUMERO}`
- Buen diseño: `EMPLEADO{E_NOMBRE, E_DNI, E_NACIMIENTO, DIRECCION}, PROYECTO{P_NOMBRE, P_NUMERO}, TRABAJA_EN{E_DNI, P_NUMERO}`

### Pautas
- Diseñar esquemas para que sea fácil explicar su significado.
- No combinar atributos de distintos tipos de entidades y relaciones en una misma relación.

## Pauta 2: Almacenamiento
Objetivo: minimizar el espacio de almacenamiento a través del diseño.

- Mal diseño: `EMPLEADO_DEPARTAMENTO{E_NOMBRE, E_DNI, NRO_DPTO, D_NOMBRE}`
    + **EMPLEADO**

    E_NOMBRE | E_DNI | NRO_DPTO | D_NOMBRE
    -------- | ----- | -------- | --------
    Diego    | 11111 | 5        | Publicidad y Promoción
    Laura    | 22222 | 5        | Publicidad y Promoción
    Marina   | 33333 | 2        | Reclutamiento y Selección
    Santiago | 44444 | 5        | Publicidad y Promoción
    ........ | ..... | ........ | ........................

- Bueno diseño: `EMPLEADO{E_NOMBRE, E_DNI, NRO_DPTO}, DEPARTAMENTO{NRO_DPTO, D_NOMBRE}`
    + **EMPLEADO**

    E_NOMBRE | E_DNI | NRO_DPTO
    -------- | ----- | --------
    Diego    | 11111 | 5       
    Laura    | 22222 | 5       
    Marina   | 33333 | 2       
    Santiago | 44444 | 5       
    ........ | ..... | ........

    + **DEPARTAMENTO**
    
    NRO_DPTO | D_NOMBRE
    -------- | --------------------------
    5        | Publicidad y Promoción
    2        | Reclutamiento y Selección

- Un mal diseño puede generar anomalías de actualización (inserción, eliminación, actualización).

### Anomalías de inserción
- Insertar un empleado que aún no posee departamento requiere introducir valores `NULL`

    E_NOMBRE | E_DNI | NRO_DPTO | D_NOMBRE | (Problema)
    -------- | ----- | -------- | -------- | --
    Santiago | 44444 | 5        | Publicidad y Promoción |
    Tamara   | 55555 | **_NULL_**     | **_NULL_** | <- Campos NULL
    ........ | ..... | ........ | ........................ |

- Insertar un nuevo empleado requiere que los datos sean **consistentes** con el resto de los registros.

    E_NOMBRE | E_DNI | NRO_DPTO | D_NOMBRE | (Problema)
    -------- | ----- | -------- | -------- | --
    Santiago | 44444 | 5        | Publicidad y Promoción |
    Tamara   | 55555 | 5        | _**Publicaciones y Prop.**_| <- Inconsistente
    ........ | ..... | ........ | ........................ | 

- No es posible insertar un nuevo departamento que aún no posee empleados
    1. NULL en el campo de empleado violaría la integridad de la clave (E_DNI)
    2. Esa tupla dejaría de tener sentido si se asigna un empleado a ese departamento

### Anomalías de eliminación
- Eliminar el único empleado de un departamento hace que se pierda toda la información relacionada al mismo.

    E_NOMBRE | E_DNI | NRO_DPTO | D_NOMBRE | (problema)
    -------- | ----- | -------- | -------- | --
    Diego    | 11111 | 5        | Publicidad y Promoción |
    Laura    | 22222 | 5        | Publicidad y Promoción |
    Marina   | 33333 | **_2_**        | **_Reclutamiento y Selección_** | <- Pérdida de información
    Santiago | 44444 | 5        | Publicidad y Promoción |
    ........ | ..... | ........ | ........................ |

### Anomalías de modificación
- Modificar el valor de un atributo de un departamento requiere modificar **TODAS** las tuplas de ese departamento. Sino se generan inconsistencias.

    E_NOMBRE | E_DNI | NRO_DPTO | D_NOMBRE | (problema)
    -------- | ----- | -------- | -------- | --
    Diego    | 11111 | 5        | **_Publicidad, Promoción y Comunicación_** | <- Modificado (inconsistente)
    Laura    | 22222 | 5        | **_Publicidad y Promoción_** | <- Original (inconsistente)
    Marina   | 33333 | 2        | Reclutamiento y Selección |
    Santiago | 44444 | 5        | **_Publicidad y Promoción_** | <- Original (inconsistente)
    ........ | ..... | ........ | ........................ |

### Performance
- Esta pauta puede ser violada en favor de la performance.
- Por ejemplo, al guardar una factura, esto afecta el saldo del cliente. Este saldo se puede reconstruir recorriendo todas las facturas y pagos realizados, pero es "costoso" ya que es un dato frecuentemente consultado.
    + La solución sería guardar el saldo, y recalcular el saldo en cada pago.
    + Se debe utilizar algún mecanismo que permita automatizar esto último (triggers/store procedures, etc)