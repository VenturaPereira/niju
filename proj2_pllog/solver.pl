:- use_module(library(lists)).
:- use_module(library(clpfd)).

:- include('knowledge.pl').

createGroup(ActivityId, Group) :-

    activities(Activities),
    nth1(ActivityId, Activities, Activity),
    Activity = [_,_,_,_,_,_,_,_,GroupLength],

    participants(Participants),
    length(Participants, NumberOfParticipants),

    
    length(Group, GroupLength),
    domain(Group, 1, NumberOfParticipants),
    all_distinct(Group),

    %atividades necessárias

    [_,_,MandatorySkills,_,_,_,_,_,_],

    labeling([],Group).








%reconsult('/Users/joaofurriel/Documents/Estudo/MIEIC/Ano3/PLOG/Projecto/proj2_pllog/solver.pl').

