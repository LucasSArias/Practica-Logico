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
esPlatense(asimov). % Tengo que poner que artistas son platenses

esRioplatense(UnaObra):-
    escribio(UnArtista, UnaObra),
    esPlatense(UnArtista).

