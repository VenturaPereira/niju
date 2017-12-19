:- use_module(library(lists)).
:- use_module(library(clpfd)).

:- include('knowledge.pl').

% createGroup(ActivityId, Group) :-

%     %activity name
%     activities(Activities),
%     nth1(ActivityId, Activities, Activity),
%     Activity = [_,ActivityName],


%     %total of participantes
%     participants(Participants),
%     length(Participants, NumberOfParticipants),

%     %activity requirement
%     activityRequirements(ActivitiesRequirements),
%     nth1(ActivityId,ActivitiesRequirements,ActivityRequirements),

%     %activity number of elements
%     nth1(6, ActivityRequirements, GroupLength),


%     length(Group, GroupLength),
%     domain(Group, 1, NumberOfParticipants),
%     all_distinct(Group),

%     %atividades necessárias

%     % [_,_,MandatorySkills,_,_,_,_,_,_],

%     labeling([],Group).



% 1-[1], 2-[2,5] 3-[3,6] ...


getParticipant(ActivityIndex, Participant) :-

    activityRequirements(ActivitiesRequirements),
    nth1(ActivityIndex, ActivitiesRequirements, [Sex, MinHeight, MaxHeight, MinAge, MaxAge, _]),

    %activitiesSkils(ActivitiesSkills),
    %nth1(ActivityIndex, ActivitiesSkills, ActivitySkills),

    participants(Participants),
    length(Participants,NumberOfParticipants),
    domain([Participant], 1, NumberOfParticipants),

    checkParticipantPhysicalAtts(Sex,MinHeight,MaxHeight,MinAge,MaxAge,Participant),

    labeling([], [Participant]).



checkParticipantPhysicalAtts(ReqSex, MinHeight, MaxHeight, MinAge, MaxAge, ParticipantIndex) :-

    participantPhysicalAtt(ParticipantsPhysicalAtts),
    nth1(ParticipantIndex, ParticipantsPhysicalAtts, ParticipantsPhysicalAtt),

    ParticipantsPhysicalAtt = [Age, Height, Sex],
    Age #=< MaxAge,
    Age #>= MinAge,
    Height #=< MaxHeight,
    Height #>= MinHeight,
    Sex #= ReqSex #\/ ReqSex #= 0.



checkParticipantSkills(Skill, ParticipantIndex) :-

    


%reconsult('/Users/joaofurriel/Documents/Estudo/MIEIC/Ano3/PLOG/Projecto/proj2_pllog/solver.pl').

