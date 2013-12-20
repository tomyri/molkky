# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = harbour-molkky

CONFIG += sailfishapp

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


TRANSLATIONS = i18n/harbour-molkky_fi.ts

RESOURCES += \
    resources.qrc

i18n.files = i18n
i18n.path = /usr/share/$$TARGET

INSTALLS += i18n
