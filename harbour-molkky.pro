# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = harbour-molkky

#CONFIG += sailfishapp

# Temporary fix to fill harbour requirements. Return to "CONFIG += sailfishapp" when sdk is updated
QT += quick qml
CONFIG += link_pkgconfig
PKGCONFIG += sailfishapp
INCLUDEPATH += /usr/include/sailfishapp

TARGETPATH = /usr/bin
target.path = $$TARGETPATH

DEPLOYMENT_PATH = /usr/share/$$TARGET
qml.files = qml
qml.path = $$DEPLOYMENT_PATH

desktop.files = harbour-molkky.desktop
desktop.path = /usr/share/applications

icon.files = harbour-molkky.png
icon.path = /usr/share/icons/hicolor/86x86/apps

INSTALLS += target icon desktop qml
# End fix

SOURCES += src/harbour-molkky.cpp

lupdate_only{
SOURCES +=  qml/*.qml\
            qml/pages/*.qml\
            qml/cover/*.qml
}

OTHER_FILES += qml/harbour-molkky.qml \
    qml/cover/CoverPage.qml \
    qml/pages/*.qml\
    qml/items/*.qml\
    rpm/harbour-molkky.spec \
    rpm/harbour-molkky.yaml \
    harbour-molkky.desktop


TRANSLATIONS = i18n/molkky_fi.ts

RESOURCES += \
    resources.qrc
