#ifndef B2FILE_H
#define B2FILE_H

#include <QObject>
#include <QtCore>

class QQmlEngine;
class QJSEngine;
class B2File : public QObject
{
    Q_OBJECT
public:
    // ------------------ Singleton Func -----------------------
    Q_DISABLE_COPY(B2File)
    B2File() {}
public:
    static QObject* qmlSingleton(QQmlEngine *engine, QJSEngine *scriptEngine);
    static B2File* singleton();

    // ------------------ QML Property -----------------------


    // ------------------- QML Func ---------------------------
    //  File Path
    Q_INVOKABLE QString dataPath(QString file);
    Q_INVOKABLE bool exist(QString path);
    Q_INVOKABLE QString resourcePath(QString file);
    //  File IO
    Q_INVOKABLE QStringList lines(QString path);
    Q_INVOKABLE QString read(QString path);
    Q_INVOKABLE bool remove(QString path);
    Q_INVOKABLE bool write(QString path, QString data);

    // ------------------- C++ Func ---------------------------

    // ------------------- Private Func ---------------------------
private:
};

#endif // B2FILE_H
