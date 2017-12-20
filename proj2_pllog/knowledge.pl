:- dynamic skills/1.
:- dynamic participants/1.
:- dynamic participantSkills/1.
:- dynamic activitiesSkills/1.
:- dynamic activitiesSkills/1.
:- dynamic participantPhysicalAtt/1.
:- dynamic activities/1.
:- dynamic activityRequirements/1.


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

    1-{2,7},
    2-{2,7},
    3-{6},
    4-{6},
    5-{1,5},
    6-{1,3},
    7-{8},
    8-{8},
    9-{3},
    10-{3},
    11-{3},
    12-{3,8}
]).

activitiesSkills([

    [0, 1, 0, 0, 0, 0, 1, 0], %football
    [0, 0, 0, 0, 0, 1, 0, 0], %cards
    [0, 0, 0, 0, 0, 0, 0, 0], %walk
    [0, 0, 0, 0, 0, 0, 0, 0], %fireworks
    [0, 0, 1, 0, 0, 0, 0, 0], %build app
    [0, 0, 0, 0, 0, 0, 0, 0], %meal
    [0, 0, 0, 0, 0, 0, 1, 1] %reading
]).


participantPhysicalAtt([

    [20,170,2], %1
    [12,179,2], %2
    [21,175,2], %3
    [14,167,2], %4
    [20,161,2], %5
    [13,151,1], %6
    [18,167,1], %7
    [9,160,1],  %8
    [11,165,1], %9
    [20,160,2], %10
    [25,167,2], %11
    [25,170,1] %12


]).


%activity(id, name, required skill, sex, min height, max heihgt, min age, max age (at least one element), number of elements
activities([
    [1,'football'],
    [2,'cards'],
    [3,'walk'],
    [4,'fireworks'],
    [5,'build app'],
    [6,'meal'],
    [7,'reading']
    ]).


activityRequirements([

    [1,175,300,25,30,6],
    [1,0,300,16,27,6],
    [1,0,300,10,25,6],
    [0,150,300,20,25,5],
    [0,0,300,18,25,5],
    [0,0,300,0,50,5],
    [0,0,300,0,50,5]

]).

