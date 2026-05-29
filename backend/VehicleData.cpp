#include "VehicleData.h"

// VehicleData class implementation
VehicleData::VehicleData(QObject *parent)
    : QObject(parent),
      m_rpm(0),
      m_speed(0),
      m_batteryPercent(100),
      m_motorTemp(35),
      m_batteryTemp(30),
      m_rangeKm(180),
      m_driveMode("ECO")
{
}

int VehicleData::rpm() const
{
    return m_rpm;
}

int VehicleData::speed() const
{
    return m_speed;
}

int VehicleData::batteryPercent() const
{
    return m_batteryPercent;
}

int VehicleData::motorTemp() const
{
    return m_motorTemp;
}

int VehicleData::batteryTemp() const
{
    return m_batteryTemp;
}

int VehicleData::rangeKm() const
{
    return m_rangeKm;
}

QString VehicleData::driveMode() const
{
    return m_driveMode;
}

void VehicleData::setRpm(int rpm)
{
    // Only update if the value has changed to avoid unnecessary signals
    if (m_rpm == rpm)
        return;
    // Update the RPM value and emit the signal
    m_rpm = rpm;
    emit rpmChanged();
}

void VehicleData::setSpeed(int speed)
{
    if (m_speed == speed)
        return;

    m_speed = speed;
    emit speedChanged();
}

void VehicleData::setBatteryPercent(int batteryPercent)
{
    if (m_batteryPercent == batteryPercent)
        return;

    m_batteryPercent = batteryPercent;
    emit batteryPercentChanged();
}

void VehicleData::setMotorTemp(int motorTemp)
{
    if (m_motorTemp == motorTemp)
        return;

    m_motorTemp = motorTemp;
    emit motorTempChanged();
}

void VehicleData::setBatteryTemp(int batteryTemp)
{
    if (m_batteryTemp == batteryTemp)
        return;

    m_batteryTemp = batteryTemp;
    emit batteryTempChanged();
}

void VehicleData::setRangeKm(int rangeKm)
{
    if (m_rangeKm == rangeKm)
        return;

    m_rangeKm = rangeKm;
    emit rangeKmChanged();
}

void VehicleData::setDriveMode(const QString &driveMode)
{
    if (m_driveMode == driveMode)
        return;

    m_driveMode = driveMode;
    emit driveModeChanged();
}