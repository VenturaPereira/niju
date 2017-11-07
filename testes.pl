%reconsult('/Users/joaofurriel/Documents/Estudo/MIEIC/Ano3/PLOG/Projecto/testes.pl').

:-include('logic.pl').

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


testRotatePiece :-

  piece(1,Piece1),
  write(Piece1).

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


%reconsult('/Users/joaofurriel/Documents/Estudo/MIEIC/Ano3/PLOG/Projecto/testes.pl').
