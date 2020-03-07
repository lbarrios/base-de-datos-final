# Preguntas de final

[TOC]

## ¿Qué es Data Mining? Describir las distintas técnicas.
El data mining supervisado requiere contar con las distintas etiquetas o categorías antes de clasificar. El data mining no supervisado, por otro lado, puede trabajar sin utilizar estos valores, y muchas veces se utiliza para encontrar categorías de entes similares de los que no se cuenta con mucha más información al respecto.

Supervisado, árboles de decisión: se trata de detectar la categoría de un ente desconocido a través de la representación en un árbol de decisión, en donde cada nodo es una pregunta, y las hojas son una respuesta. Encontrar la respuesta es, entonces, equivalente a recorrer el árbol hasta llegar a una hoja. Esta técnica es similar a la aplicación de sucesivas reglas "IF condicion THEN ...". Es relativamente sencilla de aplicar pero puede sufrir overfitting o sobreentrenamiento, que es cuando el exceso de reglas hace que las predicciones no resulten buenas. Por eso normalmente el entrenamiento divide en dos partes, primero la adquisición de las reglas, y luego una poda en donde se recortan los caminos que no generan ganancia; muchas veces la poda se realiza durante misma construcción del árbol, decidiendo en cada paso si agregar ese nodo va a generar una ganancia en el ratio de predicción, o no. Para ello se usa normalmente un conjunto de datos para entrenamiento, y otro separado para testing.

Supervisado, redes neuronales: las redes neuronales surgieron en un intento de replicar el modelo de funcionamiento del cerebro. La unidad básica de la red neuronal es el perceptrón, que vendría a ser una especie de neurona virtual. Posteriormente se descubrió que el cerebro no funcionaba exactamente así, pero ya habían demasiados papers escritos al respecto. La ventaja de las redes neuronales por sobre otras técnicas es su gran capacidad de adaptarse y "aprender". El entrenamiento de una red neuronal se basa en brindarle ejemplos de inputs y outputs, y en base a esto la red aprende a interpretar el output que correspondería a nuevos inputs. Como trabajan con probabilidades, no son muy buenas para los cáculos exactos.

## Defina bases de datos distribuida. ¿Qué nuevos niveles de transparencia aparecen junto a estas bases?

Una base distribuída está compuesta por múltiples bases de datos que se encuentran lógicamente relacionadas y distribuídas en una red.

Sumado a la independencia entre los datos físicos y lógicos, las bases de datos distribuídas suman nuevos niveles de transparencia:

Organización de los datos: la forma de realizar un tarea no es afectada por la ubicación de los datos, cuando se cuenta con un nombre para un objeto, este se puede acceder bajo ese nombre independientemente de su composición interna, su ubicación, etcétera.

Fragmentación: puede haber fragmentación vertical (de atributos o columnas en distintos nodos), horizontal (de tuplas o registros en distintos nodos) o mixta, y en ninguno de los casos el usuario debería tener en cuenta la existencia de esta fragmentación.

Replicación: el usuario desconoce la existencia de copias de los datos, cualquier cuestión que se derive de tener los datos replicados en varios sitios (por ejemplo, que una escritura debe grabarse en varios nodos al mismo tiempo) debe ser transparente al usuario.

Diseño: el usuario no debería tener conocimiento sobre cómo está diseñada la base distribuída (cantidad o composición de nodos, esquema global, etcétera)

Ejecución: el usuario debería poder realizar una ejecución sin tener que conocer cómo o dónde se va a ejecutar la misma.


## ¿Qué es fragmentación mixta? Dar un ejemplo, con una query en álgebra relacional para reconstruir las tablas originales

==TODO:==

## ¿Qué es gobierno de datos? Diferencias entre datos, información y conocimiento.

El gobierno de datos involucra el desarrollo y ejecución de arquitecturas, prácticas y procedimientos para administrar adecuadamente los datos dentro de una organización, buscando asegurar la calidad de los mismos, e influyendo en la forma en que se toman las decisiones de negocio, corporativas, de diseño, de gestión.

