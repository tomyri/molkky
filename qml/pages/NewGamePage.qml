import QtQuick 2.0
import Sailfish.Silica 1.0
Page {
    id: page
    //+ Jonas Raoni Soares Silva
    //@ http://jsfromhell.com/array/shuffle [v1.0]
    function shuffle(o){ //v1.0
        for(var j, x, i = o.length; i; j = Math.floor(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
        return o;
    }
    function addPlayer(p) {
        playersModel.append({"name":p})
    }
    PageHeader {
        id: hea
        title: qsTr("New Scoreboard")
    }
    TextField {
        id: newPlayerName
        placeholderText: qsTr("New Player")
        EnterKey.enabled: text.length > 0
        EnterKey.onClicked: {
            addPlayer(text)
            text = ""
        }
        anchors {
            right: addPlayerButton.left
            left: parent.left
            top: hea.bottom
        }
        //NOTE: to fix bug with prediction
        inputMethodHints: Qt.ImhNoPredictiveText
    }
    Button {
        id: addPlayerButton
        text: "+"
        onClicked: {
            addPlayer(newPlayerName.text)
            newPlayerName.text = ""
        }
        anchors {
            right: parent.right
            rightMargin: Theme.paddingLarge
            top: hea.bottom
        }
        width: 60
        height: 60
        enabled: newPlayerName.text !== ""
    }
    ListModel {
        id: playersModel
    }
    Component {
        id:playersDelegate
        ListItem {
            Label {
                text: playersModel.get(index).name
                color: playersDelegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                x: Theme.paddingLarge
            }
            onClicked: {
                var dialog = pageStack.push("RemoveUserDialog.qml",
                                            {"name": playersModel.get(index).name})
                dialog.accepted.connect(function() {
                    playersModel.remove(index)
                })
            }
        }
    }
    Label {
        id: playersLabel
        text: qsTr("Players")
        width: parent.width
        color: Theme.secondaryHighlightColor
        anchors.top: newPlayerName.bottom
        x: Theme.paddingLarge
    }
    Rectangle {
        id: seperatorLine
        height: 2
        color: Theme.secondaryHighlightColor
        width: playersLabel.paintedWidth
        x: Theme.paddingLarge
        anchors.top: playersLabel.bottom
    }
    SilicaListView {
        id: listView
        model: playersModel
        delegate: playersDelegate
        anchors {
            top: seperatorLine.bottom
            topMargin: Theme.paddingLarge
            bottom: bottomButtonRow.top
            bottomMargin: Theme.paddingLarge
        }
        width: parent.width
        boundsBehavior: Flickable.DragOverBounds
        clip: true
    }
    Row {
        id: bottomButtonRow
        anchors {
            bottom: parent.bottom
            bottomMargin: Theme.paddingLarge
            right: parent.right
            rightMargin: Theme.paddingLarge
            left: parent.left
            leftMargin: Theme.paddingLarge
        }
        Switch {
            id: shuffleSwitch
            icon.source: "image://theme/icon-l-shuffle"
        }
        Button {
            id: startButton
            text: qsTr("Start")
            enabled: playersModel.count > 0
            height: 100
            width: parent.width - 100
            onClicked: {
                var moo = []
                for (var i = 0; i < playersModel.count; ++i) {
                    moo.push({"name":playersModel.get(i).name})
                    moo[i].history = []
                    moo[i].total = 0;
                    moo[i].stillInGame = true
                }
                if (shuffleSwitch.checked)
                    moo = shuffle(moo)
                pageStack.push("MarkScorePage.qml", {"players" : moo})
            }
        }
    }
}
