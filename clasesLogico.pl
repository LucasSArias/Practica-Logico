/*Clase 24/6*/
escribio(brandonSanderson, mistborn1).
escribio(hermanHess,demian).
escribio(richie, lenguajeC).
escribio(nik, gaturro18).
escribio(stephenKing, it).
escribio(stephenKing, misery).
escribio(asimov, laUltimaPregunta).

esComic(spiderman).
esComic(sandman).
esComic(onePiece).
esComic(gaturro18).

esArtistaDelNovenoArte(UnArtista) :-
    escribio(UnaObra, UnArtista),
    esComic(UnaObra).

copiasVendidas(mistborn1, 1000001).
copiasVendidas(demian, 4).
copiasVendidas(lenguajeC, 0).
copiasVendidas(gaturro18, 18).
copiasVendidas(it, 4000000).

esBestSeller(UnaObra) :-
    copiasVendidas(UnaObra, Cantidad),
    Cantidad >= 50000.
 
 esReincidente(UnAutor) :-
    escribio(UnAutor, UnaObra),
    escribio(UnAutor, OtraObra),
    UnaObra \= OtraObra.

convieneContratar(UnAutor) :- %cuando es reincidente o escribió un bestSeller
    esReincidente(UnAutor).
convieneContratar(UnAutor) :-
    escribio(UnAutor, UnaObra),
    esBestSeller(UnaObra).

leGustaAGus(sandman).   % A gus le gusta todo lo que escribio Asimov y Sandman
leGustaAGus(UnaObra) :- 
    escribio(asimov, Unaobra).

esLibro(UnaObra) :- % Cuando fue escrito pero no es comic
    escribio(_, UnaObra),
    not(esComic(UnaObra)).

/*
Teniendo en cuenta la base de conocimientos que vimos en clase, traer resuelto para la clase que viene el siguiente pedido: Queremos saber si una obra es rioplatense, que es cuando la nacionalidad de su artista es platense (Uruguay o Argentina).
*/
nacionalidad(nik, argentina).

esNacionalidadPlatense(argentina).
esNacionalidadPlatense(uruguaya).

esRioplatense(UnaObra):-
    escribio(UnArtista, UnaObra),
    nacionalidad(UnArtista, Nacionalidad),
    esNacionalidadPlatense(Nacionalidad).

escribioSoloComics(UnAutor):-
    escribio(UnAutor, _),
    forall(escribio(UnAutor,UnaObra),esComic(UnaObra)).
    
% FUNCTORES (individuos compuestos)

% novela(Tema, CantidadDeCapitulos)
% libroDeCuentos(CantidadDeCuentos)
% libroCientifico(Disciplina)
% bestSeller(Precio, cantidadDePaginas)

esDeGenero(it, novela(terror,11)).
esDeGenero(ficciones, libroDeCuentos(17)).
esDeGenero(lenguajeC, libroCientifico(programacion)).
esDeGenero(harryPotter4, bestSeller(32000, 636)).

% Una obra esta buena si es policial y tiene menos de 12 capitulos. Si es de terror siempre está buena. Los libros con más de 10 cuentos siempre son buenos. Si es una obra cientifica de fisica cuantica siempre esta buena. Si es un bestseller y el precio por pagina es menor a 50 siempre esta buena.



estaBuena(UnaObra):-
    esDeGenero(UnaObra,UnGenero),
    esBuenGenero(UnGenero).

esBuenGenero(novela(policial,Capitulos)):-
    Capitulos < 12.
esBuenGenero(novela(terror,_)).
esBuenGenero(libroDeCuentos(Cuentos)):-
    Cuentos > 10.
esBuenGenero(libroCientifico(fisicaCuantica)).
esBuenGenero(bestSeller(Precio,CantidadDePaginas)):-
    CantidadDePaginas/Precio > 50.









