# 02. Álgebra Relacional
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

- Notación: σ<condicion\>(R).
- Genera una **partición horizontal** de la relación.

**EMPLEADO**

| dni | nombre | sexo | salario |
| --- | ------ | ---- | ------- |
| 1   | Diego  | M    | 20000   |
| 2   | Laura  | F    | 25000   |
| 3   | Marina | F    | 10000   |

- σ<sexo=F\>(EMPLEADO)
    
    | dni | nombre | sexo | salario |
    | --- | ------ | ---- | ------- |
    | 2   | Laura  | F    | 25000   |
    | 3   | Marina | F    | 10000   |

- σ<sexo=F AND salario\>15000>(EMPLEADO)
    
    | dni | nombre | sexo | salario |
    | --- | ------ | ---- | ------- |
    | 2   | Laura  | F    | 25000   |

### Propiedades:
- Operador Unario
- Grado(σ(R)) = Grado(R) (misma aridad que la relación)
- \#tuplas: |σ(R)| ≤ |R|
- Conmutatividad: σ₁(σ₂(R)) = σ₂(σ₁(R))
- Cascada: σ₁(σ₂(⋯(σₙ(R))⋯)) = σ<1 and 2 and ⋯ and n\>(R)
- SQL: se especifica en la cláusula **WHERE**, se corresponden:
    + σ<sexo=F AND salario>15000\>(EMPLEADO) 
    + SELECT * FROM EMPLEADO WHERE sexo=F AND salario>15000;

## Project
Selecciona un subconjunto de columnas de una relación
- Notación: π<lista de atributos\>(R)
- Genera una **partición vertical** de la relación.

**EMPLEADO**

| dni | nombre | sexo | salario |
| --- | ------ | ---- | ------- |
| 1   | Diego  | M    | 20000   |
| 2   | Laura  | F    | 25000   |
| 3   | Marina | F    | 10000   |

- π<dni,salario\>(EMPLEADO)

    | dni | salario |
    | --- | ------- |
    | 1   | 20000   |
    | 2   | 25000   |
    | 3   | 10000   |

### Propiedades
- Operador Unario
- Grado(π<lista de atributos\>(R)) = |<lista de atributos>|
- \#tuplas: |π<lista de atributos\>(R)| ≤ |R|
    + Remueve las tuplas duplicadas
    + Conservación de # tuplas: si <lista de atributos> es superclave de R, entonces |π<lista de atributos\>(R)| = |R|
- No es conmutativa.
    + π<lista₁\>(π<lista₁\>(R)) = π<lista1\>(R) ⟹ lista₁ ⊆ lista₂
- SQL: se especifica en la cláusula **SELECT DISTINCT**, se corresponden:
    + π<sexo,salario\>(EMPLEADO)
    + SELECT DISTINCT Sexo,Salario FROM EMPLEADO;

## Rename
Asigna nombre a atributos/relación resultado.

- Notación: ρ<NOMBRE_RESULTADO\>(R) o ρ(A₁→B₁, ⋯, Aₙ→Bₙ, R)

### Ejemplo 1: Relaciones

**EMPLEADO**

| dni | nombre | sexo | salario |
| --- | ------ | ---- | ------- |
| 1   | Diego  | M    | 20000   |
| 2   | Laura  | F    | 25000   |
| 3   | Marina | F    | 10000   |

Son equivalentes:

- π<nombre,sexo\>(σ<salario≥15000\>(empleado))

y

1. ρ<SALARIO_MAYOR\>(σ<salario≥15000\>(EMPLEADO))
    
    **SALARIO_MAYOR**

    | dni | nombre | sexo | salario |
    | --- | ------ | ---- | ------- |
    | 1   | Diego  | M    | 20000   |
    | 2   | Laura  | F    | 25000   |

2. ρ<RESULT\>(π<nombre,sexo\>(SALARIO_MAYOR))
    
    **RESULT**
    
    | nombre | sexo |
    | ------ | ---- |
    | Diego  | M    |
    | Laura  | F    |

### Ejemplo 2: Atributos

**EMPLEADO**

| dni | nombre | sexo | salario |
| --- | ------ | ---- | ------- |
| 1   | Diego  | M    | 20000   |
| 2   | Laura  | F    | 25000   |
| 3   | Marina | F    | 10000   |

- SQL: se especifica en la cláusula **AS**, se corresponden:
    + ρ<EMP(dni→id, salario→ingreso)\>(π<dni,salario\>(EMPLEADO))
        
        | id  | ingreso |
        | --- | ------- |
        | 1   | 20000   |
        | 2   | 25000   |
        | 3   | 10000   |
    + SELECT EMP.dni AS id, EMP.salario as Ingreso FROM EMPLEADO AS EMP

## Union, Intersection, Minus
Equivalente a operaciones matemáticas sobre conjuntos