El gobierno de datos puede tener distintos niveles de madurez:
- totalmente inmaduro, indisciplinado: no existen normas o procedimientos respecto al control de la calidad e integración de los datos, las decisiones de negocio se toman en base a los requerimientos de tecnología, hay alta replicación de datos, que se encuentran en distintas fuentes y formatos.
- reactivo: existen mínimas normas con respecto a la calidad e integración de datos, las decisiones de negocio se ven influenciadas por el producto. Los problemas se enfrentan sólamente luego de que estos ocurran.
- proactivo: los datos pasan a tomar valor para la compañía, los problemas se contemplan antes de que ocurran, el equipo de negocio y tecnología trabajan en colaboración.
- gobernado: las decisiones de tecnología se toman en base a los requerimientos de negocio, los procesos de gestión de datos son estandarizados

Respecto a la diferencia entre datos, información y conocimiento:

```text
     significado          procesamiento
Datos --------> Información -------> Conocimiento
     + metadatos          + relaciones
     + utilidad           + patrones
     + contexto           + predicciones
```

Los datos son un conjunto de valores crudos, sin mucho significado. Por ejemplo, el número 23 o los textos "2020-03-05", "Buenos Aires" son datos.

La información son datos procesados, agregándole metadatos que le dan significado, utilidad, contexto. Siguiendo el ejemplo anterior, no es lo mismo el dato 23, que decir la temperatura 23 grados, la fecha 05/03/2020, la Ciudad de Buenos Aires, lo cual sería información.

El conocimiento surge como derivado del procesamiento de la información mediante la relación, la búsqueda de patrones, la predicción de nueva información, etcétera. Por lo general el conocimiento permite generar nueva información (o datos) a partir de la información preexistente. Representa un entendimiento superior de la información en su conjunto. Siguiendo el ejemplo anterior, el procesamiento de la información del climática en una ciudad durante mucho tiempo puede dar lugar a predicciones meteorológicas o a un entendimiento diferenciado del tema (ejemplo: separación en estaciones del año).

## - Diferencia entre administrador de datos y DBA. Relacionar con concepto de independencia física y transparencia.

El administrador de datos trabaja con el modelo conceptual y lógico, es un perfil netamente funcional. Es un especialista en los datos de una organización desde el punto de vista lógico, con funciones como la colección y análisis de requerimientos para el modelado de negocio, la definición y el cumplimiento de standards. El administrador de datos suele desentenderse de la organización física de los datos.

El DBA trabaja con el modelo físico, es un especialista en el motor de base de datos. Esta persona es quien conoce los detalles de un motor de base de datos, y es asistido por el administrador de datos en la creación de los modelos físicos a partir de los modelos lógicos.

Esto está fuertemente relacionado con el concepto de independencia física y transparencia, ya que si bien trabajan en colaboración el administrador de datos puede abstraerse de los aspectos físicos de la base y trabajar con los aspectos lógicos gracias a la transparencia física; asímismo el DBA puede desentenderse de los aspectos lógicos y realizar cambios u optimizaciones en el modelo físico. Todo esto, en la medida de que el nivel de independencia lo permita.

## ¿Qué es la interoperabilidad de datos? Describir los dos enfoques que se mencionan en la bibliografía.

==TODO==

Enfoques:
+ Integración de datos: Se consultan datos **heterogéneos** de diferentes fuentes via un **esquema virtual global**.
+ Intercambio de datos: Se **transforman** datos estructurados bajo un esquema **origen en datos** estructurados bajo un **esquema destino**.

## Definir las operaciones del Álgebra Relacional

Se tienen los siguientes esquemas:

- R(a,b,c,d){(1,1,1,1),(2,2,2,2),(3,3,3,3),(4,4,4,4)}
- Q(a,e){(1,10),(2,20),(5,50),(6,60)}

Operaciones:

- π - Proyección: π {a} R = R'(a){(1),(2),(3),(4)}
- σ - Select: σ {a≤2} R = R'(a,b,c,d){(1,1,1,1),(2,2,2,2)}
- ⋈ - Join: R ⋈{a=a} Q = R'(a,b,c,d,a_q,e){(1,1,1,1,1,10),(2,2,2,2,2,20)}
- ⋈ - Natural Join: R ⋈{a=a} Q = R'(a,b,c,d,e){(1,1,1,1,10),(2,2,2,2,20)}
- ρ - Rename: cambia el nombre de una relación o un atributo
- ∪ - Unión: unión de conjuntos en dos tuplas
- ∩ - Intersección: intersección de conjuntos en dos tuplas
- − - Diferencia: diferencia de conjuntos en dos tuplas

## Definir esquema.

Un esquema representa al diseño lógico de la base de datos. Cuando se habla del esquema de una relación, se refiere puntualmente al nombre de dicha relación junto con sus atributos.

```
Ejemplo: 
PERSONA(dni, nombre, apellido)
```

## Definir atributo.

Es el nombre del rol que cumple algún conjunto de valores en un esquema de relación.

```
Ejemplo:
Dado el esquema de relación PERSONA(dni, nombre, apellido), sus atributos son dni, nombre, apellido.
```

## Definir extensión o instancia.

Una instancia representa a un conjunto de valores que toma la base de datos o una relación en un momento dado.

```
Ejemplo:
Dado el esquema de relación PERSONA(dni, nombre, apellido). 
Una posible instancia sería:
{
    (12345678, "nombre1", "apellido1"),
    (23456789, "nombre2", "apellido2"),
    (34567890, "nombre3", "apellido3")
}
```

## Definir tupla.

La tupla o fila es un conjunto de valores pertenecientes a la instancia de una relación, en donde se corresponde un valor para cada atributo.

```
Ejemplo:
Dado el esquema de relación PERSONA(dni, nombre, apellido).
La tupla de una posible instancia sería (12345678, "nombre1", "apellido1").
```

## Definir superclave.

Una superclave es un conjunto de atributos K que define unívocamente a una tupla. Sean e1,e2 tuplas pertenecientes a una relación, entonces vale que e1[K]=e2[K] => e1=e2, es decir, si las claves son iguales en ambas tuplas, entonces las tuplas son iguales.

## Definir clave candidata.

Una clave candidata es una superclave minimal (ningún subconjunto propio de C es superclave).

## Definir clave primaria.

Una clave primaria es una clave candidata que fue elegida para identificar a las tuplas de una relación, y se identifica en el esquema subrayando los atributos correspondientes.

## Comparar superclave, clave candidata, clave primaria

Toda clave primaria es además clave candidata, y toda clave candidata es además superclave. No vale la inversa. La clave primaria es usada en el esquema de una relación para indicar que estos atributos serán utilizados para identificar las distintas tuplas de la instancia. Las claves candidatas que no son claves primarias se llaman claves alternativas, puesto que podrían ser utilizadas para identificar las tuplas (pero no lo son). Cualquier otro conjunto de tuplas que contenga a una clave candidata es una superclave.

## Explicar las pautas de diseño de una base de datos.

Pauta 1 (semántica): asegurarse de que la semántica de los atributos es clara. Explicar los atributos debería ser fácil. Para ello, no deberían combinarse distintas entidades en una misma relación. Por ejemplo, si se tiene el diseño ALUMNO_MATERIA{a_dni, a_nombre, m_nombre, m_comision}, a no es fácil entender el significado. Un mejor diseño sería ALUMNO{a_dni, a_nombre}, MATERIA{m_comision, m_nombre}, CURSA_EN{a_dni, m_comision}.

Pauta 2 (almacenamiento): evitar la redundancia de información para minimizar el espacio de almacenamiento utilizado. Usando el mismo ejemplo anterior, si nombre es un texto con el nombre largo de la materia, y comisión es un número que identifica unívocamente la materia, entonces el primer diseño estaría teniendo un montón de información redundante. Si en una instancia dada hay mil alumnos cursando en (m_comision=52, m_nombre="Base de Datos"), entonces esa información se va a repetir mil veces. En cambio en el segundo diseño sólamente hay una tupla con la información correspondiente en MATERIA, y luego esta se relaciona a través de CURSA_EN.

