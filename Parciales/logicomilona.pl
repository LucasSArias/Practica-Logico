% receta(Plato, Duración, Ingredientes)
receta(empanadaDeCarneFrita, 20, [harina, carne, cebolla, picante, aceite]).
receta(empanadaDeCarneAlHorno, 20, [harina, carne, cebolla, picante]).
receta(lomoALaWellington, 125, [lomo, hojaldre, huevo, mostaza]).
receta(pastaTrufada, 40, [spaghetti, crema, trufa]).
receta(souffleDeQueso, 35, [harina, manteca, leche, queso]).
receta(tiramisu, 30, [vainillas, cafe, mascarpone]).
receta(rabas, 20, [calamar, harina, sal]).
receta(parrilladaDelMar, 40, [salmon, langostinos, mejillones]).
receta(sushi, 30, [arroz, salmon, sesamo, algaNori]).
receta(hamburguesa, 15, [carne, pan, cheddar, huevo, panceta, trufa]).
receta(padThai, 40, [fideos, langostinos, vegetales]).

% elabora(Chef, Plato)
elabora(guille, empanadaDeCarneFrita).
elabora(guille, empanadaDeCarneAlHorno).
elabora(vale, rabas).
elabora(vale, tiramisu).
elabora(vale, parrilladaDelMar).
elabora(ale, hamburguesa).
elabora(lu, sushi).
elabora(mar, padThai).

% cocinaEn(Restaurante, Chef)
cocinaEn(pinpun, guille).
cocinaEn(laPececita, vale).
cocinaEn(laParolacha, vale).
cocinaEn(sushiRock, lu).
cocinaEn(olakease, lu).
cocinaEn(guendis, ale).
cocinaEn(cantin, mar).
% tieneEstilo(Restaurante, Estilo)
tieneEstilo(pinpun, bodegon(parqueChas, 6000)).
tieneEstilo(laPececita, bodegon(palermo, 20000)).
tieneEstilo(laParolacha, italiano(15)).
tieneEstilo(sushiRock, oriental(japon)).
tieneEstilo(olakease, oriental(japon)).
tieneEstilo(cantin, oriental(tailandia)).
tieneEstilo(cajaTaco, mexicano([habanero, rocoto])).
tieneEstilo(guendis, comidaRapida(5)).

% italiano(CantidadDePastas)
% oriental(País)
% bodegon(Barrio, PrecioPromedio)
% mexicano(VariedadDeAjies)
% comidaRapida(cantidadDeCombos)

% Punto 1
esCrack(Chef):-
    lugaresEnQueTrabaja(Chef, Cantidad),
    Cantidad > 2.
esCrack(Chef):-
    elabora(Chef, padThai).

lugaresEnQueTrabaja(Chef, Cantidad):-
    cocinaEn(_,Chef),
    findall(Restaurante, cocinaEn(Restaurante, Chef), Restaurantes),
    length(Restaurantes, Cantidad).

% Punto 2
esOtaku(Chef):-
    cocinaEn(_,Chef),
    forall(cocinaEn(UnRestaurante, Chef), esDeComidaJaponesa(UnRestaurante)).

esDeComidaJaponesa(Restaurante):-
    tieneEstilo(Restaurante, oriental(japon)).

% Punto 3
esTop(Plato):-
    elabora(Chef, Plato),
    esCrack(Chef).

% Punto 4
esDificil(souffleDeQueso).
esDificil(Plato):-
    duracion(Plato, Duracion),
    Duracion > 120.
esDificil(Plato):-
    tiene(Plato, trufa).

duracion(Plato, Duracion):-
    receta(Plato, Duracion,_).
tiene(Plato, UnIngrediente):-
    receta(Plato,_,Ingredientes),
    member(UnIngrediente, Ingredientes).

% Punto 5
seMereceLaMichelin(Restaurante):-
    tieneChefCrack(Restaurante),
    tieneEstiloMichelinero(Restaurante).

tieneChefCrack(Restaurante):-
    cocinaEn(Restaurante, Chef),
    esCrack(Chef).

tieneEstiloMichelinero(Restaurante):-
    tieneEstilo(Restaurante, Estilo),
    esEstiloMichelinero(Estilo).

esEstiloMichelinero(oriental(tailandia)).
esEstiloMichelinero(bodegon(palermo,_)).
esEstiloMichelinero(italiano(CantidadDePastas)):-
    CantidadDePastas > 5.
esEstiloMichelinero(mexicano(Ajies)):-
    sonIngredientesUsados([aji, habanero, rocoto], Ajies).
% no hace falta agregar una regla para aclarar que los restaurantes de comida rapida no son michelineros, ya que por el principio de universo cerrado, si en ningun momento se aclara que un restaurante de comida rapida es michelinero, es porque el mismo no lo es.

sonIngredientesUsados(UnosIngredientes, IngredientesDeUnRestaurante):-
    forall(member(UnIngrediente, UnosIngredientes), member(UnIngrediente, IngredientesDeUnRestaurante)).
    

% Punto 6
tieneMayorRepertorio(RestauranteMayorRepertorio, RestauranteMenorRepertorio):-
    cocinaEn(RestauranteMayorRepertorio, ChefDeMasPlatos),
    cocinaEn(RestauranteMenorRepertorio, ChefDeMenosPlatos),
    elaboraMasPlatos(ChefDeMasPlatos, ChefDeMenosPlatos).

elaboraMasPlatos(ChefDeMasPlatos, ChefDeMenosPlatos):-
    platosElaborados(ChefDeMasPlatos, CantidadMayor),
    platosElaborados(ChefDeMenosPlatos, CantidadMenor),
    CantidadMayor > CantidadMenor.

platosElaborados(Chef, CantidadDePlatos):-
    elabora(Chef,_),
    findall(Plato, elabora(Chef, Plato), Platos),
    length(Platos, CantidadDePlatos).

% Punto 7
calificacionGastronomica(Restaurante, Calificacion):-
    cocinaEn(Restaurante, UnChef),
    platosElaborados(UnChef, CantidadDePlatos),
    Calificacion is 5 * CantidadDePlatos.
    