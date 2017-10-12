printElement(X) :- X =:= 1, write(' B ').
printElement(X) :- X =:= 2, write(' W ').
printElement(X) :- X =:= -1, write('   ').
printElement(X) :- X =:= 0, write('   ').

printPieceRowSeparation(BoardRow) :-

	BoardRow = [].

printPieceRowSeparation(BoardRow) :-
	
	BoardRow \= [],
	[_ | Rest] = BoardRow,
	write(' --------- '),
	printPieceRowSeparation(Rest).

printPieceRow([X1,X2,X3]) :- 

	write('|'),
	printElement(X1),
	printElement(X2),
	printElement(X3),
	write('|').

printBoard(Board) :-

	Board = [].

printBoard(Board) :- 

	[Row | Rest] = Board,
	printPieceRowSeparation(Row),
	nl,
	printPiecesRow1(Row),
	nl,
	printPiecesRow2(Row),
	nl,
	printPiecesRow3(Row),
	nl,
	printPieceRowSeparation(Row),
	nl,
	printBoard(Rest).

printPiecesRow1(BoardRow) :-

	BoardRow = [].

printPiecesRow1(BoardRow) :-

	[Piece | Rest] = BoardRow,
	[PieceRow1 | _] = Piece,
	printPieceRow(PieceRow1),
	printPiecesRow1(Rest).

printPiecesRow2(BoardRow) :-

	BoardRow = [].

printPiecesRow2(BoardRow) :-

	[Piece | Rest] = BoardRow,
	[_,PieceRow2,_] = Piece,
	printPieceRow(PieceRow2),
	printPiecesRow2(Rest).

printPiecesRow3(BoardRow) :-

	BoardRow = [].

printPiecesRow3(BoardRow) :-

	[Piece | Rest] = BoardRow,
	[_,_,PieceRow3] = Piece,
	printPieceRow(PieceRow3),
	printPiecesRow3(Rest).




%"reconsult('/Users/joaofurriel/Documents/Estudo/MIEIC/Ano3/PLOG/Projecto/print.pl')."

%printBoard([[1,0,0],[0,0,1],[0,0,1]]).

%printPiecesRow3([[[1,0,0],[0,0,1],[0,0,1]], [[1,0,0],[0,0,1],[0,0,1]]]).