- Notación: R∪S, R∩S, R−S
- **Sin duplicados**. La relación resultante no contiene duplicados.
- Unión compatible: R(A₁, ⋯, Aₙ) y S(B₁, ⋯, Bₙ) son unión compatibles (o compatibles por tipos) si:
    + Ambas tienen grado n
    + (∀i, 1≤i≤n) tipo(Aᵢ) = tipo(Bᵢ)

**ALUMNOS_BD**

| id | nombre |
| -- | ------ |
| 1  | Diego  |
| 2  | Laura  |
| 3  | Marina |

**ALUMNOS_TLENG**

| id | nombre    |
| -- | ------    |
| 2  | Laura     |
| 4  | Alejandro |

- Union: R∪S, incluye todas las tuplas que están en R, en S, o en ambas a la vez, eliminando duplicados.

    + **ρ<UNION\>(ALUMNOS_BD ∪ ALUMNOS_TLENG)**
    
        **UNION**
        
        | id | nombre    |
        | -- | ------    |
        | 1  | Diego     |
        | 2  | Laura     |
        | 3  | Marina    |
        | 4  | Alejandro |

- Intersection: R∩S, incluye todas las tuplas que están a la vez en R y S.

    + **ρ<INTERSECCION\>(ALUMNOS_BD ∩ ALUMNOS_TLENG)**
    
        **INTERSECCION**
        
        | id | nombre    |
        | -- | ------    |
        | 2  | Laura     |

- Set difference (o minus): R−S, incluye todas las tuplas que están en R, pero no están en S.

    + **ρ<DIFERENCIA\>(ALUMNOS_BD ∩ ALUMNOS_TLENG)**

        **DIFERENCIA**
        
        | id | nombre    |
        | -- | ------    |
        | 1  | Diego     |
        | 3  | Marina    |

- Por convención la relación resultante conserva los nombres de atributo de la primer relación.

- Conmutatividad
    + R∪S = S∪R
    + R∩S = S∩R
    + R−S ≠ S−R (en el caso general)
- Asociatividad
    + R∪(S∪T) = (R∪S)∪T
    + R∩(S∩T) = (R∩S)∩T
- Equivalencia: R∪S = ((R∪S)−(R−S)) − (S−R)

- SQL:
    1. **UNION, INTERSECT, EXCEPT** funcionan como en AR.
    2. **UNION ALL, INTERSECT ALL, EXCEPT ALL** no eliminan duplicados.

## Cartesian Product
Produce una nueva relación que combina cada tupla de una relación con las de la otra relación.

- Notación: R×S

**PERSONA**

nombre|nacionalidad
--|--
Diego|AR
Laura|BR
Marina|AR

**NACIONALIDADES**

idn|detalle
--|--
AR|Argentina
BR|Brasilera
CH|Chilena

- ρ<RESULT>(PERSONA×NACIONALIDADES)

**RESULT**

nombre|nacionalidad|idn|detalle
--|--|--|--
Diego|AR|AR|Argentina
Diego|AR|BR|Brasilera
Diego|AR|CH|Chilena
Laura|BR|AR|Argentina
Laura|BR|BR|Brasilera
Laura|BR|CH|Chilena
Marina|AR|AR|Argentina
Marina|AR|BR|Brasilera
Marina|AR|CH|Chilena

- No hace falta que las relaciones sean UNION COMPATIBLE.
- Grado: T=R×S ⟹ grado(T) = grado(R) + grado(S)
- SQL: **CROSS JOIN**

## Join
Permite combinar pares de tuplas relacionadas

- Notación: R⋈<condicion\>S

**PERSONA**

nombre|nacionalidad
--|--
Diego|AR
Laura|BR
Marina|AR

**NACIONALIDADES**

idn|detalle
--|--
AR|Argentina
BR|Brasilera
CH|Chilena


- ρ<RESULT>(PERSONA⋈<nacionalidad=idn>NACIONALIDADES)

**RESULT**

nombre|nacionalidad|idn|detalle
--|--|--|--
Diego|AR|AR|Argentina
Laura|BR|BR|Brasilera
Marina|AR|AR|Argentina

- Solo aparecen las combinaciones de tuplas que satisfacen la condición
    + <condicion> = <cond1> AND <cond2> and ... and <condN>
    + <condicion> = AᵢθBⱼ con Aᵢ atributo de R y Bⱼ atributo de S
        *  dom(Aᵢ) = dom(Bⱼ)
    +  θ ∈ {=, <, ≤, >, ≥, ≠}
    +  Si los atributos son **NULL** o la condición es falsa no aparecen en el resultado.

- EQUIJOIN: JOIN en donde se utiliza la operación =
    + Duplicación de campos (ej nacionalidad e idn)
        
        **RESULT_EQUIJOIN**

        nombre|nacionalidad|idn|detalle
        --|--|--|--
        Diego|AR|AR|Argentina
        Laura|BR|BR|Brasilera
        Marina|AR|AR|Argentina

