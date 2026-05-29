#include "TelemetrySimulator.h"
#include "VehicleData.h"

#include <QRandomGenerator>

TelemetrySimulator::TelemetrySimulator(VehicleData *vehicleData,
                                       QObject *parent)
    : QObject(parent),
      m_vehicleData(vehicleData),
      m_fakeRpm(1000),
      m_fakeSpeed(0),
      m_fakeBattery(100)
{
    connect(&m_timer,
            &QTimer::timeout,
            this,
            &TelemetrySimulator::generateFakeData);
}

void TelemetrySimulator::start()
{
    m_timer.start(1000);
}

void TelemetrySimulator::generateFakeData()
{
    m_fakeRpm = QRandomGenerator::global()->bounded(1000, 7000);

    m_fakeSpeed = QRandomGenerator::global()->bounded(0, 120);

    m_fakeBattery--;

    if(m_fakeBattery < 0)
        m_fakeBattery = 100;

    m_vehicleData->setRpm(m_fakeRpm);

    m_vehicleData->setSpeed(m_fakeSpeed);

    m_vehicleData->setBatteryPercent(m_fakeBattery);
}