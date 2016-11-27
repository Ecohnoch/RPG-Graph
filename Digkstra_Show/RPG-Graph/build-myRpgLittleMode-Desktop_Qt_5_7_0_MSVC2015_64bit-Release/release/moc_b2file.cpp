/****************************************************************************
** Meta object code from reading C++ file 'b2file.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.7.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../myRpgLittleMode/b2file.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'b2file.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.7.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_B2File_t {
    QByteArrayData data[12];
    char stringdata0[75];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_B2File_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_B2File_t qt_meta_stringdata_B2File = {
    {
QT_MOC_LITERAL(0, 0, 6), // "B2File"
QT_MOC_LITERAL(1, 7, 8), // "dataPath"
QT_MOC_LITERAL(2, 16, 0), // ""
QT_MOC_LITERAL(3, 17, 4), // "file"
QT_MOC_LITERAL(4, 22, 5), // "exist"
QT_MOC_LITERAL(5, 28, 4), // "path"
QT_MOC_LITERAL(6, 33, 12), // "resourcePath"
QT_MOC_LITERAL(7, 46, 5), // "lines"
QT_MOC_LITERAL(8, 52, 4), // "read"
QT_MOC_LITERAL(9, 57, 6), // "remove"
QT_MOC_LITERAL(10, 64, 5), // "write"
QT_MOC_LITERAL(11, 70, 4) // "data"

    },
    "B2File\0dataPath\0\0file\0exist\0path\0"
    "resourcePath\0lines\0read\0remove\0write\0"
    "data"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_B2File[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       7,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // methods: name, argc, parameters, tag, flags
       1,    1,   49,    2, 0x02 /* Public */,
       4,    1,   52,    2, 0x02 /* Public */,
       6,    1,   55,    2, 0x02 /* Public */,
       7,    1,   58,    2, 0x02 /* Public */,
       8,    1,   61,    2, 0x02 /* Public */,
       9,    1,   64,    2, 0x02 /* Public */,
      10,    2,   67,    2, 0x02 /* Public */,

 // methods: parameters
    QMetaType::QString, QMetaType::QString,    3,
    QMetaType::Bool, QMetaType::QString,    5,
    QMetaType::QString, QMetaType::QString,    3,
    QMetaType::QStringList, QMetaType::QString,    5,
    QMetaType::QString, QMetaType::QString,    5,
    QMetaType::Bool, QMetaType::QString,    5,
    QMetaType::Bool, QMetaType::QString, QMetaType::QString,    5,   11,

       0        // eod
};

void B2File::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        B2File *_t = static_cast<B2File *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: { QString _r = _t->dataPath((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 1: { bool _r = _t->exist((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 2: { QString _r = _t->resourcePath((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 3: { QStringList _r = _t->lines((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QStringList*>(_a[0]) = _r; }  break;
        case 4: { QString _r = _t->read((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 5: { bool _r = _t->remove((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 6: { bool _r = _t->write((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        default: ;
        }
    }
}

const QMetaObject B2File::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_B2File.data,
      qt_meta_data_B2File,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *B2File::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *B2File::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_B2File.stringdata0))
        return static_cast<void*>(const_cast< B2File*>(this));
    return QObject::qt_metacast(_clname);
}

int B2File::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 7)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 7;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 7)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 7;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
