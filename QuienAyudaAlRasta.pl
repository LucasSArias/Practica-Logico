estaEnElAula(rasta).
estaEnElAula(polito).
estaEnElAula(santi).

ayuda(Ayudante, Ayudado):-
    quiere(Ayudante, Ayudado),
    not(menosSuerteQue(Ayudante, Ayudado)),
    estaEnElAula(Ayudante).

quiere(rasta, UnaPersona):-
    estaEnElAula(UnaPersona),
    UnaPersona \= polito.

quiere(santi, UnaPersona):-
    estaEnElAula(UnaPersona),
    not(quiere(rasta,UnaPersona)).

quiere(polito, UnaPersona):-
    quiere(rasta, UnaPersona).

menosSuerteQue(rasta, UnaPersona):-
    estaEnElAula(UnaPersona),
    not(quiere(polito,UnaPersona)).

/*
PUNTO 1

1 ?- ayuda(UnAyudante, rasta).
UnAyudante = rasta ;
UnAyudante = polito.

PUNTO 2

2 ?- quiere(UnaPersona,milhouse).
false.

3 ?- quiere(santi,UnaPersona). 
UnaPersona = polito ;
false.

4 ?- quiere(rasta,UnaPersona).
UnaPersona = rasta ;
UnaPersona = santi.

5 ?- quiere(UnaPersona, OtraPersona).
UnaPersona = OtraPersona, OtraPersona = rasta ;
UnaPersona = rasta,
OtraPersona = santi ;
UnaPersona = santi,
OtraPersona = polito ;
UnaPersona = polito,
OtraPersona = rasta ;
UnaPersona = polito,
OtraPersona = santi.

6 ?- quiere(polito, Alguien).
Alguien = rasta ;
Alguien = santi.

*/
