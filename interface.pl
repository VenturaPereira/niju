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




playOption:-
preplay(Player1Pieces,Player2Pieces,InitialBoard),nl,
playOptionCycle(Player1Pieces,Player2Pieces,InitialBoard).





playOptionCycle(Player1Pieces,Player2Pieces,InitialBoard):-
  length(Player1Pieces,Size),
   write(Size),
  Size =:= 2,
  printPlayerPieces(Player1Pieces, player1),nl,
  write('Choose piece to play, rotation direction and times to rotate'),
  read(ChosenPieceNumber),
  read(Direction),
  read(Times),
  rotatePlayerPiece(Player1Pieces, ChosenPieceNumber, Direction, Times, Player1PiecesAfterRotation),
  startPlay(Player1PiecesAfterRotation, InitialBoard, ChosenPieceNumber, PiecesPlayer1AFP, NextBoard),
  printFullBoard(NextBoard),
  playOptionCycleSecond(PiecesPlayer1AFP,Player2Pieces,NextBoard).


playOptionCycle(Player1Pieces,Player2Pieces,InitialBoard):-
 length(Player1Pieces,Size),
  Size < 2,
  Size > 0,
  printPlayerPieces(Player1Pieces, player1),nl,
  write('Choose piece to play, rotation direction and times to rotate'),
  read(ChosenPieceNumber),
  read(Direction),
  read(Times),
  rotatePlayerPiece(Player1Pieces, ChosenPieceNumber, Direction, Times, Player1PiecesAfterRotation),
  write('Choose row and collum to place the piece:'),
  read(Row),
  read(Coll),
  (

  \+ validPlay(InitialBoard,Row,Coll) -> playOptionCycle(Player1PiecesAfterRotation,Player2Pieces,InitialBoard);
  validPlay(InitialBoard,Row,coll) -> write('Continue')
  ),
  playPiece(InitialBoard,NextBoard,Row,Coll,ChosenPieceNumber,Player1PiecesAfterRotation,PiecesPlayer1AFP),
  printFullBoard(NextBoard),
  playOptionCycleSecond(PiecesPlayer1AFP,Player2Pieces,NextBoard).

playOptionCycle([],_,_) :-
write('Fim de jogo').


playOptionCycleSecond(_,[],_).

playOptionCycleSecond(Player1Pieces,Player2Pieces,InitialBoard) :-
  length(Player2Pieces, Size),
  Size > 0,
  printPlayerPieces(Player2Pieces, player2),nl,
  write('Choose piece to play, rotation direction and times to rotate'),
  read(ChosenPieceNumber),
  read(Direction),
  read(Times),
  rotatePlayerPiece(Player2Pieces, ChosenPieceNumber, Direction, Times, Player2PiecesAfterRotation),
  write('Choose row and collum to place the piece:'),
  read(Row),
  read(Coll),
  (

  \+ validPlay(InitialBoard,Row,Coll) -> playOptionCycleSecond(Player1Pieces,Player2PiecesAfterRotation,InitialBoard);
  validPlay(InitialBoard,Row,Coll) -> write('Continue')
  ),
  playPiece(InitialBoard,NextBoard,Row,Coll,ChosenPieceNumber,Player2PiecesAfterRotation,PiecesPlayer2AFP),
  printFullBoard(NextBoard),
  playOptionCycle(Player1Pieces,PiecesPlayer2AFP,NextBoard).






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
