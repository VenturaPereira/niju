:- use_module(library(lists)).
:- use_module(library(clpfd)).
:- use_module(library(sets)).

:- include('knowledge.pl').


%activities

get_activity(Id,Activity) :-

    get_activities(Activities),
    nth1(Id,Activities,Activity).

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

get_participant(Id,Participant) :-

    get_participants(Participants),
    nth1(Id,Participants,Participant).

get_participant_atts(Id,ParticipantAtts) :-

    participantPhysicalAtt(ParticipantsAtts),
    nth1(Id,ParticipantsAtts,ParticipantAtts).

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

getParticipantSexs(PartSexs) :-

    participantPhysicalAtt(PhysicalAtts),
    getParticipantSexs(PhysicalAtts, [], PartSexs).

getParticipantSexs([], PartSexs, PartSexs).

getParticipantSexs([[_,_,Sex]|Rest], Aux, PartSexs) :-

    append(Aux, [Sex], Aux2),
    getParticipantSexs(Rest, Aux2, PartSexs).

getParticipantHeights(PartHeights) :-

    participantPhysicalAtt(PhysicalAtts),
    getParticipantHeights(PhysicalAtts, [], PartHeights).

getParticipantHeights([], PartHeights, PartHeights).

getParticipantHeights([[_,Height,_]|Rest], Aux, PartHeights) :-

    append(Aux, [Height], Aux2),
    getParticipantHeights(Rest, Aux2, PartHeights).


getParticipantAges(PartAges) :-

    participantPhysicalAtt(PhysicalAtts),
    getParticipantAges(PhysicalAtts, [], PartAges).

getParticipantAges([], PartAges, PartAges).

getParticipantAges([[Age,_,_]|Rest], Aux, PartAges) :-

    append(Aux, [Age], Aux2),
    getParticipantAges(Rest, Aux2, PartAges).


getParticipantsIds(PartIds) :-

    get_participants(Participants),
    getParticipantsIds(Participants, [], PartIds).

getParticipantsIds([],PartIds, PartIds).

getParticipantsIds([Participant|Rest], Aux, PartIds) :-

    Participant = [Id,_],
    append(Aux, [Id], Aux2),
    getParticipantsIds(Rest, Aux2, PartIds).


pair(X,Y, List) :-

    member(X,List),
    member(Y,List),
    X < Y.

buildParticipantsPairs(PartPairs) :-

    getParticipantsIds(PartIds),
    findall([P1,P2], pair(P1,P2,PartIds), PartPairs).

%skills

get_skills(Skills) :-

    skills(Skills).

get_skills_size(Size) :-

    get_skills(Skills),
    length(Skills,Size).


get_skill(Id,Skill) :-

    get_skills(Skills),
    nth1(Id,Skills,Skill).



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





%interface

print_sex(1) :- write('F').
print_sex(2) :- write('M').

print_Spaces(0).

print_Spaces(Number) :-

    Number > 0,

    write(' '),
    N is Number - 1,
    print_Spaces(N).

get_number_length(Number, 1) :-

    Number < 10.

get_number_length(Number, 2) :-

    Number < 100,
    Number >= 10.

get_number_length(Number, 3) :-

    Number >= 100.


printParticipantsHeader :-

    nl,write('Participants:'),nl,nl,
    write('Name               '), write('Sex '), write('Age '), write('Height '), write('Skills'),nl,
    write('------------------'), write(' ---'),write(' ---'), write(' ------'),write(' ------') ,nl.


printParticipants :-

    get_participants(Participants),
    printParticipantsHeader,
    printParticipants(Participants),nl.


printParticipants([]).

printParticipants([[Id,_]|PartRest]) :-


    printParticipant(Id),
    printParticipants(PartRest).

