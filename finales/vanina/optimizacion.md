## - Dar 2 heuristicas que use el optimizador de consultas. Ejemplifique.

Reordenamiento de joins: esto puede ser aprovechado para reducir el tamaño de resultados temporales. Si se tiene un join y luego un select con una condición muy selectiva, puede llegar a convenir hacer primero el select y luego el join. Por ejemplo, si se tiene una tabla de alumnos muy grande y otra de notas, y se quiere saber la nota de un determinado alumno, hacer primero el join obtendría la nota de cada alumno, para finalmente quedarse sólamente con el alumno específico, mientras que hacer primero el select obtendría primero el alumno, para luego relacionarlo con la nota en cuestión, lo cual resulta mucho menos costoso. También se puede usar esta regla para decidir no reordenar un join, cuando se estima que la condición de selección no es lo suficientemente selectiva. De este modo, se puede aprovechar por ejemplo para utilizar el índice de la tabla.

Estimación de tamaño de los resultados: relacionado con lo anterior, el optimizador de consultas debe poder estimar el tamaño de los resultados de expresiones. Para ello, cuenta con información del catálogo (cantidad de tuplas en una relación, tamaño de las tuplas de una relación, cantidad de tuplas que entran en un bloque de memoria), estadísticas sobre los índices, histogramas sobre la representación de los datos. Para una operación grande, puede incluso estimar el resultado tomando una muestra aleatoria de datos y aplicando la operación. Por ejemplo, para saber el grado de selectividad de una selección sobre una relación con m tuplas, puede tomar una cantidad n << m de muestras, y verificar el grado de selectividad de la selección sobre estas, estimando así el grado de selectividad que tendría m.

Una posible heurística que puede tomar un optimizador heurístico es "aplicar todas las operaciones de selección lo antes posible", sin hacer ningún análisis previo de los datos. Esto evita el overhead ocasionado por el análisis de costo, y por lo general funciona bien.

Otra posible heurística es "realizar las proyecciones lo antes posible", ya que al igual que las selecciones, estas reducen el tamaño de los datos.

Reutilizar planes que se encuentren en caché (a pesar de que el contenido de las relaciones involucradas pueda haber variado, se estima que la variación fue menor).

## - Dar dos propiedades del álgebra relacional que se puedan usar para optimizar consultas y ejemplificar.

Una selección en donde la condición es una conjunción σ\<cond_1 ∧ cond_2\>(E) (`SELECT cond_a AND cond_b FROM E`) puede ser descompuesta en dos selecciones anidadas σ\<cond_1\>(σ\<cond_2\>(E)) (`SELECT cond_a from (SELECT cond_b FROM E`)).

Las operaciones de selección son conmutativas, es decir que σ\<cond_1\>(σ\<cond_2\>(E)) es equivalente a σ\<cond_2\>(σ\<cond_1\>(E)).

Los natural join son asociativos. (A⋈B)⋈C = A⋈(B⋈C)

