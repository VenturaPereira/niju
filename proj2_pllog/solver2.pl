:- use_module(library(lists)).
:- use_module(library(clpfd)).
:- use_module(library(sets)).

:- include('knowledge.pl').

constrainParticipant(ActivityIndex, ParticipantPhy, ParticipantSkill) :-

    activityRequirements(ActivitiesRequirements),
    nth1(ActivityIndex, ActivitiesRequirements, [ReqSex, MinHeight, MaxHeight, MinAge, MaxAge, _,ActivitySkill]),

    participants(Participants),
    length(Participants,NumberOfParticipants),
    ParticipantPhy in 1 .. NumberOfParticipants,
    ParticipantSkill in 1 .. NumberOfParticipants,

    constrainParticipantBySex(ReqSex, ParticipantPhy),
    constrainParticipantByPhysicalAtts(MinHeight, MaxHeight, MinAge, MaxAge, ParticipantPhy),


    constrainParticipantBySkills(ActivitySkill, ParticipantSkill).

    % labeling([], [Participant]).


constrainParticipantBySex(ReqSex,ParticipantIndex) :-

    getParticipantAttSep(Sexs,_,_),
    element(ParticipantIndex, Sexs, ReqSex).

constrainParticipantBySex(0,_).


constrainParticipantByPhysicalAtts(MinHeight, MaxHeight, MinAge, MaxAge, ParticipantIndex) :-

    getParticipantAttSep(_,Heights,Ages),

    element(ParticipantIndex, Heights, Height),
    Height #>= MinHeight,
    Height #=< MaxHeight,

    element(ParticipantIndex, Ages, Age),
    Age #>= MinAge,
    Age #=< MaxAge.


constrainParticipantBySkills(ActivitySkill, ParticipantIndex) :-

    participantSkills(ParticipantsSkills),
    relation(ParticipantIndex, ParticipantsSkills, ActivitySkill).



%test

t(Participant) :-

    constrainParticipantBySkills(2, Participant).

%Aux Predicates




%reconsult('/Users/joaofurriel/Documents/Estudo/MIEIC/Ano3/PLOG/Projecto/proj2_pllog/solver2.pl').