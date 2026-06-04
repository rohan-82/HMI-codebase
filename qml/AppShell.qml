import QtQuick
import EvHmi

Item {
    id: root

    property int currentPageIndex: 0
    
    // =====================================================
    // GLOBAL APP TRANSLATION DICTIONARY
    // =====================================================
    readonly property var translations: {
        "live_telemetry":   { "en": "LIVE TELEMETRY",    "de": "LIVE-TELEMETRIE",   "es": "TELEMETRÍA EN VIVO" },
        "offline":          { "en": "OFFLINE",           "de": "OFFLINE",           "es": "FUERA DE LÍNEA" },
        "system_nominal":   { "en": "SYSTEM NOMINAL",    "de": "SYSTEM NOMINAL",    "es": "SISTEMA NOMINAL" },
        "comm_fault":       { "en": "COMMUNICATION FAULT","de": "KOMMUNIKATIONSFEHLER","es": "FALLO DE COMUNICACIÓN" },
        "tab_home":         { "en": "Home",              "de": "Start",             "es": "Inicio" },
        "tab_music":        { "en": "Music",             "de": "Musik",             "es": "Música" },
        "tab_settings":     { "en": "Settings",          "de": "Einstellungen",     "es": "Ajustes" },
        "tab_diagnostics":  { "en": "Diagnostics",       "de": "Diagnose",          "es": "Diagnóstico" }
    }

    // Dynamic keys mapping back directly to the translation dictionary above
    readonly property var pages: [
        { "key": "tab_home" },
        { "key": "tab_music" },
        { "key": "tab_settings" },
        { "key": "tab_diagnostics" }
    ]

    // Background Canvas
    Rectangle {
        anchors.fill: parent
        color: Colors.backgroundPrimary

        Rectangle {
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#090B0D" }
                GradientStop { position: 0.58; color: Colors.backgroundPrimary }
                GradientStop { position: 1.0; color: Colors.backgroundPrimary }
            }
        }
    }

    // =====================================================
    // TOP STATUS BAR
    // =====================================================
    Item {
        id: topBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: Theme.topBarHeight

        Row {
            anchors.left: parent.left
            anchors.leftMargin: Theme.pageMargin
            anchors.verticalCenter: parent.verticalCenter
            spacing: Math.round(12 * Theme.scale)

            Text {
                text: "EV HMI"
                color: Colors.textPrimary
                font.family: Typography.family
                font.pixelSize: Typography.bodyMedium
                font.weight: Font.DemiBold
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                // Now directly links to your updated global Typography module!
                text: vehicleData.communicationFault 
                      ? root.translations["offline"][Typography.currentLanguage] 
                      : root.translations["live_telemetry"][Typography.currentLanguage]
                color: vehicleData.communicationFault ? Colors.critical : Colors.accentEco
                font.family: Typography.family
                font.pixelSize: Typography.label
                font.weight: Font.DemiBold
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Row {
            anchors.right: parent.right
            anchors.rightMargin: Theme.pageMargin
            anchors.verticalCenter: parent.verticalCenter
            spacing: Math.round(14 * Theme.scale)

            Text {
                text: vehicleData.driveMode
                color: vehicleData.driveMode === "SPORT" ? Colors.accentSport
                    : vehicleData.driveMode === "CITY" ? Colors.accentCity
                    : Colors.accentEco
                font.family: Typography.family
                font.pixelSize: Typography.label
                font.weight: Font.DemiBold
            }

            Text {
                text: Math.round(vehicleData.batteryPercent) + "%"
                color: Colors.textSecondary
                font.family: Typography.family
                font.pixelSize: Typography.label
                font.weight: Font.DemiBold
            }
        }
    }

    // =====================================================
    // SYSTEM DIAGNOSTICS & WARNING BANNER
    // =====================================================
    Rectangle {
        id: warningBanner
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: topBar.bottom
        anchors.leftMargin: Theme.pageMargin
        anchors.rightMargin: Theme.pageMargin
        height: Math.round(40 * Theme.scale)
        radius: Theme.controlRadius
        color: vehicleData.communicationFault || vehicleData.warningMessage.length > 0
            ? Qt.rgba(Colors.critical.r, Colors.critical.g, Colors.critical.b, 0.16)
            : Qt.rgba(Colors.accentEco.r, Colors.accentEco.g, Colors.accentEco.b, 0.11)
        border.color: vehicleData.communicationFault || vehicleData.warningMessage.length > 0
            ? Colors.critical
            : Colors.borderSubtle
        border.width: 1

        Row {
            anchors.fill: parent
            anchors.leftMargin: Math.round(14 * Theme.scale)
            anchors.rightMargin: Math.round(14 * Theme.scale)
            spacing: Math.round(10 * Theme.scale)

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: vehicleData.communicationFault || vehicleData.warningMessage.length > 0 ? "!" : "OK"
                color: vehicleData.communicationFault || vehicleData.warningMessage.length > 0 ? Colors.critical : Colors.accentEco
                font.family: Typography.family
                font.pixelSize: Typography.bodySmall
                font.weight: Font.DemiBold
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width - Math.round(42 * Theme.scale)
                
                // Reactive warning text translated via global font engine state
                text: vehicleData.communicationFault 
                      ? root.translations["comm_fault"][Typography.currentLanguage]
                      : vehicleData.warningMessage.length > 0 
                        ? vehicleData.warningMessage.toUpperCase()
                        : root.translations["system_nominal"][Typography.currentLanguage]
                        
                color: Colors.textPrimary
                elide: Text.ElideRight
                font.family: Typography.family
                font.pixelSize: Typography.bodySmall
                font.weight: Font.DemiBold
            }
        }
    }


    // =====================================================
    // MAIN CONTENT PAGE LOADER
    // =====================================================
    Loader {
        id: pageLoader
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: warningBanner.bottom
        anchors.bottom: navBar.top
        anchors.leftMargin: Theme.pageMargin
        anchors.rightMargin: Theme.pageMargin
        anchors.topMargin: Math.round(10 * Theme.scale)
        anchors.bottomMargin: Math.round(8 * Theme.scale)
        sourceComponent: root.currentPageIndex === 0 ? homePage
            : root.currentPageIndex === 1 ? musicPage
            : root.currentPageIndex === 2 ? settingsPage
            : diagnosticsPage
    }


    // =====================================================
    // BOTTOM NAVIGATION BAR
    // =====================================================
    Rectangle {
        id: navBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: Theme.navBarHeight
        color: Colors.surfaceRaised
        border.color: Colors.borderSubtle

        Row {
            anchors.centerIn: parent
            spacing: Math.round(8 * Theme.scale)

            Repeater {
                model: root.pages.length

                Rectangle {
                    width: Math.round(132 * Theme.scale)
                    height: Math.round(46 * Theme.scale)
                    radius: Math.round(8 * Theme.scale)
                    color: root.currentPageIndex === index 
                             ? Colors.surfaceBase 
                             : "transparent"
                    border.color: root.currentPageIndex === index
                             ? Colors.borderWarm 
                             : Colors.borderSubtle
                    border.width: 1

                    Behavior on color {
                        ColorAnimation {
                            duration: Theme.motionFast
                            easing.type: Easing.OutCubic
                        }
                    }

                    Text {
                        anchors.centerIn: parent
                        
                        // Dynamically updates translation values for navbar labels instantly
                        text: root.translations[root.pages[index].key][Typography.currentLanguage]
                        
                        color: root.currentPageIndex === index
                                 ? Colors.textPrimary
                                 : Colors.textMuted
                        font.family: Typography.family
                        font.pixelSize: Typography.bodySmall
                        font.weight: root.currentPageIndex === index 
                                 ? Font.DemiBold 
                                 : Font.Medium
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.currentPageIndex = index
                    }
                }
            }
        }
    }

    
    Component { id: homePage; HomePage {} }
    Component { id: musicPage; MusicPage {} }
    Component { id: settingsPage; SettingsPage {} }
    Component { id: diagnosticsPage; DiagnosticsPage {} }
    
}