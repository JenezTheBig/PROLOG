% Alunos: Emerson Costa, Rafael Carvalho, Vinicius Almeidas
% Tema: Sistema de Rastreio de Rotas Aéreas

% Fatos: voos diretos entre cidades
voo_direto(sao_paulo, rio_de_janeiro).
voo_direto(rio_de_janeiro, brasilia).
voo_direto(brasilia, salvador).
voo_direto(sao_paulo, belo_horizonte).
voo_direto(belo_horizonte, vitoria).
voo_direto(vitoria, salvador).
voo_direto(salvador, fortaleza).
voo_direto(rio_de_janeiro, curitiba).
voo_direto(curitiba, porto_alegre).
voo_direto(fortaleza, manaus).
voo_direto(manaus, belem).
voo_direto(porto_alegre, florianopolis).

% -------- Regras --------

% rota(Origem, Destino)
% Verifica se há uma rota entre duas cidades (direta ou com conexões).
rota(Origem, Destino) :-
    voo_direto(Origem, Destino). % Direto

rota(Origem, Destino) :-
    voo_direto(Origem, Intermediaria), % Conexão
    rota(Intermediaria, Destino).

% caminho(Origem, Destino, Caminho)
% Retorna o caminho completo (lista de cidades) entre Origem e Destino.
caminho(Origem, Destino, [Origem, Destino]) :-
    voo_direto(Origem, Destino). % Direto

caminho(Origem, Destino, [Origem | Resto]) :-
    voo_direto(Origem, Intermediaria),
    caminho(Intermediaria, Destino, Resto). % Conexão

% rota_evitando(Origem, Destino, CidadeEvitada, Caminho)
% Encontra um caminho entre duas cidades evitando passar por uma específica.
rota_evitando(Origem, Destino, CidadeEvitada, [Origem, Destino]) :-
    voo_direto(Origem, Destino),
    Origem \= CidadeEvitada,
    Destino \= CidadeEvitada.

rota_evitando(Origem, Destino, CidadeEvitada, [Origem | Resto]) :-
    voo_direto(Origem, Intermediaria),
    Intermediaria \= CidadeEvitada,
    rota_evitando(Intermediaria, Destino, CidadeEvitada, Resto).

% membro(X, Lista)
% Verifica se X está na lista.
membro(X, [X|_]).
membro(X, [_|T]) :- membro(X, T).

% Exemplos de uso:
% ?- rota(sao_paulo, fortaleza).
% ?- caminho(sao_paulo, salvador, C).
% ?- rota_evitando(sao_paulo, salvador, rio_de_janeiro, C).
