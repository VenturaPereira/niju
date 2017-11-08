:-include('pieces.pl').

initialBoard(InitialBoard) :-

  emptySpace(EmptySpace),

	InitialBoard = [

    [EmptySpace,EmptySpace,EmptySpace],
    [EmptySpace,EmptySpace,EmptySpace],
    [EmptySpace,EmptySpace,EmptySpace]

	].

insertBoardRowBeggining(Board,NewBoard) :-

  emptySpace(EmptySpace),
  insertRowBeggining(Board,NewBoard,EmptySpace).

insertBoardRowEnd(Board,NewBoard) :-

  emptySpace(EmptySpace),
  insertRowEnd(Board,NewBoard,EmptySpace).

insertBoardColumnBeggining(Board,NewBoard) :-

  emptySpace(EmptySpace),
  insertColumnBeggining(Board,NewBoard,EmptySpace).

insertBoardColumnEnd(Board,NewBoard) :-

  emptySpace(EmptySpace),
  insertColumnEnd(Board,NewBoard,EmptySpace).

updateBoardRows(CurrentBoard, GrownBoard, 0) :-

  insertBoardRowBeggining(CurrentBoard, GrownBoard).

updateBoardRows(CurrentBoard, CurrentBoard, Row) :-

  length(CurrentBoard, NumberOfRows),
  LastRow is NumberOfRows - 1,
  Row =\= LastRow.

updateBoardRows(CurrentBoard, GrownBoard, Row) :-

  NumberOfRows is Row + 1,
  length(CurrentBoard, NumberOfRows),
  insertBoardRowEnd(CurrentBoard, GrownBoard).

updateBoardColumns(CurrentBoard, GrownBoard, 0) :-

  insertBoardColumnBeggining(CurrentBoard, GrownBoard).

updateBoardColumns(CurrentBoard, CurrentBoard, Column) :-

  [FirstRow|_] = CurrentBoard,
  length(FirstRow, NumberOfColumns),
  LastColumn is NumberOfColumns - 1,
  Column =\= LastColumn.

updateBoardColumns(CurrentBoard, GrownBoard, Column) :-

  [FirstRow|_] = CurrentBoard,
  NumberOfColumns is Column+1,
  length(FirstRow,NumberOfColumns),
  insertBoardColumnEnd(CurrentBoard, GrownBoard).

growBoard(CurrentBoard, GrownBoard, Row, Column) :-

  updateBoardRows(CurrentBoard, GrownBoardRows, Row),
  updateBoardColumns(GrownBoardRows, GrownBoard, Column).


getPieceFromBoard(Board, Row, Column, Piece) :-

  getMatrixElement(Board, Piece, Row, Column).

getPieceFromBoard(Board, Row, Column, EmptySpace) :-

  \+ getMatrixElement(Board, EmptySpace, Row, Column),
  emptySpace(EmptySpace).


playFirstPiece(InitialBoard, CurrentBoard, Pieces, PieceNumber, NewPieces) :-

  nth0(PieceNumber,Pieces,Piece),
  replaceMatrixElement(InitialBoard, CurrentBoard, 1, 1, Piece),
  remove(Piece,Pieces,NewPieces).


playPiece(Board, NewBoard, Row, Column, PieceNumber, Pieces, NewPieces) :-

  %validPlay%BoardRowColumn
  %nlwritevalidplaynl
  nth0(PieceNumber,Pieces,Piece),
  replaceMatrixElement(Board, BoardWithPiece, Row, Column, Piece),
  growBoard(BoardWithPiece, NewBoard, Row, Column),
  remove(Piece,Pieces,NewPieces).

playPiece(Board,Board, Row, Column, _, Pieces, Pieces) :-

  \+ validPlay(Board,Row,Column),
  nl, write('invalid play'), nl.

validPlay(Board, Row, Column) :-

  getMatrixElement(Board, Element, Row, Column),
  emptySpace(EmptySpace),
  EmptySpace == Element,

  UpRow is Row - 1,
  DownRow is Row + 1,
  RightColumn is Column + 1,
  LeftColumn is Column - 1,

  getPieceFromBoard(Board, UpRow, Column, ElementUp),
  getPieceFromBoard(Board, DownRow, Column, ElementDown),
  getPieceFromBoard(Board, Row, RightColumn, ElementRight),
  getPieceFromBoard(Board, Row, LeftColumn, ElementLeft),

  (ElementUp \= EmptySpace ; ElementDown \= EmptySpace ; ElementLeft \= EmptySpace ; ElementRight \= EmptySpace).

retrievePiecePattern(Piece, _, _, _, []) :-

  [[-1|_]|_] = Piece.

retrievePiecePattern(Piece, Row, Column, Player, Pattern) :-

  playerFromPiece(Piece, Player),

  replaceMatrixElement(Piece, NeutralPiece, 1, 1, 0),

  [R1,R2,R3] = NeutralPiece,

  LeftColumn is Column - 1,
  RowNorth is Row - 1,
  RowSouth is Row + 1,

  parsePieceRow(R1,R1Pattern, [], RowNorth, LeftColumn),
  parsePieceRow(R2,R2Pattern, [], Row, LeftColumn),
  parsePieceRow(R3,R3Pattern, [], RowSouth, LeftColumn),
  append(R1Pattern, R2Pattern, RAux),
  append(RAux, R3Pattern, Pattern).


parsePieceRow([],List, List,_,_).

parsePieceRow(Row, List, ListAux, RowNumber, ColumNumber) :-

  [1| Rest] = Row,
  append(ListAux,[RowNumber,ColumNumber], ListAux2),

  NewColumnNumber is ColumNumber + 1,
  parsePieceRow(Rest,List,ListAux2,RowNumber,NewColumnNumber).

parsePieceRow(Row,List, ListAux, RowNumber,ColumNumber) :-

  [0| Rest] = Row,
  NewColumnNumber is ColumNumber + 1,
  parsePieceRow(Rest,List, ListAux,RowNumber, NewColumnNumber).













%
