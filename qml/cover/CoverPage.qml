import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    Label {
        id: label
        anchors.centerIn: parent
        text: "mölkky"
    }
    Image {
        id: img
        source: "qrc:/img/game_start_big.png"
        fillMode: Image.PreserveAspectCrop
        anchors.fill: parent
        z: -2
        opacity: Theme.highlightBackgroundOpacity
    }
}


