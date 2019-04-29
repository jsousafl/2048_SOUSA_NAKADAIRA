import QtQuick 2.6
import QtQuick.Window 2.2

Window
{
    property int dimension: gametable.dimension
    property int widthWindow: (85*dimension + 50)
    property int heightWindow: (85*dimension + 175)
    property int sizeBlockText: 30
    property string textType: "Arial"
    property bool gameModeBool: true
    property bool verify_win: gametable.verify_win
    property bool verify_lost: gametable.verify_lost

    visible: true
    width: widthWindow
    height: heightWindow
    title: qsTr("2048")
    property bool mainButtons: true

    Rectangle {
        anchors.fill: parent
        id: gameWindow
        width: (85*dimension + 160)//290
        height: (85*dimension + 160)
        color: "#faf9f0"
        property alias rectangleTiles: rectangleTiles

        Rectangle {
            id: dim5x5
            anchors.left: dim4x4.right
            anchors.leftMargin: 5
            anchors.bottom: rectangleTiles.top
            anchors.bottomMargin: 10
            width: 40
            height: 40
            color: "#8f7a66"
            radius: 5

            Text {
                id: textdim5
                color: "#ffffff"
                text: qsTr("5x5")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 15
            }

            MouseArea {
                id: dimButton5
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                visible: mainButtons
                onClicked:
                {
                    gametable.setdimension(5)
                }
            }
        }
        Rectangle {
            id: dim4x4
            anchors.left:  undoButtonRect.right
            anchors.leftMargin: 5
            anchors.bottom: rectangleTiles.top
            anchors.bottomMargin: 10
            width: 40
            height: 40
            color: "#8f7a66"
            radius: 5

            Text {
                id: textdim4
                color: "#ffffff"
                text: qsTr("4x4")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 15
            }

            MouseArea {
                id: dimButton4
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                visible: mainButtons
                onClicked:
                {
                    gametable.setdimension(4)
                }
            }
        }
        Rectangle {
            id: dim6x6
            anchors.left:  dim5x5.right
            anchors.leftMargin: 5
            anchors.bottom: rectangleTiles.top
            anchors.bottomMargin: 10
            width: 40
            height: 40
            color: "#8f7a66"
            radius: 5

            Text {
                id: textdim6
                color: "#ffffff"
                text: qsTr("6x6")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 15
            }

            MouseArea {
                id: dimButton6
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                visible: mainButtons
                onClicked:
                {
                    gametable.setdimension(6)
                }
            }
        }

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
                onClicked: gametable.newGame()
            }
        }

        Rectangle {
            id: undoButtonRect
            x: 170
            width: 80
            height: 40
            anchors.bottom: rectangleTiles.top
            anchors.bottomMargin: 10
            anchors.left: newGameButtonRect.right
            anchors.leftMargin: 5
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
                onClicked: gametable.undoPlay()
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
                    width: 75
                    height: 75
                    color: gametable.blockcolor
                    Behavior on color { PropertyAnimation { duration: 200}}
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
                if(verify_win)
                {
                    mainButtons = false;
                    gameWindow.visible = false;
                    winnerwindow.visible = true;
                }
                if(verify_lost)
                {
                    mainButtons = false;
                    gameWindow.visible = false;
                    loserwindow.visible = true;
                }

            }
        }
    }
    Item {
        id: winnerwindow
        width: 370     //(widthWindow - 20)
        height: 495    //(heightWindow - 20)
        visible: false

        Rectangle {
            id: optionsRect
            width: 270
            height: 380
            radius: 10

            anchors.fill: parent
            color: "#2831f1"

            Text {
                id: youwon
                x: -7
                y: 6
                width: 173
                height: 25
                color: "#ffffff"
                text: qsTr("YOU WON !")
                anchors.horizontalCenterOffset: 1
                font.bold: true
                font.pixelSize: 30
                anchors.topMargin: 203
                fontSizeMode: Text.FixedSize
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: cont
                x: 0
                y: 20
                width: 173
                height: 25
                color: "#ffffff"
                text: qsTr("Click to start a new game")
                anchors.horizontalCenterOffset: 1
                font.bold: true
                font.pixelSize: 25
                anchors.topMargin: 355
                fontSizeMode: Text.FixedSize
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
            }

            MouseArea {
                id: quitButton
                anchors.fill: parent
                onClicked:
                {
                    gametable.newGame()
                    mainButtons = true
                    winnerwindow.visible = false
                    gameWindow.visible = true
                }

            }
        }
    }
    Item {
        id: loserwindow
        width: 370     //(widthWindow - 20)
        height: 495    //(heightWindow - 20)
        visible: false

        Rectangle {
            id: optionsRectloser
            width: 270
            height: 380
            radius: 10

            anchors.fill: parent
            color: "#2831f1"

            Text {
                id: youlost
                x: -7
                y: 6
                width: 173
                height: 25
                color: "#ffffff"
                text: qsTr("YOU LOST !")
                anchors.horizontalCenterOffset: 1
                font.bold: true
                font.pixelSize: 30
                anchors.topMargin: 203
                fontSizeMode: Text.FixedSize
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: contlost
                x: 0
                y: 20
                width: 173
                height: 25
                color: "#ffffff"
                text: qsTr("Click to start a new game")
                anchors.horizontalCenterOffset: 1
                font.bold: true
                font.pixelSize: 25
                anchors.topMargin: 355
                fontSizeMode: Text.FixedSize
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
            }

            MouseArea {
                id: quitButtonlost
                anchors.fill: parent
                onClicked:
                {
                    gametable.newGame()
                    mainButtons = true
                    loserwindow.visible = false
                    gameWindow.visible = true
                }

            }
        }
    }


}
