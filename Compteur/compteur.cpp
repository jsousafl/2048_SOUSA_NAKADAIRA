#include "compteur.h"

Compteur::Compteur(QObject *parent) : QObject(parent)
{
    valeur = 10;
    emit cptChanged();
}


void Compteur::increment()
{
    valeur++;
    emit cptChanged();
}

void Compteur::decrement()
{
    valeur--;
    emit cptChanged();
}

QString Compteur::readCompteur()
{
    return QString::number(valeur);
}
