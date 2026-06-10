// IndicatorPanel.qml

import QtQuick
import EvHmi

BaseCard {
    id: root

    title: "VEHICLE STATUS"

    // Prevent array reallocation during UI layout updates
    readonly property var gearsModel: ["P", "R", "N", "D"]

    Row {
    anchors.fill: parent
    anchors.topMargin: 42 * Theme.scale

    spacing: 24 * Theme.scale

    // =====================================================
    // PRND
    // =====================================================

    Row {
        id: prndRow

        spacing: 4 * Theme.scale

        Repeater {
            model: root.gearsModel

            Rectangle {
                width: 42 * Theme.scale
                height: 42 * Theme.scale
                radius: Theme.controlRadius

                readonly property bool isSelected:
                    vehicleData.gearState === modelData

                color: isSelected
                       ? Colors.surfacePressed
                       : Colors.surfaceSunken

                border.width: 1.5
                border.color: isSelected
                              ? Colors.borderActive
                              : Colors.borderWarm

                Text {
                    anchors.centerIn: parent

                    text: modelData

                    color: isSelected
                           ? Colors.borderActive
                           : Colors.textSecondary

                    font.family: Typography.family
                    font.pixelSize: Typography.bodyMedium
                    font.bold: true
                }
            }
        }
    }

    Rectangle {
        id: divider

        width: 1
        height: 48 * Theme.scale

        anchors.verticalCenter: parent.verticalCenter

        color: Colors.borderSubtle
    }

    // =====================================================
    // INDICATORS AREA
    // =====================================================

    Item {
        width: parent.width
               - prndRow.width
               - divider.width
               - (48 * Theme.scale)

        height: parent.height

        Row {
            anchors.centerIn: parent

            spacing: 20 * Theme.scale

            // =====================================================
            // PASTE ALL YOUR INDICATOR COLUMNS HERE
            // =====================================================

            // Left
            Column {
                spacing: 4 * Theme.scale

                Image {
                    source: vehicleData.leftIndicator
                        ? "qrc:/assets/icons/Light/HomePage/left-indicator-on.png"
                        : "qrc:/assets/icons/Light/HomePage/left-indicator-off.png"

                    width: 28 * Theme.scale
                    height: 28 * Theme.scale
                    fillMode: Image.PreserveAspectFit

                    onStatusChanged: {
                        if (status === Image.Error)
                            console.log("FAILED:", source)
                    }

                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "Left"
                    color: Colors.textSecondary
                    font.family: Typography.family
                    font.pixelSize: Typography.bodySmall
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            // Beam
            Column {
                spacing: 4 * Theme.scale

                Image {
                    source: vehicleData.highBeam
                        ? "qrc:/assets/icons/Light/HomePage/high-beam.png"
                        : "qrc:/assets/icons/Light/HomePage/low-beam.png"

                    width: 28 * Theme.scale
                    height: 28 * Theme.scale
                    fillMode: Image.PreserveAspectFit

                    onStatusChanged: {
                        if (status === Image.Error)
                            console.log("FAILED:", source)
                    }

                    opacity: vehicleData.headlights ? 1.0 : 0.35

                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "Beam"
                    color: Colors.textSecondary
                    font.family: Typography.family
                    font.pixelSize: Typography.bodySmall
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            // Hazard
            Column {
                spacing: 4 * Theme.scale

                Image {
                    source: vehicleData.hazardLights
                        ? "qrc:/assets/icons/Light/HomePage/caution-lights-on.png"
                        : "qrc:/assets/icons/Light/HomePage/caution-lights-off.png"

                    width: 28 * Theme.scale
                    height: 28 * Theme.scale
                    fillMode: Image.PreserveAspectFit

                    onStatusChanged: {
                        if (status === Image.Error)
                            console.log("FAILED:", source)
                    }

                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "Hazard"
                    color: Colors.textSecondary
                    font.family: Typography.family
                    font.pixelSize: Typography.bodySmall
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            // Handbrake
            Column {
                spacing: 4 * Theme.scale

                Image {
                    source: vehicleData.handbrakeEngaged
                        ? "qrc:/assets/icons/Light/HomePage/handbrake-light-on.png"
                        : "qrc:/assets/icons/Light/HomePage/handbrake-light-off.png"

                    width: 28 * Theme.scale
                    height: 28 * Theme.scale
                    fillMode: Image.PreserveAspectFit

                    onStatusChanged: {
                        if (status === Image.Error)
                            console.log("FAILED:", source)
                    }

                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "Brake"
                    color: Colors.textSecondary
                    font.family: Typography.family
                    font.pixelSize: Typography.bodySmall
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            // Right
            Column {
                spacing: 4 * Theme.scale

                Image {
                    source: vehicleData.rightIndicator
                        ? "qrc:/assets/icons/Light/HomePage/right-indicator-on.png"
                        : "qrc:/assets/icons/Light/HomePage/right-indicator-off.png"

                    width: 28 * Theme.scale
                    height: 28 * Theme.scale
                    fillMode: Image.PreserveAspectFit

                    onStatusChanged: {
                        if (status === Image.Error)
                            console.log("FAILED:", source)
                    }

                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "Right"
                    color: Colors.textSecondary
                    font.family: Typography.family
                    font.pixelSize: Typography.bodySmall
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }
}
}