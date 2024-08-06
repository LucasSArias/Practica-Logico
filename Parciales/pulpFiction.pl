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

% aca esta el dilema de que si vincent es amigo de jules, entonces jules es amigo de vincent?
amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).

%encargo(Solicitante, Encargado, Tarea). 
%las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent,   cuidar(mia)).
encargo(nashe, vincent, cuidar(pancho)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).


% Punto 1
esPeligroso(Personaje):-
    realizaActPeligrosa(Personaje).
esPeligroso(Personaje):-
    tieneEmpleadosPeligrosos(Personaje).

realizaActPeligrosa(Personaje):-
    personaje(Personaje, mafioso(maton)).
realizaActPeligrosa(Personaje):-
    personaje(Personaje, ladron(LocalesRobados)),
    member(licorerias, LocalesRobados).

tieneEmpleadosPeligrosos(Personaje):-
    trabajaPara(Personaje, Alguien),
    realizaActPeligrosa(Alguien).

% Punto 2
duoTemible(Persona1, Persona2):-
    sonPeligrosos(Persona1, Persona2),
    pareja(Persona1, Persona2).
duoTemible(Persona1, Persona2):-
    sonPeligrosos(Persona1, Persona2),
    amigo(Persona1, Persona2).

sonPeligrosos(Persona1, Persona2):-
    Persona1 \= Persona2,
    esPeligroso(Persona1),
    esPeligroso(Persona2).

% Punto 3
estaEnProblemas(Personaje):-
    trabajaPara(Jefe, Personaje),
    esPeligroso(Jefe),
    encargo(Jefe, Personaje, cuidar(Protegido)),
    pareja(Jefe, Protegido).
estaEnProblemas(Personaje):-
    encargo(_,Personaje, buscar(Alguien, _)),
    personaje(Alguien, boxeador).
estaEnProblemas(butch).

% Punto 4
sanCayetano(Personaje):-
    personaje(Personaje,_),
    tieneCerca(Personaje,_),
    forall(tieneCerca(Personaje, Alguien), encargo(Personaje,Alguien,_)).

tieneCerca(Personaje, Alguien):-
    amigo(Personaje, Alguien).
tieneCerca(Personaje, Alguien):-
    trabajaPara(Personaje, Alguien).

% Punto 5
masAtareado(ElDeMasTareas):-
    personaje(ElDeMasTareas,_),
    personaje(OtroPersonaje,_),
    ElDeMasTareas \= OtroPersonaje,
    forall(personaje(OtroPersonaje,_), menosTareasQue(OtroPersonaje, ElDeMasTareas)).

menosTareasQue(PersonajeConMenosTareas, PersonajeConMasTareas):-
    personaje(PersonajeConMenosTareas,_),
    personaje(PersonajeConMasTareas,_),
    findall(Encargo, encargo(_, PersonajeConMenosTareas, _), EncargosPMenos),
    findall(Encargo, encargo(_, PersonajeConMasTareas, _), EncargosPMas),
    length(EncargosPMenos, CantidadPMenos),
    length(EncargosPMas, CantidadPMas),
    CantidadPMenos < CantidadPMas.