#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <sailfishapp.h>
#include <QTranslator>
#include <QGuiApplication>
#include <QQuickView>
#include <QCoreApplication>

int main(int argc, char *argv[])
{
    QCoreApplication::setOrganizationName("molkky");
    QCoreApplication::setOrganizationDomain("tomyri.com");
    QCoreApplication::setApplicationName("molkky");
    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));
    QTranslator translator;
    translator.load(QLocale::system(), "harbour-molkky", "_", SailfishApp::pathTo("i18n").toLocalFile(), ".qm");
    app->installTranslator(&translator);
    QScopedPointer<QQuickView> v(SailfishApp::createView());
    v->setSource(SailfishApp::pathTo("qml/main.qml"));
    v->show();
    return app->exec();
}

