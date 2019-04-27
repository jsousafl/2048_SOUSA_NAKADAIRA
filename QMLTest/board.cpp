#include "board.h"
#include <iostream>

using namespace std;

Board::Board(QObject *parent) : QObject(parent)
{
    dimension = 4;
    score = 0;
    bestscore = 0;
    nb_rounds = 0;
    end = false;
    status = 'P';
    QMLBlockIndexX = 0;
    QMLBlockIndexY = 0;
    QMLBlockIndexColor = 0;
    QMLBlockIndexNumber = 0;
    QMLBlockIndexTextColor = 0;
    allocateActualBoard();
    createNewBlock(true);
    boardSignal();
}

void Board::createNewBlock(bool flag_start)
{
    vector<int> indexNullBlocs;
    int nblock_index, random_integer, somme_score = 0;
    srand(time(NULL));
    for (int i=0;i<dimension*dimension;i++)
    {
        if(TABAct[i]->getvalue()==0)
        {
            indexNullBlocs.push_back(i);
        }
    }
    random_integer = rand()% indexNullBlocs.size();
    nblock_index = indexNullBlocs[random_integer];


    if(flag_start==false)
    {
       vector<int> values = {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,4,4,4}; //85% of 2 and 15% of 4
       random_integer = rand() % values.size();
       TABAct[nblock_index]->setvalue(values[random_integer]); //new block can be a 2 or a 4
    }
    else
    {
        TABAct[nblock_index]->setvalue(2);
    }

    // Mise a jour du score
    for (int i =0;i<dimension*dimension;i++)
    {
        somme_score += TABAct[i]->getvalue();
    }
    //setscore(somme_score);

    // Mise a jour du bestscore
    if (bestscore < somme_score)
        setbestscore(somme_score);
}

