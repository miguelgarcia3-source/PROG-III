% -----------Ejercicio 1: Sin Caso Recursivo-----------

conexion1(vancouver, calgary, 675).
conexion1(calgary, regina, 758).
conexion1(regina, winnipeg, 573).
conexion1(winnipeg, toronto, 1372).
conexion1(toronto, montreal, 541).
conexion1(montreal, halifax, 1245).
conexion1(saskatoon, calgary, 525).
conexion1(saskatoon, regina, 262).
conexion1(edmonton, calgary, 299).
conexion1(edmonton, saskatoon, 525).

conexion1(X, Y, C) :- conexion1(Y, X, C).

tiene_aristas1(Ciudad) :-
    conexion1(Ciudad, _, _).

conexiones1(Ciudad) :-
    conexion1(Ciudad, Otra, Costo),
    format('~w -> ~w : ~w km~n', [Ciudad, Otra, Costo]),
    fail.
conexiones1(_).

conexion_directa1(C1, C2, Costo) :-
    conexion1(C1, C2, Costo).

costo_por1(C1, C2, C3, Total) :-
    conexion1(C1, C2, Costo1),
    conexion1(C2, C3, Costo2),
    Total is Costo1 + Costo2.

ruta1(Inicio, Destino, Camino, Costo) :-
    ruta_aux1(Inicio, Destino, [Inicio], CaminoInvertido, 0, Costo),
    reverse(CaminoInvertido, Camino).

ruta_aux1(Destino, Destino, Camino, Camino, Costo, Costo).
ruta_aux1(Actual, Destino, Visitadas, Camino, CostoAcc, Costo) :-
    conexion1(Actual, Siguiente, Costo1),
    \+ member(Siguiente, Visitadas),
    NuevoCosto is CostoAcc + Costo1,
    ruta_aux1(Siguiente, Destino, [Siguiente|Visitadas], Camino, NuevoCosto, Costo).


% -----------Ejercicio 2: Con Caso Recursivo-----------

arista2(vancouver, edmonton, 16).
arista2(vancouver, calgary, 13).
arista2(edmonton, saskatoon, 12).
arista2(saskatoon, winnipeg, 20).
arista2(calgary, regina, 14).
arista2(regina, winnipeg, 4).
arista2(edmonton, calgary, 4).
arista2(saskatoon, regina, 9).

conexion2(X, Y, C) :- arista2(X, Y, C).
conexion2(X, Y, C) :- arista2(Y, X, C).

tiene_aristas2(N) :- conexion2(N, _, _).

costo2(X, Y, Z, Costo) :-
    conexion2(X, Y, C1),
    conexion2(Y, Z, C2),
    Costo is C1 + C2.

viaje2(X, Y, Costo, [X,Y]) :-
    conexion2(X, Y, Costo).

viaje2(X, Z, Costo, [X|Ruta]) :-
    conexion2(X, Y, C1),
    X \= Z,
    \+ member(X, Ruta), 
    viaje2(Y, Z, C2, Ruta),
    Costo is C1 + C2.
