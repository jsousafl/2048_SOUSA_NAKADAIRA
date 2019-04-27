import QtQuick 2.6
import QtQuick.Window 2.2

Window
{
    property int dimension: gametable.dimension
    property int widthWindow: (85*dimension + 50)
    property int heightWindow: (85*dimension + 175)
    property int sizeBlockText: 35
    property string textType: "Verdana"
    property bool gameModeBool: true

    visible: true
    width: widthWindow
    height: heightWindow
    title: qsTr("2048")
    property bool mainButtons: true

    MainForm
    {
        anchors.fill: parent
        id: gameWindow
        //property variant window;

        newGameButton
        {
            onClicked: gametable.newGame()
        }

        undoButton
        {
            onClicked: gametable.undoPlay()
        }

    }
}
