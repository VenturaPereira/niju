:-include('activities.pl').


%tests if the list is an identifier and returns two lists with keys and values

testKVlist(List,Keys,Values) :-
    listIdentifier(List),
    Listaux = List,
    getKeysAndValues(Listaux,Keys,Values).

testSingleValue(Index):-
  getActivityDescription(Index).


testDynamicValues(Index,List):-
  addListOfGroup(Index,List).

  testSave(Index):-
    listItems(Index).
