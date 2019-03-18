#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include "compteur.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    Compteur compteur;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("vueObjetCpt",&compteur);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
