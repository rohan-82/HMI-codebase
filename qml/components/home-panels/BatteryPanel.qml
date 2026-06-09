import QtQuick
import EvHmi

BaseCard {
    id: root

    title: "BATTERY"

    Column {
        anchors.fill: parent
        spacing: 18 * Theme.scale

        Item {
            width: parent.width
            height: 90 * Theme.scale

            BatteryGraphic {
                id: batteryGraphic

                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter

                percentage: vehicleData.batteryPercent

                scale: 2.6
                transformOrigin: Item.Left
            }

            Text {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                text: vehicleData.batteryPercent + "%"

                color: Colors.textPrimary

                font.family: Typography.family
                font.pixelSize: Typography.displayMedium
                font.weight: Font.Bold
            }
        }

        Rectangle {
            width: parent.width
            height: 1
            color: Colors.borderSubtle
            opacity: 0.5
        }

        Column {
            width: parent.width
            spacing: 10 * Theme.scale

            Item {
                width: parent.width
                height: 28 * Theme.scale

                Text {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter

                    text: "Total Range"

                    color: Colors.textSecondary
                    font.family: Typography.family
                    font.pixelSize: Typography.bodyMedium
                }

                Text {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter

                    text: vehicleData.totalRangeKm + " km"

                    color: Colors.textPrimary
                    font.family: Typography.family
                    font.pixelSize: Typography.bodyLarge
                    font.weight: Font.DemiBold
                }
            }

            Item {
                width: parent.width
                height: 28 * Theme.scale

                Text {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter

                    text: "Est. Range"

                    color: Colors.textSecondary
                    font.family: Typography.family
                    font.pixelSize: Typography.bodyMedium
                }

                Text {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter

                    text: vehicleData.rangeKm + " km"

                    color: Colors.accentCity
                    font.family: Typography.family
                    font.pixelSize: Typography.bodyLarge
                    font.weight: Font.DemiBold
                }
            }

            Item {
                width: parent.width
                height: 28 * Theme.scale

                Text {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter

                    text: "Battery Temp"

                    color: Colors.textSecondary
                    font.family: Typography.family
                    font.pixelSize: Typography.bodyMedium
                }

                Text {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter

                    text: vehicleData.batteryTemp + "°C"

                    color: Colors.textPrimary
                    font.family: Typography.family
                    font.pixelSize: Typography.bodyLarge
                    font.weight: Font.DemiBold
                }
            }

            Item {
                width: parent.width
                height: 28 * Theme.scale

                Text {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter

                    text: "Capacity"

                    color: Colors.textSecondary
                    font.family: Typography.family
                    font.pixelSize: Typography.bodyMedium
                }

                Text {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter

                    text: vehicleData.batteryPercent + "%"

                    color: Colors.textPrimary
                    font.family: Typography.family
                    font.pixelSize: Typography.bodyLarge
                    font.weight: Font.DemiBold
                }
            }
        }
    }
}