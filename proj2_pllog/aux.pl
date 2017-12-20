:- use_module(library(lists)).
:- use_module(library(clpfd)).
:- use_module(library(sets)).

:- include('knowledge.pl').


%activities

get_activities(Activities) :-

    activities(Activities).

get_activities_size(Size) :-

    get_activities(Activities),
    length(Activities,Size).

get_activities_reqs(ActivitiesReqs) :-

    activityRequirements(ActivitiesReqs).

get_activity_reqs(Activity_Id, ActivityReqs) :-

    get_activities_reqs(ActivitiesReqs),
    nth1(Activity_Id, ActivitiesReqs, ActivityReqs).

get_activity_number_elements(Activity_Id, Number_Elements) :-

    get_activity_reqs(Activity_Id, ActivityReqs),
    nth1(6,ActivityReqs, Number_Elements).

get_activity_number_groups(Activity_Id, Number_Groups) :-

    get_participants_size(Size),
    get_activity_number_elements(Activity_Id, Number_Elements),
    Number_Groups is div(Size,Number_Elements).

get_activities_skills(ActivitiesSkills) :-

    activitiesSkills(ActivitiesSkills).

get_activity_skills(ActivityId, ActivitySkills) :-

    get_activities_skills(ActivitiesSkills),
    nth1(ActivityId, ActivitiesSkills, ActivitySkillRow),

    get_skills_size(SkillsSize),
    get_activity_skills(ActivitySkillRow, SkillsSize, [], ActivitySkills).



get_activity_skills(_, 0, SkillsIds, SkillsIds).

get_activity_skills(Skill_Row, Column, Aux, SkillsIds) :-

    nth1(Column, Skill_Row, 0),
    N_Col is Column - 1,
    get_activity_skills(Skill_Row, N_Col, Aux, SkillsIds).

get_activity_skills(Skill_Row, Column, Aux, SkillsIds) :-

    nth1(Column, Skill_Row, 1),
    get_skills(Skills),
    nth1(Column, Skills, [SkillId|_]),



    append(Aux,[SkillId], Aux2),
    N_Col is Column - 1,
    get_activity_skills(Skill_Row, N_Col, Aux2, SkillsIds).





%participants

get_participants(Participants) :-

    participants(Participants).

get_participants_size(Size) :-

    get_participants(Participants),
    length(Participants, Size).

get_participant_skills(ParticipantId,Skills) :-

    participantSkills(ParticipantsSkills),
    nth1(ParticipantId, ParticipantsSkills, Skills).

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


%skills

get_skills(Skills) :-

    skills(Skills).

get_skills_size(Size) :-

    get_skills(Skills),
    length(Skills,Size).




%build global matrix

create_global_matrix(Global_Matrix) :-

    get_activities_size(Size),
    length(Global_Matrix, Size),
    create_global_matrix_rows(Global_Matrix, Size).

    % nth1(6,Global_Matrix,Atividade),
    % nth1(1,Atividade, Grupo1),

    % length(Atividade, GruposAtividade),
    % length(Grupo1, ElementosGrupo1),

    % write('Grupos Atividade: '), write(GruposAtividade),nl,
    % write('Elementos Grupo: '), write(ElementosGrupo1).
    

create_global_matrix_rows(_, 0).

create_global_matrix_rows(Global_Matrix, Size) :-

    nth1(Size,Global_Matrix,Row),
    get_activity_number_groups(Size, Number_Groups),
    length(Row,Number_Groups),

    get_activity_number_elements(Size,Number_Elements),
    create_row_fixed_size(Row,Number_Groups, Number_Elements),

    N_Size is Size - 1,
    create_global_matrix_rows(Global_Matrix, N_Size).



create_row_fixed_size(_, 0, _).

create_row_fixed_size(Row, Row_Size, Element_Size) :-

    nth1(Row_Size, Row, Element),
    length(Element,Element_Size),
    N_Elem is Row_Size - 1,
    create_row_fixed_size(Row, N_Elem, Element_Size).


flat_global_matrix(GlobalMatrix, FlattenMatrix) :-

    length(GlobalMatrix, NumberOfRows),
    flat_global_matrix(GlobalMatrix, [], FlattenMatrix, 0, NumberOfRows).


flat_global_matrix(_, FlattenMatrix, FlattenMatrix, NumberOfRows, NumberOfRows).

flat_global_matrix(GlobalMatrix, Aux, FlattenMatrix, Row, NumberOfRows) :-

    nth0(Row, GlobalMatrix, CurrentRow),
    append(CurrentRow, FlatRow),
    append(Aux, FlatRow, Aux2),

    NextRow is Row + 1,
    flat_global_matrix(GlobalMatrix, Aux2, FlattenMatrix, NextRow, NumberOfRows).