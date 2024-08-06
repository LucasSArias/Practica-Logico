%integrante(grupo, integranteDelGrupo, instrumentoQueToca)
integrante(sophieTrio, sophie, violin).
integrante(sophieTrio, santi, guitarra).
integrante(vientosDelEste, lisa, saxo).
integrante(vientosDelEste, santi, voz).
integrante(vientosDelEste, santi, guitarra).
integrante(vientosDelEste, santi , bateria).
integrante(jazzmin, santi, bateria).

%nivelQueTiene(persona, instrumentoQueToca, queTanBienImprovisa)
nivelQueTiene(sophie, violin, 5).
nivelQueTiene(santi, guitarra,2).
nivelQueTiene(santi,voz,3).
nivelQueTiene(santi,bateria,4).
nivelQueTiene(lisa,saxo,4).
nivelQueTiene(lore,violin,4).
nivelQueTiene(luis, trompeta, 1). 
nivelQueTiene(luis, contrabajo, 4).

%instrumento(nombreInstrumento, rolQueCumple)
instrumento(violin, melodico(cuerdas)).
instrumento(guitarra, armonico).
instrumento(bateria, ritmico).
instrumento(saxo, melodico(viento)).
instrumento(trompeta, melodico(viento)).
instrumento(contrabajo, armonico).
instrumento(bajo, armonico).
instrumento(piano, armonico).
instrumento(pandereta, ritmico).
instrumento(voz, melodico(vocal)).

% Punto 1
tieneBuenaBase(Grupo):-
    integrante(Grupo, IntegranteArmonico, InstrumentoArmonico),
    instrumento(InstrumentoArmonico, armonico),
    integrante(Grupo, IntegranteRitmico, InstrumentoRitmico),
    instrumento(InstrumentoRitmico, ritmico),
    IntegranteArmonico \= IntegranteRitmico.

% Punto 2
seDestaca(Persona, Grupo):- % REVISAR DESPUES
    integrante(Grupo, Persona, _),
    forall((Persona \= OtraPersona, integrante(Grupo, OtraPersona, _)), hayDiferencia(Persona, OtraPersona)).

hayDiferencia(Persona, OtraPersona):-
    nivelQueTiene(Persona, _,Nivel),
    nivelQueTiene(OtraPersona, _,OtroNivel),
    Persona \= OtraPersona,
    2 >= Nivel - OtroNivel.

% Punto 3
grupo(vientosDelEste, bigBand).
grupo(sophieTrio, formacion([contrabajo, guitarra, violin])).
grupo(jazzmin, formacion([bateria, bajo, trompeta, piano, guitarra])).

% Punto 4
hayCupo(Instrumento, Grupo):-
    grupo(Grupo,bigBand),
    instrumento(Instrumento, melodico(viento)).
hayCupo(Instrumento, Grupo):-
    instrumento(Instrumento,_),
    grupo(Grupo,_),
    nadieToca(Instrumento, Grupo),
    sirveEn(Instrumento, Grupo).

nadieToca(Instrumento, Grupo):-
    forall(integrante(Grupo, Integrante, InstrumentoQueToca), InstrumentoQueToca \= Instrumento).

sirveEn(Instrumento, Grupo):-
    grupo(Grupo, formacion(InstrumentosBuscados)),
    member(Instrumento, InstrumentosBuscados).
sirveEn(Instrumento, Grupo):-
    grupo(Grupo, bigBand),
    member(Instrumento, [bateria, bajo, piano]).
sirveEn(_, Grupo):-
    grupo(Grupo, ensamble(_)).


% Punto 5
puedeIncorporarse(Persona, Grupo, Instrumento):-
    integrante(Grupo,_,_),
    integrante(_,Persona,_),
    not(integrante(Grupo, Persona, _)),
    hayCupo(Instrumento, Grupo),
    pasaLaVara(Persona, Grupo, Instrumento).


pasaLaVara(Persona, Grupo, Instrumento):-
    grupo(Grupo, Tipo),
    superaElNivel(Persona, Instrumento, Tipo).

superaElNivel(Persona, Instrumento, bigBand):-
    nivelQueTiene(Persona, Instrumento, Nivel),
    Nivel >= 1.
superaElNivel(Persona, Instrumento, formacion(InstrumentosBuscados)):-
    nivelQueTiene(Persona, Instrumento, Nivel),
    length(InstrumentosBuscados, CantidadInstrumentosBuscados),
    Nivel >= 7 - CantidadInstrumentosBuscados.
superaElNivel(Persona, Instrumento, ensamble(NivelMinimo)):-
    nivelQueTiene(Persona, Instrumento, Nivel),
    Nivel > NivelMinimo.

% Punto 6
seQuedoEnBanda(Persona):-
    nivelQueTiene(Persona, _, _),
    not(integrante(_, Persona, _)),
    not(puedeIncorporarse(Persona, _, _)).

% Punto 7
puedeTocar(Grupo):-
    grupo(Grupo,_),
    cumpleNecesidades(Grupo).

cumpleNecesidades(Grupo):-
    grupo(Grupo, bigBand),
    tieneBuenaBase(Grupo),
    alMenos5TocanInstrumentosDeViento(Grupo).

cumpleNecesidades(Grupo):-
    grupo(Grupo,formacion(InstrumentosBuscados)),
    forall(member(Instrumento, InstrumentosBuscados), integrante(Grupo,_,Instrumento)).

cumpleNecesidades(Grupo):-
    grupo(Grupo, ensamble(NivelMinimo)),
    tieneBuenaBase(Grupo),
    integrante(Grupo,Persona,Instrumento),
    instrumento(Instrumento,melodico(_)).

alMenos5TocanInstrumentosDeViento(Grupo):-
    findall(Integrante, tocaYEsDeViento(Grupo, Integrante, Instrumento), ListaIntegrantes),
    list_to_set(ListaIntegrantes, IntegrantesDistintos),
    length(IntegrantesDistintos, CantidadIntegrantes),
    CantidadIntegrantes >= 5.

tocaYEsDeViento(Grupo, Integrante, Instrumento):-
    integrante(Grupo, Integrante, Instrumento),
    instrumento(Instrumento, melodico(viento)).

% Punto 8
grupo(estudio1, ensamble(3)).    
    