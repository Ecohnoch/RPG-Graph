import QtQuick 2.7
import QtQuick.Dialogs 1.2

FileDialog {
    id: fileDialog
    modality: Qt.ApplicationModal
    title: "Please choose a file"
    nameFilters: [ "Image files (*.json)" ]
    onAccepted: {
        mainWindow.path = fileDialog.fileUrl
        console.log(mainWindow.path)
    }
}