Pauta 3 (NULLs): evitar que los atributos tomen valores NULL dentro de una relación. Si estos son inevitables, asegurarse de que sean situaciones excepcionales. Siguiendo el ejemplo anterior, un alumno que no está cursando una materia tendría en NULL los campos (m_nombre, m_comision). Asimismo, si se deseab materias que no tienen alumnos también hay un problema, ya que deberían agregarse alumnos con dni y nombre nulos, lo cual violaría la integridad de la clave primaria.

Pauta 4 (tuplas espúreas): las tuplas espúreas representan información inválida. Tuplas espúreas pueden surgir al hacer JOIN como resultado de una mala descomposición. Siguiendo el ejemplo anterior, si en vez de hacer CURSA_EN{a_dni, m_comision} hiciéramos CURSA_EN{a_nombre, m_comision}, el JOIN se podría hacer, pero como nombre no es clave primaria obtendríamos tuplas que no reflejan la información original. Se debe evitar relacionar mediante atributos que no sean una combinación de claves primarias/foráneas.

## Describir las anomalías que puede presentar un diseño.

Anomalía de inserción: anomalía que surge al insertar nueva información. Por ejemplo, con un mal diseño se pueden tener que poner varios atributos en NULL al insertar un nuevo registro. También, si el diseño es malo, hay que asegurarse que la información sea consistente con el resto de los registros. Por ejemplo, si se tiene el diseño ALUMNO_MATERIA{a_dni, a_nombre, m_nombre, m_comision}, y se tienen las siguientes tuplas {(1, "Juan", "Análisis I", 10), (2, "Flor", "Álgebra", 20)}, al insertar a (3, "Pedro"), si no está cursando nada, debemos poner (3, "Pedro", NULL, NULL). Por otro lado, para insertar una nueva materia, se debe insertar (NULL, NULL, "Algoritmos I", 30), lo cual viola la integridad de la PK. También se pueden generar inconsistencias si se realiza la siguiente inserción (3, "Pedro", "Algoritmos I", 10) o (3, "Pedro", "Análisis I", 30).

Anomalía de eliminación: anomalía que surge al eliminar información. Siguiendo el ejemplo anterior, si eliminamos un alumno que es el único cursando una materia, se pierde toda la información relacionada con dicha materia.

Anomalía de actualización: anomalía que surge al actualizar información. Por ejemplo, si en el ejemplo anterior se quiere cambiar el nombre "Análisis I" por "Análisis Matemático I", se deben actualizar todas las tuplas que tengan este valor para no generar inconsistencia, lo cual es costoso en términos de performance.

## Definir dependencia funcional.

La dependencia funcional es una herramienta formal para el análisis de esquemas. Establece una dependencia entre dos conjuntos de atributos X e Y de una Base de Datos. "Y depende de X" se denota X⟹Y, y significa que para cualquier par de tuplas t1, t2, se cumple que t1[X]=t2[X] ⟹ t1[Y]=t2[Y].

Informalmente, la interpretación sería que los valores que pueden tomar los atributos de Y dependen de los valores que tomen los atributos de X.

## ¿Para qué sirve que la normalización? ¿Cómo esta relacionado con la calidad de un diseño de bases de datos? ¿Qué problemas puede presentar una base desnormalizada? Ejemplifique

## ¿Cuando un esquema está en 2FN?

Un esquema está en 2FN cuando está en 1FN (es decir uqe no tiene atributos multivaluados) y todo atributo no primo A de R (es decir, que no pertenece a ninguna CK) depende funcionalmente de manera completa de la PK de R.

## Dar un esquema que esté en 2FN pero no en 3FN. Dar una descomposición del mismo en 3FN.

Un esquema está en 3FN si está en 2FN, y además ningún atributo no primo de R depende transitivamente de la PK.

- **EMPLEADO_DEPARTAMENTO** (es 2FN, pero no es 3FN)
    
```text
    E_NOMBRE | <E_CUIL> | E_FECHA_NACIMIENTO | NRO_DPTO | D_NOMBRE
        ^          v              ^              ^ v         ^
        |          |              |              | |         |
        ^----------v--------------^--------------^ |         |
                                                   |         |
                                                   v---------^
```

