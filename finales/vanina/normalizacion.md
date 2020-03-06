## - Explicar las pautas de diseño de una base de datos.

Pauta 1 (semántica): asegurarse de que la semántica de los atributos es clara. Explicar los atributos debería ser fácil. Para ello, no deberían combinarse distintas entidades en una misma relación. Por ejemplo, si se tiene el diseño ALUMNO_MATERIA{a_dni, a_nombre, m_nombre, m_comision}, a no es fácil entender el significado. Un mejor diseño sería ALUMNO{a_dni, a_nombre}, MATERIA{m_comision, m_nombre}, CURSA_EN{a_dni, m_comision}.

Pauta 2 (almacenamiento): evitar la redundancia de información para minimizar el espacio de almacenamiento utilizado. Usando el mismo ejemplo anterior, si nombre es un texto con el nombre largo de la materia, y comisión es un número que identifica unívocamente la materia, entonces el primer diseño estaría teniendo un montón de información redundante. Si en una instancia dada hay mil alumnos cursando en (m_comision=52, m_nombre="Base de Datos"), entonces esa información se va a repetir mil veces. En cambio en el segundo diseño sólamente hay una tupla con la información correspondiente en MATERIA, y luego esta se relaciona a través de CURSA_EN.

Pauta 3 (NULLs): evitar que los atributos tomen valores NULL dentro de una relación. Si estos son inevitables, asegurarse de que sean situaciones excepcionales. Siguiendo el ejemplo anterior, un alumno que no está cursando una materia tendría en NULL los campos (m_nombre, m_comision). Asimismo, si se deseab materias que no tienen alumnos también hay un problema, ya que deberían agregarse alumnos con dni y nombre nulos, lo cual violaría la integridad de la clave primaria.

Pauta 4 (tuplas espúreas): las tuplas espúreas representan información inválida. Tuplas espúreas pueden surgir al hacer JOIN como resultado de una mala descomposición. Siguiendo el ejemplo anterior, si en vez de hacer CURSA_EN{a_dni, m_comision} hiciéramos CURSA_EN{a_nombre, m_comision}, el JOIN se podría hacer, pero como nombre no es clave primaria obtendríamos tuplas que no reflejan la información original. Se debe evitar relacionar mediante atributos que no sean una combinación de claves primarias/foráneas.

## - Describir las anomalías que puede presentar un diseño.

Anomalía de inserción: anomalía que surge al insertar nueva información. Por ejemplo, con un mal diseño se pueden tener que poner varios atributos en NULL al insertar un nuevo registro. También, si el diseño es malo, hay que asegurarse que la información sea consistente con el resto de los registros. Por ejemplo, si se tiene el diseño ALUMNO_MATERIA{a_dni, a_nombre, m_nombre, m_comision}, y se tienen las siguientes tuplas {(1, "Juan", "Análisis I", 10), (2, "Flor", "Álgebra", 20)}, al insertar a (3, "Pedro"), si no está cursando nada, debemos poner (3, "Pedro", NULL, NULL). Por otro lado, para insertar una nueva materia, se debe insertar (NULL, NULL, "Algoritmos I", 30), lo cual viola la integridad de la PK. También se pueden generar inconsistencias si se realiza la siguiente inserción (3, "Pedro", "Algoritmos I", 10) o (3, "Pedro", "Análisis I", 30).

Anomalía de eliminación: anomalía que surge al eliminar información. Siguiendo el ejemplo anterior, si eliminamos un alumno que es el único cursando una materia, se pierde toda la información relacionada con dicha materia.

Anomalía de actualización: anomalía que surge al actualizar información. Por ejemplo, si en el ejemplo anterior se quiere cambiar el nombre "Análisis I" por "Análisis Matemático I", se deben actualizar todas las tuplas que tengan este valor para no generar inconsistencia, lo cual es costoso en términos de performance.

## - Definir dependencia funcional.

