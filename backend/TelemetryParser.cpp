#include "TelemetryParser.h"
#include "VehicleData.h"

TelemetryParser::TelemetryParser(
    VehicleData *vehicleData,
    QObject *parent
)
    : QObject(parent),
      m_vehicleData(vehicleData)
{
}

void TelemetryParser::parsePacket(
    const QString &packet
)
{
    QStringList fields =
        packet.split(",");

    for (const QString &field : fields)
    {
        QStringList kv =
            field.split("=");

        if (kv.size() != 2)
            continue;

        QString key =
            kv[0].trimmed();

        QString value =
            kv[1].trimmed();

        if (key == "SPD")
            m_vehicleData->setSpeed(
                value.toInt()
            );

        else if (key == "RPM")
            m_vehicleData->setRpm(
                value.toInt()
            );

        else if (key == "BAT")
            m_vehicleData->setBatteryPercent(
                value.toInt()
            );

        else if (key == "RNG")
            m_vehicleData->setRangeKm(
                value.toInt()
            );

        else if (key == "MT")
            m_vehicleData->setMotorTemp(
                value.toInt()
            );

        else if (key == "BT")
            m_vehicleData->setBatteryTemp(
                value.toInt()
            );

        else if (key == "PWR")
            m_vehicleData->setMotorPower(
                value.toFloat()
            );

        else if (key == "MODE")
            m_vehicleData->setDriveMode(
                value
            );

        else if (key == "GEAR")
            m_vehicleData->setGearState(
                value
            );
    }
}