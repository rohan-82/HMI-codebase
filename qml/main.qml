import QtQuick
import QtQuick.Window

Window {
    visible: true

    width: 800
    height: 480

    title: "EV HMI"

    Column {
        anchors.centerIn: parent
        spacing: 10

        Text {
            text: "Speed: " + vehicleData.speed
        }

        Text {
            text: "RPM: " + vehicleData.rpm
        }

        Text {
            text: "Battery: " + vehicleData.batteryPercent + "%"
        }

        Text {
            text: "Motor Temp: " + vehicleData.motorTemp + "°C"
        }

        Text {
            text: "Mode: " + vehicleData.driveMode
        }
    }
}