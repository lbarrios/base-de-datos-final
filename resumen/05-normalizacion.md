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
    + **EMPLEADO_DEPARTAMENTO**

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

## Pauta 3: NULLs
Atributos no relacionados agrupados en una misma tabla pueden generar múltiples NULL en una misma tupla.

**EMPLEADO_DEPARTAMENTO**

E_NOMBRE | E_DNI | NRO_DPTO | D_NOMBRE
-------- | ----- | -------- | --------
Santiago | 44444 | 5          | Publicidad y Promoción
Tamar    | 55555 | **_NULL_** | **_NULL_**

- Desperdicio de **espacio de almacenamiento**
- Problemas al hacer **JOIN** (`INNER JOIN` produce distinto resultado que `OUTER JOIN`).
- ¿Cómo se interpretan las **funciones de agregación**? (count, sum, etc)
- Diversas interpretaciones de NULL
    + El resultado no aplica a la tupla.
        * Ejemplo: registro de conducir en un menor.
    + El valor existe, pero está ausente.
        * Ejemplo: fecha de nacimiento.
    + El valor es desconocido (no sabemos si existe o no)
        * Ejemplo: teléfono.

### Pautas
- Evitar asignar atributos a una relación si estos pueden ser NULL frecuentemente
- Si los NULL son inevitables, asegurar que sean situaciones excepcionales.

## Pauta 3: Tuplas Espúreas
Las tuplas espúreas representan información no válida.

- Esquema original
    **EMPLEADO_PROYECTO**

    E_NOMBRE | E_DNI | NRO_PROY | P_UBICACION
    -------- | ----- | -------- | --------
    Diego    | 11111 | 5        | Argentina
    Laura    | 22222 | 5        | Argentina
    Marina   | 33333 | 2        | Uruguay
    Santiago | 44444 | 5        | Argentina

- Descomposición
    **EMPLEADO**

    E_DNI | NRO_PROY | P_UBICACION
    ----- | -------- | --------
    11111 | 5        | Argentina
    22222 | 5        | Argentina
    33333 | 2        | Uruguay
    44444 | 5        | Argentina

    **UBICACION_EMPLEADO**

    E_NOMBRE | P_UBICACION
    -------- | --------
    Diego    | Argentina
    Laura    | Argentina
    Marina   | Uruguay
    Santiago | Argentina

- Esta descomposición no permite recuperar la información original.
- Al aplicar `NATURAL JOIN` se producen tuplas espúreas.
    
    E_DNI | NRO_PROY | P_UBICACION | E_NOMBRE
    ----- | -------- | --------    | --------
    11111 | 5        | Argentina   | Diego
    22222 | 5        | Argentina   | Diego
    33333 | 2        | Uruguay     | Marina
    44444 | 5        | Argentina   | Diego

- **Problema**: `P_UBICACION` relaciona ambos esquemas pero no es clave primaria ni foránea de ninguno de ellos.

### Pautas
- Diseñar esquemas que puedan ser relacionads por atributos que se encuentren relacionados por condiciones de igualdad entre ellos (clave primaria/foránea).
- Evitar relaciones que contengan atributos de matching que no sean combinación de claves primaria/foránea, ya que los JOINS pueden introducir tuplas espúreas.

## Dependencias funcionales
Herramienta formal para el análisis de esquemas. Permite detectar y describir problemas descriptos previamente.

- Informalmente: restricción entre dos conjuntos de atributos `X` e `Y` de una BBDD. Los valores que toman los atributos de `Y` dependen de los valores que tomen `X`.
- Ejemplo:
    + **DF1: {E_DNI, P_NUMERO} ⟹ HORAS**
        ```
        E_DNI, P_NUMERO, HORAS, E_NOMBRE, P_NOMBRE, P_UBICACION
        -----  --------
          ∨       ∨       ∧
          |       |       |
          ∨-------∨-------∧
        ```
    + **DF2: E_DNI ⟹ E_NOMBRE**
        ```
        E_DNI, P_NUMERO, HORAS, E_NOMBRE, P_NOMBRE, P_UBICACION
        -----  --------
          ∨       ∨                ∧
          |       |                |
          ∨-------∨----------------∧
        ```
    + **DF3: P_NUMERO ⟹ {P_NOMBRE, P_UBICACION}**
        ```
        E_DNI, P_NUMERO, HORAS, E_NOMBRE, P_NOMBRE, P_UBICACION
        -----  --------
                  ∨                           ∧          ∧
                  |                           |          |
                  ∨---------------------------------------
        ```

- Formalmente:
    + Esquema relacional de la BD posee atributos _A₁, A₂, ⋯, Aₙ_
    + La BD se puede pensar como un esquema universal _R = {A₁, A₂, ⋯, Aₙ}_
    + Sean _X,Y ⊆ R_, la DF indicada como _X⟹Y_ especifica una restricción sobre las posibles tuplas que pueden conformar una instancia _r_ de _R_. Para cualquier par _t₁,t₂ ∈ r_ tal que _t₁[X] = t₂[X]_, se debe cumplir que _t₁[Y] = t₂[Y]_.

- DF son propiedad **semántica** de los atributos.
- Los diseñadores de las BD deben usar su entendimiento de la semántica para especificar las DF, y deben respetarse todos los `r(R)`.
- `r(R)` que satisface condiciones de DF se denomina instancia legal, estado legal o extensión legal de R.
- No es posible determinar los DF de una relación a través de los valores de sus datos. Es necesario conocer el significado.
- Una DF _puede_ existir si la cumple una instancia r(R)
    + Para _confirmar_ la existencia, es necesario conocer la semántica de los atributos.
    + Para _descartar_ la existencia, sólo basta con mostrar tuplas que violen esta posible DF.
