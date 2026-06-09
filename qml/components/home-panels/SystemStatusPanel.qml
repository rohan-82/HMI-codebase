import QtQuick
import EvHmi

BaseCard {
    id: root

    title: "SYSTEM STATUS"

    Column {
        anchors.centerIn: parent

        width: parent.width * 0.85

        spacing: 10 * Theme.scale

        Repeater {
            model: [
                {
                    label: "Battery",
                    ok: vehicleData.batterySystemOk
                },
                {
                    label: "Motor",
                    ok: vehicleData.motorSystemOk
                },
                {
                    label: "Controller",
                    ok: vehicleData.controllerSystemOk
                },
                {
                    label: "Tires",
                    ok: vehicleData.tireSystemOk
                }
            ]

            Item {
                width: parent.width
                height: 22 * Theme.scale

                Text {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter

                    text: modelData.label

                    color: Colors.textSecondary

                    font.family: Typography.family
                    font.pixelSize: Typography.bodySmall
                }

                Row {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter

                    spacing: 8 * Theme.scale

                    Rectangle {
                        width: 8 * Theme.scale
                        height: width

                        radius: width / 2

                        color: modelData.ok
                               ? Colors.accentEco
                               : Colors.critical
                    }

                    Text {
                        text: modelData.ok
                              ? "OK"
                              : "FAULT"

                        color: Colors.textPrimary

                        font.family: Typography.family
                        font.pixelSize: Typography.bodySmall
                        font.bold: true
                    }
                }
            }
        }
    }
}