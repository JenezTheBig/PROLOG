# Programação em Lógica com Prolog: Fundamentos e Aplicações
Alunos: Emerson Consta, Rafael Carvalho, Vinicius Almeida <br>
Disciplina: Introdução a Lógica <br>
Professora: Érica Carvalho <br>
Universidade Federal de São João del Rei <br>

## O que é Prolog? 
- Linguagem de programação Lógica
- Baseada em fatos, regras e inferência
- Muito utilizada em IA, sistemas especialistas e NLP`s (Processamento de Linguagem Natural)
-  O nome "Prolog" vem de "Programming in Logic"

## Módulos

|Nível 1|Nível 2|Nível 3|
|:-----:|:-----:|:-----:|
|Consultor de Cardápio|Consultor de Rotas Aéreas|Sistema de diagnóstico de Redes Domésticas|
|Fácil|Intermediário|Difícil|
|Fatos e regras básicas|Inferência Lógica com recursão ou listas|Desenvolvimento de sistema especialista|


## Nível 1 - [Consultor de Cardápios](/Nivel1.pl)

### Objetivos
- Implementar 10 fatos; 
- Criar 3 regras;
- Executar 3 consultas;

### Fatos
Fatos definem itens no cardápio e seguem o seguinte modelo:
```prolog
    item(Nome, Tipo, Categoria).
    item(feijoada, prato_principal, brasileira).
    item(sushi, prato_princiapl, japones).
    item(pudim, sobremesa, doce).
```

## Regras
<br>

### Regra 1
A regra 1 serve para buscar os pratos princiapis de cada culinária
```prolog
    prato_principal_da_culinaria(Prato, Culinaria) :-
    item(Prato, prato_princiapl, Culinaria)
```

'prato_principal_da_culinaria(Prato, Culinaria)' é verdadeiro SE existir um 'item(Prato, prato_principal, Culinaria)'.

### Regra 2

```prolog
sobremesa_disponivel(Sobremesa) :-
    item(Sobremesa, sobremesa, _).
```

'sobremesa_disponivel(Sobremesa)' é verdadeiro SE existir um 'item(Sobremesa, sobremesa, _ )', onde '_' é uma variável anônima.

### Regra 3

```prolog
bebida_nao_alcoolica(Bebida) :-
    item(Bebida, bebida, nao_alcoolica).
```
'bebida_nao_alcoolica(Bebida)' é verdadeiro SE existir um 'item(Bebida, bebida, nao_alcoolica)'.

## Nível 2 - [Consultor de Rotas Aéreas](/Nivel2.pl)

### Objetivos
- Criar 3 regras recursivas ou envolvendo listas.
- Utilizar consultas com múltiplas soluções ou com encademento lógico.

### Fatos
No casao do nível 2 definem as conexões aéreas diretas entre cidades. Cada um é uma rota direta de uma cidade de origem para uma cidade destino.
```prolog
    voo_direto(CidadeO, CidadeD).
    voo_direto(sao_paulo, rio_de_janeiro).
    voo_direto(rio_de_janeiro, brasilia).
    voo_direto(brasilia, salvador).
```

## Regras
<br>

### Regra 1
Determina se existe rota direta ou com conexões entre duas cidades.

```prolog
    rota(Origem, Destino) :-
    voo_direto(Origem, Destino). 
rota(Origem, Destino) :-
    voo_direto(Origem, CidadeIntermediaria), 
    rota(CidadeIntermediaria, Destino).
```

Lógica: Esta regra possui um caso base onde verifica se há um voo direto. O passo recursivo procura por uma CidadeIntermediaria e então chama a si mesma para encontrar uma rota da cidade intermediária até o destino, permitindo múltiplos voos conectados


### Regra 2
Encontra um caminho completo (lista de cidades) entre a origem e o destino.

```prolog
caminho(Origem, Destino, [Origem, Destino]) :-
    voo_direto(Origem, Destino). 
caminho(Origem, Destino, [Origem | RestoCaminho]) :-
    voo_direto(Origem, CidadeIntermediaria),
    caminho(CidadeIntermediaria, Destino, RestoCaminho).
```

Lógica: O caso base forma uma lista [Origem, Destino] para voos diretos. O passo recursivo constrói a lista do caminho, adicionando a Origem à frente do RestoCaminho encontrado recursivamente a partir de uma CidadeIntermediaria.


### Regra 3
Encontra um caminho que evita passar por uma cidade específica

```prolog
rota_evitando(Origem, Destino, CidadeEvitada, [Origem, Destino]) :-
    voo_direto(Origem, Destino),
    Origem \= CidadeEvitada,
    Destino \= CidadeEvitada.
