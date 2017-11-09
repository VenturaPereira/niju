:- include('print.pl').


/*
preplay(PiecesPlayer1, PiecesPlayer2, InitialBoard) :-

  buildPiecesP1(PiecesPlayer1),
  buildPiecesP2(PiecesPlayer2),
  initialBoard(InitialBoard).
*/



/*
startPlay(PiecesPlayer1, InitialBoard, PieceNumber, NewPiecesPlayer1, NextBoard, player2) :-

  playFirstPiece(InitialBoard, NextBoard, PiecesPlayer1, PieceNumber, NewPiecesPlayer1).
*/


/*
play(PiecesPlayer1, _, Board, PieceNumber, Row, Column, NewPiecesPlayer1, _, NextBoard, player1, player2) :-

  playPiece(Board, NextBoard, Row, Column, PieceNumber, PiecesPlayer1, NewPiecesPlayer1).


play(_, PiecesPlayer2, Board, PieceNumber, Row, Column, _, NewPiecesPlayer2, NextBoard, player2, player1) :-

  playPiece(Board, NextBoard, Row, Column, PieceNumber, PiecesPlayer2, NewPiecesPlayer2).
*/
