
% Alunos: [Emerson Costa, Rafael Carvalho Vinicius Almeida]
% Tema: Consultor de Cardápios

% Fatos:
% Definem os itens do cardápio e suas categorias.
% Cada fato 'item' representa um item com seu nome, tipo e uma categoria mais específica.
% Sintaxe: item(NomeDoItem, Tipo, Categoria).

item(feijoada, prato_principal, brasileira).
item(pizza, prato_principal, italiana).
item(sushi, prato_principal, japonesa).
item(carbonara, prato_principal, italiana).
item(churrasco, prato_principal, brasileira).
item(pudim, sobremesa, doce).
item(tiramisu, sobremesa, doce).
item(brigadeiro, sobremesa, doce).
item(suco_laranja, bebida, nao_alcoolica).
item(agua_coco, bebida, nao_alcoolica).

% Regras:
% Definem como consultar os fatos de forma mais genérica, utilizando condicionais.
% O símbolo ':-' pode ser lido como "se".

% 1. Regra para encontrar pratos principais de uma culinária específica:
% 'prato_principal_da_culinaria(Prato, Culinaria)' é verdadeiro SE
% existir um 'item(Prato, prato_principal, Culinaria)'.

prato_principal_da_culinaria(Prato, Culinaria) :-
    item(Prato, prato_principal, Culinaria).

% 2. Regra para encontrar sobremesas disponíveis:
% 'sobremesa_disponivel(Sobremesa)' é verdadeiro SE
% existir um 'item(Sobremesa, sobremesa, _)', onde '_' é uma variável anônima.

sobremesa_disponivel(Sobremesa) :-
    item(Sobremesa, sobremesa, _).

% 3. Regra para encontrar bebidas não alcoólicas:
% 'bebida_nao_alcoolica(Bebida)' é verdadeiro SE
% existir um 'item(Bebida, bebida, nao_alcoolica)'.

bebida_nao_alcoolica(Bebida) :-
    item(Bebida, bebida, nao_alcoolica).

% Consultas
% ?- prato_principal_da_culinaria(X, brasileira).
% ?- sobremesa_disponivel(X).
% ?- bebida_nao_alcoolica(X).