import QtQuick 2.0
import Sailfish.Silica 1.0
import "../items"

/*
  TODO: Ask confirmatin when leaving this page
*/
Page {
    property var players:[]
    property int currentPlayerIndex: 0
    property int round: 1
    property int ballSize: 80
    property bool gameOn: true

    function checkSnap(item) {
        if (item.x + ballSize / 2 > dropArea.x && item.x < dropArea.x + ballSize
                && item.y + ballSize / 2 > dropArea.y && item.y < dropArea.y + ballSize) {
            item.x = dropArea.x + ballSize / 4
            item.y = dropArea.y + ballSize / 4
        }
    }

    function addScore(score) {
        if (!gameOn)
            return
        var scoreI = parseInt(score)
        players[currentPlayerIndex].history.push(scoreI)
        calcCurrentPlayerScore(currentPlayerIndex)
        if (players[currentPlayerIndex].stillInGame === false && players[currentPlayerIndex].total !== 50)
            noticationLabel.text = qsTr("%1 misses three in a row and is out.").arg(players[currentPlayerIndex].name)
        else
            noticationLabel.text = qsTr("%1 scores %2 and has now %3 points.").arg(players[currentPlayerIndex].name).arg(score).arg(players[currentPlayerIndex].total)
        nextPlayer()
    }

    function calcCurrentPlayerScore(index) {
        //check for 3 miss in a row
        if (players[index].history.length > 2) {
            var stillIn = false
            for (var k = 0; k < 3; ++k) {
                if (players[index].history[players[index].history.length - k - 1] !== 0) {
                    stillIn = true
                    break
                }
            }
            if (!stillIn)
                players[index].stillInGame = false
        }
        //calculate total score
        var s = 0
        for (var i in players[index].history) {
            s += players[index].history[i]
            if (s > 50)
                s = 25
        }
        if (s === 50)
            players[index].stillInGame = false
        players[index].total = s
    }

    function nextPlayer() {
        var someOneStillInGame = false
        for (var i in players) {
            if (players[i].stillInGame === true) {
                someOneStillInGame = true
                break
            }
        }
        if (someOneStillInGame === false) {
            noticationLabel.text = qsTr("Game ended")
            updateCurrentPlayerIndex(currentPlayerIndex)
            gameOn = false
            return
        }
        var tmp = currentPlayerIndex
        while (1) {
            if (++tmp == players.length) {
                tmp = 0;
                ++round;
            }
            if (players[tmp].stillInGame === true) {
                updateCurrentPlayerIndex(tmp)
                break
            }
        }
    }

    function undoLastThrow() {
        var playerIndex = currentPlayerIndex
        while (1) {
            if (--playerIndex < 0) {
                if (--round === 0) {
                    round = 1
                    noticationLabel.text = qsTr("Can not undo!")
                    return;
                }
                playerIndex = players.length - 1
            }
            if (players[playerIndex].history.lenght < round) {
                continue
            } else {
                players[playerIndex].history.pop()
                players[playerIndex].stillInGame = true
                gameOn = true
                calcCurrentPlayerScore(playerIndex)
                updateCurrentPlayerIndex(playerIndex)
                return;
            }
        }
    }

    function updateCurrentPlayerIndex(newIndex) {
        if (currentPlayerIndex === newIndex) //dirty fix for ui to refresh scores
            currentPlayerIndex = 999
        currentPlayerIndex = newIndex
    }

    id: page
    width: 500
    height: 900
    SilicaFlickable {
        anchors.fill: parent
        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
            MenuItem {
                text: qsTr("Undo")
                onClicked: undoLastThrow()
            }
            MenuItem {
                text: qsTr("Score Table")
                onClicked: pageStack.push("ScoreTablePage.qml", {"players": players})
                //TODO: Above somehow lost the information that player.history is an array??!?
            }
        }
        contentHeight: page.height
        PaddedColumn {
            PageHeader {
                title: qsTr("Mark Score")
            }
            HeaderLabel {
                id: label
                text: qsTr("Now throwing: %1").arg(players[currentPlayerIndex].name)
                MouseArea {
                    anchors.fill: parent
                    onClicked: pageStack.push("UserStatisticsPage.qml", {"player": players[currentPlayerIndex]})
                }
            }
            ParagraphLabel {
                text: qsTr("Last throws: %1").arg(players[currentPlayerIndex].history.slice(-7))
                width: parent.width
                wrapMode: Text.WordWrap
                font.pixelSize: Theme.fontSizeSmall
            }
            ParagraphLabel {
                text: qsTr("Total: %1", "scores").arg(players[currentPlayerIndex].total)
                width: parent.width
                wrapMode: Text.WordWrap
                font.pixelSize: Theme.fontSizeSmall
            }
            ParagraphLabel {
                id: noticationLabel
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeTiny
                onTextChanged: {
                    if (text !== "") {
                        timer.restart()
                    }
                }
                Timer {
                    id: timer
                    interval: 5000
                    repeat: false
                    onTriggered: {
                        noticationLabel.text = ""
                    }
                }
            }
        }
        Rectangle {
            id: dropArea
            color: Theme.secondaryColor
            width: ballSize + ballSize / 2
            height: ballSize + ballSize / 2
            radius: 100
            smooth: true
            Text {
                text: qsTr("Drop score\nhere!")
                font.pixelSize: 20
                anchors.centerIn: parent
            }
            x: parent.width / 2 - width / 2
            y: parent.height / 1.33 - height / 2
        }
        Rectangle {
            id: missball
            onXChanged: checkSnap(missball)
            onYChanged: checkSnap(missball)
            color: Theme.highlightColor
            width: ballSize
            height: ballSize
            radius: 100
            smooth: true
            x: 10
            y: parent.height / 2
            Text {
                text: qsTr("Miss")
                font.pixelSize: 20
                anchors.centerIn: parent
            }
            MouseArea {
                property int xWas
                property int yWas
                anchors.fill: parent
                drag.target: parent
                drag.axis: Drag.XandYAxis
                drag.minimumX: 0
                drag.maximumX: page.width - parent.width
                drag.minimumY: 0
                drag.maximumY: page.height - parent.height
                onPressed: {
                    xWas = parent.x
                    yWas = parent.y
                }
                onReleased: {
                    if (parent.x == dropArea.x + ballSize / 4 && parent.y == dropArea.y + ballSize / 4)
                        addScore(0)
                    parent.x = xWas
                    parent.y = yWas
                }
            }
        }
        Repeater {
            id: repeater
            model: 12
            Rectangle {
                id: scoreBall
                width: ballSize
                height: ballSize
                radius: 100
                color: Theme.secondaryHighlightColor
                opacity: 0.7
                smooth: true
                x: page.width / 2 -  width / 2 - (ballSize * 2 + ballSize / 8) * Math.sin(-(index + 1) * 30 * Math.PI / 180)
                y: page.height / 1.33 - height / 2 - (ballSize *2 + ballSize / 8) * Math.cos(-(index + 1) * 30 * Math.PI / 180)

                Text {
                    id: number
                    anchors.centerIn: parent
                    font.pixelSize: 24
                    font.bold: true
                    text: index + 1
                }
                MouseArea {
                    property int xWas
                    property int yWas
                    anchors.fill: parent
                    drag.target: parent
                    drag.axis: Drag.XandYAxis
                    drag.minimumX: 0
                    drag.maximumX: page.width - parent.width
                    drag.minimumY: 0
                    drag.maximumY: page.height - parent.height
                    onPressed: {
                        xWas = parent.x
                        yWas = parent.y
                    }
                    onReleased: {
                        if (parent.x == dropArea.x + ballSize / 4 && parent.y == dropArea.y + ballSize / 4)
                            addScore(number.text)
                        parent.x = xWas
                        parent.y = yWas
                    }
                }
                onXChanged: checkSnap(scoreBall)
                onYChanged: checkSnap(scoreBall)
            }
        }
    }
}
