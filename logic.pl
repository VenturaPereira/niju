board([empty,empty,empty]).

piece1W(

	[

		[1,1,1],
		[0,0,1],
		[0,0,0]

	]

).


getNElementOfList([H | _], 0, H).

getNElementOfList(List,N,H) :-

	N > 0,
	N1 is N - 1,
	[_ | Rest] = List,
	getNElementOfList(Rest, N1, H).


getPieceOfBoard(Board, RowNumber, ColumnNumber, Piece) :-

	getNElementOfList(Board, RowNumber, Row),
	getNElementOfList(Row, ColumnNumber, Piece).



playPieceRight(CurrentBoard, Piece, Row, Column, ResultingBoard).
playPieceDown(CurrentBoard, Piece, Row, Column, ResultingBoard).
playPieceLeft(CurrentBoard, Piece, Row, Column, ResultingBoard).
playPieceUp(CurrentBoard, Piece, Row, Column, ResultingBoard).



%"reconsult('/Users/joaofurriel/Documents/Estudo/MIEIC/Ano3/PLOG/Projecto/logic.pl')."


/*
getPieceOfBoard(

	[
		%row1

		[

		 [[0, 1, 1],
		  [0, 0, 1],
		  [0, 0, 1]
		 ],

		 [[0, 2, 2],
		  [0, 0, 0],
		  [2, 0, 2]
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
		
	], 0, 1, X

	).

*/