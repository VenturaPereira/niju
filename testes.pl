%reconsult('/Users/joaofurriel/Documents/Estudo/MIEIC/Ano3/PLOG/Projecto/testes.pl').

:-include('logic.pl').
:-include('interface.pl').

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


testPrintPlayer1Pieces :-

  buildPiecesP1(PiecesP1),
  printPlayer1Pieces(PiecesP1).



testRotatePiece :-
  piece(1,Piece1),
  rotatePiece(Piece1, Piece2,r,2),
  write(Piece2).


  testRotatePiece(Direction,Times) :-
    piece(1,Piece1),
    rotatePiece(Piece1, Piece2,Direction,Times),
    write(Piece2).

testInterface(X,Y) :-
   write('What direction?'),
   read(X),
   nl,
   write('Number of times to rotate.'),
   read(Y),
   write(X),
   write(Y).


testInterfaceFunctionRotateUser:-
  piece(1,Piece1),
  rotatedPieceOfUser(Direction, Times, Piece1, PieceRotated),
  write(PieceRotated).





%
