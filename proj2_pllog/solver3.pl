:- include('aux.pl').

%reconsult('/Users/joaofurriel/Documents/Estudo/MIEIC/Ano3/PLOG/Projecto/proj2_pllog/solver3.pl').

solver(Result) :-

    %Final List has size: number of activities

    create_global_matrix(Result),

    constrainActivites(Result),


    flat_global_matrix(Result, FlattenResult),
    
    get_participants_size(Number_Participants),
    
    domain(FlattenResult, 1, Number_Participants),

    labeling([],FlattenResult).

  
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
    constrainGroupSkills(CurrentGroup, ActivitySkills),
    constrainGroupSexs(CurrentGroup, ActivityId),

    % write(ActivitySkills),

    N_Group is NumberOfGroup + 1,
    constrainGroups(Activity, N_Group, NumberOfGroups, ActivityId).


constrainGroupSkills(_, []).

constrainGroupSkills(Group, [ActivitySkill|Rest]) :-
    
    participantSkills(ParticipantSkills),

    nth0(SkillIndex, ParticipantSkills, ActivitySkill),

    ParticipantIndex1 is div(SkillIndex,2),
    ParticipantIndex is ParticipantIndex1 + 1,

    element(_,Group,ParticipantIndex),

    constrainGroupSkills(Group, Rest).



constrainGroupSexs(Group, ActivityId) :-

    get_activity_reqs(ActivityId, ActivityReqs),
    nth0(0,ActivityReqs,ReqSex),
    
    participantPhysicalAtt(PhysicalAtts),
    getParticipantSexs(PhysicalAtts, [], PartSexs),

    element(_,Group,ParticipantIndex),
    element(ParticipantIndex, PartSexs, ReqSex).

constrainGroupSexs(_, ActivityId) :-

    get_activity_reqs(ActivityId, ActivityReqs),
    nth0(0,ActivityReqs,0).

%reconsult('/Users/joaofurriel/Documents/Estudo/MIEIC/Ano3/PLOG/Projecto/proj2_pllog/solver3.pl').