- **EMPLEADO**
    
```text
    E_NOMBRE | <E_CUIL> | E_FECHA_NACIMIENTO | NRO_DPTO
        ^          v              ^               ^
        |          |              |               |
        ^----------v--------------^---------------^
```

- **DEPARTAMENTO**
    
```text
    <NRO_DPTO> | D_NOMBRE
       v            ^
       |            |
       v------------^
```


## Definir 2FN.

(de cubawiki)
2FN es una forma normal que, además de ser 1FN (prohíbe relaciones dentro de relaciones, atributos multivaluados), cumple que todo atributo no primo A de R depende funcionalmente de manera completa de la PK de R. Esto es, que la PK es una DF minimal para todos los atributos que no pertenecen a alguna CK.

## Para qué sirve la normalización? Cómo se relaciona con las pautas de diseño de una base de datos? Describir anomalías que puede presentar una base de datos desnormalizada.

(de cubawiki)

La normalización es una herramienta que se apoya en las DFs para evaluar y comparar distintas formas de agrupar atributos en un esquema. Al diseñar una base de datos normalizada siguiendo las formas normales, se busca que el resultado sea conceptualmente bueno (e.g entendible) y también físicamente bueno (e.g minimizar duplicación).

Para esto se siguen cuatro pautas fundamentales, que si bien no siempre pueden alcanzarse al mismo tiempo, dan una medida informal de la calidad del diseño:

```text
(SANE => 
    Semántica: que la semántica sea clara
    Almacenamiento: evitar información redundante
    Nulls: evitar valores NULLs
    tuplas Espúreas: no generar tuplas espúreas
)
```

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

## ¿Qué son las propiedades BASE?

- Basic Availability: garantiza la disponibilidad en términos del teorema CAP.
- Soft-State: el estado puede variar entre distintos nodos, e ir cambiando a través del tiempo aún sin intervención externa.
- Eventual Consistency: asegura que el sistema va a ser consistente eventualmente

## ¿Qué es el teorema CAP?

También llamada conjetura de brewer.

Es un teorema que plantea que una base puede cumplir a lo sumo dos de las siguientes tres condiciones:

- Consistency: cualquier lectura recibe como respuesta la escritura más reciente o un error.
- Availability: cualquier petición recibe una respuesta.
- Partition tolerance: tolerancia a fallos, el sistema sigue funcionando incluso si hay errores en la red.

## ¿Cuáles son las principales bases de datos noSQL, y cómo se relacionan entre sí?

 ==TODO:==

## ¿Qué es una base de datos Key-Value? ¿Cuáles son sus ventajas y desventajas?

==TODO:==

## ¿Qué es una base de datos Column-Family? ¿Cuáles son sus ventajas y desventajas?

Una base de datos column-family es un tipo de base no relacional en donde los datos se almacenan como una colección de pares (columna=>valor).

## ¿Qué es una base de datos Document-Store? ¿Cuáles son sus ventajas y desventajas?

==TODO:==

## ¿Qué es una Graph Database? ¿Cuáles son sus ventajas y desventajas?

==TODO:==

## Dar 2 heuristicas que use el optimizador de consultas. Ejemplifique.

Reordenamiento de joins: esto puede ser aprovechado para reducir el tamaño de resultados temporales. Si se tiene un join y luego un select con una condición muy selectiva, puede llegar a convenir hacer primero el select y luego el join. Por ejemplo, si se tiene una tabla de alumnos muy grande y otra de notas, y se quiere saber la nota de un determinado alumno, hacer primero el join obtendría la nota de cada alumno, para finalmente quedarse sólamente con el alumno específico, mientras que hacer primero el select obtendría primero el alumno, para luego relacionarlo con la nota en cuestión, lo cual resulta mucho menos costoso. También se puede usar esta regla para decidir no reordenar un join, cuando se estima que la condición de selección no es lo suficientemente selectiva. De este modo, se puede aprovechar por ejemplo para utilizar el índice de la tabla.

