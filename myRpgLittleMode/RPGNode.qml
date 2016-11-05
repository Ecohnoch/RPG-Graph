import QtQuick 2.7

Item {
    id: node
    width: 50; height: 50
    z: 9999
    property bool drag: true
    property bool setNpc

    Rectangle{
        id: background
        anchors.fill: parent
        color: "steelblue"
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

    Component.onCompleted: {
        if(drag) event.drag.target = node
    }



}
