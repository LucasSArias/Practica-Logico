% define quiénes son amigos de nuestro cliente
amigo(mati). 
amigo(pablo). 
amigo(leo).
amigo(fer). 
amigo(flor).
amigo(ezequiel).
amigo(marina).
% define quiénes no se pueden ver
noSeBanca(leo, flor). 
noSeBanca(pablo, fer).
noSeBanca(fer, leo). 
noSeBanca(flor, fer).
% define cuáles son las comidas y cómo se componen
% functor achura contiene nombre, cantidad de calorías
% functor ensalada contiene nombre, lista de ingredientes
% functor morfi contiene nombre (el morfi es una comida principal)
comida(achura(chori, 200)). % ya sabemos que el chori no es achura
comida(achura(chinchu, 150)).
comida(ensalada(waldorf, [manzana, apio, nuez, mayo])).
comida(ensalada(mixta, [lechuga, tomate, cebolla])).
comida(morfi(vacio)).
comida(morfi(mondiola)).
comida(morfi(asado)).
% relacionamos la comida que se sirvió en cada asado
% cada asado se realizó en una única fecha posible: functor fecha + comida
asado(fecha(22,9,2011), chori). 
asado(fecha(15,9,2011), mixta).
asado(fecha(22,9,2011), waldorf).
asado(fecha(15,9,2011), mondiola).
asado(fecha(22,9,2011), vacio). 
asado(fecha(15,9,2011), chinchu).
% relacionamos quiénes asistieron a ese asado
asistio(fecha(15,9,2011), flor). 
asistio(fecha(22,9,2011), marina).
asistio(fecha(15,9,2011), pablo).
asistio(fecha(22,9,2011), pablo).
asistio(fecha(15,9,2011), leo). 
asistio(fecha(22,9,2011), flor).
asistio(fecha(15,9,2011), fer). 
asistio(fecha(22,9,2011), mati).
% definimos qué le gusta a cada persona
leGusta(mati, chori). 
leGusta(fer, mondiola). 
leGusta(pablo, asado).
leGusta(mati, vacio). 
leGusta(fer, vacio).
leGusta(mati, waldorf). 
leGusta(flor, mixta).

% Punto 1
% a 
leGusta(ezequiel, Comida):-
    leGusta(mati, Comida),
    leGusta(fer, Comida).
% b
leGusta(marina, mondiola).
leGusta(marina, Comida):-
    leGusta(flor, Comida).

% c
% Como a leo no le gusta la ensalada waldorf, no es necesario agregarlo a la base de conocimientos.

% Punto 2
asadoViolento(Fecha):-
    asistio(Fecha,_),
    forall(asistio(Fecha, Alguien), estaElQueNoSeBanca(Alguien, Fecha)).

estaElQueNoSeBanca(Alguien, Fecha):-
    asistio(Fecha, Alguien),
    asistio(Fecha, ElQueNoSeBanca),
    noSeBanca(Alguien, ElQueNoSeBanca).

% Punto 3
calorias(NombreComida, Calorias):-
    comida(Comida),
    caloriasSegunTipo(Comida, Calorias, NombreComida).

caloriasSegunTipo(ensalada(Nombre,Ingredientes), Calorias, Nombre):-
    length(Ingredientes, Calorias).
caloriasSegunTipo(achura(Nombre, Calorias), Calorias, Nombre).
caloriasSegunTipo(morfi(Nombre), 200, Nombre).

% Punto 4
asadoFlojito(Fecha):-
    asado(Fecha,_),
    findall(CaloriasDeUnaComida, (asado(Fecha, UnaComida), calorias(UnaComida, CaloriasDeUnaComida)), CaloriasDeLasComidas),
    sumlist(CaloriasDeLasComidas, CaloriasTotales),
    CaloriasTotales < 400.

% Punto 5                                   SEGUIRLO DESPUES
hablo(fecha(15,09,2011), flor, pablo). 
hablo(fecha(22,09,2011), flor, marina).
hablo(fecha(15,09,2011), pablo, leo). 
hablo(fecha(22,09,2011), marina, pablo).
hablo(fecha(15,09,2011), leo, fer). 
reservado(marina).

chismeDe(Fecha, UnaPersona, OtraPersona):-
    not(reservado(OtraPersona)),
    hablo(Fecha, OtraPersona, UnaPersona).
chismeDe(Fecha, UnaPersona, OtraPersona):-
    not(reservado(OtraPersona)),
    sabeChismeDe(OtraPersona, Alguien),
    hablo(Fecha, Alguien, UnaPersona).

sabeChismeDe(UnaPersona, ElQueSabeElChisme):-
    hablo(_,UnaPersona, ElQueSabeElChisme).

% Punto 6
disfruto(Persona, Fecha):-
    asistio(Fecha, Persona),
    findall(Comida, (asado(Fecha,Comida),leGusta(Persona, Comida)), ComidasQueComio),
    length(ComidasQueComio, CantidadDeComidas),
    CantidadDeComidas >= 3.

% Punto 7
asadoRico(Comidas):-
    asado(Fecha, _),
    findall(Comida, (asado(Fecha,Comida), esRica(Comida)), Comidas).

esRica(NombreComida):-
    comida(TipoDeComida),
    esUnaComidaRica(TipoDeComida, NombreComida).

esUnaComidaRica(morfi(Nombre), Nombre).
esUnaComidaRica(ensalada(Nombre, Ingredientes), Nombre):-
    length(Ingredientes, CantIngredientes),
    CantIngredientes > 3.
esUnaComidaRica(achura(chori,_), chori).
esUnaComidaRica(achura(morchi,_), morci).
