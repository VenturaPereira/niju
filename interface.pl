:- include('print.pl').

beginGame :-
  printMenuTitle, nl,
  readIntBetween(Option,0,3,'Choose your option with a dot!','Invalid Number'),

  (
    Option =:= 1 -> playOption;
    Option =:= 2 -> printRulesMenu;
    Option =:= 3 -> printCreditsMenu;
    Option =:= 0 -> write('Bye')

  ).


playOption:-

  preplay(Player1Pieces,Player2Pieces,InitialBoard),
  startPlay(Player1Pieces, InitialBoard, Player1PiecesAFM, BoardAFM, CurrentPlayer),
  playCycle(Player1PiecesAFM, Player2Pieces,BoardAFM, CurrentPlayer).

chooseFinalMessage(GlobalScorePlayer1,GlobalScorePlayer2) :-

  (
    GlobalScorePlayer1 > GlobalScorePlayer2 -> printFinalScore(GlobalScorePlayer1,GlobalScorePlayer2, player1),nl;
    GlobalScorePlayer1 < GlobalScorePlayer2 -> printFinalScore(GlobalScorePlayer1,GlobalScorePlayer2, player2),nl;
    GlobalScorePlayer1 =:= GlobalScorePlayer2 -> printFinalScore(GlobalScorePlayer1,GlobalScorePlayer2, empty),nl
  ),

  readIntBetween(_,0,0,'Go back?','Invalid Number'),
  beginGame.


playCycle([],[],FinalBoard,_) :-

  printFullBoard(FinalBoard),

  calculateGlobalScore(FinalBoard,GlobalScorePlayer1,player1),
  calculateGlobalScore(FinalBoard,GlobalScorePlayer2,player2),

  write('Fim do Jogo'),nl,
  chooseFinalMessage(GlobalScorePlayer1,GlobalScorePlayer2).

playCycle(PiecesPlayer1, PiecesPlayer2, CurrentBoard, CurrentPlayer) :-

  play(PiecesPlayer1, PiecesPlayer2, CurrentBoard, NewPiecesPlayer1, NewPiecesPlayer2, NextBoard, CurrentPlayer, NextPlayer),
  playCycle(NewPiecesPlayer1,NewPiecesPlayer2, NextBoard, NextPlayer).

preplay(PiecesPlayer1, PiecesPlayer2, InitialBoard) :-

  buildPiecesP1(PiecesPlayer1),
  buildPiecesP2(PiecesPlayer2),
  initialBoard(InitialBoard).

startPlay(PiecesPlayer1, InitialBoard, NewPiecesPlayer1, NextBoard, player2) :-

  printFullBoard(InitialBoard),
  printPlayerPieces(PiecesPlayer1,player1),
  askPieceNumber(PiecesPlayer1,FirstPieceNumber),
  askPieceRotation(PiecesPlayer1,FirstPieceNumber,Player1PiecesAR),
  playFirstPiece(InitialBoard, NextBoard, Player1PiecesAR, FirstPieceNumber, NewPiecesPlayer1).

play(PiecesPlayer1, PiecesPlayer2, Board, NewPiecesPlayer1, PiecesPlayer2, NextBoard, player1, player2) :-

  printFullBoard(Board),
  printPlayerPieces(PiecesPlayer1,player1),
  askPieceNumber(PiecesPlayer1,PieceNumber),
  askPieceRotation(PiecesPlayer1,PieceNumber,Player1PiecesAR),
  askPiecePosition(Board,Row,Column),
  playPiece(Board, NextBoard, Row, Column, PieceNumber, Player1PiecesAR, NewPiecesPlayer1).

play(PiecesPlayer1, PiecesPlayer2, Board, PiecesPlayer1, NewPiecesPlayer2, NextBoard, player2, player1) :-

  printFullBoard(Board),
  printPlayerPieces(PiecesPlayer2,player2),

  askPieceNumber(PiecesPlayer2,PieceNumber),
  askPieceRotation(PiecesPlayer2,PieceNumber,Player2PiecesAR),
  askPiecePosition(Board,Row,Column),
  playPiece(Board, NextBoard, Row, Column, PieceNumber, Player2PiecesAR, NewPiecesPlayer2).

askPieceRotation(Pieces,PieceNumber,NewPieces) :-

  askPieceRotationDirection(Direction),
  askPieceRotationTimes(Times),
  rotatePlayerPiece(Pieces,PieceNumber,Direction,Times,NewPieces),
  !.

askPieceRotationTimes(Times) :-

  readInt(Times,'Choose Rotation Times','Invalid Number'),
  Times < 3,
  Times > -1.

askPieceRotationTimes(Times) :-
  write('Invalid Number of Times (Choose between 0 and 2)'),
  askPieceRotationTimes(Times).

askPieceRotationDirection(Direction) :-
  readChar(Direction,'Choose Rotation Direction', 'Invalid Direction'),
  (Direction = l; Direction = r).

askPieceRotationDirection(Direction) :-
  write('Invalid Direction'),
  askPieceRotationDirection(Direction).

askPiecePosition(Board, Row, Column) :-

  readInt(Row,'Insert Row Number','Invalid Row'),
  readInt(Column,'Insert Column Number','Invalid Column'),
  validPlay(Board,Row,Column).

askPiecePosition(Board,Row,Column) :-

  write('Invalid Position'),
  askPiecePosition(Board,Row,Column).

askPieceNumber(Pieces,PieceNumber) :-

  readInt(PieceNumber,'Please select piece to play', 'Invalid Piece Number'),
  nth0(PieceNumber,Pieces,_).

askPieceNumber(Pieces,PieceNumber) :-

  write('Invalid Piece Index: '),
  askPieceNumber(Pieces,PieceNumber).

printRulesMenu :-
  printRules,
  read(Option),
  (
    Option =:= 0 -> beginGame;
    printRulesMenu

  ).

printCreditsMenu :-
  printCredits,
  read(Option),
  (
    Option =:= 0 -> beginGame;
    printCreditsMenu
  ).

rotatePlayerPiece(Pieces,PieceNumber, Direction, Times, NewPieces) :-

  nth0(PieceNumber,Pieces,Piece),
  rotatePiece(Piece,PieceRotated,Direction,Times),
  replaceInPosition(Pieces,NewPieces,PieceNumber,PieceRotated).


%
