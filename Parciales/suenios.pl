% Punto 1
% cree(Persona, [Creencias]).
cree(gabriel, [campanita, elMagoDeOz, cavenaghi]).
cree(juan, [conejoDePascua]).
cree(macarena, [reyesMagos, magoCapria, campanita]).

suenio(gabriel, ganarLaLoteria([5,6,7,8,9])).
suenio(gabriel, serFutbolista(arsenal)).
suenio(juan, cantante(100000)).
suenio(macarena, cantante(10000)).

% Punto 2
dificultad(Suenio, Dificultad):-
    suenio(_,Suenio),
    dificultadSegun(Suenio, Dificultad).

dificultadSegun(cantante(CopiasVendidas), 6):-
    CopiasVendidas > 500000.
dificultadSegun(cantante(CopiasVendidas), 4):-
    CopiasVendidas =< 500000.
dificultadSegun(ganarLaLoteria(ListaNumeros), Dificultad):-
    length(ListaNumeros, CantNumerosApostados),
    Dificultad is 10 * CantNumerosApostados.
dificultadSegun(serFutbolista(Equipo), 3):-
    esEquipoChico(Equipo).
dificultadSegun(serFutbolista(Equipo), 16):-
    not(esEquipoChico(Equipo)).

esEquipoChico(arsenal).
esEquipoChico(aldosivi).

esAmbicioso(Personaje):-
    suenio(Personaje, _),
    findall(Dificultad, (suenio(Personaje, Suenio), dificultad(Suenio, Dificultad)), Dificultades),
    sumlist(Dificultades, Suma),
    Suma > 20.

% Punto 3
tieneQuimica(Personaje, Persona):-
    creeEn(Persona,Personaje),
    Personaje \= campanita,
    forall(suenio(Persona,UnSuenio), esSuenioPuro(UnSuenio)),
    not(esAmbicioso(Persona)).
% LA PARTE DE CAMPANITA NO SE COMO HACERLA SIN FINDALL XD

esSuenioPuro(UnSuenio):-
    suenio(_, UnSuenio),
    esPuro(UnSuenio).

esPuro(serFutbolista(_)).
esPuro(cantante(CantidadDiscos)):-
    CantidadDiscos < 200000.
    
creeEn(Persona, Personaje):-
    cree(Persona, Personajes),
    member(Personaje, Personajes).
    
% Punto 4
amigoDe(campanita, reyesMagos).
amigoDe(campanita, conejoDePascua).
amigoDe(conejoDePascua, cavenaghi).

estaEnfermo(campanita).
estaEnfermo(reyesMagos).
estaEnfermo(conejoDePascua).

puedeAlegrar(Personaje, Persona):-
    cumplenLasBases(Personaje, Persona),
    not(estaEnfermo(Personaje)).
puedeAlegrar(Personaje, Persona):-
    cumplenLasBases(Personaje, Persona),
    backupNoEnfermo(Personaje, Persona).

cumplenLasBases(Personaje, Persona):-
    suenio(Persona,_),
    tieneQuimica(Personaje, Persona).

backupNoEnfermo(Personaje, AmigoDelPersonaje):-     % ESTE PARCIAL ES UNA PORONGA
    estaEnfermo(Personaje),
    amigoDe(Personaje, AmigoDelPersonaje),
    not(estaEnfermo(AmigoDelPersonaje)).