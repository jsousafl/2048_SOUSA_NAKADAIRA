import QtQuick 2.0

Item {
    id: monTexte
    width: 30
    height: 60
    property alias textAEditer: element.text

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: rectangle.color = "#337323"
        onDoubleClicked: element.rotation = 90
        hoverEnabled: true
        onEntered:  console.log("Entrée")
        onExited: console.log("Sortie")

        Rectangle {
            id: rectangle
            color: "#f7084a"
            anchors.fill: parent

            Text {
                id: element
                x: 19
                y: 28
                text: qsTr("Text")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                rotation: -90
                renderType: Text.QtRendering
                font.pixelSize: 12
            }
        }
    }

}
