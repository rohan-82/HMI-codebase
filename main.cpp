#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "backend/VehicleData.h"
#include "backend/TelemetrySimulator.h"
#include "backend/WarningManager.h"
#include "backend/LocalMusicPlayer.h"
#include "backend/TelemetryParser.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    VehicleData vehicleData;
    LocalMusicPlayer musicPlayer;

    TelemetrySimulator simulator(&vehicleData);

    WarningManager warningManager(&vehicleData);

    TelemetryParser parser(
        &vehicleData
    );

    parser.parsePacket(
        "SPD=75,"
        "RPM=3200,"
        "BAT=88,"
        "RNG=160,"
        "MT=45,"
        "BT=35,"
        "PWR=28,"
        "MODE=SPORT,"
        "GEAR=D"
    );

    QTimer::singleShot(
        3000,
        [&]()
        {
            parser.parsePacket(
                "SPD=40,"
                "RPM=1800,"
                "BAT=87,"
                "RNG=159,"
                "MT=44,"
                "BT=34,"
                "MODE=CITY,"
                "GEAR=D"
            );
        }
    );

    QTimer::singleShot(
        6000,
        [&]()
        {
            parser.parsePacket(
                "SPD=90,"
                "RPM=4000,"
                "BAT=86,"
                "RNG=158,"
                "MT=50,"
                "BT=38,"
                "MODE=SPORT,"
                "GEAR=D"
            );
        }
    );

    // CONNECTS GO HERE
    QObject::connect(
    &vehicleData,
    &VehicleData::batteryPercentChanged,
    &warningManager,
    &WarningManager::evaluateWarnings
    );

    QObject::connect(
        &vehicleData,
        &VehicleData::motorTempChanged,
        &warningManager,
        &WarningManager::evaluateWarnings
    );

    QObject::connect(
        &vehicleData,
        &VehicleData::batteryTempChanged,
        &warningManager,
        &WarningManager::evaluateWarnings
    );

    //simulator.start();
    musicPlayer.play();

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty(
        "vehicleData",
        &vehicleData
    );

    engine.rootContext()->setContextProperty(
        "musicPlayer",
        &musicPlayer
    );
    
    #if QT_VERSION >= QT_VERSION_CHECK(6,5,0)
        engine.loadFromModule("EvHmi", "Main");
    #else
        engine.load(QUrl::fromLocalFile(QCoreApplication::applicationDirPath() + "/EvHmi/qml/Main.qml"));
    #endif

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}