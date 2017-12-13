:-include('utils2.pl').
%identificador para lista, do tipo key-value (index-descricao_Atividade)

identifier(1,[1-'breakfast', 2-'play ball', 3-'lunch',4-'study', 5-'play cards']).

%preactivty constructor, indexParaIdentificador, ListaDeGrupos, ListaDeHoras (inicio,fim)
preactivity(1,1,2).
preactivity(2,1,4).
preactivity(3,1,5).
preactivity(4,1,1).
preactivity(5,1,2).
preactivity(6,1,3).



listIdentifier(Ident):-
    identifier(1,List),
    Ident = List.


getSingleValue(List,Index,Value):-
      nth1(Index,List,Value).


getActivityDescription(Index):-
  preactivity(Index,IdentIndex,Description),
  identifier(IdentIndex,List),
  getKeysAndValues(List,_,Values),
  getSingleValue(Values,Description,Value),
  write(Value).

:- dynamic activity/4.
addListOfGroup(Index,List):-
   preactivity(Index,IdentIndex,Description),
   assertz(activity(Index,IdentIndex,Description,List)).

   listItems(Index):-
    activity(Index,IdentIndex,Description,List),
    write(IdentIndex),write(Description),write(List).
