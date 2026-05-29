#ifndef WARNINGMANAGER_H
#define WARNINGMANAGER_H

#include <QObject>
#include <QTimer>

class VehicleData;

class WarningManager : public QObject
{
    Q_OBJECT

public:
    explicit WarningManager(
        VehicleData *vehicleData,
        QObject *parent = nullptr);

public slots:
    void evaluateWarnings();

private:
    VehicleData *m_vehicleData;
};

#endif // WARNINGMANAGER_H