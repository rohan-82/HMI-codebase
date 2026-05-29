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
    if (m_vehicleData->batteryPercent() < 20)
    {
        m_vehicleData->setWarningMessage(
            "Low Battery");

        return;
    }

    if (m_vehicleData->motorTemp() > 55)
    {
        m_vehicleData->setWarningMessage(
            "Motor Temperature High");

        return;
    }

    if (m_vehicleData->batteryTemp() > 60)
    {
        m_vehicleData->setWarningMessage(
            "Battery Temperature High");

        return;
    }

    m_vehicleData->setWarningMessage("");
}