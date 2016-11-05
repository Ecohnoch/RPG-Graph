import QtQuick 2.7

AnimatedImage {
    width: 32; height: 48
    x: parent.width/2-width/2
    y: parent.height/2-height
    source: "qrc:/image/npc/npc_stand.gif"
    NumberAnimation on x{
        id: moveX
        running: false
        duration: 5000
    }
    NumberAnimation on y{
        id: moveY
        running: false
        duration: 5000
        property var myStopped
        onStopped: {if(myStopped) myStopped()}
    }
    Timer{
        id: runInThePath
        interval: 5000
        property var path
        onTriggered: {

            if(node){run(node); runInThePath.restart()}
            else return
        }
    }
    function pathRun(path){
        for(var i in path){
            runInThePath.node = path[i]
            runInThePath.restart()
        }
    }

    function run(path, i){
        var node = path[i]
        var dist = []
        var node1, node2
        var ltDirc = 0 // 0 left  1 right
        if(parent.x < node.x){node1 = parent; node2 = node; source = "qrc:/image/npc/npc_right.gif"
        }else if(parent.x === node.x){if(parent.y >= node.y) source = "qrc:/image/npc/npc_up.gif"}
        else{node1 = node; node2 = parent; source= "qrc:/image/npc/npc_left.gif"}
        if(node1.y >= node2.y){
            dist[0] = node1.x - node2.x + node.width/2-width/2
            dist[1] = node1.y - node2.y - height / 2
        }
        else{
            dist[0] = node2.x - node1.x + node.width/2-width/2
            dist[1] = node2.y - node1.y - height/2
        }
        console.log("move to: ", dist[0], dist[1])
        moveX.to = dist[0]
        moveY.to = dist[1]
        moveY.myStopped = function(){
            parent = node;
            source = "qrc:/image/npc/npc_stand.gif"
            if(path[i+1]){
                run(path, i+1)
            }
        }
        moveX.restart()
        moveY.restart()
    }
}
