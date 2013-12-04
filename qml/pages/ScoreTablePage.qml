import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    property var players
    id: page
    Component.onCompleted: {
        players.sort(function(a,b){
            if (b.total - a.total === 0) {
                //calculate size of histories (TODO: solve why it is lost)
                var lengthS = [0,0]
                var ab = [a,b]
                for (var i = 0; i < 2; ++i) {
                    for (var k in ab[i].history) {
                        lengthS[i]++
                    }
                }
                return lengthS[0] - lengthS[1]
            }
            return b.total - a.total
        })
        for (var i in players)
            playersModel.append(players[i])
    }
    PageHeader {
        id: hea
        title: qsTr("Score Table")
    }
    ListModel {
        id: playersModel
    }
    Component {
        id:playersDelegate
        ListItem {
            Label {
                text: (index + 1) + ". " + playersModel.get(index).name + ", " + playersModel.get(index).total
                color: playersDelegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                x: Theme.paddingLarge
            }
            onClicked: {
                pageStack.push("UserStatisticsPage.qml", {"player": players[index]})
            }
        }
    }
    SilicaListView {
        id: listView
        model: playersModel
        delegate: playersDelegate
        anchors {
            top: hea.bottom
            bottom: parent.bottom
        }
        width: parent.width
    }

}
