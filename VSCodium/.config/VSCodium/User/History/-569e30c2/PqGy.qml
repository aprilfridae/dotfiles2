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
                required property var modelData
                screen: modelData

                WlrLayershell.layer: WlrLayer.Top
                WlrLayershell.namespace: "quickshell-bar"

                anchors {
                    top: true
                    left: true
                    right: true
                }
                
                implicitHeight: 32
                color: theme.surface || "#1e1e2e"

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

                    Item { Layout.fillWidth: true } 
                    
                    Text {
                        text: Qt.formatDateTime(new Date(), "ddd d MMM h:mm AP")
                        color: theme.on_surface || "#ffffff"
                        font.pixelSize: 13
                        font.weight: Font.DemiBold
                        Layout.alignment: Qt.AlignVCenter
                    }
                } // End RowLayout
            } // End PanelWindow
        } // End Component
    } // End Variants
} // End ShellRoot