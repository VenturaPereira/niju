:- include('play.pl').



beginGame :-
  printMenuTitle, nl,
  write('Choose your option with a dot!'),
  read(Option),
  (

  Option =:= 1 -> playOption;
  Option =:= 2 -> printRulesMenu;
  Option =:= 3 -> printCreditsMenu;
  Option =:= 0 -> beginGame

  ).

playOption :-

  preplay(Player1Pieces,Player2Pieces,InitialBoard),nl,
  write('Choose piece to play, rotation direction and times to rotate'),
  read(ChosenPieceNumber),
  read(Direction),
  read(Times),
  rotatePlayerPiece(Player1Pieces, ChosenPieceNumber, Direction, Times, Player1PiecesAfterRotation),
  startPlay(Player1PiecesAfterRotation, InitialBoard, ChosenPieceNumber, PiecesPlayer1AFP, NextBoard),
  printFullBoard(NextBoard).



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





rotatePlayerPiece(Pieces,PieceNumber, Direction, Times, NewPieces) :-

  nth0(PieceNumber,Pieces,Piece),
  rotatePiece(Piece,PieceRotated,Direction,Times),
  replaceInPosition(Pieces,NewPieces,PieceNumber,PieceRotated).




%
