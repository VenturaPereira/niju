:- include('print.pl').

rotatedPieceOfUser(Piece, PieceRotated) :-
  write('In which direction do you wish to rotate?'),
  read(Direction),
  write('How many times?'),
  read(Times),
  rotatePiece(Piece,PieceRotated,Direction,Times).
