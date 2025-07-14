% Alunos: Emerson Costa, Rafael Carvalho, Vinicius Almeida
% Tema: Diagnóstico Básico de Falhas em Redes Domésticas

% Início do diagnóstico
% Dá as boas-vindas, orienta o usuário e coleta o sintoma principal.
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

% --- Fluxo para o problema "sem_internet" ---

% Verifica se o modem/roteador está com luzes normais
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

% Verifica se outros dispositivos conseguem se conectar
pergunta_conectar_outros_dispositivos :-
    writeln('Outros aparelhos conseguem se conectar à internet? (sim/nao)'),
    read(Resposta),
    (   Resposta == sim
    ->  recomendar_problema_dispositivo_especifico
    ;   Resposta == nao
    ->  writeln('Parece um problema geral na rede.'),
        pergunta_ping_provedor
    ;   writeln('Responda com "sim." ou "nao."'),
        pergunta_conectar_outros_dispositivos
    ).

% Simula teste de conexão externa
pergunta_ping_provedor :-
    writeln('Você tentou reiniciar o modem/roteador e esperar 5 minutos? (sim/nao)'),
    read(RespostaReiniciar),
    (   RespostaReiniciar == sim
    ->  writeln('Se já tentou isso e não resolveu...'),
        writeln('Pode ser falha do provedor.'),
        recomendar_contatar_provedor
    ;   RespostaReiniciar == nao
    ->  writeln('Reinicie o modem e teste novamente.'),
        recomendar_reiniciar_e_testar
    ;   writeln('Responda com "sim." ou "nao."'),
        pergunta_ping_provedor
    ).

% --- Fluxo para o problema "wi_fi_lento" ---

% Verifica se há obstáculos atrapalhando o sinal
pergunta_interferencia_wi_fi :-
    writeln('Há muitos obstáculos entre seu dispositivo e o roteador? (sim/nao)'),
    read(Resposta),
    (   Resposta == sim
    ->  writeln('Isso pode afetar bastante o sinal.'),
        recomendar_otimizar_posicao_roteador
    ;   Resposta == nao
    ->  writeln('Vamos checar outros fatores.'),
        pergunta_muitos_dispositivos
    ;   writeln('Responda com "sim." ou "nao."'),
        pergunta_interferencia_wi_fi
    ).

% Verifica se a rede está sobrecarregada
pergunta_muitos_dispositivos :-
    writeln('Há muitos aparelhos usando a rede ao mesmo tempo? (sim/nao)'),
    read(Resposta),
    (   Resposta == sim
    ->  recomendar_limitar_uso_ou_upgrade
    ;   Resposta == nao
    ->  recomendar_verificar_atualizacoes_firmware
    ;   writeln('Responda com "sim." ou "nao."'),
        pergunta_muitos_dispositivos
    ).

% --- Recomendações finais ---

recomendar_verificar_cabos_reiniciar :-
    writeln('SUGESTÃO: Verifique se os cabos estão bem conectados e reinicie o modem.').

recomendar_problema_dispositivo_especifico :-
    writeln('SUGESTÃO: O problema pode estar no seu aparelho. Tente reiniciá-lo ou ajustar as configurações de rede.').

recomendar_contatar_provedor :-
    writeln('SUGESTÃO: Entre em contato com seu provedor de internet.').

recomendar_reiniciar_e_testar :-
    writeln('SUGESTÃO: Reinicie seu modem. Desligue por 1 minuto e ligue novamente.').

recomendar_otimizar_posicao_roteador :-
    writeln('SUGESTÃO: Mude o roteador para um lugar mais aberto e central, ou aproxime o dispositivo.').

recomendar_limitar_uso_ou_upgrade :-
    writeln('SUGESTÃO: Reduza o número de dispositivos conectados ou pense em melhorar seu plano/roteador.').

recomendar_verificar_atualizacoes_firmware :-
    writeln('SUGESTÃO: Verifique se há atualizações de firmware no roteador ou, se necessário, faça um reset de fábrica.').

% Dica inicial para o usuário
ajuda :-
    writeln('Digite: diagnosticar_rede. para iniciar.').
