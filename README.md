# 2048_SOUSA_NAKADAIRA
Replica of the game 2048 with QT and QML

## Authors:

  SOUSA FLORIANO João - [jsousafl](https://github.com/jsousafl)  
  NETO NAKADAIRA Lucas - [lunaka](https://github.com/lunaka)
  
## Enseignants

* **Emmanuel Dellandrea**

## Installing:

Pour lancer le programme en utilisant Qt Creator, il faut faire les étapes suivantes :

* Téléchargez les fichiers de cette page dans le fichier souhaité ;
* Ouvrez le logiciel Qt Creator ;
* Ouvrez le fichier "QMLTest.pro" sous Qt Creator (File -> Open File or Project... -> QMLTest.pro -> Open);
* Avec le projet ouvert et activé, démarrer le projet (ctrl + R) ;
* Jouez !

## Description:
  
  Le but du jeux est de déplacer les carrés numérotés et combiner ceux qui ont la même valeur. La combinaison des carrés de même valeur résulte en un carré de valeur égal à leur somme.  
  Après lancer le programme, une fenêtre s'ouvre avec un tableau de dimension 4x4. Le déplacement des carrés sont fait à partir des flèches du clavier.  
  La fenêtre est composée par :  
  * Le score du match en cours et le meilleur score des matchs déjà joués affichés en haut de la fenêtre ; 
  * Le button "New Game" qui permet de démarrer un nouveau match ;
  * Le button "Undo" qui permet de retourner au dernier mouvement fait ;
  * Les buttons "4x4", "5x5" et "6x6" qui permettent de redimensionner le tableau à la taille choisie. Ces buttons démarrent une nouvelle partie ;  
  S'il n'y a plus de mouvements possibles, une nouvelle fenêtre s'ouvre avec le message "YOU LOST ! Click to start a new game" et on peut cliquer sur toute la fenêtre pour démarrer un nouveau match.  
  Si on arrive à faire un bloc de valeur 2048, une nouvelle fenêtre s'ouvre avec le message "YOU WON ! Click to start a new game" et on peut cliquer sur toute la fenêtre pour démarrer un nouveau match.  

## Future functionnalités:
  Des possibles futures functionnalités sont :
  * Chosir la couleur de la fenêtre ;
  * Choisir la langue ;
  * Établir le mouvement des carrés lors de leur déplacement ;
  * Après gagner le match, pouvoir choisir entre démarrer un nouveau match ou continuer le même.
