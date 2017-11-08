:- include('print.pl').

preplay(PiecesPlayer1, PiecesPlayer2, InitialBoard) :-

  buildPiecesP1(PiecesPlayer1),
  buildPiecesP2(PiecesPlayer2),
  initialBoard(InitialBoard),
  printFullBoard(InitialBoard).


startPlay(PiecesPlayer1, InitialBoard, PieceNumber, NewPiecesPlayer1, NextBoard) :-

  playFirstPiece(InitialBoard, NextBoard, PiecesPlayer1, PieceNumber, NewPiecesPlayer1).
