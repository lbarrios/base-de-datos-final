## - Definir las operaciones del Álgebra Relacional

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

## - Definir esquema.

Un esquema representa al diseño lógico de la base de datos. Cuando se habla del esquema de una relación, se refiere puntualmente al nombre de dicha relación junto con sus atributos.

```
Ejemplo: 
PERSONA(dni, nombre, apellido)
```

## - Definir atributo.

Es el nombre del rol que cumple algún conjunto de valores en un esquema de relación.

```
Ejemplo:
Dado el esquema de relación PERSONA(dni, nombre, apellido), sus atributos son dni, nombre, apellido.
```

## - Definir extensión o instancia.

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

## - Definir tupla.

La tupla o fila es un conjunto de valores pertenecientes a la instancia de una relación, en donde se corresponde un valor para cada atributo.

```
Ejemplo:
Dado el esquema de relación PERSONA(dni, nombre, apellido).
La tupla de una posible instancia sería (12345678, "nombre1", "apellido1").
```

## - Definir superclave.

Una superclave es un conjunto de atributos K que define unívocamente a una tupla. Sean e1,e2 tuplas pertenecientes a una relación, entonces vale que e1[K]=e2[K] => e1=e2, es decir, si las claves son iguales en ambas tuplas, entonces las tuplas son iguales.

## - Definir clave candidata.

Una clave candidata es una superclave minimal (ningún subconjunto propio de C es superclave).

## - Definir clave primaria.

Una clave primaria es una clave candidata que fue elegida para identificar a las tuplas de una relación, y se identifica en el esquema subrayando los atributos correspondientes.

## - Comparar superclave, clave candidata, clave primaria

Toda clave primaria es además clave candidata, y toda clave candidata es además superclave. No vale la inversa. La clave primaria es usada en el esquema de una relación para indicar que estos atributos serán utilizados para identificar las distintas tuplas de la instancia. Las claves candidatas que no son claves primarias se llaman claves alternativas, puesto que podrían ser utilizadas para identificar las tuplas (pero no lo son). Cualquier otro conjunto de tuplas que contenga a una clave candidata es una superclave.

