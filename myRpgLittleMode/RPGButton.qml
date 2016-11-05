import QtQuick 2.7


Rectangle{
    width: 100; height: 50
    radius: 4
    border.width: 3
    border.color: "#888"
    color: "transparent"
    property string text
    property var myClicked: function(){}
    Rectangle{
        id: background
        anchors.fill: parent
        color: "grey"
        visible: false
    }
    Text{
        anchors.centerIn: parent
        font.family: uiFont.name
        font.pixelSize: 20
        color: "#005AB5"
        text: parent.text
    }
    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {background.visible = true; background.opacity = 0.3}
        onExited: {background.opacity = 0; background.visible = false}
        onClicked:  if(myClicked) myClicked()
    }
}
