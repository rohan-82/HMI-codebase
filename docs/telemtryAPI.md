# Telemetry API Contract

## Purpose

This document defines all telemetry variables exposed by the backend to QML.

Backend developers are responsible for maintaining these properties.

Frontend developers should consume these properties directly from `VehicleData`.

---

# VehicleData Properties

## Core Vehicle Data

| Property | Type | Unit | Description |
|-----------|------|------|-------------|
| speed | int | km/h | Current vehicle speed |
| rpm | int | RPM | Motor RPM |
| batteryPercent | int | % | Battery state of charge |
| rangeKm | int | km | Estimated remaining range |

---

## Temperature Data

| Property | Type | Unit | Description |
|-----------|------|------|-------------|
| motorTemp | int | °C | Motor temperature |
| batteryTemp | int | °C | Battery temperature |
| controllerTemp | int | °C | Motor controller temperature |

---

## Drive Information

| Property | Type | Unit | Description |
|-----------|------|------|-------------|
| driveMode | QString | - | ECO, CITY, SPORT |
| gearState | QString | - | P, R, N, D |

---

## Indicators & Lighting

| Property | Type | Unit | Description |
|-----------|------|------|-------------|
| leftIndicator | bool | - | Left turn signal state |
| rightIndicator | bool | - | Right turn signal state |
| hazardLights | bool | - | Hazard lights active |
| headlights | bool | - | Headlights enabled |
| highBeam | bool | - | High beam enabled |

---

## Charging Data

| Property | Type | Unit | Description |
|-----------|------|------|-------------|
| charging | bool | - | Vehicle charging state |
| chargingPower | float | kW | Charging power |
| chargeTimeRemaining | int | min | Remaining charging time |

---

## Powertrain Data

| Property | Type | Unit | Description |
|-----------|------|------|-------------|
| batteryVoltage | float | V | Battery pack voltage |
| batteryCurrent | float | A | Battery pack current |
| motorPower | float | kW | Current motor output power |
| regenLevel | int | Level | Regenerative braking level |

---

## Trip Information

| Property | Type | Unit | Description |
|-----------|------|------|-------------|
| odometer | float | km | Total lifetime distance |
| tripDistance | float | km | Current trip distance |

---

## Warning System

| Property | Type | Unit | Description |
|-----------|------|------|-------------|
| warningMessage | QString | - | Active warning text |
| lowBatteryWarning | bool | - | Low battery detected |
| motorOverTempWarning | bool | - | Motor temperature exceeded threshold |
| batteryOverTempWarning | bool | - | Battery temperature exceeded threshold |
| communicationFault | bool | - | Communication failure detected |

---

# Signals

## Telemetry Updates

| Signal | Description |
|----------|-------------|
| telemetryChanged() | Emitted whenever telemetry data changes |

---

# Example QML Usage

```qml
Text {
    text: vehicleData.speed + " km/h"
}

Text {
    text: vehicleData.batteryPercent + "%"
}

Text {
    text: vehicleData.motorTemp + " °C"
}

Text {
    text: vehicleData.driveMode
}

Rectangle {
    visible: vehicleData.leftIndicator
}

Text {
    text: vehicleData.odometer.toFixed(1) + " km"
}
```

---

# Data Flow

```text
TelemetrySimulator
        ↓

UARTDataSource
        ↓

TelemetryParser
        ↓

VehicleData
        ↓

WarningManager
        ↓

QML Dashboard
```

---

# Architecture Rules

1. QML must only read/write data through `VehicleData`.

2. QML must never directly access:
   - UART
   - Serial ports
   - CAN bus
   - Telemetry parser
   - Simulator

3. `VehicleData` acts as the single source of truth for the dashboard.

4. `TelemetrySimulator` is used during development when hardware is unavailable.

5. When STM32 integration begins, the simulator should be replaced by `UARTDataSource` without requiring changes to the QML layer.

---

# Current Integration Status

## Implemented

- speed
- rpm
- batteryPercent
- rangeKm
- motorTemp
- batteryTemp
- driveMode
- gearState
- leftIndicator
- rightIndicator
- hazardLights
- headlights
- highBeam
- motorPower
- regenLevel
- odometer
- tripDistance
- warningMessage
- lowBatteryWarning
- motorOverTempWarning
- batteryOverTempWarning
- communicationFault

## Planned

- controllerTemp
- charging
- chargingPower
- chargeTimeRemaining
- batteryVoltage
- batteryCurrent
- UARTDataSource
- STM32 integration