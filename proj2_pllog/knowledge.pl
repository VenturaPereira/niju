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
        [1,'João', [1], 20, 171, 2],
        [2,'Pedro', [2,5], 12, 179, 2],
        [3,'Ventura', [3,6], 21, 172,2],
        [4,'Luis', [4], 14, 167,2],
        [5,'Vasco', [5], 20, 161,2],
        [6,'Maria', [7,8], 13, 151,1],
        [7,'Joana', [6], 15, 167,1],
        [8,'Manuela', [], 9, 160,1],
        [9,'Elisabete', [1], 11, 165,1]
    ]).

%activity(id, name, requeried skill, sex, min height, max heihgt, min age, max age (at least one element), number of elements
activities([
    [1,'football',[2,5],2,0,300,15,25,6],
    [2,'cards',[6],1,0,300,16,27,4],
    [3,'walk',[],1,0,300,10,25,2],
    [4,'fireworks',[],0,150,300,20,25,2],
    [5,'build app',[3],0,0,300,18,25,2],
    [6,'meal',[],0,0,300,0,50,5],
    [7,'reading',[7,8],0,0,300,0,50,3]
    ]).


group('football', ['João', 'Pedro', 'Ventura', 'Luis', 'Manuela', 'Maria']).