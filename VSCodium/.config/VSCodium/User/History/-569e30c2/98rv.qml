import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

ShellRoot {
    // 1. Load your Matugen colors
    property var theme: ({})
    
    function updateTheme() {
        try {
            var data = Quickshell.readFile(Quickshell.env("HOME") + "/.cache/matugen/colors.json");
            theme = JSON.parse(data).colors;
        } catch (e) { console.log("Matugen JSON not found yet!"); }
    }

    Component.onCompleted: updateTheme()

    // 2. Create the Bar on every monitor
    Variants {
        model: Quickshell.screens
        
        delegate: Component {
            PanelWindow {
                // Variants injects modelData into this property
                required property var modelData
                screen: modelData

                anchors {
                    top: true
                    left: true
                    right: true
                }
                
                height: 32
                color: theme.surface || "#1e1e2e"

                // ALL content must be children of the PanelWindow
                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 15
                    anchors.rightMargin: 15

                    Text {
                        text: "" 
                        color: theme.on_surface || "white"
                        font.pixelSize: 18
                        verticalAlignment: Text.AlignVCenter
                    }

                    // Spacer to push the clock to the right
                    Item { Layout.fillWidth: true } 
                    
                    Text {
                        text: Qt.formatDateTime(new Date(), "ddd d MMM h:mm AP")
                        color: theme.on_surface || "white"
                        font.pixelSize: 14
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }
    }
}