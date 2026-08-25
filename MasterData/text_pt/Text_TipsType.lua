__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_TipsType = readonly({
  TipsType_100001_Desc = {
    Text = "Reinicie o cliente para aplicar a mudança de resolução, confirmar?"
  },
  TipsType_100001_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_100001_RightBtnDesc = {Text = "Confirmar"},
  TipsType_100001_Title = {
    Text = "Confirmar mudança de resolução"
  },
  TipsType_100002_Desc = {
    Text = "Esperando {s1} aceitar um convite para revanche"
  },
  TipsType_100002_RightBtnDesc = {Text = "Cancelar"},
  TipsType_100002_Title = {
    Text = "Mais uma partida"
  },
  TipsType_100003_Desc = {
    Text = "{s1} convida você para outra partida"
  },
  TipsType_100003_LeftBtnDesc = {Text = "Recusar"},
  TipsType_100003_RightBtnDesc = {Text = "Aceitar"},
  TipsType_100003_Title = {
    Text = "Mais uma partida"
  },
  TipsType_100004_Desc = {
    Text = "Já é o fundo do dormitório atual"
  },
  TipsType_100005_Desc = {
    Text = "O modo de jogo de fase não foi desbloqueado"
  },
  TipsType_100006_Desc = {
    Text = "O modo de jogo de traphase do oponente não está ativado"
  },
  TipsType_100007_Desc = {
    Text = "Só é possível iniciar uma partida amistosa se seguirem mutuamente"
  },
  TipsType_100008_Desc = {
    Text = "O oponente está offline"
  },
  TipsType_100009_Desc = {
    Text = "O oponente está explorando"
  },
  TipsType_100010_Desc = {
    Text = "Tempo de espera para partida amistosa esgotado"
  },
  TipsType_100011_Desc = {
    Text = "Você cancelou a partida amistosa"
  },
  TipsType_100012_Desc = {
    Text = "Convite para partida amistosa recusado"
  },
  TipsType_100012_LeftBtnDesc = {Text = "Confirmar"},
  TipsType_100012_Title = {Text = "Dica"},
  TipsType_100013_Desc = {
    Text = "O oponente está offline"
  },
  TipsType_100014_Desc = {
    Text = "O oponente entrou em outro modo de jogo"
  },
  TipsType_100015_Desc = {
    Text = "Convites muito frequentes, tente novamente em {s1} segundos"
  },
  TipsType_100016_Desc = {
    Text = "O oponente cancelou a partida amistosa"
  },
  TipsType_100016_LeftBtnDesc = {Text = "Confirmar"},
  TipsType_100016_Title = {Text = "Dica"},
  TipsType_100017_Desc = {
    Text = "Este jogador está em uma partida amistosa"
  },
  TipsType_100017_LeftBtnDesc = {Text = "Confirmar"},
  TipsType_100017_Title = {Text = "Dica"},
  TipsType_100018_Desc = {
    Text = "Este esquema contém cartas com uso limitado no tempo, é necessário desbloquear o tema central deste período para continuar usando-as. Espero lutar ao seu lado novamente! \n Deseja ir desbloquear o tema central?"
  },
  TipsType_100018_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_100018_RightBtnDesc = {Text = "Confirmar"},
  TipsType_100018_Title = {
    Text = "<Tópico central expirado>"
  },
  TipsType_10001_Desc = {
    Text = "Operação bem-sucedida"
  },
  TipsType_100020_Desc = {
    Text = "Ainda está na batalha, deseja continuar a batalha anterior?"
  },
  TipsType_100020_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_100020_RightBtnDesc = {Text = "Confirmar"},
  TipsType_100020_Title = {Text = "Dica"},
  TipsType_10002_Desc = {
    Text = "Erro na tabela de configuração"
  },
  TipsType_10003_Desc = {
    Text = "Erro de dados recebidos pelo cliente"
  },
  TipsType_10004_Desc = {
    Text = "Servidor não iniciado"
  },
  TipsType_10005_Desc = {
    Text = "Erro de dados do personagem"
  },
  TipsType_10006_Desc = {
    Text = "Sem dados de despertos encontrados"
  },
  TipsType_10007_Desc = {
    Text = "Despertado atingiu o nível máximo"
  },
  TipsType_10008_Desc = {
    Text = "Sem pontos de tarefa suficientes"
  },
  TipsType_10009_Desc = {
    Text = "O despertador não alcançou o nível máximo, não pode ser iluminado"
  },
  TipsType_100100_Desc = {
    Text = "Uma nova versão está disponível. Se a atualização não iniciar automaticamente, tente reiniciar o Steam para verificar atualizações."
  },
  TipsType_100100_RightBtnDesc = {Text = "Confirmar"},
  TipsType_100100_Title = {
    Text = "Aviso de atualização"
  },
  TipsType_10010_Desc = {
    Text = "Concluído o despertar"
  },
  TipsType_10011_Desc = {
    Text = "Nenhum personagem criado"
  },
  TipsType_10012_Desc = {
    Text = "Já possui personagem"
  },
  TipsType_10013_Desc = {
    Text = "Nome do personagem repetido"
  },
  TipsType_10014_Desc = {
    Text = "Erro na área do domínio"
  },
  TipsType_10015_Desc = {
    Text = "Impossível localizar a área do domínio"
  },
  TipsType_10016_Desc = {
    Text = "Energia baixa"
  },
  TipsType_10017_Desc = {
    Text = "Desbloqueia entre {s1} e {s2}"
  },
  TipsType_10018_Desc = {
    Text = "Após chegar ao segundo nível deste domínio 1 vez, uma investigação rápida pode ser realizada"
  },
  TipsType_10019_Desc = {
    Text = "Evento concluído"
  },
  TipsType_10020_Desc = {
    Text = "Erro no tipo preenchido na tabela de configuração do evento"
  },
  TipsType_10021_Desc = {
    Text = "Evento não existe"
  },
  TipsType_10022_Desc = {
    Text = "Não é possível comprar devido à insuficiência de sigilo negro"
  },
  TipsType_10023_Desc = {
    Text = "Este cartão não pode ser fortalecido"
  },
  TipsType_10024_Desc = {
    Text = "Este cartão atingiu o limite de fortalecimento"
  },
  TipsType_10025_Desc = {
    Text = "O comerciante não vende este item"
  },
  TipsType_10026_Desc = {
    Text = "Sem recompensa"
  },
  TipsType_10027_Desc = {
    Text = "Recompensa Recebida"
  },
  TipsType_10028_Desc = {
    Text = "Erro nos dados do evento"
  },
  TipsType_10029_Desc = {
    Text = "Produto comprado"
  },
  TipsType_10030_Desc = {
    Text = "Energia insuficiente para ativar portal, precisa de {s1} energia"
  },
  TipsType_10031_Desc = {
    Text = "Nenhum evento de diálogo de história encontrado"
  },
  TipsType_10032_Desc = {
    Text = "A quantidade de cartas de seleção de instrução de evento é insuficiente"
  },
  TipsType_10033_Desc = {
    Text = "A quantidade de cartas de seleção de instrução de evento é excessiva"
  },
  TipsType_10034_Desc = {
    Text = "Carta de comando de evento selecionada não existe"
  },
  TipsType_10035_Desc = {
    Text = "Sem dados no pool de eventos aleatórios"
  },
  TipsType_10036_Desc = {
    Text = "O comerciante não vende este item"
  },
  TipsType_10037_Desc = {
    Text = "Número insuficiente de criações de evento selecionadas"
  },
  TipsType_10038_Desc = {
    Text = "Número excessivo de criações de evento selecionadas"
  },
  TipsType_10039_Desc = {
    Text = "Criação de evento selecionada não existe"
  },
  TipsType_10040_Desc = {
    Text = "Nenhum nó de evento encontrado"
  },
  TipsType_10041_Desc = {
    Text = "Limite de atualizações do comerciante atingido"
  },
  TipsType_10042_Desc = {
    Text = "O limite de uso para a renovação das cartas de comando de queda de batalha foi esgotado"
  },
  TipsType_10043_Desc = {
    Text = "Limite de atualização de criações caídas na batalha atingido"
  },
  TipsType_10044_Desc = {
    Text = "A função do ponto de união foi bloqueada"
  },
  TipsType_10045_Desc = {
    Text = "Região do evento não corresponde! Região atual: {s1}, região configurada: {s2}"
  },
  TipsType_10046_Desc = {
    Text = "O número de vezes que a carta de comércio de evento foi deletado foi esgotado"
  },
  TipsType_10047_Desc = {
    Text = "Nenhum dado de unidade de tarefa encontrado"
  },
  TipsType_10048_Desc = {
    Text = "Módulo enviado, não precisa reenviar"
  },
  TipsType_10049_Desc = {
    Text = "Tópicos do módulo não concluídos, não pode ser enviado"
  },
  TipsType_10050_Desc = {
    Text = "Nenhum módulo de tarefa encontrado"
  },
  TipsType_10051_Desc = {
    Text = "Sem dados de missão da fase"
  },
  TipsType_10052_Desc = {
    Text = "Não há tema correspondente a este domínio"
  },
  TipsType_10053_Desc = {
    Text = "Créditos insuficientes, não é possível resgatar a recompensa"
  },
  TipsType_10054_Desc = {
    Text = "Requisitos de crédito para resgate não atingidos"
  },
  TipsType_10055_Desc = {
    Text = "Subtarefa não encontrada"
  },
  TipsType_10056_Desc = {
    Text = "Subtarefa concluída"
  },
  TipsType_10057_Desc = {
    Text = "Subtarefa da Tarefa não concluída"
  },
  TipsType_10058_Desc = {
    Text = "NPC foi ativado"
  },
  TipsType_10059_Desc = {
    Text = "Erro nos dados do NPC"
  },
  TipsType_10060_Desc = {
    Text = "NPC não existe"
  },
  TipsType_10061_Desc = {
    Text = "Nada encontrado no domínio secreto"
  },
  TipsType_10062_Desc = {
    Text = "Nenhum dado de ressonância encontrado"
  },
  TipsType_10063_Desc = {
    Text = "Ressonância atingiu o nível máximo"
  },
  TipsType_10064_Desc = {
    Text = "Nenhum dado de nível de ressonância encontrado"
  },
  TipsType_10065_Desc = {
    Text = "Sem reinicializações"
  },
  TipsType_10066_Desc = {
    Text = "Condições de ativação de ressonância não atendidas"
  },
  TipsType_10067_Desc = {
    Text = "Partículas de ressonância insuficientes"
  },
  TipsType_10068_Desc = {
    Text = "Iluminar Completo, não pode ser iluminado novamente"
  },
  TipsType_10069_Desc = {
    Text = "Materiais insuficientes para iluminar"
  },
  TipsType_10070_Desc = {
    Text = "Materiais insuficientes para upgrade do desperto"
  },
  TipsType_10071_Desc = {
    Text = "Fundos insuficientes para upgrade do desperto"
  },
  TipsType_10072_Desc = {
    Text = "Fundos insuficientes para upgrade do desperto"
  },
  TipsType_10073_Desc = {
    Text = "Sem habilidades de despertador"
  },
  TipsType_10074_Desc = {
    Text = "Ainda não desbloqueou a habilidade do despertador"
  },
  TipsType_10075_Desc = {
    Text = "\"Prata\" insuficiente para Despertar."
  },
  TipsType_10076_Desc = {
    Text = "Item insuficiente"
  },
  TipsType_10077_Desc = {
    Text = "Número máximo de compras atingido hoje"
  },
  TipsType_10078_Desc = {
    Text = "Item não utilizável"
  },
  TipsType_10079_Desc = {
    Text = "Quantidade de itens incorreta"
  },
  TipsType_10080_Desc = {
    Text = "Habilidade no nível máximo"
  },
  TipsType_10081_Desc = {
    Text = "Material insuficiente, não é possível atualizar"
  },
  TipsType_10082_Desc = {
    Text = "Moeda insuficiente, não é possível atualizar"
  },
  TipsType_10083_Desc = {
    Text = "A taxa de conexão do despertador atingiu o nível máximo"
  },
  TipsType_10084_Desc = {
    Text = "Este Despertado não tem energia espiritual suficiente"
  },
  TipsType_10085_Desc = {
    Text = "Rota de upgrade sem ID de personagem"
  },
  TipsType_10086_Desc = {
    Text = "Informação do cartão exclusivo não encontrada"
  },
  TipsType_10087_Desc = {
    Text = "Carta exclusiva não desbloqueada"
  },
  TipsType_10088_Desc = {
    Text = "UUID do cartão exclusivo não encontrado"
  },
  TipsType_10089_Desc = {
    Text = "Recompensa do capítulo não atingiu a pontuação"
  },
  TipsType_10090_Desc = {
    Text = "Recompensa do capítulo recebida"
  },
  TipsType_10091_Desc = {
    Text = "Escolha linha de história não desbloqueada"
  },
  TipsType_10092_Desc = {
    Text = "Escolha masmorra não desbloqueada"
  },
  TipsType_10093_Desc = {
    Text = "Área da masmorra ainda não desbloqueada"
  },
  TipsType_10094_Desc = {
    Text = "Linha de enredo ainda não desbloqueada"
  },
  TipsType_10095_Desc = {
    Text = "Nenhuma linha de história de desafio de instância encontrada"
  },
  TipsType_10096_Desc = {
    Text = "Nenhuma linha de história de desafio de instância encontrada"
  },
  TipsType_10097_Desc = {
    Text = "Desafio concluído, não é possível receber a recompensa novamente"
  },
  TipsType_10098_Desc = {
    Text = "Desafio não concluído, não é possível receber a recompensa"
  },
  TipsType_10099_Desc = {
    Text = "Construção não existe"
  },
  TipsType_10100_Desc = {
    Text = "Construção atingiu o nível máximo"
  },
  TipsType_10101_Desc = {
    Text = "Condições insuficientes para subir/construir edifício"
  },
  TipsType_10102_Desc = {
    Text = "Construção já existe, não pode ser construída novamente"
  },
  TipsType_10103_Desc = {
    Text = "Materiais necessários para atualização/edificação insuficientes"
  },
  TipsType_10104_Desc = {
    Text = "Posição já ocupada por um Despertado, não pode ser usada"
  },
  TipsType_10105_Desc = {
    Text = "Faltam outros itens necessários para a combinação do item"
  },
  TipsType_10106_Desc = {
    Text = "Faltam moedas necessárias para a combinação do item"
  },
  TipsType_10107_Desc = {
    Text = "Item de síntese não desbloqueado"
  },
  TipsType_10108_Desc = {
    Text = "Falha na conexão com o servidor, por favor, verifique a rede e tente novamente"
  },
  TipsType_10109_Desc = {
    Text = "Função do acampamento já escolhida, não pode ser selecionada novamente"
  },
  TipsType_10110_Desc = {
    Text = "Função do acampamento sem usos restantes"
  },
  TipsType_10111_Desc = {
    Text = "Carta exclusiva não melhorada, não pode trocar"
  },
  TipsType_10112_Desc = {
    Text = "Carta exclusiva sem mudanças, não pode trocar"
  },
  TipsType_10113_Desc = {
    Text = "Falha ao trocar carta exclusiva"
  },
  TipsType_10114_Desc = {
    Text = "Obter Despertar{s1}"
  },
  TipsType_10115_Desc = {
    Text = "Ganhou repetidamente {s1}, convertido para {s2}{s3}"
  },
  TipsType_10116_Desc = {
    Text = "{s1} tokens excedidos, convertidos para {s2}{s3}"
  },
  TipsType_10117_Desc = {
    Text = "Log carregado com sucesso"
  },
  TipsType_10118_Desc = {
    Text = "Comando não corresponde, aguardando comando {s1}, inserido {s2}"
  },
  TipsType_10119_Desc = {
    Text = "Perdeu o cartão: {s1}; uid: {s2}"
  },
  TipsType_10120_Desc = {
    Text = "Não pode ser liberado"
  },
  TipsType_10121_Desc = {
    Text = "Sem habilidade"
  },
  TipsType_10122_Desc = {
    Text = "Habilidade em recarga"
  },
  TipsType_10123_Desc = {
    Text = "Usos de habilidade esgotados"
  },
  TipsType_10124_Desc = {
    Text = "Verifique se a ordem de atualização do edifício Tid {s1} está em loop"
  },
  TipsType_10125_Desc = {
    Text = "Verifique se o edifício Tid {s1} não tem configuração relacionada"
  },
  TipsType_10126_Desc = {
    Text = "Construção Tid {s1} nível real deveria ser {s2}, configurado como {s3}"
  },
  TipsType_10127_Desc = {
    Text = "Tipo de construção não encontrado"
  },
  TipsType_10128_Desc = {
    Text = "Configuração de construção não encontrada ou tipo de construção ausente"
  },
  TipsType_10129_Desc = {
    Text = "Tarefa de linha de enredo não disponível"
  },
  TipsType_10130_Desc = {
    Text = "Remoção bem-sucedida"
  },
  TipsType_10131_Desc = {
    Text = "Sucesso ao obter \"Lingfétide\" × {s1}."
  },
  TipsType_10132_Desc = {
    Text = "Reparo concluído"
  },
  TipsType_10133_Desc = {
    Text = "O GM não conseguiu encontrar o item correspondente ao nome do item [\"..arg1..\"]"
  },
  TipsType_10134_Desc = {
    Text = "Evento [\"..arg1..\"] não existe"
  },
  TipsType_10135_Desc = {
    Text = "Atual: pressione {s1}"
  },
  TipsType_10136_Desc = {
    Text = "Aprimoramento de Habilidade bem-sucedido"
  },
  TipsType_10137_Desc = {
    Text = "Geração Bem-sucedida"
  },
  TipsType_10138_Desc = {
    Text = "Horário do servidor modificado com sucesso"
  },
  TipsType_10139_Desc = {
    Text = "Falha ao modificar o horário do servidor"
  },
  TipsType_10140_Desc = {
    Text = "Total de construções: 17\nEsta versão temporária só abre algumas construções"
  },
  TipsType_10141_Desc = {
    Text = "Condições de desbloqueio do edifício não atendidas"
  },
  TipsType_10142_Desc = {
    Text = "Construção: {s1} interface configurada não existe {s2}"
  },
  TipsType_10143_Desc = {
    Text = "Esta fórmula de síntese ainda não foi desbloqueada"
  },
  TipsType_10144_Desc = {
    Text = "Material insuficiente"
  },
  TipsType_10145_Desc = {
    Text = "Síntese bem-sucedida"
  },
  TipsType_10146_Desc = {
    Text = "Sucesso ao subir de nível"
  },
  TipsType_10147_Desc = {
    Text = "O monstro está vazio; não pode entrar na batalha"
  },
  TipsType_10148_Desc = {
    Text = "Recuperação de \"Lingfétide\""
  },
  TipsType_10149_Desc = {
    Text = "O ID de personagem preenchido está duplicado, não pode entrar em batalha"
  },
  TipsType_10150_Desc = {
    Text = "O ID preenchido {s1} não existe, não pode entrar em batalha"
  },
  TipsType_10151_Desc = {
    Text = "O monstro não tem ação correspondente"
  },
  TipsType_10152_Desc = {
    Text = "Ainda não disponível"
  },
  TipsType_10153_Desc = {
    Text = "Atualmente, não há cartas no baralho"
  },
  TipsType_10154_Desc = {
    Text = "Outros cartões estão em efeito, escolha não pode ser feita"
  },
  TipsType_10155_Desc = {
    Text = "Não está na mão, não pode ser jogada"
  },
  TipsType_10156_Desc = {
    Text = "Carta não pode ser jogada"
  },
  TipsType_10157_Desc = {
    Text = "Carta sem habilidade configurada"
  },
  TipsType_10158_Desc = {
    Text = "Carta não pode ser jogada"
  },
  TipsType_10159_Desc = {
    Text = "Capacidade insuficiente"
  },
  TipsType_10160_Desc = {
    Text = "Não há Despertador correspondente no campo"
  },
  TipsType_10161_Desc = {
    Text = "Tentativas restantes insuficientes"
  },
  TipsType_10162_Desc = {
    Text = "Usar habilidade de exploração"
  },
  TipsType_10163_Desc = {
    Text = "%d cartas de comando selecionadas"
  },
  TipsType_10164_Desc = {
    Text = "Limite de quantidade atingido"
  },
  TipsType_10165_Desc = {
    Text = "Não selecionado"
  },
  TipsType_10166_Desc = {
    Text = "Este cartão não pode ser jogado com consumo de aritmética"
  },
  TipsType_10167_Desc = {
    Text = "Consumo total excedido"
  },
  TipsType_10168_Desc = {
    Text = "{s1} cartas selecionadas"
  },
  TipsType_10169_Desc = {
    Text = "Número máximo de tentáculos atingido"
  },
  TipsType_10170_Desc = {
    Text = "Remoção bem-sucedida"
  },
  TipsType_10171_Desc = {
    Text = "Reforço bem-sucedido"
  },
  TipsType_10172_Desc = {
    Text = "Mudança bem-sucedida"
  },
  TipsType_10173_Desc = {
    Text = "Copiado para a área de transferência"
  },
  TipsType_10174_Desc = {
    Text = "Cartão de comando obtido com sucesso"
  },
  TipsType_10175_Desc = {
    Text = "Limite de remoção atingido"
  },
  TipsType_10176_Desc = {
    Text = "Número máximo de reforços atingido"
  },
  TipsType_10177_Desc = {
    Text = "Limite de mudanças atingido"
  },
  TipsType_10178_Desc = {
    Text = "Limite de cópias atingido"
  },
  TipsType_10179_Desc = {
    Text = "Escolha o número de cartas de comando que atinge o limite"
  },
  TipsType_10180_Desc = {
    Text = "Não selecionou carta de comando"
  },
  TipsType_10181_Desc = {
    Text = "Loja ainda não aberta, aguarde"
  },
  TipsType_10182_Desc = {Text = "Aguarde"},
  TipsType_10183_Desc = {
    Text = "Área do objetivo da Tarefa muito distante, impossível localizar"
  },
  TipsType_10184_Desc = {
    Text = "Área do alvo perdida, impossível completar"
  },
  TipsType_10185_Desc = {
    Text = "Ainda não desbloqueou este tópico"
  },
  TipsType_10186_Desc = {
    Text = "Exploração no domínio desbloqueia mais investigações"
  },
  TipsType_10187_Desc = {
    Text = "Desbloqueia mais investigações após concluir a missão prévia"
  },
  TipsType_10188_Desc = {
    Text = "Submissão bem-sucedida, pontos de projeto +{s1}"
  },
  TipsType_10189_Desc = {
    Text = "Sem tarefas para enviar"
  },
  TipsType_10190_Desc = {
    Text = "Ainda não aberto, verifique o horário de abertura da instância"
  },
  TipsType_10191_Desc = {
    Text = "Ainda não atingiu as condições de desbloqueio da fase"
  },
  TipsType_10192_Desc = {
    Text = "{s1} não pode estar vazio"
  },
  TipsType_10193_Desc = {
    Text = "{s1} e {s2} não podem estar vazios"
  },
  TipsType_10194_Desc = {
    Text = "Tentativas de atualização esgotadas, não é possível atualizar"
  },
  TipsType_10195_Desc = {
    Text = "Método de obtenção não desbloqueado"
  },
  TipsType_10196_Desc = {
    Text = "Método de obtenção fora do horário de funcionamento"
  },
  TipsType_10197_Desc = {
    Text = "Escolha a criação a modificar"
  },
  TipsType_10198_Desc = {
    Text = "Remoção bem-sucedida"
  },
  TipsType_10199_Desc = {
    Text = "Limite de remoção atingido"
  },
  TipsType_10200_Desc = {
    Text = "Limite de mudanças atingido"
  },
  TipsType_10201_Desc = {
    Text = "Escolha a criação a remover"
  },
  TipsType_10202_Desc = {
    Text = "Quantidade máxima atingida"
  },
  TipsType_10203_Desc = {
    Text = "Escolha pelo menos {s1} criações"
  },
  TipsType_10204_Desc = {
    Text = "Trocas restantes: 0, não pode trocar"
  },
  TipsType_10205_Desc = {
    Text = "Todas as cartas exclusivas estão no nível máximo"
  },
  TipsType_10206_Desc = {
    Text = "Rejeição em 0, não pode diminuir mais"
  },
  TipsType_10207_Desc = {
    Text = "Ainda não disponível"
  },
  TipsType_10208_Desc = {
    Text = "Âncoras de Alma insuficientes, não é possível fortalecer"
  },
  TipsType_10209_Desc = {
    Text = "É necessário que {s1} atinja o nível {s2} para poder realizar o Despertar Espiritual"
  },
  TipsType_10210_Desc = {
    Text = "\"{s1}\" é insuficiente"
  },
  TipsType_10211_Desc = {
    Text = "Ainda não possui \"{s1}\""
  },
  TipsType_10212_Desc = {
    Text = "Limite de nível atingido"
  },
  TipsType_10213_Desc = {
    Text = "Por favor, escolha os recursos primeiro"
  },
  TipsType_10214_Desc = {
    Text = "\"{s1}\" é insuficiente"
  },
  TipsType_10215_Desc = {
    Text = "Sucesso ao subir de nível"
  },
  TipsType_10216_Desc = {
    Text = "Elixir de gnose aumentado"
  },
  TipsType_10217_Desc = {
    Text = "Limite de iluminar atingido"
  },
  TipsType_10218_Desc = {
    Text = "Falha ao subir de nível"
  },
  TipsType_10219_Desc = {
    Text = "Faltam itens, não é possível atualizar"
  },
  TipsType_10220_Desc = {
    Text = "Lv. Máximo"
  },
  TipsType_10221_Desc = {
    Text = "Aprimoramento de Habilidade bem-sucedido"
  },
  TipsType_10222_Desc = {
    Text = "Sigilo Negro Insuficiente, não é possível comprar"
  },
  TipsType_10223_Desc = {Text = "Esgotado"},
  TipsType_10224_Desc = {
    Text = "Sigilo Negro Insuficiente, não é possível remover a carta de comando"
  },
  TipsType_10225_Desc = {
    Text = "Remover{s1} cartas de comando"
  },
  TipsType_10226_Desc = {
    Text = "Esta direção ainda não está aberta, não é possível fortalecer"
  },
  TipsType_10227_Desc = {
    Text = "Esta direção foi fortalecida até o nível máximo"
  },
  TipsType_10228_Desc = {
    Text = "Por favor, escolha a direção que deseja fortalecer do cartão exclusivo"
  },
  TipsType_10229_Desc = {
    Text = "Âncoras de Alma insuficientes, não é possível fortalecer"
  },
  TipsType_10230_Desc = {
    Text = "Ainda não possui despertos desta dimensão, não pode selecionar"
  },
  TipsType_10231_Desc = {
    Text = "Criar uma equipe"
  },
  TipsType_10232_Desc = {
    Text = "Nome da equipe não pode exceder {s1} caracteres chineses"
  },
  TipsType_10233_Desc = {
    Text = "Nome da equipe não pode ser vazio"
  },
  TipsType_10234_Desc = {
    Text = "Troca bem-sucedida"
  },
  TipsType_10235_Desc = {
    Text = "Sem mais \"Prata\""
  },
  TipsType_10236_Desc = {
    Text = "Não pode ser reduzido mais"
  },
  TipsType_10237_Desc = {
    Text = "{s1} ainda não disponível, aguarde"
  },
  TipsType_10238_Desc = {
    Text = "Invocação ainda não disponível, aguarde"
  },
  TipsType_10239_Desc = {
    Text = "Função de mini-mapa do campus ainda não disponível"
  },
  TipsType_10240_Desc = {
    Text = "Desbloqueado no nível da Tarefa {s1}"
  },
  TipsType_10241_Desc = {
    Text = "Nenhum cartão compatível"
  },
  TipsType_10242_Desc = {
    Text = "Todas as cartas de domínio foram atualizadas"
  },
  TipsType_10243_Desc = {
    Text = "Nenhum cartão de comando para upgrade"
  },
  TipsType_10244_Desc = {
    Text = "Novo ponto de teletransporte descoberto! Pode ir para {s1}"
  },
  TipsType_10245_Desc = {
    Text = "Já possui este item, não pode obter novamente"
  },
  TipsType_10246_Desc = {
    Text = "Recuperação bem-sucedida"
  },
  TipsType_10247_Desc = {
    Text = "Remoção bem-sucedida"
  },
  TipsType_10248_Desc = {
    Text = "Abrir a interface da mochila"
  },
  TipsType_10249_Desc = {
    Text = "Detectamos que você ficou offline de forma anômala na última vez, e já retornamos o \"Lingfétide\" e os suprimentos devidos. Você pode abrir a mochila para verificar."
  },
  TipsType_10250_Desc = {
    Text = "A versão AVG oferece apenas alguns edifícios, totalizando 17"
  },
  TipsType_10251_Desc = {
    Text = "A versão AVG oferece apenas alguns edifícios, totalizando 17"
  },
  TipsType_10252_Desc = {
    Text = "A versão AVG oferece apenas alguns edifícios, totalizando 17"
  },
  TipsType_10253_Desc = {
    Text = "A versão AVG oferece apenas alguns edifícios, totalizando 17"
  },
  TipsType_10254_Desc = {
    Text = "A versão AVG oferece apenas alguns edifícios, totalizando 17"
  },
  TipsType_10255_Desc = {
    Text = "A versão AVG oferece apenas alguns edifícios, totalizando 17"
  },
  TipsType_10256_Desc = {
    Text = "A versão AVG oferece apenas alguns edifícios, totalizando 17"
  },
  TipsType_10257_Desc = {
    Text = "A versão AVG oferece apenas alguns edifícios, totalizando 17"
  },
  TipsType_10258_Desc = {
    Text = "A versão AVG oferece apenas alguns edifícios, totalizando 17"
  },
  TipsType_10259_Desc = {
    Text = "A versão AVG oferece apenas alguns edifícios, totalizando 17"
  },
  TipsType_10260_Desc = {
    Text = "A versão AVG oferece apenas alguns edifícios, totalizando 17"
  },
  TipsType_10261_Desc = {
    Text = "A versão AVG oferece apenas alguns edifícios, totalizando 17"
  },
  TipsType_10262_Desc = {
    Text = "A versão AVG oferece apenas alguns edifícios, totalizando 17"
  },
  TipsType_10263_Desc = {
    Text = "A versão AVG oferece apenas alguns edifícios, totalizando 17"
  },
  TipsType_10264_Desc = {
    Text = "A versão AVG oferece apenas alguns edifícios, totalizando 17"
  },
  TipsType_10265_Desc = {
    Text = "A versão AVG oferece apenas alguns edifícios, totalizando 17"
  },
  TipsType_10266_Desc = {
    Text = "A versão AVG oferece apenas alguns edifícios, totalizando 17"
  },
  TipsType_10267_Desc = {
    Text = "Condições de uso não atendidas"
  },
  TipsType_10268_Desc = {
    Text = "Nível de Investigação 2 Desbloqueia Investigação Rápida"
  },
  TipsType_10269_Desc = {
    Text = "Conexão interrompida"
  },
  TipsType_10270_Desc = {
    Text = "A conexão do servidor foi interrompida, você retornará à página de login em breve"
  },
  TipsType_10271_Desc = {Text = "Confirmar"},
  TipsType_10272_Desc = {
    Text = "Servidor não disponível, tente novamente mais tarde"
  },
  TipsType_10273_Desc = {
    Text = "Operação bem-sucedida"
  },
  TipsType_10274_Desc = {
    Text = "Nenhum domínio correspondente encontrado"
  },
  TipsType_10275_Desc = {
    Text = "Evento do domínio secreto concluído"
  },
  TipsType_10276_Desc = {
    Text = "Erro na configuração do tipo de evento do domínio secreto"
  },
  TipsType_10277_Desc = {
    Text = "Evento do domínio secreto inexistente"
  },
  TipsType_10278_Desc = {
    Text = "Sigilo Negro Insuficiente, não é possível comprar"
  },
  TipsType_10279_Desc = {
    Text = "Este cartão não pode ser fortalecido"
  },
  TipsType_10280_Desc = {
    Text = "Este cartão atingiu o limite de fortalecimento"
  },
  TipsType_10281_Desc = {
    Text = "O comerciante não vende este item"
  },
  TipsType_10282_Desc = {
    Text = "Sem recompensa"
  },
  TipsType_10283_Desc = {
    Text = "Recompensa Recebida"
  },
  TipsType_10284_Desc = {
    Text = "Erro na tabela de configuração"
  },
  TipsType_10285_Desc = {
    Text = "Erro nos dados do evento"
  },
  TipsType_10286_Desc = {
    Text = "Produto comprado"
  },
  TipsType_10287_Desc = {
    Text = "Nenhum dado de unidade de tarefa encontrado"
  },
  TipsType_10288_Desc = {
    Text = "Módulo enviado, não precisa reenviar"
  },
  TipsType_10289_Desc = {
    Text = "Tópicos do módulo não concluídos, não pode ser enviado"
  },
  TipsType_10290_Desc = {
    Text = "Tarefa sem módulo"
  },
  TipsType_10291_Desc = {
    Text = "Sem dados de missão da fase"
  },
  TipsType_10292_Desc = {
    Text = "Erro de dados recebidos pelo cliente"
  },
  TipsType_10293_Desc = {
    Text = "Serviço não iniciado"
  },
  TipsType_10294_Desc = {
    Text = "Erro de dados do personagem"
  },
  TipsType_10295_Desc = {
    Text = "Sem personagem, crie um"
  },
  TipsType_10296_Desc = {
    Text = "Personagem já existente, não precisa criar novamente"
  },
  TipsType_10297_Desc = {
    Text = "Nome do personagem repetido"
  },
  TipsType_10298_Desc = {
    Text = "Erro no domínio"
  },
  TipsType_10299_Desc = {
    Text = "Esta linha de história ainda não foi desbloqueada, não é possível entrar"
  },
  TipsType_10300_Desc = {
    Text = "Aqui você pode ver os efeitos do terreno e informações dos monstros"
  },
  TipsType_10301_Desc = {
    Text = "{s1} atinge {s2} para desbloquear {s3}"
  },
  TipsType_10302_Desc = {
    Text = "{s1} atinge {s2} para desbloquear {s3}"
  },
  TipsType_10303_Desc = {
    Text = "Condições de desbloqueio do edifício não atendidas"
  },
  TipsType_10304_Desc = {
    Text = "Condições de atualização do edifício não atendidas"
  },
  TipsType_10305_Desc = {
    Text = "Materiais insuficientes para upgrade de construção"
  },
  TipsType_10306_Desc = {
    Text = "Recompensa de missão disponível"
  },
  TipsType_10307_Desc = {
    Text = "（Vida será reduzida em <Negative:10%%>）"
  },
  TipsType_10308_Desc = {
    Text = "No final de cada turno, ganhe um valor de <BuffTipBlock:Escudo> igual ao número de camadas de Proteção. Cada vez que sofrer dano, a Proteção diminui em <BuffTip:1> camada"
  },
  TipsType_10309_Desc = {
    Text = "Proteção múltipla"
  },
  TipsType_10310_Desc = {
    Text = "Energia abaixo do nível de alerta, risco de investigação aumentado"
  },
  TipsType_10311_Desc = {
    Text = "Energia abaixo do nível de alerta, risco de investigação extremo, deseja continuar?"
  },
  TipsType_10312_Desc = {
    Text = "Energia baixa, não pode entrar no domínio"
  },
  TipsType_10313_Desc = {
    Text = "Escolha uma carta exclusiva do mesmo nível"
  },
  TipsType_10314_Desc = {
    Text = "Desbloqueado na direção após o despertar do despertador no nível 2"
  },
  TipsType_10315_Desc = {
    Text = "Desbloqueado na direção após o despertar do despertador no nível 3"
  },
  TipsType_10316_Desc = {Text = "Atual"},
  TipsType_10317_Desc = {
    Text = "Todos os despertos não desbloquearam habilidades, não podem carregar"
  },
  TipsType_10318_Desc = {
    Text = "Toda a energia das habilidades do despertador está completa"
  },
  TipsType_10319_Desc = {Text = "Usado"},
  TipsType_10320_Desc = {
    Text = "Sigilo Negro Insuficiente"
  },
  TipsType_10321_Desc = {
    Text = "Sigilo Negro Insuficiente"
  },
  TipsType_10322_Desc = {
    Text = "Sigilo Negro Insuficiente"
  },
  TipsType_10323_Desc = {
    Text = "Não pode obter criações já existentes"
  },
  TipsType_10324_Desc = {
    Text = "Tentativas de atualização insuficientes"
  },
  TipsType_10325_Desc = {
    Text = "Causará {s1} de dano à nossa equipe"
  },
  TipsType_10326_Desc = {Text = "Ataque"},
  TipsType_10327_Desc = {
    Text = "Aqui será exibida a pré-visualização do mini-mapa do nível, permitindo que os jogadores planejem suas estratégias com antecedência"
  },
  TipsType_10328_Desc = {
    Text = "Você levou 10 minutos para completar um nível na missão diária, onde obteve uma experiência de jogo única e acabou reforçando sua compreensão de classe através do design do nível"
  },
  TipsType_10329_Desc = {
    Text = "Atualmente, a saúde máxima está abaixo de 50% da saúde máxima, por favor, tome cuidado"
  },
  TipsType_10330_Desc = {
    Text = "Energia para manter o corpo desperto. Receber dano reduz a vida, vida zero significa falha na investigação"
  },
  TipsType_10331_Desc = {
    Text = "A manifestação da intensidade de ataque do despertador. Quanto maior a força, maior o dano causado ao inimigo ao usar cartões de comando"
  },
  TipsType_10332_Desc = {
    Text = "A manifestação da capacidade de defesa do despertador. Quanto maior a alerta, mais escudo é obtido ao usar a carta de comando"
  },
  TipsType_10333_Desc = {
    Text = "Clique em qualquer lugar para continuar"
  },
  TipsType_10334_Desc = {
    Text = "Investigação de missão não concluída"
  },
  TipsType_10335_Desc = {
    Text = "Avaliação de Investigação"
  },
  TipsType_10336_Desc = {
    Text = "Conceder um Espírito de Revelação a um cartão exclusivo"
  },
  TipsType_10337_Desc = {
    Text = "Escolha a direção de fortalecimento do cartão exclusivo"
  },
  TipsType_10338_Desc = {
    Text = "Mapa da cidade principal ainda não disponível, aguarde"
  },
  TipsType_10339_Desc = {
    Text = "{s1}{s2} valor"
  },
  TipsType_10340_Desc = {
    Text = "Nível do baralho básico {s1} aumentado"
  },
  TipsType_10341_Desc = {
    Text = "<Positive:Grau de afinidade:>"
  },
  TipsType_10342_Desc = {
    Text = "Reflete a ligação emocional com os Despertos. Aumenta a afinidade, permitindo um entendimento mais profundo dos Despertos"
  },
  TipsType_10343_Desc = {
    Text = "<Positive:Nível atual:>{s1}"
  },
  TipsType_10344_Desc = {
    Text = "<Positive:Baralho básico:>"
  },
  TipsType_10345_Desc = {
    Text = "Baralho inicial ao entrar na masmorra deste domínio"
  },
  TipsType_10346_Desc = {
    Text = "<Positive:Nível máximo do baralho:>{s1}"
  },
  TipsType_10347_Desc = {
    Text = "<Positive:Nível do baralho:>"
  },
  TipsType_10348_Desc = {
    Text = "Quando o número especificado de Despertados neste domínio atingir o nível de afinidade especificado, o baralho básico pode ser atualizado"
  },
  TipsType_10349_Desc = {
    Text = "<Positive:Conteúdo da atualização:>"
  },
  TipsType_10350_Desc = {
    Text = "Cada nível aumenta o valor base de uma carta de comando"
  },
  TipsType_10351_Desc = {
    Text = "Aumento de afinidade {s1}"
  },
  TipsType_10352_Desc = {
    Text = "Domínio em silêncio"
  },
  TipsType_10353_Desc = {
    Text = "O domínio repele invasores"
  },
  TipsType_10354_Desc = {
    Text = "A repulsão do domínio aumentou"
  },
  TipsType_10355_Desc = {
    Text = "Rejeição atingindo {s1}, o domínio está te observando"
  },
  TipsType_10356_Desc = {Text = "Iluminar 1"},
  TipsType_10357_Desc = {
    Text = "Aprender a habilidade"
  },
  TipsType_10358_Desc = {
    Text = "Número máximo de tentáculos simultâneos"
  },
  TipsType_10359_Desc = {
    Text = "Reflete a intensidade do ataque dos tentáculos. Quanto maior a força dos tentáculos, maior o dano causado ao ativá-los"
  },
  TipsType_10360_Desc = {
    Text = "Não selecionou carta de comando"
  },
  TipsType_10361_Desc = {
    Text = "Mudança bem-sucedida"
  },
  TipsType_10362_Desc = {
    Text = "Não selecionou carta de comando"
  },
  TipsType_10363_Desc = {
    Text = "Cópia bem-sucedida"
  },
  TipsType_10364_Desc = {
    Text = "{s1} cartas de comando selecionadas"
  },
  TipsType_10365_Desc = {
    Text = "Não selecionou carta de comando"
  },
  TipsType_10366_Desc = {
    Text = "Não selecionou carta de comando"
  },
  TipsType_10367_Desc = {
    Text = "Sucesso ao subir de nível"
  },
  TipsType_10368_Desc = {
    Text = "Interface de Mochila de Criação em desenvolvimento, aguarde"
  },
  TipsType_10369_Desc = {
    Text = "Escolha a criação a modificar"
  },
  TipsType_10370_Desc = {
    Text = "Atualização de versão, por favor, reinstale o pacote"
  },
  TipsType_10371_Desc = {
    Text = "Efeito avançado"
  },
  TipsType_10372_Desc = {
    Text = "Informações do domínio secreto"
  },
  TipsType_10373_Desc = {
    Text = "Cada vez que usar uma carta de dano, os tentáculos causam {s1} de dano a um inimigo aleatório"
  },
  TipsType_10374_Desc = {
    Text = "Nenhum tópico pendente"
  },
  TipsType_10375_Desc = {
    Text = "Nenhum tópico arquivado"
  },
  TipsType_10376_Desc = {
    Text = "Investigação incompleta"
  },
  TipsType_10377_Desc = {
    Text = "Não pode retroceder"
  },
  TipsType_10378_Desc = {
    Text = "(Os seguintes tópicos foram arquivados automaticamente)"
  },
  TipsType_10379_Desc = {
    Text = "Tarefa alvo concluída"
  },
  TipsType_10380_Desc = {
    Text = "Você não tem este item"
  },
  TipsType_10381_Desc = {
    Text = "Índice Errado"
  },
  TipsType_10382_Desc = {
    Text = "Não desbloqueado"
  },
  TipsType_10383_Desc = {
    Text = "Sem tentativas para melhorar carta exclusiva"
  },
  TipsType_10384_Desc = {
    Text = "Desbloqueado 1 slot de item!"
  },
  TipsType_10385_Desc = {
    Text = "A taxa de conexão aumentou"
  },
  TipsType_10386_Desc = {
    Text = "Sem informações de slots"
  },
  TipsType_10387_Desc = {
    Text = "Moeda insuficiente"
  },
  TipsType_10388_Desc = {
    Text = "Nível máximo atingido"
  },
  TipsType_10389_Desc = {
    Text = "Em desenvolvimento, aguarde"
  },
  TipsType_10390_Desc = {
    Text = "Sem mais tentativas de upgrade manual"
  },
  TipsType_10391_Desc = {
    Text = "Pode ser usado após quebrar o selo na loja ou no acampamento"
  },
  TipsType_10392_Desc = {
    Text = "Perdeu {s1} de vigor nesta batalha"
  },
  TipsType_10393_Desc = {
    Text = "Energia dos Despertos cheia, não pode ser aumentada"
  },
  TipsType_10394_Desc = {
    Text = "Energia de todos os Despertados aumentada"
  },
  TipsType_10395_Desc = {
    Text = "Requer o uso do \"Olho\" para desbloquear"
  },
  TipsType_10396_Desc = {
    Text = "Marcações bem-sucedidas"
  },
  TipsType_10397_Desc = {
    Text = "Já em campo {s1} Despertado, a equipe terá a característica de domínio {s2}"
  },
  TipsType_10398_Desc = {
    Text = "A equipe se tornará neutra, sem características de domínio"
  },
  TipsType_10399_Desc = {
    Text = "O sistema de microciclo é desbloqueado no capítulo quatro"
  },
  TipsType_10400_Desc = {
    Text = "Pode herdar até {s1} criações, reduza o número de criações selecionadas"
  },
  TipsType_10401_Desc = {
    Text = "Criação não marcada não pode ser herdada"
  },
  TipsType_10405_Desc = {
    Text = "Obtenha {s1}"
  },
  TipsType_10406_Desc = {
    Text = "Limite de despertos na equipe atingido"
  },
  TipsType_10407_Desc = {
    Text = "Esta Torre de Ouro não pode ser desafiada"
  },
  TipsType_10408_Desc = {
    Text = "Esta Torre de Ouro não foi desbloqueada- complete a masmorra de investigação especificada"
  },
  TipsType_10409_Desc = {
    Text = "Escolha o Despertado para a batalha"
  },
  TipsType_10410_Desc = {
    Text = "O despertador está se esforçando para completar as tarefas de envio, volte mais tarde para receber"
  },
  TipsType_10411_Desc = {
    Text = "{s1} rosas douradas recebidas"
  },
  TipsType_10412_Desc = {
    Text = "A recompensa temporal precisa acumular com o tempo"
  },
  TipsType_10413_Desc = {
    Text = "\"Prata\" insuficiente"
  },
  TipsType_10414_Desc = {
    Text = "Sem tentativas de desafio"
  },
  TipsType_10415_Desc = {
    Text = "Desafio em cooldown"
  },
  TipsType_10416_Desc = {
    Text = "Sem oponentes para desafiar"
  },
  TipsType_10417_Desc = {
    Text = "Escolha o Despertado para a equipe"
  },
  TipsType_10418_Desc = {
    Text = "Elixir de gnose insuficiente, não pode continuar a subir de nível"
  },
  TipsType_10419_Desc = {
    Text = "Nível máximo atingido"
  },
  TipsType_10420_Desc = {
    Text = "Despertado não desbloqueado"
  },
  TipsType_10421_Desc = {
    Text = "Cancelamento de coleção bem-sucedido"
  },
  TipsType_10422_Desc = {
    Text = "Tentativas de desafio da linha de enredo insuficientes"
  },
  TipsType_10423_Desc = {
    Text = "Estrelas insuficientes na linha de enredo, não é possível varrer"
  },
  TipsType_10424_Desc = {
    Text = "Erro na Formação da Equipe de Investigação"
  },
  TipsType_10425_Desc = {
    Text = "\"Prata\" insuficiente"
  },
  TipsType_10426_Desc = {
    Text = "Número máximo de compras de vouchers atingido hoje"
  },
  TipsType_10427_Desc = {
    Text = "Desbloqueado após três fases concluídas no reino secreto"
  },
  TipsType_10428_Desc = {
    Text = "Obteve com sucesso {s1} voucher"
  },
  TipsType_10429_Desc = {
    Text = "Obteve com sucesso {s1} tentativas de desafio"
  },
  TipsType_10430_Desc = {
    Text = "Concluir Investigação 4-6 para desbloquear"
  },
  TipsType_10431_Desc = {
    Text = "Prova insuficiente"
  },
  TipsType_10432_Desc = {
    Text = "Número de compras com comprovante insuficiente"
  },
  TipsType_10433_Desc = {
    Text = "Nível de iluminação já atingiu o limite"
  },
  TipsType_10434_Desc = {
    Text = "\"{s1}\" é insuficiente"
  },
  TipsType_10435_Desc = {
    Text = "Sem este item à venda"
  },
  TipsType_10436_Desc = {
    Text = "Sem este tipo de loja"
  },
  TipsType_10437_Desc = {
    Text = "O item à venda está fora de estoque"
  },
  TipsType_10438_Desc = {
    Text = "Sem dados da loja"
  },
  TipsType_10439_Desc = {
    Text = "Sem tentativas de atualização"
  },
  TipsType_10440_Desc = {
    Text = "Hoje, o número de compras de \"Lingfétide\" alcançou o limite."
  },
  TipsType_10441_Desc = {
    Text = "Fragmentos do Despertado insuficientes"
  },
  TipsType_10442_Desc = {
    Text = "Ponto de iluminação ativado"
  },
  TipsType_10443_Desc = {
    Text = "Ponto de iluminação frontal não ativado"
  },
  TipsType_10444_Desc = {
    Text = "Sucesso ao comprar \"Lingfétide\" × {s1}."
  },
  TipsType_10445_Desc = {
    Text = "\"Lingfétide\" atingiu o limite"
  },
  TipsType_10446_Desc = {
    Text = "Conclua Investigação 1-12 para desbloquear"
  },
  TipsType_10447_Desc = {
    Text = "Conclua Prólogo para desbloquear"
  },
  TipsType_10448_Desc = {
    Text = "Conclua Prólogo para desbloquear"
  },
  TipsType_10449_Desc = {
    Text = "Conclua Investigação 2-4 para desbloquear"
  },
  TipsType_10450_Desc = {
    Text = "Este nível de habilidade já atingiu o limite"
  },
  TipsType_10451_Desc = {
    Text = "Nível de despertador insuficiente para a ascensão"
  },
  TipsType_10452_Desc = {
    Text = "Material de aprimoramento de habilidade insuficiente"
  },
  TipsType_10453_Desc = {
    Text = "Conclua Investigação 3-15 para desbloquear"
  },
  TipsType_10454_Desc = {
    Text = "Conclua Investigação 3-7 para desbloquear"
  },
  TipsType_10455_Desc = {
    Text = "Condições para aprimoramento de habilidade não atendidas"
  },
  TipsType_10456_Desc = {
    Text = "Cada item de recarga na versão de teste só pode ser recarregado uma vez"
  },
  TipsType_10457_Desc = {
    Text = "Este despertador está em cooldown da chegada do gênio, libera na próxima rodada"
  },
  TipsType_10458_Desc = {
    Text = "Configuração de recarga não encontrada"
  },
  TipsType_10459_Desc = {
    Text = "Recarga gratuita já feita, não pode recarregar novamente"
  },
  TipsType_10460_Desc = {
    Text = "Ressonância já ativada, não é necessário reativar"
  },
  TipsType_10461_Desc = {
    Text = "O preço do item {s1} foi alterado, por favor verifique"
  },
  TipsType_10462_Desc = {
    Text = "Rosa dourada insuficiente"
  },
  TipsType_10463_Desc = {
    Text = "\"Insignia de treinamento\" insuficiente"
  },
  TipsType_10464_Desc = {
    Text = "Concluir Investigação 3-4 para desbloquear"
  },
  TipsType_10465_Desc = {
    Text = "Concluir Investigação 2-16 para desbloquear"
  },
  TipsType_10466_Desc = {
    Text = "Concluir Investigação 3-16 para desbloquear"
  },
  TipsType_10467_Desc = {
    Text = "Concluir Investigação 4-12 para desbloquear"
  },
  TipsType_10468_Desc = {
    Text = "Concluir Investigação 5-12 para desbloquear"
  },
  TipsType_10469_Desc = {
    Text = "Concluir Investigação 6-12 para desbloquear"
  },
  TipsType_10470_Desc = {
    Text = "Concluir Investigação 1-7 para desbloquear"
  },
  TipsType_10471_Desc = {
    Text = "Equipamento bem-sucedido"
  },
  TipsType_10472_Desc = {
    Text = "Descarregado com sucesso"
  },
  TipsType_10473_Desc = {
    Text = "Nível máximo atingido"
  },
  TipsType_10474_Desc = {
    Text = "Rosa dourada insuficiente"
  },
  TipsType_10475_Desc = {
    Text = "Escolha os materiais"
  },
  TipsType_10476_Desc = {
    Text = "Protegido por bloqueio, desbloqueie primeiro"
  },
  TipsType_10477_Desc = {
    Text = "Fase não disponível"
  },
  TipsType_10478_Desc = {
    Text = "Batalha fora não disponível"
  },
  TipsType_10479_Desc = {
    Text = "Pilha de Descarte vazia"
  },
  TipsType_10480_Desc = {
    Text = "Ajuste da batalha RPG em andamento, vitória calculada diretamente"
  },
  TipsType_10482_Desc = {
    Text = "Roda do destino bloqueada"
  },
  TipsType_10483_Desc = {
    Text = "Roda do destino não encontrada"
  },
  TipsType_10484_Desc = {
    Text = "Roda do destino atingiu o nível máximo"
  },
  TipsType_10485_Desc = {
    Text = "Roda do destino equipada"
  },
  TipsType_10486_Desc = {
    Text = "Roda do destino incompatível"
  },
  TipsType_10487_Desc = {
    Text = "Roda do destino não bloqueada"
  },
  TipsType_10488_Desc = {
    Text = "Em um pacto no \"formação\" e \"assistência\", não pode ser desfeito"
  },
  TipsType_10489_Desc = {
    Text = "Em uma roda do destino no \"formação\" e \"assistência\", não pode ser desfeito"
  },
  TipsType_10490_Desc = {
    Text = "A quantidade de aliemus é insufficiente, não é possível liberar explosão de aliemus"
  },
  TipsType_10491_Desc = {
    Text = "Por favor, pegue o pacote anterior primeiro"
  },
  TipsType_10492_Desc = {
    Text = "O pacto atual está bloqueado, desbloqueie para consumo de recursos"
  },
  TipsType_10493_Desc = {
    Text = "A roda do destino atual está bloqueada, desbloqueie para consumo de recursos"
  },
  TipsType_10494_Desc = {
    Text = "Concluir Investigação 1-7 para desbloquear"
  },
  TipsType_10495_Desc = {
    Text = "Concluir Investigação 1-13 para desbloquear"
  },
  TipsType_10496_Desc = {
    Text = "O nível atual do pacto já está no máximo"
  },
  TipsType_10497_Desc = {
    Text = "Loja redefinida"
  },
  TipsType_10498_Desc = {
    Text = "Troca bem-sucedida"
  },
  TipsType_10499_Desc = {
    Text = "Coleção bem-sucedida"
  },
  TipsType_10500_Desc = {
    Text = "Empilhamento bem-sucedido"
  },
  TipsType_10501_Desc = {
    Text = "Desafio não desbloqueado"
  },
  TipsType_10502_Desc = {
    Text = "Despertado em desafio em outro nível de {s1}, não pode lutar novamente"
  },
  TipsType_10503_Desc = {
    Text = "Menos de 4 despertos na equipe, não é possível desafiar"
  },
  TipsType_10504_Desc = {
    Text = "Concluir Investigação 3-7 para desbloquear"
  },
  TipsType_10505_Desc = {
    Text = "Desbloqueado ao alcançar 3 estrelas no nível 1"
  },
  TipsType_10506_Desc = {
    Text = "Desbloqueado ao alcançar 3 estrelas no nível 2"
  },
  TipsType_10507_Desc = {
    Text = "Desbloqueado ao alcançar 3 estrelas no nível 3"
  },
  TipsType_10508_Desc = {
    Text = "Desbloqueado ao alcançar 3 estrelas no nível 4"
  },
  TipsType_10509_Desc = {
    Text = "Desbloqueado ao alcançar 3 estrelas no nível 5"
  },
  TipsType_10510_Desc = {
    Text = "Desbloqueado ao alcançar 3 estrelas no nível 6"
  },
  TipsType_10511_Desc = {
    Text = "Desbloqueado ao alcançar 3 estrelas no nível 7"
  },
  TipsType_10512_Desc = {
    Text = "Desbloqueado ao alcançar 3 estrelas no nível 8"
  },
  TipsType_10513_Desc = {
    Text = "Por favor, escolha o pacto que deseja fortalecer"
  },
  TipsType_10514_Desc = {Text = "Recebido"},
  TipsType_10515_Desc = {
    Text = "Concluir Investigação 2-14 para desbloquear"
  },
  TipsType_10516_Desc = {
    Text = "Concluir Investigação 4-7 para desbloquear"
  },
  TipsType_10517_Desc = {
    Text = "Concluir Investigação 4-7 para desbloquear"
  },
  TipsType_10518_Desc = {
    Text = "Formação salva"
  },
  TipsType_10519_Desc = {
    Text = "Toque a área iluminada para mover-se"
  },
  TipsType_10520_Desc = {
    Text = "Nome da equipe não pode conter caracteres além de chinês, inglês e números"
  },
  TipsType_10521_Desc = {
    Text = "Nome da equipe não pode ter mais de 8 caracteres"
  },
  TipsType_10522_Desc = {
    Text = "Número insuficiente de Despertos na equipe, precisa de {s1} para investigar"
  },
  TipsType_10523_Desc = {
    Text = "O despertador já participou de outras batalhas em domínios na dimensão sombria nesta camada"
  },
  TipsType_10524_Desc = {
    Text = "Já existem despertados de dois domínios na equipe, não é possível selecionar despertados de outros domínios"
  },
  TipsType_10525_Desc = {
    Text = "Selecione um Despertado"
  },
  TipsType_10526_Desc = {
    Text = "Não pode selecionar mais despertos"
  },
  TipsType_10527_Desc = {
    Text = "Nota de desenvolvimento: Durante o mergulho fantasmal, os níveis de despertador e habilidade são ajustados para o nível 1"
  },
  TipsType_10528_Desc = {
    Text = "Nome da equipe não pode ser vazio"
  },
  TipsType_10529_Desc = {
    Text = "Na equipe, há um despertador que está exausto e não pode mais lutar"
  },
  TipsType_10530_Desc = {
    Text = "Todos os anexos da caixa de correio foram recebidos"
  },
  TipsType_10531_Desc = {
    Text = "Concluir o prólogo para desbloquear"
  },
  TipsType_10532_Desc = {
    Text = "Mochila cheia, não foi possível coletar tudo, limpe a mochila para continuar"
  },
  TipsType_10533_Desc = {
    Text = "Mochila cheia, recompensas serão enviadas para o correio"
  },
  TipsType_10534_Desc = {
    Text = "A mochila está cheia, os suprimentos não foram totalmente recebidos, é necessário limpar a mochila antes de continuar a recepção"
  },
  TipsType_10535_Desc = {
    Text = "Sem anexos de carta para receber"
  },
  TipsType_10536_Desc = {
    Text = "Por favor, troque a criação primeiro"
  },
  TipsType_10537_Desc = {
    Text = "Conclua Investigação 2-4 para desbloquear"
  },
  TipsType_10538_Desc = {
    Text = "Conclua Investigação 1-12 para desbloquear"
  },
  TipsType_10539_Desc = {
    Text = "Conclua Investigação 1-12 para desbloquear"
  },
  TipsType_10540_Desc = {
    Text = "Conclua Investigação 1-12 para desbloquear"
  },
  TipsType_10541_Desc = {
    Text = "Desbloqueado ao alcançar 3 estrelas no nível 9"
  },
  TipsType_10542_Desc = {
    Text = "Desbloqueado ao alcançar 3 estrelas no nível 10"
  },
  TipsType_10543_Desc = {
    Text = "Desbloqueado ao alcançar 3 estrelas no nível 11"
  },
  TipsType_10544_Desc = {
    Text = "Desbloqueado ao alcançar 3 estrelas no nível 12"
  },
  TipsType_10545_Desc = {
    Text = "Desbloqueado ao alcançar 3 estrelas no nível 13"
  },
  TipsType_10546_Desc = {
    Text = "Desbloqueado ao alcançar 3 estrelas no nível 14"
  },
  TipsType_10547_Desc = {
    Text = "Função será removida"
  },
  TipsType_10548_Desc = {
    Text = "Conclua Investigação 1-7 para desbloquear"
  },
  TipsType_10549_Desc = {
    Text = "Limite de Criação atingido, não é possível obter mais"
  },
  TipsType_10550_Desc = {
    Text = "{s1} link completo, agora você pode comandá-la em batalha!"
  },
  TipsType_10551_Desc = {
    Text = "{s1} o nível e o nível de habilidade ultrapassaram os níveis fornecidos pelo amplificador de gnose, não é possível usar"
  },
  TipsType_10552_Desc = {
    Text = "O nível do despertador e o nível da habilidade excederam o nível fornecido pelo amplificador de gnose, não podem ser usados"
  },
  TipsType_10553_Desc = {Text = "Aguarde"},
  TipsType_10554_Desc = {
    Text = "Desbloqueado após passar a fase anterior"
  },
  TipsType_10555_Desc = {
    Text = "Caminho frágil sem retorno"
  },
  TipsType_10556_Desc = {
    Text = "Ainda não disponível, aguarde"
  },
  TipsType_10557_Desc = {
    Text = "Já possui esta criação, não pode obter novamente"
  },
  TipsType_10558_Desc = {
    Text = "Sobre recuperar o conteúdo da área de transferência do sistema e <Positive:[Colar]> isso, \nConfirmar?"
  },
  TipsType_10558_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10558_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10558_Title = {
    Text = "Ativar função de colar"
  },
  TipsType_10559_Desc = {
    Text = "Materiais de Edificação insuficientes"
  },
  TipsType_10560_Desc = {
    Text = "Já está no estado inicial"
  },
  TipsType_10561_Desc = {
    Text = "Rosa dourada insuficiente"
  },
  TipsType_10562_Desc = {
    Text = "Não elevado"
  },
  TipsType_10563_Desc = {
    Text = "Ressonância redefinida com sucesso"
  },
  TipsType_10564_Desc = {
    Text = "Nível de Investigação {s1} Alcançado"
  },
  TipsType_10565_Desc = {
    Text = "A loucura selada não pode ser liberada"
  },
  TipsType_1056601_Desc = {
    Text = "Anomalia na comunicação do chip de prata, por favor, verifique a rede e tente novamente({s1})"
  },
  TipsType_10566_Desc = {
    Text = "Comunicação de núcleo de prata anormal, por favor, tente novamente mais tarde ({s1})"
  },
  TipsType_10567_Desc = {
    Text = "Falha ao obter informações do servidor! {s1}"
  },
  TipsType_10568_Desc = {
    Text = "Por favor, escolha o servidor primeiro"
  },
  TipsType_10569_Desc = {
    Text = "Não desbloqueado"
  },
  TipsType_10570_Desc = {
    Text = "Insira a conta"
  },
  TipsType_10571_Desc = {
    Text = "Materiais de ativação de ressonância insuficientes"
  },
  TipsType_10572_Desc = {
    Text = "Ponto de ressonância anterior não atualizado"
  },
  TipsType_10573_Desc = {
    Text = "Nível máximo"
  },
  TipsType_10574_Desc = {
    Text = "Sucesso ao subir de nível"
  },
  TipsType_10575_Desc = {
    Text = "Este Despertado não pode ser trocado"
  },
  TipsType_10576_Desc = {
    Text = "Posição indisponível para batalha"
  },
  TipsType_10577_Desc = {
    Text = "Número insuficiente de Despertados, não pode desafiar"
  },
  TipsType_10578_Desc = {
    Text = "Ainda não desbloqueado o próximo nível"
  },
  TipsType_10579_Desc = {
    Text = "Já é a última fase"
  },
  TipsType_10580_Desc = {
    Text = "Limite de experiência atual atingido, não pode adicionar"
  },
  TipsType_10581_Desc = {
    Text = "Slot da roda do destino cheio, não pode adicionar"
  },
  TipsType_10582_Desc = {
    Text = "Nenhum material rápido disponível"
  },
  TipsType_10583_Desc = {
    Text = "Por favor, coloque os recursos no slot do ciclo de vida"
  },
  TipsType_10584_Desc = {
    Text = "Sem rodas da vida para equipar"
  },
  TipsType_10585_Desc = {
    Text = "Conclua Investigação 2-8 para desbloquear"
  },
  TipsType_10586_Desc = {
    Text = "Conclua Investigação 2-14 para desbloquear"
  },
  TipsType_10587_Desc = {
    Text = "Conclua Investigação 3-16 para desbloquear"
  },
  TipsType_10588_Desc = {
    Text = "Conclua Investigação 4-12 para desbloquear"
  },
  TipsType_10589_Desc = {
    Text = "Conclua Investigação 5-12 para desbloquear"
  },
  TipsType_10590_Desc = {
    Text = "Conclua Investigação 6-12 para desbloquear"
  },
  TipsType_10591_Desc = {
    Text = "Conclua Investigação 2-12 para desbloquear"
  },
  TipsType_10592_Desc = {
    Text = "Este usuário foi banido, entre em contato com o suporte se tiver dúvidas"
  },
  TipsType_10593_Desc = {
    Text = "Sessão de login expirou, faça login novamente"
  },
  TipsType_10594_Desc = {
    Text = "\"Lingfétide\" insuficiente"
  },
  TipsType_10595_Desc = {
    Text = "Deseja ativar \"{s1}\"?"
  },
  TipsType_10595_Title = {
    Text = "Ativar talento"
  },
  TipsType_10596_Desc = {
    Text = "Ainda não obteve o Despertado"
  },
  TipsType_10597_Desc = {
    Text = "Sem rodas da vida para fortalecer"
  },
  TipsType_10598_Desc = {
    Text = "Esta conta foi banida por violar as regras até {s1}, entre em contato com o suporte se tiver dúvidas"
  },
  TipsType_10599_Desc = {
    Text = "Concluir Investigação 2-15 para desbloquear"
  },
  TipsType_10600_Desc = {
    Text = "Limite de nível atingido, não pode adicionar mais"
  },
  TipsType_10601_Desc = {
    Text = "Desbloqueia o Registro de Crescimento do Guardião após concluir a investigação 1-7"
  },
  TipsType_10602_Desc = {
    Text = "Desbloqueia a missão de domínio após concluir a investigação 1-7"
  },
  TipsType_10603_Desc = {
    Text = "Não selecionou material"
  },
  TipsType_10604_Desc = {
    Text = "Inatividade prolongada, saindo automaticamente da instância"
  },
  TipsType_10605_Desc = {
    Text = "Questionário concluído, obrigado pelo seu apoio!"
  },
  TipsType_10606_Desc = {
    Text = "Material insuficiente para ativação"
  },
  TipsType_10607_Desc = {
    Text = "Recompensas semanais esgotadas, não receberá mais recompensas após o desafio. Deseja continuar?"
  },
  TipsType_10607_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10607_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10607_Title = {
    Text = "Dica de desafio"
  },
  TipsType_10608_Desc = {
    Text = "Manutenção do campus em andamento, aguarde a conclusão"
  },
  TipsType_10609_Desc = {
    Text = "Convidou com sucesso {s1} para seu dormitório"
  },
  TipsType_10610_Desc = {
    Text = "{s1} já está no seu dormitório"
  },
  TipsType_10611_Desc = {
    Text = "Rede atual não é Wi-Fi. Deseja usar dados móveis para continuar o download?"
  },
  TipsType_10611_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10611_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10611_Title = {
    Text = "Confirmação de download"
  },
  TipsType_10612_Desc = {
    Text = "Todas as cartas foram gravadas"
  },
  TipsType_10613_Desc = {
    Text = "Erro de Rede, por favor, aguarde"
  },
  TipsType_10614_Desc = {
    Text = "Desafio não desbloqueado"
  },
  TipsType_10615_Desc = {
    Text = "Resfriando, só pode usar no próximo turno"
  },
  TipsType_10616_Desc = {
    Text = "Em seleção, só pode liberar após escolher"
  },
  TipsType_10617_Desc = {
    Text = "No estado Selar, incapaz de desencadear Fúria Explosiva."
  },
  TipsType_10618_Desc = {
    Text = "Nível médio da equipe {s1} abaixo do recomendado {s2}, pode ser desafiador. Confirmar?"
  },
  TipsType_10618_LeftBtnDesc = {
    Text = "Ir para Melhorar"
  },
  TipsType_10618_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10618_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_10619_Desc = {
    Text = "Nível de Investigação {s1} Necessário"
  },
  TipsType_10620_Desc = {
    Text = "Conexão de rede instável, por favor verifique a conexão com o Steam ou reinicie o Steam e tente novamente"
  },
  TipsType_10621_Desc = {
    Text = "Deseja confirmar o uso de <WeaponEffect_Num:{s1}> como seu nome?"
  },
  TipsType_10621_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10621_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10621_Title = {
    Text = "Confirmação de Gravação"
  },
  TipsType_10622_Desc = {
    Text = "Gravação em resfriamento, {s1}h {s2}m para gravar novamente"
  },
  TipsType_10623_Desc = {
    Text = "Gravação bem-sucedida"
  },
  TipsType_10624_Desc = {
    Text = "Nome só pode conter chinês, inglês e números"
  },
  TipsType_10625_Desc = {
    Text = "Carta será descartada"
  },
  TipsType_10626_Desc = {
    Text = "No Steam, por favor ative a seguinte configuração: \n[Configurações do Steam - Dentro do Jogo - Ativar a Sobreposição do Steam]\ne reinicie o jogo para que tenha efeito."
  },
  TipsType_10626_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10626_Title = {Text = "Dica"},
  TipsType_10628_Desc = {
    Text = "O novo nome não pode ser igual ao atual"
  },
  TipsType_10629_Desc = {
    Text = "Insira {s1}~{s2} caracteres"
  },
  TipsType_10630_Desc = {
    Text = "{s1} pode ser recriado após obter três estrelas"
  },
  TipsType_10631_Desc = {
    Text = "Sua conta foi desconectada por violar as regras"
  },
  TipsType_10631_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10631_Title = {Text = "Aviso"},
  TipsType_10632_Desc = {
    Text = "Após concluir o desafio, a repetição estará disponível hoje"
  },
  TipsType_10633_Desc = {
    Text = "Esta decomposição consumirá os seguintes materiais, <Blue:Após a decomposição, não poderá ser recuperado>, você confirma a decomposição?"
  },
  TipsType_10633_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10633_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10633_Title = {
    Text = "Confirmar desmontagem"
  },
  TipsType_10634_Desc = {
    Text = "Dias restantes do passe mensal excedem {s1}, não pode acumular"
  },
  TipsType_10635_Desc = {
    Text = "\"Líquido de Origem de Núcleo de Prata\" insuficiente. Deseja ir para a Extração de primordial de prata?"
  },
  TipsType_10635_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10635_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10635_Title = {
    Text = "Suprimento de primordial de prata insuficiente"
  },
  TipsType_10636_Desc = {
    Text = "Nenhuma roda de destino ociosa"
  },
  TipsType_10637_Desc = {
    Text = "Nenhum pacto ocioso"
  },
  TipsType_10638_Desc = {
    Text = "Sem espaço para equipar pacto, desmonte um primeiro"
  },
  TipsType_10640_Desc = {
    Text = "Confirmar remoção de todos os pactos deste despertar?"
  },
  TipsType_10640_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10640_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10640_Title = {Text = "Dica"},
  TipsType_10641_Desc = {
    Text = "Reinicie o cliente para aplicar a mudança de idioma, confirmar?"
  },
  TipsType_10641_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10641_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10641_Title = {
    Text = "Confirmar mudança de idioma"
  },
  TipsType_10642_Desc = {
    Text = "Nível do Jogador Insuficiente"
  },
  TipsType_10643_Desc = {
    Text = "Entrar na área corroída reduz {s1} pontos de vida"
  },
  TipsType_10644_Desc = {
    Text = "Chave selecionada"
  },
  TipsType_10645_Desc = {
    Text = "Não obteve a chave"
  },
  TipsType_10646_Desc = {
    Text = "\"{s1}\" é insuficiente"
  },
  TipsType_10647_Desc = {
    Text = "A investigação do evento ainda não foi iniciada, {s1}"
  },
  TipsType_10648_Desc = {
    Text = "Intervalo de transição atualizado"
  },
  TipsType_10649_Desc = {
    Text = "Atualmente, o número máximo de enviáveis foi alcançado"
  },
  TipsType_10650_Desc = {
    Text = "Nenhum personagem SSR desbloqueado"
  },
  TipsType_10651_Desc = {
    Text = "Só pode ser usado após alcançar uma certa quantidade coletada"
  },
  TipsType_10652_Desc = {
    Text = "Atualmente, não há ícones ou expressões de batalha não adquiridos"
  },
  TipsType_10701_Desc = {
    Text = "Roda do destino equipada, remova e tente novamente"
  },
  TipsType_10702_Desc = {
    Text = "Quando a Roda do Destino SSR equipada atingir 12 camadas extras, você poderá equipar duas Rodas do Destino SSR ao mesmo tempo"
  },
  TipsType_10703_Desc = {
    Text = "Despertado já equipado com o mesmo destino, não pode equipar novamente"
  },
  TipsType_10704_Desc = {
    Text = "O nível do pacto atingiu o limite"
  },
  TipsType_10705_Desc = {
    Text = "Limite de materiais atingido"
  },
  TipsType_10706_Desc = {
    Text = "Pode travar até dois subatributos"
  },
  TipsType_10707_Desc = {
    Text = "Materiais insuficientes para transcrição"
  },
  TipsType_10708_Desc = {
    Text = "Desbloqueado após o despertar do despertador no nível {s1}"
  },
  TipsType_10709_Desc = {
    Text = "\"{s1}\" é insuficiente"
  },
  TipsType_10710_Desc = {Text = "Esgotado"},
  TipsType_10711_Desc = {
    Text = "Este item não está desbloqueado"
  },
  TipsType_10712_Desc = {
    Text = "Materiais cheios"
  },
  TipsType_10713_Desc = {
    Text = "Acúmulo da roda do destino atingiu o limite"
  },
  TipsType_10714_Desc = {
    Text = "Condições do evento não atendidas, não pode escolher"
  },
  TipsType_10715_Desc = {
    Text = "Por favor, instale o app correspondente antes de compartilhar"
  },
  TipsType_10716_Desc = {
    Text = "Não pode selecionar mais rodas do destino"
  },
  TipsType_10717_Desc = {
    Text = "Não pode selecionar mais chaves"
  },
  TipsType_10718_Desc = {
    Text = "Ativação bem-sucedida"
  },
  TipsType_10719_Desc = {
    Text = "Selo de mil faces insuficiente. Você pode converter materiais automaticamente em \"Configurações de Exchange\""
  },
  TipsType_10720_Desc = {
    Text = "Mudou para 1x"
  },
  TipsType_10721_Desc = {
    Text = "Mudou para 2x"
  },
  TipsType_10722_Desc = {
    Text = "Entrada do campus congestionada, tente novamente mais tarde"
  },
  TipsType_10723_Desc = {
    Text = "Salvo com sucesso"
  },
  TipsType_10724_Desc = {
    Text = "Falha ao salvar, permissão de álbum não concedida ou memória insuficiente"
  },
  TipsType_10725_Desc = {
    Text = "Materiais insuficientes"
  },
  TipsType_10726_Desc = {
    Text = "Por favor, escolha um cartão"
  },
  TipsType_10727_Desc = {
    Text = "Este Despertado foi desativado"
  },
  TipsType_10728_Desc = {
    Text = "Forma de Gênesis não pode ser enviada, por favor, escolha novamente"
  },
  TipsType_10736_Desc = {
    Text = "\"Lingfétide\" é suficiente, não precisa ser reabastecido."
  },
  TipsType_10737_Desc = {
    Text = "Nova versão do jogo detectada. Reinicie o jogo para atualizar e garantir uma experiência normal"
  },
  TipsType_10738_Desc = {
    Text = "Nenhuma instrução pendente"
  },
  TipsType_10739_Desc = {
    Text = "{s1} já desafiou em {s2}, não pode participar novamente"
  },
  TipsType_10740_Desc = {
    Text = "Nível de investigação {s1} abaixo do recomendado {s2}, pode ser desafiador. Confirmar?"
  },
  TipsType_10740_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10740_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10740_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_10741_Desc = {
    Text = "Nível médio da equipe {s1} e nível de investigação do Guardião {s2} abaixo do recomendado, pode ser muito desafiador. Confirmar?"
  },
  TipsType_10741_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10741_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10741_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_10742_Desc = {
    Text = "Efeito de Mandala duplicado na equipe, <Blue:{s1}> não está ativo, recomenda-se ajustar antes de investigar.\nDeseja continuar?"
  },
  TipsType_10742_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10742_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10742_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_10743_Desc = {
    Text = "Sem tentativas de assistência restantes na Zona de Desastre de Fusão"
  },
  TipsType_10744_Desc = {
    Text = "Limite de seguidores atingido"
  },
  TipsType_10745_Desc = {
    Text = "Data de aniversário incorreta, não é possível definir"
  },
  TipsType_10746_Desc = {
    Text = "Copiado para a área de transferência"
  },
  TipsType_10747_Desc = {
    Text = "Curtir com sucesso"
  },
  TipsType_10748_Desc = {
    Text = "{s1} já é um Despertado de Suporte"
  },
  TipsType_10749_Desc = {
    Text = "Despertar de apoio de batalha não pode estar vazio"
  },
  TipsType_10750_Desc = {
    Text = "Você já curtiu este Guardião do Segredo hoje"
  },
  TipsType_10751_Desc = {
    Text = "Pode exibir até 4 Despertos"
  },
  TipsType_10752_Desc = {
    Text = "Domínio não atende aos requisitos, não pode entrar"
  },
  TipsType_10753_Desc = {
    Text = "{s1} já está na equipe, não pode ser escolhido novamente"
  },
  TipsType_10754_Desc = {
    Text = "{s1} reiniciado"
  },
  TipsType_10755_Desc = {
    Text = "Desbloqueio bem-sucedido"
  },
  TipsType_10756_Desc = {
    Text = "Nenhum material empilhável disponível para inserir"
  },
  TipsType_10757_Desc = {
    Text = "{s1} já participou de um desafio nesta atividade hoje e não pode ser usado novamente"
  },
  TipsType_10758_Desc = {
    Text = "Domínio da equipe não atende aos requisitos"
  },
  TipsType_10761_Desc = {
    Text = "O despertar da forma de Gênesis não pode lutar ao mesmo tempo que sua forma normal"
  },
  TipsType_10762_Desc = {
    Text = "O despertar da forma de Gênesis não pode ser exibido ao mesmo tempo que sua forma normal"
  },
  TipsType_10799_Desc = {
    Text = "Atualmente, o efeito do conjunto de 6 Mystik <Blue:{s1}> não está ativo devido à restrição de <Blue:Equipe Única>, recomenda-se que o Guardião ajuste o Mystik antes de investigar novamente.\nVocê ainda deseja continuar a investigação?"
  },
  TipsType_10799_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10799_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10799_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_10801_Desc = {
    Text = "O número de planos do pacto atingiu o limite"
  },
  TipsType_10802_Desc = {
    Text = "{s1} já está em outros planos de pacto, não é possível salvar o plano"
  },
  TipsType_10803_Desc = {
    Text = "O nome do plano do pacto não pode estar vazio"
  },
  TipsType_10804_Desc = {
    Text = "Contém caracteres ilegais, por favor, insira novamente"
  },
  TipsType_10805_Desc = {Text = "Salvo"},
  TipsType_10806_Desc = {
    Text = "O pacto atual já foi aplicado em {s1}"
  },
  TipsType_10807_Desc = {Text = "Equipado"},
  TipsType_10808_Desc = {Text = "Removido"},
  TipsType_10809_Desc = {
    Text = "Equipe já em combate"
  },
  TipsType_10810_Desc = {
    Text = "O plano do pacto não pode estar vazio"
  },
  TipsType_10811_Desc = {
    Text = "Plano equipado"
  },
  TipsType_10812_Desc = {Text = "Equipado"},
  TipsType_10813_Desc = {
    Text = "Você tem certeza de que deseja excluir o plano [{s1}]?"
  },
  TipsType_10813_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10813_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10814_Desc = {
    Text = "O Despertado que participa nesta investigação não atende aos requisitos da equipe"
  },
  TipsType_10815_Desc = {
    Text = "Despertado especial para a história, detalhes indisponíveis"
  },
  TipsType_10816_Desc = {
    Text = "\"Credencial de agente\" insuficiente"
  },
  TipsType_10817_Desc = {
    Text = "Sem registros de liquidação, \"Desafie\" e verifique após 9:00"
  },
  TipsType_10818_Desc = {
    Text = "Agente de hoje concluído, não pode ser repetido"
  },
  TipsType_10821_Desc = {
    Text = "Atualmente, não há recursos, por favor, volte mais tarde"
  },
  TipsType_10822_Desc = {
    Text = "Evento encerrado"
  },
  TipsType_10823_Desc = {
    Text = "Reabastecimento de sementes especiais só após esgotar estoque"
  },
  TipsType_10824_Desc = {
    Text = "Limite de reabastecimento atingido, sem mais estoque disponível"
  },
  TipsType_10825_Desc = {
    Text = "\"{s1}\" é insuficiente"
  },
  TipsType_10826_Desc = {
    Text = "Sementes especiais esgotadas, escolha plantar para resetar"
  },
  TipsType_10827_Desc = {
    Text = "Sementes especiais resetadas"
  },
  TipsType_10828_Desc = {
    Text = "Todos os itens trocados. Selecione resetar"
  },
  TipsType_10829_Desc = {
    Text = "Reset bem-sucedido"
  },
  TipsType_10830_Desc = {
    Text = "Despertos inaptos na equipe, não pode investigar"
  },
  TipsType_10831_Desc = {
    Text = "Mandala duplicada na equipe, não pode entrar na Zona de Desastre"
  },
  TipsType_10832_Desc = {
    Text = "Equipe sem Chave, não pode investigar"
  },
  TipsType_10833_Desc = {
    Text = "Mandala inequipável na equipe, não pode investigar"
  },
  TipsType_10834_Desc = {
    Text = "Não pode equipar a Roda do Destino no Despertar de suporte"
  },
  TipsType_10835_Desc = {
    Text = "Não é permitido estabelecer pacto de despertadores para a assistência"
  },
  TipsType_10836_Desc = {
    Text = "Não pode equipar a Roda do Destino no Despertar predefinido da história"
  },
  TipsType_10837_Desc = {
    Text = "Não pode equipar o Mystik no Despertar predefinido da história"
  },
  TipsType_10838_Desc = {
    Text = "O número de expressões no esquema de expressões atingiu o limite máximo"
  },
  TipsType_10839_Desc = {
    Text = "Expressão usada, clique na expressão no esquema para removê-la"
  },
  TipsType_10840_Desc = {
    Text = "Envio de expressão muito rápido"
  },
  TipsType_10841_Desc = {
    Text = "Esquema de expressão não pode estar vazio"
  },
  TipsType_10842_Desc = {
    Text = "Esquema de expressão atualizado"
  },
  TipsType_10843_Desc = {
    Text = "Este item ainda não está desbloqueado"
  },
  TipsType_10844_Desc = {
    Text = "Não desbloqueado"
  },
  TipsType_10850_Desc = {
    Text = "Chave inequipável na equipe, não pode investigar"
  },
  TipsType_10901_Desc = {Text = "Paralisia"},
  TipsType_10902_Desc = {Text = "Desmaio"},
  TipsType_10903_Desc = {
    Text = "Ainda não possui: {s1}"
  },
  TipsType_10904_Desc = {
    Text = "Após passar pelo modo \"normal\" deste capítulo, desbloquear o modo \"lembrança\" para assistir à história"
  },
  TipsType_10905_Desc = {
    Text = "Completar a \"Opção de Investigação\" 1-15·Normal para desbloquear a cena de \"Lembrança\""
  },
  TipsType_10906_Desc = {
    Text = "\"Reality Verge\" é insuficiente"
  },
  TipsType_10907_Desc = {
    Text = "Desbloqueado"
  },
  TipsType_10908_Desc = {
    Text = "{s1} o nível de Despertar Espiritual está completo, continuar a receber transformará em <TipsHighlightText:\"Fragmento de Rebobinagem da Alma ×2>. Você confirma o Despertar?"
  },
  TipsType_10908_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10908_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10908_Title = {
    Text = "Confirmação de despertar"
  },
  TipsType_10909_Desc = {
    Text = "{s1} já despertou, continuar a receber transformará em <TipsHighlightText:Fragmento: {s2}*1> e <TipsHighlightText:Sedimento da raiz*50>, você confirma o despertar?"
  },
  TipsType_10909_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10909_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10909_Title = {
    Text = "Confirmação de despertar"
  },
  TipsType_10910_Desc = {
    Text = "Deseja confirmar o despertar de <TipsHighlightText:{s1}>?"
  },
  TipsType_10910_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10910_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10910_Title = {
    Text = "Confirmação de despertar"
  },
  TipsType_10911_Desc = {
    Text = "Espaço insuficiente"
  },
  TipsType_10912_Desc = {
    Text = "O espaço ultradimensional ainda não possui cartas de comando, não pode ser usado"
  },
  TipsType_10913_Desc = {
    Text = "Neste turno, não pode ser usado novamente"
  },
  TipsType_10914_Desc = {
    Text = "Deseja confirmar a escolha de <TipsHighlightText:{s1}>?"
  },
  TipsType_10914_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10914_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10914_Title = {
    Text = "Escolha confirmar"
  },
  TipsType_10915_Desc = {
    Text = "Desbloquear formações requer seguir a ordem, não é possível pular formações não desbloqueadas"
  },
  TipsType_10916_Desc = {
    Text = "Deseja consumir <Blue: {s1} × {s2}> para desbloquear?"
  },
  TipsType_10916_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10916_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10916_Title = {
    Text = "Confirmação de desbloqueio"
  },
  TipsType_10917_Desc = {
    Text = "Desbloqueio bem-sucedido {s1}"
  },
  TipsType_10918_Desc = {
    Text = "Desbloqueio bem-sucedido {s1}, todo o elenco foi desbloqueado"
  },
  TipsType_10919_Desc = {
    Text = "Desbloqueado após [{s1}:{s2}], deseja ir para [{s1}]?"
  },
  TipsType_10919_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10919_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10919_Title = {
    Text = "Ainda não desbloqueado"
  },
  TipsType_10920_Desc = {
    Text = "Acumule \"Avelã mágica\" × {s1} na atividade por tempo limitado \"Inversão de fase\" para desbloquear. Deseja ir para \"Inversão de fase\"?"
  },
  TipsType_10920_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_10920_RightBtnDesc = {Text = "Confirmar"},
  TipsType_10920_Title = {
    Text = "Ainda não desbloqueado"
  },
  TipsType_10921_Desc = {
    Text = "Não é possível equipar duas Rodas do Destino com o mesmo atributo principal simultaneamente"
  },
  TipsType_20001_Desc = {
    Text = "Marque a confirmação dupla"
  },
  TipsType_20001_LeftBtnDesc = {Text = "Confirmar"},
  TipsType_20001_Title = {Text = "Título"},
  TipsType_20002_Desc = {
    Text = "Sem confirmação secundária"
  },
  TipsType_20002_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20002_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20002_Title = {Text = "Título"},
  TipsType_20003_Desc = {
    Text = "Sua conta foi acessada em outro dispositivo"
  },
  TipsType_20003_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20003_Title = {
    Text = "Aviso de desconexão"
  },
  TipsType_20004_Desc = {
    Text = "Conexão com o servidor perdida, por favor, faça login novamente"
  },
  TipsType_20004_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20004_Title = {
    Text = "Aviso de desconexão"
  },
  TipsType_20005_Desc = {
    Text = "Sincronização falhou, tentar novamente?"
  },
  TipsType_20005_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20005_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20005_Title = {
    Text = "Sincronização falhou"
  },
  TipsType_20006_Desc = {
    Text = "Perder sincronização, retornando à tela de login em breve"
  },
  TipsType_20006_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20006_Title = {
    Text = "Sincronização falhou"
  },
  TipsType_20007_Desc = {
    Text = "Perder sincronização, retornando à tela de login em breve"
  },
  TipsType_20007_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20007_Title = {
    Text = "Sincronização falhou"
  },
  TipsType_20008_Desc = {
    Text = "Esta investigação consumirá <Positive:{s1}> de energia. Confirmar término?"
  },
  TipsType_20008_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20008_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20008_Title = {
    Text = "Encerrar exploração"
  },
  TipsType_20009_Desc = {
    Text = "A atualização irá alterar as orações e relíquias, o despertar de despertadores e as vezes de venda de cartas de comando não vão ser reiniciadas, você confirma?"
  },
  TipsType_20009_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20009_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20009_Title = {
    Text = "Confirmar atualização"
  },
  TipsType_20010_Desc = {
    Text = "Número insuficiente de despertares neste domínio, deseja continuar a criar a equipe?"
  },
  TipsType_20010_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20010_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20011_Desc = {
    Text = "Nenhum despertador foi escolhido, a formação não será mantida"
  },
  TipsType_20011_LeftBtnDesc = {
    Text = "Confirmar saída"
  },
  TipsType_20011_RightBtnDesc = {
    Text = "Continuar a formação"
  },
  TipsType_20012_Desc = {
    Text = "Nenhum Desperto selecionado"
  },
  TipsType_20012_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20013_Desc = {
    Text = "A equipe ainda tem vagas, confirmar partida?"
  },
  TipsType_20013_LeftBtnDesc = {Text = "Voltar"},
  TipsType_20013_RightBtnDesc = {Text = "Partida"},
  TipsType_20014_Desc = {
    Text = "Número máximo de equipes atingido"
  },
  TipsType_20014_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20015_Desc = {
    Text = "Deseja excluir esta equipe?"
  },
  TipsType_20015_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20015_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20016_Desc = {
    Text = "Desbloqueia após completar {s1}"
  },
  TipsType_20016_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20017_Desc = {
    Text = "Aqui você pode ver informações do mapa e dos monstros derrotados, esta versão ainda não está disponível"
  },
  TipsType_20017_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20018_Desc = {
    Text = "Ainda não atingiu as condições de desbloqueio da fase"
  },
  TipsType_20018_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20018_Title = {
    Text = "Exploração rápida"
  },
  TipsType_20019_Desc = {
    Text = "\"Prata\" insuficiente. Deseja ir à loja comprar?"
  },
  TipsType_20019_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20019_RightBtnDesc = {Text = "Ir"},
  TipsType_20020_Desc = {
    Text = "Desbloqueia esta dificuldade avançada após completar {s1}"
  },
  TipsType_20020_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20021_Desc = {
    Text = "{s1} desbloqueia treino avançado após completar modo normal"
  },
  TipsType_20021_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20022_Desc = {
    Text = "\"Prata\" insuficiente. Deseja comprar?"
  },
  TipsType_20022_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20022_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20022_Title = {
    Text = "Núcleo Prateado insuficiente"
  },
  TipsType_20023_Desc = {
    Text = "Esta atualização excederá {s1} pontos de experiência (não reembolsável), e o personagem não ganhará mais experiência ao atingir o nível máximo. Continuar?"
  },
  TipsType_20023_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20023_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20024_Desc = {
    Text = "Equipe incompleta, não pode entrar na masmorra"
  },
  TipsType_20024_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20026_Desc = {
    Text = "Deseja confirmar a carga?"
  },
  TipsType_20026_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20026_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20027_Desc = {
    Text = "Deseja confirmar a recuperação de vida?"
  },
  TipsType_20027_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20027_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20028_Desc = {
    Text = "Fechar esta interface resultará na perda de pegar [{s1}]. Prosseguir?"
  },
  TipsType_20028_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20028_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20029_Desc = {
    Text = "Fechar esta interface pulará este evento (a criação não será removida), deseja confirmar?"
  },
  TipsType_20029_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20029_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20030_Desc = {
    Text = "Desmarcar criação, deseja desistir da herança?"
  },
  TipsType_20030_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20030_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20031_Desc = {
    Text = "Deseja confirmar a saída da batalha?"
  },
  TipsType_20031_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20031_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20032_Desc = {
    Text = "Nível atual bloqueado, deseja desbloquear completando o nível de investigação?"
  },
  TipsType_20032_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20032_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20032_Title = {
    Text = "Ainda não desbloqueado"
  },
  TipsType_20033_Desc = {
    Text = "Tentativas de desafio insuficientes. Gastar 500 Prata para resetar?"
  },
  TipsType_20033_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20033_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20034_Desc = {
    Text = "O desafio atual está em cooldown. Deseja gastar \"Prata\" × 50 para resetar?"
  },
  TipsType_20034_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20034_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20035_Desc = {
    Text = "Nível recomendado é {s1}, o nível médio da equipe atual é {s2}, a investigação encontrará obstáculos, deseja continuar?"
  },
  TipsType_20035_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20035_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20035_Title = {
    Text = "Poder de combate insuficiente"
  },
  TipsType_20036_Desc = {
    Text = "Varredura definida para {s1}, mas consome {s2} energia por recompensa. Confirmar?"
  },
  TipsType_20036_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20036_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20036_Title = {
    Text = "Confirmação de desafio"
  },
  TipsType_20037_Desc = {
    Text = "Os materiais de reforço incluem materiais de alta qualidade, você tem certeza de que deseja reforçar?"
  },
  TipsType_20037_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20037_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20037_Title = {
    Text = "Confirmação de reforço"
  },
  TipsType_20038_Desc = {
    Text = "Este equipamento está bloqueado. Deseja desbloqueá-lo?"
  },
  TipsType_20038_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20038_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20039_Desc = {
    Text = "Confirmar encerramento da investigação? Isso resultará em falha e perda de recompensas subsequentes"
  },
  TipsType_20039_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20039_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20039_Title = {
    Text = "Sair da investigação"
  },
  TipsType_20040_Desc = {
    Text = "<WeaponEffect_Num:Sair agora custará {s1} Lingfétide.> A investigação falhará, não sendo possível ganhar recompensas subsequentes. Deseja continuar?"
  },
  TipsType_20040_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20040_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20040_Title = {
    Text = "Sair da investigação"
  },
  TipsType_20041_BottomDesc = {
    Text = "Permissão de compressão de tempo atual: {s1}"
  },
  TipsType_20041_Desc = {
    Text = "Você deseja consumir {s1} permissões de compressão do tempo para acelerar?"
  },
  TipsType_20041_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20041_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20041_Title = {
    Text = "Confirmação de aceleração"
  },
  TipsType_20042_Desc = {
    Text = "Ajuste da batalha RPG em andamento, vitória calculada diretamente"
  },
  TipsType_20042_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20042_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20043_Desc = {
    Text = "Deseja gastar {s1} Núcleos de Prata para atualizar a missão atual?"
  },
  TipsType_20043_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20043_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20043_Title = {
    Text = "Atualizar missão"
  },
  TipsType_20044_BottomDesc = {
    Text = "Consumo: {s1} licença de pesquisa"
  },
  TipsType_20044_Desc = {
    Text = [[
Deseja realizar a pesquisa de {s1}?
Efeito da pesquisa: {s2}]]
  },
  TipsType_20044_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20044_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20044_Title = {
    Text = "Confirmação de pesquisa"
  },
  TipsType_20045_BottomDesc = {
    Text = "Cancelar pesquisa sem manter o progresso já realizado"
  },
  TipsType_20045_Desc = {
    Text = "Cancelar a pesquisa {s1}? (A licença de pesquisa será totalmente reembolsada)"
  },
  TipsType_20045_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20045_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20045_Title = {
    Text = "Pesquisa cancelada"
  },
  TipsType_20046_Desc = {
    Text = "Deseja gastar {s1} \"Prata\" para acelerar?"
  },
  TipsType_20046_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20046_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20046_Title = {
    Text = "Confirmação de aceleração"
  },
  TipsType_20047_Desc = {
    Text = "Faltam {s1} <Blue:\"{s2}\">, deseja gastar <Blue:\"Prata\"×{s3}> para comprar?"
  },
  TipsType_20047_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20047_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20047_Title = {
    Text = "Confirmação de compra"
  },
  TipsType_20048_Desc = {
    Text = "Faltam {s1} <Blue:\"{s2}\">, deseja gastar <Blue:\"Prata\"×{s3}> para comprar?"
  },
  TipsType_20048_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20048_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20048_Title = {
    Text = "Confirmação de compra"
  },
  TipsType_20049_Desc = {
    Text = "<Blue:\"{s1}\"> está equipado por <Blue:\"{s2}\">, deseja substituir?"
  },
  TipsType_20049_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20049_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20049_Title = {
    Text = "Aviso de troca"
  },
  TipsType_20050_Desc = {
    Text = "Consumir Roda do Destino já empilhada, confirmar?"
  },
  TipsType_20050_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20050_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20050_Title = {
    Text = "Dica de empilhamento"
  },
  TipsType_20051_Desc = {
    Text = "Nível de empilhamento excederá o limite, retornando níveis excedentes. Confirmar?"
  },
  TipsType_20051_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20051_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20051_Title = {
    Text = "Dica de empilhamento"
  },
  TipsType_20052_Desc = {
    Text = "Nível recomendado é {s1}, o nível médio da equipe atual é {s2}, a investigação encontrará obstáculos significativos, deseja continuar?"
  },
  TipsType_20052_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20052_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20052_Title = {
    Text = "Poder de combate insuficiente"
  },
  TipsType_20053_Desc = {
    Text = "Nível recomendado é {s1}, o nível médio da equipe atual é {s2}, a investigação encontrará grandes obstáculos, deseja continuar?"
  },
  TipsType_20053_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20053_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20053_Title = {
    Text = "Poder de combate insuficiente"
  },
  TipsType_20054_Desc = {
    Text = "Recompensas de desafio coletadas, continuar sem recompensas. Confirmar?"
  },
  TipsType_20054_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20054_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20054_Title = {
    Text = "Confirmação de desafio"
  },
  TipsType_20055_Desc = {
    Text = "Após o reset, o progresso atual do nível será reiniciado para 0 estrelas, e o registro de batalha do despertador será apagado. Você confirma o reset?"
  },
  TipsType_20055_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20055_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20055_Title = {
    Text = "Confirmar reset"
  },
  TipsType_20056_Desc = {
    Text = "Após o sucesso do desafio, os quatro despertadores da formação atual não poderão participar de outros níveis de {s1}, deseja confirmar o desafio?"
  },
  TipsType_20056_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20056_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20056_Title = {
    Text = "Confirmação de desafio"
  },
  TipsType_20057_Desc = {
    Text = "Composição da equipe viola recomendações do manual da academia, deseja continuar o desafio?"
  },
  TipsType_20057_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20057_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20057_Title = {
    Text = "Confirmação de formação"
  },
  TipsType_20058_Desc = {
    Text = "O nível atual foi completado com sucesso, se desejar tentar novamente, você deve primeiro redefinir o progresso atual do nível para 0 estrelas, e o registro de batalhas do despertador será sincronizado para ser limpo, você confirma a redefinição?"
  },
  TipsType_20058_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20058_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20058_Title = {
    Text = "Confirmar reset"
  },
  TipsType_20059_Desc = {
    Text = "Atualmente, a quantidade de despertadores na equipe não é quatro, não pode entrar em combate"
  },
  TipsType_20059_Title = {
    Text = "Salvar formação"
  },
  TipsType_20060_BottomDesc = {
    Text = "Depois de confirmar, não será possível reativar"
  },
  TipsType_20060_Desc = {
    Text = "Deseja escolher o resultado do despertar (você receberá todas as unidades despertas e círculos de destino deste despertar)?"
  },
  TipsType_20060_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20060_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20060_Title = {
    Text = "Confirmar seleção"
  },
  TipsType_20061_BottomDesc = {
    Text = "Prata atual: {s1}"
  },
  TipsType_20061_Desc = {
    Text = "Deseja gastar {s1} \"Prata\" para Despertar novamente?\nO Despertar novamente não manterá o resultado atual do sorteio."
  },
  TipsType_20061_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20061_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20061_Title = {Text = "Reacordar"},
  TipsType_20062_Desc = {
    Text = "Tem certeza de que deseja excluir todas as mensagens lidas?\nAs mensagens com anexos não serão excluídas"
  },
  TipsType_20062_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20062_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20062_Title = {
    Text = "Excluir lidos"
  },
  TipsType_20063_Desc = {
    Text = "Confirmar exclusão?"
  },
  TipsType_20063_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20063_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20063_Title = {
    Text = "Excluir mensagem atual"
  },
  TipsType_20064_Desc = {
    Text = "Cartas na caixa de coleção não podem ser recuperadas após serem deletadas.\nDeseja deletar esta carta?"
  },
  TipsType_20064_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20064_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20064_Title = {
    Text = "Excluir cartas favoritas"
  },
  TipsType_20065_Desc = {
    Text = "Confirmar o consumo de <Blue:{s1}> para sintetizar <Blue:{s2}>?"
  },
  TipsType_20065_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20065_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20065_Title = {
    Text = "Confirmação de síntese"
  },
  TipsType_20066_Desc = {
    Text = "Confirmar desintegração de <Blue:{s1}, obter {s2}>?"
  },
  TipsType_20066_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20066_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20066_Title = {
    Text = "Confirmar desmontagem"
  },
  TipsType_20067_Desc = {
    Text = "Confirmar o consumo de <Blue:{s1}> pactos de grau SSR, reimprimir <Blue:{s2}> <Blue:{s3}>?"
  },
  TipsType_20067_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20067_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20067_Title = {
    Text = "Confirmação de reimpressão"
  },
  TipsType_20068_Desc = {
    Text = "Todos os despertadores perderam completamente a capacidade de combate\n\nÚnico guardião,\nO que você escolherá a seguir?"
  },
  TipsType_20068_LeftBtnDesc = {Text = "Rebatalha"},
  TipsType_20068_RightBtnDesc = {
    Text = "Retirada temporária"
  },
  TipsType_20068_Title = {
    Text = "Investigação Falhou"
  },
  TipsType_20069_Desc = {
    Text = "Despertado selecionado com loucura cheia, confirmar seleção?"
  },
  TipsType_20069_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20069_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20069_Title = {
    Text = "Confirmar escolha"
  },
  TipsType_20070_Desc = {
    Text = "Você deseja confirmar o uso de {s1}?\nCorpos despertadores com níveis e habilidades aprimorados não retornarão materiais de upgrade"
  },
  TipsType_20070_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20070_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20070_Title = {
    Text = "Confirmação de amplificação"
  },
  TipsType_20071_Desc = {
    Text = "Devido à limitação do nível de investigação do guardião, o nível do despertador será elevado para nível {s1}. Os materiais de upgrade faltantes não serão devolvidos. Você confirma o upgrade?"
  },
  TipsType_20071_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20071_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20071_Title = {
    Text = "Confirmação de amplificação"
  },
  TipsType_20072_Desc = {
    Text = "Confirmar pular toda a história desta seção?\nNota: Você pode revisitar esta fase para ver a história"
  },
  TipsType_20072_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20072_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20072_Title = {
    Text = "Pular a cena"
  },
  TipsType_20073_Desc = {
    Text = "Confirmar a decomposição de {s1}, obter {s2}?\n(A atual pacto já foi fortalecido, a decomposição não retornará os recursos de fortalecimento)"
  },
  TipsType_20073_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20073_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20073_Title = {
    Text = "Confirmar desmontagem"
  },
  TipsType_20074_Desc = {
    Text = "Confirmar desintegração de {s1}, obter {s2}?\n(Raridade atual do ciclo de vida é alta)"
  },
  TipsType_20074_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20074_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20074_Title = {
    Text = "Confirmar desmontagem"
  },
  TipsType_20075_BottomDesc = {
    Text = "Consumo: {s1} licença de pesquisa"
  },
  TipsType_20075_Desc = {
    Text = "Você deseja iniciar a pesquisa de {s1}?\nEficiência de produção: {s2} rosas douradas / a cada 6 horas\n      ——>{s3} rosas douradas / a cada 6 horas"
  },
  TipsType_20075_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20075_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20075_Title = {
    Text = "Confirmação de pesquisa"
  },
  TipsType_20076_BottomDesc = {
    Text = "Consumo: {s1} licença de pesquisa"
  },
  TipsType_20076_Desc = {
    Text = "Você deseja iniciar a pesquisa de {s1}?\nEficiência de produção: {s2} elixires de gnose / a cada 6 horas\n      ——>{s3} elixires de gnose / a cada 6 horas"
  },
  TipsType_20076_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20076_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20076_Title = {
    Text = "Confirmação de pesquisa"
  },
  TipsType_20077_BottomDesc = {
    Text = "Consumo: {s1} licença de pesquisa"
  },
  TipsType_20077_Desc = {
    Text = "Você deseja iniciar a pesquisa de {s1}?\nEficiência de produção: {s2} marcas de pacto / a cada 6 horas\n      ——>{s3} marcas de pacto / a cada 6 horas"
  },
  TipsType_20077_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20077_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20077_Title = {
    Text = "Confirmação de pesquisa"
  },
  TipsType_20078_Desc = {
    Text = "Confirmar pular toda a história?\nNota: Você pode revisitar esta fase para ver a história"
  },
  TipsType_20078_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20078_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20078_Title = {
    Text = "Pular a cena"
  },
  TipsType_20079_Desc = {
    Text = "A Chave de Prata detectou uma crise mortal, deseja ativar o Corpo de Conhecimento de Emergência?\n(Ressuscitar consumirá 1 uso do Corpo de Conhecimento de Emergência, que é obtido automaticamente às 9h todos os dias, usos restantes: {s1}/{s2})"
  },
  TipsType_20079_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20079_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20079_Title = {
    Text = "Confirmação de Ressurreição"
  },
  TipsType_20080_Desc = {
    Text = "A Chave de Prata detectou uma crise mortal, deseja ativar o Corpo de Conhecimento de Emergência?\n(Ressuscitar consumirá 1 uso do Corpo de Conhecimento de Emergência, que é obtido automaticamente às 9h todos os dias, usos restantes: {s1}/{s2})"
  },
  TipsType_20080_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20080_Title = {
    Text = "Confirmação de Ressurreição"
  },
  TipsType_20081_Desc = {
    Text = "Falha na inicialização do jogo. {s1}"
  },
  TipsType_20081_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20081_Title = {
    Text = "Mensagem de erro de login"
  },
  TipsType_20082_Desc = {
    Text = "Deseja consumir <Blue:\"Prata\" × {s1} > para comprar <Blue: {s2} > níveis?"
  },
  TipsType_20082_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20082_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20082_Title = {
    Text = "Aumentar nível"
  },
  TipsType_20083_Desc = {
    Text = "O destino consumido {s1}, deseja confirmar o fortalecimento?"
  },
  TipsType_20083_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20083_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20083_Title = {
    Text = "Confirmar Consumo"
  },
  TipsType_20084_Desc = {
    Text = "Nível médio da equipe abaixo do recomendado, atributos dos Despertos serão reduzidos, ainda deseja investigar?"
  },
  TipsType_20084_LeftBtnDesc = {
    Text = "Ir para Melhorar"
  },
  TipsType_20084_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20084_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_20085_Desc = {
    Text = "Confirmar saída do jogo"
  },
  TipsType_20085_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20085_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20085_Title = {
    Text = "Sair do jogo"
  },
  TipsType_20086_Desc = {
    Text = "Servidor em manutenção"
  },
  TipsType_20086_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20086_Title = {
    Text = "Aviso de desconexão"
  },
  TipsType_20087_Desc = {
    Text = "Deseja confirmar o uso de <TipsHighlightText:{s1} × {s2}> para desbloquear <TipsHighlightText:{s3}>?"
  },
  TipsType_20087_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20087_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20087_Title = {
    Text = "Confirmação de ativação"
  },
  TipsType_20088_Desc = {
    Text = "Após a coleta, o \"Lingfétide\" transbordará, e a parte que exceder {s1} não poderá ser obtida.\nVocê deseja continuar a coleta?"
  },
  TipsType_20088_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20088_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20088_Title = {
    Text = "Menofim transbordou"
  },
  TipsType_20089_Desc = {
    Text = "Gaste <Blue:{s1}> Rosa Dourada para renovar o estoque\nFaltam renovações: <Blue:{s2}>\nQuanto mais renovações, mais Rosa Dourada é necessária."
  },
  TipsType_20089_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20089_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20089_Title = {
    Text = "Atualizar estoque"
  },
  TipsType_20090_Desc = {
    Text = "Quantidade máxima de Rodas do Destino atingida. É necessário limpar Rodas do Destino antes de despertar. Deseja ir?\n\n<color=#ADC0CB>*Pode definir a decomposição automática de Rodas do Destino SR/R nas \"Configurações\"</color>"
  },
  TipsType_20090_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20090_RightBtnDesc = {
    Text = "Ir para Limpar"
  },
  TipsType_20090_Title = {
    Text = "Dica de Limpeza"
  },
  TipsType_20091_Desc = {
    Text = "O número de pactos atingiu o limite, limpe alguns antes de continuar a investigação. Deseja prosseguir?"
  },
  TipsType_20091_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20091_RightBtnDesc = {
    Text = "Ir para Limpar"
  },
  TipsType_20091_Title = {
    Text = "Dica de Limpeza"
  },
  TipsType_20092_Desc = {
    Text = "Deseja confirmar a remoção de todos os círculos de destino equipados na unidade desperta atual?"
  },
  TipsType_20092_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20092_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20092_Title = {
    Text = "Confirmação de descarregamento"
  },
  TipsType_20093_Desc = {
    Text = "O pacto consumido foi atualizado, deseja confirmar?"
  },
  TipsType_20093_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20093_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20093_Title = {
    Text = "Confirmação de upgrade"
  },
  TipsType_20094_Desc = {
    Text = "Existem bons atributos no atributo secundário primordial. Substituir não os salvará. Confirmar substituição?"
  },
  TipsType_20094_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20094_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20094_Title = {
    Text = "Confirmar substituição"
  },
  TipsType_20095_Desc = {
    Text = "Boa subatribuição encontrada, continuar não salvará. Confirmar?"
  },
  TipsType_20095_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20095_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20095_Title = {
    Text = "Confirmação de transcrição"
  },
  TipsType_20096_Desc = {
    Text = "Após a atualização deste Mystik, ele excederá o limite de nível. Os materiais de transcrição excedentes serão devolvidos. Confirmar?"
  },
  TipsType_20096_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20096_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20096_Title = {
    Text = "Confirmação de upgrade"
  },
  TipsType_20097_Desc = {
    Text = "O Despertar Espiritual deste Corpo Desperto está completo.\nApós selecionar, você receberá apenas \"Fragmento de Retrocesso de Alma\" ×1"
  },
  TipsType_20097_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20097_RightBtnDesc = {Text = "Continuar"},
  TipsType_20097_Title = {
    Text = "Confirmar seleção"
  },
  TipsType_20098_Desc = {
    Text = "Este item pode ser comprado com <Blue:{s1}> Certificados de Prata"
  },
  TipsType_20098_LeftBtnDesc = {
    Text = "Pagamento em dinheiro"
  },
  TipsType_20098_RightBtnDesc = {
    Text = "Pagamento com comprovante"
  },
  TipsType_20098_Title = {
    Text = "Escolha do método de liquidação"
  },
  TipsType_20099_Desc = {
    Text = "Deseja sair do jogo?"
  },
  TipsType_20099_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20099_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20099_Title = {Text = "Dica"},
  TipsType_20100_Desc = {
    Text = "Nova versão do jogo detectada. Reinicie o jogo para atualizar os recursos"
  },
  TipsType_20100_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20100_Title = {
    Text = "Aviso de atualização"
  },
  TipsType_20101_Desc = {
    Text = "Esta investigação foi concluída, deseja pular a história ao investigar novamente?"
  },
  TipsType_20101_LeftBtnDesc = {
    Text = "Pular a cena"
  },
  TipsType_20101_RightBtnDesc = {
    Text = "Manter enredo"
  },
  TipsType_20101_Title = {
    Text = "Confirmação do enredo"
  },
  TipsType_20102_Desc = {
    Text = "Tem certeza de que não quer mais seguir {s1}?"
  },
  TipsType_20102_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20102_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20102_Title = {
    Text = "Deixar de seguir"
  },
  TipsType_20103_Desc = {
    Text = "Durante o evento <WeaponEffect_Num:Grátis> desbloqueio, deseja desbloquear?"
  },
  TipsType_20103_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20103_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20103_Title = {
    Text = "Benefícios do evento"
  },
  TipsType_20105_Desc = {
    Text = "Para garantir a melhor experiência da trama, recomenda-se completar os seguintes níveis de investigação."
  },
  TipsType_20105_LeftBtnDesc = {Text = "Sair"},
  TipsType_20105_RightBtnDesc = {
    Text = "Ainda investigar"
  },
  TipsType_20105_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_20106_Desc = {
    Text = "Consumir <Blue:\"Líquido de Origem de Núcleo de Prata\" × {s1} > para compra?"
  },
  TipsType_20106_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20106_RightBtnDesc = {Text = "Comprar"},
  TipsType_20106_Title = {
    Text = "Confirmação de compra"
  },
  TipsType_20107_Desc = {
    Text = "Você tem certeza de que deseja selecionar <Blue:{s1}>?"
  },
  TipsType_20107_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20107_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20107_Title = {
    Text = "Escolha confirmar"
  },
  TipsType_20108_Desc = {
    Text = "Esta empilhamento consumirá o raro item “mestre do ciclo” \n você deseja continuar?"
  },
  TipsType_20108_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20108_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20108_Title = {
    Text = "Confirmar Consumo"
  },
  TipsType_20109_Desc = {
    Text = "Tem certeza de que deseja reiniciar esta batalha?"
  },
  TipsType_20109_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20109_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20109_Title = {Text = "Rebatalha"},
  TipsType_20110_Desc = {
    Text = "Confirmar {s1} de {s2} como seu aniversário?\nNão poderá ser alterado depois"
  },
  TipsType_20110_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20110_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20110_Title = {
    Text = "Confirmação de Aniversário"
  },
  TipsType_20111_Desc = {
    Text = "Para garantir a melhor experiência da trama, recomenda-se completar os seguintes níveis de investigação."
  },
  TipsType_20111_LeftBtnDesc = {Text = "Sair"},
  TipsType_20111_RightBtnDesc = {
    Text = "Ainda investigar"
  },
  TipsType_20111_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_20112_Desc = {
    Text = "Para garantir a melhor experiência da trama, recomenda-se completar os seguintes níveis de investigação."
  },
  TipsType_20112_LeftBtnDesc = {Text = "Sair"},
  TipsType_20112_RightBtnDesc = {
    Text = "Ainda investigar"
  },
  TipsType_20112_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_20113_Desc = {
    Text = "Deseja marcar todo o conteúdo didático como lido e receber as recompensas? (Recomendado para novos alunos)"
  },
  TipsType_20113_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20113_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20113_Title = {
    Text = "Ler e confirmar com um clique"
  },
  TipsType_20114_Desc = {
    Text = "Deseja confirmar a escolha de <WeaponEffect_Num:{s1}> para ativar o retrocesso? \n Esta ação não pode ser revertida, por favor, confirme com cuidado"
  },
  TipsType_20114_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20114_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20114_Title = {
    Text = "Escolha de retrocesso"
  },
  TipsType_201151_Desc = {
    Text = "O despertador atual não possui despertar espiritual, não sendo necessário realizar regressão espiritual"
  },
  TipsType_20115_Desc = {
    Text = "Despertado sem desenvolvimento, sem necessidade de retroceder"
  },
  TipsType_20116_Desc = {
    Text = "<WeaponEffect_Num:{s1}>Reversão ativada.\nDeseja ir agora para reverter?"
  },
  TipsType_20116_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20116_RightBtnDesc = {Text = "Ir"},
  TipsType_20116_Title = {
    Text = "Ativação bem-sucedida"
  },
  TipsType_20117_Desc = {
    Text = "Vai redefinir o estado de atualização, ascensão, habilidades, talentos e aprofundamento espiritual do despertador e devolver os recursos consumidos correspondentes. \nConfirmar a regressão de desenvolvimento de <WeaponEffect_Num:{s1}>?"
  },
  TipsType_20117_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20117_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20117_Title = {
    Text = "Rastreamento de criação"
  },
  TipsType_20118_Desc = {
    Text = "Está prestes a redefinir o nível de iluminação do despertador e devolver os custos de iluminação.\nConfirmar a retroação em <WeaponEffect_Num:{s1}>?"
  },
  TipsType_20118_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20118_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20118_Title = {
    Text = "Recuperação de Inspiração"
  },
  TipsType_20119_Desc = {
    Text = "Está prestes a redefinir o estado de melhoria, ascensão, habilidades, despertar espiritual, talentos e aprofundamento gnóstico do corpo desperto, devolvendo os consumos correspondentes, \n e retornando o corpo desperto ao Blackpool. \n Confirmar a devolução de <WeaponEffect_Num:{s1}> ao Blackpool?"
  },
  TipsType_20119_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20119_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20119_Title = {
    Text = "Devolver o Blackpool"
  },
  TipsType_20120_Desc = {
    Text = "Despertar especial não pode ser devolvido"
  },
  TipsType_20121_Desc = {
    Text = "Redefinindo o estado de empilhamento da Roda do Destino e devolvendo todos os consumos de empilhamento.\nConfirmar a reversão de empilhamento para <WeaponEffect_Num:{s1}>?"
  },
  TipsType_20121_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20121_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20121_Title = {
    Text = "Reversão de empilhamento"
  },
  TipsType_20122_Desc = {
    Text = "Está prestes a redefinir o estado empilhado da roda do destino, devolver todos os custos de empilhamento e retornar a roda ao abismo.\nConfirmar a devolução de <WeaponEffect_Num:{s1}> ao abismo?"
  },
  TipsType_20122_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20122_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20122_Title = {
    Text = "Devolver o Blackpool"
  },
  TipsType_20123_Desc = {
    Text = "Após completar o desafio, os Corpos Despertos, Rodas do Destino e Ordens de chave da equipe não poderão ser usados em outras Zonas Proibidas de Catástrofe de Fusão. Deseja confirmar?"
  },
  TipsType_20123_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20123_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20123_Title = {
    Text = "Confirmação de desafio"
  },
  TipsType_20124_Desc = {
    Text = "Após o reset, os Despertados, Ciclos de Vida e Chaves da equipe de investigação atual poderão ser reutilizados, mas os pontos de treino ganhos no nível serão deduzidos (não afeta recompensas). Confirmar reset?"
  },
  TipsType_20124_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20124_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20124_Title = {
    Text = "Confirmar reset"
  },
  TipsType_20125_Desc = {
    Text = "Nível de empilhamento atual: 0, sem necessidade de retroceder"
  },
  TipsType_20126_Desc = {
    Text = "O despertador atual está sendo enviado, por favor, convoque-o de volta antes de realizar um retorno ou devolução"
  },
  TipsType_20127_Desc = {
    Text = "Roda do destino bloqueada, desbloqueie antes de devolver"
  },
  TipsType_20128_Desc = {
    Text = "{s1} já foi concluído, é necessário reiniciar para poder enfrentar o desafio. Deseja confirmar o reset?\n(Após o reset, os Corpos Despertos, Rodas do Destino e Ordens de chave da equipe de investigação poderão ser reutilizados, mas os Pontos de Treinamento ganhos neste nível serão deduzidos.)"
  },
  TipsType_20128_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20128_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20128_Title = {
    Text = "Confirmar reset"
  },
  TipsType_20129_Desc = {
    Text = "Para garantir a melhor experiência da trama, recomenda-se completar os seguintes níveis de investigação."
  },
  TipsType_20129_LeftBtnDesc = {Text = "Sair"},
  TipsType_20129_RightBtnDesc = {
    Text = "Ainda investigar"
  },
  TipsType_20129_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_20130_Desc = {
    Text = "Para garantir a melhor experiência da trama, recomenda-se completar os seguintes níveis de investigação."
  },
  TipsType_20130_LeftBtnDesc = {Text = "Sair"},
  TipsType_20130_RightBtnDesc = {
    Text = "Ainda investigar"
  },
  TipsType_20130_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_20131_Desc = {
    Text = "Para garantir a melhor experiência da trama, recomenda-se completar os seguintes níveis de investigação."
  },
  TipsType_20131_LeftBtnDesc = {Text = "Sair"},
  TipsType_20131_RightBtnDesc = {
    Text = "Ainda investigar"
  },
  TipsType_20131_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_20132_Desc = {
    Text = "Se <TipsHighlightText:Fragmentos do Pacto> forem suficientes, eles serão consumidos primeiro quando verificados.\nSe insuficientes, <TipsHighlightText:\"{s1}\"> serão automaticamente consumidos para equilibrar a diferença."
  },
  TipsType_20132_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20132_RightBtnDesc = {
    Text = "Ainda marcar"
  },
  TipsType_20132_Title = {
    Text = "Reabastecimento automático"
  },
  TipsType_20133_Desc = {
    Text = "Você deseja aprofundar <TipsHighlightText:\"{s1}\"> com Gnosis?"
  },
  TipsType_20133_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20133_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20133_Title = {
    Text = "Aprofundamento Gnóstico"
  },
  TipsType_20134_Desc = {
    Text = "Para garantir a melhor experiência da trama, recomenda-se completar as seguintes fases de investigação."
  },
  TipsType_20134_LeftBtnDesc = {Text = "Sair"},
  TipsType_20134_RightBtnDesc = {
    Text = "Ainda investigar"
  },
  TipsType_20134_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_20137_Desc = {
    Text = "Confirmar o consumo de <Blue:\"{s1}\"×{s2}> para desbloquear esta faixa?"
  },
  TipsType_20137_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20137_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20137_Title = {
    Text = "Confirmação de desbloqueio"
  },
  TipsType_20138_Desc = {
    Text = "Durante o evento <Blue:Grátis> desbloqueio, deseja desbloquear?"
  },
  TipsType_20138_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20138_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20138_Title = {
    Text = "Confirmação de desbloqueio"
  },
  TipsType_20139_Desc = {
    Text = "Você tem certeza de que deseja consumir <Blue:\"{s1}\"×{s3}> para desbloquear <Blue:\"{s2}\"?>?"
  },
  TipsType_20139_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20139_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20139_Title = {
    Text = "Confirmação de desbloqueio"
  },
  TipsType_20140_Desc = {
    Text = "<Blue:\"{s1}\">Você atingiu o limite máximo. Solicitar mais não concederá itens adicionais. Você deseja solicitar?"
  },
  TipsType_20140_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20140_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20140_Title = {
    Text = "Confirmação de recebimento"
  },
  TipsType_20141_Desc = {
    Text = "Você deseja pular a batalha e eliminar o inimigo imediatamente, sacrificando 30% da saúde máxima ({s1})?  \n\nVida atual: {s2}"
  },
  TipsType_20141_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20141_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20141_Title = {
    Text = "memória muscular"
  },
  TipsType_20142_Desc = {
    Text = "Perde <color=#BB646D> {s1} </color> pontos de vida e ganha {s2} sigilos negros?"
  },
  TipsType_20142_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20142_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20142_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_20145_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20145_Title = {
    Text = "Recompensa de Login"
  },
  TipsType_20151_Desc = {
    Text = "Após o reset, a quantidade restante de \"itens especiais\" será redefinida para o máximo, confirmar?"
  },
  TipsType_20151_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20151_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20151_Title = {
    Text = "Confirmar reset"
  },
  TipsType_20152_Desc = {
    Text = "{s1} insuficiente, você deseja usar o vale-rosa *{s2} para completar?"
  },
  TipsType_20152_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20152_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20152_Title = {
    Text = "Confirmação de ativação"
  },
  TipsType_20153_Desc = {
    Text = "Após o reset, a quantidade restante de \"itens especiais\" e \"itens comuns\" será redefinida para o máximo.\nA partir da {s1}ª vez, os \"itens especiais\" não serão mais redefinidos.\nConfirmar?\n\n?"
  },
  TipsType_20153_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20153_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20153_Title = {
    Text = "Confirmar reset"
  },
  TipsType_20154_Desc = {
    Text = "Após o reset, a quantidade restante de \"itens especiais\" e \"itens comuns\" será redefinida para o máximo.\nA partir da 3ª vez, \"itens especiais\" não serão mais redefinidos.\n<Blue:Ainda há \"itens comuns\">, confirmar?"
  },
  TipsType_20154_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20154_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20154_Title = {
    Text = "Confirmar reset"
  },
  TipsType_20155_Desc = {
    Text = "Os materiais de empilhamento incluem ciclos de vida bloqueados, confirmar consumo para empilhamento?"
  },
  TipsType_20155_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20155_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20155_Title = {
    Text = "Confirmação de empilhamento"
  },
  TipsType_20156_Desc = {
    Text = "Você deseja confirmar a utilização dos <TipsHighlightText:Ponto de partida real*1> desbloqueados?\n(Durante a atividade \"onda de desejo\", os pontos de partida real necessários para desbloquear foram reduzidos de {s1} para {s2}.)"
  },
  TipsType_20156_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20156_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20156_Title = {
    Text = "Confirmação de desbloqueio"
  },
  TipsType_20157_Desc = {
    Text = "Você deseja confirmar a utilização dos <TipsHighlightText:Ponto de partida real*{s1}> desbloqueados?"
  },
  TipsType_20157_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20157_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20157_Title = {
    Text = "Confirmação de desbloqueio"
  },
  TipsType_20158_Desc = {
    Text = "Nível atual expirado, sem recompensas após completar. Deseja sair?"
  },
  TipsType_20158_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20158_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20158_Title = {
    Text = "Confirmação de saída"
  },
  TipsType_20159_Desc = {
    Text = "<TipsHighlightText:\"{s1}\"> excedeu o limite em <TipsHighlightText: {s2}>, cada unidade foi convertida em <Blue:\"Convite do Invisível\" × 1>"
  },
  TipsType_20159_Title = {
    Text = "Dica de conversão"
  },
  TipsType_20160_Desc = {
    Text = "Você desbloqueou <TipsHighlightText:\"{s1}\">\nOs benefícios de desbloqueio gratuitos deste evento oferecerão a você a seguinte compensação."
  },
  TipsType_20160_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20160_Title = {
    Text = "Aviso de compensação"
  },
  TipsType_20161_Desc = {
    Text = "<TipsHighlightText:{s1}> excedeu o limite em <TipsHighlightText:{s2}>. Cada unidade excedente foi convertida em <Blue:Vale-rosa*5000>"
  },
  TipsType_20161_Title = {
    Text = "Dica de conversão"
  },
  TipsType_20162_Desc = {
    Text = "Vai redefinir o estado de atualização, ascensão, habilidades, talentos e aprofundamento espiritual do despertador e devolver os recursos consumidos correspondentes. \nConfirmar a regressão de desenvolvimento de <WeaponEffect_Num:{s1}>?"
  },
  TipsType_20162_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20162_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20162_Title = {
    Text = "Rastreamento de criação"
  },
  TipsType_20163_Desc = {
    Text = "Vai redefinir o estado de despertar do despertador e devolver os recursos consumidos correspondentes. \n Confirmar a regressão de desenvolvimento de <WeaponEffect_Num:{s1}>?"
  },
  TipsType_20163_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20163_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20163_Title = {
    Text = "Recuperação de Inspiração"
  },
  TipsType_20164_Desc = {
    Text = "Está prestes a redefinir o estado de melhoria, ascenso, habilidades, talentos, despertar espiritual e aprofundamento gnóstico do corpo desperto, devolvendo os consumos correspondentes, \n e retornando o corpo desperto à piscina negra. \n Confirmar a devolução de <WeaponEffect_Num:{s1}> à piscina negra?"
  },
  TipsType_20164_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20164_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20164_Title = {
    Text = "Devolver o Blackpool"
  },
  TipsType_20165_Desc = {
    Text = "<WeaponEffect_Num:{s1}> pertence a um corpo desperto especial e só pode reverter melhorias, ascensões, habilidades, talentos e aprofundamento gnóstico, <Red: não é possível reverter o despertar espiritual>, deseja confirmar a ativação da reversão para <WeaponEffect_Num:{s1}>?\nEsta operação não pode ser revertida, por favor, confirme com cautela"
  },
  TipsType_20165_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20165_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20165_Title = {
    Text = "Escolha de retrocesso"
  },
  TipsType_20166_Desc = {
    Text = "Despertador especial não pode realizar regressão de invocação espiritual"
  },
  TipsType_20167_Desc = {
    Text = "Esta regressão já utilizou \"regressão de desenvolvimento\", por favor realize \"regressão de desenvolvimento\" na próxima vez que iniciar uma regressão."
  },
  TipsType_20168_Desc = {
    Text = "Esta regressão já utilizou \"Regressão de Invocação Espiritual\". Na próxima vez que iniciar uma regressão, por favor realize \"Regressão de Invocação Espiritual\"."
  },
  TipsType_20169_BottomDesc = {
    Text = "<Blue:Aviso: Uma vez selecionado, não será possível alterar nesta atividade!>"
  },
  TipsType_20169_Desc = {
    Text = "Tem certeza de que deseja escolher o Despertado <OrangeQuality:\"{s1}\"> e a Roda do Destino recomendada <OrangeQuality:\"{s2}\"> como UP direcionado deste evento?"
  },
  TipsType_20169_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20169_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20169_Title = {
    Text = "Confirmar seleção"
  },
  TipsType_20170_Desc = {
    Text = "Já atingiu o limite de desafios diários. Volte amanhã para tentar novamente!"
  },
  TipsType_20171_Desc = {
    Text = "Agora você pode ir para o \"Mergulho dos Sonhos\"!"
  },
  TipsType_20173_Desc = {
    Text = "Você agora pode ir para \"Traphase\"!"
  },
  TipsType_20174_Desc = {
    Text = "Agora você pode ir para \"Operação de Investigação - Difícil\"!"
  },
  TipsType_20175_Desc = {
    Text = "Agora você pode seguir para a \"Existência Transcendental\"!"
  },
  TipsType_20176_Desc = {
    Text = "Agora você pode entrar na \"Zona Proibida de Fusão\"!"
  },
  TipsType_20177_Desc = {
    Text = "Agora você pode ir para o \"Frenzy de Reprodução\"!"
  },
  TipsType_20178_Desc = {
    Text = "Agora você pode equipar a \"Segunda Roda do Destino\"!"
  },
  TipsType_20179_Desc = {
    Text = "Agora você pode ir para o \"Enxame do Caos\"!"
  },
  TipsType_20180_Desc = {
    Text = "Agora você pode ir para o \"Registro Tabu\"!"
  },
  TipsType_20181_Desc = {
    Text = "Agora você pode acessar o \"Upgrade Secreta\"!"
  },
  TipsType_20182_Desc = {
    Text = "Agora você pode acessar a \"Transcrição Secreta\"!"
  },
  TipsType_20183_Desc = {
    Text = "Evento atual encerrado"
  },
  TipsType_20184_Desc = {
    Text = "\"Notas\" desbloqueado!"
  },
  TipsType_20185_Desc = {
    Text = "Confirmar pular toda a história?"
  },
  TipsType_20185_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20185_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20185_Title = {
    Text = "Pular a cena"
  },
  TipsType_20186_Desc = {
    Text = "Serão baixados os dados necessários para executar o jogo. \nDeseja continuar? \n\n*Recomenda-se fazer o download em um ambiente com conexão Wi-Fi.\n\n."
  },
  TipsType_20186_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20186_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20187_Desc = {
    Text = "Recursos baixados concluídos"
  },
  TipsType_20187_LeftBtnDesc = {Text = "Confirmar"},
  TipsType_20188_Desc = {
    Text = "Espaço de armazenamento insuficiente. É necessário reservar pelo menos {s1} de espaço de armazenamento, caso contrário, pode causar perda de recursos durante a execução. Deseja continuar o download?"
  },
  TipsType_20188_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20188_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20189_Desc = {
    Text = "Falha ao baixar recursos, tentar novamente?"
  },
  TipsType_20189_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20189_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20190_Desc = {
    Text = "<TipsHighlightText:{s1}>excedeu o limite em<TipsHighlightText: {s2}>, cada unidade foi convertida em<Blue:{s3}>"
  },
  TipsType_20190_Title = {
    Text = "Dica de conversão"
  },
  TipsType_20191_Desc = {
    Text = "Agora você pode ir para o \"Evento\"!"
  },
  TipsType_20192_Desc = {
    Text = "Serão baixados os dados necessários para jogar o conteúdo subsequente do prólogo.\nTamanho do recurso: {s1}\nDeseja continuar?\n\n*Recomenda-se realizar o download em uma rede Wi-Fi."
  },
  TipsType_20192_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20192_RightBtnDesc = {Text = "Baixar"},
  TipsType_20193_Desc = {
    Text = "Agora você pode ir para \"Despacho\"!"
  },
  TipsType_20194_Desc = {
    Text = "Agora você pode acessar a \"Comunicação do Núcleo de Prata\"!"
  },
  TipsType_20195_Desc = {
    Text = "\"Curriculum\" agora está disponível!"
  },
  TipsType_20196_Desc = {
    Text = "Agora você pode seguir para o \"Reino da Escuridão\"!"
  },
  TipsType_20197_Desc = {
    Text = "Você já atingiu o número máximo de despertares! Vá até a missão e receba sua recompensa!"
  },
  TipsType_20198_Desc = {
    Text = "Missão ainda não concluída, por favor conclua a missão antes de vir coletar!"
  },
  TipsType_20199_Desc = {
    Text = "Após receber, a \"Credencial de agente\" excederá o limite de posse,\ne o excedente não será obtido.\nDeseja continuar?"
  },
  TipsType_20199_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20199_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20199_Title = {
    Text = "Confirmação de recebimento"
  },
  TipsType_20200_Desc = {
    Text = "Confirmar o uso de <Blue:Credencial de agente*1> para concluir instantaneamente a missão diária?"
  },
  TipsType_20200_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20200_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20200_Title = {
    Text = "Confirmação de Agente"
  },
  TipsType_20201_Desc = {
    Text = "Os seguintes pactos estão equipados, deseja substituí-los?"
  },
  TipsType_20201_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20201_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20201_Title = {
    Text = "Confirmar substituição"
  },
  TipsType_20202_Desc = {
    Text = "Você tem certeza de que deseja excluir o plano [{s2}] que está atualmente aplicado a {s1}?"
  },
  TipsType_20202_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20202_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20202_Title = {
    Text = "Confirmação de exclusão"
  },
  TipsType_20203_Desc = {
    Text = "Efeito de Mandala duplicado na equipe, {s1} já equipado, confirmar?"
  },
  TipsType_20203_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20203_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20203_Title = {
    Text = "Confirmação de equipamento"
  },
  TipsType_20204_Desc = {
    Text = "O pacto atual já foi usado em {s1}, após a decomposição, ele será removido desse plano, você confirma?"
  },
  TipsType_20204_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20204_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20204_Title = {
    Text = "Confirmação de exclusão"
  },
  TipsType_20205_Desc = {
    Text = "O pacto atual já foi usado na formação {s1}, após a decomposição, ele será removido, você confirma?"
  },
  TipsType_20205_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20205_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20205_Title = {
    Text = "Confirmação de exclusão"
  },
  TipsType_20206_Desc = {
    Text = "A roda do destino atual já foi usada na formação {s1}, após a decomposição, ela será removida dessa formação, você confirma?"
  },
  TipsType_20206_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20206_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20206_Title = {
    Text = "Confirmação de exclusão"
  },
  TipsType_20207_Desc = {
    Text = "Plano não salvo, sair limpará edição. Confirmar saída?"
  },
  TipsType_20207_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20207_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20207_Title = {
    Text = "Confirmação de salvamento"
  },
  TipsType_20208_Desc = {
    Text = "Recompensa da missão foi recebida. Vá verificar outras missões!"
  },
  TipsType_20209_Desc = {
    Text = "Missão expirada"
  },
  TipsType_20210_Desc = {
    Text = "Para garantir a melhor experiência da trama, recomenda-se completar os seguintes níveis de investigação."
  },
  TipsType_20210_LeftBtnDesc = {Text = "Sair"},
  TipsType_20210_RightBtnDesc = {
    Text = "Ainda investigar"
  },
  TipsType_20210_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_20211_Desc = {
    Text = "Abre em {s1} dias {s2} horas"
  },
  TipsType_20212_Desc = {
    Text = "Abre em {s1} horas e {s2} minutos"
  },
  TipsType_20213_Desc = {
    Text = "<WeaponEffect_Num:{s1}>Acionado o excesso de causalidade na formação, qualquer retrocesso fará com que o excesso de causalidade deixe de funcionar e será automaticamente removido da formação. Confirmar a escolha de iniciar o retrocesso para <WeaponEffect_Num:{s1}>? \n Esta operação não pode ser revertida, por favor, confirme com cautela"
  },
  TipsType_20213_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20213_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20213_Title = {
    Text = "Escolha de retrocesso"
  },
  TipsType_20214_Desc = {
    Text = "Vai redefinir o estado de empilhamento da Roda do Destino e devolver todos os consumos de empilhamento. \n<WeaponEffect_Num:{s1}> ativou Causalidade Extrema na formação, será removido automaticamente da formação após a reversão. \nConfirmar a reversão de empilhamento para <WeaponEffect_Num:{s1}>?"
  },
  TipsType_20214_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20214_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20214_Title = {
    Text = "Reversão de empilhamento"
  },
  TipsType_20215_Desc = {
    Text = "Está prestes a redefinir o estado empilhado da roda do destino, devolver todos os custos de empilhamento e retornar a roda ao abismo. \n<WeaponEffect_Num:{s1}> já ativou a causalidade excedente na formação, após a devolução, será automaticamente removida da formação. \nConfirmar a devolução de <WeaponEffect_Num:{s1}> ao abismo?"
  },
  TipsType_20215_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20215_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20215_Title = {
    Text = "Devolver o Blackpool"
  },
  TipsType_20216_Desc = {
    Text = "Deseja comprar com <Blue:{s1} × {s2}>?"
  },
  TipsType_20216_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20216_RightBtnDesc = {Text = "Comprar"},
  TipsType_20216_Title = {
    Text = "Confirmação de compra"
  },
  TipsType_20217_Desc = {
    Text = "{s1} abrirá após {s2}."
  },
  TipsType_20218_Desc = {
    Text = "Os Despertos pré-selecionados para esta investigação não podem ser removidos, apenas substituídos por outros Despertos compatíveis."
  },
  TipsType_20219_Desc = {
    Text = "Já foi selecionado um Despertado idêntico. Não é possível selecionar novamente."
  },
  TipsType_20220_Desc = {
    Text = "Foi detectado que você não está usando Wi-Fi no momento. O download consumirá uma quantidade significativa de dados móveis. Deseja confirmar o download?\nTamanho do recurso: {s1}\nDeseja continuar?"
  },
  TipsType_20220_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20220_RightBtnDesc = {Text = "Baixar"},
  TipsType_20221_Desc = {
    Text = "Recursos baixados concluídos"
  },
  TipsType_20221_LeftBtnDesc = {Text = "Confirmar"},
  TipsType_20222_Desc = {
    Text = "Espaço de armazenamento insuficiente. É necessário reservar pelo menos {s1} de espaço de armazenamento, caso contrário, pode causar perda de recursos durante a execução. Deseja continuar o download?"
  },
  TipsType_20222_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20222_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20223_Desc = {
    Text = "Falha ao baixar recursos, tentar novamente?"
  },
  TipsType_20223_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20223_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20224_Desc = {
    Text = "Serão baixados os dados necessários para jogar o conteúdo subsequente do prólogo.\nTamanho do recurso: {s1}\nDeseja continuar?\n\n*Recomenda-se realizar o download em uma rede Wi-Fi."
  },
  TipsType_20224_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20224_RightBtnDesc = {Text = "Baixar"},
  TipsType_20225_Desc = {
    Text = "{s1} já concluído, deseja enfrentar um desafio adicional?\nO desafio adicional concede {s2} pontos de treinamento"
  },
  TipsType_20225_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20225_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20225_Title = {
    Text = "Desafio Extra"
  },
  TipsType_20226_Desc = {
    Text = "Após o reset, os Despertados, Chaves e Rodas do Destino da equipe de desafio extra poderão ser reutilizados, mas os pontos de treinamento obtidos na conclusão extra deste nível serão deduzidos (não afeta o estado das recompensas). Confirmar o reset?"
  },
  TipsType_20226_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20226_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20226_Title = {
    Text = "Confirmar reset"
  },
  TipsType_20227_Desc = {
    Text = "Após o reset, os Corpos Despertos, Ordens de chave e Rodas do destino da equipe de investigação atual poderão ser reutilizados, e a equipe de desafio extra substituirá a equipe de investigação atual, mas os pontos de Treinamento obtidos na conclusão extra deste nível serão deduzidos (não afeta o estado das recompensas). Confirmar o reset?"
  },
  TipsType_20227_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20227_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20227_Title = {
    Text = "Confirmar reset"
  },
  TipsType_20228_Desc = {
    Text = "Deslize a lista para baixo para ver mais anúncios"
  },
  TipsType_20229_Desc = {
    Text = "<Blue:{s1}> atingiu o limite de nível de ascensão.\nVocê gostaria de continuar comprando?\nQuantidade restante: {s2}"
  },
  TipsType_20229_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20229_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20229_Title = {
    Text = "Confirmação de compra"
  },
  TipsType_20230_Desc = {
    Text = "Para garantir a melhor experiência da trama, recomenda-se completar os seguintes níveis de investigação."
  },
  TipsType_20230_LeftBtnDesc = {Text = "Sair"},
  TipsType_20230_RightBtnDesc = {
    Text = "Ainda investigar"
  },
  TipsType_20230_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_20231_Desc = {
    Text = "Para garantir a melhor experiência da trama, recomenda-se completar as seguintes fases de investigação."
  },
  TipsType_20231_LeftBtnDesc = {Text = "Sair"},
  TipsType_20231_RightBtnDesc = {
    Text = "Ainda investigar"
  },
  TipsType_20231_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_20232_Desc = {
    Text = "Para garantir a melhor experiência da trama, recomenda-se completar os seguintes níveis de investigação."
  },
  TipsType_20232_LeftBtnDesc = {Text = "Sair"},
  TipsType_20232_RightBtnDesc = {
    Text = "Ainda investigar"
  },
  TipsType_20232_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_20233_Desc = {
    Text = "Materiais necessários atualmente insuficientes. Deseja consumir os seguintes materiais para completar?"
  },
  TipsType_20233_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20233_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20233_Title = {
    Text = "Confirmar preenchimento"
  },
  TipsType_20234_Desc = {
    Text = "Apenas chaves especificadas podem ser equipadas nesta fase e não podem ser substituídas."
  },
  TipsType_20235_Desc = {
    Text = "Para garantir a melhor experiência da trama, recomenda-se completar os seguintes níveis de investigação."
  },
  TipsType_20235_LeftBtnDesc = {Text = "Sair"},
  TipsType_20235_RightBtnDesc = {
    Text = "Ainda investigar"
  },
  TipsType_20235_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_20236_Desc = {
    Text = "Para garantir a melhor experiência da trama, recomenda-se completar os seguintes níveis de investigação."
  },
  TipsType_20236_LeftBtnDesc = {Text = "Sair"},
  TipsType_20236_RightBtnDesc = {
    Text = "Ainda investigar"
  },
  TipsType_20236_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_20237_Desc = {
    Text = "Para garantir a melhor experiência da trama, recomenda-se completar as seguintes fases de investigação."
  },
  TipsType_20237_LeftBtnDesc = {Text = "Sair"},
  TipsType_20237_RightBtnDesc = {
    Text = "Ainda investigar"
  },
  TipsType_20237_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_20238_Desc = {
    Text = "Para garantir a melhor experiência da trama, recomenda-se completar as seguintes fases de investigação."
  },
  TipsType_20238_LeftBtnDesc = {Text = "Sair"},
  TipsType_20238_RightBtnDesc = {
    Text = "Ainda investigar"
  },
  TipsType_20238_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_20239_Desc = {
    Text = "Para garantir a melhor experiência da trama, recomenda-se completar os seguintes níveis de investigação."
  },
  TipsType_20239_LeftBtnDesc = {Text = "Sair"},
  TipsType_20239_RightBtnDesc = {
    Text = "Ainda investigar"
  },
  TipsType_20239_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_20240_Desc = {
    Text = "Reparo concluído, por favor, reinicie o jogo"
  },
  TipsType_20240_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20240_Title = {Text = "Aviso"},
  TipsType_20241_Desc = {
    Text = "Ainda são necessários {s1} \" <Blue:{s2}> \" para atingir o limite de nível de empilhamento \n Deseja continuar a comprar?"
  },
  TipsType_20241_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20241_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20241_Title = {
    Text = "Confirmação de compra"
  },
  TipsType_20250_Desc = {
    Text = "Para garantir a melhor experiência da trama, recomenda-se completar os seguintes níveis de investigação."
  },
  TipsType_20250_LeftBtnDesc = {Text = "Sair"},
  TipsType_20250_RightBtnDesc = {
    Text = "Ainda investigar"
  },
  TipsType_20250_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_20251_Desc = {
    Text = "Para garantir a melhor experiência da trama, recomenda-se completar os seguintes níveis de investigação."
  },
  TipsType_20251_LeftBtnDesc = {Text = "Sair"},
  TipsType_20251_RightBtnDesc = {
    Text = "Ainda investigar"
  },
  TipsType_20251_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_20252_Desc = {
    Text = "Para garantir a melhor experiência da trama, recomenda-se completar os seguintes níveis de investigação."
  },
  TipsType_20252_LeftBtnDesc = {Text = "Sair"},
  TipsType_20252_RightBtnDesc = {
    Text = "Ainda investigar"
  },
  TipsType_20252_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_20259_Desc = {
    Text = "Configuração de substituição salva quando o \"Selo de mil faces\" é insuficiente"
  },
  TipsType_20300_Desc = {
    Text = "Já possui {s1} Despertado com essa função, não pode usar outro igual na mesma equipe"
  },
  TipsType_20301_Desc = {
    Text = "Você pode agora prosseguir para \"Tarefas Regulares!\""
  },
  TipsType_20351_Desc = {
    Text = "{s1} insuficiente, deseja usar {s2}{s3} para trocar por {s4}{s5}?"
  },
  TipsType_20351_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20351_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20351_Title = {
    Text = "{s1} insuficiente"
  },
  TipsType_20352_Desc = {
    Text = "Você está prestes a se vincular ao outro jogador. Após a vinculação, não será possível desfazer. Confirmar se deseja continuar com a vinculação?"
  },
  TipsType_20352_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20352_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20352_Title = {
    Text = "Confirmar convite"
  },
  TipsType_20353_Desc = {
    Text = "Código de convite copiado para a área de transferência."
  },
  TipsType_20354_Desc = {
    Text = "Você já é o convidador do outro lado."
  },
  TipsType_20355_Desc = {
    Text = "Não é possível inserir seu próprio código de convite. Tente obter um código de convite de outro Guardião do Segredo."
  },
  TipsType_20356_Desc = {
    Text = "Jogar novamente permite reviver a história do prólogo e o tutorial! \nNo entanto, durante a reprodução, todas as recompensas das fases são apenas demonstrativas e não poderão ser realmente obtidas. \nConfirmar?\n\n?"
  },
  TipsType_20356_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20356_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20356_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_20357_Desc = {
    Text = "Você tem certeza de que não vai prestar mais atenção a este {s1} guardião?"
  },
  TipsType_20357_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20357_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20357_Title = {
    Text = "Deixar de seguir"
  },
  TipsType_20358_Desc = {
    Text = "Há cancelamentos de acompanhamento não confirmados, sair não salvará nenhuma ação. Deseja sair?"
  },
  TipsType_20358_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20358_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20358_Title = {
    Text = "Confirmação de saída"
  },
  TipsType_20400_Desc = {
    Text = "<WeaponEffect_Num:\"{s1}\"> insuficiente, deseja ir para trocar?"
  },
  TipsType_20400_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_20400_RightBtnDesc = {Text = "Confirmar"},
  TipsType_20400_Title = {
    Text = "Itens de sorteio insuficientes"
  },
  TipsType_300001_Desc = {
    Text = "\"Primeiro Brilho Prateado\" só oferece uma chance gratuita de despertar. Deseja usá-la?"
  },
  TipsType_300001_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_300001_RightBtnDesc = {Text = "Confirmar"},
  TipsType_300001_Title = {
    Text = "Confirmação de despertar"
  },
  TipsType_300002_Desc = {
    Text = "Tem certeza de que deseja confirmar o resultado deste despertar? Após a confirmação, esta despertada consumirá uma das 5 despertadas gratuitas."
  },
  TipsType_300002_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_300002_RightBtnDesc = {Text = "Confirmar"},
  TipsType_300002_Title = {
    Text = "Confirmação de despertar"
  },
  TipsType_30001_Desc = {
    Text = "Dica lateral sem ícone"
  },
  TipsType_30003_Desc = {
    Text = "{s1} desbloqueado"
  },
  TipsType_30004_Desc = {
    Text = "Modo avançado de {s1} desbloqueado"
  },
  TipsType_30005_Desc = {
    Text = "Desbloqueia {s1} (difícil)"
  },
  TipsType_31000_Desc = {
    Text = "Tem certeza de que deseja usar esta data de nascimento para autenticação? A data de nascimento, uma vez confirmada, não poderá ser alterada!"
  },
  TipsType_31000_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_31000_RightBtnDesc = {Text = "Confirmar"},
  TipsType_31000_Title = {
    Text = "Autenticação de Idade"
  },
  TipsType_31001_Desc = {
    Text = "Este mês você já recarregou <Blue:{s1}> yuan, o limite máximo é <Blue:{s2}> yuan. Tente recarregar no próximo mês ou selecione uma opção de valor menor."
  },
  TipsType_31002_Desc = {
    Text = "Por favor, conclua primeiro a verificação de idade"
  },
  TipsType_31003_Desc = {
    Text = "A Chave de Prata detectou uma crise mortal, deseja ativar o Corpo de Gnosis de Emergência?\n(A ressurreição consumirá 1 uso do Corpo de Gnosis de Emergência, que é obtido automaticamente às 9h todos os dias, usos restantes: {s1})\n<Blue:(A primeira ressurreição não consome o Corpo de Gnosis de Emergência)>"
  },
  TipsType_31003_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_31003_RightBtnDesc = {Text = "Confirmar"},
  TipsType_31003_Title = {
    Text = "Confirmação de Ressurreição"
  },
  TipsType_31004_Desc = {
    Text = "A Chave de Prata detectou uma crise mortal, deseja ativar o Corpo de Gnosis de Emergência?\n(A ressurreição consumirá 1 uso do Corpo de Gnosis de Emergência, que é obtido automaticamente às 9h todos os dias, usos restantes: {s1})\n<Blue:(A primeira ressurreição não consome o Corpo de Gnosis de Emergência)>"
  },
  TipsType_31004_RightBtnDesc = {Text = "Confirmar"},
  TipsType_31004_Title = {
    Text = "Confirmação de Ressurreição"
  },
  TipsType_40001_Desc = {
    Text = "Quando a vida chegar a 0, a investigação será encerrada à força"
  },
  TipsType_40001_Title = {Text = "Vida"},
  TipsType_40002_Desc = {
    Text = "Mover-se no mapa e investigar eventos causará estresse mental. O acúmulo de estresse causará sintomas no Guardião do Segredo.\nCada movimento aumenta o estresse em 10 pontos. A cada 100 pontos de estresse, um sintoma é adquirido.\nQuando o estresse atinge 500, cada movimento reduz 10% da vida"
  },
  TipsType_40002_Title = {Text = "Estresse"},
  TipsType_40003_Desc = {
    Text = "Quanto maior o nível de despacho, mais difícil é a missão, e as recompensas obtidas pelo despacho também são proporcionalmente aumentadas"
  },
  TipsType_40003_Title = {
    Text = "Nível de despacho"
  },
  TipsType_40004_Desc = {
    Text = "A primeira cópia temporária da carta de comando jogada a cada turno entra no espaço hiperdimensional. \n Quando o espaço hiperdimensional atinge o limite, você ganha 1 turno ultra extra e preserva o escudo. \n Efeito do domínio de área: no início do turno, há uma chance de adicionar 1 carta de \"inspiração\" à mão."
  },
  TipsType_40004_Title = {
    Text = "Espaço Hiperdimensional"
  },
  TipsType_40005_Desc = {
    Text = "O Guardião pode aumentar seu nível através de investigações, interlúdios e outros desafios. Mais mecânicas serão desbloqueadas gradualmente conforme o nível do Guardião aumentar"
  },
  TipsType_40005_Title = {Text = "Nível"},
  TipsType_40006_Desc = {
    Text = "Disparar cartas de comando requer consumo de poder de cálculo. No final do turno, não haverá preservação do poder de cálculo restante, e no início do turno, o poder de cálculo será restaurado ao limite máximo."
  },
  TipsType_40006_Title = {
    Text = "Poder de cálculo"
  },
  TipsType_40007_Desc = {
    Text = "A chave de prata percebeu uma energia especial, pode haver materiais preciosos escondidos no mapa"
  },
  TipsType_40007_Title = {
    Text = "Recursos Ocultos"
  },
  TipsType_40008_Desc = {
    Text = "Quando enfrentar uma crise mortal na batalha, pode ser ativa, consumindo 1 cartão a cada uso, restaurando a vida do guardião e a loucura do despertador até o limite; obtendo automaticamente 1 cartão todos os dias às 9h"
  },
  TipsType_40008_Title = {
    Text = "Corpo de Gnosis de Emergência"
  },
  TipsType_40009_Desc = {
    Text = "Jogar cartas de comando requer custo de aritmética. No final do turno, não haverá sobra de aritmética, no início do turno, o limite de aritmética aumenta em 1 e a aritmética se recupera para o limite máximo. Atualmente é o {s1} turno"
  },
  TipsType_40009_Title = {
    Text = "Poder de cálculo"
  },
  TipsType_AbyssChallengeResetTips_Desc = {
    Text = "A Zona Proibida de Fusão de desastres foi reiniciada. O desafio em andamento será encerrado imediatamente."
  },
  TipsType_AbyssChallengeResetTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_AbyssChallengeResetTips_Title = {Text = "Dica"},
  TipsType_AbyssChallengeRevivalTips_Desc = {
    Text = "A Chave de Prata detecta uma crise fatal. Ativar o Corpo de Gnosis de Emergência?\n(A ressurreição consumirá 1 Corpo de Gnosis de Emergência. Você recebe 1 diariamente às 9h.)"
  },
  TipsType_AbyssChallengeRevivalTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_AbyssChallengeRevivalTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_AbyssChallengeRevivalTips_Title = {
    Text = "Confirmação de Ressurreição"
  },
  TipsType_AcceptConfirm_Desc = {
    Text = "Você aceita o convite de <Blue:{s1}> para <Blue:{s2}>?"
  },
  TipsType_AcceptConfirm_LeftBtnDesc = {Text = "Recusar"},
  TipsType_AcceptConfirm_RightBtnDesc = {Text = "Aceitar"},
  TipsType_AcceptConfirm_Title = {
    Text = "Combate de senha"
  },
  TipsType_ActivitySignRewardTaskNotCompleteTips_Desc = {
    Text = "Complete a tarefa correspondente para realizar o despertar"
  },
  TipsType_AlreadyIsBackgroundMusicTips_Desc = {
    Text = "Já é a música de fundo atual"
  },
  TipsType_AwakerAutoInsertCoinNotEnoughTips_Desc = {
    Text = "\"Cupom de ouro rosa\" insuficiente para usar completamente o \"Elixir de Gnosis\" disponível. Recarregue o \"Cupom de ouro rosa\" e tente novamente."
  },
  TipsType_AwakerNotOpenTips_Desc = {
    Text = "Corpo Desperto ainda não disponível. Fique atento!"
  },
  TipsType_AwakerRandomChestConfirm_Desc = {
    Text = "Confirmar o uso de <Blue:{s1}> para obter 1 Corpo Desperto <Blue:aleatório>?"
  },
  TipsType_AwakerRandomChestConfirm_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_AwakerRandomChestConfirm_RightBtnDesc = {Text = "Confirmar"},
  TipsType_AwakerRandomChestConfirm_Title = {
    Text = "Confirmação de Uso"
  },
  TipsType_BattleCreateFail_Desc = {
    Text = "Falha na Criação da Batalha"
  },
  TipsType_BattlePassAllCompleteTips_Desc = {
    Text = "O Diário do Guardião do Segredo atual foi totalmente concluído."
  },
  TipsType_BestExperienceTips_Chapter3_Desc = {
    Text = "Para garantir a melhor experiência da trama, recomenda-se completar as seguintes fases de investigação."
  },
  TipsType_BestExperienceTips_Chapter3_LeftBtnDesc = {Text = "Sair"},
  TipsType_BestExperienceTips_Chapter3_RightBtnDesc = {
    Text = "Ainda investigar"
  },
  TipsType_BestExperienceTips_Chapter3_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_BestExperienceTips_Chapter7_Desc = {
    Text = "Para garantir a melhor experiência da trama, recomenda-se completar os seguintes níveis de investigação."
  },
  TipsType_BestExperienceTips_Chapter7_LeftBtnDesc = {Text = "Sair"},
  TipsType_BestExperienceTips_Chapter7_RightBtnDesc = {
    Text = "Ainda investigar"
  },
  TipsType_BestExperienceTips_Chapter7_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_BestExperienceTips_Chapter8_Desc = {
    Text = "Para garantir a melhor experiência da trama, recomenda-se completar os seguintes níveis de investigação."
  },
  TipsType_BestExperienceTips_Chapter8_LeftBtnDesc = {Text = "Sair"},
  TipsType_BestExperienceTips_Chapter8_RightBtnDesc = {
    Text = "Ainda investigar"
  },
  TipsType_BestExperienceTips_Chapter8_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_BestExperienceTips_ChapterS2_Desc = {
    Text = "Para garantir a melhor experiência da trama, recomenda-se completar os seguintes níveis de investigação."
  },
  TipsType_BestExperienceTips_ChapterS2_LeftBtnDesc = {Text = "Sair"},
  TipsType_BestExperienceTips_ChapterS2_RightBtnDesc = {
    Text = "Ainda investigar"
  },
  TipsType_BestExperienceTips_ChapterS2_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_BestExperienceTips_ChapterS3_Desc = {
    Text = "Para garantir a melhor experiência da trama, recomenda-se completar os seguintes níveis de investigação."
  },
  TipsType_BestExperienceTips_ChapterS3_LeftBtnDesc = {Text = "Sair"},
  TipsType_BestExperienceTips_ChapterS3_RightBtnDesc = {
    Text = "Ainda investigar"
  },
  TipsType_BestExperienceTips_ChapterS3_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_BestExperienceTips_ChapterS4_Desc = {
    Text = "Para garantir a melhor experiência da trama, recomenda-se completar as seguintes fases de investigação."
  },
  TipsType_BestExperienceTips_ChapterS4_LeftBtnDesc = {Text = "Sair"},
  TipsType_BestExperienceTips_ChapterS4_RightBtnDesc = {
    Text = "Ainda investigar"
  },
  TipsType_BestExperienceTips_ChapterS4_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_BestExperienceTips_ChapterS5_Desc = {
    Text = "Para garantir a melhor experiência da trama, recomenda-se completar as seguintes fases de investigação."
  },
  TipsType_BestExperienceTips_ChapterS5_LeftBtnDesc = {Text = "Sair"},
  TipsType_BestExperienceTips_ChapterS5_RightBtnDesc = {
    Text = "Ainda investigar"
  },
  TipsType_BestExperienceTips_ChapterS5_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_BestExperienceTips_MainStoryS1_6_Desc = {
    Text = "Para garantir a melhor experiência da trama, recomenda-se completar as seguintes fases de investigação."
  },
  TipsType_BestExperienceTips_MainStoryS1_6_LeftBtnDesc = {Text = "Sair"},
  TipsType_BestExperienceTips_MainStoryS1_6_RightBtnDesc = {
    Text = "Ainda investigar"
  },
  TipsType_BestExperienceTips_MainStoryS1_6_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_Desc = {
    Text = "Para garantir a melhor experiência da trama, recomenda-se completar as seguintes fases de investigação."
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_LeftBtnDesc = {Text = "Sair"},
  TipsType_BestExperienceTips_TwoAnniversarySubStage_RightBtnDesc = {
    Text = "Ainda investigar"
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_CancelCollectAwakerTips_Desc = {
    Text = "Coleção cancelada"
  },
  TipsType_CoinBulkBuyConfirm_Desc = {
    Text = "Deseja gastar \"Voucher Rosa\" × {s1} para realizar a compra?"
  },
  TipsType_CoinBulkBuyConfirm_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_CoinBulkBuyConfirm_RightBtnDesc = {Text = "Confirmar"},
  TipsType_CoinBulkBuyConfirm_Title = {
    Text = "Confirmação de compra"
  },
  TipsType_CollectAwakerTips_Desc = {
    Text = "Coleção bem-sucedida"
  },
  TipsType_CommonUseBattleHelpLimitTips_Desc = {
    Text = "O número de Guardiões do segredo de apoio de batalha comum atingiu o limite, por favor, ajuste a lista de apoio de batalha comum"
  },
  TipsType_DiskIsFullOrViolation_Desc = {
    Text = "Falha ao carregar arquivos. Por favor, verifique seu espaço de armazenamento."
  },
  TipsType_DiskIsFullOrViolation_RightBtnDesc = {Text = "Confirmar"},
  TipsType_DiskSpaceNotEnough_Desc = {
    Text = "Espaço de armazenamento insuficiente, deseja continuar tentando o download?"
  },
  TipsType_DiskSpaceNotEnough_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_DiskSpaceNotEnough_RightBtnDesc = {Text = "Confirmar"},
  TipsType_DoubleExBPBuyConfirm_Desc = {
    Text = "Você deseja consumir <Blue:\"Líquido de origem\"× {s1}> para comprar?\n <color=#ACBFCA>Esta edição é um tema especial, o preço do tema principal foi reduzido</color>"
  },
  TipsType_DoubleExBPBuyConfirm_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_DoubleExBPBuyConfirm_RightBtnDesc = {Text = "Comprar"},
  TipsType_DoubleExBPBuyConfirm_Title = {
    Text = "Confirmação de compra"
  },
  TipsType_EnterSix_DigitPasswordTips_Desc = {
    Text = "Por favor, insira <color=#5EF2FF>valor da fase</color>"
  },
  TipsType_FilterMaxAwakerCountTips_Desc = {
    Text = "Selecione até {s1} Corpos Despertos para filtrar"
  },
  TipsType_FollowBackConfirm_Desc = {
    Text = "Tem certeza de que deseja seguir os <color=#5EF2FF>{s1}</color> seguidores nesta página?\n\n<color=#96947F>Seguindo atualmente </color>{s2}<color=#A0A0A0>/{s3}\nApós atingir o limite não será possível seguir</color>"
  },
  TipsType_FollowBackConfirm_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_FollowBackConfirm_RightBtnDesc = {Text = "Confirmar"},
  TipsType_FollowBackConfirm_Title = {
    Text = "Confirmação de retorno"
  },
  TipsType_FrenziedOmenUpgradeConfirm_Desc = {
    Text = "Esta operação consumirá uma grande quantidade de recursos, adequada para quem deseja levar as habilidades do Corpo Desperto ao limite. Confirmar o Reforço de \"Sinais Loucos\"?"
  },
  TipsType_FrenziedOmenUpgradeConfirm_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_FrenziedOmenUpgradeConfirm_RightBtnDesc = {Text = "Confirmar"},
  TipsType_FrenziedOmenUpgradeConfirm_Title = {
    Text = "Confirmação de reforço"
  },
  TipsType_GnosticPotentialUpgradeConfirm_Desc = {
    Text = "Esta operação consumirá uma grande quantidade de recursos, adequada para quem deseja levar as habilidades do Corpo Desperto ao limite. Confirmar o Reforço de \"Potencial Gnóstico\"?"
  },
  TipsType_GnosticPotentialUpgradeConfirm_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_GnosticPotentialUpgradeConfirm_RightBtnDesc = {Text = "Confirmar"},
  TipsType_GnosticPotentialUpgradeConfirm_Title = {
    Text = "Confirmação de reforço"
  },
  TipsType_InCharging_Desc = {
    Text = "Pedido em processamento, não faça pagamentos duplicados. \n Se o pagamento foi concluído, aguarde pacientemente a distribuição das recompensas pelo sistema. \n Se o pagamento não foi concluído, tente reiniciar o jogo e tentar novamente. \n Se tiver dúvidas, entre em contato com o suporte ao cliente."
  },
  TipsType_InCharging_RightBtnDesc = {Text = "Confirmar"},
  TipsType_InCharging_Title = {Text = "Aviso"},
  TipsType_KeyShortNameDownLoadTips_Desc = {
    Text = "Baixando recursos de identificação de texto, por favor, tente visualizar novamente mais tarde"
  },
  TipsType_LimitAwakerEnlightenmentOverflowTips_Desc = {
    Text = "O Despertar Espiritual deste Corpo Desperto está completo\nApós selecionar, você receberá apenas \"Fragmento de Retorno da Alma\" ×2"
  },
  TipsType_LimitAwakerEnlightenmentOverflowTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_LimitAwakerEnlightenmentOverflowTips_RightBtnDesc = {Text = "Continuar"},
  TipsType_LimitAwakerEnlightenmentOverflowTips_Title = {
    Text = "Confirmar seleção"
  },
  TipsType_MainResetBG_Desc = {
    Text = "Você precisa restaurar o fundo do dormitório <Blue:\"tela\"> e <Blue:\"música\"> para o padrão?"
  },
  TipsType_MainResetBG_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_MainResetBG_RightBtnDesc = {Text = "Confirmar"},
  TipsType_MainResetBG_Title = {
    Text = "Restaurar padrão"
  },
  TipsType_MultiSelectBox_FixItemTips_Desc = {
    Text = "Item fixo obtido, não pode ser trocado"
  },
  TipsType_MultiSelectBox_SelectTips_Desc = {
    Text = "Por favor, complete a seleção de todos os itens selecionados por conta própria antes de prosseguir para a compra"
  },
  TipsType_OppositeSideCancelMatchTips_Desc = {
    Text = "O oponente cancelou a partida"
  },
  TipsType_OppositeSideRejectTips_Desc = {
    Text = "O oponente recusou o convite de <Blue:{s1}>, por favor, escolha o modo novamente"
  },
  TipsType_PVEExceedMaxRoundsTips_Desc = {
    Text = "O número de rodadas de combate atingiu o limite máximo\n\nÓ único Guardião do segredo\nQual será a sua escolha agora?"
  },
  TipsType_PVEExceedMaxRoundsTips_LeftBtnDesc = {Text = "Rebatalha"},
  TipsType_PVEExceedMaxRoundsTips_RightBtnDesc = {
    Text = "Retirada temporária"
  },
  TipsType_PVEExceedMaxRoundsTips_Title = {
    Text = "Investigação Falhou"
  },
  TipsType_PVEReplayErrorTips_Desc = {
    Text = "Erro ao obter a gravação da batalha, por favor, tente novamente mais tarde"
  },
  TipsType_PVEReplayMaxRounds_Desc = {
    Text = "A reprodução atingiu o limite máximo de 25 turnos, \n reprodução encerrada."
  },
  TipsType_PVEReplayMaxRounds_RightBtnDesc = {Text = "Confirmar"},
  TipsType_PVEReplayMaxRounds_Title = {
    Text = "Confirmar fim"
  },
  TipsType_PVEReplayNoDataTips_Desc = {
    Text = "Nenhum registro de operação de investigação"
  },
  TipsType_PVEReplayRepeatClickTips_Desc = {
    Text = "Carregando a gravação da batalha, por favor, não repita a operação"
  },
  TipsType_PVEReplaySpecialTeamAssignTips_Desc = {
    Text = "Ainda não suportamos a reprodução de batalhas de formações especiais, aguarde"
  },
  TipsType_PVEReplayTimeoutTips_Desc = {
    Text = "Tempo de espera para obter a gravação de batalha excedido"
  },
  TipsType_PVEReplayUnableOperateTips_Desc = {
    Text = "Não é possível realizar operações durante a reprodução da batalha"
  },
  TipsType_PVETeamShareCodeCopyTips_Desc = {
    Text = "Copiado para a área de transferência"
  },
  TipsType_PVETeamShareCodeError_Desc = {
    Text = "Não foi possível reconhecer corretamente que há <color=#5EF2FF>Operação de investigação</color> formação na área de transferência"
  },
  TipsType_PVETeamShareCodeSaveTips_Desc = {
    Text = "Você confirma a salvaguarda da configuração da equipe correspondente ao código de formação?\nAs partes não mantidas dessa configuração serão deixadas vazias."
  },
  TipsType_PVETeamShareCodeSaveTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_PVETeamShareCodeSaveTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_PVETeamShareCodeSaveTips_Title = {
    Text = "Confirmação de salvamento"
  },
  TipsType_PVETeamShareCodeSpecialTeamAssignTips_Desc = {
    Text = "Esta equipe contém um Corpo Desperto pré-definido, não pode copiar ou importar o código da Formação"
  },
  TipsType_PVPExceedMaxRoundsTips_Loser_Desc = {
    Text = "A partida atingiu o limite de rodadas. O jogador que age primeiro não conseguiu dar Fim à partida e é declarado derrotado."
  },
  TipsType_PVPExceedMaxRoundsTips_Loser_RightBtnDesc = {Text = "Confirmar"},
  TipsType_PVPExceedMaxRoundsTips_Loser_Title = {
    Text = "Combate encerrado"
  },
  TipsType_PVPExceedMaxRoundsTips_Winner_Desc = {
    Text = "A partida atingiu o limite de rodadas. O jogador que age por último resistiu com sucesso até o Fim da partida e é declarado vencedor."
  },
  TipsType_PVPExceedMaxRoundsTips_Winner_RightBtnDesc = {Text = "Confirmar"},
  TipsType_PVPExceedMaxRoundsTips_Winner_Title = {
    Text = "Combate encerrado"
  },
  TipsType_PVPSurrenderConfirm_Desc = {
    Text = "Você se rende?"
  },
  TipsType_PVPSurrenderConfirm_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_PVPSurrenderConfirm_RightBtnDesc = {Text = "Confirmar"},
  TipsType_PVPSurrenderConfirm_Title = {
    Text = "Confirmar Rendição"
  },
  TipsType_PVPTeamShareCodeError_Desc = {
    Text = "Não foi possível reconhecer corretamente que há uma <color=#5EF2FF>Fase de Duelo</color> na formação do clipboard"
  },
  TipsType_PVP_PasswordBattle_BlockTips_Desc = {
    Text = "Você deseja bloquear este Guardião do Segredo?"
  },
  TipsType_PVP_PasswordBattle_BlockTips_LeftBtnDesc = {Text = "Recusar"},
  TipsType_PVP_PasswordBattle_BlockTips_RightBtnDesc = {Text = "Aceitar"},
  TipsType_PVP_PasswordBattle_BlockTips_Title = {Text = "Bloquear"},
  TipsType_PVP_PasswordBattle_GameStartedTips_Desc = {
    Text = "O combate de senha começou"
  },
  TipsType_PVP_PasswordBattle_OthersEnterTips_Desc = {
    Text = "Um novo guardião entrou nesta rodada da batalha criptográfica"
  },
  TipsType_PVP_PasswordBattle_QueueTips_Desc = {
    Text = "Atualmente na fila..."
  },
  TipsType_PVP_PasswordBattle_QuitTips_Desc = {
    Text = "Você quer sair da batalha de senhas?"
  },
  TipsType_PVP_PasswordBattle_QuitTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_PVP_PasswordBattle_QuitTips_RightBtnDesc = {Text = "Sair"},
  TipsType_PVP_PasswordBattle_QuitTips_Title = {
    Text = "Confirmação de saída"
  },
  TipsType_PVP_PasswordBattle_RejectedTips_Desc = {
    Text = "O oponente se recusou a lutar com você"
  },
  TipsType_PassportHoistTips1_Desc = {
    Text = "\"Íon Ativo Básico\"\n·Após o desbloqueio, o \"Ponto de partida real\", \"Núcleo Imaculado\", \"Experiência\" e \"Núcleo de prata\" obtidos nas recompensas acumuladas de \"Íon Ativo Básico\" no \"Treinamento diário\" durante o período atual do Tema principal serão aumentados para 3 vezes. Após a compra do \"Tema principal\", a parte adicional das recompensas acumuladas de \"Íon Ativo Básico\" já recebidas neste período será compensada."
  },
  TipsType_PassportHoistTips2_Desc = {
    Text = "\"Inversão Temporal\"\n·Pode voltar a turnos vividos durante a batalha.\n·Pode retornar a qualquer um dos 25 turnos anteriores da batalha.\n·Após um novo desafio, ainda é possível usar a função de inversão para voltar aos turnos anteriores."
  },
  TipsType_PassportHoistTips3_Desc = {
    Text = "\"Fase de Duelo\"\n·Após desbloquear, todas as cartas da \"Fase de Duelo\" estarão disponíveis durante o período deste tema."
  },
  TipsType_Password_CopiedTips_Desc = {
    Text = "<color=#5EF2FF>O valor da fase</color> foi copiado para a área de transferência"
  },
  TipsType_PayMoneyBuyConfirmDescDetail_Desc = {
    Text = "Deseja gastar <Blue:\"Líquido de origem\" × {s1} >para comprar?\n\n<size=30><color=#ACBFCA>Ao consumir \"Líquido de origem\", o \"Líquido de origem\" de presente será deduzido primeiro.\n(Extraído: {s2}, Presente: {s3})</color></size>"
  },
  TipsType_PayMoneyBuyConfirmDescDetail_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_PayMoneyBuyConfirmDescDetail_RightBtnDesc = {Text = "Comprar"},
  TipsType_PayMoneyBuyConfirmDescDetail_Title = {
    Text = "Confirmação de compra"
  },
  TipsType_PublishEmptyCommentTips_Desc = {
    Text = "O conteúdo do comentário não pode estar vazio"
  },
  TipsType_PvpCollectionCommentDeleteTips_Desc = {
    Text = "Confirmar exclusão deste comentário?"
  },
  TipsType_PvpCollectionCommentDeleteTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_PvpCollectionCommentDeleteTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_PvpCollectionCommentDeleteTips_Title = {
    Text = "Confirmação de exclusão"
  },
  TipsType_PvpHideCommentConfirm_Desc = {
    Text = "Ocultar todos os comentários?"
  },
  TipsType_PvpHideCommentConfirm_LeftBtnDesc = {Text = "Não"},
  TipsType_PvpHideCommentConfirm_RightBtnDesc = {Text = "Sim"},
  TipsType_PvpHideCommentConfirm_Title = {Text = "Esconder"},
  TipsType_PvpMatchingInterruptTips_Desc = {
    Text = "Anomalia de rede detectada, correspondência interrompida."
  },
  TipsType_RailWayContinueReconnectSeasonSwitchTips_Desc = {
    Text = "Ainda em combate, deseja continuar a batalha anterior? \n A temporada \"Trem da Alegria Veloz\" foi atualizada. Continuar o desafio permite completar as missões da temporada mais recente, mas não será possível acessar a \"Lista de Convidados VIP\"."
  },
  TipsType_RailWayContinueReconnectSeasonSwitchTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_RailWayContinueReconnectSeasonSwitchTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_RailWayContinueReconnectSeasonSwitchTips_Title = {Text = "Dica"},
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_Desc = {
    Text = "O progresso do último desafio foi {s1} - Fase {s2} - Batalha {s3}, tendo obtido \"Pontos VIP\" × {s4}\nA temporada foi atualizada. Continuar o desafio permite completar as missões da temporada mais recente, mas não será possível acessar a \"Lista de Convidados VIP\". Deseja continuar o desafio?"
  },
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_Title = {Text = "CONTINUE"},
  TipsType_RailWayContinueSaveStage_Desc = {
    Text = [[
Retomar progresso: {s1} - Fase {s2} - Combate {s3}.
Pontos VIP ganhos: {s4}.
Deseja continuar o desafio?]]
  },
  TipsType_RailWayContinueSaveStage_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_RailWayContinueSaveStage_RightBtnDesc = {Text = "Confirmar"},
  TipsType_RailWayContinueSaveStage_Title = {
    Text = "Continuar desafio"
  },
  TipsType_RailWayHaveSaveStage_Desc = {
    Text = "É necessário concluir o desafio salvo anteriormente antes de iniciar um novo desafio"
  },
  TipsType_RailWaySaveAndExitInBattleTips_Desc = {
    Text = "Deseja confirmar a saída do desafio?\nO progresso deste desafio será salvo, e na próxima vez que desafiar, você continuará a partir do progresso atual e reiniciará esta batalha."
  },
  TipsType_RailWaySaveAndExitInBattleTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_RailWaySaveAndExitInBattleTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_RailWaySaveAndExitInBattleTips_Title = {
    Text = "Salvar e sair"
  },
  TipsType_RailWaySaveAndExitTips_Desc = {
    Text = "Deseja confirmar a saída do desafio? \n O progresso deste desafio será salvo e será continuado na próxima vez que você tentar."
  },
  TipsType_RailWaySaveAndExitTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_RailWaySaveAndExitTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_RailWaySaveAndExitTips_Title = {
    Text = "Salvar e Sair"
  },
  TipsType_RailWaySeasonSwitchTips_Desc = {
    Text = "A temporada foi atualizada. Continuar o desafio permite completar as missões da temporada mais recente, mas não será possível acessar a \"Lista de Convidados VIP\"."
  },
  TipsType_ReplayNullTips_Desc = {
    Text = "As informações de reprodução não podem estar vazias"
  },
  TipsType_SchoolConflictTips_Desc = {
    Text = "Conflito de Reino. Por favor, reajuste a formação."
  },
  TipsType_SelectedAwakensAndCardsExceedLimit_Desc = {
    Text = "Excedeu a quantidade selecionada"
  },
  TipsType_ServerRankDataLoading_Desc = {
    Text = "Os dados deste ranking ainda não foram totalmente carregados. Por favor, reabra a interface mais tarde."
  },
  TipsType_ServerRankDataLoading_RightBtnDesc = {Text = "Confirmar"},
  TipsType_ServerRankDataLoading_Title = {
    Text = "Dados do ranking do servidor em inicialização"
  },
  TipsType_ShopBulkBuyConfirm_Desc = {
    Text = "<Blue:{s1}> {s2} serão usados para trocar por <Blue:{s3}> {s4}. Confirmar a troca?"
  },
  TipsType_ShopBulkBuyConfirm_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_ShopBulkBuyConfirm_RightBtnDesc = {Text = "Confirmar"},
  TipsType_ShopBulkBuyConfirm_Title = {
    Text = "Confirmação de \"Salvar o mundo\""
  },
  TipsType_SocialRecordHideTips_Desc = {
    Text = "Os registros de batalha estão ocultos"
  },
  TipsType_SteamOverlayEnabledTips_Desc = {
    Text = "Por favor, ative a opção \"Ativar a interface Steam durante o jogo\" em Steam \"Configurações - No jogo\" e nas propriedades do jogo \"Propriedades - Geral\", depois reinicie o jogo para tentar novamente."
  },
  TipsType_SteamOverlayEnabledTips_LeftBtnDesc = {Text = "Confirmar"},
  TipsType_SteamOverlayEnabledTips_Title = {Text = "Aviso"},
  TipsType_SteamRestartTips_Desc = {
    Text = "Erro de autorização do Steam. Por favor, reinicie o cliente Steam e tente novamente."
  },
  TipsType_SteamRestartTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_SteamRestartTips_Title = {
    Text = "Erro de login"
  },
  TipsType_SubBestExperienceTips_Chapter3_Desc = {
    Text = "Para garantir a melhor experiência da trama, recomenda-se completar as seguintes fases de investigação."
  },
  TipsType_SubBestExperienceTips_Chapter3_LeftBtnDesc = {Text = "Sair"},
  TipsType_SubBestExperienceTips_Chapter3_RightBtnDesc = {
    Text = "Ainda investigar"
  },
  TipsType_SubBestExperienceTips_Chapter3_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_SubBestExperienceTips_Chapter5_Desc = {
    Text = "Para garantir a melhor experiência da trama, recomenda-se completar as seguintes fases de investigação."
  },
  TipsType_SubBestExperienceTips_Chapter5_LeftBtnDesc = {Text = "Sair"},
  TipsType_SubBestExperienceTips_Chapter5_RightBtnDesc = {
    Text = "Ainda investigar"
  },
  TipsType_SubBestExperienceTips_Chapter5_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_SubBestExperienceTips_ChapterS2_Desc = {
    Text = "Para garantir a melhor experiência da trama, recomenda-se completar as seguintes fases de investigação."
  },
  TipsType_SubBestExperienceTips_ChapterS2_LeftBtnDesc = {Text = "Sair"},
  TipsType_SubBestExperienceTips_ChapterS2_RightBtnDesc = {
    Text = "Ainda investigar"
  },
  TipsType_SubBestExperienceTips_ChapterS2_Title = {
    Text = "Confirmação de Investigação"
  },
  TipsType_SummonFailureTips_Desc = {
    Text = "Os custos de material de Despertar foram alterados, tente Despertar novamente"
  },
  TipsType_SummonPriorityNotEnoughTips_Desc = {
    Text = "Faltam {s1} <Blue:\"{s2}\">. Consumir <Blue:{s4} × {s3} > em vez disso?"
  },
  TipsType_SummonPriorityNotEnoughTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_SummonPriorityNotEnoughTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_SummonPriorityNotEnoughTips_Title = {
    Text = "Confirmação de \"Salvar o mundo\""
  },
  TipsType_SummonType_14SelectConfirm_BottomDesc = {
    Text = "<Blue:Aviso: Uma vez selecionado, não será possível alterar nesta atividade!>"
  },
  TipsType_SummonType_14SelectConfirm_Desc = {
    Text = "Tem certeza de que deseja escolher o Corpo Desperto <OrangeQuality:\"{s1}\",\"{s2}\",\"{s3}\",\"{s4}\"> como UP direcionado deste evento?"
  },
  TipsType_SummonType_14SelectConfirm_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_SummonType_14SelectConfirm_RightBtnDesc = {Text = "Confirmar"},
  TipsType_SummonType_14SelectConfirm_Title = {
    Text = "Confirmar seleção"
  },
  TipsType_SummonType_14SelectLimitTips_BottomDesc = {
    Text = "<Blue:Aviso: Uma vez selecionado, não será possível alterar nesta atividade!>"
  },
  TipsType_SummonType_14SelectLimitTips_Desc = {
    Text = "Limite de quantidade alcançado"
  },
  TipsType_SummonType_17IncompleteSelectionTips_Desc = {
    Text = "Por favor, complete todas as seleções antes de tentar novamente"
  },
  TipsType_SummonType_17SelectConfirm_Desc = {
    Text = "Confirmar a conclusão da seleção do Corpo Desperto designado?\nApós a confirmação, a seleção deste período não poderá ser alterada novamente."
  },
  TipsType_SummonType_17SelectConfirm_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_SummonType_17SelectConfirm_RightBtnDesc = {Text = "Confirmar"},
  TipsType_SummonType_17SelectConfirm_Title = {
    Text = "Confirmar seleção"
  },
  TipsType_SupportListLatestTips_Desc = {
    Text = "Já está no estado mais recente. Vá seguir mais colegas para obter mais opções de Apoio de batalha!"
  },
  TipsType_TrinketAutoRefineExitTips_Desc = {
    Text = "Transcrição Automática em andamento, operação indisponível."
  },
  TipsType_TrinketAutoRefineTips_BottomDesc = {
    Text = "(A Transcrição Automática para quando um atributo desbloqueado atingir 8.)"
  },
  TipsType_TrinketAutoRefineTips_Desc = {
    Text = "Transcrever até {s1} vezes\nConsumir até"
  },
  TipsType_TrinketAutoRefineTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_TrinketAutoRefineTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_TrinketAutoRefineTips_Title = {
    Text = "Confirmação de Transcrição Automática"
  },
  TipsType_TrinketBagFullTips_Desc = {
    Text = "A mochila de Mystiks está cheia"
  },
  TipsType_TrinketBatchUnbindTips_Desc = {
    Text = "Desvincular todos os Mystiks?"
  },
  TipsType_TrinketBatchUnbindTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_TrinketBatchUnbindTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_TrinketBatchUnbindTips_Title = {
    Text = "Confirmação de Desvincular"
  },
  TipsType_TrinketBindSaveTips_Desc = {
    Text = "Existem Mystiks atados, não é possível salvar como plano!"
  },
  TipsType_TrinketBindTips_Desc = {
    Text = "Confirmar a combinação dos seguintes Mystik? Os Mystik equipados por outros Corpos Despertos ou presentes em equipes/esquemas/suporte serão automaticamente removidos."
  },
  TipsType_TrinketBindTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_TrinketBindTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_TrinketBindTips_Title = {
    Text = "Confirmação de Modificação de Atar"
  },
  TipsType_TrinketChangeBindTips_Desc = {
    Text = "Confirmar modificação do Atar?"
  },
  TipsType_TrinketChangeBindTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_TrinketChangeBindTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_TrinketChangeBindTips_Title = {
    Text = "Modificar Confirmação de Atar"
  },
  TipsType_TrinketHighLevelBatchUnbindTips_Desc = {
    Text = "Desvincular todos os conjuntos de Mystik?\n\n<color=#9BA3A2><size=30>+12 peças de Mystik serão consumidas.</size></color>"
  },
  TipsType_TrinketHighLevelBatchUnbindTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_TrinketHighLevelBatchUnbindTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_TrinketHighLevelBatchUnbindTips_Title = {
    Text = "Confirmação de Desvincular"
  },
  TipsType_TrinketHighLevelChangeBindTips_Desc = {
    Text = "Confirmar alteração?\n\n<color=#9BA3A2><size=30>+12 peças de Mystik serão consumidas.</size></color>"
  },
  TipsType_TrinketHighLevelChangeBindTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_TrinketHighLevelChangeBindTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_TrinketHighLevelChangeBindTips_Title = {
    Text = "Modificar Confirmação de Atar"
  },
  TipsType_TrinketHighLevelUnbindTips_Desc = {
    Text = "Desvincular este conjunto de Mystik?\n\n<color=#9BA3A2><size=30>+12 peças de Mystik serão consumidas.</size></color>"
  },
  TipsType_TrinketHighLevelUnbindTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_TrinketHighLevelUnbindTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_TrinketHighLevelUnbindTips_Title = {
    Text = "Confirmação de Desvincular"
  },
  TipsType_TrinketUnbindTips_Desc = {
    Text = "Confirmar desvinculação deste Mystik?"
  },
  TipsType_TrinketUnbindTips_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_TrinketUnbindTips_RightBtnDesc = {Text = "Confirmar"},
  TipsType_TrinketUnbindTips_Title = {
    Text = "Confirmação de Desvincular"
  },
  TipsType_TryAgainLaterTips_Desc = {
    Text = "O <color=#5EF2FF>valor de fase</color> está atualmente em uso, por favor tente novamente mais tarde"
  },
  TipsType_WaitOppositeSideAccept_Desc = {
    Text = [[
Aguardando
{s1}
 aceitar o convite de <Blue:{s2}>]]
  },
  TipsType_WaitOppositeSideAccept_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_WaitOppositeSideAccept_Title = {
    Text = "Combate de senha"
  },
  TipsType_WaitOthersEnter_Desc = {
    Text = "Esperando outros Guardiões para inserir\n<Blue:{s1}>\nsenha de combate correspondente"
  },
  TipsType_WaitOthersEnter_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_WaitOthersEnter_RightBtnDesc = {
    Text = "Copie <color=#5EF2FF>valor da fase</color>"
  },
  TipsType_WaitOthersEnter_Title = {
    Text = "Combate de senha"
  },
  TipsType_WeaponRandomChestConfirm_Desc = {
    Text = "Confirmar o uso de <Blue:{s1}> para obter 1 Roda do destino <Blue:aleatória>?"
  },
  TipsType_WeaponRandomChestConfirm_LeftBtnDesc = {Text = "Cancelar"},
  TipsType_WeaponRandomChestConfirm_RightBtnDesc = {Text = "Confirmar"},
  TipsType_WeaponRandomChestConfirm_Title = {
    Text = "Confirmação de Uso"
  },
  TipsType_WeekChallengeSweepTips_Desc = {
    Text = "Recompensas semanais esgotadas, não é possível realizar a reprodução."
  }
})
return Text_TipsType
