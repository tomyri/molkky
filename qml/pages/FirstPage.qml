import QtQuick 2.0
import Sailfish.Silica 1.0
import "../items"

Page {
    id: page
    SilicaFlickable {
        anchors.fill: parent
        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
            MenuItem {
                text: qsTr("New Scoreboard")
                onClicked: pageStack.push(Qt.resolvedUrl("NewGamePage.qml"))
            }
        }
        contentHeight: column.height
        PaddedColumn {
            id: column
            PageHeader {
                title: "Mölkky"
            }
            HeaderLabel {
                text: qsTr("Wellcome!")
            }
            ParagraphLabel {
                text: qsTr("You can start by selecting new scoreboard. If you need help how to play mölkky, check the About page.")
            }
        }
    }
}
