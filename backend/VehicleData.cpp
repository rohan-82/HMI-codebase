#include "VehicleData.h"

//constructor initializes telemetry values to defaults
VehicleData::VehicleData(QObject *parent)
    : QObject(parent),
      m_rpm(0),
      m_speed(0),
      m_batteryPercent(100)
{
}
//Getters for telemetry properties
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

void VehicleData::setRpm(int rpm)
{
    //if value unchanged, don't update UI unnecessarily
    if (m_rpm == rpm)
        return;
    //update value and notify QML
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