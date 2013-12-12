#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <sailfishapp.h>
#include <QTranslator>
#include <QGuiApplication>
#include <QQuickView>

int main(int argc, char *argv[])
{
    QGuiApplication *app = SailfishApp::application(argc, argv);
    QTranslator translator;
    translator.load(QLocale::system(), "harbour-molkky", "_", SailfishApp::pathTo("i18n").toLocalFile(), ".qm");
    app->installTranslator(&translator);
    QQuickView *v = SailfishApp::createView();
    v->setSource(SailfishApp::pathTo("qml/harbour-molkky.qml"));
    v->show();
    return app->exec();
}

