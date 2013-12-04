import QtQuick 2.0
import Sailfish.Silica 1.0
import "../items"

Page {
    id: page
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height
        PaddedColumn {
            id: column
            PageHeader {
                title: qsTr("About")
            }
            Image {
                id: startPattern
                source: "qrc:/img/game_start_big.png"
                width: parent.width
                fillMode: Image.PreserveAspectFit
            }
            HeaderLabel {
                text: qsTr("Rules")
            }
            ParagraphLabel {
                text: qsTr("The players use a wooden pin (also called \"mölkky\") to try and knock over wooden pins (also called \"skittles\") of almost similar dimensions with the throwing pin, which are marked with numbers from 1 to 12. The pins are initially placed in a tight group in an upright position 3–4 metres away from the throwing place (order of pins; 1st row-1_2, 2nd row-3_10_4, 3rd row-5_11_12_6, 4th row-7_9_8 (picture above)). Knocking over one pin scores the amount of points marked on the pin. Knocking 2 or more pins scores the amount of pins knocked over (e.g. 3 pins score 3 points). A pin does not count if it is leaning on the mölkky or one of the numbered pins (they have to be parallel to the ground to count). After each throw, the pins are lifted up again in the exact location where they landed. The first one to reach exactly 50 points wins the game. Scoring more than 50 will be penalised by setting the player's score back to 25 points. A player will be eliminated from the game if they miss all of the target pins three times in a row.")
            }
            HeaderLabel {
                text: qsTr("Trivia")
            }
            ParagraphLabel {
                text: qsTr("Mölkky (Finnish: [ˈmœlkːy]) is a Finnish throwing game invented by Tuoterengas company in 1996. It is reminiscent of kyykkä, a centuries-old throwing game with Karelian roots. However, mölkky does not require as much physical strength as kyykkä, and is more suitable for everyone regardless of age and condition. Mölkky requires no special equipment and success is based on a combination of chance and skill. Tuoterengas has sold nearly 200,000 sets in Finland. Tuoterengas owns the Mölkky-trademark.")
            }
            ParagraphLabel {
                text: "<i>" + qsTr("Source") + ": <a href=\""+ qsTr("http://en.wikipedia.org/wiki/M%C3%B6lkky", "wikipedia link to mökky article") + "\">Wikipedia</a></i>"
                textFormat: Text.StyledText
                font.pixelSize: Theme.fontSizeSmall
            }
        }
    }
}
