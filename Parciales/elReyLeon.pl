%comio(Personaje, Bicho)
comio(pumba, vaquitaSanAntonio(gervasia,3)).
comio(pumba, hormiga(federica)).
comio(pumba, hormiga(tuNoEresLaReina)).
comio(pumba, cucaracha(ginger,15,6)).
comio(pumba, cucaracha(erikElRojo,25,70)).
comio(timon, vaquitaSanAntonio(romualda,4)).
comio(timon, cucaracha(gimeno,12,8)).
comio(timon, cucaracha(cucurucha,12,5)).
comio(simba, vaquitaSanAntonio(remeditos,4)).
comio(simba, hormiga(schwartzenegger)).
comio(simba, hormiga(niato)).
comio(simba, hormiga(lula)).
pesoHormiga(2).
%peso(Personaje, Peso)
peso(pumba, 100).
peso(timon, 50).
peso(simba, 200).

% Punto 1
% a

esJugosita(Cucaracha):-
    comio(_, Cucaracha),
    comio(_, Cucaracha2),
    Cucaracha\=Cucaracha2,
    tamanio(Cucaracha,Tam),
    pesoTam(Tam,Cucaracha,Peso1),
    pesoTam(Tam,Cucaracha2,Peso2),
    Peso1>Peso2.

tamanio(cucaracha(_,Tam,_),Tam).
pesoTam(Tam,cucaracha(_,Tam,Peso),Peso).

% b
hormigofilico(Personaje):-
    comio(Personaje, hormiga(_)),
    findall(Hormigas, comio(Personaje, hormiga(_)), ListaHormigas),
    length(ListaHormigas, CantidadHormigas),
    CantidadHormigas >= 2.

% c
cucarachofobico(Personaje):-
    comio(Personaje,_),
    not(comio(Personaje,cucaracha(_,_,_))).

% d
picarones(ListaPersonajes):-
    findall(Personaje, esPicaron(Personaje), ListaPersonajes).

esPicaron(pumba).
esPicaron(Personaje):-
    comio(Personaje, Cucaracha),
    esJugosita(Cucaracha).
esPicaron(Personaje):-
    comio(Personaje, vaquitaSanAntonio(remeditos,4)).

% Punto 2
persigue(scar, timon).
persigue(scar, pumba).
persigue(shenzi, simba).
persigue(shenzi, scar).
persigue(banzai, timon).

comio(shenzi,hormiga(conCaraDeSimba)).

peso(scar, 300).
peso(shenzi, 400).
peso(banzai, 500).

% a
cuantoEngorda(Personaje, Peso):-
    findall(Bichos, comio(Personaje, Bicho),)

    % QUE PARCIAL DE MIERRRRRRDA