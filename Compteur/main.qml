import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    id: window
    visible: true
    width: 320
    height: 240
    color: "#030dae"
    title: qsTr("Compteur")

    Rectangle {
        id: rectangle
        x: 41
        y: 26
        width: 100
        height: 50
        color: "#5a99d7"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Text {
            id: element
            text: vueObjetCpt.cptQML
            font.bold: true
            font.family: "Tahoma"
            renderType: Text.QtRendering
            lineHeight: 0.8
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.fill: parent
            font.pixelSize: 40
            focus:true
        }
        Keys.onPressed: {
            switch(event.key){
            case Qt.Key_Up:
                vueObjetCpt.increment();
                break;
            case Qt.Key_Down:
                vueObjetCpt.decrement();
                break;
            case Qt.Key_A:
                monTexte.texteAEditer=qsTr("Touche A")
            }
        }
    }
    MonText {
        id: monText
        x: 26
        y: 21
    }
}
