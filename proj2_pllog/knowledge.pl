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
        [9,'Elisabete']
    ]).

participantSkills([

    [1],
    [5],
    [3,6],
    [4],
    [5],
    [7,8],
    [6],
    [2],
    [1]
]).


participantPhysicalAtt([

    [20,171,2],
    [12,179,2],
    [21,172,2],
    [14,167,2],
    [20,161,2],
    [13,151,1],
    [15,167,1],
    [9,160,1],
    [11,165,1]


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

activitiesSkils([

    [2,5],
    [6],
    [],
    [],
    [3],
    [],
    [7,8]
]).

activityRequirements([

    [2,0,300,15,25,6],
    [1,0,300,16,27,4],
    [1,0,300,10,25,2],
    [0,150,300,20,25,2],
    [0,0,300,18,25,2],
    [0,0,300,0,50,5],
    [0,0,300,0,50,3]
]).


group('football', ['João', 'Pedro', 'Ventura', 'Luis', 'Manuela', 'Maria']).