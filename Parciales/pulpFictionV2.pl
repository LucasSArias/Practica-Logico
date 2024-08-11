personaje(pumkin,     ladron([licorerias, estacionesDeServicio])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent,    mafioso(maton)).
personaje(jules,      mafioso(maton)).
personaje(marsellus,  mafioso(capo)).
personaje(winston,    mafioso(resuelveProblemas)).
personaje(mia,        actriz([foxForceFive])).
personaje(butch,      boxeador).

pareja(marsellus, mia).
pareja(pumkin,    honeyBunny).

%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

% Punto 1
esPeligroso(Personaje):-
    realizaActividadPeligrosa(Personaje).
esPeligroso(Personaje):-
    tieneEmpleadosPeligrosos(Personaje).

realizaActividadPeligrosa(Personaje):-
    personaje(Personaje, Rol),
    esRolPeligroso(Rol).

esRolPeligroso(ladron(Tiendas)):-
    member(licorerias, Tiendas).
esRolPeligroso(mafioso(maton)).

tieneEmpleadosPeligrosos(Personaje):-
    trabajaPara(Personaje, Empleado),
    realizaActividadPeligrosa(Empleado).

% Punto 2
amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).

duoTemible(UnPersonaje, OtroPersonaje):-
    esPeligroso(UnPersonaje),
    esPeligroso(OtroPersonaje),
    sonParejaOAmigos(UnPersonaje, OtroPersonaje).

sonParejaOAmigos(UnPersonaje, OtroPersonaje):-
    amigo(UnPersonaje, OtroPersonaje).
sonParejaOAmigos(UnPersonaje, OtroPersonaje):-
    pareja(UnPersonaje, OtroPersonaje).

% Punto 3
%encargo(Solicitante, Encargado, Tarea). 
%las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).
encargo(marsellus, vincent, caca).


estaEnProblemas(butch).
estaEnProblemas(Personaje):-
    trabajaPara(Jefe, Personaje),
    esPeligroso(Jefe),
    pareja(Jefe, Pareja),
    encargo(Jefe, Personaje, cuidar(Pareja)).
estaEnProblemas(Personaje):-
    encargo(_,Personaje, buscar(Boxeador)),
    esBoxeador(Boxeador).

esBoxeador(Personaje):-
    personaje(Personaje, boxeador).

% Punto 4
sanCayetano(Personaje):-
    tieneCerca(Personaje,_),
    forall(tieneCerca(Personaje, Alguien), leDaTrabajo(Personaje, Alguien)).

tieneCerca(Personaje, Alguien):-
    amigo(Personaje, Alguien).
tieneCerca(Personaje, Alguien):-
    trabajaPara(Personaje, Alguien).

leDaTrabajo(Personaje, Alguien):-
    encargo(Personaje, Alguien, _).

% Punto 5
masAtareado(Personaje):-
    cantidadDeEncargos(Personaje, CantidadMaxima),
    forall(encargosDeAlguienQueNoEs(Personaje, OtroPersonaje, Cantidad), Cantidad < CantidadMaxima).

cantidadDeEncargos(Personaje, Cantidad):-
    personaje(Personaje,_),
    findall(Encargo, encargo(_, Personaje, Encargo), ListaEncargos),
    length(ListaEncargos, Cantidad).

encargosDeAlguienQueNoEs(Personaje, OtroPersonaje, Cantidad):-
    personaje(OtroPersonaje,_),
    Personaje \= OtroPersonaje,
    cantidadDeEncargos(OtroPersonaje, Cantidad).
    
% Punto 6
personajesRespetables(ListaPersonajes):-
    findall(Personaje, esRespetable(Personaje), ListaPersonajes).

esRespetable(Personaje):-
    personaje(Personaje, Actividad),
    respetoDeActividad(Actividad, Nivel),
    Nivel > 9.

respetoDeActividad(actriz(Peliculas), Nivel):-
    length(Peliculas, CantidadDePeliculas),
    Nivel is CantidadDePeliculas / 10.
respetoDeActividad(mafioso(TipoDeMafioso), Nivel):-
    nivelSegunTipoDeMafioso(TipoDeMafioso, Nivel).

nivelSegunTipoDeMafioso(resuelveProblemas, 10).
nivelSegunTipoDeMafioso(maton, 1).
nivelSegunTipoDeMafioso(capo, 20).

% Punto 7
hartoDe(PrimerPersonaje, SegundoPersonaje):-
    personaje(PrimerPersonaje,_),
    forall(tareaDe(PrimerPersonaje, Tarea), interactuaElSegundoOUnAmigo(SegundoPersonaje, Tarea)).

tareaDe(PrimerPersonaje, Tarea):-
    encargo(_, PrimerPersonaje, Tarea).

interactuaElSegundoOUnAmigo(SegundoPersonaje, Tarea):-
    personajeOAmigoDelPersonaje(SegundoPersonaje, PersonaInvolucradaEnLaTarea),
    estaPresenteEnLaTarea(PersonaInvolucradaEnLaTarea, Tarea).

personajeOAmigoDelPersonaje(Personaje, PersonaInvolucradaEnLaTarea):-
    personaje(Personaje,_),
    Personaje = PersonaInvolucradaEnLaTarea.
personajeOAmigoDelPersonaje(Personaje, PersonaInvolucradaEnLaTarea):-
    amigo(Personaje, PersonaInvolucradaEnLaTarea).

estaPresenteEnLaTarea(Personaje, cuidar(Personaje)).
estaPresenteEnLaTarea(Personaje, buscar(Personaje)).
estaPresenteEnLaTarea(Personaje, ayudar(Personaje)).

% Punto 8
caracteristicas(vincent,  [negro, muchoPelo, tieneCabeza]).
caracteristicas(jules,    [tieneCabeza, muchoPelo]).
caracteristicas(marvin,   [negro]).

duoDiferenciable(UnPersonaje, OtroPersonaje):-
    tieneAlgoQueElOtroNo(UnPersonaje, OtroPersonaje).

tieneAlgoQueElOtroNo(Personaje1, Personaje2):-
    caracteristicas(Personaje1, CaracteristicasP1),
    caracteristicas(Personaje2, CaracteristicasP2),
    member(UnaCaracteristicaP1, CaracteristicasP1),
    not(member(UnaCaracteristicaP1, CaracteristicasP2)).