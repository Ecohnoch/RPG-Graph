/*
 *
 * onDragChanged  to do
 * ok~

*/

import QtQuick 2.7
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 1.4
import QtQuick.Window 2.2
import QtMultimedia 5.4

import File 1.0

ApplicationWindow {
    id: mainWindow
    width: 640
    height: 480
    visible: true
    color: systemPalette.window
    SystemPalette{id: systemPalette}
    FontLoader{id: uiFont; source: "qrc:/fonts/PingFangM.ttf"}
    menuBar:MenuBar{
        Menu{
            title: "文件"
            MenuItem{text: "保存(s)"; onTriggered: {save()}}
            MenuItem{text: "加载(l)"; onTriggered: {dialog.open()}}
        }
        Menu{
            title: "背景图片"
            MenuItem{text: "选取(c)"; onTriggered: {imgDialog.open()}}
        }
        Menu{
            title: "音乐"
            MenuItem{text: "选取(m)"; onTriggered: {musicDialog.open()}}
        }
    }

    property bool drawLine: false
    property var npc
    property var itemChosen
    property var curChosen
    property string path
    property string imgPath
    property string musicPath

    onItemChosenChanged: {
        if(curChosen)
            curChosen.notChosen()
        if(itemChosen)
            itemChosen.beChosen()
    }

    //column
    RPGButton{x: 10; y: 10; text: "加载"; myClicked: function(){dialog.open()}}
    RPGButton{x: 10; y: 65; text: "保存"; myClicked: function(){save()}}
    RPGButton{x: 10; y: 140; text: "连接结点"; myClicked: function(){drawLine = true; statusBar.text = "状态: " + (drawLine ? "连线" : "自由")}}
    RPGButton{x: 10; y: 195; text: "生成结点"; myClicked: function(){createNode()}}
    RPGButton{x: 10; y: 250; text: "显示/隐藏"; myClicked: function(){var path = getPath.construcAGraph(npc.parent, itemChosen); npcRun(path)}}
    RPGButton{x: 10; y: 335; text: "放置人物"; myClicked: function(){setNpc()}}
    RPGButton{id: run;x: 10; y: 390; text: "行走"; myClicked: function(){
       var path = getPath.construcAGraph(npc.parent, itemChosen);
       if(path)
            npcRun(path)
    }}
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
        x: 120; y: 10; z: -999
        width: 510; height: 460
        color: "#272727"
        Image{
            id: bg
            anchors.fill: parent
            source: imgPath ? imgPath : ""
        }
        function addBackground(path){
            bg.source = path
        }
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
        if(path)
            npc.run(path, 1)
    }

    // DFS, but bugs..
    function findPath(node1, node2){
        if(node2 === node1) return
        var dist = []
        var path = []
        var tmpNodes = []
        for(var ii in allNodes){
            dist.push(1000)
        }
        path.push(node1)

        tmpNodes.push(node1)
        while(tmpNodes){
            var node = tmpNodes.pop()
            var num

            for(var find in allNodes){
                if(allNodes[find] === node) {num = find; break}
            }
            console.log("debug", tmpNodes, node, node.next)

            for(var i in node.next){
                if(node.next[i] === node2){
                    if(path[0] === path[1]) path.shift()
                    for(var iiii = path.length-1; iiii > 0; iiii--){
                        if(path[iiii - 1].next.indexOf(node2) !== -1 || path[iiii].next.indexOf(node2) === -1){
                            path.pop()
                        }else{
                            break
                        }
                    }
                    path.push(node2)
                    for(var test in path){
                        console.log("path: ", test, path[test].x)
                    }
                    return path
                }
            }

        //be here
            var flag = 1
            for(var iii in node.next){
                var num2
                for(var num2m in allNodes){
                    if(allNodes[num2m] === node.next[iii]){
                        num2 = num2m
                        break
                    }
                }

                if(dist[num2] !== 0){
                    dist[num2] = 0
                    tmpNodes.push(node.next[iii])
                    path.push(node.next[iii])
                    flag = 0
                }
            }
            if(flag){
                path.pop()
                console.log("Out!!")
            }
        }
        console.log("***Can't find the path")
        return
    }

    function findPath2(node1, node2){
        var tmpNodes = []
        var visited = []
        var path = []
        tmpNodes.push(node1)
        for(var allnode in allNodes){
            visited[allnode] = 1
        }

        while(tmpNodes){
            var node = tmpNodes.shift()

            if(node === node2){
                path.push(node2)
                return path
            }

            var nodeNum
            for(var all in allNodes){
                if(allNodes[all] === node){
                    nodeNum = all
                    break
                }
            }

            if(visited[nodeNum] !== 0){
                visited[nodeNum] = 0
            }

            for(var i in node.next){
                // Get i num
                var iNum
                for(var ii in allNodes){
                    if(allNodes[ii] === node.next[i]){
                        iNum = ii
                        break
                    }
                }

                if(visited[iNum] !==0){
                    visited[iNum] = 0
                    tmpNodes.push(node.next[i])
                    path.push(node.next[i])

                }
            }



        }
    }

    function canDrag(){
        if(itemChosen)
            itemChosen.drag = true
    }

    function maintainLine(node1, node2){
        if(node1 === node2) return
        for(var i in node1.next){
            if(node1.next[i] === node2){
                var node11 = node1
                var lineObj = node1.nextLine[i - 1]
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
                }else{
                    lineObj.x = tx2
                    lineObj.y = ty2
                    lineObj.rotation = 180-angle*180/Math.PI
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
        }else{
            lineObj.x = tx2
            lineObj.y = ty2
            lineObj.rotation = 180-angle*180/Math.PI
        }
        node1.next.push(node2)
        node1.nextLine.push(lineObj)
        node2.next.push(node1)
        node2.nextLine.push(lineObj)
        drawLine = false
        statusBar.text = "状态: " + (drawLine ? "连线" : "自由")
    }

    //Dijkstra
    RPGDijkstra{
        id: getPath
    }
    RPGDialog{
        id: dialog
    }
    RPGImageDialog{
        id: imgDialog
        onAccepted: {
            mainWindow.imgPath = fileDialog.fileUrl
            console.log(mainWindow.imgPath)
        }
    }
    onImgPathChanged: {
        canvas.addBackground(imgPath)
    }

    MediaPlayer{
        id: music
        autoPlay: true
        source: musicPath ? musicPath : ""
    }

    RPGMusicDialog{
        id: musicDialog
    }
    onMusicPathChanged: {
        music.source = musicPath
        music.volume = 0.5;
        music.loops = Audio.Infinite
        music.play()
    }

    onPathChanged: {
        var data
        if(File.exist(path.substring(8, path.length))){
            data = JSON.parse(File.read(path.substring(8, path.length)))
            var nodes = []
            for(var i in data){
                if(data[i].x){
                    var nodeComponent = Qt.createComponent("RPGNode.qml")
                    var nodeObj = nodeComponent.createObject(canvas, {"x":data[i].x, "y":data[i].y})
                    nodes.push(nodeObj)
                }
            }
            console.log("nodes : ", nodes)
            for(var j in nodes){
                for(var ii in data[j].next){
                    line(nodes[j], nodes[data[j].next[ii]])
                }
            }


            for(var node in allNodes){
                for(var combine in allNodes[node].nextLine){
                    allNodes[node].nextLine[combine].destroy()
                }
                allNodes[node].destroy()
            }
            allNodes = nodes
            curChosen = allNodes[0]
            itemChosen = allNodes[0]
            musicPath = data.music
            imgPath = data.img
            console.log("Load Suc!!")
        }
        console.log("Load Failed!!")
    }

    function save(){
        var data = "{\n"
        for(var i in allNodes){
            var nextList = ""
            for(var ii in allNodes[i].next){
                for(var iii in allNodes){
                    if(allNodes[iii] === allNodes[i].next[ii]){
                        nextList = nextList + iii + ","
                    }
                }
            }
            nextList = nextList.substring(0, nextList.length - 1)
            console.log("nextList:", nextList)
            data = data + "    \"" + i + "\":{\n        \"x\":" + allNodes[i].x + ",\n        \"y\":" + allNodes[i].y + ",\n        \"next\":["
            data = data + nextList + "]\n    },\n"
        }
        if(musicPath)
            data = data + "    \"music\":" + "\"" + musicPath + "\",\n"
        else
            data = data + "    \"music\":" + "\"\",\n"
        if(imgPath)
            data = data + "    \"img\":"  + "\"" + imgPath + "\"\n"
        else
            data = data + "    \"img\":" + "\"\"\n"
        data = data + "\n}"
        var num = 1
        var path = "data" + num + ".json"
        while(File.exist(File.dataPath(path))){
            num++
            path = "data" + num + ".json"
        }

        File.write(File.dataPath(path), data)
    }


}
