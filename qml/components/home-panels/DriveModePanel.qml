import QtQuick
import EvHmi

BaseCard {
    id: root

    title: "DRIVE MODE"

    Row {
        anchors.centerIn: parent

        spacing: 10 * Theme.scale

        Repeater {
            model: ["ECO", "CITY", "SPORT"]

            Rectangle {
                width: 78 * Theme.scale
                height: 42 * Theme.scale

                radius: Theme.controlRadius

                readonly property bool active:
                    vehicleData.driveMode === modelData

                color: active
                       ? Colors.surfacePressed
                       : Colors.surfaceSunken

                border.width: active ? 2 : 1

                border.color: active
                              ? Colors.borderActive
                              : Colors.borderWarm

                Behavior on color {
                    ColorAnimation {
                        duration: Theme.motionFast
                    }
                }

                Behavior on border.color {
                    ColorAnimation {
                        duration: Theme.motionFast
                    }
                }

                Text {
                    anchors.centerIn: parent

                    text: modelData

                    color: parent.active
                           ? Colors.borderActive
                           : Colors.textPrimary

                    font.family: Typography.family
                    font.pixelSize: Typography.bodyMedium
                    font.bold: true
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        vehicleData.driveMode = modelData
                    }
                }
            }
        }
    }
}