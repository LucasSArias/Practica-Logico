/*Clase 24/6*/
escribio(brandonSanderson, mistborn1).
escribio(hermanHess,demian).
escribio(richie, lenguajeC).
escribio(nik, gaturro18).
escribio(stephenKing, it).
escribio(stephenKing, misery).

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
