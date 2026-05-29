/*
    VehicleData

    Central telemetry state container for the EV HMI system.

    Responsibilities:
    - Stores live vehicle telemetry values
    - Exposes telemetry properties to QML
    - Emits update signals when values change

    This acts as the bridge between backend systems
    (UART, simulator, parser) and the QML dashboard UI.

    IMPORTANT:
    This class ONLY stores state.
    It should NOT:
    - Generate telemetry
    - Parse UART packets
    - Contain UI logic
*/

#ifndef VEHICLEDATA_H
#define VEHICLEDATA_H

#include <QObject>

class VehicleData : public QObject
{   
    // Enables Qt signal-slot and property system
    Q_OBJECT
    //Bridge between C++ and QML, properties for rpm, speed, and battery percentage
    Q_PROPERTY(int rpm READ rpm WRITE setRpm NOTIFY rpmChanged)
    Q_PROPERTY(int speed READ speed WRITE setSpeed NOTIFY speedChanged)
    Q_PROPERTY(int batteryPercent READ batteryPercent WRITE setBatteryPercent NOTIFY batteryPercentChanged)

public:
    explicit VehicleData(QObject *parent = nullptr);

    int rpm() const;
    int speed() const;
    int batteryPercent() const;

    void setRpm(int rpm);
    void setSpeed(int speed);
    void setBatteryPercent(int batteryPercent);

signals: //Notify QML when properties change
    void rpmChanged();
    void speedChanged();
    void batteryPercentChanged();

private:
    int m_rpm;
    int m_speed;
    int m_batteryPercent;
};

#endif // VEHICLEDATA_H