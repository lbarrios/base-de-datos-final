# - Explicar las pautas de diseño de una base de datos.

Pauta 1 (semántica): asegurarse de que la semántica de los atributos es clara. Explicar los atributos debería ser fácil. Para ello, no deberían combinarse distintas entidades en una misma relación. Por ejemplo, si se tiene el diseño ALUMNO_MATERIA{a_dni, a_nombre, m_nombre, m_comision}, a no es fácil entender el significado. Un mejor diseño sería ALUMNO{a_dni, a_nombre}, MATERIA{m_comision, m_nombre}, CURSA_EN{a_dni, m_comision}.

Pauta 2 (almacenamiento): evitar la redundancia de información para minimizar el espacio de almacenamiento utilizado. Usando el mismo ejemplo anterior, si nombre es un texto con el nombre largo de la materia, y comisión es un número que identifica unívocamente la materia, entonces el primer diseño estaría teniendo un montón de información redundante. Si en una instancia dada hay mil alumnos cursando en (m_comision=52, m_nombre="Base de Datos"), entonces esa información se va a repetir mil veces. En cambio en el segundo diseño sólamente hay una tupla con la información correspondiente en MATERIA, y luego esta se relaciona a través de CURSA_EN.

Pauta 3 (NULLs): evitar que los atributos tomen valores NULL dentro de una relación. Si estos son inevitables, asegurarse de que sean situaciones excepcionales. Siguiendo el ejemplo anterior, un alumno que no está cursando una materia tendría en NULL los campos (m_nombre, m_comision). Asimismo, si se deseab materias que no tienen alumnos también hay un problema, ya que deberían agregarse alumnos con dni y nombre nulos, lo cual violaría la integridad de la clave primaria.

Pauta 4 (tuplas espúreas): las tuplas espúreas representan información inválida. Tuplas espúreas pueden surgir al hacer JOIN como resultado de una mala descomposición. Siguiendo el ejemplo anterior, si en vez de hacer CURSA_EN{a_dni, m_comision} hiciéramos CURSA_EN{a_nombre, m_comision}, el JOIN se podría hacer, pero como nombre no es clave primaria obtendríamos tuplas que no reflejan la información original. Se debe evitar relacionar mediante atributos que no sean una combinación de claves primarias/foráneas.

# - Describir las anomalías que puede presentar un diseño.

Anomalía de inserción: anomalía que surge al insertar nueva información. Por ejemplo, con un mal diseño se pueden tener que poner varios atributos en NULL al insertar un nuevo registro. También, si el diseño es malo, hay que asegurarse que la información sea consistente con el resto de los registros. Por ejemplo, si se tiene el diseño ALUMNO_MATERIA{a_dni, a_nombre, m_nombre, m_comision}, y se tienen las siguientes tuplas {(1, "Juan", "Análisis I", 10), (2, "Flor", "Álgebra", 20)}, al insertar a (3, "Pedro"), si no está cursando nada, debemos poner (3, "Pedro", NULL, NULL). Por otro lado, para insertar una nueva materia, se debe insertar (NULL, NULL, "Algoritmos I", 30), lo cual viola la integridad de la PK. También se pueden generar inconsistencias si se realiza la siguiente inserción (3, "Pedro", "Algoritmos I", 10) o (3, "Pedro", "Análisis I", 30).

Anomalía de eliminación: anomalía que surge al eliminar información. Siguiendo el ejemplo anterior, si eliminamos un alumno que es el único cursando una materia, se pierde toda la información relacionada con dicha materia.

Anomalía de actualización: anomalía que surge al actualizar información. Por ejemplo, si en el ejemplo anterior se quiere cambiar el nombre "Análisis I" por "Análisis Matemático I", se deben actualizar todas las tuplas que tengan este valor para no generar inconsistencia, lo cual es costoso en términos de performance.

# - Definir dependencia funcional.

La dependencia funcional es una herramienta formal para el análisis de esquemas. Establece una dependencia entre dos conjuntos de atributos X e Y de una Base de Datos. "Y depende de X" se denota X⟹Y, y significa que para cualquier par de tuplas t1, t2, se cumple que t1[X]=t2[X] ⟹ t1[Y]=t2[Y].

Informalmente, la interpretación sería que los valores que pueden tomar los atributos de Y dependen de los valores que tomen los atributos de X.

# - ¿Para qué sirve que la normalización? ¿Cómo esta relacionado con la calidad de un diseño de bases de datos? ¿Qué problemas puede presentar una base desnormalizada? Ejemplifique

# - ¿Cuando un esquema está en 2FN?

# - Dar un esquema que esté en 2FN pero no en 3FN. Dar una descomposición del mismo en 3FN.

# - Definir 2FN.

# - Para qué sirve la normalización? Cómo se relaciona con las pautas de diseño de una base de datos? Describir anomalías que puede presentar una base de datos desnormalizada.
