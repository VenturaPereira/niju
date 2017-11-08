:- include('print.pl').



beginGame :-
printMenuTitle, nl,
write('Choose your option with a dot!'),
read(Option),
(

Option =:= 2 -> printRulesMenu;
Option =:= 3 -> printCreditsMenu;
Option =:= 0 -> beginGame

).

printRulesMenu :-
printRules,
read(Option),
(
Option =:= 0 -> beginGame
).

printCreditsMenu :-
printCredits,
read(Option),
(
Option =:= 0 -> beginGame
).






decisionRotateUser:-
  buildPiecesP1(Pieces),
  printPlayerPieces(Pieces,player1),
  write('Do you wish to rotate? press y or n'), nl,
  read(Wish),
  Wish = 'y',
  write('Which Piece?'),nl,
  read(NumberPiece),
  nth0(NumberPiece,Pieces,Piece),
  rotatedPieceOfUser(Piece,PieceRotated),
  replaceInPosition(Pieces,NewPieces,NumberPiece,PieceRotated),
  printPlayerPieces(NewPieces,player1).

rotatedPieceOfUser(Piece, PieceRotated) :-

  write('In which direction do you wish to rotate?'),nl,
  read(Direction),
  write('How many times?'),nl,
  read(Times),
  rotatePiece(Piece,PieceRotated,Direction,Times).


rotatedPieceOfUser(Piece,Piece) :-
 write('Here').