//Fusion and mouvement
vector<int> Board::checkMouvLimits(int id_mov)
{
    vector<int> index_mobileBlocks;
    index_mobileBlocks.clear();
    switch (id_mov)
    {
    case 1: //up mouvement
        for (int i =0;i<dimension*dimension;i++)
        {
            if((TABAct[i]->getrow()!=0)&&(TABAct[i]->getvalue()!=0))
            {
                index_mobileBlocks.push_back(i);
            }

        }
        break;
    case 2: //down mouvement
        for (int i=(dimension*dimension)-1;i>=0;i=i-1)
        {
            if((TABAct[i]->getrow()!=dimension-1)&&(TABAct[i]->getvalue()!=0))
            {
                index_mobileBlocks.push_back(i);
            }

        }
        break;
    case 3: //left mouvement
        for (int i =0;i<dimension*dimension;i++)
        {
            if((TABAct[i]->getcol()!=0)&&(TABAct[i]->getvalue()!=0))
            {
                index_mobileBlocks.push_back(i);
            }

        }
        break;
    case 4://right mouvement
        for (int i=(dimension*dimension)-1;i>=0;i=i-1)
        {
            if((TABAct[i]->getcol()!=dimension-1)&&(TABAct[i]->getvalue()!=0))
            {
                index_mobileBlocks.push_back(i);
            }

        }
        break;

    }
    if(index_mobileBlocks.empty())
    {
        setstatus('L');
        //call end game
    }
    return index_mobileBlocks;
}
void Board::fusionBlocks(int indexreceiver, int indexsender)
{
    TABAct[indexreceiver]->setvalue(2*(TABAct[indexsender]->getvalue()));;
    TABAct[indexsender]->setvalue(0);

}
void Board::moveBlocks(int indexreceiver, int indexsender)
{
    TABAct[indexreceiver]->setvalue((TABAct[indexsender]->getvalue()));;
    TABAct[indexsender]->setvalue(0);
}
void Board::checkforPairs(int id_mov)
{
    int aux_index1,aux_index2,aux_count,lim_inf;
        switch (id_mov)
        {
        case 1: //UP mouvement
            aux_index1 = dimension*(dimension-2);
            for (int i =0;i<dimension;i++)
            {
                for (int j=i;j<=aux_index1;j = j+dimension)
                {
                    if((TABAct[j]->getvalue()==0))
                    {
                        continue;//not searching for fusion
                    }
                    else //searching for fusion
                    {
                        aux_count = j+dimension;
                        while(aux_count<=aux_index1+dimension)
                        {
                            if(TABAct[j]->getvalue()==TABAct[aux_count]->getvalue())
                            {
                                fusionBlocks(j,aux_count);//fusion
                                aux_count = aux_index1+dimension+1; //stop searching for fusion
                            }
                            else if(TABAct[aux_count]->getvalue()!=0)
                            {
                                aux_count = aux_index1+dimension+1;//element not fusionable ->stop searching
                            }
                            else {
                                aux_count = aux_count+dimension;
                            }
                        }
                    }
                }
                aux_index1 = aux_index1+1;
            }
            break;
        case 2: //down mouvement
            aux_index2 = dimension*(dimension-1);
            lim_inf = dimension;
            for (int i=aux_index2;i<dimension*dimension;i++)
            {
                for (int j=i;j>=lim_inf;j=j-dimension)
                {
                    if((TABAct[j]->getvalue()==0))
                    {
                        continue;//not searching for fusion
                    }
                    else //searching for fusion
                    {
                        aux_count = j-dimension;
                        while(aux_count>=lim_inf-dimension)
                        {
                            if(TABAct[j]->getvalue()==TABAct[aux_count]->getvalue())
                            {
                                fusionBlocks(j,aux_count);//fusion
                                aux_count = lim_inf-dimension-1; //stop searching for fusion
                            }
                            else if(TABAct[aux_count]->getvalue()!=0)
                            {
                                aux_count = lim_inf-dimension-1;//element not fusionable ->stop searching
                            }
                            else
                            {
                                aux_count = aux_count-dimension;
                            }

                        }
                    }
                }
                lim_inf = lim_inf+1;

            }
            break;
        case 3://left mouvement
            aux_index1 = dimension-2;
            aux_index2 = dimension*(dimension-1);
            for (int i = 0;i<=aux_index2;i=i+dimension)
            {
                for (int j=i;j<=aux_index1;j++)
                {
                    if((TABAct[j]->getvalue()==0))
                    {
                        continue;//not searching for fusion
                    }
                    else //searching for fusion
                    {
                        aux_count = j+1;
                        while(aux_count<=aux_index1+1)
                        {
                            if(TABAct[j]->getvalue()==TABAct[aux_count]->getvalue())
                            {
                                fusionBlocks(j,aux_count);//fusion
                                aux_count = aux_index1+2 ; //stop searching for fusion
                            }
                            else if(TABAct[aux_count]->getvalue()!=0)
                            {
                                aux_count = aux_index1+2;//element not fusionable ->stop searching
                            }
                            else {
                                aux_count = aux_count+1;
                            }

                        }
                    }


                }
                aux_index1 = aux_index1+dimension;

            }
            break;
        case 4: //right mouvement
            lim_inf = 1;
            for (int i=dimension-1;i<dimension*dimension;i = i+dimension)
            {
                for (int j =i;j>=lim_inf;j=j-1)
                {
                    if((TABAct[j]->getvalue()==0))
                    {
                        continue;//not searching for fusion
                    }
                    else //searching for fusion
                    {
                        aux_count = j-1;
                        while(aux_count>=lim_inf-1)
                        {
                            if(TABAct[j]->getvalue()==TABAct[aux_count]->getvalue())
                            {
                                fusionBlocks(j,aux_count);//fusion
                                aux_count = lim_inf-2 ; //stop searching for fusion
                            }
                            else if(TABAct[aux_count]->getvalue()!=0)
                            {
                                aux_count = lim_inf-2;//element not fusionable ->stop searching
                            }
                            else {
                                aux_count = aux_count-1;
                            }
                        }
                    }

                }
                lim_inf = lim_inf +dimension;
            }
            break;
        }
}
void Board::goUP()
{
    vector<int> index_mobileBlocks;
    int col_aux;
    checkforPairs(1); //make fusion of fusionable elements
    index_mobileBlocks = checkMouvLimits(1); //getting index vector of mobile blocks
    for (auto & index : index_mobileBlocks) //iterating within the index vector
    {
        col_aux = TABAct[index]->getcol();
        for (int i=col_aux;i<index;i=i+dimension)  //searching for 0 above the mobile block
        {
            if(TABAct[i]->getvalue()==0)
            {
                moveBlocks(i,index);//already found the position to move
                break;
            }
        }
    }
    savegame();
    createNewBlock(false);
    boardSignal();
}
void Board::goDown()
{
    vector<int> index_mobileBlocks;
    int col_aux,aux_index1;
    checkforPairs(2); //make fusion of fusionable elements
    index_mobileBlocks = checkMouvLimits(2); //getting index vector of mobile blocks
    for (auto & index : index_mobileBlocks) //iterating within the index vector
    {
        col_aux = TABAct[index]->getcol();
        aux_index1 = dimension*(dimension-1);
        for (int i=col_aux+aux_index1;i>index;i=i-dimension)  //searching for 0 above the mobile block
        {
            if(TABAct[i]->getvalue()==0)
            {
                moveBlocks(i,index);
                break; //already found the position to move
            }
        }
    }
    savegame();
    createNewBlock(false);
    boardSignal();
}
void Board::goLeft()
{
    vector<int> index_mobileBlocks;
    int row_aux,index_row;
    checkforPairs(3); //make fusion of fusionable elements
    index_mobileBlocks = checkMouvLimits(3); //getting index vector of mobile blocks
    for (auto & index : index_mobileBlocks) //iterating within the index vector
    {
        row_aux = TABAct[index]->getrow();
        index_row = row_aux*dimension;
        for (int i=index_row;i<index;i++)  //searching for 0 above the mobile block
        {
            if(TABAct[i]->getvalue()==0)
            {
                moveBlocks(i,index);//already found the position to move
                break;
            }
        }
    }
    savegame();
    createNewBlock(false);
    boardSignal();
}
void Board::goRight()
{
    vector<int> index_mobileBlocks;
    int row_aux,index_end_row;
    checkforPairs(4); //make fusion of fusionable elements
    index_mobileBlocks = checkMouvLimits(4); //getting index vector of mobile blocks
    for (auto & index : index_mobileBlocks) //iterating within the index vector
    {
        row_aux = TABAct[index]->getrow();
        index_end_row = (row_aux+1)*dimension - 1;
        for (int i=index_end_row;i>index;i=i-1)  //searching for 0 above the mobile block
        {
            if(TABAct[i]->getvalue()==0)
            {
                moveBlocks(i,index);//already found the position to move
                break;
            }
        }
    }    
    savegame();
    createNewBlock(false);
    boardSignal();
}

