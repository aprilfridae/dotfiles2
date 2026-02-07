import quickshell
import quickshell.wayland
import QtQuick
import QtQuick.Layouts

ShellRoot {
    // 1. Load your Matugen colors
    property var theme: ({})
    
    // Logic to read Matugen JSON
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
        delegate: PanelWindow {
            anchor: Anchor.Top | Anchor.Left | Anchor.Right
            height: 32
            color: theme.surface || "#1e1e2e" // Fallback color

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 15
                anchors.rightMargin: 15

                Text {
                    text: "" // The classic Mac vibe
                    color: theme.on_surface || "white"
                    font.pixelSize: 18
                }

                // Workspace dots would go here
                // Clock would go here
                
                Item { Layout.fillWidth: true } // Spacer
                
                Text {
                    text: Qt.formatDateTime(new Date(), "ddd d MMM h:mm AP")
                    color: theme.on_surface || "white"
                }
            }
        }
    }
}