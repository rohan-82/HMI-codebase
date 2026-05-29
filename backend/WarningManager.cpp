#include "WarningManager.h"
#include "VehicleData.h"

WarningManager::WarningManager(
    VehicleData *vehicleData,
    QObject *parent)
    : QObject(parent),
      m_vehicleData(vehicleData)
{
}

void WarningManager::evaluateWarnings()
{
    m_vehicleData->setLowBatteryWarning(false);
    m_vehicleData->setMotorOverTempWarning(false);
    m_vehicleData->setBatteryOverTempWarning(false);

    if (m_vehicleData->batteryPercent() < 20)
    {
        m_vehicleData->setLowBatteryWarning(true);
        m_vehicleData->setWarningMessage("Low Battery");
        return;
    }

    if (m_vehicleData->motorTemp() > 55)
    {
        m_vehicleData->setMotorOverTempWarning(true);
        m_vehicleData->setWarningMessage("Motor Temperature High");
        return;
    }

    if (m_vehicleData->batteryTemp() > 60)
    {
        m_vehicleData->setBatteryOverTempWarning(true);
        m_vehicleData->setWarningMessage("Battery Temperature High");
        return;
    }

    m_vehicleData->setWarningMessage("");
}