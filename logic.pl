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
