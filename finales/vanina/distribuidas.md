## - Defina bases de datos distribuida. ¿Qué nuevos niveles de transparencia aparecen junto a estas bases?

Una base distribuída está compuesta por múltiples bases de datos que se encuentran lógicamente relacionadas y distribuídas en una red.

Sumado a la independencia entre los datos físicos y lógicos, las bases de datos distribuídas suman nuevos niveles de transparencia:

Organización de los datos: la forma de realizar un tarea no es afectada por la ubicación de los datos, cuando se cuenta con un nombre para un objeto, este se puede acceder bajo ese nombre independientemente de su composición interna, su ubicación, etcétera.

Fragmentación: puede haber fragmentación vertical (de atributos o columnas en distintos nodos), horizontal (de tuplas o registros en distintos nodos) o mixta, y en ninguno de los casos el usuario debería tener en cuenta la existencia de esta fragmentación.

Replicación: el usuario desconoce la existencia de copias de los datos, cualquier cuestión que se derive de tener los datos replicados en varios sitios (por ejemplo, que una escritura debe grabarse en varios nodos al mismo tiempo) debe ser transparente al usuario.

Diseño: el usuario no debería tener conocimiento sobre cómo está diseñada la base distribuída (cantidad o composición de nodos, esquema global, etcétera)

Ejecución: el usuario debería poder realizar una ejecución sin tener que conocer cómo o dónde se va a ejecutar la misma.


## - ¿Qué es fragmentación mixta? Dar un ejemplo, con una query en álgebra relacional para reconstruir las tablas originales

==TODO:==