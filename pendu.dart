import 'dart:html';
import 'dart:math';

// Liste de mots possibles pour le jeu
List<String> mots =
["soleil",
 "concentration",
 "université",
 "administration",
 "laval",
 "anticonstitutionnellement",
 "encadrement",
 "travail",
 "javascript",
 "programmation",
 "dart",
 "tellement",
 "plaisir",
 "enthousiaste"];

Random random = new Random();
int maximumVies = 11;
int vieCourante = 0;
String motChoisi = "";
String lettresEntrees = "";
List<String> motCache;
bool partieTerminee = false;

// Début du programme
void main() {
  // Ajouter les événements
  InputElement input = querySelector("#inputTextbox");
  input.onKeyPress.listen(lettreEntree);
  
  reset();
}

// Initialiser le programme
void reset() {
  
  // Choisir le mot de cette partie au hasard
  motChoisi = mots[random.nextInt(mots.length)];
  motCache = motChoisi.replaceAll(new RegExp('.'), '-').split("");
  querySelector("#texteMotChoisi").text = motCache.join();
  querySelector("#texteVictoire").text = "";
  
  // Image de départ
  vieCourante = 1;
  ImageElement img = querySelector("#imagePendu");
  img.src = "pendu" + vieCourante.toString() + ".png";
  
  partieTerminee = false;
}

// Événement lorsque l'on entre une lettre
void lettreEntree(KeyboardEvent event) {
  if(partieTerminee) {
    reset();
    return;
  }
  
  InputElement input = querySelector("#inputTextbox");
  String lettreChoisi = new String.fromCharCode(event.charCode);
  input.value = "";
  
  // Si la lettre est dans le mot...
  if(motChoisi.contains(lettreChoisi)) {
    
    // Mettre à jour les lettres cachées
    for (int i = 0; i < motChoisi.length; i++) {
      if(motChoisi[i] == lettreChoisi) {
        motCache[i] = lettreChoisi;
      }
    }
    
    // Afficher les lettres 
    querySelector("#texteMotChoisi").text = motCache.join();
    
    // Victoire si aucune lettre n'est cachée
    if(!motCache.contains('-')) {
      partieTerminee = true;
      querySelector("#texteVictoire").text = "Gagné !  Appuyez sur une touche pour ré-initialiser le jeu.";
    }
    
  } else {
    // Si la lettre n'était pas dans le mot, on l'ajoute aux lettres déja entrées.
    lettresEntrees = lettresEntrees + lettreChoisi;

    vieCourante++;
    
    // Afficher l'image correspondante
    ImageElement img = querySelector("#imagePendu");
    img.src = "pendu" + vieCourante.toString() + ".png";

    // Perdu la parti ?
    if(vieCourante == maximumVies) {
      partieTerminee = true;
      querySelector("#texteVictoire").text = "Perdu... Appuyez sur une touche pour ré-initialiser le jeu.";
    }
  }
  
}