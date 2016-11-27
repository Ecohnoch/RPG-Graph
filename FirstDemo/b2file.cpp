#include "b2file.h"
#include <QDebug>

QObject* B2File::qmlSingleton(QQmlEngine *engine, QJSEngine *scriptEngine){
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);
    static B2File* _singleton=nullptr;
    if(!_singleton)
        _singleton=new B2File;
    return _singleton;
}
B2File* B2File::singleton(){
    return qobject_cast<B2File*>(qmlSingleton(nullptr,nullptr));
}

QString B2File::dataPath(QString file){
    QString path=QDir::currentPath();//QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    path = path + "/data";
    QDir dir(path);
    if(!dir.exists())
        dir.mkpath(path);
    qDebug()<< path+'/'+file;
    return path+'/'+file;
}
bool B2File::exist(QString path){
    return QFile(path).exists();
}
QString B2File::resourcePath(QString file){
    return QString(":/")+file;
}

QStringList B2File::lines(QString path){
    QFile f(path);
    if(!f.exists()) return QStringList();
    if(!f.open(QIODevice::ReadOnly)) return QStringList();
    QStringList lines;
    while(!f.atEnd())
        lines.push_back(f.readLine());
    f.close();
    return lines;
}
QString B2File::read(QString path){
    QFile f(path);
    if(!f.exists()) return "";
    if(!f.open(QIODevice::ReadOnly)) return "";
    QByteArray byteArray(f.readAll());
    f.close();
    return QString(byteArray);  // maybe empty
}
bool B2File::remove(QString path){
    QFile f(path);
    return f.remove();
}
bool B2File::write(QString path, QString data){
    QFile f(path);
    if(!f.open(QIODevice::WriteOnly)) return false;
    if(f.write(data.toUtf8())==-1){     // writing failed
        f.close();
        return false;
    }else{
        f.close();
        return true;
    }
}
