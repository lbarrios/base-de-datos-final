- Definir transacciones y dar y explicar las propiedades ACID.

- Dada la siguiente relación (idEstudiante, nombreEstudiante, nroCurso, idProfesor). En base a su conocimiento del dominio, detalle cuales son las dependencias funcionales en ese esquema. ¿Está en 3FN? Justifique. En caso de no estarlo dar una descomposición que sea 3FN.

- Defina bases de datos distribuida. Qué nuevos niveles de transparencia aparecen junto a estas bases?

- No me acuerdo exactamente el enunciado, pero era asi: Tenias dos tablas: Estudiantes E: (idEstudiante, nombreEstudiante, idFacultad, fechaNac), Facultad F: (idFacultad, nombreFacultad, region). Un estudiante va a 1 y solo 1 facultad. La tabla Estudiantes tiene 10000 registros de 30 bytes cada uno. La tabla universidad tiene 100 regitros de 20 bytes cada uno. Suponga una base de datos distribuida de 3 nodos N1, N2 y N3 donde N1 tiene la tabla estudiantes, N2 tiene la tabla universidades y N3 no tiene nada.
    1. Expresar en álgebra relacional la consulta: “devolver id de estudiante y nombre de la facultad para los estudiantes que hayan nacido despues de 1980”
    2. Dar dos estrategias de resolución de esta query, indicando cuantos bytes se transfieren por la red entre las maquinas. Por ejemplo “N1 y N2 mandan todo a N3”
    3. Esta no me la acuerdo mucho pero era algo como “de forma general, cual es la estrategia óptima?”

- (Creo que este era exactamente el enunciado, con un 90% de seguridad): Se tienen 4 servidores N1, N2, N3 y N4, y 4 regiones reg1, reg2, reg3, reg4 tal que cada servidor Ni está en la región regi.
    1. Indicar como sería la query en algebra relacional que fragmentaría a la tabla Facultades del insiso anterior para que cada facultad vaya al server de su región (todas las facultades pertenecen a una y solo una de esas 4 regiones) y la query que fragmente a la tabla Estudiantes por la region a la que pertenece su facultad.
    2. Qué tipo de fragmentación utilizó?
    3. Indicar en algebra relacional como sería la query que reconstruya las tablas originales

- Dar 2 heuristicas que use el optimizador de consultas. Ejemplifique.

- ¿Qué es gobierno de datos? Diferencias entre datos, información y conocimiento.

- ¿Qué es una transacción? Describir las propiedades ACID.

- Defina bases de datos distribuida. ¿Qué nuevos niveles de transparencia aparecen junto a estas bases?

- ¿Qué es Data Mining? Describir las distintas técnicas.

- ¿Qué es la interoperabilidad de datos? Describir los dos enfoques que se mencionan en la bibliografía.

- Se tienen los siguientes esquemas:
    E = {IDEstudiante, nombreEstudiante, IDDepartamento, fechaInscripción}
    D = {IDDepartamento, nombreDepartamento, Facultad}
    
    1. Dar las dependencias funcionales que reflejen: i) un estudiante se pudo inscribir a más de un departamento pero no en la misma fecha ii) cada departamento pertenece solo a una facultad.
    2. Suponga una base de datos distribuida de 3 nodos donde N1 tiene a E, N2 tiene a D y en N3 se dispara la consulta "ID de los estudiantes que pertenecen a un departamento de 'FCEyN' junto con el nombre de su Facultad". Asumir que E tiene 10.000 registros de 30B cada uno, D tiene 100 registros de 20B cada uno y el 30% de los estudiantes pertenecen a 'FCEyN'.
        1. Escribir la query en AR
        2. Dar dos estrategias de ejecución para esa query junto con la cantidad de datos que deben transmitirse en cada caso. ¿Cuál es la mejor en términos de transferencia de datos?

- Definir transacciones y dar y explicar las propiedades ACID.

- Tenías tres relaciones y había que dar según conocimiento del dominio las dependencias funcionales y decir en qué FN estaba (idMascota, nombreMascota, nombreDuenio), (idMascota, idDiagnostico, fecha), (idDiagnostico, descripcion, medicamento). (No había una única respuesta).

- Explicar bases NoSQL por documentos, explicando el concepto de documento. Mostrar cómo sería una base por documentos para el ejercicio anterior (no sé si había que hacer el DID, poner los jsons o ambos).

- Dar dos propiedades del álgebra relacional que se puedan usar para optimizar consultas y ejemplificar.

- Defina bases de datos distribuida. ¿Qué nuevos niveles de transparencia aparecen junto a estas bases?

- ¿Qué es fragmentación mixta? Dar un ejemplo, con una query en álgebra relacional para reconstruir las tablas originales

- ¿Cuáles son las dos formas de interrelación de datos? (creo que era integración e intercambio).

- Tenias dos tablas: Estudiantes E: (idEstudiante, nombreEstudiante, idUniversidad, fechaNac), Facultad F: (idFacultad, nombreFacultad). Un estudiante va a 1 y solo 1 facultad. La tabla Estudiantes tiene 10000 registros de 30 bytes cada uno. La tabla universidad tiene 100 registros de 20 bytes cada uno. Suponga una base de datos distribuida de 3 nodos N1, N2 y N3 donde N1 tiene la tabla estudiantes, N2 tiene la tabla facultades y N3 no tiene nada.
    1. Expresar en álgebra relacional la consulta: “devolver id de estudiante y nombre de la facultad para los estudiantes que hayan nacido despues de 1980” (universidad y facultad es lo mismo acá, es sólo para que haya que ponerle condición al join)
    2. Dar dos estrategias de resolución de esta query, indicando cuantos bytes se transfieren por la red entre las maquinas. Por ejemplo “N1 y N2 mandan todo a N3”

- Definir dependencia funcional. Dado {idAlumno, nombreAlumno, idCurso, idProfesor} dar un conjunto de dependencias funcionales. Decir en qué forma normal se encuentra.

- Qué es una transacción? Dar un ejemplo de algún dominio. Por qué es importante el control de concurrencia?

- Explicar bases NoSQL por documentos, explicando el concepto de documento. Qué es un DID? Dar un ejemplo de un sistema de base de datos por documentos.
Definir base de datos distribuida. Explicar nuevos niveles de transparencia.
Explicar fragmentación. Explicar cómo se recupera la tabla original con álgebra relacional.

- Explicar independencia física.

- Dar dos ejemplos de optimizaciones algebraicas. Ejemplificar.

- Diferencia entre administrador de datos y DBA. Relacionar con concepto de independencia física y transparencia.