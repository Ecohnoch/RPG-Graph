/*
 * another case \ to do
 * onDragChanged  to do
 * ok~

*/

import QtQuick 2.7
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 1.4
import QtQuick.Window 2.2

Window {
    id: mainWindow
    width: 640
    height: 480
    visible: true
    color: systemPalette.window
    SystemPalette{id: systemPalette}
    FontLoader{id: uiFont; source: "qrc:/fonts/PingFangM.ttf"}

    property bool drawLine: false
    property var itemChosen
    property var curChosen
    onItemChosenChanged: {
        if(curChosen)
            curChosen.notChosen()
        if(itemChosen)
            itemChosen.beChosen()
    }

    //column
    RPGButton{x: 10; y: 10; text: "加载"; myClicked: function(){}}
    RPGButton{x: 10; y: 65; text: "保存"; myClicked: function(){}}
    RPGButton{x: 10; y: 140; text: "连接结点"; myClicked: function(){drawLine = true}}
    RPGButton{x: 10; y: 195; text: "生成结点"; myClicked: function(){createNode()}}
    RPGButton{x: 10; y: 250; text: "显示/隐藏"; myClicked: function(){}}
    RPGButton{x: 10; y: 335; text: "放置人物"; myClicked: function(){}}
    RPGButton{x: 10; y: 390; text: "行走"; myClicked: function(){}}

    //main canvas
    Rectangle{
        id: canvas
        x: 120; y: 10
        width: 510; height: 460
        color: "#272727"

        RPGNode{}
        RPGNode{}
    }
    function createNode(){
        var newNode = Qt.createComponent("RPGNode.qml")
        var nodeObj = newNode.createObject(canvas)
    }

    function canDrag(){
        if(itemChosen)
            itemChosen.drag = true
    }
    function line(node1, node2){
        var myLine = Qt.createComponent("RPGLine.qml")
        var lineObj = myLine.createObject(canvas)
        lineObj.width = Math.sqrt(((node1.x+node1.width/2)-(node2.x+node2.width/2))*((node1.x+node1.width/2)-(node2.x+node2.width/2)) + ((node1.y+node1.height/2) - (node2.y+node2.height/2))*((node1.y+node1.height/2) - (node2.y+node2.height/2)))
        lineObj.height = 5
        console.log("width : ", lineObj.width)
        //   \  /
        if(node1.x > node2.x){
            var nodeTmp = node1
            node1 = node2
            node2 = nodeTmp
        }
        if(node1.y <= node2.y){
            var tx1 = node1.x + node1.width/2
            var ty1 = node1.y + node1.height/2
            var tx2 = node2.x + node2.width/2
            var ty2 = node2.y + node2.height/2
            lineObj.x = tx1;
            lineObj.y = ty1;
            var angle = Math.atan2(ty1 - ty2, tx2 - tx1)
            lineObj.rotation = -angle*180/Math.PI
            node1.drag = false
            node2.drag = false
            console.log("line yes!", angle)
        }else{
            //TO DO
        }

        console.log("line node1, and node2", node1, node2)
        drawLine = false
    }
}
