# 05. Normalización

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

## Pauta 4: Tuplas Espúreas
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
        ```text
        E_DNI, P_NUMERO, HORAS, E_NOMBRE, P_NOMBRE, P_UBICACION
        -----  --------
          v       v       ^
          |       |       |
          v-------v-------^
        ```
    + **DF2: E_DNI ⟹ E_NOMBRE**
        ```text
        E_DNI, P_NUMERO, HORAS, E_NOMBRE, P_NOMBRE, P_UBICACION
        -----  --------
          v       v                ^
          |       |                |
          v-------v----------------^
        ```
    + **DF3: P_NUMERO ⟹ {P_NOMBRE, P_UBICACION}**
        ```text
        E_DNI, P_NUMERO, HORAS, E_NOMBRE, P_NOMBRE, P_UBICACION
        -----  --------
                  v                           ^          ^
                  |                           |          |
                  v---------------------------------------
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
- Una DF _X⟹Y_ es **completa** si al eliminar algún atributo _A de X_ la DF deja de existir. En caso contrario, es **parcial**.
    + Horas depende de manera completa de PK
    + E_Nombre depende de manera parcial de PK.
    + P_Nombre y P_Ubicacion dependen de manera parcial de PK.
- Una DF _X⟹Y_ es **transitiva** si existe un conjunto de atributos _Z_ en _R_ que no son ni CK ni un subconjunto de alguna clave de _R_, tal que _X⟹Z_ y _Z⟹Y_.
- Una DF _A⟹B_ es **trivial** si _B⊆A_.
    + Por ejemplo, _A⟹A_ es una DF trivial.

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
    + Mover atributos de relación anidada a una nueva relación
    + Agregar a la nueva relación PK de la relación original
    + PK de la nueva relación = clave parcial + PK relación original

* Ejemplo: `EMP_PROY{<E_CUIL>, E_NOMBRE, PROYECTOS{<P_NUMERO>, HORAS}}` se transforma en `EMP{<E_CUIL>, E_NOMBRE}` y `EMP_PROY{<E_CUIL>, <P_NUMERO>, HORAS}`.

## 2FN
Un esquema R está en 2FN si todo atributo no primo _A_ de _R_ depende funcionalmente de manera completa de la PK de R.

- Definición alternativa: Un esquema R está en 2FN si todo atributo no primo _A_ de _R_ depende completamente de todas las claves de _R_.

**Tips**
- Verificar sólo DF cuyos lado izquierdo posean atributos que sean parte de la PK.
- Si la PK es un solo atributo, cumple 2FN.

- Ejemplo descomposición en 2FN:
    + **EP1**
        ```text
        E_DNI, P_NUMERO, HORAS
        -----  --------
          v       v       ^
          |       |       |
          v-------v-------^
        ```
    + **EP2**
        ```text
        E_DNI, E_NOMBRE
        ----- 
          v       ^
          |       |
          v-------^
        ```
    + **EP3**
        ```text
        P_NUMERO, P_NOMBRE, P_UBICACION
        --------                       
        v          ^          ^
        |          |          |
        v----------------------
        ```

## 3FN
Un esquema está en 3FN si está en 2FN, y además ningún atributo no primo de R depende transitivamente de la PK.

- Definición formal: Un esquema _R_ está en 3FN si para toda dependencia funcional **no trivial** _X⟹A_ de _R_, se cumple alguna de las condiciones:
    + _X_ es SK de _R_.
    + _A_ es atributo primo de _R_.

- Ejemplo descomposición 3FN
    + **EMPLEADO_DEPARTAMENTO** (es 2FN, pero no es 3FN)
        ```text
        E_NOMBRE | <E_CUIL> | E_FECHA_NACIMIENTO | NRO_DPTO | D_NOMBRE
            ^          v              ^              ^ v         ^
            |          |              |              | |         |
            ^----------v--------------^--------------^ |         |
                                                       |         |
                                                       v---------^
        ```

    + **EMPLEADO**
        ```text
        E_NOMBRE | <E_CUIL> | E_FECHA_NACIMIENTO | NRO_DPTO
            ^          v              ^               ^
            |          |              |               |
            ^----------v--------------^---------------^
        ```

    + **DEPARTAMENTO**
        ```text
        <NRO_DPTO> | D_NOMBRE
           v            ^
           |            |
           v------------^
        ```

- El natural join _ED1⋈ED2_ de la descomposición recompone la relación original sin generar tuplas espúreas.

## BCFN (Boyce-Codd Normal Form)
Un esquema _R_ está en BCFN si pra toda dependencia funcional no trivial _X⟹A_ de _R_, _X_ es _SK_ de _R_.

- Es un derivado más restrictivo de 3FN, ya que no permite la condición de que _A_ sea primo.

- Reduce la redundancia.
- Se puede perder alguna DF.

## Reglas de inferencia
El diseñador de la BD especifica DF semánticamente obvias. Existen DF no especificadas que pueden ser inferidas.

- _R = {E_CUIL, NRO_DEPTO, D_NOMBRE}_
- _F = {E_CUIL ⟹ NRO_DEPTO, NRO_DEPTO ⟹ D_NOMBRE}_
- Usando ambas DF de _F_ se puede deducir que _E_CUIL ⟹ D_NOMBRE_.

- Una DF _x⟹Y_ es **inferida de** o **implicada por** un conjunto de DFs _F_ de _R_ si se cumple _X⟹Y_ en toda instancia legal _r(R)_.
    + Es decir, siempre que _r(R)_ satisface F, se cumple _X⟹Y_.
- El conjunto de todas las DF de _F_ más todas las DF que puedan ser inferidas de _F_ se denota como _F⁺_.
    + _R = {E_CUIL, NRO_DEPTO, D_NOMBRE}_
    + _F = {E_CUIL ⟹ NRO_DEPTO, NRO_DEPTO ⟹ D_NOMBRE}_
    + _F⁺ = {E_CUIL ⟹ NRO_DEPTO, NRO_DEPTO ⟹ D_NOMBRE, **E_CUIL ⟹ D_NOMBRE**}_

### Axiomas de Armstrong
- RI1 (reflexiva): si `Y⊆X`, entonces `X⟹Y`.
- RI2 (de incremento): `{X⟹Y} ⊧ XZ⟹YZ`.
- RI3 (transitiva): `{X⟹Y, Y⟹Z} ⊧ X⟹Z`.
- Propiedades:
    + Fiable (Sound): dado _F_ de _R_, cualquier DF deducida de _F_ utilizando RI1, RI2 o RI3 se cumple en cualquier estado _r(R)_ que satisface _F_.
    + Completa (Complete): _F⁺_ puede ser determinado a partir de _F_ aplicando solamente RI1, RI2 y RI3.

### Corolarios de Armstrong (reglas adicionales)
- RI4 (de descomposición o proyección): `{X⟹YZ} ⊧ X⟹Y`.
- RI5 (de unión o aditiva): `{X⟹Y, X⟹Z} ⊧ X⟹YZ`.
- RI6 (pseudotransitiva): `{X⟹Y, WY⟹Z} ⊧ WX⟹Z`.

### Clausura
- Diseño:
    1. Se especifica _F_ el conjunto de DFs por semántica de atributos.
    2. Se utilizan RI1, RI2 y RI3 para inferir DFs adicionales.
        1. Determinar conjunto de atributos _X_ que aparecen del lado izquierdo de cada DF de _F_.
        2. Determinar conjunto _Y_ de atributos que dependen de _X_.

- Clausura de _X_: conjunto de atributos que son determinados por _X_ basados en _F_. Se denota _X⁺_.

**Algoritmo para determinar X⁺**
```tex
X⁺ := X
repetir
    viejoX⁺ := X⁺
    para cada DF Y⟹Z en F hacer
        si Y⊆X⁺ entonces
            X⁺ = X⁺∪Z
mientras(X⁺==viejoX⁺)
```

### Clave de una relación
Búsqueda de una clave _K_ en _R_ a partir de un conjunto de DFs.

```text
K := R
para cada atributo A∈K
    calcular (K−A)⁺
    si (K−A)⁺ contiene todos los atributos de R entonces
        K := K − {A}
```

- Determina una sola de las CK, depende fuertemente de la manera en que son removidos los atributos.

## Bibliografía
- Capítulo 15 (hasta 15.5 inclusive) Elmasri/Navathe - Fundamentals of Database Systems, 6th Ed., Pearson, 2011.
