:- use_module(library(lists)).
:- use_module(library(clpfd)).
:- use_module(library(sets)).

:- include('knowledge.pl').

%reconsult('/Users/joaofurriel/Documents/Estudo/MIEIC/Ano3/PLOG/Projecto/proj2_pllog/solver.pl').

% createActivityGroups(ActivityId, ListOfGroups) :-

%     participants(Participants),
%     length(Participants, NumberOfParticipants),

%     activityRequirements(ActivitiesRequirements),
%     nth1(ActivityId, ActivitiesRequirements, ActivityRequirement),
%     nth1(6, ActivityRequirement, NumberOfElements),

%     NumberOfGroups is div(NumberOfParticipants,NumberOfElements),

%     length(ListOfGroups, NumberOfGroups),

%     append(ListOfGroups, AllParticipants),

%     all_distinct(AllParticipants),

%     createAllGroups(ActivityId, NumberOfGroups, ListOfGroups),

%     write('antes labeling'),

%     labeling([], AllParticipants).


% createAllGroups(ActivityId, NumberOfGroups, AllGroups) :-

%     createAllGroups(ActivityId, NumberOfGroups, AllGroups, []),!.

% createAllGroups(_, 0, AllGroups, AllGroups).

% createAllGroups(ActivityId, NumberOfGroups, AllGroups, AllGroupsAux) :-

%     createGroup(ActivityId, Group),
%     append(AllGroupsAux, [Group], AllGroupsAux2),
%     NumberOfGroupsAux is NumberOfGroups - 1,
%     createAllGroups(ActivityId, NumberOfGroupsAux, AllGroups, AllGroupsAux2).


createGroup(ActivityId, Group) :-

    %activity name
    activities(Activities),
    nth1(ActivityId, Activities, Activity),
    Activity = [_,ActivityName],

    write(ActivityName),
    nl,

    %total of participantes
    participants(Participants),
    % length(Participants, NumberOfParticipants),

    %activity requirement
    activityRequirements(ActivitiesRequirements),
    nth1(ActivityId,ActivitiesRequirements,ActivityRequirements),

    %activity number of elements
    nth1(6, ActivityRequirements, GroupLength),

    length(Group, GroupLength),
    % domain(Group, 1, NumberOfParticipants),
    % all_distinct(Group),

    getAllRequiredParticipants(ActivityId, RequiredParticipants),
    subset_constrain(RequiredParticipants, Group),

    labeling([],Group).


subset_constrain([],_).

subset_constrain([HR|TR],[HG|TG]) :-

    HG #= HR,
    subset_constrain(TR,TG).

getAllRequiredParticipants(ActivityIndex, Participants) :-

    getParticipant(ActivityIndex, PhysicalReqParticipant),

    getMinimumParticipantsSkils(ActivityIndex, SkillsParticipants),
    
    append([PhysicalReqParticipant], SkillsParticipants, Participants),
    all_distinct(Participants),
    % sort(ParticipantsReq, Participants),

    length(Participants, Length).

    % labeling([],Participants).


constraintParticipant(ActivityIndex, Participant) :-

    activityRequirements(ActivitiesRequirements),
    nth1(ActivityIndex, ActivitiesRequirements, [ReqSex, MinHeight, MaxHeight, MinAge, MaxAge, _]),

    participants(Participants),
    length(Participants,NumberOfParticipants),
    Participant in 1 .. NumberOfParticipants,

    constraintParticipantBySex(ReqSex, Participant),
    constraintParticipantByPhysicalAtts(MinHeight, MaxHeight, MinAge, MaxAge, Participant).

    % labeling([], [Participant]).


constraintParticipantBySex(ReqSex,ParticipantIndex) :-

    getParticipantAttSep(Sexs,_,_),
    element(ParticipantIndex, Sexs, ReqSex).

constraintParticipantBySex(0,ParticipantIndex).


constraintParticipantByPhysicalAtts(MinHeight, MaxHeight, MinAge, MaxAge, ParticipantIndex) :-

    getParticipantAttSep(_,Heights,Ages),

    element(ParticipantIndex, Heights, Height),
    Height #>= MinHeight,
    Height #=< MaxHeight,

    element(ParticipantIndex, Ages, Age),
    Age #>= MinAge,
    Age #=< MaxAge.


%reconsult('/Users/joaofurriel/Documents/Estudo/MIEIC/Ano3/PLOG/Projecto/proj2_pllog/solver.pl').
    
t(A,P) :- getParticipant(A,P).


getMinimumParticipantsSkils(ActivityIndex, Participants) :-

    activitiesSkills(ActivitiesSkills),
    nth1(ActivityIndex, ActivitiesSkills, ActivitySkills),

    length(ActivitySkills, Length),
    
    length(Participants, Length),

    participants(ListOfParticipants),
    length(ListOfParticipants, NumberOfParticipants),

    domain(Participants, 1, NumberOfParticipants),
    all_distinct(Participants),

    checkAllParticipantsSkills(ActivitySkills, Participants).

    % labeling([],Participants).


checkAllParticipantsSkills(Skills, ParticipantsIndexs) :-

    getFlatListSkilsFromParticipants(ParticipantsIndexs, FlatList),
    subset(Skills, FlatList).

getFlatListSkilsFromParticipants(ParticipantsIndexs, FlatList) :-
    getFlatListSkilsFromParticipants(ParticipantsIndexs, [], FlatListRep),
    sort(FlatListRep, FlatList).



getFlatListSkilsFromParticipants([ParticipantIndex|Rest], FlatListAux, FlatList) :-

    participantSkills(AllPartSkills),
    nth1(ParticipantIndex, AllPartSkills, ParticipantSkills),
    append(FlatListAux, ParticipantSkills, FlatListAux2),
    getFlatListSkilsFromParticipants(Rest, FlatListAux2, FlatList).


getFlatListSkilsFromParticipants([], FlatList, FlatList).



%reconsult('/Users/joaofurriel/Documents/Estudo/MIEIC/Ano3/PLOG/Projecto/proj2_pllog/solver.pl').



%Aux Predicates

getParticipantAttSep(PartSexs, PartHeights, PartAges) :-

    participantPhysicalAtt(PhysicalAtts),
    getParticipantSexs(PhysicalAtts, [], PartSexs),
    getParticipantHeights(PhysicalAtts, [], PartHeights),
    getParticipantAges(PhysicalAtts, [], PartAges).



getParticipantSexs([], PartSexs, PartSexs).

getParticipantSexs([[_,_,Sex]|Rest], Aux, PartSexs) :-

    append(Aux, [Sex], Aux2),
    getParticipantSexs(Rest, Aux2, PartSexs).

getParticipantHeights([], PartHeights, PartHeights).

getParticipantHeights([[_,Height,_]|Rest], Aux, PartHeights) :-

    append(Aux, [Height], Aux2),
    getParticipantHeights(Rest, Aux2, PartHeights).

getParticipantAges([], PartAges, PartAges).

getParticipantAges([[Age,_,_]|Rest], Aux, PartAges) :-

    append(Aux, [Age], Aux2),
    getParticipantAges(Rest, Aux2, PartAges).