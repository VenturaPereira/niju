:- use_module(library(lists)).
:- use_module(library(clpfd)).


%separates a key-value list into two lists

getKeysAndValues(ValueKeyList,ValueList,KeyList) :-
  keys_and_values(ValueKeyList,ValueList,KeyList).