//Gestion de memoire
void Board::allocateActualBoard()
{
    if (nb_rounds == 0){
        TABAct = new Block*[dimension*dimension];
        int row_count = 0;
        int col_count = -1;
        int aux = dimension;
        for (int i=0;i<dimension*dimension;i++)
        {
            if(i == aux)
            {
                row_count++;
                aux = aux+dimension;
                col_count = -1;
            }
            col_count++;
            TABAct[i] = new Block(row_count,col_count);
        }
    }
    histVecTAB = new Block**[1];
    histVecTAB[0] = TABAct;
    countnewround();
    setscore(nb_rounds);
}
void Board::destroyActualBoard()
{
    if (TABAct!=NULL)
    {
        for (int i=0;i<dimension*dimension;i++)
        {
            delete TABAct[i];
        }
        delete [] TABAct;
        for (int i=0;i<nb_rounds;i++)
        {
            delete histVecTAB[i];
        }
        delete histVecTAB;
        histVecTAB = NULL;
        TABAct = NULL;
    }
}
void Board::savegame(){
    Block*** block_aux;
    int value;
    block_aux = new Block**[nb_rounds];
    for(int i=0;i<nb_rounds;i++){
        block_aux[i] = histVecTAB[i];
    }
    delete histVecTAB;
    histVecTAB = new Block**[nb_rounds+1];
    for(int i=0;i<nb_rounds;i++){
        histVecTAB[i] = block_aux[i];
    }
    delete block_aux;
    //Block** Aux = histVecTAB[nb_rounds];
    //for (int i=0;i<dimension*dimension;i++)
    //{
    //    value = TABAct[i]->getvalue();
    //    (histVecTAB[nb_rounds])[i]->setvalue(value);
    //}
    histVecTAB[nb_rounds] = TABAct;
    countnewround();
    setscore(nb_rounds);
}
void Board::endGame(){
    for(int i=0;i<dimension*dimension;i++)
    {
        if(TABAct[i]->getvalue()==0){
            end = false;
            break;
        }
    }
}

