import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    id: window
    visible: true
    width: 320
    height: 240
    color: "#3f1cec"
    title: qsTr("Compteur")

    Rectangle {
        id: rectangle
        x: 36
        y: 20
        width: 100
        height: 50
        color: "#ffffff"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    Text {
        id: element
        x: 148
        y: 161
        width: 100
        height: 50
        text: vueObjetCpt.cptQML
        styleColor: "#00000000"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        fontSizeMode: Text.FixedSize
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 29
        focus:true
        Keys.onPressed: {
            switch(event.key){
            case Qt.Key_Up:
                vueObjetCpt.increment();
                break;
            case Qt.Key_Down:
                vueObjetCpt.decrement();
                break;

            }
        }
    }

}
