import QtQuick
import QtQuick.Controls
import QtQuick.Shapes
import EvHmi

Item {
    id: homePage
    anchors.fill: parent
    anchors.margins: Theme.pageMargin

    Column {
        anchors.fill: parent
        spacing: Theme.sectionGap

        // =====================================================
        // 1. TOP ROW (SPEEDOMETER & BATTERY STATUS)
        // =====================================================
        Row {
            width: parent.width
            height: parent.height * 0.58 // Expanded slightly to reclaim banner space
            spacing: Theme.cardGap

            // --- SPEEDOMETER & RPM GAUGE CARD ---
            BaseCard {
                width: (parent.width * 0.55) - (Theme.cardGap / 2)
                height: parent.height
                title: "" 

                Canvas {
                    id: gaugeCanvas
                    anchors.fill: parent
                    anchors.margins: 20
                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.reset();
                        
                        var centerX = width / 2;
                        var centerY = height / 2 + 15;
                        var radius = Math.min(width, height) * 0.44;
                        
                        ctx.beginPath();
                        ctx.arc(centerX, centerY, radius, Math.PI * 0.8, Math.PI * 2.2);
                        ctx.lineWidth = 4;
                        ctx.strokeStyle = Colors.surfaceSunken;
                        ctx.stroke();

                        ctx.beginPath();
                        var endAngle = Math.PI * 0.8 + ((Math.PI * 1.4) * (Math.min(vehicleData.speed, 200) / 200));
                        ctx.arc(centerX, centerY, radius, Math.PI * 0.8, endAngle);
                        ctx.lineWidth = 6;
                        ctx.strokeStyle = Colors.borderActive;
                        ctx.stroke();
                    }
                    
                    Connections {
                        target: vehicleData
                        function onSpeedChanged() { gaugeCanvas.requestPaint(); }
                    }
                }

                Column {
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: 15
                    spacing: 2

                    Text {
                        text: vehicleData.speed
                        color: Colors.textPrimary
                        font.family: Typography.family
                        font.pixelSize: Typography.displayLarge
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        text: "km/h"
                        color: Colors.textSecondary
                        font.family: Typography.family
                        font.pixelSize: Typography.bodyLarge
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Item { width: 1; height: 10 } 

                    Text {
                        text: "RPM"
                        color: Colors.textMuted
                        font.family: Typography.family
                        font.pixelSize: Typography.bodySmall
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        text: vehicleData.rpm
                        color: Colors.textPrimary
                        font.family: Typography.family
                        font.pixelSize: Typography.titleLarge
                        font.weight: Font.DemiBold
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }

            // --- BATTERY SYSTEM METRICS CARD ---
            BaseCard {
                width: (parent.width * 0.45) - (Theme.cardGap / 2)
                height: parent.height
                title: "BATTERY"

                Column {
                    anchors.top: parent.top
                    anchors.topMargin: 45 
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.margins: Theme.cardPadding
                    spacing: 14

                    Row {
                        width: parent.width
                        spacing: 12

                        Rectangle {
                            width: parent.width - 75
                            height: 34
                            radius: 6
                            color: Colors.surfaceSunken
                            border.width: 1.5
                            border.color: Colors.borderWarm
                            clip: true

                            Row {
                                anchors.fill: parent
                                anchors.margins: 4
                                spacing: 2

                                Repeater {
                                    model: 10
                                    Rectangle {
                                        width: (parent.width - 22) / 10
                                        height: parent.height
                                        radius: 2
                                        color: (index * 10 < vehicleData.batteryPercent) ? Colors.accentEco : "transparent"
                                        opacity: (index * 10 < vehicleData.batteryPercent) ? 1.0 : 0.0
                                    }
                                }
                            }
                        }

                        Text {
                            text: vehicleData.batteryPercent + "%"
                            color: Colors.textPrimary
                            font.family: Typography.family
                            font.pixelSize: Typography.titleMedium
                            font.bold: true
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    Column {
                        width: parent.width
                        spacing: 10

                        property var itemsModel: [
                            {"label": "Capacity", "value": vehicleData.batteryPercent + "%", "isAccent": false},
                            {"label": "Total Range", "value": "180 km", "isAccent": true}, 
                            {"label": "Estimated Range", "value": vehicleData.rangeKm + " km", "isAccent": true},
                            {"label": "Battery Temp", "value": vehicleData.batteryTemp + "°C", "isAccent": false}
                        ]

                        Repeater {
                            model: parent.itemsModel
                            Item {
                                width: parent.width
                                height: 26 

                                Text {
                                    text: modelData.label
                                    color: Colors.textSecondary
                                    font.family: Typography.family
                                    font.pixelSize: Typography.bodyMedium
                                    anchors.left: parent.left
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                                Text {
                                    text: modelData.value
                                    color: modelData.isAccent ? Colors.accentCity : Colors.textPrimary
                                    font.family: Typography.family
                                    font.pixelSize: Typography.bodyLarge
                                    font.bold: true
                                    anchors.right: parent.right
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                            }
                        }
                    }
                }
            }
        }

        // =====================================================
        // 2. LOWER CONTROL SETS ROW (PRND, DRIVE MODES & STATUS)
        // =====================================================
        Row {
            width: parent.width
            height: parent.height * 0.25
            spacing: Theme.cardGap

            // --- PRND & LIGHTS INTERACTIVE CARD ---
            BaseCard {
                width: parent.width * 0.46
                height: parent.height
                title: "PRND & LIGHTS"

                Row {
                    anchors.top: parent.top
                    anchors.topMargin: 45
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.margins: Theme.cardPadding
                    spacing: Theme.sectionGap

                    Row {
                        spacing: 4
                        property var gears: ["P", "R", "N", "D"]
                        Repeater {
                            model: parent.gears
                            Rectangle {
                                width: 36
                                height: 36
                                radius: Theme.controlRadius
                                color: (vehicleData.gearState === modelData) ? Colors.surfacePressed : Colors.surfaceSunken
                                border.width: 1.5
                                border.color: (vehicleData.gearState === modelData) ? Colors.borderActive : Colors.borderWarm

                                Text {
                                    anchors.centerIn: parent
                                    text: modelData
                                    color: (vehicleData.gearState === modelData) ? Colors.borderActive : Colors.textSecondary
                                    font.family: Typography.family
                                    font.pixelSize: Typography.bodyMedium
                                    font.bold: true
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: vehicleData.gearState = modelData
                                }
                            }
                        }
                    }

                    Rectangle {
                        width: 1
                        height: 36
                        color: Colors.borderSubtle
                    }

                    Row {
                        spacing: 12
                        anchors.verticalCenter: parent.verticalCenter
                        
                        Image {
                            id: leftImg
                            source: vehicleData.leftIndicator ? "qrc:/assets/icons/Active/left_on.png" : "qrc:/assets/icons/Muted/left_off.png"
                            width: 22; height: 22; fillMode: Image.PreserveAspectFit
                            visible: status === Image.Ready
                        }
                        Text { text: "⬅"; color: vehicleData.leftIndicator ? Colors.accentEco : Colors.textMuted; font.pixelSize: 18; visible: leftImg.status !== Image.Ready }

                        Image {
                            id: headImg
                            source: vehicleData.headlights ? "qrc:/assets/icons/Active/head_on.png" : "qrc:/assets/icons/Muted/head_off.png"
                            width: 22; height: 22; fillMode: Image.PreserveAspectFit
                            visible: status === Image.Ready
                        }
                        Text { text: "D0="; color: vehicleData.headlights ? Colors.accentBlue : Colors.textMuted; font.pixelSize: 18; visible: headImg.status !== Image.Ready }

                        Image {
                            id: highImg
                            source: vehicleData.highBeam ? "qrc:/assets/icons/Active/high_on.png" : "qrc:/assets/icons/Muted/high_off.png"
                            width: 22; height: 22; fillMode: Image.PreserveAspectFit
                            visible: status === Image.Ready
                        }
                        Text { text: "≡D"; color: vehicleData.highBeam ? Colors.accentBlue : Colors.textMuted; font.pixelSize: 18; visible: highImg.status !== Image.Ready }

                        Image {
                            id: hazImg
                            source: vehicleData.hazardLights ? "qrc:/assets/icons/Active/hazard_on.png" : "qrc:/assets/icons/Muted/hazard_off.png"
                            width: 22; height: 22; fillMode: Image.PreserveAspectFit
                            visible: status === Image.Ready
                        }
                        Text { text: "⚠️"; color: vehicleData.hazardLights ? Colors.critical : Colors.textMuted; font.pixelSize: 18; visible: hazImg.status !== Image.Ready }

                        Image {
                            id: rightImg
                            source: vehicleData.rightIndicator ? "qrc:/assets/icons/Active/right_on.png" : "qrc:/assets/icons/Muted/right_off.png"
                            width: 22; height: 22; fillMode: Image.PreserveAspectFit
                            visible: status === Image.Ready
                        }
                        Text { text: "➡"; color: vehicleData.rightIndicator ? Colors.accentEco : Colors.textMuted; font.pixelSize: 18; visible: rightImg.status !== Image.Ready }
                    }
                }
            }

            // --- CLICKABLE DRIVE MODES CARD ---
            BaseCard {
                width: parent.width * 0.28
                height: parent.height
                title: "DRIVE MODE"

                Row {
                    anchors.top: parent.top
                    anchors.topMargin: 45
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 6
                    property var modes: ["ECO", "CITY", "SPORT"]

                    Repeater {
                        model: parent.modes
                        Rectangle {
                            width: 64
                            height: 36
                            radius: Theme.controlRadius
                            color: (vehicleData.driveMode === modelData) ? Colors.surfacePressed : Colors.surfaceSunken
                            border.width: 1.5
                            border.color: (vehicleData.driveMode === modelData) ? Colors.borderActive : Colors.borderWarm

                            Text {
                                anchors.centerIn: parent
                                text: modelData
                                color: (vehicleData.driveMode === modelData) ? Colors.borderActive : Colors.textPrimary
                                font.family: Typography.family
                                font.pixelSize: Typography.bodySmall
                                font.bold: true
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: vehicleData.driveMode = modelData
                            }
                        }
                    }
                }
            }

            // --- SYSTEM STATUS DIAGNOSTICS ---
            BaseCard {
                width: parent.width * 0.26 - Theme.cardGap
                height: parent.height
                title: "SYSTEM STATUS"

                Column {
                    anchors.top: parent.top
                    anchors.topMargin: 45
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.margins: Theme.cardPadding
                    spacing: 4

                    property var statusModel: [
                        {"name": "Battery", "fault": vehicleData.lowBatteryWarning || vehicleData.batteryOverTempWarning},
                        {"name": "Motor", "fault": vehicleData.motorOverTempWarning},
                        {"name": "Controller", "fault": vehicleData.communicationFault},
                        {"name": "Tire System", "fault": false} 
                    ]

                    Repeater {
                        model: parent.statusModel
                        Item {
                            width: parent.width
                            height: 16

                            Text {
                                text: modelData.name
                                color: Colors.textSecondary
                                font.family: Typography.family
                                font.pixelSize: Typography.bodySmall
                                anchors.left: parent.left
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            Row {
                                spacing: 6
                                anchors.right: parent.right
                                anchors.verticalCenter: parent.verticalCenter

                                Rectangle {
                                    width: 6; height: 6; radius: 3
                                    color: modelData.fault ? Colors.critical : Colors.accentEco
                                    anchors.verticalCenter: parent.verticalCenter
                                }

                                Text {
                                    text: modelData.fault ? "FAULT" : "OK"
                                    color: Colors.textPrimary
                                    font.family: Typography.family
                                    font.pixelSize: Typography.bodySmall
                                    font.bold: true
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                            }
                        }
                    }
                }
            }
        }

        // =====================================================
        // 3. BOTTOM TRIP & DISTANCE BAR
        // =====================================================
        BaseCard {
            width: parent.width
            height: parent.height * 0.15 
            title: "" 

            Row {
                anchors.fill: parent
                spacing: 0

                // Odometer
                Item {
                    width: parent.width / 3
                    height: parent.height

                    Row {
                        anchors.centerIn: parent
                        spacing: 12
                        
                        Image {
                            id: odoImg
                            source: "qrc:/assets/icons/Metrics/odometer.png"
                            width: 24; height: 24; anchors.verticalCenter: parent.verticalCenter
                            visible: status === Image.Ready
                        }
                        
                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            Text { text: "ODOMETER"; color: Colors.textMuted; font.family: Typography.family; font.pixelSize: Typography.label; font.bold: true }
                            Text { text: vehicleData.odometer.toFixed(1) + " km"; color: Colors.textPrimary; font.family: Typography.family; font.pixelSize: Typography.bodyLarge; font.bold: true }
                        }
                    }
                }

                Rectangle { width: 1; height: 30; color: Colors.borderSubtle; anchors.verticalCenter: parent.verticalCenter }

                // Trip A
                Item {
                    width: parent.width / 3
                    height: parent.height

                    Row {
                        anchors.centerIn: parent
                        spacing: 12
                        
                        Image {
                            id: tripaImg
                            source: "qrc:/assets/icons/Metrics/trip_a.png"
                            width: 24; height: 24; anchors.verticalCenter: parent.verticalCenter
                            visible: status === Image.Ready
                        }
                        
                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            Text { text: "TRIP A"; color: Colors.textMuted; font.family: Typography.family; font.pixelSize: Typography.label; font.bold: true }
                            Text { text: vehicleData.tripDistance.toFixed(1) + " km"; color: Colors.textPrimary; font.family: Typography.family; font.pixelSize: Typography.bodyLarge; font.bold: true }
                        }
                    }
                }

                Rectangle { width: 1; height: 30; color: Colors.borderSubtle; anchors.verticalCenter: parent.verticalCenter }

                // Trip B
                Item {
                    width: parent.width / 3
                    height: parent.height

                    Row {
                        anchors.centerIn: parent
                        spacing: 12
                        
                        Image {
                            id: tripbImg
                            source: "qrc:/assets/icons/Metrics/trip_b.png"
                            width: 24; height: 24; anchors.verticalCenter: parent.verticalCenter
                            visible: status === Image.Ready
                        }
                        
                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            Text { text: "TRIP B"; color: Colors.textMuted; font.family: Typography.family; font.pixelSize: Typography.label; font.bold: true }
                            Text { text: "087.3 km"; color: Colors.textPrimary; font.family: Typography.family; font.pixelSize: Typography.bodyLarge; font.bold: true }
                        }
                    }
                }
            }
        }
    }
}