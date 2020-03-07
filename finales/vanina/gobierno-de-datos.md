## - ¿Qué es gobierno de datos? Diferencias entre datos, información y conocimiento.

El gobierno de datos involucra el desarrollo y ejecución de arquitecturas, prácticas y procedimientos para administrar adecuadamente los datos dentro de una organización, buscando asegurar la calidad de los mismos, e influyendo en la forma en que se toman las decisiones de negocio, corporativas, de diseño, de gestión.

El gobierno de datos puede tener distintos niveles de madurez:
- totalmente inmaduro, indisciplinado: no existen normas o procedimientos respecto al control de la calidad e integración de los datos, las decisiones de negocio se toman en base a los requerimientos de tecnología, hay alta replicación de datos, que se encuentran en distintas fuentes y formatos.
- reactivo: existen mínimas normas con respecto a la calidad e integración de datos, las decisiones de negocio se ven influenciadas por el producto. Los problemas se enfrentan sólamente luego de que estos ocurran.
- proactivo: los datos pasan a tomar valor para la compañía, los problemas se contemplan antes de que ocurran, el equipo de negocio y tecnología trabajan en colaboración.
- gobernado: las decisiones de tecnología se toman en base a los requerimientos de negocio, los procesos de gestión de datos son estandarizados

Respecto a la diferencia entre datos, información y conocimiento:

```
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

