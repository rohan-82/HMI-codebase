#ifndef TELEMETRYSIMULATOR_H
#define TELEMETRYSIMULATOR_H

#include <QObject>
#include <QTimer>
//Forward declaration to avoid unnecessary header inclusion
class VehicleData;

class TelemetrySimulator : public QObject
{
    Q_OBJECT

public:
    explicit TelemetrySimulator(VehicleData *vehicleData,
                                QObject *parent = nullptr);

    void start();

private slots:
    void generateFakeData();

private:
    VehicleData *m_vehicleData;

    QTimer m_timer;

    int m_fakeRpm;
    int m_fakeSpeed;
    int m_fakeBattery;
};

#endif // TELEMETRYSIMULATOR_H