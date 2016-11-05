/*
 *
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
    property var npc
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
    RPGButton{x: 10; y: 140; text: "连接结点"; myClicked: function(){drawLine = true; statusBar.text = "状态: " + (drawLine ? "连线" : "自由")}}
    RPGButton{x: 10; y: 195; text: "生成结点"; myClicked: function(){createNode()}}
    RPGButton{x: 10; y: 250; text: "显示/隐藏"; myClicked: function(){}}
    RPGButton{x: 10; y: 335; text: "放置人物"; myClicked: function(){setNpc()}}
    RPGButton{id: run;x: 10; y: 390; text: "行走"; myClicked: function(){
        var table = [allNodes[0], allNodes[1], allNodes[2], allNodes[4]]
        npcRun(table)}}
    Text{
        id: statusBar
        anchors.top: run.bottom
        anchors.topMargin: 5
        anchors.verticalCenter: run.verticalCenter
        x : 20
        text: "状态: " + (drawLine ? "连线" : "自由")
        font.family: uiFont.name
    }
    //main canvas
    Rectangle{
        id: canvas
        x: 120; y: 10
        width: 510; height: 460
        color: "#272727"
    }
    property var allNodes: []
    function createNode(){
        var newNode = Qt.createComponent("RPGNode.qml")
        var nodeObj = newNode.createObject(canvas)
        allNodes.push(nodeObj)
    }

    function setNpc(){
        if(npc) return
        else{
            var newNpc = Qt.createComponent("RPGNpc.qml")
            var npcObj = newNpc.createObject(itemChosen)
            npc = npcObj
        }
    }

    function npcRun(path){
        npc.run(path, 1)
    }
    //Dijkstra
    //And fuck the spfa!!!!!!!!!!!!
    function findPath(node1, node2){
        var table = []
        var visited = []
        for(var length in allNodes){
            visited[length] = false
        }

        table.push(node1)

        for(var i in node1.next){

        }

        return table
    }
    function dfs(node){

    }

    function canDrag(){
        if(itemChosen)
            itemChosen.drag = true
    }

    function maintainLine(node1, node2){
        for(var i in node1.next){
            if(node1.next[i] === node2){
                var node11 = node1
                var lineObj = node1.nextLine[i]
                if(node11.x > node2.x){
                    var nodeTmp = node11
                    node11 = node2
                    node2 = nodeTmp
                }
                var tx1 = node11.x + node11.width/2
                var ty1 = node11.y + node11.height/2
                var tx2 = node2.x + node2.width/2
                var ty2 = node2.y + node2.height/2
                var angle = Math.atan2(ty1 - ty2, tx2 - tx1)
                lineObj.width = Math.sqrt((tx1-tx2)*(tx1-tx2) + (ty1-ty2)*(ty1-ty2))
                if(node11.y <= node2.y){
                    lineObj.x = tx1;
                    lineObj.y = ty1;
                    lineObj.rotation = -angle*180/Math.PI
                    console.log("line mainTain!", lineObj.rotation)
                }else{
                    lineObj.x = tx2
                    lineObj.y = ty2
                    lineObj.rotation = 180-angle*180/Math.PI
                    console.log("line mainTain2!", lineObj.rotation)
                }
            }
        }
    }

    function line(node1, node2){
        if(!node1 || !node2) return
        for(var i in node1.next){
            if(node1.next[i] === node2){
                console.log("Already lined!!")
                return
            }
        }
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
        var tx1 = node1.x + node1.width/2
        var ty1 = node1.y + node1.height/2
        var tx2 = node2.x + node2.width/2
        var ty2 = node2.y + node2.height/2
        var angle = Math.atan2(ty1 - ty2, tx2 - tx1)
        if(node1.y <= node2.y){
            lineObj.x = tx1;
            lineObj.y = ty1;
            lineObj.rotation = -angle*180/Math.PI
            console.log("line yes!", angle)
        }else{
            lineObj.x = tx2
            lineObj.y = ty2
            lineObj.rotation = 180-angle*180/Math.PI
            console.log("line yes2!", angle)
        }
        node1.next.push(node2)
        node1.nextLine.push(lineObj)
        node2.next.push(node1)
        node2.nextLine.push(lineObj)
        console.log("line node1, and node2", node1, node2)
        drawLine = false
        statusBar.text = "状态: " + (drawLine ? "连线" : "自由")
    }


}
