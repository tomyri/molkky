import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"

ApplicationWindow
{
    initialPage: FirstPage { }
//    initialPage: MarkScorePage {}
//    initialPage: NewGamePage {}

    cover: Qt.resolvedUrl("cover/CoverPage.qml")
}
