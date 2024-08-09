rata(remy, gusteaus).
rata(emile, bar).
rata(django, pizzeria).
cocina(linguini, ratatouille, 3).
cocina(linguini, sopa, 5).
cocina(colette, salmonAsado, 9).
cocina(horst, ensaladaRusa, 8).
/*  De las ratas sabemos su nombre y dónde viven. De los humanos, además de su nombre, qué platos
saben cocinar y cuánta experiencia (del 1 al 10) tienen preparándolos. También tenemos información
acerca de quién trabaja en cada restaurante:    */
trabajaEn(gusteaus, linguini).
trabajaEn(gusteaus, colette).
trabajaEn(gusteaus, skinner).
trabajaEn(gusteaus, horst).
trabajaEn(cafeDes2Moulins, amelie).

% Punto 1
inspeccionSatisfactoria(Restaurante):-
    trabajaEn(Restaurante,_),
    not(rata(_,Restaurante)).

% Punto 2
chef(Empleado, Restaurante):-
    trabajaEn(Restaurante, Empleado),
    cocina(Empleado,_,_).

% Punto 3
chefcito(Rata):-
    rata(Rata, gusteaus).

% Punto 4
cocinaBien(remy, _).
cocinaBien(Persona, Plato):-
    cocina(Persona, Plato, Experiencia),
    Experiencia > 7.

% Punto 5
encargadoDe(Persona, Plato, Restaurante):-
    masExperimentadoCocinando(Persona, Plato),
    trabajaEn(Restaurante, Persona).

masExperimentadoCocinando(Persona, Plato):-
    cocina(Persona, Plato, Habilidad),
    forall((cocina(OtraPersona,Plato,OtraHabilidad), Persona\= OtraPersona), Habilidad > OtraHabilidad).

% Punto 6
plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo, mayonesa])).
plato(bifeDeChorizo, principal(pure, 25)).
plato(frutillasConCrema, postre(265)).

saludable(Plato):-
    calorias(Plato, Calorias),
    Calorias < 75.
saludable(Plato):-
    esPostre(Plato),
    grupo(NombreGrupo),
    NombreGrupo = Plato.
calorias(Plato, Calorias):-
    plato(Plato, Tipo),
    caloriasSegunTipo(Tipo, Calorias).

caloriasSegunTipo(entrada(Ingredientes), Calorias):-
    length(Ingredientes, CantidadIngredientes),
    Calorias is CantidadIngredientes * 15.
caloriasSegunTipo(principal(Guarnicion, MinutosDeCoccion), Calorias):-
    caloriasDeLaGuarnicion(Guarnicion, CaloriasGuarnicion),
    Calorias is CaloriasGuarnicion + MinutosDeCoccion * 5.
caloriasSegunTipo(postre(Calorias),Calorias).

esPostre(Plato):-
    plato(Plato, postre(_)).

caloriasDeLaGuarnicion(papasFritas, 50).
caloriasDeLaGuarnicion(pure, 20).
caloriasDeLaGuarnicion(ensaladaRusa,0).

grupo(frutillasConCrema).

% Punto 7


criticaPositiva(Restaurante, Critico):-
    reseniaPositiva(Restaurante, Critico),
    inspeccionSatisfactoria(Restaurante).

reseniaPositiva(Restaurante, antonEgo):-
    lugarEspecialista(Restaurante, ratatouille).
reseniaPositiva(Restaurante, christophe):-
    masDeTresChefs(Restaurante).
reseniaPositiva(Restaurante, cormillot):-
    todosPlatosSaludables(Restaurante),
    todasEntradasConZanahoria(Restaurante).

lugarEspecialista(Restaurante, Plato):-
    plato(Plato,_),
    trabajaEn(Restaurante,_),
    forall(trabajaEn(Restaurante, Persona), cocinaBien(Persona, Plato)).
    
masDeTresChefs(Restaurante):-
    trabajaEn(Restaurante,_),
    findall(Empleado, trabajaEn(Restaurante, Empleado), ListaEmpleados),
    length(ListaEmpleados, CantEmpleados),
    CantEmpleados > 3.

todosPlatosSaludables(Restaurante):-
    forall(platoDelRestaurante(Plato, Restaurante), saludable(Plato)).

platoDelRestaurante(Plato, Restaurante):-
    cocina(Empleado, Plato, _),
    trabajaEn(Restaurante,Empleado).

todasEntradasConZanahoria(Restaurante):-
    forall(entradaDelRestaurante(Entrada, Restaurante), tieneZanahoria(Entrada)).

entradaDelRestaurante(Entrada, Restaurante):-
    plato(Entrada, entrada(_)),
    cocina(Empleado, Entrada, _),
    trabajaEn(Restaurante, Empleado).

tieneZanahoria(Entrada):-
    plato(Entrada,entrada(Ingredientes)),
    member(zanahoria,Ingredientes).