//gets
int Board::getscore()
{
    return score;
}
int Board::getbestscore()
{
    return bestscore;
}
int Board::getdimension()
{
    return dimension;
}
char Board::getstatus()
{
    return status;
}
int Board::getrounds()
{
    return nb_rounds;
}
Block** Board::getTAB()
{
    return TABAct;
}

//sets
void Board::setround(int round)
{
    nb_rounds = round;
}
void Board::countnewround()
{
    nb_rounds++;
}
void Board::setscore(int val_score)
{
    score = val_score;
}
void Board::setstatus(char newstatus)
{
    status = newstatus;
}
void Board::setbestscore(int best_score)
{
    bestscore = best_score;
}
void Board::setdimension(int dim)
{
    if(dim>2)
    {
        dimension = dim;
        destroyActualBoard();
        allocateActualBoard();
        createNewBlock(true);
    }
}

//Game Methods
void Board::newGame()
{
    setround(1);
    for (int i=0;i<dimension*dimension;i++)
    {
        TABAct[i]->setvalue(0);
    }
    createNewBlock(true);
    boardSignal();
}
void Board::undoPlay()
{
    int value;
    histVecTAB[nb_rounds-1] = NULL;
    nb_rounds -= 1;
    for (int i=0;i<dimension*dimension;i++)
    {
        value = (histVecTAB[nb_rounds-1])[i]->getvalue();
        TABAct[i]->setvalue(value);
    }
    boardSignal();
}

//Sending data to GUI
QString Board::sendBlocknumber()
{
    int blockNumber;
    if(QMLBlockIndexNumber == dimension*dimension)
    {
        QMLBlockIndexNumber = 0;
    }
    blockNumber = TABAct[QMLBlockIndexNumber]->getvalue();
    QMLBlockIndexNumber++;
    return QString::number(blockNumber);
}
QString Board::sendBlockColor()
{
    QString blockColor;
    if(QMLBlockIndexColor == dimension*dimension)
    {
        QMLBlockIndexColor = 0;
    }
    blockColor = TABAct[QMLBlockIndexColor]->getcolorblock();
    QMLBlockIndexColor++;
    return blockColor;
}
QString Board::sendBlockTextColor()
{
    QString textColor;
    if(QMLBlockIndexTextColor == dimension*dimension)
    {
        QMLBlockIndexTextColor = 0;
    }
    textColor = TABAct[QMLBlockIndexTextColor]->getcolortext();
    QMLBlockIndexTextColor++;
    return textColor;

}
int Board::sendBlockX()
{
    int xBlock,row_block;
    if(QMLBlockIndexX == dimension*dimension)
    {
        QMLBlockIndexX = 0;
    }
    row_block = TABAct[QMLBlockIndexX]->getrow();
    QMLBlockIndexX++;
    xBlock = (row_block*85)+10;
    return xBlock;

}
int Board::sendBlockY()
{
    int yBlock,col_block;
    if(QMLBlockIndexY == dimension*dimension)
    {
        QMLBlockIndexY = 0;
    }
    col_block = TABAct[QMLBlockIndexY]->getcol();
    QMLBlockIndexY++;
    yBlock = (col_block*85)+10;
    return yBlock;
}
Board::~Board()
{
    destroyActualBoard();
}

