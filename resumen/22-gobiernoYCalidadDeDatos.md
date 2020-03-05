# Gobierno y Calidad de Datos

## Tipos de datos

- Registro
    + Matriz de datos: conjunto de registros con cantidad fija de atributos (tabla)
    + Documentos: vector de términos (atributos)
    + Datos de transacciones: cada registro (transacción) involucra un conjunto de items
- Semi estructurado
    + XML: lenguaje de marcado usado por la WWW
        * Jerárquico, se utiliza mucho para intercambio de información
    + JSON: similar a XML
- Grafos
    + Redes sociales: grafos que conectan personas
- Ordenados
    + Secuenciales: eventos o items con un orden
    + Espacio-temporales: en el tiempo
    + Stream Data: datos que fluyen de forma contínua y masiva
        * Ej: IoT

## Calidad de datos

- Si no se invierte dinero y esfuerzo la calidad de datos es mala
    + Necesario monitorearla
    + El 70% del trabajo de un proyecto de minería de datos se invierte en "acomodar" y "cruzar" datos.

### Análisis de calidad

- Análisis univariado
    + Valor mínimo, máximo
    + Media, mediana, moda, cuartiles, outliers
    + Histograma
    + Tablas de frecuencia
    + Gráficos
- Análisis bivariado
    + Coeficiente de correlación
    + Tablas de contingencia
    + Diagramas de dispersión
    + Etc.
- Perfilado de los datos
    + Verificar si la nueva información es consistente con los datos previamente leídos

## Gobierno de datos

- De acuerdo a la DAMA (Data Management Association), la data resource management (administración de datos) es el "desarrollo y ejecución de arquitecturas, prácticas y procedimientos que manejan adecuadamente las necesidades del ciclo de vida de los datos de una empresa".
    + Calidad
    + Arquitectura
    + Seguridad
    + Metadata
- Es un tema de mucha relevancia

### Madurez del gobierno de datos

```
  ∧                                               | R
V |                                   GOBERNADO   | i
a |                         PROACTIVO             | e
l |                REACTIVO                       | s
o | INDISCIPLINADO                                | g
r |                                               ∨ o
   ----------------------------------------------->
            Persona, procesos y tecnología
```

- Indisciplinado
    + Decisiones de negocio dependientes de la tecnología
    + Datos duplicados e inconsistentes
    + Poca flexibilidad para sostener cambios del negocio
- Reactivo
    + Negocio influye sobre decisiones
    + Información redundante
    + Alto costo para mantener múltiples aplicaciones
- Proactivo
    + Equipos de negocio y tecnología trabajan colaborativamente
    + Datos se ven como un activo de la compañía
- Gobernado
    + Modelos de negocio definen las decisiones tecnológicas
    + Procesos estandarizados para la gestión de datos
    + Decisiones corporativas se toman con datos ciertos
    + Beneficios directos por la aplicación del gobierno

### Roles

- Chief Data Officer: Máximo responsable del gobierno de datos
    + Liderar el equipo
    + Definir o colaborar en la definición sobre el alcance, objetivo, recursos, etc de las iniciativas del programa
    + Promover, negociar y justificar cambios en la estrategia de datos

- Arquitecto de datos
    + Desarrollar la arquitectura de datos para atender requerimientos de negocio
    + Desarrollar estándares y procedimientos de diseño y modelado de datos
    + Supervisar diseño y modelado
    + Aprobar características de desarrollo de aplicaciones e interfaces

- Data owner (de cada dominio): Máxima autoridad de aprobación respecto a los issues de gobierno de datos dentro de su dominio
    + Gestiona el ciclo de vida de datos
    + Gestiona calidad y riesgo dentro de su dominio
    + Colabora en el gobierno de datos corporativo
    + Conoce el significado de los datos

- Data steward: apoyo a los data owners
    + Debe comprender los procesos de negocio como los datos
    + Escribir e implementar reglas de calidad de datos
    + Medir, monitorear, remediar o escalar los problemas
    + Forma parte del flujo de gobierno

- Custodio de datos
    + Pertenece a las áreas de IT responsables de las plataformas, sistemas y aplicaciones
    + Son soporte a los stewards y owners para facilitar entendimiento a bajo nivel
    + Responsabilidad operativa en el flujo de gobierno
        * Integridad y seguridad de datos
        * Cumplimiento de políticas de gobierno
        * Responsabilidad sobre sistemas, aplicaciones, plataformas


## Administración de los datos

```
Datos -------> Información ------> Conocimiento
+ metadata     + asunciones
(definición    + relaciones
formato        + patrones
relevancia)
```

### Administrador de datos
Persona responsable de la administración de datos, perfil funcional.

- Especialista en los "datos" de una organización.
    + No es un DBA. El DBA es especialista en un "motor" de base de datos.

### Tareas del administrador de datos
- Diseño lógico
    + recolectar y analizar requerimientos
    + modelar el negocio basado en requerimientos
    + definir standards, asegurar cumplimiento
    + conducir sesiones de definición de datos
    + manejar y administrar repositorios de metadata y modelado
    + **colaborar con el DBA** en la creación de modelos físicos a partir de los modelos lógicos

- Definición de datos
    + Hay dos lugares donde típicamente se encuentran las definiciones de los datos:
        * En la cabeza de las personas
        * En los modelos de datos
    + Deben coincidir lo más posible
    + Mientras más difieran uno de otro, más vulnerable a la baja calidad de los datos es la empresa

## Privacidad
Preocupación creciente

- Numerosas regulaciones internacionales
- Las organizaciones deben cumplir con las normas locales
    + Unión Europea: nueva ley garantiza la protección de datos para todos los ciudadanos.
    + En Argentina existen numerosos "secretos": estadístico, fiscal, educativo.
        * Dirección nacional de datos personales
        * Agencia de acceso a la información pública
        * Ley de Habeas Data: permite el acceso a la información personal