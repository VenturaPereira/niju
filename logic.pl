:-include('print.pl').

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


playFirstPiece(InitialBoard, CurrentBoard, Piece) :-

  replaceMatrixElement(InitialBoard, CurrentBoard, 1, 1, Piece).














%
