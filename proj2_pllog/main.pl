:- include('aux.pl').

%reconsult('/Users/joaofurriel/Documents/Estudo/MIEIC/Ano3/PLOG/Projecto/proj2_pllog/main.pl').

solver(TimeOut) :-

    %Final List has size: number of activities

    create_global_matrix(Result),
    constrainActivites(Result),
    flat_global_matrix(Result, FlattenResult),

    get_participants_size(Number_Participants),    
    domain(FlattenResult, 1, Number_Participants),


    buildParticipantsPairs(ParticipantsPairs),

    length(ParticipantsPairs, LengthParticipantsPairs),
    length(Ocurrences, LengthParticipantsPairs),

    append(Result, ActivitiesList),
    calculateOcurrences(ParticipantsPairs, Ocurrences, ActivitiesList),


    %TotalOcurrences in 0 .. 10000,
    sumOcurrences(Ocurrences,TotalOcurrences),


    append(FlattenResult,[TotalOcurrences],FinalResult),

    % length(FinalResult,X),

    % write(X),

    MiliSeconds is TimeOut * 1000,

    labeling([down,time_out(MiliSeconds,_),minimize(TotalOcurrences)],FinalResult),

    % labeling([down,minimize(TotalOcurrences)],FinalResult),


    print_solution(Result,1),
    nl,
    write('co-ocorrences factor: '),
    write(TotalOcurrences).


constrainActivites(AllActivities) :-

    length(AllActivities, NumberOfActivities),
    constrainActivites(AllActivities, 0, NumberOfActivities).

constrainActivites(_, NumberOfRows, NumberOfRows).

constrainActivites(GlobalMatrix, NumberOfRow, NumberOfRows) :-

    nth0(NumberOfRow, GlobalMatrix, CurrentRow),
    append(CurrentRow, FlatRow),
    all_distinct(FlatRow),

    ActivityId is NumberOfRow + 1,

    constrainGroups(CurrentRow, ActivityId),


    N_Row is NumberOfRow + 1,
    constrainActivites(GlobalMatrix, N_Row, NumberOfRows).


constrainGroups(Activity, ActivityId) :-

    length(Activity, NumberOfGroups),
    constrainGroups(Activity, 0, NumberOfGroups, ActivityId).

constrainGroups(_, NumberOfGroups, NumberOfGroups, _).

constrainGroups(Activity, NumberOfGroup, NumberOfGroups, ActivityId) :-

    nth0(NumberOfGroup, Activity, CurrentGroup),

    %fazer as restrições de grupo
    % write(CurrentGroup),
    % nl,

    get_activity_skills(ActivityId, ActivitySkills),
    get_activity_reqs(ActivityId, ActivityReqs),

    nth0(0,ActivityReqs,ReqSex),

    nth0(1, ActivityReqs, MinHeight),
    nth0(2, ActivityReqs, MaxHeight),

    nth0(3, ActivityReqs, MinAge),
    nth0(4, ActivityReqs, MaxAge),

    constrainGroupSkills(CurrentGroup, ActivitySkills),
    constrainGroupSexs(CurrentGroup, ReqSex),
    constrainGroupHeights(CurrentGroup, MinHeight, MaxHeight),


    constrainGroupAges(CurrentGroup, MinAge, MaxAge),

    N_Group is NumberOfGroup + 1,
    constrainGroups(Activity, N_Group, NumberOfGroups, ActivityId).


constrainGroupSkills(_, []).

constrainGroupSkills(Group, [ActivitySkill|Rest]) :-
    
    participantSkills(ParticipantSkills),

    element(_,Group,ParticipantIndex),
    relation(ParticipantIndex, ParticipantSkills, ActivitySkill),

    constrainGroupSkills(Group, Rest).

constrainGroupSexs(Group, ReqSex) :-

    ReqSex > 0,
    getParticipantSexs(PartSexs),

    element(_,Group,ParticipantIndex),
    element(ParticipantIndex, PartSexs, ReqSex).

constrainGroupSexs(_, 0).

constrainGroupHeights(Group, MinHeight, MaxHeight) :-

    getParticipantHeights(PartHeights),

    element(_,Group, ParticipantIndex),
    element(ParticipantIndex, PartHeights, Height),

    Height #>= MinHeight,
    Height #=< MaxHeight.

constrainGroupAges(Group, MinAge, MaxAge) :-

    getParticipantAges(PartAges),

    element(_,Group, ParticipantIndex),
    element(ParticipantIndex, PartAges, Age),

    Age #>= MinAge,
    Age #=< MaxAge.



calculateOcurrences([],[],_).

calculateOcurrences([Pair|PairsRest], [Ocurrences|OcurrencesRest], ActivitiesList) :-
    
    calculatePairOcurrences(Pair,ActivitiesList, 0, Ocurrences),
    calculateOcurrences(PairsRest,OcurrencesRest, ActivitiesList).


calculatePairOcurrences(_, [], Ocurrences, Ocurrences).

calculatePairOcurrences(Pair, [Group|Rest], Aux, Ocurrences) :-

    calculateOcurrenceInGroup(Pair,Group,Ocurrence),
    Aux2 #= Aux + Ocurrence,
    calculatePairOcurrences(Pair, Rest, Aux2, Ocurrences).


calculateOcurrenceInGroup([P1,P2], Group, Ocurrence) :-

    count(P1,Group,#=, C1),
    count(P2,Group,#=, C2),
    
    Ocurrence #= C1*C2.


sumOcurrences(OcurrencesList, Total) :-

    sumOcurrences(OcurrencesList, 0, Total).
    

sumOcurrences([],Total,Total).

sumOcurrences([Ocurrences|Rest], Aux, Total) :-

    Power2 #= Ocurrences * Ocurrences,
    Aux2 #= Aux + Power2,
    sumOcurrences(Rest, Aux2, Total).


%reconsult('/Users/joaofurriel/Documents/Estudo/MIEIC/Ano3/PLOG/Projecto/proj2_pllog/main.pl').
