import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import EvHmi

Item {
    id: diagnosticsCoreGrid
    anchors.fill: parent

    // =========================================================================
    // 🛠️ REUSABLE DASHBOARD CARD COMPONENT WITH SPEC RADII & PADDING
    // =========================================================================
    component DashboardCard : 
    Rectangle {
        property string title: ""
        color: Colors.surfaceBase // Theme-mapped card surface background
        border.color: Colors.borderSubtle // Theme-mapped subtle border outline
        border.width: 1
        radius: Theme.cardRadius // Responsive border radius tracking scale

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: Theme.cardPadding // Padding standards driven by singleton
            spacing: Math.round(8 * Theme.scale)
            
            FontLoader { 
                id: rajdhaniFont
                source: "assets/fonts/Rajdhani-Regular.ttf" 
            }

            Text {
                text: parent.parent.title.toUpperCase()
                font.family: "Rajdhani" // Unified typeface reference
                font.pixelSize: Typography.label // Design system label token sizing
                font.weight: Font.Bold
                color: Colors.textSecondary // Context/mode aware secondary text
                Layout.fillWidth: true
            }

            // Viewport target for custom layout content injection
            Item {
                id: contentContainer
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
        default property alias cardContent: contentContainer.data
    }

    // =========================================================================
    // 🕸️ PRIMARY VIEWPORT MONITORING GRID (MIDDLE ROW SECTION)
    // =========================================================================
    RowLayout {
        anchors.fill: parent
        anchors.margins: Theme.pageMargin // Configurable global layout margins
        spacing: Theme.sectionGap // Standard gaps between primary UI modules

        // =====================================================================
        // LEFT COLUMN MODULE AREA (42% Dynamic Width Allocation Space)
        // =====================================================================
        ColumnLayout {
            Layout.preferredWidth: parent.width * 0.42
            Layout.fillHeight: true
            spacing: Theme.sectionGap

            // CARD A: VEHICLE OVERVIEW CHASSIS WIREFRAME MODEL
            DashboardCard {
                title: "Vehicle Overview"
                Layout.fillWidth: true
                Layout.fillHeight: true
                
                Item {
                    anchors.fill: parent
                    
                    // Structural Chassis Wireframe Model Representation
                    Rectangle {
                        anchors.centerIn: parent
                        width: Math.round(155 * Theme.scale)
                        height: Math.round(270 * Theme.scale)
                        color: "transparent"
                        border.color: Colors.borderSubtle
                        border.width: 1.5
                        radius: 36
                        
                        Text { text: "FRONT"; anchors.bottom: parent.top; anchors.horizontalCenter: parent.horizontalCenter; anchors.bottomMargin: 6; font.family: Typography.family; font.pixelSize: Typography.label; font.weight: Font.Bold; color: Colors.textMuted }
                        Text { text: "REAR"; anchors.top: parent.bottom; anchors.horizontalCenter: parent.horizontalCenter; anchors.topMargin: 6; font.family: Typography.family; font.pixelSize: Typography.label; font.weight: Font.Bold; color: Colors.textMuted }
                    }

                    // Internal Layout Actuator & Thermal Pack Component Chain
                    ColumnLayout {
                        anchors.centerIn: parent
                        spacing: Math.round(10 * Theme.scale)

                        // Powertrain Actuator Component (Motor Block)
                        Rectangle {
                            width: Math.round(110 * Theme.scale)
                            height: Math.round(54 * Theme.scale)
                            color: Colors.surfaceSunken
                            border.color: Colors.borderSubtle
                            radius: Theme.controlRadius

                            ColumnLayout {
                                anchors.centerIn: parent
                                spacing: 1
                                Text { text: "Motor"; font.family: Typography.family; font.pixelSize: Typography.label; color: Colors.textSecondary; Layout.alignment: Qt.AlignHCenter }
                                Text { text: vehicleData.motorTemp + "°C"; font.family: Typography.family; font.pixelSize: Typography.bodyMedium; font.weight: Font.Bold; color: Colors.textPrimary; Layout.alignment: Qt.AlignHCenter }
                                RowLayout { 
                                    spacing: 4; Layout.alignment: Qt.AlignHCenter
                                    Rectangle { width: 4; height: 4; radius: 2; color: Colors.accentEco } 
                                    Text { text: "OK"; font.family: Typography.family; font.pixelSize: 9; font.weight: Font.Bold; color: Colors.accentEco } 
                                }
                            }
                        }

                        // Central Pack Block Traction Array (Battery Core)
                        Rectangle {
                            id: coreBatteryBlock
                            width: Math.round(120 * Theme.scale)
                            height: Math.round(72 * Theme.scale)
                            color: Colors.surfaceSunken
                            border.color: Colors.borderWarm // Highlighted pack focus boundary
                            border.width: 1
                            radius: Theme.controlRadius

                            ColumnLayout {
                                anchors.centerIn: parent
                                spacing: 1
                                Text { text: "Battery Pack"; font.family: Typography.family; font.pixelSize: Typography.label; color: Colors.textSecondary; Layout.alignment: Qt.AlignHCenter }
                                Text { text: vehicleData.batteryTemp + "°C"; font.family: Typography.family; font.pixelSize: Typography.bodyLarge; font.weight: Font.Bold; color: Colors.textPrimary; Layout.alignment: Qt.AlignHCenter }
                                RowLayout { 
                                    spacing: 4; Layout.alignment: Qt.AlignHCenter
                                    Rectangle { width: 4; height: 4; radius: 2; color: Colors.accentEco } 
                                    Text { text: "OK"; font.family: Typography.family; font.pixelSize: 9; font.weight: Font.Bold; color: Colors.accentEco } 
                                }
                            }
                        }

                        // H-Bridge Inverter Component (Controller Block)
                        Rectangle {
                            width: Math.round(110 * Theme.scale)
                            height: Math.round(54 * Theme.scale)
                            color: Colors.surfaceSunken
                            border.color: Colors.borderSubtle
                            radius: Theme.controlRadius

                            ColumnLayout {
                                anchors.centerIn: parent
                                spacing: 1
                                Text { text: "Controller"; font.family: Typography.family; font.pixelSize: Typography.label; color: Colors.textSecondary; Layout.alignment: Qt.AlignHCenter }
                                Text { text: "41°C"; font.family: Typography.family; font.pixelSize: Typography.bodyMedium; font.weight: Font.Bold; color: Colors.textPrimary; Layout.alignment: Qt.AlignHCenter }
                                RowLayout { 
                                    spacing: 4; Layout.alignment: Qt.AlignHCenter
                                    Rectangle { width: 4; height: 4; radius: 2; color: Colors.accentEco } 
                                    Text { text: "OK"; font.family: Typography.family; font.pixelSize: 9; font.weight: Font.Bold; color: Colors.accentEco } 
                                }
                            }
                        }
                    }

                    // Voltage & Current Vectors (Absolute Margin Symmetrical Offsets)
                    Column {
                        x: Math.round(10 * Theme.scale)
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 2
                        Text { text: "72.4 V"; font.family: Typography.family; font.pixelSize: Typography.bodyLarge; font.weight: Font.Bold; color: Colors.accentBlue }
                        Text { text: "Pack Voltage"; font.family: Typography.family; font.pixelSize: 10; color: Colors.textMuted }
                    }

                    Column {
                        anchors.right: parent.right
                        anchors.rightMargin: Math.round(10 * Theme.scale)
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 2
                        Text { text: "18.2 A"; font.family: Typography.family; font.pixelSize: Typography.bodyLarge; font.weight: Font.Bold; color: Colors.accentBlue; horizontalAlignment: Text.AlignRight }
                        Text { text: "Pack Current"; font.family: Typography.family; font.pixelSize: 10; color: Colors.textMuted; horizontalAlignment: Text.AlignRight }
                    }
                }
            }

            // CARD B: METRICS MATRIX WITH INDEPENDENT SEGMENTED TRACK LAYOUTS
            DashboardCard {
                title: "Temperature Status"
                Layout.fillWidth: true
                Layout.preferredHeight: Math.round(215 * Theme.scale) // Aspect ratio locked

                ColumnLayout {
                    anchors.fill: parent
                    spacing: Math.round(8 * Theme.scale)

                    // Inline Custom Segmented Progress Component Template
                    component TemperatureMetricRow : RowLayout {
                        property string moduleName: ""
                        property string currentTemp: ""
                        property real fillRatio: 0.5
                        property color statusColor: Colors.accentCity

                        Text { text: moduleName; font.family: Typography.family; font.pixelSize: Typography.bodySmall; font.weight: Font.Medium; color: Colors.textPrimary; Layout.preferredWidth: 85 }
                        
                        // Segmented Bar Layout Track
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 3
                            Repeater {
                                model: 12
                                Rectangle {
                                    Layout.fillWidth: true
                                    height: Math.round(10 * Theme.scale)
                                    radius: 1.5
                                    color: (index / 12.0 < fillRatio) ? statusColor : Colors.surfaceSunken
                                    opacity: (index / 12.0 < fillRatio) ? 1.0 : 0.35
                                }
                            }
                        }
                        
                        Text { text: currentTemp; font.family: "Rajdhani"; font.pixelSize: Typography.bodySmall; font.weight: Font.Bold; color: Colors.textPrimary; Layout.preferredWidth: 45; horizontalAlignment: Text.AlignRight }
                    }

                    TemperatureMetricRow { moduleName: "Motor"; currentTemp: vehicleData.motorTemp + "°C"; fillRatio: 0.75; statusColor: Colors.accentCity }
                    TemperatureMetricRow { moduleName: "Battery"; currentTemp: vehicleData.batteryTemp + "°C"; fillRatio: 0.45; statusColor: Colors.accentCity }
                    TemperatureMetricRow { moduleName: "Controller"; currentTemp: "41°C"; fillRatio: 0.60; statusColor: Colors.warning } 

                    Item { Layout.preferredHeight: 2 }

                    // Status Color Explanatory Legend Footer
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 12
                        
                        RowLayout { spacing: 5; Rectangle { width: 8; height: 8; radius: 4; color: Colors.accentCity } Text { text: "< 50°C Normal"; font.family: Typography.family; font.pixelSize: 10; color: Colors.textMuted } }
                        RowLayout { spacing: 5; Rectangle { width: 8; height: 8; radius: 4; color: Colors.warning } Text { text: "50°C - 70°C Elevated"; font.family: Typography.family; font.pixelSize: 10; color: Colors.textMuted } }
                        RowLayout { spacing: 5; Rectangle { width: 8; height: 8; radius: 4; color: Colors.critical } Text { text: "> 70°C High"; font.family: Typography.family; font.pixelSize: 10; color: Colors.textMuted } }
                    }
                }
            }
        }

        // =====================================================================
        // RIGHT COLUMN MODULE AREA (58% Dynamic Width Allocation Space)
        // =====================================================================
        ColumnLayout {
            Layout.preferredWidth: parent.width * 0.58
            Layout.fillHeight: true
            spacing: Theme.sectionGap

            // GRID MATRIX SPLIT ROW CONTAINER
            RowLayout {
                Layout.preferredHeight: Math.round(180 * Theme.scale)
                spacing: Theme.sectionGap

                // CARD C: VEHICLE OPERATIONAL HEALTH SCORES
                DashboardCard {
                    title: "Vehicle Health"
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    RowLayout {
                        anchors.fill: parent
                        spacing: Theme.cardGap
                
                        ColumnLayout {
                            spacing: 3
                            Layout.fillWidth: true
                            
                            component DiagnosticLineItem : RowLayout {
                                property string itemLabel: ""
                                Text { text: itemLabel; font.family: "Rajdhani"; font.pixelSize: Typography.bodySmall; color: Colors.textSecondary }
                                Item { Layout.fillWidth: true }
                                Text { text: "OK"; font.family: "Rajdhani"; font.pixelSize: Typography.bodySmall; font.weight: Font.Bold; color: Colors.accentEco }
                            }
                            
                            DiagnosticLineItem { itemLabel: "Battery" }
                            DiagnosticLineItem { itemLabel: "Motor" }
                            DiagnosticLineItem { itemLabel: "Controller" }
                            DiagnosticLineItem { itemLabel: "Comms" }
                            
                            Text { text: "Last Check: 12:42:31"; font.family: "Rajdhani"; font.pixelSize: 9; color: Colors.textMuted; Layout.topMargin: 4 }
                        }
                        
                        ColumnLayout {
                            Layout.preferredWidth: Math.round(95 * Theme.scale)
                            spacing: 2
                            Layout.alignment: Qt.AlignVCenter // ✅ Attached property layout resolution
                            Text { text: "98%"; font.family: "Rajdhani"; font.pixelSize: Typography.displayMedium; font.weight: Font.Bold; color: Colors.accentCity; Layout.alignment: Qt.AlignHCenter }
                            Text { text: "HEALTHY"; font.family: "Rajdhani"; font.pixelSize: Typography.label; font.weight: Font.Bold; color: Colors.accentEco; Layout.alignment: Qt.AlignHCenter }
                        }
                    }
                }

                // CARD D: ACTIVE WARNINGS LOG REGISTRY
                DashboardCard {
                    title: "Active Warnings"
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    ColumnLayout {
                        anchors.fill: parent
                        spacing: 5
                        
                        RowLayout {
                            spacing: 8
                            Rectangle { 
                                width: 18; height: 18; radius: 9; color: "transparent"; border.color: Colors.accentEco; border.width: 1
                                Text { text: "✓"; color: Colors.accentEco; font.family: "Rajdhani"; font.pixelSize: Typography.label; font.weight: Font.Bold; anchors.centerIn: parent }
                            }
                            Text { text: "NO ACTIVE WARNINGS"; font.family: "Rajdhani"; font.pixelSize: Typography.bodySmall; font.weight: Font.Bold; color: Colors.accentEco }
                        }
                        
                        Text { text: "All diagnostic systems operating normal."; font.family: "Rajdhani"; font.pixelSize: Typography.label; color: Colors.textMuted }
                        
                        Rectangle { Layout.fillWidth: true; height: 1; color: Colors.borderSubtle; Layout.topMargin: 2; Layout.bottomMargin: 2 }
                        
                        Text { text: "Last Fault (Historical):"; font.family: "Rajdhani"; font.pixelSize: 10; font.weight: Font.Bold; color: Colors.textSecondary }
                        
                        RowLayout {
                            spacing: 6
                            Text { text: "⚠  BMS Overtemp — 02-Jun-2026 | Resolved"; font.family: "Rajdhani"; font.pixelSize: 10; color: Colors.warning; Layout.fillWidth: true; elide: Text.ElideRight }
                        }
                        
                        RowLayout {
                            Layout.topMargin: 1
                            spacing: 10
                            Text { text: "0 Active"; font.family: "Rajdhani"; font.pixelSize: 10; font.weight: Font.Bold; color: Colors.textMuted }
                            Text { text: "2 Historical"; font.family: "Rajdhani"; font.pixelSize: 10; font.weight: Font.Bold; color: Colors.accentCity }
                        }
                    }
                }
            }

            // QUAD AGGREGATED TELEMETRY BADGES
            RowLayout {
                Layout.preferredHeight: Math.round(112 * Theme.scale)
                spacing: Theme.sectionGap

                component QuadMiniBadge : DashboardCard {
                    property string mainValue: ""
                    property string subLabel: ""
                    property string statusText: "NORMAL"
                    property color statusColor: Colors.accentEco
                    property string symbolChar: ""
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Item {
                        anchors.fill: parent
                        
                        Text { text: symbolChar; x: 0; y: -4; font.family: "Rajdhani"; font.pixelSize: Typography.bodyLarge; color: Colors.textMuted }
                        
                        ColumnLayout {
                            anchors.fill: parent
                            anchors.topMargin: Math.round(12 * Theme.scale)
                            spacing: 1
                            
                            Text { text: mainValue; font.family: "Rajdhani"; font.pixelSize: Typography.titleMedium; font.weight: Font.Bold; color: Colors.textPrimary }
                            Text { text: subLabel; font.family: "Rajdhani"; font.pixelSize: 10; color: Colors.textSecondary; elide: Text.ElideRight; Layout.fillWidth: true }
                            
                            RowLayout { 
                                spacing: 4; Layout.topMargin: 2
                                Rectangle { width: 5; height: 5; radius: 2.5; color: statusColor }
                                Text { text: statusText; font.family: "Rajdhani"; font.pixelSize: 9; font.weight: Font.Bold; color: statusColor } 
                            }
                        }
                    }
                }

                QuadMiniBadge { title: "Battery"; symbolChar: "🔋"; mainValue: vehicleData.batteryPercent + "%"; subLabel: "Range " + vehicleData.rangeKm + " km  |  SOH 96%" }
                QuadMiniBadge { title: "Powertrain"; symbolChar: "⚡"; mainValue: vehicleData.motorPower.toFixed(1) + " kW"; subLabel: "Motor Power Vectors" }
                QuadMiniBadge { title: "Thermal"; symbolChar: "🌡"; mainValue: vehicleData.motorTemp + "°C"; subLabel: "Max Component Temp" }
                QuadMiniBadge { title: "Communication"; symbolChar: "📡"; mainValue: "CONNECTED"; subLabel: "Stable Bus Feed Stream"; statusText: "STABLE" }
            }

            // DETAILED STREAM POWERTRAIN MATRIX RAW VIEWPORT
            DashboardCard {
                title: "Powertrain Data"
                Layout.fillHeight: true

                ListView {
                    anchors.fill: parent
                    anchors.topMargin: Math.round(4 * Theme.scale)
                    interactive: false
                    spacing: 0
                    
                    model: ListModel {
                        ListElement { metric: "Battery Voltage"; reading: "72.4 V"; symbol: "🔋" }
                        ListElement { metric: "Battery Current"; reading: "18.2 A"; symbol: "📈" }
                        ListElement { metric: "Motor Power"; reading: "4.8 kW"; symbol: "⚙" }
                        ListElement { metric: "Regen Level"; reading: "2"; symbol: "🔄" }
                    }
                    
                    delegate: ColumnLayout {
                        width: parent.width
                        spacing: 0
                        
                        RowLayout {
                            Layout.fillWidth: true
                            Layout.preferredHeight: Math.round(34 * Theme.scale)
                            
                            Text { text: model.symbol; font.family: "Rajdhani"; font.pixelSize: Typography.bodySmall; color: Colors.textMuted; Layout.rightMargin: 4 }
                            Text { text: model.metric; font.family: "Rajdhani"; font.pixelSize: Typography.bodyMedium; color: Colors.textSecondary }
                            Item { Layout.fillWidth: true }
                            Text { text: model.reading; font.family: "Rajdhani"; font.pixelSize: Typography.bodyMedium; font.weight: Font.Bold; color: Colors.textPrimary }
                        }
                        
                        Rectangle { 
                            Layout.fillWidth: true; height: 1; color: Colors.surfaceSunken
                            visible: index < 3
                        }
                    }
                }
            }
        }
    }
}