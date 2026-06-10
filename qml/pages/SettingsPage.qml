import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import EvHmi

Item {
    id: settingsRoot
    anchors.fill: parent

    property int cardSpacing: Theme.cardGap ? Theme.cardGap : 10
    property int innerMargin: Theme.cardPadding ? Theme.cardPadding : 14

    QtObject {
        id: settingsState
        property int brightness: 70
        property int contrast: 55
        property int alertVolume: 66
        property int indicatorVolume: 40

        property string language: Typography.currentLanguage         
        property string dayNightMode: Colors.dayNightMode

        property string units: "metric"     
        property int clockFormat: Typography.timeFormat === "HH:mm" ? 24 : 12           
        property string dateFormat: "dd"        
    }

    // =====================================================
    // HARDCODED TRANSLATION DICTIONARY
    // =====================================================
    readonly property var translations: {
        "modes_title":  { "en": "Modes",       "de": "Modi",               "es": "Modos" },
        "display_title":{ "en": "Display",     "de": "Anzeige",            "es": "Pantalla" },
        "volume_title": { "en": "Volume",      "de": "Lautstärke",         "es": "Volumen" },
        "system_title": { "en": "System",      "de": "System",             "es": "Sistema" },
        "units":        { "en": " Units",      "de": " Einheiten",         "es": " Unidades" },
        "language":     { "en": " Language",   "de": " Sprache",           "es": " Idioma" },
        "day_night":    { "en": " Day / Night Mode", "de": " Tag / Nacht Modus", "es": " Modo Día / Noche" },
        "theme":        { "en": " Theme",      "de": " Design",            "es": " Tema" },
        "brightness":   { "en": " Brightness", "de": " Helligkeit",        "es": " Brillo" },
        "contrast":     { "en": " Contrast",   "de": " Kontrast",          "es": " Contraste" },
        "alert":        { "en": " Alert",      "de": " Warnung",           "es": " Alerta" },
        "indicator":    { "en": " Indicator",  "de": " Blinker",           "es": " Indicador" },
        "clock_format": { "en": " Clock Format", "de": " Uhrzeitformat",    "es": " Formato de Reloj" },
        "date_format":  { "en": " Date Format",  "de": " Datumsformat",     "es": " Formato de Fecha" },
        "about":        { "en": " About",      "de": " Über",              "es": " Acerca de" },
        "factory_reset":{ "en": "Factory Reset", "de": "Werkseinstellung", "es": "Reiniciar Fábrica" }
    }

    RowLayout {
        // Force anchors to left and right boundaries to avoid any layout calculations leaving black gaps
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        spacing: settingsRoot.cardSpacing

        // =====================================================
        // CARD 1: MODES & ENVIRONMENT
        // =====================================================
        BaseCard {
            Layout.fillWidth: true
            Layout.preferredWidth: 240
            Layout.fillHeight: true
            title: settingsRoot.translations["modes_title"][settingsState.language]
 

            Column {
                anchors.fill: parent
                anchors.margins: settingsRoot.innerMargin
                spacing: 19

                Item {
                    width: parent.width
                    height: 32
                    
                    Image { 
                        id: unitsIcon
                        source: settingsState.dayNightMode === "day"
                                 ? "qrc:/assets/icons/Light/SettingsPage/units.png"
                                 : "qrc:/assets/icons/Dark/SettingsPage/units.png" 
                        width: 29
                        height: 29
                        anchors.verticalCenter: parent.verticalCenter 
                    }
                    Text { 
                        text: settingsRoot.translations["units"][settingsState.language]
                        color: Colors.textPrimary
                        font.family: Typography.family
                        font.pixelSize: Typography.bodyLarge
                        font.weight: Font.DemiBold
                        anchors.left: unitsIcon.right
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                Row {
                    spacing: 8
                    width: parent.width
                    
                    Rectangle {
                        width: (parent.width - 8) / 2; height: 54; radius: Theme.controlRadius*1.67
                        color: settingsState.units === "metric" ? Colors.surfacePressed : Colors.surfaceRaised
                        border.width: 1
                        border.color: settingsState.units === "metric" ? Colors.borderActive : Colors.borderSubtle
                        
                        Text { anchors.centerIn: parent; text: "Metric\nkm/h, °C"; color: settingsState.units === "metric" ? Colors.textPrimary : Colors.textMuted; font.pixelSize: 17; font.weight: Font.DemiBold; horizontalAlignment: Text.AlignCenter }
                        MouseArea { anchors.fill: parent; onClicked: settingsState.units = "metric" }
                    }
                    
                    Rectangle {
                        width: (parent.width - 8) / 2; height: 54; radius: Theme.controlRadius*1.67
                        color: settingsState.units === "imperial" ? Colors.surfacePressed : Colors.surfaceRaised
                        border.width: 1
                        border.color: settingsState.units === "imperial" ? Colors.borderActive : Colors.borderSubtle
                        
                        Text { anchors.centerIn: parent; text: "Imperial\nmph, °F"; color: settingsState.units === "imperial" ? Colors.textPrimary : Colors.textMuted; font.pixelSize: 17; font.weight: Font.DemiBold; horizontalAlignment: Text.AlignCenter }
                        MouseArea { anchors.fill: parent; onClicked: settingsState.units = "imperial" }
                    }
                }

                Item {
                    width: parent.width
                    height: 32
                    Image { 
                        id: langIcon
                        source: settingsState.dayNightMode === "day"
                                 ? "qrc:/assets/icons/Light/SettingsPage/language.png"
                                 : "qrc:/assets/icons/Dark/SettingsPage/language.png"
                        width: 29
                        height: 29
                        anchors.verticalCenter: parent.verticalCenter 
                    }
                    Text { 
                        text: settingsRoot.translations["language"][settingsState.language]
                        color: Colors.textPrimary
                        font.family: Typography.family
                        font.pixelSize: Typography.bodyLarge
                        font.weight: Font.DemiBold
                        anchors.left: langIcon.right
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                Row {
                    spacing: 4
                    width: parent.width
                    
                    Rectangle {
                        width: (parent.width - 8) / 3; height: 48; radius: Theme.controlRadius*1.67
                        color: settingsState.language === "en" ? Colors.surfacePressed : Colors.surfaceRaised
                        border.width: 1; border.color: settingsState.language === "en" ? Colors.borderActive : Colors.borderSubtle
                        Text { anchors.centerIn: parent; text: "ENG"; color: settingsState.language === "en" ? Colors.textPrimary : Colors.textMuted; font.pixelSize: 17; font.weight: Font.DemiBold }
                        MouseArea { 
                            anchors.fill: parent
                            onClicked: { 
                                     settingsState.language = "en"
                                     Typography.currentLanguage = "en"
                                      }
                        }
                    }
                    
                    Rectangle {
                        width: (parent.width - 8) / 3; height: 48; radius: Theme.controlRadius*1.67
                        color: settingsState.language === "de" ? Colors.surfacePressed : Colors.surfaceRaised
                        border.width: 1; border.color: settingsState.language === "de" ? Colors.borderActive : Colors.borderSubtle
                        Text { anchors.centerIn: parent; text: "GER"; color: settingsState.language === "de" ? Colors.textPrimary : Colors.textMuted; font.pixelSize: 17; font.weight: Font.DemiBold }
                        MouseArea { 
                            anchors.fill: parent
                            onClicked: { 
                                         settingsState.language = "de"
                                         Typography.currentLanguage = "de"
                                       }
                        }
                    }
                    
                    Rectangle {
                        width: (parent.width - 8) / 3; height: 48; radius: Theme.controlRadius*1.67
                        color: settingsState.language === "es" ? Colors.surfacePressed : Colors.surfaceRaised
                        border.width: 1; border.color: settingsState.language === "es" ? Colors.borderActive : Colors.borderSubtle
                        Text { anchors.centerIn: parent; text: "ESP"; color: settingsState.language === "es" ? Colors.textPrimary : Colors.textMuted; font.pixelSize: 17; font.weight: Font.DemiBold }
                        MouseArea { 
                            anchors.fill: parent
                            onClicked: { 
                                         settingsState.language = "es"
                                         Typography.currentLanguage = "es"
                                       }
                        }
                    }
                }

                Rectangle { width: parent.width; height: 1; color: Colors.borderSubtle }

                Item {
                    width: parent.width
                    height: 32
                    Image { 
                        id: dayNightIcon
                        source: settingsState.dayNightMode === "day"
                                 ? "qrc:/assets/icons/Light/SettingsPage/day-night-mode.png"
                                 : "qrc:/assets/icons/Dark/SettingsPage/day-night-mode.png"
                        width: 29
                        height: 29
                        anchors.verticalCenter: parent.verticalCenter 
                    }
                    Text { 
                        text: settingsRoot.translations["day_night"][settingsState.language]
                        color: Colors.textPrimary
                        font.family: Typography.family
                        font.pixelSize: Typography.bodyLarge
                        font.weight: Font.DemiBold
                        anchors.left: dayNightIcon.right
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                Row {
                    spacing: 4
                    width: parent.width
                    
                    Rectangle {
                        width: (parent.width - 8) / 3; height: 48; radius: Theme.controlRadius*1.67
                        color: settingsState.dayNightMode === "auto" ? Colors.surfacePressed : Colors.surfaceRaised
                        border.width: 1
                        border.color: settingsState.dayNightMode === "auto" ? Colors.borderActive : Colors.borderSubtle
                        
                        Text { 
                            anchors.centerIn: parent
                            text: "Auto"
                            color: settingsState.dayNightMode === "auto" ? Colors.textPrimary : Colors.textMuted
                            font.pixelSize: 17
                            font.weight: Font.DemiBold 
                        }
                        MouseArea { 
                            anchors.fill: parent
                            onClicked: {
                                settingsState.dayNightMode = "auto"
                                Colors.dayNightMode = "auto"
                            }
                        }
                    }
                    
                    Rectangle {
                        width: (parent.width - 8) / 3; height: 48; radius: Theme.controlRadius*1.67
                        color: settingsState.dayNightMode === "day" ? Colors.surfacePressed : Colors.surfaceRaised
                        border.width: 1
                        border.color: settingsState.dayNightMode === "day" ? Colors.borderActive : Colors.borderSubtle
                        
                        Text { 
                            anchors.centerIn: parent
                            text: "Day"
                            color: settingsState.dayNightMode === "day" ? Colors.textPrimary : Colors.textMuted
                            font.pixelSize: 17
                            font.weight: Font.DemiBold 
                        }
                        MouseArea { 
                            anchors.fill: parent
                            onClicked: {
                                settingsState.dayNightMode = "day"
                                Colors.dayNightMode = "day"
                            }
                        }
                    }
                    
                    Rectangle {
                        width: (parent.width - 8) / 3; height: 48; radius: Theme.controlRadius*1.67
                        color: settingsState.dayNightMode === "night" ? Colors.surfacePressed : Colors.surfaceRaised
                        border.width: 1
                        border.color: settingsState.dayNightMode === "night" ? Colors.borderActive : Colors.borderSubtle
                        
                        Text { 
                            anchors.centerIn: parent
                            text: "Night"
                            color: settingsState.dayNightMode === "night" ? Colors.textPrimary : Colors.textMuted
                            font.pixelSize: 17
                            font.weight: Font.DemiBold 
                        }
                        MouseArea { 
                            anchors.fill: parent
                            onClicked: {
                                settingsState.dayNightMode = "night"
                                Colors.dayNightMode = "night"
                            }
                        }
                    }
                }
            }
        }

        // =====================================================
        // CARD 2: DISPLAY VISUALS
        // =====================================================
        BaseCard {
            Layout.fillWidth: true
            Layout.preferredWidth: 260
            Layout.fillHeight: true
            title: settingsRoot.translations["display_title"][settingsState.language]

            Column {
                anchors.fill: parent
                anchors.margins: settingsRoot.innerMargin
                spacing: 22 

                Item {
                    width: parent.width
                    height: 32
                    Image { id: themeIcon
                        source: settingsState.dayNightMode === "day"
                                 ? "qrc:/assets/icons/Light/SettingsPage/theme.png"
                                 : "qrc:/assets/icons/Dark/SettingsPage/theme.png"
                        width: 29
                        height: 29
                        anchors.verticalCenter: parent.verticalCenter
                     }

                    Text { 
                        text: settingsRoot.translations["theme"][settingsState.language]
                        color: Colors.textPrimary
                        font.family: Typography.family
                        font.pixelSize: Typography.bodyLarge
                        font.weight: Font.DemiBold
                        anchors.left: themeIcon.right
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                Row {
                    spacing: 38
                    anchors.horizontalCenter: parent.horizontalCenter
                    
                    Column {
                        spacing: 6
                        Rectangle { 
                            width: 45; height: 45; radius: 22
                            color: "transparent"
                            border.width: Colors.themeName === "ICE" ? 2 : 1
                            border.color: Colors.themeName === "ICE" ? Colors.borderActive : "transparent"
                            
                            Rectangle {
                                anchors.fill: parent; anchors.margins: 3; radius: 11
                                gradient: Gradient {
                                    GradientStop { position: 0.0; color: "#72D7FF" }
                                    GradientStop { position: 1.0; color: "#0088cc" }
                                }
                            }
                            MouseArea { anchors.fill: parent; onClicked: Colors.themeName = "ICE" }
                        }
                        Text { text: "Ice"; color: Colors.themeName === "ICE" ? Colors.textPrimary : Colors.textMuted; font.pixelSize: 17; font.weight: Colors.themeName === "ICE" ? Font.DemiBold : Font.Normal; anchors.horizontalCenter: parent.horizontalCenter }
                    }

                    Column {
                        spacing: 6
                        Rectangle { 
                            width: 45; height: 45; radius: 22
                            color: "transparent"
                            border.width: Colors.themeName === "LAVENDER" ? 2 : 1
                            border.color: Colors.themeName === "LAVENDER" ? Colors.borderActive : "transparent"
                            
                            Rectangle {
                                anchors.fill: parent; anchors.margins: 3; radius: 11
                                gradient: Gradient {
                                    GradientStop { position: 0.0; color: "#F0B84D" }
                                    GradientStop { position: 1.0; color: "#b84a22" }
                                }
                            }
                            MouseArea { anchors.fill: parent; onClicked: Colors.themeName = "LAVENDER" }
                        }
                        Text { text: "Ember"; color: Colors.themeName === "LAVENDER" ? Colors.textPrimary : Colors.textMuted; font.pixelSize: 17; font.weight: Colors.themeName === "LAVENDER" ? Font.DemiBold : Font.Normal; anchors.horizontalCenter: parent.horizontalCenter }
                    }

                    Column {
                        spacing: 6
                        Rectangle { 
                            width: 45; height: 45; radius: 22
                            color: "transparent"
                            border.width: Colors.themeName === "SAKURA" ? 2 : 1
                            border.color: Colors.themeName === "SAKURA" ? Colors.borderActive : "transparent"
                            
                            Rectangle {
                                anchors.fill: parent; anchors.margins: 3; radius: 11
                                gradient: Gradient {
                                    GradientStop { position: 0.0; color: "#E29572" }
                                    GradientStop { position: 1.0; color: "#6e4431" }
                                }
                            }
                            MouseArea { anchors.fill: parent; onClicked: Colors.themeName = "SAKURA" }
                        }
                        Text { text: "SAKURA"; color: Colors.themeName === "SAKURA" ? Colors.textPrimary : Colors.textMuted; font.pixelSize: 17; font.weight: Colors.themeName === "SAKURA" ? Font.DemiBold : Font.Normal; anchors.horizontalCenter: parent.horizontalCenter }
                    }
                }

                Item {
                    width: parent.width
                    height: 32
                    Image { 
                        id: brightnessIcon
                        source: settingsState.dayNightMode === "day"
                                 ? "qrc:/assets/icons/Light/SettingsPage/brightness.png"
                                 : "qrc:/assets/icons/Dark/SettingsPage/brightness.png"
                        width: 29
                        height: 29
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                     }
                    Text { text: settingsRoot.translations["brightness"][settingsState.language]; color: Colors.textPrimary; font.family: Typography.family; font.pixelSize: Typography.bodyLarge; font.weight: Font.DemiBold; anchors.left: brightnessIcon.right; anchors.verticalCenter: parent.verticalCenter }
                    Text { text: Math.round(settingsState.brightness) + "%"; color: Colors.textPrimary; font.family: Typography.family; font.pixelSize: Typography.bodyLarge; font.weight: Font.Bold; anchors.right: parent.right; anchors.verticalCenter: parent.verticalCenter }
                }
                Slider {
                    width: parent.width; height: 35
                    from: 0; to: 100; value: settingsState.brightness
                    onValueChanged: { settingsState.brightness = value }
                }

                Item {
                    width: parent.width
                    height: 32
                    Image { 
                        id: contrastIcon
                        source: settingsState.dayNightMode === "day"
                                 ? "qrc:/assets/icons/Light/SettingsPage/contrast.png"
                                 : "qrc:/assets/icons/Dark/SettingsPage/contrast.png"
                        width: 29
                        height: 29
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter 
                    }
                    Text { text: settingsRoot.translations["contrast"][settingsState.language]; color: Colors.textPrimary; font.family: Typography.family; font.pixelSize: Typography.bodyLarge; font.weight: Font.DemiBold; anchors.left: contrastIcon.right; anchors.verticalCenter: parent.verticalCenter }
                    Text { text: Math.round(settingsState.contrast) + "%"; color: Colors.textPrimary; font.family: Typography.family; font.pixelSize: Typography.bodyLarge; font.weight: Font.Bold; anchors.right: parent.right; anchors.verticalCenter: parent.verticalCenter }
                }
                Slider {
                    width: parent.width; height: 35
                    from: 0; to: 100; value: settingsState.contrast
                    onValueChanged: { settingsState.contrast = value }
                }
            }
        }

        // =====================================================
        // CARD 3: SOUND TELEMETRY
        // =====================================================
        BaseCard {
            Layout.fillWidth: true
            Layout.fillHeight: true
            title: settingsRoot.translations["volume_title"][settingsState.language]

            Column {
                anchors.fill: parent
                anchors.margins: settingsRoot.innerMargin
                spacing: 16

                Item {
                    width: parent.width
                    height: 32
                    Image { 
                        id: alertIcon
                        source: settingsState.dayNightMode === "day"
                                 ? "qrc:/assets/icons/Light/SettingsPage/alert-vol.png"
                                 : "qrc:/assets/icons/Dark/SettingsPage/alert-vol.png"
                        width: 29
                        height: 29
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                     }
                    Text { text: settingsRoot.translations["alert"][settingsState.language]; color: Colors.textPrimary; font.family: Typography.family; font.pixelSize: Typography.bodyLarge; font.weight: Font.DemiBold; anchors.left: alertIcon.right; anchors.verticalCenter: parent.verticalCenter }
                    Text { text: Math.round(settingsState.alertVolume) + "%"; color: Colors.textPrimary; font.family: Typography.family; font.pixelSize: Typography.bodyLarge; font.weight: Font.Bold; anchors.right: parent.right; anchors.verticalCenter: parent.verticalCenter }
                }
                Slider {
                    width: parent.width; height: 35
                    from: 0; to: 100; value: settingsState.alertVolume
                    onValueChanged: { settingsState.alertVolume = value }
                }
                Item {
                    width: parent.width; height: 22
                    Text { text: "0%"; color: Colors.textMuted; font.pixelSize: 15; anchors.left: parent.left }
                    Text { text: "50%"; color: Colors.textMuted; font.pixelSize: 15; anchors.horizontalCenter: parent.horizontalCenter }
                    Text { text: "100%"; color: Colors.textMuted; font.pixelSize: 15; anchors.right: parent.right }
                }

                Item { width: 1; height: 8 }

                Item {
                    width: parent.width
                    height: 32
                    Image {
                        id: indicatorIcon
                        source: settingsState.dayNightMode === "day"
                                 ? "qrc:/assets/icons/Light/SettingsPage/indicator-vol.png"
                                 : "qrc:/assets/icons/Dark/SettingsPage/indicator-vol.png"
                        width: 29
                        height: 29
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter 
                    }
                    Text { text: settingsRoot.translations["indicator"][settingsState.language]; color: Colors.textPrimary; font.family: Typography.family; font.pixelSize: Typography.bodyLarge; font.weight: Font.DemiBold; anchors.left: indicatorIcon.right; anchors.verticalCenter: parent.verticalCenter }
                    Text { text: Math.round(settingsState.indicatorVolume) + "%"; color: Colors.textPrimary; font.family: Typography.family; font.pixelSize: Typography.bodyLarge; font.weight: Font.Bold; anchors.right: parent.right; anchors.verticalCenter: parent.verticalCenter }
                }
                Slider {
                    width: parent.width; height: 35
                    from: 0; to: 100; value: settingsState.indicatorVolume
                    onValueChanged: { settingsState.indicatorVolume = value }
                }
                Item {
                    width: parent.width; height: 22
                    Text { text: "0%"; color: Colors.textMuted; font.pixelSize: 15; anchors.left: parent.left }
                    Text { text: "50%"; color: Colors.textMuted; font.pixelSize: 15; anchors.horizontalCenter: parent.horizontalCenter }
                    Text { text: "100%"; color: Colors.textMuted; font.pixelSize: 15; anchors.right: parent.right }
                }
            }
        }

        // =====================================================
        // CARD 4: SYSTEM PROPERTIES
        // =====================================================
        BaseCard {
            Layout.fillWidth: true
            Layout.fillHeight: true
            title: settingsRoot.translations["system_title"][settingsState.language]

            Column {
                anchors.fill: parent
                anchors.margins: settingsRoot.innerMargin
                spacing: 19

                Item {
                    width: parent.width
                    height: 32
                    Image { 
                        id: clockIcon
                        source: settingsState.dayNightMode === "day"
                                 ? "qrc:/assets/icons/Light/SettingsPage/clock-format.png"
                                 : "qrc:/assets/icons/Dark/SettingsPage/clock-format.png"
                        width: 29
                        height: 29
                        anchors.verticalCenter: parent.verticalCenter 
                    }
                    Text { 
                        text: settingsRoot.translations["clock_format"][settingsState.language]
                        color: Colors.textPrimary
                        font.family: Typography.family
                        font.pixelSize: Typography.bodyLarge
                        font.weight: Font.DemiBold
                        anchors.left: clockIcon.right
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                Row {
                    spacing: 6; width: parent.width
                    
                    Rectangle {
                        width: (parent.width - 6) / 2; height: 48; radius: Theme.controlRadius*1.67
                        color: settingsState.clockFormat === 12 ? Colors.surfacePressed : Colors.surfaceRaised
                        border.width: 1; border.color: settingsState.clockFormat === 12 ? Colors.borderActive : Colors.borderSubtle
                        Text { anchors.centerIn: parent; text: "12 Hour"; color: settingsState.clockFormat === 12 ? Colors.textPrimary : Colors.textMuted; font.pixelSize: 19; font.weight: settingsState.clockFormat === 12 ? Font.DemiBold : Font.Normal }
                        MouseArea { anchors.fill: parent; 
                                     onClicked: {settingsState.clockFormat = 12
                                                 Typography.timeFormat = "hh:mm AP" }}
                    }
                    
                    Rectangle {
                        width: (parent.width - 6) / 2; height: 48; radius: Theme.controlRadius*1.67
                        color: settingsState.clockFormat === 24 ? Colors.surfacePressed : Colors.surfaceRaised
                        border.width: 1; border.color: settingsState.clockFormat === 24 ? Colors.borderActive : Colors.borderSubtle
                        Text { anchors.centerIn: parent; text: "24 Hour"; color: settingsState.clockFormat === 24 ? Colors.textPrimary : Colors.textMuted; font.pixelSize: 19; font.weight: settingsState.clockFormat === 24 ? Font.DemiBold : Font.Normal }
                        MouseArea { anchors.fill: parent
                                     onClicked: {settingsState.clockFormat = 24
                                                 Typography.timeFormat = "HH:mm" }
                                                 }
                    }
                }

                Item {
                    width: parent.width
                    height: 32
                    Image { 
                        id: dateIcon
                        source: settingsState.dayNightMode === "day"
                                 ? "qrc:/assets/icons/Light/SettingsPage/date-format.png"
                                 : "qrc:/assets/icons/Dark/SettingsPage/date-format.png"
                        width: 29
                        height: 29
                        anchors.verticalCenter: parent.verticalCenter 
                    }
                    Text { 
                        text: settingsRoot.translations["date_format"][settingsState.language]
                        color: Colors.textPrimary
                        font.family: Typography.family
                        font.pixelSize: Typography.bodyLarge
                        font.weight: Font.DemiBold
                        anchors.left: dateIcon.right
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                Row {
                    spacing: 6; width: parent.width
                    
                    Rectangle {
                        width: (parent.width - 6) / 2; height: 48; radius: Theme.controlRadius*1.67
                        color: settingsState.dateFormat === "dd" ? Colors.surfacePressed : Colors.surfaceRaised
                        border.width: 1; border.color: settingsState.dateFormat === "dd" ? Colors.borderActive : Colors.borderSubtle
                        Text { anchors.centerIn: parent; text: "DD/MM/YY"; color: settingsState.dateFormat === "dd" ? Colors.textPrimary : Colors.textMuted; font.pixelSize: 17; font.weight: settingsState.dateFormat === "dd" ? Font.DemiBold : Font.Normal }
                        MouseArea { anchors.fill: parent; onClicked: settingsState.dateFormat = "dd" }
                    }
                    
                    Rectangle {
                        width: (parent.width - 6) / 2; height: 48; radius: Theme.controlRadius*1.67
                        color: settingsState.dateFormat === "mm" ? Colors.surfacePressed : Colors.surfaceRaised
                        border.width: 1; border.color: settingsState.dateFormat === "mm" ? Colors.borderActive : Colors.borderSubtle
                        Text { anchors.centerIn: parent; text: "MM/DD/YY"; color: settingsState.dateFormat === "mm" ? Colors.textPrimary : Colors.textMuted; font.pixelSize: 17; font.weight: settingsState.dateFormat === "mm" ? Font.DemiBold : Font.Normal }
                        MouseArea { anchors.fill: parent; onClicked: settingsState.dateFormat = "mm" }
                    }
                }

                Item {
                    width: parent.width
                    height: 32
                    Image { 
                        id: aboutIcon
                        source: settingsState.dayNightMode === "day"
                                 ? "qrc:/assets/icons/Light/SettingsPage/about.png"
                                 : "qrc:/assets/icons/Dark/SettingsPage/about.png"
                        width: 29
                        height: 29
                        anchors.verticalCenter: parent.verticalCenter 
                    }

                    Text { 
                        text: settingsRoot.translations["about"][settingsState.language]
                        color: Colors.textPrimary
                        font.family: Typography.family
                        font.pixelSize: Typography.bodyLarge
                        font.weight: Font.DemiBold
                        anchors.left: aboutIcon.right
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                
                Grid {
                    columns: 2; spacing: 6; width: parent.width
                    Text { text: "Firmware Version"; color: Colors.textMuted; font.pixelSize: 17; width: parent.width * 0.55 }
                    Text { text: "v1.2.3"; color: Colors.textPrimary; font.pixelSize: 17; font.weight: Font.DemiBold; horizontalAlignment: Text.AlignRight; width: parent.width * 0.45 }
                    Text { text: "Build Number"; color: Colors.textMuted; font.pixelSize: 17; width: parent.width * 0.45 }
                    Text { text: "2024.05.28.01"; color: Colors.textPrimary; font.pixelSize: 17; font.weight: Font.DemiBold; horizontalAlignment: Text.AlignRight; width: parent.width * 0.55 }
                }

                Rectangle {
                    width: parent.width; height: 51; radius: Theme.controlRadius*1.67
                    color: "transparent"; border.width: 1; border.color: "#88ff4444"
                    
                    Row {
                        anchors.centerIn: parent; spacing: 8
                        Text { text: settingsRoot.translations["factory_reset"][settingsState.language]; color: "#ff4444"; font.weight: Font.Bold; font.pixelSize: 19 }
                        Image { 
                            source: settingsState.dayNightMode === "day"
                                    ? "qrc:/assets/icons/Light/SettingsPage/restart.png"
                                    : "qrc:/assets/icons/Dark/SettingsPage/restart.png"
                            width: 22
                            height: 22
                            anchors.verticalCenter: parent.verticalCenter 
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        onPressed: parent.color = "#22ff4444"
                        onReleased: parent.color = "transparent"
                        onClicked: {
                            settingsState.brightness = 70
                            settingsState.contrast = 55
                            settingsState.alertVolume = 66
                            settingsState.indicatorVolume = 40
                            settingsState.units = "metric"
                            settingsState.language = "en"
                            settingsState.dayNightMode = "auto"
                            settingsState.clockFormat = 24
                            settingsState.dateFormat = "dd"

                            Colors.themeName = "ICE"
                            Colors.dayNightMode = "auto"           // Forces background palettes to follow system defaults
                            Typography.currentLanguage = "en"
                        }
                    }
                }
            }
        }
    }
}