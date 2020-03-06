# 24. Data Mining
Extracción de patrones o información interesante de grandes bases de datos.

## Descubrimiento del conocimiento (KDD Process)

- Data mining es el core del proceso de descubrimiento del conocimiento.

```text
DATABASES
   \
    ---------> data warehouse
    data cleaning       \
                         -----> task-relevant data
                     Selection       \
                                      --------> Pattern evaluation
                                   Data mining       \
                                                      ------> Knowledge
```

## Funcionalidades del Data Mining

- Descripción de conceptos: Generalizar, resumir y contrastar las características de la información
    + Caracterización
    + Discriminación

- Asociación: buscar correlación, Causalidad
    + Multi-dimensionales
    + Uni-dimensionales

- Clasificación y predicción: encontrar modelos que describan clases para futuras predicciones
    + Árboles de decisión
    + Reglas de clasificación
    + Redes neuronales

- Cluster análisis: agrupar datos para formar clases
    + Maximizar similtud dentro de la clase
    + Minimizar similtud entre distintas clases

- Análisis de outliers: datos que no respetan el comportamiento general
    + Ruido
    + Excepciones
    + Fraude
    + Eventos raros

- Análisis de tendencias y evolución
    + Análisis de regresión
    + Patrones secuenciales
    + Similitudes

- Otro tipo de análisis estadísticos

## Supervisada: Redes Neuronales
Sistemas capaces de enfrentar problemas que sólo podían ser resueltos por el cerebro humano.

- Capacidades:
    + Aprender
    + Adaptarse a nuevas condiciones
    + Adaptarse al ruido
    + Predecir el estado futuro

- No son algorítmicas
    + No se programan mediante una secuencia de instrucciones
    + Generan ellas mismas sus propias "reglas" para asociar salida y entrada
    + Aprenden mediante ejemplos
    + Aprenden mediante sus propios errores
    + Utilizan procesamiento paralelo

- Pueden ser combinadas con otras herramientas para mejorar performance
    + Lógica Difusa
    + Algoritmos Genéticos
    + Sistemas Expertos
    + Estadísticas
    + Transformadas de Fourier
    + Wavelets

- Aplicaciones: los mismos problemas que puede resolver el ser humano, pero a gran escala
    + Asociación
    + Evaluación
    + Reconocimiento de patrones
    + No se requieren respuestas perfectas, sino rápidas y buenas
    + Ejemplo:
        * Escenario bursátil: inversiones, comprar, vender, mantener
        * Reconocimiento: comparar objetos, se parecen, son el mismo, está modificado

- Fallas: no son buenas para
    + Cálculos precisos
    + Procesamiento en serie
    + Reconocer cosas que no tengan patrones inherentes

- Tipos de redes más utilizados
    + Perceptrón multicapa
    + Hopfield (mapas asociativos)
    + Kohonen (autoorganizativos)

## Supervisada: Árboles de decisión

- Los nodos internos son preguntas sobre los atributos
- Las hojas representan respuestas (etiquetas o clases)

- Generación, fundamentalmente dos pasos
    + Construcción
        * Todos los ejemplos están en la raíz al principio
        * Se dividen de forma recursiva basados en atributos
    + Prunning
        * Remover ramas que representen outliers

- Uso de árboles de decisión
    + Clasificación de ejemplo desconocido

- Es posible extraer reglas de clasificación (IF-THEN) a partir de árboles

- Es necesario evitar el overfitting
    + Si hay demasiadas ramas se tiene mala performance en nuevos ejemplos
    + Preprunning: no partir un nodo si la mejora que esto produce está debajo de cierto umbral
        * Difícil encontrar el umbral
    + Postprunning: podar el árbol una vez construído
        * Usando un conjunto diferente al de entrenamiento

- En cada paso de la clasificación se usan datos distintos
    + Construcción: training data
    + Evaluación del modelo: testing data

## Supervisada: Regresión lineal
Se genera un modelo de regresión lineal.

- La relación entre variables es lineal
- Erorres son independientes
- Errores tienen varianza constante
- Errores tienen esperanza igual a cero
- Error total es la suma de los errores

- Tipos de regresión lineal
    + Simple: sólo se maneja una variable independiente
    + Múltiple: maneja varias variables independientes

- Regresión logística: cuando la variable es dicotómica o politómica (no numérica)
    + Se asocia la variable dependiente a su probabilidad de ocurrencia
    + El resultado es la probabilidad de ocurrencia del suceso

### Clasificación bayesiana

- Aprendizaje probabilístico: se calcula explícitamente la probabilidad de la hipótesis
- Incremental: cada ejemplo de entrenamiento aumenta o disminuye la probabilidad de la hipótesis
- Predicción: se pueden efectuar predicciones, ponderadas por su probabilidad
- El problema de clasificación puede generalizarse a usar bayes a posteriori

## No supervisada: Clústering
Colección de objetos

- Función de distancia
    + Similares dentro del cluster
    + Diferentes con otros clusters

- **No supervisada: no hay clases predefinidas**

- Aplicaciones típicas
    + Como herramienta para tener idea de la distribución de datos
    + Como proceso previo a usar otros métodos

- Clustering jerárquico
    + Usa matriz de distancia como criterio
    + No requiere cantidad de clusters como parámetro de input
- Clustering no jerárquico
    + Construir una partición de n objetos en k clusters
    + Requiere especificar cantidad de clusters como parámetro de input (arbitrario)
    + Requiere establecer una semilla inicial

## No supervisada: reglas de asociación

- Generar reglas del tipo `IF condicion THEN resultado`

- Tipos de reglas
    + Útiles: contienen buena calidad de información
    + Triviales: ya conocidas en el negocio
    + Inexplicables: curiosidades arbitrarias sin aplicación práctica

- Medidas de calidad de una regla
    + Soporte: cantidad de transacciones en donde se encuentra
        * Condición y resultado
    + Confianza: Cantidad de transacciones que contienen la cláusula condicional
        * Condición
    + Lift (improvement): capacidad predictiva de la regla
        * Si es mayor a 1, la regla tiene valor predictivo

- Tipos de reglas
    + Booleanas vs cuantitativas
    + Una dimensión vs varias dimensiones
    + Con jerarquía de elementos (taxonomías) vs elementos simples
