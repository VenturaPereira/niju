%reconsult('/Users/joaofurriel/Documents/Estudo/MIEIC/Ano3/PLOG/Projecto/testes.pl').

:-include('interface.pl').

testPrintIsolatedPiece(PieceNumber) :-

  piece(PieceNumber,Piece),
  printIsolatedPiece(Piece,player1).

testInsertRowBeggining(NewTable) :-

  M = [
        [1,1,1],
        [1,1,1]
      ],

  insertRowBeggining(M,NewTable,1).

testInsertColumnBeggining(NewTable) :-

  M = [
        [1,1,1],
        [1,1,1]
      ],

  insertColumnBeggining(M,NewTable,1).


testInsertBoardRowBegginingIB :-

  initialBoard(IB),
  insertBoardRowBeggining(IB,NIB),
  printFullBoard(NIB).

testInsertBoardRowBegginingB1 :-

  board1(B1),
  insertBoardRowBeggining(B1,NIB),
  printFullBoard(NIB).

testInsertBoardRowBegginingB2 :-

  board2(B2),
  insertBoardRowBeggining(B2,NIB),
  printFullBoard(NIB).

testInsertBoardRowEndB2 :-

  board2(B2),
  insertBoardRowEnd(B2,NIB),
  printFullBoard(NIB).

testInsertBoardColumnBegginingB2 :-

  board2(B2),
  insertBoardColumnBeggining(B2,NIB),
  printFullBoard(NIB).

testInsertBoardColumnEndB2 :-

  board2(B2),
  insertBoardColumnEnd(B2,NIB),
  printFullBoard(NIB).

printInitialBoard :-

  initialBoard(X),
  printFullBoard(X).

printBoard1 :-

  board1(X),
  printFullBoard(X).

printBoard2 :-

  board2(X),
  printFullBoard(X).

board1(

	[
		%row1

		[

		 [[0, 1, 1],
		  [0, 0, 1],
		  [0, 0, 1]
		 ],

		 [[0, 1, 1],
		  [0, 1, 0],
		  [1, 0, 1]
		 ]

		],

		%row2

		[

		 [[-1, -1, -1],
		  [-1, -1, -1],
		  [-1, -1, -1]
		 ],

		 [[1, 0, 1],
		  [0, 0, 0],
		  [1, 0, 1]
		 ]

		]

	]

).

board2(

	[

		%row1

		[

		 [[1, 0, 0],
		  [1, 1, 0],
		  [1, 0, 1]
		 ],

		 [[1, 0, 0],
		  [0, 1, 1],
		  [0, 1, 1]
		 ],

		 [[0, 1, 0],
		  [0, 1, 0],
		  [1, 1, 1]
		 ],

		 [[1, 0, 0],
		  [1, 0, 0],
		  [1, 0, 1]
		 ]

		],


		%row2

		[

		 [[-1, -1, -1],
		  [-1, -1, -1],
		  [-1, -1, -1]
		 ],

		 [[1, 1, 1],
		  [0, 1, 1],
		  [0, 0, 0]
		 ],

		 [[0, 0, 1],
		  [1, 1, 1],
		  [1, 0, 0]
		 ],

		 [[0, 0, 1],
		  [1, 0, 1],
		  [1, 0, 0]
		 ]

		],

		%row3

		[

		 [[1, 0, 0],
		  [0, 0, 1],
		  [1, 1, 0]
		 ],

		 [[1, 1, 1],
		  [0, 0, 1],
		  [0, 0, 0]
		 ],

		 [[0, 0, 1],
		  [1, 1, 1],
		  [1, 0, 0]
		 ],

		 [[0, 0, 1],
		  [1, 0, 1],
		  [1, 0, 0]
		 ]

		]

	]

).


testPrintPlayerPieces :-

  buildPiecesP1(PiecesP1),
  printPlayerPieces(PiecesP1,player1),

  buildPiecesP2(PiecesP2),
  printPlayerPieces(PiecesP2,player2).

testRotatePiece(Direction,Times) :-
  piece(1,Piece1),
  rotatePiece(Piece1, Piece2,Direction,Times),
  write(Piece2).

testUpdateBoardRows(Row) :-

  board2(Board2),
  updateBoardRows(Board2, UpdatedBoard,Row),
  printFullBoard(UpdatedBoard).

testUpdateBoardColumns(Column) :-

  board2(Board2),
  updateBoardColumns(Board2, UpdatedBoard,Column),
  printFullBoard(UpdatedBoard).

testGrowBoard(Row, Column) :-

  board2(Board2),
  growBoard(Board2, NewBoard, Row, Column),
  printFullBoard(NewBoard).

testPlayFirstPiece :-

  buildPiecesP1(Pieces),
  nth0(3,Pieces,Piece),
  initialBoard(InitialBoard),
  playFirstPiece(InitialBoard, CurrentBoard, Piece),
  printFullBoard(CurrentBoard).

testInterface(X,Y) :-
   write('What direction?'),
   read(X),
   nl,
   write('Number of times to rotate.'),
   read(Y),
   write(X),
   write(Y).


testInterfaceFunctionRotateUser:-

  buildPiecesP1(Pieces),
  printPlayerPieces(Pieces,player1),
  nth0(4,Pieces,Piece),
  rotatedPieceOfUser(Piece, PieceRotated),
  replaceInPosition(Pieces,NewPieces,4,PieceRotated),
  printPlayerPieces(NewPieces,player1).

testInterfaceOptions :-
  decisionRotateUser.

testPlayPiece(Row,Column) :-

  initialBoard(IB),
  buildPiecesP1(Pieces),

  printFullBoard(IB),
  printPlayerPieces(Pieces,player1),

  playFirstPiece(IB, NewBoard, Pieces, 5, NewPieces),

  printFullBoard(NewBoard),
  printPlayerPieces(NewPieces,player1),


  playPiece(NewBoard, NextBoard, Row,Column,10,NewPieces, NewPieces2),


  printFullBoard(NextBoard),
  printPlayerPieces(NewPieces2, player1).


testGetPieceFromBoard(Row,Column) :-

  board2(Board2),
  printFullBoard(Board2),
  getPieceFromBoard(Board2, Row, Column, Piece),
  printIsolatedPiece(Piece,empty).


testRetrievePattern(PieceNumber) :-

  buildPiecesP1(Pieces),
  nth0(PieceNumber,Pieces,Piece),

  retrievePiecePattern(Piece, 1,1, Pattern),

  write('Pattern: '),
  write(Pattern).

testCalculateP1ScoreInPiece(Row,Column) :-

  board2(Board),
  printFullBoard(Board),
  calculatePlayer1ScoreInPiece(Board,Row,Column,Score),
  write('Score in chosen Piece: '),nl, write(Score).


testCalculateScoreInRow(RowNumber,Player) :-

  board2(Board),
  printFullBoard(Board),

  calculateScoreInRow(Board,RowScore, RowNumber,Player),
  write('Row '), write(RowNumber), write(' score: '), write(RowScore),nl.


testCalcGS(Player) :-

  board2(Board),
  printFullBoard(Board),

  calculateGlobalScore(Board, GlobalScore,Player),
  write('Player Global Score: '), write(GlobalScore),nl.



testPrintMenu :-
  beginGame.


%reconsult('/Users/joaofurriel/Documents/Estudo/MIEIC/Ano3/PLOG/Projecto/testes.pl').
