#include <QtWidgets/QApplication>
#include <QtQml/QQmlApplicationEngine>

#include "b2file.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    app.setApplicationName("Game Gragh");
    app.setApplicationVersion("1.1.0");
    app.setOrganizationName("Ecohnoch(XCY)");
    app.setOrganizationDomain("www.github.com/ecohnoch");
    qmlRegisterSingletonType<B2File>("File", 1, 0, "File", &B2File::qmlSingleton);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
