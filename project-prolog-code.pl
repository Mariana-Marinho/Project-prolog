% Fatos

homem(guy).
homem(lombardo).
homem(guyjr).
homem(lombardojr).
mulher(olivia).
mulher(rubia).
pai_biologico(lombardo, guy).
pai_biologico(guy, guyjr).
pai_biologico(lombardo, lombardojr).
mae_biologica(olivia, rubia).
mae_biologica(olivia, guyjr).
mae_biologica(rubia, lombardojr).
casal(guy, olivia).
casal(lombardo, rubia).


% Regras

mae(X, Y) :- mulher(X), ((casal(P, X), pai_biologico(P, Y)); mae_biologica(X, Y)).
pai(X, Y) :- homem(X), ((casal(X, M), mae_biologica(M, Y)); pai_biologico(X, Y)).
avó(X, Z) :- mae(X, Y), (pai(Y, Z); mae(Y, Z)).
avô(X, Z) :- pai(X, Y), (pai(Y, Z); mae(Y, Z)).
filho(X, Y) :- homem(X), (pai(Y, X); mae(Y, X)).
filha(X, Y) :- mulher(X), (pai(Y, X); mae(Y, X)).
marido(X, Y) :- homem(X), casal(X, Y).
esposa(X, Y) :- mulher(X), casal(Y, X).
conjuge(X, Y) :- casal(X, Y); casal(Y, X).
irmaos(X, Y) :- (pai(P, X), pai(P, Y), X \= Y); (mae(M, X), mae(M, Y), X \= Y).
genro(X, Y) :- homem(X), conjuge(X, Z), (pai(Y, Z); mae(Y, Z)).
nora(X, Y) :- mulher(X), conjuge(X, Z), (pai(Y, Z); mae(Y, Z)).
sogro(X, Y) :- homem(X), (genro(Y, X); nora(Y, X)).
sogra(X, Y) :- mulher(X), (genro(Y, X); nora(Y, X)).
cunhado(X, Y) :- homem(X), irmaos(X, Z), conjuge(Y, Z).
cunhada(X, Y) :- mulher(X), irmaos(X, Z), conjuge(Y, Z).
tio(X, Y) :- homem(X), irmaos(X, Z), (pai(Z, Y); mae(Z, Y)).
tia(X, Y) :- mulher(X), irmaos(X, Z), (pai(Z, Y); mae(Z, Y)).
neto(X, Y) :- homem(X), (avô(Y, X); avó(Y, X)).
neta(X, Y) :- mulher(X), (avô(Y, X); avó(Y, X)).
madrasta(X, Z) :- mulher(X), casal(Y, X), pai_biologico(Y, Z), not(mae_biologica(X, Z)).
padrasto(Y, Z) :- homem(Y), casal(Y, X), mae_biologica(X, Z), not(pai_biologico(Y, Z)).


% Perguntas

?- avô(guy, guy).
?-filha(rubia, guy), mae(rubia, guy), irmaos(rubia, guyjr).
?- neto(lombardojr, guy), irmaos(lombardojr, guy), tio(lombardojr, rubia).
?- sogro(guy, lombardo), genro(lombardo, guy).
?- esposa(rubia, lombardo).
?- pai(guy, guyjr).
?- cunhado(guyjr, lombardo).
?- tio(guyjr, guy).
?- padrasto(guy, rubia).