printParticipant(Id) :-

    get_participant(Id,Participant),
    
    get_participant_atts(Id,ParticipantAtts),

    [Age,Height,Sex] = ParticipantAtts,
    [_,Name] = Participant,

    
    get_participant_skills(Id,_-{ParticipantSkills}),

    atom_length(Name,NameLength),
    get_number_length(Age,AgeLength),
    get_number_length(Height,HeightLength),

    Spaces_Name_Age is 19 - NameLength,
    Spaces_Age_Height is 4 - AgeLength,
    Spaces_Height_Skills is 7 - HeightLength,

    write(Name),print_Spaces(Spaces_Name_Age),print_sex(Sex),print_Spaces(3),write(Age), print_Spaces(Spaces_Age_Height), write(Height), print_Spaces(Spaces_Height_Skills), write(ParticipantSkills), nl.

printActivitiesHeader :-

    nl,write('Activity:'),nl,nl,
    write('Name               '), write('Min Height '), write('Max Height '), write('Min Age '), write('Max Age '),write('Elements'),write(' Sex (Of at least 1 Element)'),write(' Required Skills (At Least 1 Element)'),nl,
    write('------------------'), write(' ----------'),write(' ----------'), write(' -------'),write(' -------'), write(' --------'),write(' ---------------------------'),write(' ------------------------------------'), nl.


printActivities :-

    get_activities(Activities),
    printActivitiesHeader,
    printActivities(Activities),nl.

    % write(Activities).


printActivities([]).

printActivities([[Id,_]|Rest]) :-

    printActivity(Id),
    printActivities(Rest).


printActivity(Id) :-

    get_activity(Id,[_,Name]),
    get_activity_reqs(Id,ActivityReqs),
    
    [Sex, MinHeight, MaxHeight, MinAge, MaxAge, Number_Elements] = ActivityReqs,
    
    atom_length(Name,NameLength),
    Spaces_Name is 19 - NameLength,

    get_number_length(MinHeight,MinHeightLength),
    SpacesMinHL is 11 - MinHeightLength,

    get_number_length(MaxHeight,MaxHeightLength),
    SpacesMaxHL is 11 - MaxHeightLength,

    get_number_length(MinAge,MinAgeLength),
    SpacesMinAge is 8 - MinAgeLength,

    get_number_length(MaxAge,MaxAgeLength),
    SpacesMaxAge is 8 - MaxAgeLength,

    get_number_length(Number_Elements,Number_Elements_Length),
    SpacesNumberElements is 9 - Number_Elements_Length,

    write(Name),            print_Spaces(Spaces_Name), 
    write(MinHeight),       print_Spaces(SpacesMinHL),
    write(MaxHeight),       print_Spaces(SpacesMaxHL),
    write(MinAge),          print_Spaces(SpacesMinAge),
    write(MaxAge),          print_Spaces(SpacesMaxAge),
    write(Number_Elements), print_Spaces(SpacesNumberElements),
    print_sex(Sex),         print_Spaces(27),


    get_activity_skills(Id,Skills),
    
    start_print_skills(Skills),

    nl.


start_print_skills([]) :-

    write('None').

start_print_skills(Skills) :-

    length(Skills,Length),
    Length > 0,
    print_skills(Skills).

print_skills([]).

print_skills([Skill|Rest]) :-

    get_skill(Skill,[_,Skill_Name]),

    write('|'),write(Skill), write(' - '), write(Skill_Name), write(' '),
    print_skills(Rest).



%solution

print_solution([],_).

print_solution(Solution,Id) :-

    Solution = [ActivityGroups|Rest],
 
    printActivitiesHeader,

    printActivity(Id),

    print_solution_groups(ActivityGroups,1),

    NextId is Id + 1,
    print_solution(Rest,NextId).


print_solution_groups([],_).

print_solution_groups(Groups, Id) :-

    Groups = [Group|Rest],
    nl,
    write('Grup '), write(Id), write(':'),nl,
    printParticipantsHeader,

    print_solution_group(Group),

    Next_Group is Id + 1,

    print_solution_groups(Rest,Next_Group).



print_solution_group([]).

print_solution_group([PersonId|Rest]) :-

    printParticipant(PersonId),
    print_solution_group(Rest).










p :- printParticipants, printActivities.






%reconsult('/Users/joaofurriel/Documents/Estudo/MIEIC/Ano3/PLOG/Projecto/proj2_pllog/main.pl').