:- dynamic activity/4.
:- dynamic skill/2.
:- dynamic participant/6.
:- dynamic group/2.

sex(1,f).
sex(2,m).
sex(0,none).

%skill(id, name)
skills([
        [1,'cook'],
        [2,'play footbal'],
        [3,'program'],
        [4,'sing'],
        [5,'run'],
        [6,'play cards'],
        [7,'read'],
        [8,'write']
    ]).

%participant(id, name, list of skils, age, height, sex)

participants([
        [1,'João'],
        [2,'Pedro'],
        [3,'Ventura'],
        [4,'Luis'],
        [5,'Vasco'],
        [6,'Maria'],
        [7,'Joana'],
        [8,'Manuela'],
        [9,'Elisabete'],
        [10,'Manuel'],
        [11,'Ricardo'],
        [12,'Marta']
    ]).

participantSkills([

    1,2,
    2,0,
    2,1,
    4,0,
    5,1,
    3,0,
    6,1,
    7,2,
    8,3,
    2,1,
    0,0,
    1,0
]).


participantPhysicalAtt([

    [20,171,2], %1
    [12,179,2], %2
    [21,172,2], %3
    [14,167,2], %4
    [20,161,2], %5
    [13,151,1], %6
    [18,167,1], %7
    [9,160,1],  %8
    [11,165,1], %9
    [20,175,2], %10
    [21,167,2], %11
    [22,170,1] %12


]).


%activity(id, name, required skill, sex, min height, max heihgt, min age, max age (at least one element), number of elements
activities([
    [1,'football']%,
    % [2,'cards'],
    % [3,'walk'],
    % [4,'fireworks'],
    % [5,'build app'],
    % [6,'meal'],
    % [7,'reading']
    ]).


activityRequirements([

    [2,165,300,13,25,6],
    [1,0,300,16,27,4],
    [1,0,300,10,25,2],
    [0,150,300,20,25,2],
    [0,0,300,18,25,2],
    [0,0,300,0,50,5],
    [0,0,300,0,50,3]

]).

activitiesSkills([

    [0, 1, 0, 0, 0, 0, 0, 1], %football
    [0, 0, 0, 0, 0, 1, 1, 1], %cards
    [0, 0, 0, 0, 0, 0, 0, 0], %walk
    [0, 0, 0, 0, 0, 0, 0, 0], %fireworks
    [0, 0, 1, 0, 0, 0, 0, 0], %build app
    [0, 0, 0, 0, 0, 0, 0, 0], %meal
    [0, 0, 0, 0, 0, 0, 1, 1] %reading
]).