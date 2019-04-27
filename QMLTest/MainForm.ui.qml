import QtQuick 2.6
import QtGraphicalEffects 1.0

Rectangle {
    id: gameWindow
    width: (85*dimension + 160)//290
    height: (85*dimension + 160)
    color: "#faf9f0"
    property alias newGameButton: newGameButton
    property alias undoButton: undoButton
    property alias rectangleTiles: rectangleTiles

    Text {
        id: title2048
        color: "#746c6b"
        text: qsTr("2048")
        font.bold: true
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 20
        font.pixelSize: 40
    }

    Rectangle {
        id: scoreRect
        anchors.left: title2048.right
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 20
        width: 80
        height: 40
        color: "#ccc2b3"
        radius: 5

        Text {
            id: scoreText
            text: qsTr("SCORE")
            color: "#ffffff"
            anchors.top: parent.top
            anchors.topMargin: 5
            horizontalAlignment: Text.AlignHCenter
            anchors.fill: parent
            font.pixelSize: 10
        }

        Text {
            id: scoreValue
            text: qsTr(gametable.score.toString())
            font.bold: true
            color:  "#ffffff"
            anchors.top: parent.top
            anchors.topMargin: 18
            horizontalAlignment: Text.AlignHCenter
            anchors.fill: parent
            font.pixelSize: 14
        }
    }

    Rectangle {
        id: bestScoreRect
        anchors.left: scoreRect.right
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 20
        width: 80
        height: 40
        color: "#ccc2b3"
        radius: 5

        Text {
            id: bestScoreText
            text: qsTr("BEST")
            color: "#ffffff"
            anchors.top: parent.top
            anchors.topMargin: 5
            horizontalAlignment: Text.AlignHCenter
            anchors.fill: parent
            font.pixelSize: 10
        }

        Text {
            id: bestScoreValue
            text: qsTr(gametable.bestscore.toString())
            font.bold: true
            color: "#ffffff"
            anchors.top: parent.top
            anchors.topMargin: 18
            horizontalAlignment: Text.AlignHCenter
            anchors.fill: parent
            font.pixelSize: 14
        }
    }

    Text {
        id: textExplaining
        color: "#746c6b"
        text: qsTr("Join the numbers and get to the 2048 tile!")
        anchors.left: title2048.left
        anchors.leftMargin: 5
        anchors.top: title2048.bottom
        anchors.topMargin: 5
        font.pixelSize: 12
    }

    Rectangle {
        id: newGameButtonRect
        x: 170
        width: 125
        height: 40
        anchors.bottom: rectangleTiles.top
        anchors.bottomMargin: 10
        anchors.left: rectangleTiles.left
        anchors.leftMargin: 5
        color:"#8f7a66"
        radius: 5

        Text {
            id: textNewGame
            color: "#ffffff"
            text: qsTr("New Game")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 19
        }

        MouseArea {
            id: newGameButton
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            visible: mainButtons
        }
    }

    Rectangle {
        id: undoButtonRect
        x: 170
        width: 125
        height: 40
        anchors.bottom: rectangleTiles.top
        anchors.bottomMargin: 10
        anchors.right: rectangleTiles.right
        anchors.rightMargin: 5
        color: "#8f7a66"
        radius: 5
        visible: true

        Text {
            id: undoText
            color: "#ffffff"
            text: qsTr("Undo")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 19
        }

        MouseArea {
            id: undoButton
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            visible: mainButtons
        }
    }

    Rectangle {
        id: rectangleTiles
        y: 80
        width: (85*dimension + 10)
        height: (85*dimension + 10)
        color:  "#baae9d"
        radius: 15
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 150

        Repeater {
            model: dimension*dimension
            Rectangle {
                x: gametable.posX
                y: gametable.posY
                Behavior on x { PropertyAnimation { duration: 300}}
                Behavior on y { PropertyAnimation { duration: 300}}
                width: 75
                height: 75
                color: gametable.blockcolor
                Behavior on color { PropertyAnimation { duration: 100}}
                radius: 5
                z: 1
                focus: true

                Text {
                    color: gametable.blocktextcolor
                    text: gametable.blocknumber
                    z: 2
                    font.family: textType
                    fontSizeMode: Text.FixedSize
                    textFormat: Text.AutoText
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: sizeBlockText
                }
            }
        }

        Grid {
            x: 10
            y: 10
            rows: dimension
            columns: dimension
            spacing: 10

            Repeater {
                model: dimension*dimension
                Rectangle {
                    width: 75
                    height: 75
                    color:  "#ccc2b3"
                    radius: 5
                }
            }
        }
        Keys.onPressed:
        {
            switch (event.key) {
            case Qt.Key_Right:
                gametable.goDown();
                break;
            case Qt.Key_Left:
                gametable.goUP();
                break;
            case Qt.Key_Up:
                gametable.goLeft();
                break;
            case Qt.Key_Down:
                gametable.goRight();
                break;
            }

        }
    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
