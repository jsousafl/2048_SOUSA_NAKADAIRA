#ifndef BOARD_H
#define BOARD_H


#include "block.h"
#include <QObject>
#include <QString>
#include <vector>
#include <stdlib.h>
#include <time.h>

using namespace std;


class Board: public QObject
{
    Q_OBJECT
public:
    explicit Board(QObject *parent = 0);
    ~Board();

    //Game methods
    Q_INVOKABLE void newGame();
    Q_INVOKABLE void undoPlay();
    void endGame();
    void winGame();

    //Set Methods
    Q_INVOKABLE void setdimension(int dim);
    Q_INVOKABLE void setscore(int val_score);
    Q_INVOKABLE void setbestscore(int best_score);
    Q_INVOKABLE void setstatus(char newstatus);
    Q_INVOKABLE void setround(int round);

    void countnewround();

    //Get Methods
    Q_PROPERTY(int dimension READ getdimension NOTIFY boardSignal)
    int getdimension();
    Q_PROPERTY(int score READ getscore NOTIFY boardSignal)
    int getscore();
    Q_PROPERTY(int bestscore READ getbestscore NOTIFY boardSignal)
    int getbestscore();
    char getstatus();
    int getrounds();
    Block** getTAB();

    //Mouvement methods
    vector<int> checkMouvLimits(int id_mov);
    void checkforPairs(int id_mov, bool command_fusion);
    Q_INVOKABLE void goUP();
    Q_INVOKABLE void goDown();
    Q_INVOKABLE void goLeft();
    Q_INVOKABLE void goRight();

    void fusionBlocks(int indexreceiver, int indexsender);
    void moveBlocks(int indexreceiver, int indexsender);
    void createNewBlock(bool flag_start);
    bool verifyCommand(int id_move);

    //GUI Methods
    Q_PROPERTY(QString blocknumber READ sendBlocknumber NOTIFY boardSignal)
    QString sendBlocknumber();
    Q_PROPERTY(QString blockcolor READ sendBlockColor NOTIFY boardSignal)
    QString sendBlockColor();
    Q_PROPERTY(QString blocktextcolor READ sendBlockTextColor NOTIFY boardSignal)
    QString sendBlockTextColor();

    Q_PROPERTY(int posX READ sendBlockX NOTIFY boardSignal)
    int sendBlockX();
    Q_PROPERTY(int posY READ sendBlockY NOTIFY boardSignal)
    int sendBlockY();
    Q_PROPERTY(bool verify_win READ sendwin NOTIFY boardSignal)
    bool sendwin();
    Q_PROPERTY(bool verify_lost READ sendlost NOTIFY boardSignal)
    bool sendlost();


signals:
    void boardSignal();
private:
    int QMLBlockIndexNumber;
    int QMLBlockIndexX;
    int QMLBlockIndexY;
    int QMLBlockIndexColor;
    int QMLBlockIndexTextColor;

    Block** TABAct;
    int*** histIntTAB;
    int dimension;
    int score;
    int nb_rounds;
    int bestscore;
    bool end_game;
    bool fusion_possible;
    char status; //W->winner, L->>loser, P->playing
    bool verify_win;
    bool verify_lost;

    void allocateActualBoard();
    void destroyActualBoard();
    void savegame();

};

#endif // BOARD_H