Estimación de tamaño de los resultados: relacionado con lo anterior, el optimizador de consultas debe poder estimar el tamaño de los resultados de expresiones. Para ello, cuenta con información del catálogo (cantidad de tuplas en una relación, tamaño de las tuplas de una relación, cantidad de tuplas que entran en un bloque de memoria), estadísticas sobre los índices, histogramas sobre la representación de los datos. Para una operación grande, puede incluso estimar el resultado tomando una muestra aleatoria de datos y aplicando la operación. Por ejemplo, para saber el grado de selectividad de una selección sobre una relación con m tuplas, puede tomar una cantidad n << m de muestras, y verificar el grado de selectividad de la selección sobre estas, estimando así el grado de selectividad que tendría m.

Una posible heurística que puede tomar un optimizador heurístico es "aplicar todas las operaciones de selección lo antes posible", sin hacer ningún análisis previo de los datos. Esto evita el overhead ocasionado por el análisis de costo, y por lo general funciona bien.

Otra posible heurística es "realizar las proyecciones lo antes posible", ya que al igual que las selecciones, estas reducen el tamaño de los datos.

Reutilizar planes que se encuentren en caché (a pesar de que el contenido de las relaciones involucradas pueda haber variado, se estima que la variación fue menor).

## Dar dos propiedades del álgebra relacional que se puedan usar para optimizar consultas y ejemplificar.

Una selección en donde la condición es una conjunción σ\<cond_1 ∧ cond_2\>(E) (`SELECT cond_a AND cond_b FROM E`) puede ser descompuesta en dos selecciones anidadas σ\<cond_1\>(σ\<cond_2\>(E)) (`SELECT cond_a from (SELECT cond_b FROM E`)).

Las operaciones de selección son conmutativas, es decir que σ\<cond_1\>(σ\<cond_2\>(E)) es equivalente a σ\<cond_2\>(σ\<cond_1\>(E)).

Los natural join son asociativos. (A⋈B)⋈C = A⋈(B⋈C)

## Definir transacción.

Una transacción es un conjunto de operaciones que se realizan de forma atómica, cumpliendo las propiedades ACID.

## Explicar las propiedades ACID.

Atomicity / Atomicidad: es la propiedad de que las operaciones en una transacción se ejecuten de forma atómica, es decir, como si fuesen una sola operación. Dicho de otro modo, o bien todas las operaciones son aplicadas, o bien ninguna lo es.

Consistency / Consistencia: si la base era consistente antes de iniciar una transacción, esta debe seguir siendo consistente al finalizar la transacción.

Isolation / Aislamiento: distintas transacciones ejecutándose concurrentemente no deben afectar unas a otras. Las transacciones no deberían tener que considerar la posible existencia de otras transacciones.

Durability / Durabilidad: cuando una transacción es commiteada, esta es persistida, y los cambios realizados se van a mantener incluso ante la presencia de una falla posterior.

## Dar un ejemplo de transacciones de algún dominio. ¿Por qué es importante el control de concurrencia?

(de cubawiki)

Una transacción es un conjunto de instrucciones que se ejecutan formando una unidad lógica de procesamiento. Una transacción puede incluir uno o más accesos a la BD a través del uso de diversas operaciones (inserción, eliminación, modificación, etc.).

Diversos sistemas como los bancarios, los de reservas de vuelos o del mercado de valores, usan transacciones para garantizar la consistencia de los datos. Por ejemplo, un sistema bancario que usa una transacción para actualizar dos saldos a causa una transferencia evita la pérdida o creación de dinero en caso de fallas. En este caso, la atomicidad de la transacción garantiza que se ejecuta completo o se deshace por completo.

Este tipo de sistemas requieren rápida respuesta y alta disponibilidad para muchos usuarios que acceden de manera concurrente. En este escenario, un motor de base de datos hace uso de la multiprogramación, intercalando operaciones de distintas transacciones que se ejecutan concurrentemente. El control de concurrencia resulta importante pues queremos evitar que una transacción interfiera con otra: para el usuario, las transacciones se comportan como si se hubieran ejecutado una a continuación de la otra. De no manejar la concurrencia, pueden aparecer distintos problemas como:

- Lost update
- Dirty read
- Incorrect summary
- Unrepeatable read
