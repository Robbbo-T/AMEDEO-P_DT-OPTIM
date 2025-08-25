# CA-001-FuselageNoseSection

| Atributo | Valor |
| :--- | :--- |
| **AMPEL** | `AMPEL-01-TUW` |
| **Arquitectura** | `Tube Wing` |
| **Segmento** | `A-AIRFRAMES` |
| **Nombre del Ensamblaje** | Sección 41 del Fuselaje (Morro) |
| **Tipo** | Ensamblaje Constituyente |
| **Integrador Principal** | AMEDEO Aerospace |
| **Estado** | `ACTIVE - PRODUCTION` |

---

## 1.0 Descripción General

Este Ensamblaje Constituyente (CA) define la **Sección 41 (Morro)** de la aeronave. Representa la **estructura física integradora** que aloja un conjunto de sistemas complejos y críticos.

La función de este CA es gestionar la **integración física, funcional y de certificación** de todos los Ítems de Configuración (CIs) que componen la sección del morro. La gestión de las interfaces entre estos CIs es la principal responsabilidad del equipo de este ensamblaje.

## 2.0 Desglose de Ítems de Configuración (CIs)

El `CA-001` está compuesto por seis Ítems de Configuración primarios. Cada CI representa un sistema completo, gestionado a lo largo de su ciclo de vida y, por lo general, suministrado por un proveedor principal.

| ID del CI | Ítem de Configuración | Rol del Proveedor / Integrador |
| :--- | :--- | :--- |
| **`CI-001`** | Estructura Primaria y Secundaria | Proveedor de Aeroestructuras |
| **`CI-002`** | Sistemas de Aviónica Integrados | Integrador de Sistemas de Aviónica |
| **`CI-003`** | Sistema del Tren de Aterrizaje de Nariz | Proveedor de Sistemas de Aterrizaje |
| **`CI-004`** | Sistemas de Control Ambiental (ECS) | Proveedor de Sistemas de Cabina |
| **`CI-005`** | Sistema de Cableado e Interconexión (EWIS)| Proveedor de Sistemas de Potencia |
| **`CI-006`** | Sistemas Hidráulicos y Sensores Externos| Proveedor de Sistemas y Sensores |

## 3.0 Control Maestro de Interfaces

Este CA gestiona las interfaces más críticas entre los Ítems de Configuración:

*   **Interfaces Estructurales:**
    *   Carga entre la **Estructura (`CI-001`)** y el **Tren de Aterrizaje (`CI-003`)**.
    *   Ajuste y sellado de las ventanas en los marcos de la **Estructura (`CI-001`)**.

*   **Interfaces de Sistemas:**
    *   **Eléctricas (EWIS `CI-005`):** Distribución de energía a los CIs **`CI-002`**, **`CI-003`**, **`CI-004`** y **`CI-006`**.
    *   **Datos:** Conexiones de la red de aviónica entre los componentes de **Aviónica (`CI-002`)** y los sensores del **`CI-006`**.
    *   **Mecánicas:** Conexiones hidráulicas desde el **`CI-006`** hacia el actuador del **Tren de Aterrizaje (`CI-003`)**.

## 4.0 Base de Certificación de Nivel Superior

Toda la documentación y evidencia contenida dentro de los CIs de este ensamblaje debe demostrar colectivamente el cumplimiento con la siguiente base de certificación (lista no exhaustiva):

*   **`FAR 25.301`**: Cargas
*   **`FAR 25.365`**: Estructura de Compartimientos Presurizados
*   **`FAR 25.561`**: Aterrizaje de Emergencia
*   **`FAR 25.729`**: Requisitos del Tren de Aterrizaje Retráctil
*   **`FAR 25.775`**: Ventanas y Parabrisas
*   **`FAR 25.841`**: Presurización de Cabina
*   **`FAR 25.1309`**: Equipos, Sistemas e Instalaciones
*   **`FAR 25.1707`**: Sistema de Cableado e Interconexión Eléctrica (EWIS)

## 5.0 Gestión de Configuración y Ciclo de Vida

La configuración de este Ensamblaje Constituyente se define por la línea base de sus Ítems de Configuración, gestionada en el archivo `ca-config.yaml`. Cada CI sigue rigurosamente el **Ciclo de Vida de 11 Fases**, asegurando la trazabilidad completa.

## 6.0 Navegación (Objetos de Vínculo)

La navegación y las relaciones entre este Ensamblaje Constituyente y sus Ítems de Configuración se gestionan a través de los siguientes Objetos de Vínculo (`.lo`), que son elementos formales bajo control de configuración:

*   **CI-001.lo:** Vínculo al Ítem de Configuración de la Estructura Primaria y Secundaria.
*   **CI-002.lo:** Vínculo al Ítem de Configuración de Sistemas de Aviónica Integrados.
*   **CI-003.lo:** Vínculo al Ítem de Configuración del Sistema del Tren de Aterrizaje de Nariz.
*   **CI-004.lo:** Vínculo al Ítem de Configuración de Sistemas de Control Ambiental (ECS).
*   **CI-005.lo:** Vínculo al Ítem de Configuración del Sistema de Cableado e Interconexión (EWIS).
*   **CI-006.lo:** Vínculo al Ítem de Configuración de Sistemas Hidráulicos y Sensores Externos.
