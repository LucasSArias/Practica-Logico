canta(megurineLuka, cancion(nightFever, 4)).
canta(megurineLuka, cancion(foreverYoung, 5)).
canta(hatsuneMiku, cancion(tellYourWorld, 4)).
canta(gumi, cancion(foreverYoung, 4)).
canta(gumi, cancion(tellYourWorld, 5)).
canta(seeU, cancion(novemberRain, 6)).
canta(seeU, cancion(nightFever, 5)).

esNovedoso(Cantante):-
    alMenos2Canciones(Cantante),
    duraMenosDe15Min(Cantante).
alMenos2Canciones(Cantante):-
    canta(Cantante,UnaCancion),
    canta(Cantante,OtraCancion),
    UnaCancion \= OtraCancion.

duraMenosDe15Min(Cantante):-
    duracionTotal(Cantante, Duracion),
    Duracion < 15.
duracionTotal(Cantante, Duracion):-
    findall(Minutos, minutosDeLaCancion(Cantante,_, Minutos), MinutosTotales),
    sumlist(MinutosTotales, Duracion).

minutosDeLaCancion(Cantante,_ , Minutos):-
    canta(Cantante, cancion(_, Minutos)).

esAcelerado(Cantante):-
    canta(Cantante,_),
    forall(canta(Cantante, cancion(_,Duracion)), Duracion =< 4).


concierto(mikuExpo, eeuu, 2000, gigante(2,6)).
concierto(magicalMirai, japon, 3000, gigante(3,10)).
concierto(vocalektVisions, eeuu, 1000, mediano(9)).
concierto(mikuFest, argentina, 100, pequenio(4)).

puedeParticipar(Cantante, Concierto):-
    canta(Cantante,_),
    concierto(Concierto,_,_,Requisitos),
    cumpleRequisitos(Cantante, Requisitos).
puedeParticipar(hatsuneMiku, Concierto).

cumpleRequisitos(Cantante, gigante(MinimoDeCanciones, DuracionMinima)):-
    cantidadCanciones(Cantante, Cantidad),
    Cantidad >= MinimoDeCanciones,
    duracionTotal(Cantante, Duracion),
    Duracion >= DuracionMinima.
cumpleRequisitos(Cantante, mediano(DuracionMaxima)):-
    duracionTotal(Cantante, Duracion),
    Duracion < DuracionMaxima.
cumpleRequisitos(Cantante, pequenio(DuracionMinimaDeUnaCancion)):-
    canta(Cantante,cancion(_,Duracion)),
    Duracion >= DuracionMinimaDeUnaCancion.

cantidadCanciones(Cantante, Cantidad):-
    canta(Cantante,_),
    findall(Cancion, canta(Cantante, Cancion), ListaCanciones),
    length(ListaCanciones, Cantidad).

elMasFamoso(Cantante):-
    canta(Cantante,_),
    OtroCantante\=Cantante,
    forall(canta(OtroCantante,_), esMasFamoso(Cantante, OtroCantante)).

esMasFamoso(MasFamoso, MenosFamoso):-
    nivelDeFama(MasFamoso, NivelFamaMayor),
    nivelDeFama(MenosFamoso, NivelFamaMenor),
    NivelFamaMayor > NivelFamaMenor.

nivelDeFama(Cantante, NivelFama):-
    famaTotal(Cantante, FamaTotal),
    cantidadCanciones(Cantante, CantidadCanciones),
    NivelFama is FamaTotal * CantidadCanciones.

famaTotal(Cantante, FamaTotal):-
    canta(Cantante,_),
    findall(Fama, (puedeParticipar(Cantante, Concierto), concierto(Concierto,_,Fama,_)), FamaDeLosConciertos),
    sumlist(FamaDeLosConciertos, FamaTotal).

