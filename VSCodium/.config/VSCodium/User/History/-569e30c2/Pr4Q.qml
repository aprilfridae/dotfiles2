import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

ShellRoot {
    // 1. Theme Logic
    property var theme: ({})
    
    function updateTheme() {
        try {
            var path = Quickshell.env("HOME") + "/.cache/matugen/colors.json";
            var data = Quickshell.readFile(path);
            theme = JSON.parse(data).colors;
            console.log("Matugen colors updated!");
        } catch (e) { 
            console.log("Waiting for Matugen JSON... Run 'matugen image' to fix."); 
        }
    }

    Component.onCompleted: updateTheme()

    // 2. The Bar Definition
    Variants {
        model: Quickshell.screens
        
        delegate: Component {
            PanelWindow {
                // REQUIRED: This tells the window which screen it belongs to
                required property var modelData
                screen: modelData

                // Layer Shell Config
                WlrLayershell.layer: WlrLayer.Top
                WlrLayershell.namespace: "quickshell-bar"

                anchors {
                    top: true
                    left: true
                    right: true
                }
                
                // FIX: height is deprecated, use implicitHeight
                implicitHeight: 32
                
                // Fallback to a dark gray if theme is empty
                color: theme.surface || "#1e1e2e"

                // Content container
                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 20
                    anchors.rightMargin: 20
                    spacing: 10

                    Text {
                        text: ""
                        color: theme.on_surface || "#ffffff"
                        font.pixelSize: 20
                        Layout.alignment: Qt.AlignVCenter
                    }

                    // This pushes the clock to the far right
                    Item { Layout.fillWidth: true } 
                    
                    Text {
                        text: Qt.formatDateTime(new Date(), "ddd d MMM h:mm AP")
                        color: theme.on_surface || "#ffffff"
                        font.pixelSize: 13
                        font.weight: Font.Demi