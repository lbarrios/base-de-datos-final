# 03. Cálculo Relacional de Tuplas
**Lenguaje de consultas** al igual que Álgebra Relacional

- **Declarativo** (no tiene un orden de evaluación, no es procedural)
- Tiene fundamento en lógica matemática
- SQL tiene fundamentos en CRT


- Notación: `{t | COND(t)}`
    + `t` es una variable de tipo tupla.
        * `t` es la única **variable libre** de la expresión.
    + `COND(t)` es una expresión booleana condicional que afecta a `t`.
    + `COND(t)` es una **fórmula bien formada**
        * Formada por alguno de los siguientes predicados atómicos:
            1. `r ∈ R`
            2. `r.A op s.B`
            3. `r.A op c` o `c op R.a`
            - ...en donde `R` es una relación, `r` y `s` son tuplas, `A` y `B` son atributos, `c` es un valor constante y `op` es un operador de conjunto `{=, <, ≤, >, ≥, ≠}`.
        * Cada predicado atómico tiene un **valor de verdad**:
            1. Si `r` toma el valor de una tupla que pertenece a la relación `R`, el predicado es verdadero.
            2. Si el valor que toman los atributos de `r` y `s` satisfacen la condición, el predicado es verdadero.
            3. Si el valor que toma el atributo de `r` satisface la condición, el resultado es verdadero.
        * Se define recursivamente de la siguiente manera:
            1. Todo predicado atómico es una fórmula.
            2. `(F₁ ∧ F₂)`, `(F₁ ∨ F₂)`, `(¬F₁)` son fórmulas, donde `F₁` y `F₂` son fórmulas.
            3. `(∃r)(F)`. Es una fórmula si `F` es una fórmula en donde la variable de tipo tupla `r` aparece al menos una vez de manera libre. Es verdadera cuando existe un valor de `r` que satisfaga `F`.
            4. `(∀r)(F)`. Es una fórmula si `F` es una fórmula en donde la variable de tipo tupla `r` aparece al menos una vez de manera libre. Es verdadera cuando todos los valores de `r` satisfacen `F`.
    + El resultado es el conjunto de todas las tuplas `t` que satisfacen `COND(t)`.

## Ejemplos

**EMPLEADO**

   dni   | nombre  | salario | depto | supervisor
   --    |  --     |  --     | --   | --
20222333 | Diego   | 20000   | IN   | 33456234 
33456234 | Laura   | 25000   | IN   | 
45432345 | Marina  | 10000   | IN   | 33456234
12323212 | Beatriz | 12000   | RH   | 12323212
34323232 | Pedro   | 17000   | RH   | 
11232123 | María   | 55000   | GG   | 

**DEPARTAMENTO**

idd | detalle
--- | ----------------
IN  | Investigación
RH  | RRHH
GG  | Gerencia General

1. Listar nombre y salario de aquellos empleado que trabajan en el Departamento cuyo detalle es RRHH.
    - `{t | (∃e)(∃d)(e∈EMPLEADO ∧ d∈DEPARTAMENTO ∧ d.detalle='RRHH' ∧ e.depto=d.idd ∧ t.nombre=e.nombre ∧ t.salario=e.salario)}`.
2. Listar nombre, salario y nombre de departamento de aquellos empleados que ganan más de 15000.
    - `{t | (∃e)(e∈EMPLEADO ∧ d∈departamento ∧ e.salario>15000 ∧ e.depto=d.idd ∧ t.nombre=e.nombre ∧ t.salario=e.salario ∧ t.departamento=d.detalle)}`
3. 
    1. Listar el nombre de cada empleado junto al de su supervisor.
        - `{t | (∃e)(∃s)(e∈EMPLEADO ∧ s∈EMPLEADO ∧ e.supervisor=s.dni ∧ t.nombre=e.nombre ∧ t.supervisor=s.nombre}`
    2. Listar el nombre de cada empleado del Departamento de investigación junto al de su supervisor.
        - `{t | (∃e)(∃s)(e∈EMPLEADO ∧ s∈EMPLEADO ∧ e.depto='IN' ∧ e.supervisor=s.dni ∧ t.nombre=e.nombre ∧ t.supervisor=s.nombre}`
4. Listar el nombre de los empleados que trabajan en RRHH o que su supervisor gana más de 15000
    ```text
        {t | (∃e)(e∈EMPLEADO ∧ (
            (e.dpto='RH')
            ∨
            (∃s)(s∈EMPLEADO ∧ e.supervisor=s.dni ∧ s.salario>15000)
        ) ∧ t.nombre=e.nombre)}
    ```
5. Listar los empleados que no tienen supervisor asignado
    - `{t | (∃e)(e∈EMPLEADO ∧ (∀s)(s∈EMPLEADO ⟹ e.supervisor≠s.dni) ∧ t.nombre=e.nombre)}`