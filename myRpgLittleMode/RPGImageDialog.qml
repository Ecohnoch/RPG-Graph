import QtQuick 2.7
import QtQuick.Dialogs 1.2

FileDialog {
    id: fileDialog
    modality: Qt.ApplicationModal
    title: "选取背景图片"
    nameFilters: [ "Image files (*.jpg, *.png)" ]

}