- Un conjunto de DF se denota F.

## FN basadas en PK
- Se asume:
    + Se cuenta con el conjunto DF para cada relación
    + Cada relación tiene PK
- A cada esquema se le ejecutan test para **certificar** que satisfacen una **forma normal**.
- Objetivo:
    + Minimizar redundancia
    + Minimizar anomalías de actualización.
- Esquemas que no pasan ciertos tests, se descomponen en esquemas más pequeños.
- La forma normal de una relación se refiere a **la mayor forma normal alcanzada** por ella.
- **No garantizan un buen diseño** de la DB si se las considera aisladas de otros factores.
- Propiedades luego de la descomposición:
    + **Nonadditive Join (Lossless Join)**: no ocurre generación de tuplas espúreas; la relación original tiene que poder ser recuperada.
        * Debe lograrse a cualquier costo.
    + **Preservación de DF**: garantía de que cada DF se encuentra representada en algún esquema resultante de la descomposición.
        * No siempre puede ser lograda; a veces se sacrifica.

## Elementos
* Super Clave (SK): SK de `R = {A₁, ⋯, aₙ}` es un subconjunto `S⊆R` de atributos tal que `t₁,t₂ ∈ r(R) ∧ t₁ = t₂ ⟹ t₁(S) ≠ t₂(S)`.
* Clave (K): una clave K es una SK con la propiedad adicional de que al remover cualquier atributo de K, deja de ser SK. Es decir, un _SK minimal_.
* Clave Candidata (CK): cada clave de un esquema se denomina clave candidata.
* Clave Primaria (PK): es una CK designada _arbitrariamente_ como PK.
* Clave Secundaria: cualquier CK que no es PK.
* Atributo primo: atributo de un esquema R que pertenece a _**alguna** CK_ de R.
* Requisito: todos los esquemas deben poseer PK en la práctica

## 1FN
- **Prohibe**: relaciones dentro de relaciones o relaciones como valores de atributos dentro de tuplas.
- **Admite**: El dominio de un atributo debe incluir valores atómicos (simples e indivisibles). En la tupla, puede tomar un solo valor del dominio.

### Técnicas para alcanzar 1FN

**DEPARTAMENTO**

D_NOMBRE       | <D_NUMERO> | D_MGR_CUIL | D_AREAS_INFLUENCIA
-------------- | ---------- | ---------- | ---------------------------
Investigación  | 2          | 27-233-9   | {Argentina, Brasil, Uruguay}
Prensa         | 3          | 20-172-4   | {Chile}
Administración | 8          | 27-384-2   | {Argentina}

1. Remover atributo que viola 1FN y ubicarlo en una nueva relación. La nueva relación tiene como PK ambos atributos.
    + Se mueve DPTO_AREAS_INFLUENCIA junto con la PK D_NUMERO.

        **DEPARTAMENTO**

        D_NOMBRE       | <D_NUMERO> | D_MGR_CUIL
        -------------- | ---------- | ----------
        Investigación  | 2          | 27-233-9  
        Prensa         | 3          | 20-172-4  
        Administración | 8          | 27-384-2  

        **DEPARTAMENTO_AREAS**

        <D_NUMERO> | <D_AREAS_INFLUENCIA>
        ---------- | ---------------------
        2          | Argentina
        2          | Brasil
        2          | Uruguay
        3          | Chile
        8          | Argentina
    + Suele ser la mejor opción ya que no sufre de redundancia y es genérica (no se limita a un número de valores).
2. Expandir la PK que permita que exista más de un mismo D_NUMERO, pero con distinta área de influencia.
    + Esta solución introduce **REDUNDANCIA** en la relación.

        **DEPARTAMENTO**

        D_NOMBRE       | <D_NUMERO> | D_MGR_CUIL | <D_AREAS_INFLUENCIA>
        -------------- | ---------- | ---------- | ---------------------
        Investigación  | 2          | 27-233-9   | Argentina
        Investigación  | 2          | 27-233-9   | Brasil
        Investigación  | 2          | 27-233-9   | Uruguay
        Prensa         | 3          | 20-172-4   | Chile
        Administración | 8          | 27-384-2   | Argentina
3. Si se conoce la cantidad máxima de valores que puede tomar el atributo, se pueden generar tantos atributos como esa cantidad.
    + Ejemplo, si hay 3 áreas de influencia como máximo por departamento.

        **DEPARTAMENTO**

        D_NOMBRE       | <D_NUMERO> | D_MGR_CUIL | D_AREAS_INFLUENCIA1 | D_AREAS_INFLUENCIA2 | D_AREAS_INFLUENCIA3
        -------------- | ---------- | ---------- | -- | -- | --
        Investigación  | 2          | 27-233-9   | Argentina | Brasil | Uruguay
        Prensa         | 3          | 20-172-4   | Chile | **NULL** | **NULL**
        Administración | 8          | 27-384-2   | Argentina | **NULL** | **NULL**

    + Introduce valores NULL para los casos en que la tupla no posee todos los valores.
    + No existe una semántica en cuanto al orden y ubicación de los valores.
    + Consultas se vuelven más complejas.
- La técnica puede aplicarse recursivamente.
- Debe manejarse con cuidado cuando hay múltiples atributos multivaluados para no generar relaciones inexistentes.

### Relaciones anidadas
Cuando el valor de una tupla es una relación.

- 1FN prohíbe relaciones anidadas.