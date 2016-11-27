import QtQuick 2.7

Item {
    id: node
    width: 80; height: 50
    z: 9999
    property bool drag: true
    property var next: []
    property var nextLine: []
    property string path: "qrc:/image/vertex_2.png"
    Rectangle{
        id: background
        anchors.fill: parent
        color: "transparent"
    }

    Image{
        id: backImage
        anchors.fill: parent
        source: node.path
    }

    MouseArea{
        id: event
        anchors.fill: parent
        //drag.target:{ if(drag) return node; else return;}

        drag.axis: Drag.XAndYAxis
        drag.maximumX: canvas.width - node.width
        drag.minimumX: 0
        drag.maximumY: canvas.height - node.height
        drag.minimumY: 0

        onClicked: {
            if(itemChosen)
                curChosen = itemChosen
            itemChosen = node
            if(drawLine){
                console.log(drawLine)
                line(curChosen, itemChosen)
            }
        }
        onDoubleClicked: {
            fileDialog.open()
        }
    }
    function beChosen(){
        background.border.width = 3;
        background.border.color = "#930000"
    }
    function notChosen(){
        background.border.width = 0;
    }

    onDragChanged: {
        if(drag) event.drag.target = node
        // empty id TO DO
        else event.drag.target =
        console.log("come on")
    }
    function positionChanged(){
        if(!next){
           return
        }else{
            for(var tmpNode in next){
                mainWindow.maintainLine(node, node.next[tmpNode])
            }
        }
    }
    onXChanged: positionChanged()


    RPGImageDialog{
        id: fileDialog
        title: "选取图案图片"
        onAccepted: {
            node.path = fileDialog.fileUrl
            console.log(node.path)
        }
    }
    onPathChanged: backImage.source = path

    Component.onCompleted: {
        if(drag) event.drag.target = node
        next.push(node)
    }



}
