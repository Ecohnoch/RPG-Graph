import QtQuick 2.7
import QtQuick.Dialogs 1.2

FileDialog {
    id: fileDialog
    modality: Qt.ApplicationModal
    title: "选取音乐文件(mp3)"
    nameFilters: [ "Image files (*.mp3)" ]
    onAccepted: {
        mainWindow.musicPath = fileDialog.fileUrl
        console.log(mainWindow.musicPath)
    }
}
