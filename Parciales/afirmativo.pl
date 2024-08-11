%tarea(agente, tarea, ubicacion)
%tareas:
%  ingerir(descripcion, tamaño, cantidad)
%  apresar(malviviente, recompensa)
%  asuntosInternos(agenteInvestigado)
%  vigilar(listaDeNegocios)

tarea(vigilanteDelBarrio, ingerir(pizza, 1.5, 2),laBoca).
tarea(vigilanteDelBarrio, vigilar([pizzeria, heladeria]), barracas).
tarea(canaBoton, asuntosInternos(vigilanteDelBarrio), barracas).
tarea(sargentoGarcia, vigilar([pulperia, haciendaDeLaVega, plaza]),puebloDeLosAngeles).
tarea(sargentoGarcia, ingerir(vino, 0.5, 5),puebloDeLosAngeles).
tarea(sargentoGarcia, apresar(elzorro, 100), puebloDeLosAngeles). 
tarea(vega, apresar(neneCarrizo,50),avellaneda).
tarea(jefeSupremo, vigilar([congreso,casaRosada,tribunales]),laBoca).

ubicacion(puebloDeLosAngeles).
ubicacion(avellaneda).
ubicacion(barracas).
ubicacion(marDelPlata).
ubicacion(laBoca).
ubicacion(uqbar).

%jefe(jefe, subordinado)
jefe(jefeSupremo, vega).
jefe(vega, vigilanteDelBarrio).
jefe(vega, canaBoton).
jefe(jefeSupremo,sargentoGarcia).


% Punto 1
frecuenta(_, buenosAires).
frecuenta(vega, quilmes).
frecuenta(Agente, Lugar):-
    tarea(Agente, _, Lugar).
frecuenta(Agente, marDelPlata):-
    tarea(Agente, vigilar(Puestos),_),
    member(negocioDeAlfajores, Puestos).

% Punto 2
nadieFrecuenta(Lugar):-
    ubicacion(Lugar),
    forall(frecuenta(UnAgente, UnLugar), UnLugar \=Lugar).

% Punto 3
afincado(Agente):-
    trabajaEn(Agente, Lugar),
    not((trabajaEn(Agente, OtroLugar), Lugar \= OtroLugar)).

trabajaEn(Agente, Lugar):-
    tarea(Agente,_,Lugar).

% Punto 4
cadenaDeMando(Lista):-
    findall(Policia, jefe(Policia, OtroPolicia), ListaPolicias),
    list_to_set(ListaPolicias, Lista).

% Punto 5
agentePremiado(Agente):-
    puntuacion(Agente, PuntuacionMaxima),
    forall((puntuacion(OtroAgente, Puntuacion), Agente \= OtroAgente), PuntuacionMaxima > Puntuacion).

puntuacion(Agente, Puntuacion):-
    tarea(Agente,_,_),
    findall(Puntos, puntosDeUnaTareaQueRealiza(Agente, Puntos), PuntosDeLasTareas),
    sumlist(PuntosDeLasTareas, Puntuacion).

puntosDeUnaTareaQueRealiza(Agente, Puntos):-
    tarea(Agente, UnaTarea,_),
    puntosSegunTarea(UnaTarea, Puntos).

puntosSegunTarea(vigilar(Negocios), Puntos):-
    length(Negocios, CantidadDeNegocios),
    Puntos is CantidadDeNegocios * 5.
puntosSegunTarea(ingerir(_,Tamanio, Cantidad), Puntos):-
    Puntos is -10 * Tamanio * Cantidad.
puntosSegunTarea(apresar(_, Recompensa), Puntos):-
    Puntos is Recompensa / 2.
puntosSegunTarea(asuntosInternos(AgenteInvestigado)):-
    puntuacion(AgenteInvestigado, PuntosAgenteInvestigado),
    Puntos is 2 * PuntosAgenteInvestigado.
    