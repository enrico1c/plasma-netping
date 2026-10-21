import QtQuick
import org.kde.plasma.plasmoid
import org.kde.plasma.plasma5support as P5Support
import org.kde.plasma.components as PlasmaComponents
import QtQuick.Layouts

PlasmoidItem {
    id: root
    property string pingText: "…"

    P5Support.DataSource {
        id: exec
        engine: "executable"
        interval: 5000
        onNewData: (sourceName, data) => {
            root.pingText = data["stdout"].trim() || "…"
        }
        Component.onCompleted: connectSource("$HOME/bin/netping")
    }

    compactRepresentation: PlasmaComponents.Label {
        text: root.pingText
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        Layout.minimumWidth: implicitWidth
        Layout.preferredWidth: implicitWidth
        Layout.fillHeight: true

        MouseArea {
            anchors.fill: parent
            onClicked: root.expanded = !root.expanded
        }
    }

    fullRepresentation: Item {
        implicitWidth: fullLabel.implicitWidth + 24
        implicitHeight: fullLabel.implicitHeight + 24

        PlasmaComponents.Label {
            id: fullLabel
            anchors.centerIn: parent
            text: root.pingText
        }
    }
}
