import QtQuick
import EvHmi

BaseCard {
    id: root

    title: ""

    property real displayedSpeed: vehicleData.speed
    property real displayedRpm: vehicleData.rpm

    // Automatically repaint canvas only when the animated speed value changes
    onDisplayedSpeedChanged: gaugeCanvas.requestPaint()

    Behavior on displayedSpeed {
        NumberAnimation {
            duration: 350
            easing.type: Easing.OutCubic
        }
    }

    Behavior on displayedRpm {
        NumberAnimation {
            duration: 250
            easing.type: Easing.OutCubic
        }
    }

    Canvas {
        id: gaugeCanvas

        anchors.fill: parent
        anchors.margins: 24 * Theme.scale

        antialiasing: true

        onPaint: {
            var ctx = getContext("2d")
            ctx.reset()

            var w = width
            var h = height

            var cx = w / 2
            var cy = h * 0.68

            var radius = Math.min(w, h) * 0.42

            var startAngle = Math.PI * 0.80
            var endAngleMax = Math.PI * 2.20

            var progress = Math.min(root.displayedSpeed, 200) / 200

            var activeEnd = startAngle + ((endAngleMax - startAngle) * progress)

            // Background Arc
            ctx.beginPath()
            ctx.arc(cx, cy, radius, startAngle, endAngleMax)
            ctx.lineWidth = 8 * Theme.scale
            ctx.strokeStyle = Colors.surfaceSunken
            ctx.stroke()

            // Active Arc
            ctx.beginPath()
            ctx.arc(cx, cy, radius, startAngle, activeEnd)
            ctx.lineWidth = 10 * Theme.scale
            ctx.shadowColor = Colors.borderActive
            ctx.shadowBlur = 18 * Theme.scale
            ctx.strokeStyle = Colors.borderActive
            ctx.stroke()
            ctx.shadowBlur = 0

            // Tick Marks
            ctx.strokeStyle = Colors.textMuted
            ctx.lineWidth = 2 * Theme.scale

            var totalAngleRange = endAngleMax - startAngle

            for (var i = 0; i <= 20; i++) {
                var angle = startAngle + (totalAngleRange * (i / 20))
                
                // Cache trig results to optimize performance loop
                var cosA = Math.cos(angle)
                var sinA = Math.sin(angle)

                var outer = radius
                var inner = (i % 5 === 0) 
                    ? radius - (18 * Theme.scale) 
                    : radius - (10 * Theme.scale)

                ctx.beginPath()
                ctx.moveTo(cx + cosA * inner, cy + sinA * inner)
                ctx.lineTo(cx + cosA * outer, cy + sinA * outer)
                ctx.stroke()
            }

            // Needle
            ctx.beginPath()
            ctx.moveTo(cx, cy)

            var needleLength = radius - (26 * Theme.scale)
            ctx.lineTo(
                cx + Math.cos(activeEnd) * needleLength,
                cy + Math.sin(activeEnd) * needleLength
            )

            ctx.lineWidth = 4 * Theme.scale
            ctx.strokeStyle = Colors.borderActive
            ctx.stroke()

            // Hub
            ctx.beginPath()
            ctx.arc(cx, cy, 8 * Theme.scale, 0, Math.PI * 2)
            ctx.shadowColor = Colors.borderActive
            ctx.shadowBlur = 12 * Theme.scale
            ctx.fillStyle = Colors.borderActive
            ctx.fill()
            ctx.shadowBlur = 0
        }
    }

    Column {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -20 * Theme.scale

        spacing: 4 * Theme.scale

        Text {
            id: speedText

            text: Math.round(root.displayedSpeed)
            anchors.horizontalCenter: parent.horizontalCenter
            color: Colors.textPrimary

            font.family: Typography.family
            font.pixelSize: Typography.displayLarge
            font.bold: true

            scale: 1.0 + (root.displayedSpeed / 200) * 0.06

            Behavior on scale {
                NumberAnimation {
                    duration: 250
                    easing.type: Easing.OutCubic
                }
            }

            Rectangle {
                anchors.centerIn: parent

                width: speedText.width + 40
                height: speedText.height + 20
                radius: height / 2

                color: Colors.borderActive
                opacity: 0.08
                z: -1
            }
        }

        Text {
            text: "km/h"
            anchors.horizontalCenter: parent.horizontalCenter
            color: Colors.textSecondary

            font.family: Typography.family
            font.pixelSize: Typography.bodyLarge
        }

        Item {
            width: 1
            height: 16 * Theme.scale
        }

        Text {
            text: "RPM"
            anchors.horizontalCenter: parent.horizontalCenter
            color: Colors.textMuted

            font.family: Typography.family
            font.pixelSize: Typography.bodySmall
            font.bold: true
        }

        Text {
            text: Math.round(root.displayedRpm)
            anchors.horizontalCenter: parent.horizontalCenter
            color: Colors.textPrimary

            font.family: Typography.family
            font.pixelSize: Typography.titleLarge
            font.weight: Font.DemiBold
        }
    }
}