rota_evitando(Origem, Destino, CidadeEvitada, [Origem | Resto]) :-
    voo_direto(Origem, Intermediaria),
    Intermediaria \= CidadeEvitada,
    rota_evitando(Intermediaria, Destino, CidadeEvitada, Resto).
```
Lógica: Esta regra utiliza o operador \= para garantir que nem a Origem, nem o Destino, nem qualquer Intermediaria sejam a CidadeEvitada durante a busca recursiva da rota.


## Nível 3 - [Diagnóstico Básico de Falhas em Redes Domésticas](/Nivel3.pl)

### Objetivos
- Criar mínimo de 5 regras de decisão (if-then).
- Utilizar encademaento lógico de condições.
- Simular iteraçao com user via Q&A
- Apresentar 3 exemplos diferentes de execução

### Flwxo Principal
O diagnóstico começa com diagnosticar_rede/0, que dá as boas-vindas ao usuário e coleta o sintoma principal. Em seguida,    iniciar_diagnostico/1 direciona para o fluxo de diagnóstico específico com base no sintoma informado:

```prolog
    diagnosticar_rede :-
    writeln('Olá! Vou te ajudar a diagnosticar problemas na sua rede doméstica.'),
    writeln('Diga qual o problema principal: sem_internet, wi_fi_lento ou nenhum_problema.'),
    writeln('Digite o nome exatamente como está, seguido de ponto final.'),
    read(Sintoma),
    iniciar_diagnostico(Sintoma).

% Decide o fluxo com base no sintoma informado
iniciar_diagnostico(sem_internet) :-
    writeln('Vamos analisar a falta de conexão com a internet.'),
    pergunta_luzes_modem.
iniciar_diagnostico(wi_fi_lento) :-
    writeln('Vamos investigar a lentidão do Wi-Fi.'),
    pergunta_interferencia_wi_fi.
iniciar_diagnostico(nenhum_problema) :-
    writeln('Ótimo! Sem problemas detectados.').
iniciar_diagnostico(_) :-
    writeln('Sintoma não reconhecido. Tente: sem_internet, wi_fi_lento ou nenhum_problema.').
```
O sistema possui dois fluxos principais de diagnóstica, cada um com suas prórpias perguntas e recomendações"

1 - sem_internet.

    - Verifica o estado das luzes do modem/roteadro.
    - Testa a conexão em outros dispositivos,
    - Recomenda ações específicas com base nas respostas.

2 - wi_fi_lento. 

    - Verifica presença de interferências físicas.
    - Avalia o número de dispositivos conectados à rede.
    - Fornece recomendações para melhorar a velocidade do Wi-Fi.

## Mecanismo de Inferência:

### Encadeamento Lógico de Condições :

### Operador Condicional (->) : 
É o coração do sistema. Ele implementa as regras "se-então" (if-then). Por exemplo:

```prolog 
Condição -> Ação_Se_Verdadeiro ; Ação_Se_Falso     
``` 
Permite que o sistema avalie a resposta do usuário e prossiga para a ação ou meta correspondente.
<br>

### Recursão para Validação:
Para garantir a validade das respostas, o sistema usa recursão. Se uma resposta inválida (que não seja "sim" ou "não") for fornecida, a pergunta é repetida até que uma entrada válida seja recebida, garantindo consistência dos dados.

### Padrões de Encadeamento:
 O diagnóstico é guiado por uma sequência lógica de perguntas e verificações. Cada resposta do usuário determina o próximo passo na cadeia de inferência, levando a um diagnóstico e recomendação específica.

 ```prolog
 pergunta_luzes_modem :-
    writeln('As luzes do seu modem/roteador estão acesas e estáveis? (sim/nao)'),
    read(Resposta),
    (   Resposta == sim
    ->  writeln('Tudo certo com o aparelho. Vamos ver se o problema é no provedor.'),
        pergunta_conectar_outros_dispositivos
    ;   Resposta == nao
    ->  writeln('Pode ser problema físico ou de energia.'),
        recomendar_verificar_cabos_reiniciar
    ;   writeln('Responda com "sim." ou "nao."'),
        pergunta_luzes_modem
    ).
 ```
