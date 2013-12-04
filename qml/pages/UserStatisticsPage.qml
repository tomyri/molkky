import QtQuick 2.0
import Sailfish.Silica 1.0
import "../items"

Page {
    property var player
    PaddedColumn {
        id: column
        PageHeader {
            title: qsTr("Player Stats")
        }
        HeaderLabel {
            text: player.name
        }
        ParagraphLabel {
            text: qsTr("Throw history: %1").arg(player.history)
        }
        ParagraphLabel {
            text: qsTr("Total: %1", "scores").arg(player.total)
        }
        ParagraphLabel {
            text: qsTr("Accuracy %: ")
            Component.onCompleted: {
                //NOTE: should be much easier but somehow qml messes my datastructure (yeah, blame the framework :))
                var zeros = 0
                var moo = []
                moo = player.history
                var c = 0 //player.history.lenght is undefined?
                for (var i in moo) {
                    ++c
                    if (moo[i] === 0)
                        ++zeros
                }
                if (c === 0) {
                    text = text + "-"
                } else {
                    var hmp = 100 - zeros / c * 100
                    text = text + hmp.toFixed()
                }
            }
        }
        ParagraphLabel {
            text: qsTr("Average points per throw: ")
            Component.onCompleted: {
                var count = 0
                var points = 0
                for (count in player.history)
                    points += player.history[count]
                if (count === 0) {
                    text = text + "-"
                } else {
                    ++count
                    var m = points / count
                    text = text + m.toFixed(1)
                }
            }
        }
    }
}
