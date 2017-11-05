%"reconsult('/Users/joaofurriel/Documents/Estudo/MIEIC/Ano3/PLOG/Projecto/print.pl')."

:-include('pieces.pl').

printElement(X) :- X =:= 1, write(' 1 ').
printElement(X) :- X =:= -1, write('   ').
printElement(X) :- X =:= 0, write('   ').

printPlayerMark(player1) :- write(' W ').
printPlayerMark(player2) :- write(' B ').
printPlayerMark(empty) :- write('   ').

emptySpace([[-1, -1, -1],[-1, -1, -1],[-1, -1, -1]]).

printColumnNumber(NumberOfColumns) :-

  printColumnNumber(NumberOfColumns,0).

printColumnNumber(NumberOfColumns,NumberOfColumns).

printColumnNumber(NumberOfColumns,Column) :-

  write('     '),
  write(Column),
  write('     '),
  NextColumn is Column + 1,
  printColumnNumber(NumberOfColumns,NextColumn).

printInitialPieceRowSeparation(BoardRow) :-

  write('    --------- '),
  [_ | Rest] = BoardRow,
  printPieceRowSeparation(Rest).

printPieceRowSeparation([]).

printPieceRowSeparation(BoardRow) :-

	BoardRow \= [],
	[_ | Rest] = BoardRow,
	write(' --------- '),
	printPieceRowSeparation(Rest).

printFirstPieceRow([X1,X2,X3]) :-

  write('   |'),
  printElement(X1),
  printElement(X2),
  printElement(X3),
  write('|').

printPieceRow([X1,X2,X3]) :-

	write('|'),
	printElement(X1),
	printElement(X2),
	printElement(X3),
	write('|').

printFirstPieceRow2([X1,_,X3],PlayerColor,RowNumber) :-

  write(RowNumber),
  write('  |'),
  printElement(X1),
  printPlayerMark(PlayerColor),
  printElement(X3),
  write('|').


printPieceRow2([X1,_,X3],PlayerColor) :-

  write('|'),
  printElement(X1),
  printPlayerMark(PlayerColor),
  printElement(X3),
  write('|').


printFullBoard(Board) :-

  nth0(0,Board,FirsRow),
  length(FirsRow,NumberOfColumns),
  write('   '),
  printColumnNumber(NumberOfColumns),
  nl,
  printBoard(Board,0).


printBoard([],_).

printBoard(Board,RowNumber) :-

	[Row | Rest] = Board,
	printInitialPieceRowSeparation(Row),
	nl,
	printPiecesRow1FirstPiece(Row),
	nl,
	printPiecesRow2FirstPiece(Row,RowNumber),
	nl,
	printPiecesRow3FirstPiece(Row),
	nl,
	printInitialPieceRowSeparation(Row),
	nl,
  NextRow is RowNumber + 1,
	printBoard(Rest,NextRow).


printPiecesRow1FirstPiece(BoardRow) :-

  [Piece | Rest] = BoardRow,
  [PieceRow1 | _] = Piece,
  printFirstPieceRow(PieceRow1),
  printPiecesRow1(Rest).


printPiecesRow1([]).

printPiecesRow1(BoardRow) :-

	[Piece | Rest] = BoardRow,
	[PieceRow1 | _] = Piece,
	printPieceRow(PieceRow1),
	printPiecesRow1(Rest).


printPiecesRow2FirstPiece(BoardRow,RowNumber) :-

	[Piece | Rest] = BoardRow,
	[_,PieceRow2,_] = Piece,
  playerFromPiece(Piece,Player),
	printFirstPieceRow2(PieceRow2,Player,RowNumber),
	printPiecesRow2(Rest).


printPiecesRow2([]).

printPiecesRow2(BoardRow) :-

	[Piece | Rest] = BoardRow,
	[_,PieceRow2,_] = Piece,
  playerFromPiece(Piece,Player),
	printPieceRow2(PieceRow2,Player),
	printPiecesRow2(Rest).


printPiecesRow3FirstPiece(BoardRow) :-

	[Piece | Rest] = BoardRow,
	[_,_,PieceRow3] = Piece,
	printFirstPieceRow(PieceRow3),
	printPiecesRow3(Rest).


printPiecesRow3([]).

printPiecesRow3(BoardRow) :-

	[Piece | Rest] = BoardRow,
	[_,_,PieceRow3] = Piece,
	printPieceRow(PieceRow3),
	printPiecesRow3(Rest).
