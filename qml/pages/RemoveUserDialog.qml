import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    property string name
    anchors.fill: parent
    DialogHeader {
        acceptText: qsTr("Remove")
    }
    Label {
        anchors.centerIn: parent
        color: Theme.highlightColor
        font.pixelSize: Theme.fontSizeLarge
        text: qsTr("Remove %1?", "1-username").arg(name)
    }
}
