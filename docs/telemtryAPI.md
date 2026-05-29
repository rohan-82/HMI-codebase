This PDF defines the official telemetry API for our project.

Only use properties listed in the document.

Do not invent new property names.

If a required property is missing, tell me which property should be added to the API instead of creating a new one.

Version: 1.0
Last Updated: <29-05-26>

Property names are considered stable.
Frontend code should not rename or replace them.
New properties must be added to this document before use.

## Purpose

This document defines all telemetry variables exposed by the backend to QML.

Backend developers are responsible for maintaining these properties.

Frontend developers should consume these properties directly from `VehicleData`.

---

# VehicleData Properties

## Core Vehicle Data

|Property|Type|Unit|Description|
|---|---|---|---|
|speed|int|km/h|Current vehicle speed|
|rpm|int|RPM|Motor RPM|
|batteryPercent|int|%|Battery state of charge|
|rangeKm|int|km|Estimated remaining range|

---

## Temperature Data

|Property|Type|Unit|Description|
|---|---|---|---|
|motorTemp|int|°C|Motor temperature|
|batteryTemp|int|°C|Battery temperature|
|controllerTemp|int|°C|Motor controller temperature|

---

## Drive Information

|Property|Type|Unit|Description|
|---|---|---|---|
|driveMode|QString|-|ECO, CITY, SPORT|
|gearState|QString|-|P, N, R, D|

---

## Indicators & Lighting

|Property|Type|Unit|Description|
|---|---|---|---|
|leftIndicator|bool|-|Left turn signal state|
|rightIndicator|bool|-|Right turn signal state|
|hazardLights|bool|-|Hazard light state|
|headlights|bool|-|Headlight state|
|highBeam|bool|-|High beam state|

---

## Charging Data

|Property|Type|Unit|Description|
|---|---|---|---|
|charging|bool|-|Charging status|
|chargingPower|float|kW|Charging power|
|chargeTimeRemaining|int|min|Remaining charging time|

---

## Powertrain Data

|Property|Type|Unit|Description|
|---|---|---|---|
|batteryVoltage|float|V|Battery pack voltage|
|batteryCurrent|float|A|Battery pack current|
|motorPower|float|kW|Current motor output power|
|regenLevel|int|Level|Regenerative braking level|

---

## Trip Information

|Property|Type|Unit|Description|
|---|---|---|---|
|odometer|float|km|Total vehicle distance|
|tripDistance|float|km|Current trip distance|

---

## Warning System

|Property|Type|Unit|Description|
|---|---|---|---|
|warningMessage|QString|-|Active warning message|
|lowBatteryWarning|bool|-|Low battery condition|
|motorOverTempWarning|bool|-|Motor overheating|
|batteryOverTempWarning|bool|-|Battery overheating|
|communicationFault|bool|-|Communication failure detected|

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
    text: vehicleData.motorTemp + "°C"
}

Text {
    text: vehicleData.driveMode
}
```

---

# Data Flow

```text
TelemetrySimulator
        ↓

UARTManager / CANManager
        ↓

TelemetryParser
        ↓

VehicleData
        ↓

QML Dashboard
```

The UI must never communicate directly with UART, CAN, or the simulator.

All vehicle data must pass through VehicleData.