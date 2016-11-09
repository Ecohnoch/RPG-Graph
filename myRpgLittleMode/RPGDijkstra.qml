import QtQuick 2.7

Item {

    function construcAGraph(node1, node2){
        if(node1 === node2) {console.log("***Error"); return}
        var vertex = allNodes
        var matrix = []
        var dist = []
        var path = []
        for(var i = 0; i < vertex.length; i++){
            var rowMatrix = []
            for(var j = 0; j < vertex.length; j++){
                rowMatrix.push(1000)
            }
            matrix.push(rowMatrix)
            dist.push(1000)
            path.push(-1)
        }
        for(var node in vertex){
            for(var each in vertex[node].next){
                var num
                for(var numm in vertex){
                    if(vertex[node].next[each] === vertex[numm]){
                        num = numm;
                        break;
                    }
                }
                if(vertex[node] !== vertex[num]){
                    matrix[node][num] = vertex[node].nextLine[each - 1].width
                }else{
                    matrix[node][num] = 0
                }
            }
        }

        var n1, n2
        var nPath = []
        for(var all in allNodes){
            if(allNodes[all] === node1){
                n1 = all
            }
            if(allNodes[all] === node2){
                n2 = all
            }
        }
        dijkstra(vertex, matrix, dist, path, n1)
        console.log(vertex, matrix, dist, path)

        // 0 1 2 3
        // 0 0 1 0

        // 3  ->  0
        console.log("debug++++", n1, n2, path)

        var nnPath = []
        var overflow = 0
        while(n1 !== n2){
            nnPath.push(n2)
            n2 = path[n2]
            console.log("fuck")
            overflow++
            if(overflow > vertex.length){
                console.log("***Error, overflow")
                return
            }
        }
        console.log(nnPath)

        while(nnPath.length){
            var p = nnPath.pop()
            nPath.push(p)
        }

        console.log("Final Res: ", nPath)
//        if(nPath.length === 1 && allNodes[nPath[0]] === node2){return }
        var realPath = []
        realPath.push(node1)
        for(var real in nPath){
            realPath.push(allNodes[nPath[real]])
        }
        return realPath
    }


    function dijkstra(vertex, matrix, dist, path, v0){
        var visited = []
        for(var i in vertex){
            visited.push(0)
        }
        for(var ii in vertex){
            if(matrix[v0][ii] > 0 && ii !== v0){
                dist[ii] = matrix[v0][ii]
                path[ii] = v0
            }else{
                dist[ii] = 1000
                path[ii] = -1
            }
            path[v0] = v0
            dist[v0] = 0
        }
        visited[v0] = 1

        // 初始化结束
        for(var iii in vertex){
            var min = 1000
            var u
            for(var j in vertex){
                if(visited[j] === 0 && dist[j] < min){
                    min = dist[j]
                    u = j
                }
            }
            visited[u] = 1
            for(var k in vertex){
                if(visited[k] === 0 && matrix[u][k] > 0 && min + matrix[u][k] < dist[k]){
                    dist[k] = min + matrix[u][k]
                    path[k] = u
                }
            }
        }
    }
}
