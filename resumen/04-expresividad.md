# Expresividad
Es la amplitud de ideas que pueden ser representadas por un lenguaje.

- más expresividad ⟹ más variedad y cantidad de ideas
- equivale a la cantidad de consultas que pueden hacerse

## Comparación CRT vs LPO
CRT es una especialización de LPO.

- Cada relación es la interpretación de un predicado.
- CRT tiene semántica restringida, el modelo es fijo.

## CRT - Expresiones seguras

- **Dominio de expresión** CRT: `dom(E)` es el conjunto de valores:
    1. Constantes en `E`
    2. pertenecientes a cualquier atributo de cualquier tupla de las relaciones mencionadas en E
    + Ejemplo: `dom({t | (t∈EMPLEADO)})` es el conjunto de todos los valores que toman los atributos de todas las tuplas de la relación `EMPLEADO`.
- **Expresión segura**: produce cantidad finitas de resultados.
    + Ejemplo de expresión insegura: `{t | ¬(EMPLEADO)}` produce todo el universo posible de empleados que no forman parte de la relación EMPLEADO.
    + Una expresión es segura si todos los valores en el resultado son **parte del dominio de la expresión**.
- CRT restringido a expresiones seguras es equivalente en poder de expresividad al AR básica.

## Comparación CRT vs AR
Bajo ciertas condiciones, CRT tiene el mismo poder expresivo que Álgebra Relacional.

## CRD - Cálculo Relacional de Dominio
- CRT utiliza tuplas a modo de variables
- CRD utiliza atributos a modo de variables
- CRD tiene el mismo poder de expresividad que CRT

## Propiedades NO expresables
- Existen ciertas propiedades que no pueden ser expresadas en LPO.
    + Ver: Teorema Ehrenfeucht-Fraisse.

==TODO:== Hace falta estudiar el teorema este? Suena al pedo.

## SQL

- La semántica de SQL está basada en AR, por lo que ese es su poder expresivo.
- Hay implementaciones que proveen predicados "extra-lógicos" que permiten mayor expresividad:
    + Recursión
    + Funciones de agregación y agrupamiento
    + Operaciones sobre atributos (ej. aritméticas)
    + Store procedures
    + Etc...

## Bibliografía

- Ehrenfeucht-Fraïssé games, Math Explorers Club, Cornell Department of Mathematics. http://www.math.cornell.edu/~mec/Summer2009/Raluca
- Libkin. Elements of Finite Model Theory. Springer. 2012.
- Expressive Power of SQL. Leonid Libkin: https://homepages.inf.ed.ac.uk/libkin/papers/icdt01.pdf