La dependencia funcional es una herramienta formal para el análisis de esquemas. Establece una dependencia entre dos conjuntos de atributos X e Y de una Base de Datos. "Y depende de X" se denota X⟹Y, y significa que para cualquier par de tuplas t1, t2, se cumple que t1[X]=t2[X] ⟹ t1[Y]=t2[Y].

Informalmente, la interpretación sería que los valores que pueden tomar los atributos de Y dependen de los valores que tomen los atributos de X.

## - ¿Para qué sirve que la normalización? ¿Cómo esta relacionado con la calidad de un diseño de bases de datos? ¿Qué problemas puede presentar una base desnormalizada? Ejemplifique

## - ¿Cuando un esquema está en 2FN?

Un esquema está en 2FN cuando está en 1FN (es decir uqe no tiene atributos multivaluados) y todo atributo no primo A de R (es decir, que no pertenece a ninguna CK) depende funcionalmente de manera completa de la PK de R.

## - Dar un esquema que esté en 2FN pero no en 3FN. Dar una descomposición del mismo en 3FN.

Un esquema está en 3FN si está en 2FN, y además ningún atributo no primo de R depende transitivamente de la PK.

- **EMPLEADO_DEPARTAMENTO** (es 2FN, pero no es 3FN)
    ```
    E_NOMBRE | <E_CUIL> | E_FECHA_NACIMIENTO | NRO_DPTO | D_NOMBRE
        ^          v              ^              ^ v         ^
        |          |              |              | |         |
        ^----------v--------------^--------------^ |         |
                                                   |         |
                                                   v---------^
    ```

- **EMPLEADO**
    ```
    E_NOMBRE | <E_CUIL> | E_FECHA_NACIMIENTO | NRO_DPTO
        ^          v              ^               ^
        |          |              |               |
        ^----------v--------------^---------------^
    ```

- **DEPARTAMENTO**
    ```
    <NRO_DPTO> | D_NOMBRE
       v            ^
       |            |
       v------------^
    ```


## - Definir 2FN.

(de cubawiki)
2FN es una forma normal que, además de ser 1FN (prohíbe relaciones dentro de relaciones, atributos multivaluados), cumple que todo atributo no primo A de R depende funcionalmente de manera completa de la PK de R. Esto es, que la PK es una DF minimal para todos los atributos que no pertenecen a alguna CK.

## - Para qué sirve la normalización? Cómo se relaciona con las pautas de diseño de una base de datos? Describir anomalías que puede presentar una base de datos desnormalizada.

(de cubawiki)

La normalización es una herramienta que se apoya en las DFs para evaluar y comparar distintas formas de agrupar atributos en un esquema. Al diseñar una base de datos normalizada siguiendo las formas normales, se busca que el resultado sea conceptualmente bueno (e.g entendible) y también físicamente bueno (e.g minimizar duplicación).

Para esto se siguen cuatro pautas fundamentales, que si bien no siempre pueden alcanzarse al mismo tiempo, dan una medida informal de la calidad del diseño:

(SANE => 
    Semántica: que la semántica sea clara
    Almacenamiento: evitar información redundante
    Nulls: evitar valores NULLs
    tuplas Espúreas: no generar tuplas espúreas
)

1. semántica clara
2. reducir información redundante
3. reducir la cantidad de valores NULL
4. no permite generar tuplas espúreas

Una base de datos desnormalizada puede presentar distintos problemas, como por ejemplo:

Anomalías de modificación: el nombre del departamento 33 es inconsistente (Compras/Adquisiciones):
idEmpleado  idDepartamento  nombreDepartamento
1   33  Compras
2   34  Ventas
3   33  Adquisiciones
Anomalías de deleción: al borrar el empleado 2 desaparece el departamento Ventas
idEmpleado  idDepartamento  nombreDepartamento
1   33  Compras
3   33  Adquisiciones
Anomalías de inserción: este esquema no permite agregar información de departamentos que aún no tienen empleados. Lo siguiente es inválido:
idEmpleado  idDepartamento  nombreDepartamento
NULL    35  Ingeniería
NULL    36  Calidad
