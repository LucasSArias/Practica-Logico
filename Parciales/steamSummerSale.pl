%juego(Juego, Precio)   --> Juego es un functor
juego(accion(callOfDuty),5).
juego(accion(batmanAA),10).
juego(mmorpg(wow,5000000),30).
juego(mmorpg(lineage2,6000000),15).
juego(puzzle(plantsVsZombies,40,media),10).
juego(puzzle(tetris,10,facil),0).

%oferta(NombreJuego, porcentajeDeDescuento)
oferta(callOfDuty,10).
oferta(plantsVsZombies,50).
/*
A su vez, se tiene el predicado usuario​/3 que relaciona a un usuario con los nombres de los juegos
que ya posee y los distintos tipos de adquisiciones que planea realizar el mismo.

Las adquisiciones que puede realizar un usuario se encuentran modeladas con functores. Estas
pueden ser: una compra ​para sí mismo, donde se conoce el nombre del juego que se va a
comprar; o bien, un regalo​, donde se conoce el nombre del juego a regalar y además, el nombre
del usuario a quien se le hará dicho regalo.
*/
usuario(nico,[batmanAA,plantsVsZombies,tetris],[compra(lineage2)]).
usuario(fede,[],[regalo(callOfDuty,nico),regalo(wow,nico)]).
usuario(rasta,[lineage2],[]).
usuario(agus,[],[]).
usuario(felipe,[plantsVsZombies],[compra(tetris)]).

cuantoSale(Juego, Valor):-
    juego(Juego, PrecioOriginal),
    estaEnOferta(Juego, Descuento),
    Valor is PrecioOriginal - PrecioOriginal * Descuento / 100.
cuantoSale(Juego, Valor):-
    juego(Juego, Valor),
    not(estaEnOferta(Juego, _)).

estaEnOferta(Juego, Descuento):-
    nombre(Juego, NombreJuego),
    oferta(NombreJuego, Descuento).

nombre(accion(NombreJuego), NombreJuego).
nombre(mmorpg(NombreJuego,_), NombreJuego).
nombre(puzzle(NombreJuego,_,_), NombreJuego).

juegoPopular(Juego):-
    juego(Juego,_),
    esBuenTipo(Juego).

esBuenTipo(accion(_)).
esBuenTipo(mmorpg(_,Usuarios)):-
    Usuarios > 1000000.
esBuenTipo(puzzle(_,_, facil)).
esBuenTipo(puzzle(_,25 ,_)).

tieneUnBuenDescuento(Juego):-
    juego(Juego,_),
    estaEnOferta(Juego, Descuento),
    Descuento > 50.

adictoALosDescuentos(Usuario):-
    usuario(Usuario,_, JuegosPorAdquirir),
    forall(member(Adquisicion, JuegosPorAdquirir), esBuenaAdquisicion(Adquisicion)).

esBuenaAdquisicion(compra(Juego)):-
    buenDescuento(Juego).
esBuenaAdquisicion(regalo(Juego,_)):-
    buenDescuento(Juego).

buenDescuento(Juego):-
    oferta(Juego,Descuento),
    Descuento > 50.

fanaticoDe(Usuario, Genero):-
    usuario(Usuario, Juegos, _),
    member(UnJuego, Juegos),
    member(OtroJuego, Juegos),
    UnJuego\=OtroJuego,
    esDeGenero(UnJuego, Genero),
    esDeGenero(OtroJuego, Genero).

esDeGenero(Juego, accion):-
    juego(accion(Juego),_).
esDeGenero(Juego, mmorpg):-
    juego(mmorpg(Juego,_),_).
esDeGenero(Juego, puzzle):-
    juego(puzzle(Juego,_,_),_).

monotematico(Usuario, Genero):-     % NO SE POR QUE NICO LO TOMA COMO MONOTEMATICO ¿?¿?
    usuario(Usuario, Juegos,_),
    forall(member(Juego, Juegos), esDeGenero(Juego, Genero)).

buenosAmigos(UnUsuario, OtroUsuario):-
    usuario(UnUsuario,_,_),
    usuario(OtroUsuario,_,_),
    UnUsuario \= OtroUsuario,
    regalaJuegoPopular(UnUsuario, OtroUsuario),
    regalaJuegoPopular(OtroUsuario, UnUsuario).

regalaJuegoPopular(PersonaA, PersonaB):-
    usuario(PersonaA,_, AdquisicionesA),
    usuario(PersonaB,_,_),
    member(regalo(UnJuego,PersonaB), AdquisicionesA),
    juegoPopular(UnJuego).

cuantoGastara(Usuario, Dinero):-
    usuario(Usuario,_,Adquisiciones)
    sumlist(, Dinero).

precioDeUnJuegoPorAdquirir(Usuario, Precio):-
    usuario(Usuario,_,Adquisicion)