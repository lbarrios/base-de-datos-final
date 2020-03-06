# 20. Integración de Datos

- Aplicaciones necesitan acceder a datos en lugares
    + Diferentes **sitios físicos**
    + Diferentes **sitios lógicos** (formatos)

- Modelo para **interoperabilidad de datos**: mapeos de esquema
    + Integración de datos
    + Intercambio de datos

## Integración de Datos (Data Integration - Data Federation)
- Se consultan datos **heterogéneos** de diferentes fuentes via un **esquema virtual global**.

```text
           ∑₁
|DB1| S₁<------
           ∑₂  \
|DB2| S₂<------ --- |T| <- CONSULTA
           ∑₃  /
|DB3| S₃<-----

- Sᵢ: fuentes
- T: esquema global
- ∑ᵢ(T->Sᵢ): mapeos
```

- Los datos nunca están en T.
    + T sólamente convierte la consulta para que distintas fuentes la puedan procesar.

## Intercambio de Datos (Data Exchange - Data Translation)
Se **transforman** datos estructurados bajo un esquema **origen en datos** estructurados bajo un **esquema destino**.

```text
        ∑
  S ----------> T
|DBₛ| - - - > |DBₜ|
```

## Schema Mappings
Son piezas fundamentales para la formalización y el estudio de interoperabilidad de datos

- Aserciones en alto nivel que especifican la relación entre dos esquemas
- Separación del diseño de la relación entre esquemas y su implementación
    + Fáciles de generar y manejar (semi)automáticamente
    + Compilados en scripts SQL/XSLT

```text
         ∑
  S ----------> T
|DBₛ| - - - > |DBₜ|

Mapeo M = (S, T, ∑)
```

### Lenguaje de mapeo de esquemas

- Usando **lógica de Primer Orden (LPO)**

- **Copiado (nicknaming)**: copiar tabla origen a tabla destino y renombrarla
    + (∀X₁,⋯,Xₙ)(P(X₁,⋯,Xₙ) ⟹ R(X₁,⋯,Xₙ))
- **Proyección (borrado de columna)**: borrar columnas de tabla origen para formar una tabla destino
    + (∀X,Y,Z)(P(X,Y,Z) ⟹ R(X,Y))
- **Incorporación de columna**: sumar columnas a tabla origen para formar una tabla destino
    + (∀X,Y)(P(X,Y) ⟹ (∃Z)(R(X,Y,Z)))
- **Descomposición**: descomponer tabla origen en una o más tablas destino
    + (∀X,Y,Z)(P(X,Y,Z) ⟹ R(X,Y) ∧ T(X,Z))
- **Join**: hacer join entre dos o más tablas origen para formar tabla destino
    + (∀X,Y,Z)(E(X,Y) ∧ F(X,Z) ⟹ R(X,Y,Z))
- **Combinaciones** de lo anterior

### Tuple-Generating Dependencies (TGD)
Restricciones que se refieren a la necesidad de que **existan tuplas** cuando se cumple una condición de disparo.

- Parte de la LPO, clase importante de restricciones.
    + Poder expresivo
    + Propiedades algorítmicas

- Forma general `∀X ϕ(X) ⟹ ∃Y ψ(X,Y)`
    + X e Y son **vectores de variables**
    + ϕ y ψ son **conjunciones de fórmulas atómicas**

- Subclases conocidas
    + Dependencias de inclusión (ej claves foráneas)
    + Dependencias multivaluadas

#### Source-to-Target TGDs

- Forma: `∀X ϕ(X) ⟹ ∃Y ψ(X,Y)`
    + ϕ es una conjunción de átomos sobre esquema origen
    + ψ es conjunción de átomos sobre esquema destino
- Ejemplos:
    + ∀E ∀C estudiante(E) ∧ anotado(E,C) ⟹ ∃N nota(E,C,N)
    + ∀E ∀C estudiante(E) ∧ anotado(E,C) ⟹ ∃N ∃P profesor(P,C) ∧ nota(E,C,N)

- Generalizan a dos tipos de restricciones
    + Local as view: origen -> ...
    + Global as view: ... -> destino

- Se las conoce también como restricciones GLAV (Global-and-Local-as-View)

## Soluciones Universales
Solución J para I es universal si existen homomorfismos de J a todas las posibles soluciones de I.

- Dos instancias son homomórficamente equivalentes si existe un homomorfismo I⟹J y otro J⟹I.

## Chase
Procedimiento para reparar una BD en relación a un conjunto de dependencias (TGDs)

- Una TGD σ es aplicable a una BD D si body(σ) mapea a átomos en D
- La aplicación de σ sobre D agrega un átomo con nulos "frescos" correspondientes a cada una de las variables cuantificadas en head(σ).
- El procedimiento de chase produce una solución universal.

## Solución universal mínima
Dada una instancia J, la subinstancia J' más pequeña homomórficamente equivalente a J se denomina el core de J.

- Toda estructura relacional finita tiene un core.
- El core es único, módulo isomorfismo.


- J' es core de J si:
    + J'⊆J
    + ∃ homomorfismo h: J⟹J'
    + ∄ homomorfismo g: J⟹J'' con J''⊂J

- Decidir si un conjunto es el core de una instancia es NP-hard.

## Consultas en intercambio de datos

- Certains Answers: semántica de la respuesta a consultas sobre el esquema destino.
- Se opera sobre mundo abierto: lo que podemos probar/inferir es verdadero, lo que no podemos no necesariamente es falso
    + Mundo cerrado: sólo sabemos qué es verdadero, el resto es falso

### Cómputo de certain answers

- Computar solución universal (via chase)
- Evaluar la consulta y descartar toda tupla que contenga nulls (no pueden ser parte del resultado)
- Certain answers coincide con hacer la consulta sobre el core.
    + certain(Q,I) = Q(J) donde J es el core de I