- NATURAL JOIN: Deja solo uno de los campos duplicados
    + Notación: R⋈S (también R*S)
    + Los campos del join deben tener el mismo nombre, o hacer un rename previo.

        **RESULT_NATURALJOIN**

        nombre|nacionalidad|detalle
        --|--|--
        Diego|AR|Argentina
        Laura|BR|Brasilera
        Marina|AR|Argentina

- Tamaño resultado JOIN(S,R): puede ir de 0 a S*R registros.
- Selectividad de JOIN(S,R): es una tasa, y corresponde a |JOIN(S,R)|/(|S|*|R|)
- SQL: SELECT persona.nombre, persona.nacionalidad, nacionalidades.detalle from persona, nacionalidades where persona.nacionalidad=nacionalidades.idn;

**PERSONA**

nombre|nacionalidad
--|--
Diego|BR
Laura|NULL
Marina|AR
Santiago|UY

**NACIONALIDADES**

idn|detalle
--|--
AR|Argentina
BR|Brasilera
CH|Chilena
US|Estadounidense


- Inner Join: las tuplas que no cumplen la condición son eliminadas (ej, si el atributo es null)

    **RESULT_INNERJOIN**

    nombre|nacionalidad|idn|detalle
    --|--|--|--
    Diego|BR|BR|Brasilera
    Marina|AR|AR|Argentina

- Outer Join: se incorpora las tuplas de R, S o ambas que no cumplen la condición de JOIN.

    **RESULT_OUTERJOIN**

    nombre|nacionalidad|idn|detalle
    --|--|--|--
    Diego|BR|BR|Brasilera
    Laura|NULL|NULL|NULL
    Marina|AR|AR|Argentina
    Santiago|UY|NULL|NULL
    NULL|NULL|US|Estadounidense

- Left Outer Join: conserva todas las tuplas de R. Si no se encuentra ninguna de S que cumpla con la condición de join, los atributos de S en el resultado se completan con NULL.
    
    **RESULT_LEFTOUTERJOIN**

    nombre|nacionalidad|idn|detalle
    --|--|--|--
    Diego|BR|BR|Brasilera
    Laura|NULL|NULL|NULL
    Marina|AR|AR|Argentina
    Santiago|UY|NULL|NULL

- Right Outer Join: conserva todas las tuplas de S. Si no se encuentra ninguna de R que cumpla con la condición de join, los atributos de R en el resultado se completan con NULL.
    
    **RESULT_RIGHTOUTERJOIN**

    nombre|nacionalidad|idn|detalle
    --|--|--|--
    Diego|BR|BR|Brasilera
    Marina|AR|AR|Argentina
    NULL|NULL|US|Estadounidense

- Full Outer Join: conserva todas las tuplas de R y S. Si no se encuentra ninguna de R o S que cumpla con la condición de JOIN, entonces sus atributos se completan con NULL.

    **RESULT_FULLOUTERJOIN**

    nombre|nacionalidad|idn|detalle
    --|--|--|--
    Diego|BR|BR|Brasilera
    Laura|NULL|NULL|NULL
    Marina|AR|AR|Argentina
    Santiago|UY|NULL|NULL
    NULL|NULL|US|Estadounidense

==TODO: ¿esto es lo mismo que outer join?==

## Division
Retorna los valores de R que están emparejados con todos los valores de S.

- Notación: R÷S.
    + Requiere que atributos(S) ⊂ atributos(R).
    + Resultado contiene atributos(S) − atributos(R).

**ALUMNOS**

nombre|materia
--|--
diego|bd
diego|plp
laura|bd
laura|plp
laura|tleng
marina|bd
marina|tleng
santiago|bd
santiago|plp
santiago|tleng

**MATERIAS_1**

|materia|
|--|
|bd|

**MATERIAS_2**

|materia|
|--|
|bd|
|tleng|

**MATERIAS_3**

|materia|
|--|
|bd|
|plp|
|tleng|

**ALUMNOS÷MATERIAS_1**

|nombre|
|--|
|diego|
|laura|
|marina|
|santiago|

**ALUMNOS÷MATERIAS_2**

|nombre|
|--|
|laura|
|marina|
|santiago|

**ALUMNOS÷MATERIAS_3**

|nombre|
|--|
|laura|
|santiago|

- Operación compuesta: se puede expresar como secuencia de operaciones (π, ×, −). Ejemplo, son equivalentes:
    + ALUMNOS÷MATERIAS_3
    1. ρ<TEMP1\>(π<nombre\>(ALUMNOS))
    2. ρ<TEMP2\>(π<nombre\>((TEMP1×MATERIAS_3)−ALUMNOS))
    3. ρ<RESULT\>(TEMP1−TEMP2)

**TEMP_1**

|nombre|
|--|
|diego|
|laura|
|marina|
|santiago|

**TEMP_2**

|nombre|
|--|
|diego|
|marina|

**TEMP_3**

|nombre|
|--|
|laura|
|santiago|

## Bibliografía
- Capítulo 6 (hasta 6.5 inclusive), Elmasri/Navathe - Fundamentals of Database
Systems, 6th Ed., Pearson, 2011

