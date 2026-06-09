import QtQuick
import EvHmi

BaseCard {
    id: root

    title: ""

    Row {
        anchors.fill: parent

        Item {
            width: parent.width / 3
            height: parent.height

            Column {
                anchors.centerIn: parent
                spacing: 4 * Theme.scale

                Text {
                    text: "ODOMETER"

                    color: Colors.textMuted

                    font.family: Typography.family
                    font.pixelSize: Typography.label
                    font.bold: true

                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: vehicleData.odometer.toFixed(1) + " km"

                    color: Colors.textPrimary

                    font.family: Typography.family
                    font.pixelSize: Typography.bodyLarge
                    font.bold: true

                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }

        Rectangle {
            width: 1
            height: parent.height * 0.45

            anchors.verticalCenter: parent.verticalCenter

            color: Colors.borderSubtle
        }

        Item {
            width: parent.width / 3
            height: parent.height

            Column {
                anchors.centerIn: parent
                spacing: 4 * Theme.scale

                Text {
                    text: "TRIP A"

                    color: Colors.textMuted

                    font.family: Typography.family
                    font.pixelSize: Typography.label
                    font.bold: true

                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: vehicleData.tripA.toFixed(1) + " km"

                    color: Colors.textPrimary

                    font.family: Typography.family
                    font.pixelSize: Typography.bodyLarge
                    font.bold: true

                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }

        Rectangle {
            width: 1
            height: parent.height * 0.45

            anchors.verticalCenter: parent.verticalCenter

            color: Colors.borderSubtle
        }

        Item {
            width: parent.width / 3
            height: parent.height

            Column {
                anchors.centerIn: parent
                spacing: 4 * Theme.scale

                Text {
                    text: "TRIP B"

                    color: Colors.textMuted

                    font.family: Typography.family
                    font.pixelSize: Typography.label
                    font.bold: true

                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: vehicleData.tripB.toFixed(1) + " km"

                    color: Colors.textPrimary

                    font.family: Typography.family
                    font.pixelSize: Typography.bodyLarge
                    font.bold: true

                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }
}