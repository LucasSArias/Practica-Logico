% esPersonaje/1 nos permite saber qué personajes tendrá el juego
esPersonaje(aang).
esPersonaje(katara).
esPersonaje(zoka).
esPersonaje(appa).
esPersonaje(momo).
esPersonaje(toph).
esPersonaje(tayLee).
esPersonaje(zuko).
esPersonaje(azula).
esPersonaje(iroh).

% esElementoBasico/1 nos permite conocer los elementos básicos que pueden controlar algunos personajes
esElementoBasico(fuego).
esElementoBasico(agua).
esElementoBasico(tierra).
esElementoBasico(aire).

% elementoAvanzadoDe/2 relaciona un elemento básico con otro avanzado asociado
elementoAvanzadoDe(fuego, rayo).
elementoAvanzadoDe(agua, sangre).
elementoAvanzadoDe(tierra, metal).

% controla/2 relaciona un personaje con un elemento que controla
controla(zuko, rayo).
controla(toph, metal).
controla(katara, sangre).
controla(aang, aire).
controla(aang, agua).
controla(aang, tierra).
controla(aang, fuego).
controla(azula, rayo).
controla(iroh, rayo).

% visito/2 relaciona un personaje con un lugar que visitó. Los lugares son functores que tienen la siguiente forma:
% reinoTierra(nombreDelLugar, estructura)
% nacionDelFuego(nombreDelLugar, soldadosQueLoDefienden)
% tribuAgua(puntoCardinalDondeSeUbica)
% temploAire(puntoCardinalDondeSeUbica)

visito(aang, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(iroh, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(zuko, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(toph, reinoTierra(fortalezaDeGralFong, [cuartel, dormitorios, enfermeria, salaDeGuerra, templo, zonaDeRecreo])).
visito(aang, nacionDelFuego(palacioReal, 1000)).
visito(katara, tribuAgua(norte)).
visito(katara, tribuAgua(sur)).
visito(aang, temploAire(norte)).
visito(aang, temploAire(oeste)).
visito(aang, temploAire(este)).
visito(aang, temploAire(sur)).


% Punto 1
esElAvatar(Personaje):-
    esPersonaje(Personaje),
    forall(esElementoBasico(Elemento), controla(Personaje, Elemento)).

% Punto 2

noEsMaestro(Personaje):-
    not(controlaUnElementoBasico(Personaje)),
    not(controlaUnElementoAvanzado(Personaje)).

controlaUnElementoBasico(Personaje):-
    esElementoBasico(Elemento),
    controla(Personaje, Elemento).

controlaUnElementoAvanzado(Personaje):-
    elementoAvanzadoDe(_,ElementoAvanzado),
    controla(Personaje, ElementoAvanzado).

esMaestroPrincipiante(Personaje):-
    controlaUnElementoBasico(Personaje),
    not(controlaUnElementoAvanzado(Personaje)).

esMaestroAvanzado(Personaje):-
    controlaUnElementoAvanzado(Personaje).
esMaestroAvanzado(Personaje):-
    esElAvatar(Personaje).

% Punto 3
sigueA(Seguido, Seguidor):-
    visito(Seguido,_),
    visito(Seguidor,_),
    Seguido \= Seguidor,
    forall(visito(Seguido, Lugares), visito(Seguidor, Lugares)).
sigueA(aang, zuko).

% Punto 4
esDignoDeConocer(Lugar):-
    visito(_,Lugar),
    esDigno(Lugar).

esDigno(tribuAgua(norte)).
esDigno(temploAire(_)).
esDigno(reinoTierra(Nombre, Estructura)):-
    not(member(muro, Estructura)).


% Punto 5
esPopular(Lugar):-
    visito(_,Lugar),
    findall(Visitante, visito(Visitante,Lugar), ListaVisitantes),
    length(ListaVisitantes, CantidadVisitantes),
    CantidadVisitantes > 4.

% Punto 6
personaje(bumi).
controla(bumi, tierra).
visito(bumi, reinoTierra(baSingSe)).

personaje(suki).
visito(nacionDelFuego(prisionDeMaximaSeguridad,200)).