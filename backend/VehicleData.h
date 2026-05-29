// Storing state variables for the vehicle and providing a way to update them from the simulator

#ifndef VEHICLEDATA_H
#define VEHICLEDATA_H

#include <QObject>
#include <QString>

class VehicleData : public QObject
{
    Q_OBJECT // Define properties for the vehicle data that can be accessed and modified from QML
    /*
    Property Name  : speed
    Getter         : speed()
    Setter         : setSpeed()
    Signal         : speedChanged()
    */
    Q_PROPERTY(int rpm READ rpm WRITE setRpm NOTIFY rpmChanged)
    Q_PROPERTY(int speed READ speed WRITE setSpeed NOTIFY speedChanged)
    Q_PROPERTY(int batteryPercent READ batteryPercent WRITE setBatteryPercent NOTIFY batteryPercentChanged)

    Q_PROPERTY(int motorTemp READ motorTemp WRITE setMotorTemp NOTIFY motorTempChanged)
    Q_PROPERTY(int batteryTemp READ batteryTemp WRITE setBatteryTemp NOTIFY batteryTempChanged)

    Q_PROPERTY(int rangeKm READ rangeKm WRITE setRangeKm NOTIFY rangeKmChanged)

    Q_PROPERTY(QString driveMode READ driveMode WRITE setDriveMode NOTIFY driveModeChanged)

public:
    explicit VehicleData(QObject *parent = nullptr);
    // Getter functions
    int rpm() const;
    int speed() const;
    int batteryPercent() const;

    int motorTemp() const;
    int batteryTemp() const;

    int rangeKm() const;

    QString driveMode() const;
    // Setter functions
    /*
    Receive new value
    Store value
    Notify UI
    */
    void setRpm(int rpm);
    void setSpeed(int speed);
    void setBatteryPercent(int batteryPercent);

    void setMotorTemp(int motorTemp);
    void setBatteryTemp(int batteryTemp);

    void setRangeKm(int rangeKm);

    void setDriveMode(const QString &driveMode);

signals:
    // Signals to notify the UI when a value changes
    void rpmChanged();
    void speedChanged();
    void batteryPercentChanged();

    void motorTempChanged();
    void batteryTempChanged();

    void rangeKmChanged();

    void driveModeChanged();

private:
    // Member variables to store the current state of the vehicle
    int m_rpm;
    int m_speed;
    int m_batteryPercent;

    int m_motorTemp;
    int m_batteryTemp;

    int m_rangeKm;

    QString m_driveMode;
};

#endif