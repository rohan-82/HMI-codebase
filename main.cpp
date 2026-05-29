#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "backend/VehicleData.h"
#include "backend/TelemetrySimulator.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    VehicleData vehicleData;

    TelemetrySimulator simulator(&vehicleData);
    simulator.start();

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty(
        "vehicleData",
        &vehicleData
    );

    engine.load(QUrl("qrc:/qml/main.qml"));

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}