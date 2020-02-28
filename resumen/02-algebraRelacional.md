# Álgebra Relacional
Conjunto de elementos junto con sus propiedades operacionales determinadas y las propiedades matemáticas que dichas operaciones poseen.

- Lenguaje formal utilizado en el modelo relacional.
- Permite especificar consultas sobre instancias de relaciones.
    + También implementar y optimizar.
- El resultado es una nueva relación.

- Técnica: procedural/axiomática (importa el orden de evaluación)

- Operadores: toman relaciones y devuelven relaciones
    + Unarios
    + Binarios


## Select
Selecciona un subconjunto de tuplas de una relación a través de una condición lógica.

- Notación: σ<condicion>(R).
- Genera una **partición horizontal** de la relación.

**EMPLEADO**
| dni | nombre | sexo | salario |
| --- | ------ | ---- | ------- |
| 1   | Diego  | M    | 20000   |
| 2   | Laura  | F    | 25000   |
| 3   | Marina | F    | 10000   |

- σ<sexo=F>(EMPLEADO)
    | dni | nombre | sexo | salario |
    | --- | ------ | ---- | ------- |
    | 2   | Laura  | F    | 25000   |
    | 3   | Marina | F    | 10000   |

- σ<sexo=F AND salario>15000>(EMPLEADO)
    | dni | nombre | sexo | salario |
    | --- | ------ | ---- | ------- |
    | 2   | Laura  | F    | 25000   |

### Propiedades:
- Operador Unario
- Grado(σ(R)) = Grado(R) (misma aridad que la relación)
- #tuplas: |σ(R)| ≤ |R|
- Conmutatividad: σ₁(σ₂(R)) = σ₂(σ₁(R))
- Cascada: σ₁(σ₂(⋯(σₙ(R))⋯)) = σ<1 and 2 and ⋯ and n>(R)
- SQL: se especifica en la cláusula **WHERE**, se corresponden:
    + σ<sexo=F AND salario>15000>(EMPLEADO) 
    + SELECT * FROM EMPLEADO WHERE sexo=F AND salario>15000;

## Project
Selecciona un subconjunto de columnas de una relación
- Notación: π<lista de atributos>(R)
- Genera una **partición vertical** de la relación.

**EMPLEADO**
| dni | nombre | sexo | salario |
| --- | ------ | ---- | ------- |
| 1   | Diego  | M    | 20000   |
| 2   | Laura  | F    | 25000   |
| 3   | Marina | F    | 10000   |

- π<dni,salario>(EMPLEADO)
    | dni | salario |
    | --- | ------- |
    | 1   | 20000   |
    | 2   | 25000   |
    | 3   | 10000   |

### Propiedades
- Operador Unario
- Grado(π<lista de atributos>(R)) = |<lista de atributos>|
- #tuplas: |π<lista de atributos>(R)| ≤ |R|
    + Remueve las tuplas duplicadas
    + Conservación de # tuplas: si <lista de atributos> es superclave de R, entonces |π<lista de atributos>(R)| = |R|
- No es conmutativa.
    + π<lista₁>(π<lista₁>(R)) = π<lista1>(R) ⟹ lista₁ ⊆ lista₂
- SQL: se especifica en la cláusula **SELECT DISTINCT**, se corresponden:
    + π<sexo,salario>(EMPLEADO)
    + SELECT DISTINCT Sexo,Salario FROM EMPLEADO;