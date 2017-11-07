:- include('logic.pl').
:- include('pieces.pl').
:- include('utils.pl').

:- use_module(library(clpfd)).
:- use_module(library(lists)).







rotatedPieceOfUser(Direction, Times, Piece, PieceRotated) :-
  write('In which direction do you wish to rotate?'),
  read(Direction),
  write('How many times?'),
  read(Times),
  rotatePiece(Piece,PieceRotated,Direction,Times).
