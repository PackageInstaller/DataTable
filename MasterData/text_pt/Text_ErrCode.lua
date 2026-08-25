__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_ErrCode = readonly({
  ErrCode_CMD_UNDEFINED_Desc = {
    Text = "Comando não existe"
  },
  ErrCode_ERR_ACTIVITY_FINISH_Desc = {
    Text = "Evento encerrado"
  },
  ErrCode_ERR_ACTIVITY_LOGINDAILY_Desc = {
    Text = "Dias de login insuficientes para reivindicar recompensas"
  },
  ErrCode_ERR_ACTIVITY_NOT_CONDITION_Desc = {
    Text = "Condições para participar do evento não atendidas"
  },
  ErrCode_ERR_ACTIVITY_NOT_FIND_Desc = {
    Text = "Este evento não existe"
  },
  ErrCode_ERR_ACTIVITY_NOT_HANDLE_CLASS_Desc = {
    Text = "Evento ainda não desenvolvido"
  },
  ErrCode_ERR_ACTIVITY_NOT_OPEN_Desc = {
    Text = "O evento ainda não começou"
  },
  ErrCode_ERR_ACTIVITY_TASK_NOT_FINISH_Desc = {
    Text = "Missão do evento não concluída"
  },
  ErrCode_ERR_ACTIVITY_TRIALSTAGE_FAIL_Desc = {
    Text = "Evento de Demonstração: Recompensas não podem ser reclamadas por estágios incompletos."
  },
  ErrCode_ERR_ACTIVITY_TRIAL_NOT_STAGE_Desc = {
    Text = "Evento de Julgamento: Este nível não foi encontrado."
  },
  ErrCode_ERR_ASSISTED_ONCE_Desc = {
    Text = "O Guardião deste evento já lhe forneceu apoio uma vez."
  },
  ErrCode_ERR_ASSIST_NEED_FOLLOW_EACHOTHER_Desc = {
    Text = "Este evento requer atenção mútua entre os Guardiões para oferecer suporte."
  },
  ErrCode_ERR_ASSIST_STAR_LIMIT_Desc = {
    Text = "O número de Guardiões do Segredo de Apoio de batalha comum atingiu o limite, por favor, ajuste a lista de Apoio de batalha comum"
  },
  ErrCode_ERR_AWAKER_NOT_ARRIVED_LEVEL_Desc = {
    Text = "Condições para aprimoramento de habilidade não atendidas"
  },
  ErrCode_ERR_AWAKER_NOT_BREAKLEVEL_Desc = {
    Text = "Nível de despertador insuficiente para a ascensão"
  },
  ErrCode_ERR_AWAKER_START_DROP_DATE_Desc = {
    Text = "O Despertar ainda não alcançou o horário de abertura."
  },
  ErrCode_ERR_AWAKER_USED_Desc = {
    Text = "Despertar já foi utilizado"
  },
  ErrCode_ERR_AlREADY_BAN_Desc = {
    Text = "Não pode ser bloqueado novamente"
  },
  ErrCode_ERR_BANNED_Desc = {
    Text = "Você foi adicionado à lista negra do outro, não pode operar"
  },
  ErrCode_ERR_BANNED_FOLLOW_LIKE_Desc = {
    Text = "Você foi colocado na lista negra por este usuário e não pode segui-lo ou curtí-lo."
  },
  ErrCode_ERR_BAN_FOLLOW_LIKE_Desc = {
    Text = "Você colocou este usuário na lista negra e não pode curtir ou segui-lo."
  },
  ErrCode_ERR_BAN_NUM_LIMIT_Desc = {
    Text = "Limite da lista negra alcançado"
  },
  ErrCode_ERR_BATTLE_CREATE_FAILED_Desc = {
    Text = "Falha na Criação da Batalha"
  },
  ErrCode_ERR_BP_BUYLEVEL_NOT_ENOUGH_Desc = {
    Text = "Moeda insuficiente para comprar nível de Pass"
  },
  ErrCode_ERR_BP_FAIL_Desc = {
    Text = "Operação Falhou"
  },
  ErrCode_ERR_BP_NOT_CONFIG_PRIZE_Desc = {
    Text = "Preço do privilégio de compra do passe não configurado"
  },
  ErrCode_ERR_BP_PRIVILEGELEVEL_MAX_Desc = {
    Text = "O nível de privilégio Pass está no máximo, não podendo ser adquirido novamente."
  },
  ErrCode_ERR_BP_PRIVILEGE_LEVEL_NOT_ENOUGH_Desc = {
    Text = "Nível de privilégio insuficiente para reivindicar a recompensa"
  },
  ErrCode_ERR_BP_REWARD_NOT_EXISTS_Desc = {
    Text = "Recompensa não existe"
  },
  ErrCode_ERR_BP_REWARD_RECEIVED_Desc = {
    Text = "Recompensa Recebida"
  },
  ErrCode_ERR_BUY_TICKET_NO_MONEY_Desc = {
    Text = "Prata Prateada insuficiente"
  },
  ErrCode_ERR_BUY_TICKET_NO_TIMES_Desc = {
    Text = "Número de compras com comprovante insuficiente"
  },
  ErrCode_ERR_CANT_ENCHANCE_RELIC_Desc = {
    Text = "Relíquias não suportam fortalecimento."
  },
  ErrCode_ERR_CARD_MAX_LEVEL_Desc = {
    Text = "Este cartão atingiu o nível máximo e não pode ser fortalecido."
  },
  ErrCode_ERR_CARD_NOT_UPDRADE_Desc = {
    Text = "Este cartão não pode ser fortalecido"
  },
  ErrCode_ERR_CARD_REVIEW_CONTAINS_BLOCKED_WORD_Desc = {
    Text = "Contém palavras bloqueadas"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_COMMENT_Desc = {
    Text = "Repetir comentário"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_DELETE_Desc = {
    Text = "excluir repetidamente"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_LIKE_Desc = {
    Text = "Curtir novamente"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_UNLIKE_Desc = {
    Text = "Cancelar elogio repetido"
  },
  ErrCode_ERR_CARD_REVIEW_LENGTH_EXCEEDED_Desc = {
    Text = "Comprimento excede o limite"
  },
  ErrCode_ERR_CARD_REVIEW_LIKE_ALREADY_DELETED_Desc = {
    Text = "Comentário de elogio foi excluído"
  },
  ErrCode_ERR_CARD_REVIEW_TIMEOUT_Desc = {
    Text = "Tempo de comentário esgotado"
  },
  ErrCode_ERR_CARD_UPGRADE_NOT_NUMBER_Desc = {
    Text = "Sem tentativas para melhorar carta exclusiva"
  },
  ErrCode_ERR_CHALLENGE_NOT_FIND_PLOT_Desc = {
    Text = "Nenhuma linha de história de desafio de instância encontrada"
  },
  ErrCode_ERR_CHALLENGE_NOT_FIND_TASK_Desc = {
    Text = "Nenhuma linha de história de desafio de instância encontrada"
  },
  ErrCode_ERR_CHALLENGE_NOT_IN_STAGEGROUP_Desc = {
    Text = "Os dados do estágio do mergulho fantasmal estão sendo atualizados. Por favor, tente novamente mais tarde."
  },
  ErrCode_ERR_CHALLENGE_TASK_FINISH_Desc = {
    Text = "Desafio concluído, não é possível receber a recompensa novamente"
  },
  ErrCode_ERR_CHALLENGE_TASK_RUNING_Desc = {
    Text = "Desafio não concluído, não é possível receber a recompensa"
  },
  ErrCode_ERR_CHAPTER_PRIZE_CONDITION_Desc = {
    Text = "Recompensa do capítulo não atingiu a pontuação"
  },
  ErrCode_ERR_CHAPTER_PRIZE_FINISH_Desc = {
    Text = "Recompensa do capítulo recebida"
  },
  ErrCode_ERR_CHOOSE_GEAR_NOT_FIND_Desc = {
    Text = "Nó atual não encontrado"
  },
  ErrCode_ERR_CHREATE_ROLE_Desc = {
    Text = "Nome de personagem duplicado"
  },
  ErrCode_ERR_CLIENT_DATA_Desc = {
    Text = "Erro de dados recebidos pelo cliente"
  },
  ErrCode_ERR_CLOSE_GEAR_NOT_FIND_Desc = {
    Text = "Nó atual não encontrado. Impossível fechar."
  },
  ErrCode_ERR_CONFIG_Desc = {
    Text = "Erro na tabela de configuração"
  },
  ErrCode_ERR_COURSE_CREDIT_NOT_ENOUGH_Desc = {
    Text = "Incapaz de reivindicar recompensas"
  },
  ErrCode_ERR_COURSE_MODULE_NOT_FINISH_Desc = {
    Text = "Condições de recompensa ainda não cumpridas"
  },
  ErrCode_ERR_COURSE_NOT_BARRIES_DATA_Desc = {
    Text = "Nenhum dado de tarefa de nível disponível"
  },
  ErrCode_ERR_COURSE_NOT_FIND_COPIES_Desc = {
    Text = "Sem pontos para a missão desta instância"
  },
  ErrCode_ERR_COURSE_NOT_FIND_MODULE_Desc = {
    Text = "Módulo para o score do assunto não encontrado"
  },
  ErrCode_ERR_COURSE_NOT_FIND_TASK_Desc = {
    Text = "Nenhuma tarefa encontrada até agora"
  },
  ErrCode_ERR_COURSE_NOT_FIND_UNIT_Desc = {
    Text = "Nenhum dado de unidade encontrado para o tópico"
  },
  ErrCode_ERR_COURSE_PRIZE_Desc = {
    Text = "Módulo enviado, não precisa reenviar"
  },
  ErrCode_ERR_COURSE_TASK_CONDITION_NOT_FINISH_Desc = {
    Text = "Subtarefas da missão estão incompletas"
  },
  ErrCode_ERR_COURSE_TASK_FINISH_Desc = {
    Text = "Missão concluída"
  },
  ErrCode_ERR_COURSE_UNIT_NOT_FINISH_Desc = {
    Text = "Tarefas sob a unidade não foram totalmente concluídas e não podem ser submetidas."
  },
  ErrCode_ERR_CREATE_ROLE_CLOSE_Desc = {
    Text = "O registro de novos Guardiões está atualmente pausado."
  },
  ErrCode_ERR_CREATE_ROLE_Desc = {
    Text = "Nenhum personagem encontrado. Por favor, crie um."
  },
  ErrCode_ERR_CUSTOM_CMD_USE_LIMIT_Desc = {
    Text = "O uso de comandos personalizados alcançou o limite."
  },
  ErrCode_ERR_ENCHANCE_RELIC_EXIST_Desc = {
    Text = "A relíquia foi fortalecida."
  },
  ErrCode_ERR_ENERGY_STORE_MAX_Desc = {
    Text = "Menofim é suficiente, não precisa ser reabastecido"
  },
  ErrCode_ERR_ENHANCE_RELIC_Desc = {
    Text = "Sacrifícios não podem ser oferecidos neste momento."
  },
  ErrCode_ERR_EQUIP_NOT_FIND_Desc = {
    Text = "Acessório não existe"
  },
  ErrCode_ERR_EVENT_AREA_NOT_MATCH_Desc = {
    Text = "Erro na área do evento"
  },
  ErrCode_ERR_EVENT_CHOOSE_CARD_DATA_Desc = {
    Text = "O Cartão de Seleção de Evento não existe"
  },
  ErrCode_ERR_EVENT_CHOOSE_CARD_NUM_MAX_Desc = {
    Text = "Cartas de Evento demais"
  },
  ErrCode_ERR_EVENT_CHOOSE_RELIC_DATA_Desc = {
    Text = "Criação de evento selecionada não existe"
  },
  ErrCode_ERR_EVENT_CHOOSE_RELIC_NUM_MAX_Desc = {
    Text = "Relíquias demais selecionadas para o evento"
  },
  ErrCode_ERR_EVENT_CONFIG_NOTYPE_Desc = {
    Text = "Entrada de tipo de evento incorreta na tabela de configuração da masmorra"
  },
  ErrCode_ERR_EVENT_DATA_Desc = {
    Text = "Erro nos dados do evento"
  },
  ErrCode_ERR_EVENT_DROP_CARD_NO_REFRESH_NUM_Desc = {
    Text = "Os cartões de refresh de queda de batalha não têm limite de vezes."
  },
  ErrCode_ERR_EVENT_DROP_RELIC_NO_REFRESH_NUM_Desc = {
    Text = "Nenhum limite no número de vezes que os relíquias de batalha podem ser renovados"
  },
  ErrCode_ERR_EVENT_FINISH_Desc = {
    Text = "Evento completo"
  },
  ErrCode_ERR_EVENT_NOT_FIND_Desc = {
    Text = "Evento não existe no calabouço"
  },
  ErrCode_ERR_EVENT_NOT_MONEY_ENOUGT_Desc = {
    Text = "Mithril insuficiente. Incapaz de comprar."
  },
  ErrCode_ERR_EVENT_NOT_NODE_Desc = {
    Text = "Evento não encontrado neste nó"
  },
  ErrCode_ERR_EVENT_RANDOM_POND_Desc = {
    Text = "Nenhum dado no pool aleatório do Evento"
  },
  ErrCode_ERR_EVENT_REST_FUNCLOCK_Desc = {
    Text = "A função do ponto de união foi bloqueada"
  },
  ErrCode_ERR_EVENT_REST_FUNC_SELECT_Desc = {
    Text = "Função do acampamento já escolhida, não pode ser selecionada novamente"
  },
  ErrCode_ERR_EVENT_REST_NOT_USENUM_Desc = {
    Text = "Função do acampamento sem usos restantes"
  },
  ErrCode_ERR_EVENT_SHOP_NOT_REFRESH_NUM_Desc = {
    Text = "A loja de eventos é renovada sem limite de vezes."
  },
  ErrCode_ERR_EVENT_SHOP_NOT_REMOVECARD_Desc = {
    Text = "O número de vezes que a carta de comércio de evento foi deletado foi esgotado"
  },
  ErrCode_ERR_EVENT__CHOOSE_CARD_NUM_Desc = {
    Text = "Número insuficiente de Cartões de Evento selecionados"
  },
  ErrCode_ERR_EVENT__CHOOSE_RELIC_NUM_Desc = {
    Text = "Número insuficiente de criações de evento selecionadas"
  },
  ErrCode_ERR_EXCLUSIVECARD_CARD_CONFIG_NOT_FOUND_Desc = {
    Text = "Informação do cartão exclusivo não encontrada"
  },
  ErrCode_ERR_EXCLUSIVECARD_ROLE_NOT_FOUND_Desc = {
    Text = "Rota de upgrade sem ID de personagem"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_INVALID_Desc = {
    Text = "Carta exclusiva não desbloqueada"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_CHANGE_Desc = {
    Text = "Carta exclusiva sem mudanças, não pode trocar"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_SWITCH_Desc = {
    Text = "Falha ao trocar carta exclusiva"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_UPGRADE_SWITCH_Desc = {
    Text = "Carta exclusiva não melhorada, não pode trocar"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_UUID_NOT_FOUND_Desc = {
    Text = "UUID do cartão exclusivo não encontrado"
  },
  ErrCode_ERR_EXPIRED_SUPPORTLIST_Desc = {
    Text = "O Awakened Ally não está mais disponível. Atualize a lista de Awakened Allies e selecione novamente."
  },
  ErrCode_ERR_FACTORY_COMPOSE_ITEM_LOCK_Desc = {
    Text = "Item de síntese não desbloqueado"
  },
  ErrCode_ERR_FACTORY_COMPOSE_NOT_CURRENCY_Desc = {
    Text = "Faltam moedas necessárias para a combinação do item"
  },
  ErrCode_ERR_FACTORY_COMPOSE_NOT_ITEMS_Desc = {
    Text = "Faltam outros itens necessários para a combinação do item"
  },
  ErrCode_ERR_FACTORY_EXIST_Desc = {
    Text = "Construção já existe, não pode ser construída novamente"
  },
  ErrCode_ERR_FACTORY_HAVE_ACTOR_Desc = {
    Text = "Posição já ocupada por um Despertado, não pode ser usada"
  },
  ErrCode_ERR_FACTORY_MAX_LEVEL_Desc = {
    Text = "Construção atingiu o nível máximo"
  },
  ErrCode_ERR_FACTORY_NOT_EXIST_Desc = {
    Text = "Construção não existe"
  },
  ErrCode_ERR_FACTORY_UPGRADE_CONDITION_Desc = {
    Text = "Condições insuficientes para subir/construir edifício"
  },
  ErrCode_ERR_FACTORY_UPGRADE_ITEMS_Desc = {
    Text = "Materiais necessários para atualização/edificação insuficientes"
  },
  ErrCode_ERR_GAIN_BATTLE_PRIZE_Desc = {
    Text = "Nenhuma recompensa disponível no nó atual."
  },
  ErrCode_ERR_GAMECOPY_CHALLENGETIMES_NOT_ENOUGH_Desc = {
    Text = "Sem tentativas de desafio"
  },
  ErrCode_ERR_GAMECOPY_ENERGY_NOT_ENOUGH_Desc = {
    Text = "Atualmente com baixa estamina, você está em um estado de fraqueza."
  },
  ErrCode_ERR_GAMECOPY_MOPPING_LOCK_Desc = {
    Text = "Desbloqueia quando o nível de exploração atinge 2"
  },
  ErrCode_ERR_GAMECOPY_NOF_FINISH_Desc = {
    Text = "Depois de completar uma exploração com sucesso, você pode explorar novamente instantaneamente."
  },
  ErrCode_ERR_GAMECOPY_NOT_Desc = {
    Text = "Erro de Masmorras"
  },
  ErrCode_ERR_GAMECOPY_NOT_FIND_Desc = {
    Text = "Nenhuma instância encontrada"
  },
  ErrCode_ERR_GEAR_BLOCK_Desc = {
    Text = "Nó Bloqueado"
  },
  ErrCode_ERR_GEAR_FINISH_Desc = {
    Text = "Nó Completo"
  },
  ErrCode_ERR_GEAR_NOT_FINISH_Desc = {
    Text = "Nódulo não completo"
  },
  ErrCode_ERR_GEAR_NOT_NEIGHBORING_Desc = {
    Text = "Nós não são adjacentes"
  },
  ErrCode_ERR_GEAR_SHOP_NOT_NUM_Desc = {
    Text = "Renovações de loja insuficientes"
  },
  ErrCode_ERR_HOME_PLAYERLEVEL_LOCK_Desc = {
    Text = "Nível do Jogador Insuficiente"
  },
  ErrCode_ERR_ILLEGAL_CHARACTER_Desc = {
    Text = "A descrição contém caracteres ilegais. Por favor, reintroduza."
  },
  ErrCode_ERR_INOTHERBATTLE_Desc = {
    Text = "O oponente está no meio de uma investigação ou outro modo."
  },
  ErrCode_ERR_INVALID_INDEX_Desc = {
    Text = "Índice Errado"
  },
  ErrCode_ERR_INVITE_EACH_Desc = {
    Text = "Você já é o convidador do outro"
  },
  ErrCode_ERR_INVITE_REPEAT_Desc = {
    Text = "Já possui um convidado"
  },
  ErrCode_ERR_IN_COPIES_Desc = {
    Text = "Erro no estado do calabouço, por favor, faça o login novamente"
  },
  ErrCode_ERR_ITEM_BAG_FULL_Desc = {
    Text = "Inventário Cheio"
  },
  ErrCode_ERR_ITEM_CHARGES_USEDUP_Desc = {
    Text = "Número máximo de compras atingido hoje"
  },
  ErrCode_ERR_ITEM_HAS_BEEN_EQUIP_Desc = {
    Text = "Item foi equipado"
  },
  ErrCode_ERR_ITEM_HAS_LOCKED_Desc = {
    Text = "Item está bloqueado"
  },
  ErrCode_ERR_ITEM_HAS_UNLOCKED_Desc = {
    Text = "Item Não Bloqueado"
  },
  ErrCode_ERR_ITEM_MAX_STAGE_Desc = {
    Text = "Item alcançou o nível máximo"
  },
  ErrCode_ERR_ITEM_NOT_ENOUGH_Desc = {
    Text = "Item insuficiente"
  },
  ErrCode_ERR_ITEM_NOT_FIND_Desc = {
    Text = "Item não encontrado"
  },
  ErrCode_ERR_ITEM_NOT_MATCH_Desc = {
    Text = "Item incompatível"
  },
  ErrCode_ERR_ITEM_NOT_USE_Desc = {
    Text = "Item não pode ser usado"
  },
  ErrCode_ERR_ITEM_REPEAT_Desc = {
    Text = "Item duplicado"
  },
  ErrCode_ERR_ITEM_START_DROP_DATE_Desc = {
    Text = "A Roda do Destino ou Posse ainda não atingiu seu horário de abertura"
  },
  ErrCode_ERR_ITEM_SUB_NUM_FAULT_Desc = {
    Text = "Quantidade de itens incorreta"
  },
  ErrCode_ERR_ITEM_UNUSABLE_Desc = {
    Text = "Item não utilizável"
  },
  ErrCode_ERR_LAST_GEAR_NOT_FIND_Desc = {
    Text = "Nó de gatilho anterior não encontrado"
  },
  ErrCode_ERR_LEAVE_NOT_CONDITION_Desc = {
    Text = "A energia atualmente coletada é insuficiente para ativar o portal. {s1} pontos de energia são necessários."
  },
  ErrCode_ERR_LEVEL_MAX_Desc = {
    Text = "Nível máximo atingido"
  },
  ErrCode_ERR_LOCKED_Desc = {
    Text = "Não desbloqueado"
  },
  ErrCode_ERR_LOCK_COPIESAREA_Desc = {
    Text = "Área da masmorra ainda não desbloqueada"
  },
  ErrCode_ERR_LOCK_COPIESPLOTMOPPING_Desc = {
    Text = "Linha de enredo ainda não desbloqueada"
  },
  ErrCode_ERR_LOCK_COPIES_Desc = {
    Text = "Escolha masmorra não desbloqueada"
  },
  ErrCode_ERR_LOCK_SROTYLINE_Desc = {
    Text = "Escolha linha de história não desbloqueada"
  },
  ErrCode_ERR_LOGIN_SERVER_Desc = {
    Text = "Erro no servidor de login"
  },
  ErrCode_ERR_MAIL_ITEM_GAIN_Desc = {
    Text = "Anexo reivindicado"
  },
  ErrCode_ERR_MAIL_NOT_FIND_Desc = {
    Text = "O correio não existe"
  },
  ErrCode_ERR_MATCH_FAIL_Desc = {
    Text = "Partida Falhada"
  },
  ErrCode_ERR_MAXSUMMONLIMIT_Desc = {
    Text = "Já atingiu o número máximo de despertares!"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CHALLENGE_Desc = {
    Text = "Incapaz de desafiar a masmorra de Ouro especificada."
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CHOOSE_ROUSE_Desc = {
    Text = "Escolha o Despertado para a equipe"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CONDITION_Desc = {
    Text = "Dungeons de Ouro designadas bloqueadas - Por favor, complete a masmorra de Investigação especificada"
  },
  ErrCode_ERR_NAME_CHANGE_COOLTIME_Desc = {
    Text = "O tempo para mudar o nome novamente ainda não chegou, por favor Esperar"
  },
  ErrCode_ERR_NAME_ILLEGAL_CHARACTER_Desc = {
    Text = "O nome contém caracteres ilegais, por favor insira novamente"
  },
  ErrCode_ERR_NAME_NOT_LENGTH_Desc = {
    Text = "O comprimento do nome é inválido, deve ter entre 2 e 4 caracteres"
  },
  ErrCode_ERR_NOTE_LENGTH_LIMIT_Desc = {
    Text = "A string de entrada é muito longa"
  },
  ErrCode_ERR_NOTE_LENGTH_SHORT_Desc = {
    Text = "Texto inserido muito curto"
  },
  ErrCode_ERR_NOT_ENOUGH_INTEGRAL_Desc = {
    Text = "Não há pontos suficientes"
  },
  ErrCode_ERR_NOT_HAVE_ITEM_Desc = {
    Text = "Você não tem este item"
  },
  ErrCode_ERR_NOT_MOVE_Desc = {
    Text = "Não pode se mover"
  },
  ErrCode_ERR_NOT_OPEN_Desc = {
    Text = "Recurso ainda não disponível"
  },
  ErrCode_ERR_NOT_PRIZE_CONDITION_Desc = {
    Text = "Condições de recompensa não atendidas. Incapaz de reivindicar."
  },
  ErrCode_ERR_NO_AWAKER_DETAIL_Desc = {
    Text = "Atualizando o perfil, por favor, aguarde para verificar novamente."
  },
  ErrCode_ERR_NO_FRIEND_GAME_Desc = {
    Text = "Nenhuma partida amigável em andamento"
  },
  ErrCode_ERR_NO_TRINKET_Desc = {
    Text = "Sem Pacto ocioso"
  },
  ErrCode_ERR_NPC_DATA_Desc = {
    Text = "Erro nos dados do NPC"
  },
  ErrCode_ERR_NPC_FINISH_Desc = {
    Text = "O NPC já foi ativado"
  },
  ErrCode_ERR_NPC_NOT_FIND_Desc = {
    Text = "NPC não existe"
  },
  ErrCode_ERR_OFFLINE_Desc = {
    Text = "O adversário está atualmente offline"
  },
  ErrCode_ERR_PLAYERLEVEL_NOT_ENOUGH_Desc = {
    Text = "Nível do Jogador Insuficiente"
  },
  ErrCode_ERR_PLOTMOP_STARLIMIT_Desc = {
    Text = "Estrelas insuficientes na linha de enredo, não é possível varrer"
  },
  ErrCode_ERR_PLOTSAY_NOT_END_Desc = {
    Text = "Nenhum evento de diálogo de história encontrado"
  },
  ErrCode_ERR_PLOT_BUY_TIMES_NOT_ENOUGH_Desc = {
    Text = "Tentativas de desafio da linha de enredo insuficientes"
  },
  ErrCode_ERR_PRIZE_GAIN_Desc = {
    Text = "Recompensa Recebida"
  },
  ErrCode_ERR_PRIZE_NOT_FIND_Desc = {
    Text = "Nenhuma recompensa assim"
  },
  ErrCode_ERR_PUTENCHANT_FAIL_Desc = {
    Text = "Falha na incorporação de runa"
  },
  ErrCode_ERR_PVPCOLLECT_NOT_FIND_Desc = {
    Text = "Coleção PVP Não Obtida"
  },
  ErrCode_ERR_PVPTEAM_NEED_KEEPERSKILL_Desc = {
    Text = "A lista do Traphase não possui suficientes Bandos."
  },
  ErrCode_ERR_PVPTEAM_NEED_WEAPON_Desc = {
    Text = "Roda do Destino insuficiente para implantação da equipe Traphase"
  },
  ErrCode_ERR_PVP_DRAFT_LOCK_Desc = {
    Text = "Condições para ativar o modo de seleção da roda não atendidas"
  },
  ErrCode_ERR_PVP_NOT_COOLTIME_Desc = {
    Text = "Desafio em cooldown"
  },
  ErrCode_ERR_PVP_NOT_COUNT_Desc = {
    Text = "Sem tentativas de desafio"
  },
  ErrCode_ERR_PVP_NOT_FIND_OTHER_Desc = {
    Text = "Sem oponentes para desafiar"
  },
  ErrCode_ERR_PVP_NOT_FIND_ROUSE_Desc = {
    Text = "Escolha o Despertado para a equipe"
  },
  ErrCode_ERR_PVP_OverWinTime_Desc = {
    Text = "Um dos dois jogadores conseguiu duas vitórias. Nenrodas adicionais são permitidas."
  },
  ErrCode_ERR_PVP_QUIT_Desc = {
    Text = "Oponente saiu do jogo"
  },
  ErrCode_ERR_PVP_ROOM_NOT_EXIST_Desc = {
    Text = "Combate de senha não existe ou está desatualizado"
  },
  ErrCode_ERR_RANK_OUT_OF_RANGE_Desc = {
    Text = "No momento, não é possível visualizar informações de classificação além da posição 2000."
  },
  ErrCode_ERR_RECHARGE_NOT_CONFIG_Desc = {
    Text = "Configuração de recarga não encontrada"
  },
  ErrCode_ERR_RECHARGE_NOT_FREE_Desc = {
    Text = "Recarga gratuita já feita, não pode recarregar novamente"
  },
  ErrCode_ERR_REFRESH_NUM_LIMIT_Desc = {
    Text = "O número de renovações de itens atingiu o limite superior."
  },
  ErrCode_ERR_RELATION_Desc = {
    Text = "Não em um estado mutuamente seguido"
  },
  ErrCode_ERR_RELIC_FULL_Desc = {
    Text = "Relíquias Cheias"
  },
  ErrCode_ERR_REQUEST_CD_Desc = {
    Text = "Pedido muito frequente. Por favor, tente novamente mais tarde."
  },
  ErrCode_ERR_ROLE_ADVANCE_NOT_ITEM_Desc = {
    Text = "Materiais insuficientes para aprimoramento de elite"
  },
  ErrCode_ERR_ROLE_ADVANCE_NOT_MONEY_Desc = {
    Text = "Moeda insuficiente para aprimorar o Despertador"
  },
  ErrCode_ERR_ROLE_DATA_Desc = {
    Text = "Erro de dados do personagem"
  },
  ErrCode_ERR_ROLE_ENERGY_FULL_Desc = {
    Text = "A taxa de chegada do Despertar está no máximo e não pode ser aumentada mais."
  },
  ErrCode_ERR_ROLE_LEVEl_NOENOUGH_Desc = {
    Text = "Nível do Despertar insuficiente"
  },
  ErrCode_ERR_ROLE_MAX_LEVEL_Desc = {
    Text = "Despertar atingiu o nível máximo e não pode ser atualizado."
  },
  ErrCode_ERR_ROLE_MONEY_NOT_ENOUGH_Desc = {
    Text = "Moeda insuficiente"
  },
  ErrCode_ERR_ROLE_NOT_ADVANCE_Desc = {
    Text = "O Despertar alcançou o nível mais alto de Edificação."
  },
  ErrCode_ERR_ROLE_NOT_ARRIVED_MAXLEVEL_Desc = {
    Text = "Não pode avançar sem alcançar o nível mais alto"
  },
  ErrCode_ERR_ROLE_NOT_FIND_Desc = {
    Text = "Sem dados de despertos encontrados"
  },
  ErrCode_ERR_ROLE_NOT_SKILL_Desc = {
    Text = "O Despertar não possui habilidades."
  },
  ErrCode_ERR_ROLE_NOT_SLOTDATA_Desc = {
    Text = "Sem informações de slots"
  },
  ErrCode_ERR_ROLE_POTENCY_MAX_Desc = {
    Text = "O potencial do Despertar alcançou o nível mais alto."
  },
  ErrCode_ERR_ROLE_POTENCY_UPGRADE_NOT_ITEM_Desc = {
    Text = "Itens insuficientes para aprimorar o potencial do Despertador"
  },
  ErrCode_ERR_ROLE_SKILL_LOCKED_Desc = {
    Text = "Habilidades do Despertar ainda não desbloqueadas"
  },
  ErrCode_ERR_ROLE_SKILL_MAX_Desc = {
    Text = "Habilidade no nível máximo"
  },
  ErrCode_ERR_ROLE_SKILL_UPGRADE_NOT_ITEM_Desc = {
    Text = "Itens de Upgrade de Habilidade insuficientes"
  },
  ErrCode_ERR_ROLE_SKILL_UPGRADE_NOT_MONEY_Desc = {
    Text = "Moeda insuficiente para atualizações de habilidade"
  },
  ErrCode_ERR_ROLE_SLOT_MAX_LEVEL_Desc = {
    Text = "Nível máximo atingido"
  },
  ErrCode_ERR_ROLE_SLOT_UPGRADE_NOT_NUMBER_Desc = {
    Text = "Sem mais tentativas de upgrade manual"
  },
  ErrCode_ERR_ROLE_STAGE_Desc = {
    Text = "Já avançado. Não pode avançar novamente."
  },
  ErrCode_ERR_ROLE_UPLEVEL_NOT_ITEM_Desc = {
    Text = "Itens insuficientes para consumo de aprimoramento do Despertador"
  },
  ErrCode_ERR_ROLE_UPLEVEL_NOT_MONEY_Desc = {
    Text = "Moeda insuficiente para aprimorar o Despertador"
  },
  ErrCode_ERR_SCHOOL_NOT_MATCH_Desc = {
    Text = "O reino não atende às condições"
  },
  ErrCode_ERR_SCHOOL_TOWN_AWAKER_REQUIREMENT_Desc = {
    Text = "Despertadores implantados na Torre do Reino não atendem aos requisitos do Reino."
  },
  ErrCode_ERR_SCHOOL_TOWN_BATCH_MATCH_Desc = {
    Text = "O nível que você entrou não está disponível atualmente."
  },
  ErrCode_ERR_SCHOOL_TOWN_SAME_AWAKER_Desc = {
    Text = "Não é possível implantar Despertadores idênticos na Torre do Reino"
  },
  ErrCode_ERR_SENIORMONEY_NOT_ENOUGH_Desc = {
    Text = "Núcleo Prateado insuficiente"
  },
  ErrCode_ERR_SERVER_CLOSED_Desc = {
    Text = "Manutenção do campus em andamento, aguarde a conclusão"
  },
  ErrCode_ERR_SERVER_NOT_START_Desc = {
    Text = "Serviço não iniciado"
  },
  ErrCode_ERR_SHOP_BUY_Desc = {
    Text = "Produto comprado"
  },
  ErrCode_ERR_SHOP_CUSTOM_CMD_Desc = {
    Text = "Atualmente incapaz de sentir"
  },
  ErrCode_ERR_SHOP_GOODS_EXPIRE_Desc = {
    Text = "O item expirou e não pode ser resgatado."
  },
  ErrCode_ERR_SHOP_GOODS_NOT_ENGHOU_Desc = {
    Text = "O item à venda está fora de estoque"
  },
  ErrCode_ERR_SHOP_NOT_DATA_Desc = {
    Text = "Sem dados da loja"
  },
  ErrCode_ERR_SHOP_NOT_Desc = {
    Text = "Sem este tipo de loja"
  },
  ErrCode_ERR_SHOP_NOT_GOODS_Desc = {
    Text = "Sem este item à venda"
  },
  ErrCode_ERR_SHOP_NOT_GOODS_SELL_Desc = {
    Text = "A loja não carrega este item."
  },
  ErrCode_ERR_SHOP_NOT_REFRESH_NUM_Desc = {
    Text = "Sem tentativas de atualização"
  },
  ErrCode_ERR_SHOP_NOT_SELL_Desc = {
    Text = "Este item não está disponível na loja."
  },
  ErrCode_ERR_SHOP_REFRESH_Desc = {
    Text = "Atualmente não é um nó de loja e não pode ser atualizado."
  },
  ErrCode_ERR_SOCIAL_NO_ROLE_Desc = {
    Text = "O jogador não existe."
  },
  ErrCode_ERR_STAGE_GROUP_BAN_BY_TASK_Desc = {
    Text = "Todos os avatares da Visão Primordial foram derrotados"
  },
  ErrCode_ERR_STAGE_GROUP_TYPE_BAN_BY_DAILY_WIN_COUNT_Desc = {
    Text = "A contagem de desafios diários do tipo de missão atingiu o limite"
  },
  ErrCode_ERR_SUMMON_CLICKTOOFAST_Desc = {
    Text = "Clicando com muita frequência. Por favor, tente novamente mais tarde."
  },
  ErrCode_ERR_SUMMON_NOT_OPEN_Desc = {
    Text = "Função de despertar não ativada"
  },
  ErrCode_ERR_TALENT_ACTIVE_CONDITION_Desc = {
    Text = "Condições de ativação não atendidas"
  },
  ErrCode_ERR_TALENT_ACTIVE_Desc = {
    Text = "Ressonância já ativada, não é necessário reativar"
  },
  ErrCode_ERR_TALENT_INIT_STATE_NOT_RESET_Desc = {
    Text = "O estado inicial de Ressonância não pode ser redefinido."
  },
  ErrCode_ERR_TALENT_ITEM_NOT_ENOUGH_Desc = {
    Text = "Materiais de Ressonância insuficientes."
  },
  ErrCode_ERR_TALENT_MAX_LEVEL_Desc = {
    Text = "O Ponto de Ressonância alcançou o nível máximo."
  },
  ErrCode_ERR_TALENT_NOT_COPIES_Desc = {
    Text = "Nenhuma ressonância encontrada na instância"
  },
  ErrCode_ERR_TALENT_NOT_FIND_Desc = {
    Text = "Nenhum dado de ressonância encontrado"
  },
  ErrCode_ERR_TALENT_NOT_FIND_LEVEL_Desc = {
    Text = "Nenhum dado relacionado ao nível de Ressonância encontrado"
  },
  ErrCode_ERR_TALENT_NOT_RESET_NUM_Desc = {
    Text = "Nenhuma tentativa de reinicialização disponível"
  },
  ErrCode_ERR_TALENT_UNLOCK_Desc = {
    Text = "Efeitos de produção do Despertar desbloqueados; não é necessário desbloquear novamente."
  },
  ErrCode_ERR_TASKMODULE_PRIZE_NOT_GAIN_Desc = {
    Text = "Recompensa Recebida"
  },
  ErrCode_ERR_TASK_APPOINT_TASK_FINISH_Desc = {
    Text = "A missão delegada está completa e não pode ser recallada."
  },
  ErrCode_ERR_TASK_DELEGATE_NOT_COND_Desc = {
    Text = "Condições de atribuição insuficientes"
  },
  ErrCode_ERR_TASK_FINISH_Desc = {
    Text = "Missão concluída"
  },
  ErrCode_ERR_TASK_NOT_FIND_Desc = {
    Text = "Tarefa não encontrada"
  },
  ErrCode_ERR_TASK_NOT_GAINPRIZE_Desc = {
    Text = "Quest incompleta, recompensa indisponível"
  },
  ErrCode_ERR_TEAM_NAME_ILLEGLE_Desc = {
    Text = "O nome da equipe pode conter apenas caracteres chineses ou ingleses."
  },
  ErrCode_ERR_TEAM_NAME_TOO_LONG_Desc = {
    Text = "Nome da equipe não pode ter mais de 8 caracteres"
  },
  ErrCode_ERR_TEAM_NEED_4_AWAKER_Desc = {
    Text = "São necessários pelo menos quatro Despertos na equipe para entrar no estágio."
  },
  ErrCode_ERR_TEAM_NO_TEAM_Desc = {
    Text = "Configuração da equipe não encontrada"
  },
  ErrCode_ERR_TEAM_NO_WEAPON_SLOT_Desc = {
    Text = "O Despertador da equipe ainda não configurou a Roda do Destino."
  },
  ErrCode_ERR_TEAM_SCHOOLMIX_Desc = {
    Text = "Há um conflito de reino com os Despertadores na equipe, por favor, faça ajustes"
  },
  ErrCode_ERR_TEAM_WEAPON_NOT_EXISTS_Desc = {
    Text = "Roda do Destino não existe"
  },
  ErrCode_ERR_TICKET_NOT_ENOUGH_Desc = {
    Text = "Prova insuficiente"
  },
  ErrCode_ERR_TOKEN_Desc = {
    Text = "Erro no Token de Login"
  },
  ErrCode_ERR_TRIGGER_NOT_FIND_Desc = {
    Text = "Nó de gatilho atual não encontrado"
  },
  ErrCode_ERR_TRINKET_NOT_TRAINING_Desc = {
    Text = "Acessório não registrado, incapaz de substituir atributos"
  },
  ErrCode_ERR_UNATTEN_FIRST_Desc = {
    Text = "Deixar de Seguir primeiro, depois bloquear"
  },
  ErrCode_ERR_UNIT_USED_ONCE_Desc = {
    Text = "Os Despertadores, a Roda do Destino ou Bando foram usados neste jogo hoje."
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_AVAILABLE_Desc = {
    Text = "Falha ao Desbloquear Missão Secundária: Missão Secundária Disponível"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_NOT_OPEN_Desc = {
    Text = "Falha ao desbloquear a missão secundária: Missão secundária não ativada"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_NO_UNLOCKITEM_Desc = {
    Text = "Falha ao desbloquear a missão secundária: Nenhum item necessário para desbloqueio"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_UNLOCKED_Desc = {
    Text = "Falha ao desbloquear missão secundária: Missão secundária já desbloqueada."
  },
  ErrCode_ERR_VERSION_TOO_OLD_Desc = {
    Text = "Incompatibilidade de versão. Por favor, atualize para o cliente mais recente; se já foi atualizado, por favor, aguarde a manutenção do campus ser concluída."
  },
  ErrCode_FAILED_Desc = {Text = "Falha"},
  ErrCode_IS_CREATE_ROLE_Desc = {
    Text = "Personagens existentes não precisam ser criados novamente."
  },
  ErrCode_SUCCESS_Desc = {
    Text = "Operação bem-sucedida"
  }
})
return Text_ErrCode
