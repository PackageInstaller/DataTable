__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Activity = readonly({
  Activity_100432_ActivityName = {
    Text = "Shaggai hipnótico"
  },
  Activity_100432_ActivityTips = {
    Text = "<Title:Regras do evento>\n· Durante o evento \"Hypno-Inseto\", o Guardião pode usar equipes predefinidas do sistema que incluem Clementine para experimentar as fases designadas sem limites. \n· Ao experimentar as fases do evento, não é possível ajustar os Corpos Despertos na formação. \n<Title:Recompensas do evento>\n· Após completar o desafio da fase pela primeira vez, você pode receber recompensas de teste na interface do evento."
  },
  Activity_100433_ActivityName = {
    Text = "Bishop de bálsamos"
  },
  Activity_100433_ActivityTips = {
    Text = "<Title:Regras da Atividade>\n·Durante o evento \"Bispo Benevolente\", os Guardiães podem usar equipes pré-definidas pelo sistema contendo Salvador para experimentar níveis designados um número ilimitado de vezes.\n·Ao jogar os níveis do evento, ajustes no Despertar do alinhamento da equipe não podem ser feitos.\n<Title:Recompensas da Atividade>\n·Após completar com sucesso um desafio de nível pela primeira vez, você pode reivindicar recompensas de teste na interface do evento."
  },
  Activity_116469_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_116470_ActivityName = {
    Text = "Noite Eterna do Dia"
  },
  Activity_116470_ActivityPlot = {
    Text = "Eles se cruzaram no fim do destino, o relógio que foi reconfigurado já estava atrasado há muito tempo, apenas aquele coração arrependido prometeu iluminar toda a impureza na escuridão."
  },
  Activity_116470_ActivityStageEndContent = {
    Text = "Evento encerrado, apenas disponível para \"Cerimônia de Bênção\""
  },
  Activity_116470_ActivityTips = {
    Text = "<Title:Introdução ao evento>\n1. Durante o evento, os Guardiões do Segredo podem coletar a moeda do evento \"Visita de tributo\", \"Confissão de oferendas\" e \"Lealdade e tributo\" através das jogabilidades limitadas \"Sangue amargo fundido\" e \"Recompensa de conquista\". As moedas \"Visita de tributo\", \"Confissão de oferendas\" e \"Lealdade e tributo\" podem ser usadas para comprar produtos na \"Cerimônia de Bênção\", incluindo a roda do destino SR limitada do evento \"Imagem do Filho Santo\", Núcleo de Lumen, Núcleo Imaculado, entre outros. \n2. Durante o evento, \"Visão de Sonhos Estranhos: Além do horizonte·baixo\" será desbloqueado gratuitamente por tempo limitado, e completar as conquistas do evento também garantirá o avatar limitado do evento \"Por nome da Chave de prata: Pollux\"!\n\n<Title:Tempo do evento>\n1. De 20 de outubro às 9:00 até 3 de novembro às 9:00 (GMT+8), todas as jogabilidades do evento estão disponíveis. \n2. De 3 de novembro às 9:00 até 10 de novembro às 9:00 (GMT+8), apenas a \"Cerimônia de Bênção\" e as recompensas de conquista estarão disponíveis. \n\n<Title:Sangue amargo fundido>\n1. \"Sangue amargo fundido\" contém 7 fases, sendo que uma fase será desbloqueada automaticamente a cada dia. \n2. Cada desafio consumirá 120 pontos de Menophin, e o sucesso no desafio resultará na obtenção de moeda do evento. \n3. Após concluir a fase, a função \"Reproduzir\" dessa fase será desbloqueada. Atenção: ao usar a função \"Reproduzir\", a taxa de sincronização não será obtida. \n4. É possível utilizar a ajuda da associação de ex-alunos para facilitar a conclusão das fases. \n\n<Title: Vórtice das Memórias>\n Após o início do evento, você receberá automaticamente 60 \"Visita de tributo\" a cada hora, com um armazenamento máximo de 25 horas. \n\n<Title:Cerimônia de Bênção>\n1. A \"Cerimônia de Bênção\" possui três lojas, com os seguintes horários de abertura:\n\"Lavar o corpo\": abre às 9:00 do dia 20 de outubro.\n\"Confissão da alma\": abre às 9:00 do dia 21 de outubro.\n\"Precipite os pecados\": abre às 9:00 do dia 22 de outubro. \n2. Cada troca consumirá 750 \"Visita de tributo\"/\"Confissão de oferendas\"/\"Lealdade e tributo\", e você receberá aleatoriamente cinco itens como recompensa da loja. \n3. As recompensas de itens de cada loja são divididas em \"Item Especial\" e \"Item comum\". Ao redefinir, é possível restaurar a quantidade restante dos itens especiais ao limite máximo, com as seguintes regras específicas: \n(1) Para as duas primeiras redefinições: quando não houver mais quantidade restante de \"Item Especial\", o Guardião pode optar por redefinir, o que restaurará as quantidades restantes de \"Item Especial\" e \"Item comum\" ao limite máximo; também pode optar por continuar trocando. Quando não houver mais quantidade restante de \"Item comum\", será necessário redefinir para continuar trocando. \n(2) A partir da terceira redefinição: quando não houver mais quantidade restante de \"Item comum\", a redefinição pode ser realizada, que restaurará a quantidade restante de \"Item comum\" ao limite máximo, mas \"Item Especial\" não será mais redefinido. \n\n<Title:Aumento do evento>\n1. Os Guardiões do Segredo que possuírem um Corpo Desperto específico ou Roda do Destino (não é necessário estar em uso) poderão obter um aumento adicional na quantidade de \"Visita de tributo\", \"Confissão de oferendas\" e \"Lealdade e tributo\" nas recompensas das missões do evento \"Sangue amargo fundido\". Os aumentos específicos são os seguintes:\nCorpo Desperto \"Pollux\": Despertar Espiritual 0/1/2/3 ou mais, aumento de 20%/30%/40%/50%.\nRoda do Destino SSR \"Pólux\": Nível de empilhamento 0/1/2/3 ou mais, aumento de 20%/30%/40%/50%.\nRoda do Destino SR \"Imagem do Filho Santo\": Nível de empilhamento 0/1/2/3 ou mais, aumento de 20%/30%/40%/50%. \n2. Os \"Aumentos do evento\" de diferentes Corpos Despertos ou Rodas do Destino são calculados de forma acumulativa. \n3. Especialmente, a recompensa do primeiro desafio na dificuldade de loucura não será afetada pelos \"Aumentos do evento\". \n\n<Title:Visão de Sonhos Estranhos>\n1. Durante o evento, \"Visão de Sonhos Estranhos: Além do horizonte·baixo\" pode ser desbloqueado gratuitamente. \n2. Após o término do evento, o progresso da investigação de \"Visão de Sonhos Estranhos: Além do horizonte·baixo\" será mantido. Completar os eventos de investigação não concluídos durante o evento ainda permitirá que você obtenha recompensas de investigação consistentes com as do período do evento. Se \"Visão de Sonhos Estranhos: Além do horizonte·baixo\" não for desbloqueado durante o evento, ainda será possível desbloqueá-lo após o término do evento consumindo \"Ponto de partida real\"*7. \n3. Independentemente de estar ou não durante o período do evento, após concluir \"Visão de Sonhos Estranhos: Além do horizonte·baixo\", você poderá obter \"Ordem de chave: Coração Santo de Choro\"."
  },
  Activity_116470_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_116765_ActivityName = {
    Text = "Partida gravada"
  },
  Activity_116765_ActivityTips = {
    Text = "Regras do evento:\n1. Após os Guardiões do Segredo completarem as tarefas designadas da jornada, podem coletar recompensas em \"Partida Marcada\".\n2. Após desbloquear o \"Arquivo Avançado\", é possível receber recompensas adicionais ao completar as tarefas.\n3. A compra do \"Arquivo Avançado\" desta vez tem um prazo limitado; após o vencimento, não será mais possível comprá-lo. Por favor, os Guardiões do Segredo considerem a compra até 3 de novembro às 9h.\n4. Atenção: o \"Arquivo Avançado\" desbloqueado nesta atividade só será válido enquanto a atividade estiver em vigor. Os Guardiões do Segredo devem consumir de forma racional."
  },
  Activity_116765_BannerText = {
    Text = "Jornada Especial da Atividade por Tempo Limitado!"
  },
  Activity_116818_ActivityName = {
    Text = "Rebatalha Primal"
  },
  Activity_116818_ActivityPlot = {
    Text = "\"As estrelas\" são os olhos Dele, substituindo Seu olhar, ou melhor, vigiando tudo no mundo. \n Você acha que escapou de Sua visão, mas a verdade é — você ainda está no sonho Dele. \n \"Peguei você —\" \n No momento em que você é capturado, as estrelas soltam um suspiro de satisfação."
  },
  Activity_116818_ActivityStageEndContent = {
    Text = "Evento encerrado"
  },
  Activity_116818_ActivityTips = {
    Text = "<Title: Repetir o Primordial>\n· \"Repetir o Primordial\" inclui 7 estágios não repetíveis que desafiam diretamente a Visão Primordial, com um estágio abrindo nos primeiros dois dias do evento, três estágios abrindo no terceiro dia e um estágio abrindo a cada dia nos dois dias seguintes. \n· Cada vez que você derrota a correspondente Visão Primordial Astral em um desafio, você receberá as recompensas correspondentes. \n· Cada tipo de Visão Primordial Astral tem numerosos clones; sempre que qualquer Guardião desafiar com sucesso um tipo específico, a \"Quantidade Restante\" desse tipo diminui em 1. Uma vez que todos os clones desse tipo sejam eliminados, o estágio correspondente será fechado e não poderá ser desafiado novamente. \n· Cada estágio oferecerá diferentes relíquias que fornecerão poderosos bônus. \n· Todos os estágios devem selecionar unidades de assistência; ao longo do evento, cada Guardião que se seguir mutuamente pode apenas ajudar você uma vez. Como você está usando assistência, a recompensa real da taxa de sincronização será aumentada em 50% além da recompensa base. \n· Cada Despertador, Roda do Destino e Chave podem participar de uma batalha apenas uma vez por dia. \n· Durante o evento, o registro especial \"Coro das Estrelas\" é desbloqueado gratuitamente sem quaisquer pré-requisitos! Após o término do evento \"Repetir o Primordial\", você deve completar \"Investigação: Capítulo Astral - Capítulo 4\" para desbloquear o registro especial \"Coro das Estrelas.\" \n\n<Title: Compensação de Nível>\n· Em \"Repetir o Primordial\", há um mecanismo de compensação de nível para permitir que todos os Guardiões lutem juntos! \nAs regras de compensação de nível são as seguintes: \n  · Despertadores na equipe de investigação abaixo do nível 60 serão compensados para o nível 60 para este desafio. \n  · Despertadores na equipe de investigação com níveis de habilidade abaixo do nível 5 serão compensados para o nível 5 para este desafio. \n  · Despertadores na equipe de investigação com \"Presságio Louco\" abaixo do nível 6 serão compensados para o nível 6 para este desafio. \n  · Despertadores na equipe de investigação com \"Plasticidade Espiritual\" abaixo do nível 5 serão compensados para o nível 5 para este desafio. \n  · Se o nível de um Guardião estiver abaixo de 60, ele será compensado para o nível 60 para este desafio. \n\n<Title: Registro Especial>\n· Durante o evento, o \"Registro Especial: Coro das Estrelas\" pode ser desbloqueado gratuitamente sem quaisquer pré-requisitos! \n· Após o término do evento, o progresso da investigação para \"Registro Especial: Coro das Estrelas\" será mantido, e completar quaisquer eventos de investigação não finalizados durante o evento ainda concederá recompensas de investigação consistentes com aquelas durante o evento. Se \"Registro Especial: Coro das Estrelas\" não foi desbloqueado durante o evento, você deve completar \"Investigação: Capítulo Astral - Capítulo 4\" e consumir \"Ponto de Partida da Realidade\" ×7 para desbloquear o registro especial \"Coro das Estrelas\" após o término do evento. \n· Independentemente de estar durante o evento ou não, completar \"Registro Especial: Coro das Estrelas\" lhe concederá \"Chave: Desejo de Reunião.\""
  },
  Activity_116818_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_117836_ActivityName = {
    Text = "Senhora de vermelho"
  },
  Activity_117836_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento \"Dama Vermelha\", os Guardiões podem usar equipes presetadas pelo sistema que incluem Sorel para experimentar níveis designados infinitamente.\n·Ao experimentar os níveis do evento, ajustes nos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_117837_ActivityName = {
    Text = "Senhora das profundezas"
  },
  Activity_117837_ActivityTips = {
    Text = "<Title:Regras do Evento>\n· Durante o evento \"Senhorita Aequor\", os Guardiães podem usar equipes pré-definidas pelo sistema que incluam Murphy para experimentar níveis designados infinitamente.\n· Durante a experiência do nível do evento, ajustes aos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n· Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_117838_ActivityName = {
    Text = "Divus: a pena Ônix"
  },
  Activity_117838_ActivityTips = {
    Text = "<Title:Regras do evento>\n· Durante o evento \"Filho Santo · Pluma Negra\", os Guardiões do Segredo podem usar formações pré-definidas do sistema que incluem Castor para experimentar as fases designadas sem limite. \n· Ao experimentar as fases do evento, não é possível ajustar os Corpos Despertos na formação. \n<Title:Recompensas do evento>\n· Após completar o desafio da fase pela primeira vez, você poderá coletar recompensas de teste na interface do evento."
  },
  Activity_117839_ActivityName = {
    Text = "Chave para o portal"
  },
  Activity_117839_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento \"Key of the Door\", os Guardiões podem usar equipes predefinidas pelo sistema que incluem Tawil para experimentar níveis designados infinitamente.\n·Enquanto experimenta os níveis do evento, ajustes aos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_119662_ActivityName = {
    Text = "Florescer de Lodo"
  },
  Activity_119662_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento \"Flor do Lodo\", os Guardiões podem usar equipes presetadas pelo sistema que incluem Lily para experimentar níveis designados infinitamente.\n·Ao jogar os níveis do evento, ajustes nos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_119663_ActivityName = {
    Text = "Sopro de fertilidade"
  },
  Activity_119663_ActivityTips = {
    Text = "<Title:Regras da Atividade>\n·Durante o evento \"Sopro Abundante\", os Guardiães podem usar equipes pré-definidas pelo sistema contendo Táias para experimentar níveis designados um número ilimitado de vezes.\n·Ao jogar os níveis do evento, ajustes no Despertar do alinhamento da equipe não podem ser feitos.\n<Title:Recompensas da Atividade>\n·Após completar com sucesso um desafio de nível pela primeira vez, você pode reivindicar recompensas de teste na interface do evento."
  },
  Activity_119693_ActivityName = {
    Text = "Por nome da Chave de Prata"
  },
  Activity_119693_ActivityPlot = {
    Text = "Após concluir a missão, você pode escolher 1 Desperto entre os seguintes Despertos limitados!"
  },
  Activity_119693_ActivityTips = {
    Text = "<Title:Regras do Evento>\nDurante o evento, cada Guardião do Segredo pode escolher 1 Corpo Desperto entre 8 Corpos Despertos SSR limitados após usar 200 Ordens de Chave acumuladas.\nA lista inclui: Doll: Inferno, Clementine, Corposant, Castor, Doresain, Katie Gula, Pickman e Pollux.\nQuando o Guardião do Segredo escolhe um Corpo Desperto já possuído, cópias subsequentes (da 2ª à 16ª) se converterão em 1 Fragmento correspondente do Corpo Desperto e 50 sedimentos fundamentais.\nA partir da 17ª cópia em diante, o Corpo Desperto SSR limitado se converterá em 2 Fragmentos de núcleo espiritual essencial, 6 Fragmentos de núcleo espiritual e 250 sedimentos fundamentais."
  },
  Activity_119693_BannerText = {
    Text = "Despertador Limitado Grátis"
  },
  Activity_119694_ActivityName = {
    Text = "Orientação da Estrela da Manhã"
  },
  Activity_119694_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Os Guardiões do Segredo que completarem as missões designadas poderão coletar recompensas em \"Orientação da Estrela da Manhã\".\n·Após desbloquear o \"Arquivo Avançado\", recompensas extras poderão ser coletadas após completar as missões.\n·A compra do \"Arquivo Avançado\" tem um prazo limitado, e não poderá ser adquirida após o término. Os Guardiões do Segredo devem considerar a compra até 26 de janeiro às 9h (GMT+8).\n·Por favor, note: o \"Arquivo Avançado\" desbloqueado nesta atividade só é válido durante a duração desta atividade. Os Guardiões do Segredo devem consumir de forma racional e ponderada."
  },
  Activity_119694_BannerText = {
    Text = "Jornada Especial da Atividade por Tempo Limitado!"
  },
  Activity_119857_ActivityName = {
    Text = "Soberano adormecido"
  },
  Activity_119857_ActivityTips = {
    Text = "<Title:Event Rules>\n·Durante o evento \"Soberano do Sono\", os Guardiães podem usar equipes pré-definidas pelo sistema que incluem Tulu para experimentar níveis designados infinitamente.\n·Ao experimentar níveis do evento, ajustes aos Despertadores na formação da equipe não são permitidos.\n<Title:Event Rewards>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_120495_ActivityName = {
    Text = "Oferta Memorial de Jornada · Capítulo das EstrelasⅣ"
  },
  Activity_120495_ActivityPlot = {
    Text = "Um pedaço de memória selado e arquivado, uma jornada registrada no passado. Em momentos de lembrança, não se esqueça de oferecer sua reverente Visita."
  },
  Activity_120496_ActivityName = {
    Text = "Crônica do Ciclo"
  },
  Activity_120496_ActivityTips = {
    Text = "Regras do evento:\n1. Os Guardiões do Segredo que completarem as tarefas designadas da crônica podem coletar recompensas em \"Crônica do Ciclo\".\n2. A \"Crônica do Ciclo\" está aberta permanentemente.\n3. Após liberar o \"Arquivo Avançado\", é possível coletar recompensas extras após completar as missões.\n4. Atenção: o \"Arquivo Avançado\" desbloqueado neste evento só é válido durante este evento. Os Guardiões do Segredo devem consumir de forma consciente e racional."
  },
  Activity_120954_ActivityName = {
    Text = "Cântico das Estrelas"
  },
  Activity_122195_ActivityName = {
    Text = "Ritual da Névoa"
  },
  Activity_122195_ActivityPlot = {
    Text = "A luz da aurora dissolve a dor dos devotos, com as estrelas como um recipiente, transportando irmãos e irmãs para o reino elevado. \n O cordeiro perdido dança e canta na porta, adornado por velas estelares no eterno tribunal divino. \n No entanto, a névoa atrás da porta já respondeu ao chamado, enganando e trapaceando apenas para satisfazer seus próprios interesses distorcidos. \n Essa névoa, portanto, sela a \"aurora\", bloqueando o caminho para a libertação. \n Ela estará aqui para testemunhar mais um fim do mundo."
  },
  Activity_122195_ActivityStageEndContent = {
    Text = "O evento terminou. Atualmente, apenas \"Cabana de Mouchette\" está disponível."
  },
  Activity_122195_ActivityTips = {
    Text = "<Title:Visão geral do evento>\n1. Durante o evento, Guardiões podem coletar a moeda do evento \"Visão da Névoa\", \"Sonho da Névoa\" e \"Fonte\" da Névoa através da jogabilidade por tempo limitado \"Eu perdido\" e \"Recompensa de conquista\". \"Visão da Névoa\", \"Sonho da Névoa\" e \"Fonte\" da Névoa podem ser usados para comprar itens na \"Casa de Mouchette\", incluindo a Roda do destino SR exclusiva do evento \"Lanterna da razão\", Núcleo de Lumen, Núcleo Imaculado e mais. \n2. Durante o evento, \"Enlace Multiversal: O Batismo de Prata e Sangue\" será temporariamente desbloqueado gratuitamente. Completar conquistas do evento também recompensará você com o Avatar exclusivo do evento \"Por nome da Chave de Prata: Mouchette\"!\n\n<Title:Duração do Evento>\n1. 29 de dezembro, 9:00 – 12 de janeiro, 9:00 (GMT+8), toda a jogabilidade do evento estará acessível. \n2. 12 de janeiro, 9:00 – 19 de janeiro, 9:00 (GMT+8), apenas \"Casa de Mouchette\" e Recompensa de conquista estarão disponíveis. \n\n<Title:Eu perdido>\n1. \"Eu perdido\" consiste em 7 fases, com 1 fase desbloqueando automaticamente a cada dia. \n2. Cada desafio consumirá 120 Lingfétide, e desafios bem-sucedidos concederão moeda do evento. \n3. Após concluir uma fase, o recurso \"Recriar\" para essa fase será desbloqueado. Atenção: usar o recurso \"Recriar\" não concederá Taxa de Sincronização. \n4. Você pode usar a Assistência de Alumni para ajudá-lo a concluir fases mais facilmente. \n\n<Title:Casa de Mouchette>\nHá três lojas na \"Casa de Mouchette\", abrindo nos seguintes horários: \n \"Sala de Materiais\": Abre às 9:00 de 29 de dezembro. \n \"Sala de Sonhar\": Abre às 9:00 de 30 de dezembro. \n \"Sala de cultivo\": Abre às 9:00 de 31 de dezembro. \nVocê pode selecionar itens para compra direta nas lojas. \n\n<Title:Bônus do Evento>\n1. Guardiões que possuem Corpos Despertos ou Rodas do destino específicos (não é necessário implantá-los) podem ganhar bônus adicionais de drop para \"Visão da Névoa\", \"Sonho da Névoa\" e \"Fonte\" da Névoa nas tarefas de fase \"Eu perdido\", com bônus específicos como segue: \n Corpo Desperto \"Mouchette\": Despertar Espiritual 0/1/2/3 e acima, bônus 20%/30%/40%/50%. \n Roda do destino SSR \"Carnificina até o fim do mundo\": Posição sobreposta 0/1/2/3 e acima, bônus 20%/30%/40%/50%. \n Roda do destino SR \"Lanterna da razão\": Posição sobreposta 0/1/2/3 e acima, bônus 20%/30%/40%/50%. \n2. \"Bônus do Evento\" de diferentes Corpos Despertos ou Rodas do destino são calculados de forma cumulativa. \n3. Notavelmente, as recompensas de primeiro desafio concluído na dificuldade de loucura não serão afetadas pelos \"Bônus do Evento\". \n\n<Title:Enlace Multiversal>\n1. Durante o evento, \"Enlace Multiversal: O Batismo de Prata e Sangue\" pode ser desbloqueado gratuitamente. \n2. Após o término do evento, o progresso de investigação de \"Enlace Multiversal: O Batismo de Prata e Sangue\" será mantido. Completar eventos de investigação que não foram finalizados durante o período do evento também concederá recompensas de investigação consistentes com as do evento. Se \"Enlace Multiversal: O Batismo de Prata e Sangue\" não foi desbloqueado durante o evento, ainda pode ser desbloqueado após o evento consumindo \"Ponto de partida real\" *3. \n3. Independentemente de ter sido durante o evento, concluir \"Enlace Multiversal: O Batismo de Prata e Sangue\" concederá a \"Ordem de chave: Vindo da Névoa\"."
  },
  Activity_122195_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_122196_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_122520_ActivityName = {
    Text = "Sombra da cidade chuvosa·clon"
  },
  Activity_122520_ActivityPlot = {
    Text = "Um encontro destinado espera na chuva úmida e nebulosa. Você conhece o nome dela e o rosto dela, e a voz dela ainda o embala em uma sensação de tranquilidade. \nMas lembre-se—apenas deuses e demônios são tão desesperados para satisfazer os desejos humanos. \nAdivinhe. Qual deles ela é?"
  },
  Activity_122520_ActivityStageEndContent = {
    Text = "O evento terminou. Você agora só pode participar do \"Cofr da Bruxa\"."
  },
  Activity_122520_ActivityTips = {
    Text = "<Title:Breve introdução do evento>\n1. Durante o evento, os Guardiões do Segredo poderão coletar moeda do evento através das jogabilidades limitadas \"Loja da Bruxa\" e \"Recompensa de Conquista\". A moeda do evento pode ser trocada no \"Tesouro da Bruxa\" para obter recompensas de itens, incluindo a Roda do Destino SR exclusiva do evento \"Chapéu de Bruxa\", Pedra Filosofal, Núcleo Imaculado, Núcleo de Lumen, entre outros. \n2. Durante o evento, \"Registro da Força-Tarefa: Sombras da Cidade da Chuva\" estará disponível gratuitamente. Completar conquistas do evento também concederá o avatar exclusivo do evento \"Por nome da Chave de Prata: Daphne\"! \n\n<Title:Horário do Evento>\n1. 12 de janeiro, 9:00 - 26 de janeiro, 9:00 (GMT+8), todos os conteúdos do evento estarão disponíveis. \n2. 26 de janeiro, 9:00 - 2 de fevereiro, 9:00 (GMT+8), apenas \"Tesouro da Bruxa\" e \"Recompensa de Conquista\" estarão disponíveis, todos os outros conteúdos terão terminado e não poderão ser participados. \n\n<Title: Loja da Bruxa>\n1. A \"Loja da Bruxa\" contém 5 fases, sendo que uma nova fase será automaticamente liberada a cada 2 dias. \n2. Cada desafio consumirá 120 pontos de Lingfétide, e um desafio bem-sucedido concederá moeda do evento. \n3. Após concluir a fase, a função \"Reproduzir\" daquela fase será desbloqueada. Atenção: ao usar a função \"Reproduzir\", a taxa de sincronização não será obtida. \n4. É possível usar a ajuda do Alumni para facilitar a conclusão das fases. \n\n<Title: Bônus do Evento>\n1. Os Guardiões que possuírem corpos despertos ou Rodas do Destino específicas (não é necessário estar em campo) poderão obter um bônus adicional de drops de \"Crânio do Animal Pálido\", \"Crânio de Fera Sombria\" e \"Crânio do Animal Escarlate\" nas recompensas das missões da fase da \"Loja da Bruxa\", os bônus específicos são: \n· Corpo Desperto \"Daphne\": Despertar 0/1/2/3 ou mais, bônus de 20%/30%/40%/50% \n· Roda do Destino SSR \"Raridade Preciosa\": Posição sobreposta 0/1/2/3 ou mais, bônus de 20%/30%/40%/50% \n· Roda do Destino SR \"Chapéu de Bruxa\": Posição sobreposta 0/1/2/3 ou mais, bônus de 20%/30%/40%/50% \n2. Os \"Bônus do Evento\" de diferentes corpos despertos ou Rodas do Destino são calculados de forma acumulativa. \n3. Especialmente, a recompensa do desafio inicial de dificuldade de loucura não será afetada pelos \"Bônus do Evento\". \n\n<Title: Tesouro da Bruxa>\n1. O \"Tesouro da Bruxa\" é composto por três partes, com os horários de abertura a seguir: \n· \"Produto para aliviar preocupações\": 12 de janeiro, 9:00 - 2 de fevereiro, 9:00. \n· \"Tesouro Secreto Deslumbrante\": 14 de janeiro, 9:00 - 2 de fevereiro, 9:00. \n· \"Coleção Exclusiva\": 16 de janeiro, 9:00 - 2 de fevereiro, 9:00. \n2. Cada troca consumirá 750 \"Crânio do Animal Pálido\"/\"Crânio de Fera Sombria\"/\"Crânio do Animal Escarlate\", e recompensará aleatoriamente cinco itens do tesouro. \n3. As recompensas de itens de cada tesouro são divididas em \"Item Especial\" e \"Item Comum\". Durante a redefinição, é possível redefinir a quantidade restante de itens designados para o limite máximo, as regras específicas são: \n(1) Nas 2 primeiras redefinições: quando não houver mais quantidade restante de \"Item Especial\", o Guardião pode escolher redefinir. Após a redefinição, a quantidade restante de \"Item Especial\" e \"Item Comum\" será restaurada ao limite máximo; também pode optar por continuar trocando. Quando não houver mais quantidade restante de \"Item Comum\", é necessário redefinir para continuar as trocas. \n(2) A partir da 3ª redefinição: somente quando não houver mais quantidade restante de \"Item Comum\" é que a redefinição poderá ser feita, a redefinição restaurará a quantidade restante de \"Item Comum\" ao limite máximo, \"Item Especial\" não será mais redefinido. \n\n<Title: Registro da Força-Tarefa>\n1. Durante o evento, \"Registro da Força-Tarefa: Sombras da Cidade da Chuva\" estará disponível gratuitamente. \n2. Após o término do evento, o progresso da investigação de \"Registro da Força-Tarefa: Sombras da Cidade da Chuva\" será mantido. Se não desbloquear durante o evento, ainda poderá ser desbloqueado após o término do evento consumindo \"Ponto de partida real\"*7. \n3. Independentemente de estar ou não durante o evento, ao concluir \"Registro da Força-Tarefa: Sombras da Cidade da Chuva\", será possível obter \"Ordem de chave: Verdadeira aparência da Névoa Cinza\"."
  },
  Activity_122520_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_122521_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_122803_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_122803_ActivityPlot = {
    Text = "Após a compra, \"Mouchette\" pode ativar\n<BlueQuality: desenvolvimento da personalidade +4, desbloquear explosão superalimentada>"
  },
  Activity_122804_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_122804_ActivityPlot = {
    Text = "Após a compra, \"Mouchette\" pode ativar <BlueQuality:Despertar Espiritual 3>"
  },
  Activity_122827_ActivityName = {
    Text = "A Graça da Reprodução"
  },
  Activity_122827_ActivityTips = {
    Text = "<Title:Introdução>\n·Durante o evento, os Guardiões do Segredo podem coletar recompensas correspondentes em \"A Graça da Reprodução\" após completar os objetivos designados."
  },
  Activity_122827_BannerText = {
    Text = "Receba gratuitamente a Roupa Fantasma!"
  },
  Activity_123150_ActivityName = {
    Text = "Caçadora de crânios"
  },
  Activity_123150_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento \"Caçadora de Cranios\", os Guardiões podem usar equipes presetadas pelo sistema que incluem Narciso para experimentar níveis designados infinitamente.\n·Ao experimentar os níveis do evento, ajustes nos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_123151_ActivityName = {
    Text = "Senhor de necrovia"
  },
  Activity_123151_ActivityTips = {
    Text = "<Title:Regras do Evento>\n· Durante o evento \"Senhor dos Ossos Enterrados\", os Guardiões do segredo podem usar equipes pré-definidas do sistema que incluem Doresain para experimentar níveis designados sem limite. \n· Durante a experiência nos níveis do evento, não é possível ajustar os Corpos Despertos na formação. \n<Title:Recompensas do Evento>\n· Após completar o desafio do nível pela primeira vez, é possível coletar recompensas de teste na interface do evento."
  },
  Activity_123152_ActivityName = {
    Text = "Apóstolo do mar"
  },
  Activity_123152_ActivityTips = {
    Text = "<Title:Regras do Evento>\n· Durante o evento \"Apostolo do Mar\", os Guardiães podem usar equipes pré-definidas pelo sistema que incluam Miryam para experimentar níveis designados infinitamente.\n· Ao experimentar os níveis do evento, ajustes aos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n· Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_123322_ActivityName = {
    Text = "Jornada de Geada Prateada"
  },
  Activity_123322_ActivityTips = {
    Text = "<Title:Regras do evento>\n1. Após completar as missões designadas, os Guardiões do Segredo podem coletar recompensas na \"Jornada de Geada Prateada\".\n2. A \"Jornada de Geada Prateada\" terminará em 12 de janeiro às 9h (GMT+8).\n3. Após desbloquear o \"Arquivo Avançado\", você poderá receber recompensas extras ao completar as missões.\n4. Atenção: o \"Arquivo Avançado\" desbloqueado nesta atividade é válido apenas durante esta atividade. Por favor, guarde o seu consumo de forma sensata."
  },
  Activity_123322_BannerText = {
    Text = "Jornada Especial da Atividade por Tempo Limitado!"
  },
  Activity_123323_ActivityName = {
    Text = "Dança da Cabra Dourada"
  },
  Activity_123323_ActivityTips = {
    Text = "<Title:Regras do Evento>\n1. Os Guardiões podem reivindicar recompensas em \"Dança da Cabra Dourada\" após completar as tarefas designadas do arquivo.\n2. \"Dança da Cabra Dourada\" terminará em 26 de janeiro às 9:00 (GMT+8).\n3. Após desbloquear os \"Arquivos Premium\", recompensas extras podem ser reivindicadas após completar as tarefas.\n4. Por favor, note: Os \"Arquivos Premium\" desbloqueados neste evento são válidos apenas durante este evento. Os Guardiões devem gastar de forma sábia e racional."
  },
  Activity_123323_BannerText = {
    Text = "Jornada Especial da Atividade por Tempo Limitado!"
  },
  Activity_124049_ActivityName = {
    Text = "Cérebro corrompido"
  },
  Activity_124049_ActivityTips = {
    Text = "<Title:Regras do evento>\n· Durante o evento \"Cérebro Corrompido\", os Guardiões do Segredo podem usar equipes predefinidas do sistema que incluem \"Fusão · Dor\" para experimentar infinitas vezes as fases designadas.\n· Durante a experiência das fases do evento, não é possível ajustar o Corpo Desperto na formação.\n<Title:Recompensas do evento>\n· Após completar o desafio da fase pela primeira vez, é possível receber recompensas de teste na interface do evento."
  },
  Activity_124050_ActivityName = {
    Text = "Apóstolo do mar"
  },
  Activity_124050_ActivityTips = {
    Text = "<Title:Regras do Evento>\n· Durante o evento \"Apostolo do Mar\", os Guardiães podem usar equipes pré-definidas pelo sistema que incluam Miryam para experimentar níveis designados infinitamente.\n· Ao experimentar os níveis do evento, ajustes aos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n· Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_124051_ActivityName = {
    Text = "Sacrifício do Abismo: Repetição"
  },
  Activity_124051_ActivityPlot = {
    Text = "No reflexo do mar profundo, o sonho do rei se dissipa, o reino dos deuses apodrece.\nEla vem dos sonhos antigos, entra nas ruínas do futuro.\nEla pergunta ao abismo, o abismo permanece em silêncio.\nEla oferece ao abismo, e a resposta é ela mesma"
  },
  Activity_124051_ActivityStageEndContent = {
    Text = "Evento encerrado, apenas disponível para \"Resposta do Abismo\""
  },
  Activity_124051_ActivityTips = {
    Text = "<Title:Introdução ao Evento>\n1,Durante o evento, os guardiões podem coletar moeda do evento através das mecânicas limitadas \"Nascimento do Reino Divino\", \"O Decreto do Rei\" e \"Recompensas de Conquista\". A moeda do evento pode ser usada em \"Resposta do Abismo\" para fazer ofertas e obter recompensas de itens, incluindo a roda do destino SR exclusiva do evento \"O Chamado do Mar Profundo\", Pedra Filosofal, Núcleo Imaculado, Núcleo de Lumen, entre outros. \n2,Durante o evento, \"Visão de Sonhos Estranhos: Profanação\" estará disponível gratuitamente, e ao completar as conquistas do evento, os guardiões também receberão o avatar exclusivo do evento \"Por nome da Chave de Prata: Miryam\"!\n\n<Title: Tempo do Evento>\n1,De 9 de março às 9:00 até 23 de março às 9:00 (GMT+8), todos os conteúdos do evento estarão disponíveis. \n2,De 23 de março às 9:00 até 30 de março às 9:00 (GMT+8), apenas \"Resposta do Abismo\" e \"Recompensas de Conquista\" estarão disponíveis, todos os outros conteúdos terão terminado e não poderão ser participados. \n\n<Title: Nascimento do Reino Divino>\n1,\"Nascimento do Reino Divino\" contém 5 fases, sendo que uma nova fase será automaticamente aberta a cada 2 dias. \n2,Cada desafio consumirá \"Lingfétide\" × 120, e o sucesso no desafio resultará em moeda do evento. \n3,Após concluir a fase, a função \"Reproduzir\" dessa fase será desbloqueada. Atenção: ao usar a função \"Reproduzir\", não será possível obter a taxa de sincronização. \n4,Você pode usar o auxílio da Associação de Antigos e \"Ressonância: Ritual do Abismo\" para facilitar sua conclusão. \n\n<Title: Bonificação de Sacrifício>\n1,Os guardiões que possuírem um corpo despertado ou roda do destino específicos (sem necessidade de estar em campo) poderão fazer com que as recompensas das missões da fase \"Nascimento do Reino Divino\" envolvendo \"Lágrimas do Sacerdote\", \"Sangue do adorador\" e \"Medula do Sacrificador\" recebam um bônus de queda adicional (incluindo a reprodução), conforme detalhado abaixo: \n· Corpo Despertado \"Miryam\": Despertar 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%\n· Roda do Destino SSR \"Poder do piedoso\": Sincronização 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%\n· Roda do Destino SR \"O Chamado do Mar Profundo\": Sincronização 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%\n2,A \"Bonificação de Sacrifício\" de diferentes corpos despertados ou rodas do destino será calculada de forma acumulativa. \n3,Notavelmente, as recompensas do desafio de dificuldade de loucura não serão afetadas pela \"Bonificação de Sacrifício\".\n\n<Title:Ressonância: Ritual do Abismo>\n1,Os guardiões podem obter \"Coração de piedade\" ao completar as conquistas do evento. \n2,Consumindo \"Coração de piedade\", ao ativar \"Ressonância: Ritual do Abismo\", você pode obter os seguintes bônus: \n(1) Fortalecer os guardiões na mecânica do evento \"Nascimento do Reino Divino\", tornando os desafios mais fáceis. \n(2) Aumentar a moeda do evento obtida após completar os desafios do \"Nascimento do Reino Divino\". \n(3) Ativar a mecânica do evento \"O Decreto do Rei\". \n\n<Title: O Decreto do Rei>\n· Após ativar a ressonância \"Prova de Sacrifício\", você receberá automaticamente 60 \"Lágrimas do Sacerdote\" por hora, podendo acumular até 25 horas. \n\n<Title: Resposta do Abismo>\n1,\"Resposta do Abismo\" possui três altares, com os seguintes horários de abertura: \n· \"Altar de Lágrimas Brilhantes\": de 9 de março às 9:00 até 30 de março às 9:00. \n· \"Altar de Sangue de Gorila\": de 11 de março às 9:00 até 30 de março às 9:00. \n· \"Altar de Medula Espiritual\": de 13 de março às 9:00 até 30 de março às 9:00. \n2,Cada oferta de sacrifício consumirá \"Lágrimas do Sacerdote\"/\"Sangue do adorador\"/\"Medula do Sacrificador\" × 750, e você receberá aleatoriamente cinco recompensas do altar. \n3,As recompensas de cada altar são divididas em \"itens especiais\" e \"itens comuns\", e ao redefinir, você pode restaurar a quantidade restante de itens específicos ao seu limite, conforme as seguintes regras: \n(1) Nas 3 primeiras redefinições: Quando não houver mais quantidade restante de \"itens especiais\", o guardião pode escolher redefinir, e após a redefinição, a quantidade restante de \"itens especiais\" e \"itens comuns\" será restaurada ao limite; ou pode optar por continuar fazendo ofertas, e quando não houver mais quantidade restante de \"itens comuns\", será necessário redefinir para continuar fazendo ofertas. \n(2) A partir da 4ª redefinição: Quando não houver mais quantidade restante de \"itens comuns\", você poderá redefinir, e a redefinição restaurará a quantidade restante de \"itens comuns\" ao limite, e \"itens especiais\" não serão mais redefinidos. \n\n<Title: Visão de Sonhos Estranhos>\n1,Durante o evento, \"Visão de Sonhos Estranhos: Profanação\" estará disponível gratuitamente. \n2,Após o término do evento, o progresso da investigação de \"Visão de Sonhos Estranhos: Profanação\" será mantido. Se a \"Visão de Sonhos Estranhos: Profanação\" não for desbloqueada durante o evento, ainda será possível desbloqueá-la após o término do evento consumindo \"Ponto de partida real\" × 7. \n3,Independentemente de estar ou não durante o evento, ao concluir \"Visão de Sonhos Estranhos: Profanação\", você pode obter \"Ordem de chave: Festa do Mar\". \n\n<Title: Compensação de Repetição>\n1,Os guardiões que já desbloquearam \"Visão de Sonhos Estranhos: Profanação\" receberão uma compensação de \"Lágrimas do Sacerdote\" × 700 durante o período do evento de repetição ao serem desbloqueados novamente. \n2,Os guardiões que já obtiveram o avatar exclusivo do evento \"Por nome da Chave de Prata: Miryam\" ao serem obtidos novamente serão automaticamente convertidos em \"Convite do Incorpóreo\" × 1. \n3,Os guardiões que já obtiveram o material de ativação de ressonância \"Coração de piedade\", a cada \"Coração de piedade\" adicional obtido será automaticamente convertido em \"Cupom de ouro rosa\" × 5000. \n"
  },
  Activity_124051_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_124052_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_124053_ActivityName = {
    Text = "Rainha dos Espinhos"
  },
  Activity_124053_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento \"Rainha dos Espinhos\", os Guardiões podem usar equipes presetadas pelo sistema que incluem Wanda para experimentar níveis designados infinitamente.\n·Ao experimentar os níveis do evento, ajustes nos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_124800_ActivityName = {
    Text = "Turno inverso"
  },
  Activity_124801_ActivityName = {
    Text = "Inversão de fase"
  },
  Activity_124801_ActivityPlot = {
    Text = "\"Vou fazer com que todas as pessoas joguem Carta do Curso do Mundo!\"\nUm visitante de outras dimensões entrou acidentalmente no espaço de duelos da Traphase e o transformou em algo completamente diferente do original.\nPara reverter novamente o espaço, guardiões de diferentes dimensões decidirão quem é o mais forte e lançarão um desafio a esse visitante."
  },
  Activity_124801_ActivityTips = {
    Text = "<Title:Breve introdução do evento>\n1. Durante o evento, os Guardiões do Segredo podem participar da \"Fase de Duelo\" para completar conquistas nas \"Recompensas de Conquista\" e receber \"Avelãs Mágicas\".\n2. As \"Avelãs Mágicas\" podem ser trocadas por recompensas ricas no \"Prêmio de Turno\", incluindo o ícone de perfil limitado do evento \"Turno Inverso: Carta do Mundo\", 10 expressões limitadas do evento, assim como \"Sonho Fragmentado\", \"Sonhos Residuais das Estrelas\" e outros.\n3. Durante o evento, \"Conexão Multidimensional: Turno Inverso\" será aberto gratuitamente!\n4. Durante o evento, os Guardiões do Segredo que completarem \"Conexão Multidimensional: Turno Inverso: Convidado de Outro Mundo\" verão o fundo da batalha da \"Fase de Duelo\" temporariamente trocado por \"Turno Inverso: Espaço de Consciência\".\n\n<Title: Recompensa de Conquista>\n1. As \"Recompensas de Conquista\" incluem \"Prova Arcana\", \"Prova de Honra\" e \"Prova de Limiar\". Os Guardiões do Segredo podem completar objetivos de conquista para receber \"Avelãs Mágicas\".\n2. Nas conquistas da \"Prova Arcana\", a cada 3 Corpos Despertos inimigos derrotados, você recebe 10 \"Avelãs Mágicas\", até 50 vezes. A cada 6 Fúrias Explosivas desencadeadas, você recebe 10 \"Avelãs Mágicas\", até 50 vezes. A cada 20 Cartas jogadas, você recebe 10 \"Avelãs Mágicas\", até 50 vezes.\n3. Os Corpos Despertos, Rodas do Destino e Ordens de Chave desbloqueados temporariamente via Tema principal contarão normalmente para contagem de vitórias e contagem de cartas.\n\n<Title: Prêmio de Turno>\n1. Os Guardiões do Segredo podem acumular \"Avelãs Mágicas\" para receber recompensas correspondentes. Acumulando 3.600 \"Avelãs Mágicas\", você poderá obter todas as recompensas principais, e acumulando 6.000 \"Avelãs Mágicas\", você poderá obter todas as recompensas!\n2. Após completar \"Turno Inverso: Convidado de Outro Mundo\", as recompensas para acumular 100–900 \"Avelãs Mágicas\" serão desbloqueadas. Após completar \"Turno Inverso: O Momento de Reversão de Tudo\", as recompensas para acumular 1.000–6.000 \"Avelãs Mágicas\" serão desbloqueadas.\n\n<Title: Conexão Multidimensional>\n1. Durante o evento, \"Conexão Multidimensional: Turno Inverso\" será gratuito.\n2. Após o término do evento, o progresso da pesquisa de \"Conexão Multidimensional: Turno Inverso\" será mantido. Se não foi desbloqueado durante o evento, ainda será possível gastar \"Ponto de Partida Real\" *3 para desbloquear após o término do evento.\n3. Independentemente do período do evento, ao completar \"Conexão Multidimensional: Turno Inverso\", você receberá \"Ordem de Chave: A Porta da Taverna\".\n\n<Title:Tempo do Evento>\nEste evento estará aberto apenas de 16 de março às 9:00 até 30 de março às 9:00 (GMT+8). Após 30 de março às 9:00 (GMT+8), o evento será encerrado. Por favor, Guardiões do Segredo, lembrem-se de coletar as recompensas no \"Prêmio de Turno\"!"
  },
  Activity_124801_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_124801_UnlockConditionExplanation = {
    Text = "Desbloqueado após completar \"Operação de Investigação\" 3-2 · Normal"
  },
  Activity_124834_ActivityName = {
    Text = "Em Nome da Névoa"
  },
  Activity_124834_ActivityPlot = {
    Text = "Morimens × Sequência de Névoa\nConvite Especial de Colaboração\n\"Meu nome é Mouchette, investigadora de... Ah, certo, eu não sou mais a vanguarda da A.U.G.E. Deixe-me me reintroduzir—sou Mouchette, apenas uma menina doce e fofa.\""
  },
  Activity_124834_ActivityTips = {
    Text = "<Title:Regras do Evento>\nConclua o Capítulo Esquecido Cap. 1 \"Segredos do Leste\" durante o evento \"Em Nome da Névoa\" para reivindicar o novo Corpo Desperto SSR Limitado \"Mouchette\" gratuitamente!\nDa 2ª à 16ª vez obtendo o mesmo Corpo Desperto SSR, cada um será convertido em 1 Fragmento de Corpo Desperto correspondente e 50 sedimentos fundamentais; a partir da 17ª vez em diante, o Corpo Desperto SSR limitado será convertido em 2 Fragmentos de núcleo espiritual essenciais, 6 Fragmentos de núcleo espiritual e 250 sedimentos fundamentais."
  },
  Activity_124834_BannerText = {
    Text = "Despertador Limitado Grátis"
  },
  Activity_124981_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_124982_ActivityName = {
    Text = "Paciente dissociativo: caos"
  },
  Activity_124982_ActivityTips = {
    Text = "<Title:Regras da Atividade>\n·Durante o evento \"Paciente Fragmentado: Caos\", os Guardiães podem usar equipes pré-definidas pelo sistema contendo \"24\" para experimentar níveis designados um número ilimitado de vezes.\n·Ao jogar os níveis do evento, ajustes no Despertar do alinhamento da equipe não podem ser feitos.\n<Title:Recompensas da Atividade>\n·Após completar com sucesso um desafio de nível pela primeira vez, você pode reivindicar recompensas de teste na interface do evento."
  },
  Activity_124983_ActivityName = {
    Text = "Paciente dissociativo: caro"
  },
  Activity_124983_ActivityTips = {
    Text = "<Title:Event Rules>\n·Durante o evento \"Paciente Dividido: Caro\", os Guardiães podem usar equipes pré-definidas pelo sistema que incluem \"24\" para experimentar níveis designados infinitamente.\n·Ao experimentar níveis do evento, ajustes aos Despertadores na formação da equipe não são permitidos.\n<Title:Event Rewards>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_124984_ActivityName = {
    Text = "Poema Sem Nome"
  },
  Activity_124984_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento \"Poema Sem Nome\", os Guardiões podem usar equipes presetadas pelo sistema que incluem Horla para experimentar níveis designados infinitamente.\n·Enquanto experimenta os níveis do evento, ajustes nos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_124985_ActivityName = {
    Text = "Paciente dissociativo: aequor"
  },
  Activity_124985_ActivityTips = {
    Text = "<Title:Regras da Atividade>\n·Durante o evento \"Paciente Fragmentado: Aequor\", os Guardiães podem usar equipes pré-definidas pelo sistema contendo \"24\" para experimentar níveis designados um número ilimitado de vezes.\n·Ao jogar os níveis do evento, ajustes no Despertar do alinhamento da equipe não podem ser feitos.\n<Title:Recompensas da Atividade>\n·Após completar com sucesso um desafio de nível pela primeira vez, você pode reivindicar recompensas de teste na interface do evento."
  },
  Activity_124986_ActivityName = {
    Text = "Paciente dissociativo: ultra"
  },
  Activity_124986_ActivityTips = {
    Text = "<Title:Event Rules>\n·Durante o evento \"Paciente Dividido: Ultra\", os Guardiães podem usar equipes pré-definidas pelo sistema que incluem \"24\" para experimentar níveis designados infinitamente.\n·Ao experimentar níveis do evento, ajustes aos Despertadores na formação da equipe não são permitidos.\n<Title:Event Rewards>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_124987_ActivityName = {
    Text = "Cura múltipla: Réplica"
  },
  Activity_124987_ActivityPlot = {
    Text = "Histeria. Chame de mania, chame de destruição da mente; nesta era, o diagnóstico é uma sentença de morte. Felizmente, os cientistas e investigadores da Misaq são possuídos por uma loucura própria: estão determinados a conquistar esse terror."
  },
  Activity_124987_ActivityStageEndContent = {
    Text = "O evento terminou. Atualmente, apenas \"Análise de Personalidade\" está disponível."
  },
  Activity_124987_ActivityTips = {
    Text = "<Title:Introdução ao Evento>\n1. Durante o evento, os Guardiões do Segredo podem coletar a moeda do evento \"Quebra-Cabeça da Memória\" através dos modos de jogo temporários \"Código de memória\", \"Acumulação Maníaca\" e \"Recompensa de Conquista\". \"Quebra-Cabeça da Memória\" pode ser usado para comprar itens na \"Análise de personalidade\", incluindo a Roda do Destino SR exclusiva do evento \"Determinação do Bacalhau Prateado\", Núcleo de Lumen, Núcleo Imaculado, entre outros. \n2. Durante o evento, \"Registro da força-tarefa: Fissão Tranquila\" será desbloqueado gratuitamente por tempo limitado. Completar conquistas do evento também concede o avatar exclusivo do evento \"Por nome da Chave de prata: '24'\"!\n\n<Title:Tempo do Evento>\n1. 23 de fevereiro às 9:00 - 9 de março às 9:00 (GMT+8), todos os modos de jogo estão disponíveis. \n2. 9 de março às 9:00 - 16 de março às 9:00 (GMT+8), apenas \"Análise de personalidade\" e Recompensa de Conquista estão disponíveis. \n\n<Title:Código de memória>\n1. \"Código de memória\" contém 5 fases, que serão desbloqueadas automaticamente a cada 2 dias. \n2. Cada desafio consumirá 120 pontos de Lingfétide, e um desafio bem-sucedido concederá a moeda do evento. \n3. Após completar a fase, a função de \"Reprodução\" daquela fase será desbloqueada. Observe: ao usar a função \"Reprodução\", a Taxa de Sincronização não será obtida. \n4. Você pode usar a ajuda da associação de ex-alunos e a \"Resonância: Síndrome Dissociativa\" para facilitar a passagem das fases. \n\n<Title:Aumento Racional>\n1. Os Guardiões do Segredo que possuem corpos despertos ou rodas do destino específicas (não é necessário estar em batalha) podem fazer com que o \"Quebra-Cabeça da Memória\" na recompensa das fases de \"Código de memória\" tenha um aumento extra na queda, conforme os detalhes a seguir: \n Corpo Desperto \"24\": Despertar Espiritual 0/1/2/3 ou mais, aumento de 20%/30%/40%/50%. \n Roda do Destino SSR \"Restituição do corpo deformado\": Nível de empilhamento 0/1/2/3 ou mais, aumento de 20%/30%/40%/50%. \n Roda do Destino SR \"Determinação do Bacalhau Prateado\": Nível de empilhamento 0/1/2/3 ou mais, aumento de 20%/30%/40%/50%. \n2. O \"Aumento Racional\" de diferentes corpos despertos ou rodas do destino será calculado de forma acumulativa. \n3. Notavelmente, a recompensa do desafio de primeira conclusão na dificuldade de loucura não será afetada pelo \"Aumento Racional\". \n\n<Title:Resonância: Síndrome Dissociativa>\n1. Os Guardiões do Segredo podem obter \"Coração dividido\" ao completar conquistas do evento. \n2. Consumindo \"Coração dividido\" para ativar a \"Resonância: Síndrome Dissociativa\", você pode obter os seguintes aumentos: \n(1) Fortalecer os Guardiões do Segredo nos modos de jogo \"Código de memória\" e \"Registro da força-tarefa: Fissão Tranquila\", tornando os desafios mais fáceis. \n(2) Aumentar as recompensas obtidas após completar os desafios de \"Código de memória\". \n(3) Ativar o modo de jogo \"Acumulação Maníaca\". \n\n<Title: Acumulação Maníaca>\n1. Após ativar a ressonância \"Diagnóstico: Esquizofrenia\", você receberá automaticamente 60 \"Puzzle de Memória α\" a cada hora, com um máximo de 25 horas de armazenamento. \n2. Após ativar a ressonância \"Conhecimento harmonizado\", você receberá automaticamente 30 \"Puzzle de Memória β\" a cada hora, com um máximo de 25 horas de armazenamento. \n\n<Title:Registro da força-tarefa>\n1. Durante o evento, \"Registro da força-tarefa: Fissão Tranquila\" pode ser desbloqueado gratuitamente. \n2. Após o término do evento, o progresso da investigação de \"Registro da força-tarefa: Fissão Tranquila\" será mantido, e completar eventos de investigação não concluídos durante o evento também concederá recompensas de investigação consistentes com as do evento. Se \"Registro da força-tarefa: Fissão Tranquila\" não foi desbloqueado durante o evento, ainda será possível desbloqueá-lo consumindo \"Ponto de partida real\" *7 após o término do evento. \n3. Independentemente de estar durante o evento ou não, após concluir \"Registro da força-tarefa: Fissão Tranquila\", você receberá a \"Ordem de Chave: Tudo dela\". \n\n<Title:Compensação de Réplica>\n1. Os Guardiões do Segredo que já desbloquearam \"Registro da força-tarefa: Fissão Tranquila\" receberão uma compensação de 700 \"Puzzle de Memória α\" ao desbloqueá-lo novamente durante este evento de réplica. \n2. Os Guardiões do Segredo que já obtiveram o avatar exclusivo do evento \"Por nome da Chave de prata: '24'\" receberão automaticamente 1 \"Convite do Incorpóreo\" ao obtê-lo novamente. \n3. Os Guardiões do Segredo que já obtiveram o material de ativação da ressonância \"Coração dividido\" receberão automaticamente 5000 \"Cupom de ouro rosa\" por cada \"Coração dividido\" extra obtido. \n"
  },
  Activity_124987_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_124988_ActivityName = {
    Text = "Ceifador de almas"
  },
  Activity_124988_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento \"Colecionador de Almas\", os Guardiões podem usar equipes pré-definidas pelo sistema que incluem Hilota: Catena para experimentar níveis designados infinitamente.\n·Ao experimentar os níveis do evento, ajustes nos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_125364_ActivityName = {
    Text = "Sussurros de Huangpu"
  },
  Activity_125364_ActivityPlot = {
    Text = "Poder, luxúria e a intoxicação da riqueza; no altar onde os corpos jazem na profunda mansão, o ser antigo lentamente abre os olhos. \n Ah, mas esta não é uma história aterrorizante; Ele \"ama\" você, e Ele \"protegerá\" você para sempre... Ele deseja te dar tudo de \"melhor.\""
  },
  Activity_125364_ActivityStageEndContent = {
    Text = "O evento terminou. Atualmente, apenas \"Oferta Desolada\" está disponível."
  },
  Activity_125364_ActivityTips = {
    Text = "<Title:Visão geral do evento>\nDurante o evento, Guardiões podem coletar a moeda do evento \"Doce de Pêra\" através da jogabilidade por tempo limitado \"Senhora Misteriosa Sem Forma\" e \"Recompensa de conquista\". \"Doce de Pêra\" pode ser trocado por recompensas em \"Casa abandonada\", incluindo a Roda do destino SR exclusiva do evento \"Isca de Magnolia\", Núcleo de Lumen, Núcleo Imaculado, Fragmentos de Pedra Sábia, Cristal de Mimese e mais.\n\n<Title:Senhora Misteriosa Sem Forma>\n1. \"Senhora Misteriosa Sem Forma\" consiste em 9 fases de material que podem ser combatidas diretamente sem exploração, com uma fase abrindo a cada dia.\n2. Cada desafio consumirá 120 Lingfétide, e desafios bem-sucedidos concederão materiais de cultivo e moeda do evento.\n3. Após concluir uma fase, o recurso \"Recriar\" para essa fase será desbloqueado. Atenção: Usar o recurso \"Recriar\" não concederá Taxa de Sincronização.\n4. Você pode usar a Assistência de Alumni para ajudá-lo a concluir fases mais facilmente.\n\n<Title:Bônus do Evento>\n1. Guardiões que possuem Corpos Despertos ou Rodas do destino específicos (não é necessário implantá-los) podem ganhar bônus adicionais de drop para \"Doce de Pêra\" nas tarefas de fase \"Senhora Misteriosa Sem Forma\" (incluindo Recriar). Os bônus específicos são os seguintes: \n Corpo Desperto \"Xu\": Despertar Espiritual 0/1/2/3 e acima, bônus 20%/30%/40%/50%\n Roda do destino SSR \"Franzir a testa em vão\": Posição sobreposta 0/1/2/3 e acima, bônus 20%/30%/40%/50%\n Roda do destino SR \"Isca de Magnolia\": Posição sobreposta 0/1/2/3 e acima, bônus 20%/30%/40%/50%\n2. \"Bônus do Evento\" de diferentes Corpos Despertos ou Rodas do destino serão calculados de forma aditiva.\n3. Notavelmente, as recompensas de primeiro desafio concluído na dificuldade de loucura não serão afetadas pelos bônus mencionados acima. \n\n<Title:Casa abandonada>\n1. Cada \"Sacrifício a Deus\" consumirá 750 \"Doce de Pêra\" e concederá aleatoriamente cinco recompensas de itens de \"Casa abandonada\". \n2. As recompensas de itens de \"Casa abandonada\" são divididas em \"Item Especial\" e \"Item comum\". Ao reiniciar, a quantidade restante de recompensas de itens especiais pode ser reiniciada ao limite, com regras específicas como segue: \n(1) Para as primeiras 5 reinicializações: Quando não houver \"Item Especial\" restantes, Guardiões podem escolher reiniciar, o que reiniciará as quantidades restantes de \"Item Especial\" e \"Item comum\" ao limite; Guardiões também podem escolher continuar trocando, e quando não houver \"Item comum\" restantes, uma reinicialização deve ser realizada para continuar trocando. \n(2) A partir da 6ª reinicialização: Uma reinicialização só pode ser realizada quando não houver \"Item comum\" restantes, e a reinicialização reiniciará a quantidade restante de \"Item comum\" ao limite, enquanto \"Item Especial\" não serão mais reiniciados. \n\n<Title:Navegação na consciência>\n1. Durante o evento, \"Conversa à sombra do leque\" pode ser desbloqueado gratuitamente.\n2. Após o término do evento, o progresso de investigação de \"Conversa à sombra do leque\" será mantido. Completar quaisquer eventos de investigação que não foram finalizados durante o evento ainda concederá as mesmas recompensas de investigação do evento. Se \"Conversa à sombra do leque\" não foi desbloqueado durante o evento, ainda pode ser desbloqueado após o término do evento consumindo \"Ponto de partida real\"*3.\n3. Independentemente de ter sido durante o evento ou não, concluir \"Navegação na consciência: Conversa à sombra do leque\" concederá a você a \"Ordem de chave: Memórias da mansão\".\n\n<Title:Horário do Evento>\n1. 26 de janeiro, 9:00 – 9 de fevereiro, 9:00 (GMT+8), todo o conteúdo na visão geral do evento está disponível para participação. \n2. 9 de fevereiro, 9:00 – 16 de fevereiro, 9:00 (GMT+8), apenas \"Casa abandonada\" e \"Recompensa de conquista\" permanecerão, e todo o outro conteúdo terá terminado e estará indisponível para participação. \n3. Após 16 de fevereiro, 9:00 (GMT+8), qualquer \"Doce de Pêra\" não trocado será recuperado a uma taxa de 40 \"Cupom de ouro rosa\". Por favor, verifique sua caixa de entrada para resgatá-los a tempo."
  },
  Activity_125364_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_125366_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_125366_ActivityPlot = {
    Text = "Após a compra, \"Xu\" pode ativar\n<BlueQuality:Surto Psíquico +4, Desbloquear Superexaltação>"
  },
  Activity_125367_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_125368_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_125368_ActivityPlot = {
    Text = "Após a compra, \"Xu\" pode ativar <BlueQuality:iluminar 3>"
  },
  Activity_126275_ActivityName = {
    Text = "Tecelão Aprisionado"
  },
  Activity_126275_ActivityPlot = {
    Text = "A roda gira suavemente, fiando através das eras sem cessar. Dance ao longo dos filamentos prateados, ó Grande Tecelã. Pois o destino é o palco do qual nunca poderás fugir.\nJuíza. Redentora. Senhora. Cativa...\nDesde o momento em que pisaste nestas tábuas, o papel que haverias de Disparar já não era teu para escolher."
  },
  Activity_126275_ActivityStageEndContent = {
    Text = "O evento terminou. Atualmente, apenas a \"Loja de Presentes do Teatro\" está disponível."
  },
  Activity_126275_ActivityTips = {
    Text = "<Title:Visão Geral do Evento>\nDurante o evento, os Guardiões do segredo podem coletar a moeda do evento \"Bilhete de assento em veludo\" através das jogabilidades por tempo limitado \"Palco da Marionete\" e \"Conquistas\". O \"Bilhete de assento em veludo\" pode ser trocado por recompensas na \"Loja de Presentes do Teatro,\" incluindo a exclusiva Roda do destino SR \"Roda de fiar do destino,\" Núcleo do Vazio, Núcleo Imaculado, Fragmentos de Pedra Sábia, Cristal de Mimese e mais.\n\n<Title:Palco da Marionete>\n1. O \"Palco da Marionete\" contém 5 fases, com 1 fase desbloqueada a cada 2 dias.\n2. Cada desafio custa \"Lingfétide\" × 120. Completar um desafio com sucesso recompensa materiais de cultivo e moeda do evento.\n3. Após completar uma fase, a função \"Recriar\" dessa fase é desbloqueada. Atenção: a Taxa de Sincronização não pode ser obtida ao usar a função \"Recriar\".\n4. Você pode usar o Apoio de batalha de Colegas para ajudá-lo a completar as fases mais facilmente.\n\n<Title:Bônus do Evento>\n1. Guardiões do segredo que possuírem Corpos Despertos ou Rodas do destino específicos (não é necessário que estejam posicionados) podem obter bônus adicionais de drop de \"Bilhete de assento em veludo\" nas recompensas de missão de fase do \"Palco da Marionete\" (incluindo Recriar). Os bônus específicos são os seguintes:\n·Corpo Desperto \"Arachne\": Despertar Espiritual 0/1/2/3 ou acima, bônus 20%/30%/40%/50%\n·Roda do destino SSR \"Rede da Tecelagem Eterna\": Nível de empilhamento 0/1/2/3 ou acima, bônus 20%/30%/40%/50%\n·Roda do destino SR \"Roda de fiar do destino\": Nível de empilhamento 0/1/2/3 ou acima, bônus 20%/30%/40%/50%\n2. O \"Bônus do Evento\" de diferentes Corpos Despertos ou Rodas do destino é calculado de forma acumulativa.\n3. Em particular, as recompensas de primeira conclusão dos desafios de dificuldade de loucura não são afetadas pelos bônus acima.\n\n<Title: Loja de Presentes do Teatro>\n1. Cada \"Troca de Presentes\" custa 750 \"Bilhete de assento em veludo\" e concede aleatoriamente cinco recompensas de itens da \"Loja de Presentes do Teatro\".\n2. As recompensas de itens na \"Loja de Presentes do Teatro\" são divididas em \"Item Especial\" e \"Item comum\". Um retroceder pode restaurar a quantidade restante das recompensas de Item Especial ao máximo. As regras específicas são as seguintes:\n(1) Primeiros 5 Retroceder: Quando os \"Item Especial\" não tiverem quantidade restante, os Guardiões do segredo podem optar por retroceder, o que redefinirá as quantidades restantes tanto dos \"Item Especial\" quanto dos \"Item comum\" ao limite; ou podem optar por continuar trocando. Quando os \"Item comum\" também não tiverem quantidade restante, é necessário realizar um retroceder para continuar trocando.\n(2) A partir do 6º Retroceder: O retroceder só pode ser realizado quando os \"Item comum\" não tiverem quantidade restante. O retroceder restaurará a quantidade restante dos \"Item comum\" ao limite, enquanto os \"Item Especial\" não serão mais redefinidos.\n\n<Title:Duração do Evento>\n1. 20 de abril, 9:00 – 18 de maio, 9:00 (GMT+8): Todas as jogabilidades do evento estão disponíveis.\n2. 4 de maio, 9:00 – 11 de maio, 9:00 (GMT+8): Apenas \"Loja de Presentes do Teatro\" e \"Conquistas\" estão disponíveis.\n3. Após 11 de maio, 9:00 (GMT+8): Quaisquer \"Bilhete de assento em veludo\" restantes não resgatados serão convertidos a uma taxa de \"Cupom de ouro rosa\" × 40 por bilhete. Lembre-se de verificar suas recompensas."
  },
  Activity_126275_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_126365_ActivityName = {
    Text = "Crônica do Destino"
  },
  Activity_126365_ActivityTips = {
    Text = "Regras do evento:\n1. Os Guardiões do Segredo que completarem as tarefas designadas poderão coletar recompensas em \"Arquivos Destinados\".\n2. As tarefas são agrupadas, com um grupo sendo desbloqueado diariamente após o início do evento.\n3. Após liberar o \"Arquivo de Peregrinação\", será possível coletar recompensas extras após completar as tarefas.\n4. Atenção: o \"Arquivo Avançado\" desbloqueado neste evento só é válido durante este evento de Arquivos."
  },
  Activity_126366_ActivityName = {
    Text = "Peregrinação Ecoada: Reinado Astral V"
  },
  Activity_126366_ActivityPlot = {
    Text = "Um pedaço de memória selado e arquivado, uma jornada registrada no passado. Em momentos de lembrança, não se esqueça de oferecer sua reverente Visita."
  },
  Activity_126492_ActivityName = {
    Text = "Monólogos de Panlong"
  },
  Activity_126492_ActivityTips = {
    Text = "<Title: Antologia de Antigos Reinos>\n· Esta jornada por tempo limitado inclui 8 pacotes, dos quais o primeiro pode ser coletado gratuitamente, e os pacotes 2-8 precisam ser comprados para serem coletados após a compra da \"Antologia de Antigos Reinos\".\n· Após comprar a \"Antologia de Antigos Reinos\", você pode imediatamente coletar a recompensa do 2º pacote; os pacotes subsequentes precisam esperar um certo tempo antes de serem coletados.\n· Se a \"Antologia de Antigos Reinos\" for comprada antes de 26 de janeiro às 9:00, você também receberá recompensas adicionais: ícone exclusivo \"Forma Verdadeira do Leque\" e \"Convite do Incorpóreo\" ×10! Após 26 de janeiro às 9:00, não haverá recompensas exclusivas por tempo limitado ao comprar.\n· Após a compra, a duração desta jornada por tempo limitado se tornará permanente, e o evento será encerrado no dia seguinte após a coleta de todos os pacotes.\n· A compra da \"Antologia de Antigos Reinos\" tem um limite de tempo; após o prazo, não será mais possível comprar. Por favor, os Guardiões do Segredo devem considerar a compra até 23 de fevereiro às 9:00."
  },
  Activity_126492_BannerText = {
    Text = "Jornada Especial da Atividade por Tempo Limitado!"
  },
  Activity_127173_ActivityName = {Text = "O pintor"},
  Activity_127173_ActivityTips = {
    Text = "<Title:Regras do evento>\n· Durante o evento \"O Artista\", os Guardiões do Segredo podem usar equipes pré-definidas do sistema que incluem Pickman para experimentar os níveis designados sem limites. \n· Ao experimentar os níveis do evento, não é possível ajustar os Corpos Despertos na Formação. \n<Title:Recompensas do evento>\n· Após completar o desafio do nível pela primeira vez, você pode coletar recompensas de teste na interface do evento."
  },
  Activity_129488_ActivityName = {
    Text = "Trem de Alegria Acelerado"
  },
  Activity_129488_ActivityPlot = {
    Text = "No trem, gritos irritados ecoavam continuamente da sala de luxo. \n \"Salvador, o terceiro vagão precisa de ajuda!\" \n \"Wanda, mande os inimigos que você controla para a parte de trás do trem, eles estão se aproximando!\" \n \"Ryker! Não flerte mais! Venha espantar o cara do meu lado da janela!\" \n Enquanto você, atolado nas preocupações da cabine de luxo, não percebeu que uma pequena figura já havia se infiltrado em seu bolso. \n \"Hehe, realmente é assim que fica interessante.\" \n \"Capturei uma boa imagem~ Então, a próxima — é hora da ajudante pequena 'N' aparecer~\""
  },
  Activity_129488_ActivityTips = {
    Text = "<Title:Introdução ao Evento>\nDurante o evento, os guardiões podem obter recompensas limitadas e ricas através da \"Marca de trilho longo\". Após o término do evento, as recompensas na \"Marca de trilho longo\" não poderão mais ser recebidas, por favor, guardiões, reivindiquem as recompensas limitadas a tempo.\nDurante o evento, participar da \"Partida do Trem\" resultará em compensação de nível: no grupo de investigação, os corpos despertos com nível abaixo de 60, nível de habilidade abaixo de 5, \"Sinais Loucos\" abaixo de 6 ou \"Adaptabilidade de forma espiritual\" abaixo de 5 serão compensados para esses mínimos nesta desafio. Se o nível do guardião for inferior a 60, será compensado para 60 durante este desafio.\n\n<Title:Registro da força-tarefa>\nDurante o evento, o \"Registro da força-tarefa: Trem em direção ao Festival de Qisui\" estará disponível gratuitamente.\nApós o término do evento, o progresso da investigação será mantido. Se o \"Trem em direção ao Festival de Qisui\" não for desbloqueado durante o evento, ainda será possível desbloqueá-lo após o término do evento consumindo \"Ponto de partida real\"*7.\nIndependentemente de estar ou não durante o evento, após concluir o \"Trem em direção ao Festival de Qisui\", será possível obter a \"Ordem de chave: Fogos de Artifício de Fim de Ano\".\n<Title:Trem de Alegria Acelerado>\nO \"Trem de Alegria Acelerado\" é um modo de desafio contínuo baseado nas regras do \"Capítulo das Estrelas\". Os guardiões enfrentarão continuamente os chefes finais que apareceram em várias ações de investigação em encontros aleatórios e dinâmicos!\nNo modo de jogo, o limite de posse de criação pode ser aumentado para até 36.\nDurante o desafio, é possível possuir e fortalecer simultaneamente 3 poderosos efeitos de \"Ressonância\" em ações de investigação.\nCada vez que o corpo de Gnosis de Emergência for usado, você ganhará 20% menos Pontos de Convidados VIP neste desafio; os guardiões devem planejar suas estratégias de ação com mais cautela.\nÉ permitido sair do jogo a qualquer momento e manter o progresso, mas o estado da equipe não será atualizado em sincronia com as mudanças externas de desenvolvimento. O progresso será mantido por no máximo 7 dias após o último desafio; se não houver continuidade no desafio durante o período de retenção, será considerado desistência do desafio e o progresso não será mais mantido.\n\n<Title:Lista VIP>\n1. Durante o evento, os registros na \"Lista VIP\" serão mantidos, e serão redefinidos de acordo com o ciclo da Atividade escolar após o término do evento.\n2. A \"Lista VIP\" registrará os guardiões que tiveram excelente desempenho nos desafios. Os guardiões que desafiarem uma vez durante cada período de Atividade escolar e obtiverem \"Pontos de Convidados VIP\" com sucesso serão incluídos na \"Lista VIP\".\n3. A classificação na \"Lista VIP\" será baseada no máximo de \"Pontos de Convidados VIP\" obtidos em um único desafio e no número mínimo de \"Turnos\" usados. É possível refazer desafios para melhorar a classificação.\n\n<Title:Tempo do Evento>\n1. 9 de fevereiro às 9:00 - 9 de março às 9:00 (GMT+8), todo o conteúdo do evento estará aberto para participação.\n2. Após 9 de março às 9:00 (GMT+8), o evento será arquivado no \"Fliperama\", e as recompensas na \"Marca de trilho longo\" não poderão mais ser recebidas."
  },
  Activity_129488_BannerText = {
    Text = "Evento especial de nova jogabilidade iniciado!"
  },
  Activity_129508_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_129509_ActivityName = {
    Text = "Asas de boa sorte do início do ano"
  },
  Activity_129509_ActivityTips = {
    Text = "Regras do evento:\n1. Após fazer login diariamente, os Guardiões do Segredo podem coletar recompensas do \"Luz do Novo Ano\".\n2. As recompensas serão desbloqueadas conforme o login acumulado, e o check-in diário será atualizado às 9h (GMT+8)."
  },
  Activity_129509_BannerText = {
    Text = "Check-in para receber Núcleos de Prata e muitas recompensas"
  },
  Activity_129705_ActivityName = {
    Text = "Senhor da Chama Explosiva"
  },
  Activity_129705_ActivityTips = {
    Text = "<Title:Regras do Evento>\n· Durante o evento \"Senhor da Chama Explosiva\", os Guardiões do Segredo podem usar equipes pré-definidas que incluem Katie Gula para experimentar os níveis designados sem limites. \n· Ao experimentar os níveis do evento, não é possível ajustar o Corpo Desperto na formação. \n<Title:Recompensas do Evento>\n· Após completar o desafio do nível pela primeira vez, é possível receber recompensas de teste na interface do evento."
  },
  Activity_129706_ActivityName = {
    Text = "Bishop de bálsamos"
  },
  Activity_129706_ActivityTips = {
    Text = "<Title:Regras da Atividade>\n·Durante o evento \"Bispo Benevolente\", os Guardiães podem usar equipes pré-definidas pelo sistema contendo Salvador para experimentar níveis designados um número ilimitado de vezes.\n·Ao jogar os níveis do evento, ajustes no Despertar do alinhamento da equipe não podem ser feitos.\n<Title:Recompensas da Atividade>\n·Após completar com sucesso um desafio de nível pela primeira vez, você pode reivindicar recompensas de teste na interface do evento."
  },
  Activity_130174_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_130175_ActivityName = {
    Text = "renascimento de cabeça para baixo"
  },
  Activity_130175_ActivityPlot = {
    Text = "O mundo é solitário demais, o mundo é desolado demais. Por favor, ouça, por favor, testemunhe.\nCarne gritante espera através do longo silêncio, esperando que dentes-de-leão floresçam no deserto.\nEntão será preenchido com amor radiante, e receberá novo nascido curado mais uma vez."
  },
  Activity_130175_ActivityStageEndContent = {
    Text = "O evento foi Concluído. Atualmente, apenas o \"Jardim de Dentes-de-Leão\" está disponível."
  },
  Activity_130175_ActivityTips = {
    Text = "<Title:Introdução da atividade>\n1, Durante a atividade, os Guardiões podem coletar as moedas de atividade \"Pó de Escama Pálida\",\"Pó de Escama Vermelha\" e \"Pó de Escama Brilhante\" através da atividade de jogo por tempo limitado \"Notas da câmara escura\" e das \"Recompensas de conquista\", e trocá-las no \"Jardim de Dentes-de-Leão\" por itens, incluindo a Roda do destino SR limitada \"Conto de fadas na lama\", Núcleo de Lumen, Núcleo Imaculado, entre outros.\n2, Durante a atividade,\"Conexão multidimensional: Sementes esquecidas de amor\" estará disponível para desbloqueio gratuito por tempo limitado, e completar as conquistas da atividade também permitirá obter o avatar limitado da atividade \"Por nome da Chave de Prata: Saya\"!\n\n<Title:Período da atividade>\n1, 30 de maio às 9:00 - 24 de agosto às 9:00(GMT+8), todas as atividades de jogo estarão disponíveis para participação.\n2, 24 de agosto às 9:00 - 31 de agosto às 9:00(GMT+8), apenas o \"Jardim de Dentes-de-Leão\" e as recompensas de conquista estarão disponíveis.\n\n<Title:Notas da câmara escura>\n1,\"Notas da câmara escura\" contém 7 fases, sendo 1 desbloqueada automaticamente por dia.\n2, Cada desafio consumirá\"Lingfétide\" × 120, e o sucesso no desafio renderá moedas de atividade.\n3, Após concluir uma fase, a função \"Recriar\" dessa fase será desbloqueada. Atenção: ao usar a função \"Recriar\", não será possível obter Taxa de Sincronização.\n4, Você pode usar o Apoio de batalha da associação de ex-alunos para ajudá-lo a passar pelas fases com mais facilidade.\n\n<Title: Jardim de Dentes-de-Leão>\n1, O \"Jardim de Dentes-de-Leão\" possui três lojas, com os seguintes horários de abertura:\n·\"Jardim de Cultivo\": abre às 9h do dia 30 de maio.\n·\"Jardim em Crescimento\": abre às 9h do dia 31 de maio.\n·\"Jardim em Flor\": abre às 9h do dia 1 de junho.\n2, Cada troca consumirá\"Pó de Escama Pálida\"/\"Pó de Escama Vermelha\"/\"Pó de Escama Brilhante\" × 750, obtendo aleatoriamente cinco recompensas de itens do \"Jardim de Dentes-de-Leão\".\n3, As recompensas de itens de cada \"Jardim de Dentes-de-Leão\" são divididas em \"Item Especial\" e \"Item comum\". Ao reiniciar, é possível restaurar a quantidade restante de Itens Especiais ao limite máximo. As regras específicas são:\n(1) Primeiras 2 reinicializações: quando os \"Itens Especiais\" não tiverem quantidade restante, o Guardião pode optar por reiniciar, restaurando a quantidade restante de \"Itens Especiais\" e \"Itens comuns\" ao limite máximo; também é possível continuar trocando, e quando os \"Itens comuns\" também não tiverem quantidade restante, será necessário reiniciar para continuar trocando.\n(2) A partir da 3ª reinicialização: só é possível reiniciar quando os \"Itens comuns\" não tiverem quantidade restante. A reinicialização restaurará a quantidade restante de \"Itens comuns\" ao limite máximo, e os \"Itens Especiais\" não serão mais reiniciados.\n\n<Title:Bônus de atividade>\n1, Quando o Guardião possuir determinados Corpos Despertos ou Rodas do destino(não é necessário colocá-los em campo), as recompensas das missões das fases de \"Notas da câmara escura\" receberão bônus adicionais na queda dos três tipos de moedas de atividade:\n·Corpo Desperto \"Saya\": Despertar Espiritual 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%.\n·Roda do destino SSR \"Que o mundo se transforme em fragrância\": Nível de empilhamento 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%.\n·Roda do destino SR \"Conto de fadas na lama\": Nível de empilhamento 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%.\n2, Múltiplos \"Bônus de atividade\" podem ser acumulados. \n3, Atenção: as recompensas do primeiro desafio concluído na dificuldade de loucura não serão afetadas pelo \"Bônus de atividade\".\n\n<Title:Conexão multidimensional>\n1, Durante a atividade,\"Conexão multidimensional: Sementes esquecidas de amor\" pode ser desbloqueada gratuitamente.\n2, Após o término da atividade, o progresso da investigação será preservado, e os eventos de Investigação de eventos não concluídos durante a atividade poderão ser concluídos após o término da atividade para obter as recompensas correspondentes. Caso não tenha sido desbloqueado durante a atividade, ainda será possível desbloquear consumindo \"Ponto de partida real\" × 3 após o término da atividade.\n3, Independentemente de ser durante a atividade ou não, Concluir \"Conexão multidimensional: Sementes esquecidas de amor\" permitirá obter \"Ordem de chave: Dedicado ao novo mundo\"."
  },
  Activity_130175_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_130176_ActivityName = {
    Text = "Ágape Florescente"
  },
  Activity_130176_ActivityTips = {
    Text = "<Title:Regras do Evento>\nDurante o evento \"Ágape Florescente\", os Guardiões do segredo podem usar a Formação predefinida pelo sistema contendo Saya para experimentar Fases designadas ilimitadamente.\nAo experimentar as Fases do evento, os Corpos Despertos na Formação não podem ser ajustados.\n<Title:Recompensas do Evento>\nApós concluir um desafio de Fase pela primeira vez, as recompensas de teste podem ser reivindicadas na interface do evento."
  },
  Activity_130376_ActivityName = {
    Text = "Texto temporário"
  },
  Activity_130376_ActivityTips = {
    Text = "<Title:Regras do Evento>\nDurante o evento \"Origem: Poder Real\", os Guardiões do segredo podem usar equipes predefinidas pelo sistema que incluem Origem: Poder Real para experienciar níveis designados um número ilimitado de vezes.\nAo experienciar os níveis do evento, ajustes nos Corpos Despertos na formação da equipe não podem ser feitos.\n<Title:Recompensas do Evento>\nApós completar o desafio do nível pela primeira vez, você pode reivindicar as recompensas de demonstração na interface do evento."
  },
  Activity_130403_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_130403_ActivityPlot = {
    Text = "Após a compra, \"Origem Ogier\" pode ativar\n<BlueQuality:Desenvolvimento da personalidade +4, Desbloquear Fúria Explosiva Sobrecarregada>"
  },
  Activity_130404_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_130404_ActivityPlot = {
    Text = "Após a compra, \"Satogua\" pode ativar\n<BlueQuality:Desenvolvimento da personalidade +4, Desbloquear Fúria Explosiva Sobrecarregada>"
  },
  Activity_130406_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_130406_ActivityPlot = {
    Text = "Após a compra, \"Satogua\" pode ativar <BlueQuality:Despertar Espiritual 3>"
  },
  Activity_130407_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_130407_ActivityPlot = {
    Text = "Após a compra, \"Origem Ogier\" pode ativar <BlueQuality:Despertar Espiritual 3>"
  },
  Activity_130408_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_130408_ActivityPlot = {
    Text = "Após a compra, \"Saya\" pode ativar <BlueQuality:Despertar Espiritual 3>"
  },
  Activity_130409_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_130409_ActivityPlot = {
    Text = "Após a compra, \"Saya\" pode ativar\n<BlueQuality:Desenvolvimento da personalidade +4, Desbloquear Fúria Explosiva Sobrecarregada>"
  },
  Activity_130921_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_130922_ActivityName = {Text = "Vórtice"},
  Activity_130922_ActivityTips = {
    Text = "<Title:Regras do Evento>\nDurante o evento \"vórtice\", os Guardiões do segredo podem usar a formação predefinida do sistema contendo Mosk para experimentar fases designadas um número ilimitado de vezes.\nAo experimentar as fases do evento, os Corpos Despertos na formação não podem ser ajustados.\n<Title:Recompensas do Evento>\nApós completar o desafio de uma fase pela primeira vez, as recompensas de teste podem ser reivindicadas na interface do evento."
  },
  Activity_130923_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_130923_ActivityPlot = {
    Text = "Após a compra, \"Mosk\" pode ativar\n<BlueQuality:Desenvolvimento da personalidade +4, Desbloquear Fúria Explosiva Sobrecarregada>"
  },
  Activity_130924_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_130924_ActivityPlot = {
    Text = "Após a compra, \"Mosk\" pode ativar <BlueQuality:Despertar Espiritual 3>"
  },
  Activity_130925_ActivityName = {
    Text = "Chamado de Musk"
  },
  Activity_130925_ActivityPlot = {
    Text = "No fundo do mar, o vórtice está devorando tudo. \n Os demônios sob Merscus abrem suas bocas enormes, convidando igualmente todos os seres que se aproximam. \n Ele gira dia após dia, gritando repetidamente, chamando a pessoa destinada que inevitavelmente chegará. \n Venha, venha, \"vegetação aquática\" irá enrolar você, \"recifes\" irão acompanhá-lo, nas profundezas escuras do mar, você está destinado a dançar com o desastre. \n E o desastre também responderá seu último pedido. \n Bem-vindo de volta, a pessoa destinada que não pode escolher."
  },
  Activity_130925_ActivityStageEndContent = {
    Text = "Evento encerrado, disponível apenas na \"Biblioteca de Mosk\""
  },
  Activity_130925_ActivityTips = {
    Text = "<Title:Introdução da Atividade>\n1, Durante o período da atividade, o Guardião do Segredo pode coletar a moeda da atividade \"Caracol do Mar I\", \"Caracol do Mar II\", \"Caracol do Mar III\" através dos modos de jogo limitados \"Mosk e o Mar\" e \"Recompensa de Conquista\". \"Caracol do Mar I\", \"Caracol do Mar II\", \"Caracol do Mar III\" podem ser usados para comprar itens na \"Tesouro de Mosk\", incluindo a roda de destino SR limitada da atividade \"Loucura Aprisionada\", Núcleo de Lumen, Núcleo Imaculado, entre outros. \n2, Durante o período da atividade, \"Navegação na Consciência: Vício\" será desbloqueado gratuitamente por tempo limitado e completar as conquistas da atividade também dará ao jogador o avatar limitado da atividade \"Por Nome da Chave de Prata: Mosk\"! \n\n<Title:Tempo da Atividade>\n1, 9 de março às 9:00 - 6 de abril às 9:00 (GMT+8), todos os modos de jogo da atividade estão disponíveis. \n2, 6 de abril às 9:00 - 13 de abril às 9:00 (GMT+8), apenas \"Tesouro de Mosk\" e Recompensa de Conquista estarão disponíveis. \n\n<Title:Mosk e o Mar>\n1, \"Mosk e o Mar\" contém 7 fases, uma fase será desbloqueada automaticamente a cada dia. \n2, Cada desafio consumirá \"Lingfétide\" × 120, e ao ter sucesso no desafio, o jogador ganhará a moeda da atividade. \n3, Após completar a fase, a função \"Reproduzir\" daquela fase será desbloqueada. Atenção: ao usar a função \"Reproduzir\", a taxa de sincronização não será obtida. \n4, O apoio da associação de ex-alunos pode ser utilizado para ajudar a completar as fases mais facilmente. \n\n<Title:Tesouro de Mosk>\n1, \"Tesouro de Mosk\" possui três lojas, com os seguintes horários de abertura: \n· \"Baú Número Um\": Abre às 9:00 do dia 9 de março. \n· \"Baú Número Dois\": Abre às 9:00 do dia 10 de março. \n· \"Baú Número Três\": Abre às 9:00 do dia 11 de março. \n2, Cada troca consumirá \"Caracol do Mar I\"/\"Caracol do Mar II\"/\"Caracol do Mar III\" × 750, recebendo aleatoriamente cinco itens como recompensa do \"Tesouro de Mosk\". \n3, As recompensas de itens de cada \"Tesouro de Mosk\" são divididas em \"Itens Especiais\" e \"Itens Comuns\", e ao redefinir, a quantidade restante de itens especiais será restaurada ao limite máximo, as regras específicas são: \n(1) Nas 2 primeiras redefinições: quando não houver mais itens especiais restantes, o Guardião do Segredo pode optar por redefinir, e a redefinição restaurará a quantidade restante de itens especiais e comuns ao limite máximo; também pode optar por continuar trocando, quando não houver mais itens comuns restantes, será necessário redefinir para continuar trocando. \n(2) A partir da 3ª redefinição: só pode ser feita após não haver mais itens comuns restantes, a redefinição restaurará a quantidade restante de itens comuns ao limite máximo, e os itens especiais não serão mais redefinidos. \n\n<Title:Aumento da Atividade>\n1, O Guardião do Segredo que possui um corpo desperto ou roda de destino específicos (não é necessário estar em uso) pode fazer com que as recompensas da missão da fase \"Tesouro de Mosk\" em \"Caracol do Mar I\", \"Caracol do Mar II\", \"Caracol do Mar III\" tenham um aumento adicional nas quedas, os aumentos específicos são: \n· Corpo Desperto \"Mosk\": Despertar 0/1/2/3 e acima, aumento de 20%/30%/40%/50%. \n· Roda de Destino SSR \"Jardim do Éden Distante\": Sobreposição 0/1/2/3 e acima, aumento de 20%/30%/40%/50%. \n· Roda de Destino SR \"Loucura Aprisionada\": Sobreposição 0/1/2/3 e acima, aumento de 20%/30%/40%/50%. \n2, O \"Aumento da Atividade\" de diferentes corpos despertos ou rodas de destino será calculado de maneira acumulativa. \n3, Especialmente, a recompensa do primeiro desafio em dificuldade de loucura não será afetada pelo \"Aumento da Atividade\". \n\n<Title:Navegação na Consciência>\n1, Durante o período da atividade, \"Navegação na Consciência: Vício\" pode ser desbloqueado gratuitamente. \n2, Após o término da atividade, o progresso da investigação de \"Navegação na Consciência: Vício\" será mantido, e ao completar eventos de investigação não concluídos durante o período da atividade, o jogador ainda poderá receber recompensas de investigação iguais às do período da atividade. Se \"Navegação na Consciência: Vício\" não for desbloqueado durante o período da atividade, após o término da atividade ainda será possível gastar \"Ponto de Partida Real\" × 3 para desbloquear. \n3, Independentemente de estar ou não durante o período da atividade, após completar \"Navegação na Consciência: Vício\", o jogador receberá \"Ordem de Chave: Inocência Afogada\"."
  },
  Activity_130925_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_131090_ActivityName = {
    Text = "Banquete Ardente: Recorrência"
  },
  Activity_131090_ActivityPlot = {
    Text = "Isalrauh, a cidade no lago, supostamente é a terra natal de wanda.\nDesta vez você passará pela porta do sonho e chegará àquela antiga torre repleta de línguas de sino"
  },
  Activity_131090_ActivityStageEndContent = {
    Text = "O evento terminou, atualmente só é possível participar do\"Baú do tesouro de wanda\""
  },
  Activity_131090_ActivityTips = {
    Text = "<Title:Descrição da Atividade>\n1, Durante o evento, os Guardiões do Segredo podem coletar a moeda do evento \"Os Festins Ardentes\" e \"Recompensas de Conquista\" através de modos de jogo limitados, como \"Os Festins Ardentes\" e \"Recompensas de Conquista\", coletando a moeda do evento \"Os Tibia Original\", \"Amónito de folhas arredondadas\", \"Ruínas Espirais\". A moeda do evento pode ser usada para comprar itens na \"A Caixa de Tesouros Exóticos de Wanda\", incluindo o SR da roda do destino limitado ao evento \"O olhar de Isarau\", Núcleo de Lumen, Núcleo Imaculado, entre outros. \n2, Durante o evento, \"Navegação na consciência: Os Festins Ardentes\" será desbloqueado gratuitamente por tempo limitado, e completar as conquistas do evento também concederá o ícone do evento limitado \"Por nome da Chave de Prata: Wanda\"!\n\n<Title:Período do Evento>\n1, De 23 de março às 9:00 até 20 de abril às 9:00 (GMT+8), todos os modos de jogo do evento estarão disponíveis. \n2, De 20 de abril às 9:00 até 27 de abril às 9:00 (GMT+8), apenas \"A Caixa de Tesouros Exóticos de Wanda\" e recompensas de conquista estarão disponíveis. \n\n<Title:Cidade no Lago>\n1, \"Cidade no Lago\" tem 7 fases, que se abrem automaticamente uma a cada dia. \n2, Cada desafio consumirá \"Lingfétide\" × 120, e o sucesso no desafio concederá a moeda do evento. \n3, Após passar uma fase, a função \"Reproduzir\" dessa fase será desbloqueada. Atenção: ao usar a função \"Reproduzir\", não será possível obter a Taxa de Sincronização. \n4, Você pode usar o apoio de batalha da associação de ex-alunos e \"Resonância: Ordem Secreta\" para ajudá-lo a passar mais facilmente pelas fases. \n\n<Title:Bônus de Tesouro>\n1, Os Guardiões do Segredo que possuem um corpo despertado ou roda do destino específica (não é necessário estar em campo) podem aumentar a recompensa da moeda do evento nas missões da fase \"Cidade no Lago\", com os seguintes bônus: \n· Corpo Desperto \"Wanda\": Despertar 0/1/2/3 e acima, bônus de 20%/30%/40%/50%. \n· Roda do Destino SSR \"Decreto da Rainha\": Posição sobreposta 0/1/2/3 e acima, bônus de 20%/30%/40%/50%. \n· Roda do Destino SR \"O olhar de Isarau\": Posição sobreposta 0/1/2/3 e acima, bônus de 20%/30%/40%/50%. \n2, O \"Bônus de Tesouro\" de diferentes corpos despertados ou rodas do destino será calculado de forma acumulativa. \n3, Notavelmente, a recompensa do primeiro desafio na dificuldade de loucura não será afetada pelo \"Bônus de Tesouro\". \n\n<Title:Resonância: Ordem Secreta>\n1, Os Guardiões do Segredo podem obter \"Coração do prazer\" completando as conquistas do evento. \n2, Consumindo \"Coração do prazer\", ativar \"Resonância: Ordem Secreta\", permitirá que os Guardiões do Segredo se tornem mais fortes na \"Cidade no Lago\", tornando os desafios mais fáceis; também permitirá que os Guardiões do Segredo recebam moeda do evento extra ao passar. \n\n<Title:Navegação na Consciência>\n1, Durante o evento, \"Os Festins Ardentes\" pode ser desbloqueado gratuitamente. \n2, Após o término do evento, o progresso da investigação de \"Os Festins Ardentes\" será mantido, e completar os eventos de investigação não concluídos durante o evento também resultará em recompensas de investigação consistentes com as do evento. Se \"Os Festins Ardentes\" não foi desbloqueado durante o evento, ainda será possível consumindo \"Ponto de partida real\" × 3 para desbloquear. \n3, Independentemente de estar durante o evento ou não, após passar \"Os Festins Ardentes\", você poderá obter \"Ordem de Chave: Festim Podre\". \n\n<Title:Compensação de Recriação>\n1, Os Guardiões do Segredo que já desbloquearam \"Navegação na consciência: Os Festins Ardentes\" receberão uma compensação de \"Os Tibia Original\" × 300 durante este evento de recriação. \n2, Os Guardiões do Segredo que já obtiveram o ícone do evento limitado \"Por nome da Chave de Prata: Wanda\", ao recebê-lo novamente, será automaticamente convertido em \"Convite do Incorpóreo\" × 1. \n3, Os Guardiões do Segredo que já obtiveram o material de ativação da resonância \"Coração do prazer\", a cada \"Coração do prazer\" extra, será automaticamente convertido em \"Cupom de ouro rosa\" × 5000. \n"
  },
  Activity_131090_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_131091_ActivityName = {
    Text = "Festa Ardente"
  },
  Activity_131370_ActivityName = {
    Text = "Vencedor sortudo"
  },
  Activity_131370_ActivityTips = {
    Text = "<Title:Visão Geral do Evento>\n1. Após completar as tarefas designadas do Diário do Guardião do Segredo, os Guardiões do segredo podem reivindicar recompensas em \"Vencedor sortudo\".\n2. \"Vencedor sortudo\" terminará em 6 de abril às 9:00.\n3. Desbloqueie o \"Arquivo Avançado\" para reivindicar recompensas extras ao completar tarefas.\n4. Atenção: O \"Arquivo Avançado\" desbloqueado neste evento é válido apenas para este evento. Guardiões do segredo, por favor consumam de forma racional."
  },
  Activity_131370_BannerText = {
    Text = "Jornada Especial da Atividade por Tempo Limitado!"
  },
  Activity_131849_ActivityName = {
    Text = "memória eterna"
  },
  Activity_131849_ActivityTips = {
    Text = "<Title:memória eterna>\n\nEsta Jornada por Tempo Limitado contém 8 pacotes de presente. O primeiro pacote de presente pode ser reivindicado gratuitamente, enquanto os pacotes 2–8 requerem a compra de \"memória eterna\" antes de poderem ser reivindicados.\n\nApós comprar \"memória eterna,\" as recompensas do 2º pacote de presente podem ser reivindicadas imediatamente; os pacotes subsequentes requerem esperar um certo período de tempo antes de poderem ser reivindicados.\n\nComprar \"memória eterna\" antes das 9:00 de 30 de maio também concederá recompensas adicionais: avatar exclusivo \"Bom Apetite\" e \"Convite do Incorpóreo\" ×10! Comprar após as 9:00 de 30 de maio não concederá mais as recompensas exclusivas por tempo limitado.\n\nAtenção: \"memória eterna\" estará disponível para compra até 29 de junho, 9:00."
  },
  Activity_131849_BannerText = {
    Text = "Jornada Especial da Atividade por Tempo Limitado!"
  },
  Activity_132331_ActivityName = {
    Text = "Senhora de vermelho"
  },
  Activity_132331_ActivityTips = {
    Text = "<Title:Regras do Evento>\nDurante o evento \"Madame de Vermelho\", os Guardiões do segredo podem usar a formação predefinida do sistema que inclui \"Sorel\" para experimentar as Fases designadas um número ilimitado de vezes.\nAo experimentar as Fases do evento, os Corpos Despertos na formação não podem ser ajustados.\n<Title:Recompensas do Evento>\nApós completar o desafio de uma Fase pela primeira vez, você pode reivindicar as recompensas de teste na interface do evento."
  },
  Activity_132332_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_132333_ActivityName = {
    Text = "Revolução do Rei Divino"
  },
  Activity_132333_ActivityPlot = {
    Text = "No desejo interminável de desejos, desperta brevemente em seu longo sono e lança um olhar real para este mundo esmaecido.\nNa vida eterna, este olhar é tão breve"
  },
  Activity_132333_ActivityStageEndContent = {
    Text = "O evento terminou. Atualmente, apenas \"Abismo da Consciência\" está disponível."
  },
  Activity_132333_ActivityTips = {
    Text = "<Title:Descrição da Atividade>\n1,Durante o período da atividade, os Guardiões do Segredo podem coletar a moeda da atividade \"Pensamentos cansados\", \"Pensamentos melancólicos\" e \"Pensamentos alegres\" através das jogabilidades limitadas \"Olhar do Mar Profundo\" e \"Recompensa de conquista\". A moeda da atividade pode ser usada para comprar produtos em \"Abismo do mar da percepção\", incluindo a roda de destino SR limitada da atividade \"Trono de Pedra Azul\", Núcleo de Lumen, Núcleo Imaculado, Fragmentos de Pedra Sábia, Cristal de Mimese, entre outros. \n2,Durante o período da atividade, ao completar conquistas da atividade, você também pode ganhar o ícone de avatar limitado da atividade \"Por nome da Chave de Prata: Tulu\", a roda de destino SR limitada da atividade \"Trono de Pedra Azul\", Núcleo de prata e uma grande quantidade de moedas da atividade! \n\n<Title:Tempo da Atividade>\n1,6 de abril às 9:00 - 4 de maio às 9:00 (GMT+8), todas as jogabilidades da atividade podem ser participadas. \n2,4 de maio às 9:00 - 11 de maio às 9:00 (GMT+8), apenas \"Abismo do mar da percepção\" e Recompensa de conquista podem ser participados. \n\n<Title:Olhar do Mar Profundo>\n1,\"Olhar do Mar Profundo\" possui 5 fases, sendo que uma nova fase é automaticamente desbloqueada a cada 2 dias. \n2,Cada desafio consumirá \"Lingfétide\" × 120, e ao vencer o desafio, você ganhará a moeda da atividade. \n3,Após completar uma fase, a função de \"Reproduzir\" dessa fase será desbloqueada. Atenção: ao usar a função \"Reproduzir\", você não poderá ganhar a Taxa de Sincronização. \n4,Você pode usar o apoio da associação de ex-alunos para ajudá-lo a passar pelas fases mais facilmente. \n\n<Title:Aumento dos Pensamentos>\n1,Os Guardiões do Segredo que possuírem um corpo desperto ou roda de destino específicos (não é necessário estar em combate) podem fazer com que a moeda da atividade nas recompensas das missões da fase \"Olhar do Mar Profundo\" ganhe um aumento adicional na queda, conforme detalhado abaixo: \n· Corpo Desperto \"Tulu\": Despertar 0/1/2/3 e acima, aumento de 20%/30%/40%/50%. \n· Roda de Destino SSR \"Hino do Soberano\": Posição sobreposta 0/1/2/3 e acima, aumento de 20%/30%/40%/50%. \n· Roda de Destino SR \"Trono de Pedra Azul\": Posição sobreposta 0/1/2/3 e acima, aumento de 20%/30%/40%/50%. \n2,Os \"Aumentos dos Pensamentos\" de diferentes corpos despertos ou rodas de destino são calculados de forma acumulativa. \n3,Notavelmente, a recompensa do primeiro desafio na dificuldade de loucura não será afetada pelos \"Aumentos dos Pensamentos\". \n\n<Title:Abismo do Mar da Percepção>\n1,O \"Abismo do mar da percepção\" estará disponível apenas entre 6 de abril às 9:00 e 11 de maio às 9:00 (GMT+8). \n2,Após 11 de maio às 9:00 (GMT+8), as \"Pensamentos cansados\", \"Pensamentos melancólicos\" e \"Pensamentos alegres\" não trocadas restantes serão recuperadas na proporção de cada troca de \"Cupom de ouro rosa\" × 40, por favor, os Guardiões do Segredo fiquem atentos ao e-mail. \n\n<Title:Navegação na Consciência>\n1,Durante o período da atividade, \"Navegação na consciência: Dia da Coroação\" pode ser desbloqueada gratuitamente. \n2,Após o término da atividade, o progresso da investigação de \"Navegação na consciência: Dia da Coroação\" será mantido, e ao completar eventos de investigação não concluídos durante o período da atividade, você também poderá obter recompensas de investigação consistentes com o período da atividade. Se \"Navegação na consciência: Dia da Coroação\" não foi desbloqueada durante o período da atividade, ainda será possível desbloqueá-la após o término da atividade consumindo \"Ponto de partida real\" × 3. \n3,Independentemente de estar ou não durante o período da atividade, ao completar \"Navegação na consciência: Dia da Coroação\", você poderá obter \"Ordem de chave: Bênção das Estrelas\". \n\n<Title:Compensação de Recriação>\n1,Os Guardiões do Segredo que já desbloquearam \"Navegação na consciência: Dia da Coroação\" receberão uma compensação de \"Pensamentos cansados\" × 300 ao desbloqueá-la novamente durante este evento de recriação. \n2,Os Guardiões do Segredo que já obtiveram o ícone de avatar limitado da atividade \"Por nome da Chave de Prata: Tulu\", ao recebê-lo novamente, serão automaticamente convertidos em \"Convite do Incorpóreo\" × 1."
  },
  Activity_132333_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_132334_ActivityName = {
    Text = "Soberano adormecido"
  },
  Activity_132334_ActivityTips = {
    Text = "<Title:Regras do Evento>\nDurante o evento \"O Senhor Adormecido\", os Guardiões do segredo podem usar a formação predefinida do sistema contendo \"Tulu\" para experimentar as fases designadas um número ilimitado de vezes.\nDurante as fases de teste, os Corpos Despertos na Formação não podem ser ajustados.\n<Title:Recompensas do Evento>\nApós completar o desafio da fase pela primeira vez, as recompensas de teste podem ser reivindicadas na interface do evento."
  },
  Activity_132688_ActivityName = {
    Text = "Mudança de Comunicações"
  },
  Activity_132688_ActivityTips = {
    Text = "<Title:Introdução da Atividade>\n 1, Após o Guardião concluir as tarefas designadas da atividade, poderá coletar o \"Núcleo de Lumen\", o avatar limitado da atividade \"Winkle·Terminal de Grande Porte\",\"Erica·Terminal Portátil\" e \"Coleção de Selos: Guardião\", além de recompensas limitadas da atividade como a nova Fantasia de 1 estrela \"Nautila·Reminiscência Involuta\",\"Helot·Momento de Quebra\" e muito mais! \n 2, Esta atividade é permanente. Após concluir todas as tarefas da atividade e coletar todas as recompensas, a atividade será encerrada e não será mais exibida após as 9:00 do dia seguinte(GMT+8).\n 3, Se as tarefas \"Fazer login usando PC\" ou \"Fazer login usando dispositivo móvel\" já foram concluídas anteriormente na função de recompensas de login, elas não serão contabilizadas novamente como concluídas aqui."
  },
  Activity_132908_ActivityName = {
    Text = "Texto temporário"
  },
  Activity_132908_ActivityTips = {
    Text = "Regras do Evento:\n1. Após completar as missões de Jornada designadas, os Guardiões do Segredo podem resgatar recompensas em\"Texto Temporário\".\n2. Após desbloquear a\"Jornada Avançada\", ao completar as missões, você poderá resgatar recompensas adicionais.\n3. A compra da\"Jornada Avançada\"desta vez possui prazo limitado e não poderá mais ser adquirida após o vencimento. Guardiões do Segredo, por favor realizem a compra antes de 20 de maio às 9:00.\n6. Atenção: a\"Jornada Avançada\"desbloqueada neste evento é válida apenas para este evento. Guardiões do Segredo, por favor consumam de forma racional."
  },
  Activity_132908_BannerText = {
    Text = "Jornada Especial da Atividade por Tempo Limitado!"
  },
  Activity_132934_ActivityName = {
    Text = "Beijo de Gancho do Funeral"
  },
  Activity_132934_ActivityTips = {
    Text = "<Title:Introdução>\n·Durante o evento, após o Guardião concluir os objetivos designados, poderá resgatar as recompensas correspondentes em \"Beijo de Gancho do Funeral\"."
  },
  Activity_132934_BannerText = {
    Text = "Receba gratuitamente a Roupa Fantasma!"
  },
  Activity_133271_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_133272_ActivityName = {
    Text = "A Grande Conquista: Atividade Despertar Reedição"
  },
  Activity_133272_ActivityPlot = {
    Text = "Uma grande era talvez acabe perecendo, mas a vontade destes bravos guerreiros jamais desaparecerá. \nLápides não podem enterrá-los, correntes não conseguem domá-los. \nQuando uma nova jornada surge, suculentas carnes assadas os aguardam ao final do caminho da conquista; os guerreiros avançam em carga, recolhendo como presa a glória que lhes é devida. \nCantemos então a esta coragem imortal, cantemos ao sagrado império! \nRoma! Roma!"
  },
  Activity_133272_ActivityStageEndContent = {
    Text = "Evento encerrado, disponível apenas para \"Oferecer tributo\""
  },
  Activity_133272_ActivityTips = {
    Text = "<Title:Visão Geral do Evento>\n1. Durante o evento, Guardiões do segredo podem coletar a moeda do evento \"Delicioso churrasco de Leão\" através da jogabilidade por tempo limitado \"Caça Divina.\" \"Delicioso churrasco de Leão\" pode ser usado em \"Oferecer tributo\" para comprar itens, incluindo Núcleo do Vazio, Núcleo Imaculado, e mais.\n2. Durante o evento, \"Visão de Sonhos Estranhos: Conquista da Cozinha\" está temporariamente desbloqueado gratuitamente.\n\n<Title:Período do Evento>\n1. 4 de Maio, 9:00 – 18 de Maio, 9:00 (GMT+8): Toda a jogabilidade do evento está disponível.\n2. 18 de Maio, 9:00 – 25 de Maio, 9:00 (GMT+8): Apenas \"Oferecer tributo\" e Recompensa de conquista estão disponíveis.\n\n<Title:Caça Divina>\n1. \"Caça Divina\" contém 5 fases, com 1 fase desbloqueada automaticamente a cada 2 dias.\n2. Cada desafio consome Menophin × 120, e completar um desafio com sucesso recompensa moeda do evento.\n3. Após concluir uma fase, a função \"Reencenar\" daquela fase será desbloqueada. Atenção: Afinidade não pode ser obtida ao usar a função \"Reencenar\".\n4. Você pode usar o Apoio de batalha de Ex-alunos para ajudá-lo a concluir fases mais facilmente.\n\n<Title: Oferecer tributo>\nNa loja \"Oferecer tributo,\" você pode usar a moeda do evento \"Delicioso churrasco de Leão\" para selecionar e comprar itens diretamente.\n\n<Title:Visão de Sonhos Estranhos>\n1. Durante o evento, \"Visão de Sonhos Estranhos: Conquista da Cozinha\" pode ser desbloqueado gratuitamente.\n2. Após o término do evento, o progresso de investigação de \"Visão de Sonhos Estranhos: Conquista da Cozinha\" será mantido. Completar quaisquer Investigação de eventos inacabadas durante o evento ainda recompensará as mesmas recompensas de investigação do evento. Se \"Visão de Sonhos Estranhos: Conquista da Cozinha\" não foi desbloqueado durante o evento, ainda pode ser desbloqueado após o término do evento consumindo \"Ponto de partida real\" × 7.\n3. Independentemente de ser durante o período do evento, concluir \"Visão de Sonhos Estranhos: Conquista da Cozinha\" recompensará \"Posse: Resolução Voraz.\""
  },
  Activity_133272_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_133301_ActivityName = {
    Text = "L'Heure du Thé"
  },
  Activity_133301_ActivityTips = {
    Text = "<Title:Regras do Evento>\n1. Após completar tarefas designadas do Diário do Guardião do Segredo, Guardiões do segredo podem reivindicar recompensas em \"L'Heure du Thé.\"\n2. \"L'Heure du Thé\" terminará em 18 de Maio às 9:00.\n3. Desbloqueie \"Arquivo Avançado\" para reivindicar recompensas extras ao completar tarefas.\n4. Atenção: O \"Arquivo Avançado\" desbloqueado neste evento é válido apenas para este evento. Guardiões do segredo, por favor, consumam racionalmente."
  },
  Activity_133301_BannerText = {
    Text = "Jornada Especial da Atividade por Tempo Limitado!"
  },
  Activity_134393_ActivityName = {
    Text = "Ex Stellaris"
  },
  Activity_134393_ActivityPlot = {
    Text = "Faça login diariamente para reivindicar a Roda do destino SSR comemorativa de tempo limitado \"Ex Stellaris,\" até 16 no total!"
  },
  Activity_134393_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento, Guardiões do segredo podem fazer login diariamente para reivindicar a Roda do destino SSR comemorativa de tempo limitado \"Para as estrelas\" em \"Para as estrelas,\" totalizando 16 reivindicações.\n·As recompensas serão desbloqueadas sequencialmente com base nos logins acumulados do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_134393_BannerText = {
    Text = "Roda do destino SSR Limitada Grátis"
  },
  Activity_138582_ActivityName = {
    Text = "Corte das Flores"
  },
  Activity_138582_ActivityTips = {
    Text = "<Title:Regras do Evento>\n1. Após completar missões de arquivo especificadas, Guardiões do segredo podem reivindicar recompensas na \"Corte das Flores.\"\n2. \"Corte das Flores\" terminará em 15 de Junho, 09:00.\n3. Após desbloquear \"Arquivo Avançado,\" recompensas adicionais podem ser reivindicadas ao completar missões.\n4. Atenção: O \"Arquivo Avançado\" desbloqueado neste evento é válido apenas para este evento. Por favor, gaste com sabedoria a seu critério."
  },
  Activity_138582_BannerText = {
    Text = "Jornada Especial da Atividade por Tempo Limitado!"
  },
  Activity_139116_ActivityName = {
    Text = "Encontro Onírico"
  },
  Activity_139116_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Guardiões do segredo podem reivindicar recompensas do \"Encontro Onírico\" após concluir tarefas designadas.\n·Após desbloquear o \"Arquivo Avançado,\" recompensas adicionais podem ser reivindicadas ao concluir tarefas.\n·Há um limite de tempo para a compra do \"Arquivo Avançado\" desta vez. Não será possível comprá-lo após o prazo. Por favor, compre a seu critério antes de 29 de junho, 9:00 (GMT+8).\n·Atenção: O \"Arquivo Avançado\" desbloqueado durante este evento é válido apenas para este evento. Recomenda-se que os Guardiões do segredo gastem com sabedoria."
  },
  Activity_139116_BannerText = {
    Text = "Resgate um novo Corpo Desperto limitado de graça!"
  },
  Activity_139117_ActivityName = {
    Text = "Oferenda Onírica"
  },
  Activity_139117_ActivityTips = {
    Text = "<Title:Introdução>\n·Durante o evento, após concluir objetivos específicos, Guardiões do segredo podem reivindicar recompensas correspondentes em \"Oferenda Onírica.\""
  },
  Activity_139117_BannerText = {
    Text = "Resgate Sonhos Residuais das Estrelas grátis!"
  },
  Activity_139591_ActivityName = {
    Text = "Miau Obrigado!"
  },
  Activity_139591_ActivityPlot = {
    Text = "\"Aviso de emergência: Todos os professores e alunos, por favor, interrompam suas tarefas atuais imediatamente e ajudem a capturar os sujeitos de teste que escaparam.\"\n\"Repito: Todos os professores e alunos, por favor, interrompam suas tarefas atuais imediatamente e ajudem a capturar os que escaparam—Droga! Os gatos entraram!\"\n\nQuando você ouviu a voz em pânico pelo alto-falante, todo o campus já havia sido engolido por pelos negros, e todos estavam atrapalhados tentando capturar esses pequenos encrenqueiros que escaparam do laboratório.\nComo se buscando vingança pela Festa de Oração, esses gatos negros estavam lenta e metodicamente convergindo para o seu dormitório.\n\nMas, pensando bem... considerando a grande quantidade de Cupom de ouro rosa e Núcleo de prata que eles carregam, é difícil dizer se vieram para se vingar ou para retribuir o favor.\nMas cuidado para não capturá-los em excesso."
  },
  Activity_139591_ActivityStageEndContent = {
    Text = "Evento encerrado"
  },
  Activity_139591_ActivityTips = {
    Text = "<Title: Miau Obrigado!>\nMiau Obrigado! apresenta 7 fases únicas e não repetíveis que devem ser desafiadas diretamente. Uma nova fase é desbloqueada a cada dia.\nDerrotar o \"Gato Negro Dimensional\" correspondente em cada desafio contribui para o progresso do evento. As recompensas podem ser reivindicadas através do \"Registro de Captura de gato\".\nCada \"Gato Negro Dimensional\" possui inúmeras cópias—os desafios podem ser tentados ilimitadamente durante o evento e suportam batalha automática.\nCada fase fornece diferentes Criações que concedem bônus poderosos.\nTodas as fases requerem um Guardião de Apoio de batalha. Durante o evento, cada Guardião mutuamente seguido só pode fornecer apoio a você uma vez.\n\n\n<Title: Compensação de Nível>\nMiau Obrigado! inclui um sistema de compensação de nível para que todos os Guardiões do segredo possam lutar lado a lado!\nAs regras de compensação são as seguintes:\nCorpos Despertos na sua equipe abaixo do nível 60 serão compensados para o nível 60 durante o desafio.\nCorpos Despertos na sua equipe com níveis de habilidade abaixo de 5 serão compensados para o nível de habilidade 5 durante o desafio.\nCorpos Despertos na sua equipe com Sinais Loucos abaixo do nível 6 serão compensados para o nível 6 durante o desafio.\nCorpos Despertos na sua equipe com Adaptabilidade de forma espiritual abaixo do nível 5 serão compensados para o nível 5 durante o desafio.\nGuardiões do segredo abaixo do nível 60 serão compensados para o nível 60 durante o desafio.\n\n<Title: Registro de Captura de Gato Negro>\nDurante o evento, derrotar o \"Gato Negro Dimensional\" correspondente acumula progresso de missão, permitindo que os Guardiões do segredo reivindiquem recompensas através do \"Registro de Captura de gato\". O Registro é dividido em duas seções: \"Registro de Captura Pessoal\" e \"Registro de Captura do Campus\". O \"Registro de Captura Pessoal\" acompanha o progresso individual de cada Guardião. O \"Registro de Captura do Campus\" acompanha o progresso combinado de todos os Guardiões do segredo em todo o campus.\n\n<Title: Rankings de Captura>\nDurante o evento, os Guardiões do segredo podem visualizar o \"Ranking de Guardiões\" e o \"Ranking de Suporte\" em \"Rankings de Captura\".\n\n<Title: Duração do Evento>\nOs Guardiões do segredo podem acessar a página do evento e participar do desafio antes das 9:00 de 15 de junho (GMT+8). Nenhum novo Guardião será admitido após esse horário. Guardiões do segredo que já entraram podem continuar participando se o evento ainda não tiver sido concluído.\nSe a \"Contagem Total de Capturas\" for alcançada antes das 9:00 de 15 de junho (GMT+8), o evento terminará em 29 de junho às 9:00 (GMT+8). Se a \"Contagem Total de Capturas\" não for alcançada até essa data, o evento terminará 14 dias após a \"Contagem Total de Capturas\" ser atingida."
  },
  Activity_139591_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_139922_ActivityName = {
    Text = "Shaggai hipnótico"
  },
  Activity_139922_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento \"Hypnotic Worm\", o Guardião pode usar equipes predefinidas pelo sistema que incluem Clementine para experimentar estágios especificados infinitamente.\n·Enquanto experimenta os estágios do evento, ajustes aos Despertadores na formação da equipe não podem ser feitos.\n<Title:Recompensas do Evento>\n·Após completar o desafio de estágio pela primeira vez, você pode reivindicar as recompensas de teste na interface do evento."
  },
  Activity_139923_ActivityName = {
    Text = "Sinfonia Imaterial"
  },
  Activity_139923_ActivityPlot = {
    Text = "A sinfonia é uma arte de tecer, onde as trajetórias dos instrumentos se entrelaçam.\nEm sua teia, cada nota tem seu papel.\nOuça, uma sinfonia magnífica está prestes a começar"
  },
  Activity_139923_ActivityStageEndContent = {
    Text = "Evento encerrado, apenas disponível para \"Palácio do Sono\""
  },
  Activity_139923_ActivityTips = {
    Text = "<Title:Introdução do Evento>\n1. Durante o evento, Guardiões do segredo podem coletar a moeda do evento \"Canto heroico\" através da jogabilidade por tempo limitado \"Som tonante\" e \"Conquistas.\" \"Canto heroico\" pode ser trocado por recompensas generosas no \"Palácio do Sono,\" incluindo a Roda do destino SR limitada do evento \"Desempenho Sem Fim,\" \"Núcleo Imaculado,\" \"Núcleo de Lumen,\" \"Fragmentos de Pedra Sábia,\" \"Cristal de Mimese,\" e mais.\n2. Durante o evento, completar missões de \"Conquistas\" concederá o avatar limitado do evento \"Em Nome da Chave de prata: Hameln,\" a Roda do destino SR limitada do evento \"Desempenho Sem Fim,\" Prata, e uma grande quantidade de moeda do evento \"Canto heroico.\"\n\n<Title:Duração do Evento>\n1. 15 de Junho, 9:00 – 13 de Julho, 9:00 (GMT+8): Todo o conteúdo do evento está disponível.\n2. 13 de Julho, 9:00 – 20 de Julho, 9:00 (GMT+8): Apenas \"Palácio do Sono\" e \"Conquistas\" permanecerão disponíveis. Todo o restante do conteúdo estará Concluído e não poderá ser acessado.\n\n<Title: Som tonante>\n1. \"Som tonante\" contém 9 Fases, com 1 abrindo automaticamente a cada dia.\n2. Cada tentativa de desafio custa Neurobrew × 120. Desafiar diferentes Fases concederá diferentes drops de materiais, bem como a moeda do evento \"Canto heroico.\"\n3. As Fases deste evento são Fases de materiais de combate direto. Após concluí-las, podem ser repetidas! Cada repetição custa Neurobrew × 120.\n4. Atenção: Ao usar a função de repetição, a Taxa de Sincronização não pode ser obtida.\n\n<Title: Bônus de Ária>\n1. Guardiões do segredo que possuem Corpos Despertos ou Rodas do destino específicos (não é necessário posicioná-los) podem receber drops bônus de \"Canto heroico\" das recompensas de missão de Fase de \"Som tonante\" (incluindo repetições). Os bônus específicos são os seguintes:\n·Corpo Desperto \"Hameln\": Despertar Espiritual 0/1/2/3 ou acima, bônus 20%/30%/40%/50%\n·Roda do destino SSR \"Réquiem Eterno\": Nível de empilhamento 0/1/2/3 ou acima, bônus 20%/30%/40%/50%\n·Roda do destino SR \"Desempenho Sem Fim\": Nível de empilhamento 0/1/2/3 ou acima, bônus 20%/30%/40%/50%\n2. \"Bônus de Ária\" de diferentes Corpos Despertos ou Rodas do destino é calculado de forma aditiva.\n3. Especificamente, as recompensas de primeiro Concluir da dificuldade de loucura não são afetadas pelo \"Bônus de Ária.\"\n\n<Title: Palácio do Sono>\n1. \"Palácio do Sono\" está aberto apenas de 15 de Junho, 9:00 – 13 de Julho, 9:00 (GMT+8).\n2. Após 20 de Julho, 9:00 (GMT+8), \"Canto heroico\" restantes não trocados serão convertidos à taxa de Cupom de ouro rosa × 40 por unidade. Por favor, verifique seu correio."
  },
  Activity_139923_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_139924_ActivityName = {
    Text = "Artista Eterno"
  },
  Activity_139924_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento \"Eternal Performer\", os Guardiões podem usar equipes predefinidas pelo sistema que incluem Hameln para experimentar níveis designados infinitamente.\n·Ao experimentar os níveis do evento, ajustes aos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_139925_ActivityName = {
    Text = "Senhora das profundezas"
  },
  Activity_139925_ActivityTips = {
    Text = "<Title:Regras do Evento>\n· Durante o evento \"Senhorita Aequor\", os Guardiães podem usar equipes pré-definidas pelo sistema que incluam Murphy para experimentar níveis designados infinitamente.\n· Durante a experiência do nível do evento, ajustes aos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n· Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_140080_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_140081_ActivityName = {
    Text = "A chama viva"
  },
  Activity_140081_ActivityTips = {
    Text = "<Title:Event Rules>\n· Durante o evento \"Senhor das Chamas Explosivas\", os Guardiões podem usar uma equipe pré-definida do sistema, incluindo Kathigu-Ra, para experienciar o nível especificado um número ilimitado de vezes.\n· Ao vivenciar os níveis do evento, ajustes nos Despertadores na equipe não podem ser feitos.\n<Title:Event Rewards>\n· Ao completar pela primeira vez o desafio de nível, você pode reivindicar recompensas de teste na interface do evento."
  },
  Activity_140082_ActivityName = {
    Text = "Mil Raios Brilhantes Descem·clon"
  },
  Activity_140082_ActivityPlot = {
    Text = "Eles cantam uma canção de lembrança eterna, saudando o Senhor que jamais se apagará. \n Ele descerá do alto céu carregado de incontáveis luzes, proclamando a glória que jamais desaparecerá. \n No momento de Sua chegada, a luz âmbar cobrirá o mundo. \n Este é o funeral que Ele oferece ao mundo."
  },
  Activity_140082_ActivityStageEndContent = {
    Text = "O evento foi Concluído. Atualmente, apenas \"Base Secreta\" está disponível."
  },
  Activity_140082_ActivityTips = {
    Text = "<Title:Introdução da atividade>\n1, Durante o período da atividade, os Guardiões podem coletar as moedas da atividade \"Selo da Riqueza\",\"Selo da Morte\" e \"Selo de Guerra\" através das mecânicas de tempo limitado \"Caça à Cinza\",\"A Festa Sem Conflitos\" e \"Recompensas de Conquista\".\"Selo da Riqueza\",\"Selo da Morte\" e \"Selo de Guerra\" podem ser usados para comprar itens em \"Base Secreta\", incluindo a Roda do destino SR limitada da atividade \"Sol Iminente\", Núcleo de Lumen, Núcleo Imaculado, entre outros.\n2, Durante o período da atividade,\"Dia Eterno e Imutável\" será desbloqueado gratuitamente por tempo limitado. Ao completar as conquistas da atividade, você também poderá obter o avatar limitado da atividade \"Por nome da Chave de Prata: Katie Gula\"!\n\n<Title:Período da atividade>\n1, 7 de setembro 9:00 - 5 de outubro 9:00(GMT+8), todas as mecânicas de atividade estão disponíveis.\n2, 5 de outubro 9:00 - 12 de outubro 9:00(GMT+8), apenas \"Base Secreta\" e as recompensas de conquista estão disponíveis.\n\n<Title:Caça à Cinza>\n1,\"Caça à Cinza\" contém 7 fases, com 1 fase desbloqueada automaticamente a cada 1 dia.\n2, Cada desafio consumirá\"Lingfétide\" × 120. Ao concluir o desafio com sucesso, você receberá moedas da atividade.\n3, Após concluir uma fase, a função \"Recriar\" dessa fase será desbloqueada. Atenção: ao usar a função \"Recriar\", não é possível obter Taxa de Sincronização.\n4, Você pode usar o Apoio de batalha da associação de ex-alunos para ajudá-lo a passar pelas fases com mais facilidade.\n\n<Title: Base Secreta>\n\"Base Secreta\" possui três lojas, com os seguintes horários de abertura:\n·\"Cofre de Coleção\": abre às 9h do dia 7 de setembro.\n·\"Sala de Comissões\": abre às 9h do dia 8 de setembro.\n·\"Acampamento de Combate\": abre às 9h do dia 9 de setembro.\nNa loja, você pode selecionar os itens e comprá-los diretamente.\n\n<Title:Bônus da atividade>\n1, Se o Guardião possuir determinados Corpos Despertos ou Rodas do destino(não é necessário colocá-los em campo), as recompensas das missões de fase de \"Caça à Cinza\" referentes a \"Selo da Riqueza\",\"Selo da Morte\" e \"Selo de Guerra\" receberão bônus de drop adicionais. Os bônus específicos são os seguintes:\n·Corpo Desperto \"Katie Gula\": Despertar Espiritual 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%.\n·Roda do destino SSR \"Morte âmbar\": Nível de empilhamento 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%.\n·Roda do destino SR \"Sol Iminente\": Nível de empilhamento 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%.\n2, O \"Bônus da atividade\" de diferentes Corpos Despertos ou Rodas do destino é calculado de forma acumulativa.\n3, Em especial, as recompensas do primeiro desafio concluído na dificuldade de loucura não serão afetadas pelo \"Bônus da atividade\".\n\n<Title: A Festa Sem Conflitos>\n1, A cada hora, você obtém automaticamente 60 \"Selo da Riqueza\", com capacidade máxima de armazenamento de 25 horas.\n\n<Title:Navegação na consciência>\n1, Durante o período da atividade,\"Dia Eterno e Imutável\" pode ser desbloqueado gratuitamente.\n2, Após o término da atividade, o progresso de investigação de \"Dia Eterno e Imutável\" será preservado. Ao concluir as investigações de eventos não concluídas durante o período da atividade, você também poderá obter as mesmas recompensas de investigação do período da atividade. Se \"Dia Eterno e Imutável\" não foi desbloqueado durante o período da atividade, ainda será possível desbloqueá-lo após o término da atividade consumindo \"Ponto de partida real\" ×3.\n3, Independentemente de estar ou não no período da atividade, após concluir \"Navegação na consciência: Dia Eterno e Imutável\", você poderá obter \"Ordem de chave: Sol Incrível\"."
  },
  Activity_140082_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_140188_ActivityName = {
    Text = "Corrente de Paixão"
  },
  Activity_140188_ActivityTips = {
    Text = "<Title:Introdução>\n·Durante o evento, após o Guardião ter extraído cumulativamente uma quantidade especificada de Líquido de Origem de Núcleo de Prata em \"Extração de líquido fonte,\" as recompensas correspondentes podem ser reivindicadas em \"Corrente de Paixão.\"\n·Por favor, note que o Líquido de Origem de Núcleo de Prata presenteado em \"Extração de líquido fonte\" não será contabilizado na quantidade cumulativa de extração de Líquido de Origem de Núcleo de Prata do evento."
  },
  Activity_140188_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_140462_ActivityName = {
    Text = "Prólogo de Todas as Coisas"
  },
  Activity_140462_ActivityTips = {
    Text = "<Title:Introdução>\n·Durante o evento, após completar os objetivos especificados, os Guardiões do segredo podem reivindicar as recompensas correspondentes em \"Prólogo da Natureza.\""
  },
  Activity_140462_BannerText = {
    Text = "Receba gratuitamente a Roupa Fantasma!"
  },
  Activity_140760_ActivityName = {Text = "Pólux"},
  Activity_140760_ActivityTips = {
    Text = "<Title:Regras do evento>\n· Durante o evento \"Pólux\", os Guardiões do Segredo podem usar equipes predefinidas pelo sistema que incluam Pólux para experimentar ilimitadamente as fases designadas.\n· Ao experimentar as fases do evento, não é possível ajustar os Corpos Despertados na formação da equipe.\n<Title:Recompensas do evento>\n· Após completar o desafio da fase pela primeira vez, é possível coletar a recompensa de teste na interface do evento.\n"
  },
  Activity_140761_ActivityName = {
    Text = "Brilho de Mareel"
  },
  Activity_140761_ActivityTips = {
    Text = "<Title:Regras do Evento>\n· Durante o evento \"Luz Fria\", os Guardiães podem usar equipes pré-configuradas que incluem o Kepler Sanga para experimentar níveis designados um número ilimitado de vezes.\n· Ao experienciar os níveis do evento, não podem ser feitos ajustes aos Despertadores dentro da formação da equipe.\n<Title:Recompensas do Evento>\n· Após completar um desafio de nível pela primeira vez, você pode reclamar recompensas de teste na interface do evento."
  },
  Activity_140762_ActivityName = {Text = "Matsuka"},
  Activity_140762_ActivityTips = {
    Text = "<Title:Regras do Evento>\n· Durante o evento \"Aurora Selada\", os Guardiões podem usar formações pré-definidas pelo sistema que incluem Mouchette para experimentar os estágios designados um número ilimitado de vezes.\n· Ao experimentar os estágios do evento, ajustes aos Despertadores na formação não podem ser feitos.\n<Title:Recompensas do Evento>\n· Após completar o desafio do estágio pela primeira vez, você pode reivindicar recompensas de teste na interface do evento."
  },
  Activity_140763_ActivityName = {
    Text = "Poema Sem Nome"
  },
  Activity_140763_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento \"Poema Sem Nome\", os Guardiões podem usar equipes presetadas pelo sistema que incluem Horla para experimentar níveis designados infinitamente.\n·Enquanto experimenta os níveis do evento, ajustes nos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_140764_ActivityName = {
    Text = "Senhor de necrovia"
  },
  Activity_140764_ActivityTips = {
    Text = "<Title:Event Rules>\n· Durante o evento \"Senhor dos Sepultamentos\", os Guardiões podem usar uma equipe preset do sistema, incluindo Durusain, para experimentar o nível especificado um número ilimitado de vezes.\n· Ao experimentar os níveis do evento, não é permitido fazer ajustes nos Despertadores na formação.\n<Title:Event Rewards>\n· Ao completar o desafio de nível pela primeira vez, você pode reivindicar recompensas de teste na interface do evento."
  },
  Activity_141306_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_141306_ActivityPlot = {
    Text = "Após a compra, \"Pontos\" pode ativar <BlueQuality:Despertar Espiritual 3>"
  },
  Activity_141307_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_141307_ActivityPlot = {
    Text = "Após a compra, \"Pontos\" pode ativar\n<BlueQuality:Desenvolvimento da personalidade +4, desbloquear Superexaltação>"
  },
  Activity_141308_ActivityName = {
    Text = "Fonte do Abismo"
  },
  Activity_141308_ActivityTips = {
    Text = "<Title:Regras do Evento>\nDurante o evento \"Fonte do Abismo\", os Guardiões do segredo podem usar a Formação predefinida pelo sistema que inclui Pontos para experimentar as Fases designadas sem limite de vezes.\nAo experimentar as Fases do evento, os Corpos Despertos da Formação não podem ser ajustados.\n<Title:Recompensas do Evento>\nDepois de concluir o desafio de uma Fase pela primeira vez, as recompensas de demonstração podem ser recebidas na interface do evento."
  },
  Activity_141460_ActivityName = {
    Text = "Divus: a pena Ônix"
  },
  Activity_141460_ActivityTips = {
    Text = "<Title:Regras do Evento>\n· Durante o evento \"Asas Negras Sagradas\", os Guardiões podem usar a equipe pré-setada do sistema contendo Castor para vivenciar estágios específicos indefinidamente.\n· Os Despertadores na Escala de Equipe não podem ser ajustados durante os estágios do evento.\n<Title:Recompensas do Evento>\n· Após alcançar um desafio de estágio pela primeira vez, uma recompensa de teste pode ser reivindicada na interface do evento."
  },
  Activity_141462_ActivityName = {
    Text = "Soberano adormecido"
  },
  Activity_141462_ActivityTips = {
    Text = "<Title:Event Rules>\n·Durante o evento \"Soberano do Sono\", os Guardiães podem usar equipes pré-definidas pelo sistema que incluem Tulu para experimentar níveis designados infinitamente.\n·Ao experimentar níveis do evento, ajustes aos Despertadores na formação da equipe não são permitidos.\n<Title:Event Rewards>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_141464_ActivityName = {
    Text = "A Matriarca Obsidiana dos Mil Fãs"
  },
  Activity_141464_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento \"Matriarca Obsidiana dos Mil Ventos\", os Guardiões podem usar formações pré-definidas pelo sistema que incluem Xu para experimentar os estágios designados um número ilimitado de vezes.\n·Ao experimentar os estágios do evento, ajustes aos Despertadores na formação não são permitidos.\n<Title:Recompensas do Evento>\n·Após completar com sucesso o desafio do estágio pela primeira vez, você pode reivindicar recompensas de teste na interface do evento."
  },
  Activity_141466_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_141467_ActivityName = {
    Text = "Prisioneiro Espelho·clon"
  },
  Activity_141467_ActivityPlot = {
    Text = "Pássaro, pássaro, por que há algemas partidas em seus pés?\nPássaro, pássaro, por que você canta solitariamente nas alturas?\nLivre-se dos espinhos, fuja da gaiola, você voa sobre as areias infinitas, mas seu canto triste não cessa. Afinal, quem é o companheiro fiel que você procura? Afinal, onde fica a verdadeira terra natal que você busca?"
  },
  Activity_141467_ActivityStageEndContent = {
    Text = "Evento encerrado, disponível apenas para \"Desejo de Sabedoria\""
  },
  Activity_141467_ActivityTips = {
    Text = "<Title:Introdução da atividade>\n1, Durante o período da atividade, os Guardiões podem coletar as moedas da atividade \"Livro de senso comum\",\"Livro de Matemática\" e \"Livro de literatura\" através das mecânicas de tempo limitado \"Salto pelo Céu Azul\",\"Crucero Onírico\" e \"Recompensas de Conquista\".\"Livro de senso comum\",\"Livro de Matemática\" e \"Livro de literatura\" podem ser usados para comprar itens em \"Desejo de conhecimento\", incluindo a Roda do destino SR limitada da atividade \"Pena Solitária\", Núcleo de Lumen, Núcleo Imaculado, entre outros.\n2, Durante o período da atividade,\"Visão de Sonhos Estranhos: Além do horizonte·Cima\" será desbloqueado gratuitamente por tempo limitado. Ao completar as conquistas da atividade, você também poderá obter o avatar limitado da atividade \"Por nome da Chave de Prata: Castor\"!\n\n<Title:Período da atividade>\n1, 5 de outubro 9:00 - 2 de novembro 9:00(GMT+8), todas as mecânicas de atividade estão disponíveis.\n2, 2 de novembro 9:00 - 9 de novembro 9:00(GMT+8), apenas \"Desejo de conhecimento\" e as recompensas de conquista estão disponíveis.\n\n<Title:Salto pelo Céu Azul>\n1,\"Salto pelo Céu Azul\" contém 7 fases, com 1 fase desbloqueada automaticamente a cada 1 dia.\n2, Cada desafio consumirá\"Lingfétide\" × 120. Ao concluir o desafio com sucesso, você receberá moedas da atividade.\n3, Após concluir uma fase, a função \"Recriar\" dessa fase será desbloqueada. Atenção: ao usar a função \"Recriar\", não é possível obter Taxa de Sincronização.\n4, Você pode usar o Apoio de batalha da associação de ex-alunos para ajudá-lo a passar pelas fases com mais facilidade.\n\n<Title: Desejo de conhecimento>\n\"Desejo de conhecimento\" possui três lojas, com os seguintes horários de abertura:\n·\"Disciplinas eletivas gerais\": abre às 9h do dia 5 de outubro.\n·\"Classe optativa de ciências\": abre às 9h do dia 6 de outubro.\n·\"Classe optativa de literatura\": abre às 9h do dia 7 de outubro.\nNa loja, você pode selecionar os itens e comprá-los diretamente.\n\n<Title:Bônus da atividade>\n1, Se o Guardião possuir determinados Corpos Despertos ou Rodas do destino(não é necessário colocá-los em campo), as recompensas das missões de fase de \"Salto pelo Céu Azul\" referentes a \"Livro de senso comum\",\"Livro de Matemática\" e \"Livro de literatura\" receberão bônus de drop adicionais. Os bônus específicos são os seguintes:\n·Corpo Desperto \"Castor\": Despertar Espiritual 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%.\n·Roda do destino SSR \"Liberdade Inquebrável\": Nível de empilhamento 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%.\n·Roda do destino SR \"Pena Solitária\": Nível de empilhamento 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%.\n2, O \"Bônus da atividade\" de diferentes Corpos Despertos ou Rodas do destino é calculado de forma acumulativa.\n3, Em especial, as recompensas do primeiro desafio concluído na dificuldade de loucura não serão afetadas pelo \"Bônus da atividade\".\n\n<Title: Crucero Onírico>\n1, A cada hora, você obtém automaticamente 60 \"Livro de senso comum\", com capacidade máxima de armazenamento de 25 horas.\n\n<Title:Visão de Sonhos Estranhos>\n1, Durante o período da atividade,\"Visão de Sonhos Estranhos: Além do horizonte·Cima\" pode ser desbloqueado gratuitamente.\n2, Após o término da atividade, o progresso de investigação de \"Visão de Sonhos Estranhos: Além do horizonte·Cima\" será preservado. Ao concluir as investigações de eventos não concluídas durante o período da atividade, você também poderá obter as mesmas recompensas de investigação do período da atividade. Se \"Visão de Sonhos Estranhos: Além do horizonte·Cima\" não foi desbloqueado durante o período da atividade, ainda será possível desbloqueá-lo após o término da atividade consumindo \"Ponto de partida real\" ×7.\n3, Independentemente de estar ou não no período da atividade, após concluir \"Visão de Sonhos Estranhos: Além do horizonte·Cima\", você poderá obter \"Ordem de chave: Desvio do Destino\"."
  },
  Activity_141467_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_141509_ActivityName = {
    Text = "Diário de Viagem Secreto"
  },
  Activity_141509_ActivityTips = {
    Text = "<Title:Regras da atividade>\n1, Após o Guardião concluir as missões de arquivo designadas, é possível receber recompensas em \"Diário de Viagem Secreto\".\n2,\"Diário de Viagem Secreto\" será encerrado em 27 de julho às 09:00.\n3, Após desbloquear o \"Arquivo Avançado\", é possível receber recompensas adicionais após concluir as missões.\n4, Atenção: o \"Arquivo Avançado\" desbloqueado nesta atividade só é válido para esta atividade. Os Guardiões devem consumir com moderação e bom senso."
  },
  Activity_141509_BannerText = {
    Text = "Jornada Especial da Atividade por Tempo Limitado!"
  },
  Activity_141533_ActivityName = {
    Text = "Ebwynnos Evermore"
  },
  Activity_141533_ActivityPlot = {
    Text = "Vamos rir em voz alta, vamos celebrar a noite toda.\nVamos cravar nossas garras na garganta dos inimigos, e deixar os dias comuns enferrujar no abismo.\nNunca mais seremos capturados pela velhice, pela mediocridade e pela solidão.\nEste é Ebwynnos, onde somos eternamente felizes, eternamente reunidos.\nNunca nos separaremos."
  },
  Activity_141533_ActivityStageEndContent = {
    Text = "Evento Concluído. Atualmente, apenas \"Terrenos de Caça\" está disponível."
  },
  Activity_141533_ActivityTips = {
    Text = "<Title:Introdução da atividade>\n1, Durante a atividade, os Guardiões podem coletar as moedas da atividade \"\" Presa \" Fresca\",\"\" Presa \" Colossal\" e \"\" Presa \" Primordial\" através do modo de jogo por tempo limitado \"A Grande Caçada da Casa\" e das \"Recompensas de Conquista\", e trocá-las em \"Terrenos de Caça\" por produtos, incluindo a Roda do destino SR limitada da atividade \"A Bússola Errante\", Núcleo de Lumen, Núcleo Imaculado, entre outros.\n2, Durante a atividade,\"Navegação na consciência: Ebwynnos Evermore\" estará disponível gratuitamente por tempo limitado. Ao completar as conquistas da atividade, também é possível obter o avatar limitado da atividade \"Por nome da Chave de Prata: Pontos\"!\n\n<Title:Período da atividade>\n1, 29 de junho, 9:00 - 27 de julho, 9:00(GMT+8), todos os modos de jogo da atividade estão disponíveis para participação.\n2, 27 de julho, 9:00 - 3 de agosto, 9:00(GMT+8), apenas \"Terrenos de Caça\" e Recompensas de Conquista estão disponíveis.\n\n<Title:A Grande Caçada da Casa>\n1,\"A Grande Caçada da Casa\" contém 7 Fases, sendo 1 desbloqueada automaticamente por dia.\n2, Cada desafio consumirá\"Lingfétide\" × 120. Ao concluir o desafio com sucesso, você obterá moedas da atividade.\n3, Após Concluir a Fase, a função \"Recriar\" dessa Fase será desbloqueada. Atenção: ao usar a função \"Recriar\", não é possível obter Taxa de Sincronização.\n4, Você pode usar o Apoio de batalha da associação de ex-alunos para ajudá-lo a passar as Fases com mais facilidade.\n\n<Title: Terrenos de Caça>\n\"Terrenos de Caça\" possui três lojas, com os seguintes horários de abertura:\n·\"Ferro Frio\": abre às 9h do dia 29 de junho.\n·\"Fogo e Enxofre\": abre às 9h do dia 30 de junho.\n·\"Feitiçaria\": abre às 9h do dia 1 de julho.\nNas lojas, é possível selecionar produtos e comprá-los diretamente.\n\n<Title:Bônus da atividade>\n1, Guardiões que possuam determinados Corpos Despertos ou Rodas do destino(não é necessário colocá-los em campo) podem obter bônus adicionais de queda das três moedas da atividade nas recompensas de missões de Fase de \"A Grande Caçada da Casa\":\n·Corpo Desperto \"Pontos\": Despertar Espiritual 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%.\n·Roda do destino SSR \"Gaiola Viva\": Nível de empilhamento 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%.\n·Roda do destino SR \"A Bússola Errante\": Nível de empilhamento 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%.\n2, O \"Bônus da atividade\" de diferentes Corpos Despertos ou Rodas do destino é calculado de forma acumulada.\n3, Em especial, as recompensas da primeira conclusão do desafio de dificuldade de loucura não serão afetadas pelo \"Bônus da atividade\".\n\n<Title:Navegação na consciência>\n1, Durante a atividade,\"Navegação na consciência: Ebwynnos Evermore\" pode ser desbloqueada gratuitamente.\n2, Após o término da atividade, o progresso de investigação será Preservado. Os eventos de investigação não concluídos durante a atividade podem ser concluídos após a atividade e também renderão as recompensas correspondentes. Se não for desbloqueada durante a atividade, ainda será possível desbloqueá-la após o término da atividade consumindo \"Ponto de partida real\" × 3.\n3, Independentemente de estar ou não no período da atividade, após Concluir \"Navegação na consciência: Ebwynnos Evermore\", é possível obter \"Ordem de chave: Homem vazio\"."
  },
  Activity_141533_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_141534_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_141535_ActivityName = {
    Text = "Verão Eterno sob o Sol Negro·clon"
  },
  Activity_141535_ActivityPlot = {
    Text = "Verão, praia, sol brilhante e muitos rostos familiares.\nSob o brilho do Sol Negro, esqueça tudo e afunde-se nesta festa de sonhos que satisfaz todas as fantasias."
  },
  Activity_141535_ActivityTips = {
    Text = "<Title:Introdução da atividade>\n1, Durante a atividade,\"Visão de Sonhos Estranhos: Adeus, Terra do Nunca\" estará disponível gratuitamente por tempo limitado!\n2, Durante a atividade, ao fazer login por 7 dias acumulados, é possível obter \"Núcleo de Lumen\" × 10 em \"Festa de Verão sem Fim\". No 7º dia, é possível obter adicionalmente o avatar de batalha limitado \"Vôlei 'Grande General'\".\n\n<Title:Período da atividade>\n1, 6 de julho, 9:00 - 20 de julho, 9:00(GMT+8), todas as atividades estão disponíveis para participação.\n\n<Title:Visão de Sonhos Estranhos>\n1, Durante a atividade,\"Visão de Sonhos Estranhos: Adeus, Terra do Nunca\" pode ser desbloqueada gratuitamente.\n2, Após o término da atividade, o progresso de investigação de \"Visão de Sonhos Estranhos: Adeus, Terra do Nunca\" será Preservado. Ao concluir os eventos de investigação não concluídos durante a atividade, também é possível obter as mesmas recompensas de investigação do período da atividade. Se \"Visão de Sonhos Estranhos: Adeus, Terra do Nunca\" não for desbloqueada durante a atividade, ainda será possível desbloqueá-la após o término da atividade consumindo \"Ponto de partida real\" × 7.\n3, Independentemente de estar ou não no período da atividade, após Concluir \"Visão de Sonhos Estranhos: Adeus, Terra do Nunca\", é possível obter \"Ordem de chave: Verão Congelado - Recordação de Verão\"."
  },
  Activity_141535_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_141536_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_142866_ActivityName = {
    Text = "Gênesis Dama do Mar Profundo"
  },
  Activity_142866_ActivityTips = {
    Text = "<Title:Regras da Atividade>\n· Durante o período da atividade \"Lady do Mar Profundo Primordial\", os Guardiãs da Verdade poderão utilizar equipes predefinidas pelo sistema contendo a Lady do Mar Profundo Primordial para repetidamente experimentar as fases designadas.\n· Ao experimentar as fases da atividade, não será possível ajustar os Corpos Despertados dentro da formação da equipe.\n<Title:Recompensas da Atividade>\n· Após completar o desafio da fase pela primeira vez, será possível receber as recompensas de teste na interface da atividade."
  },
  Activity_142867_ActivityName = {
    Text = "Caçadora de crânios"
  },
  Activity_142867_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento \"Caçadora de Cranios\", os Guardiões podem usar equipes presetadas pelo sistema que incluem Narciso para experimentar níveis designados infinitamente.\n·Ao experimentar os níveis do evento, ajustes nos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_143933_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_144359_ActivityName = {
    Text = "Testemunha de Tudo"
  },
  Activity_144359_ActivityTips = {
    Text = "<Title:Visão Geral do Evento>\n1. Após completar as tarefas designadas do Diário do Guardião do Segredo, os Guardiões podem resgatar recompensas em \"Testemunha de Tudo\".\n2. \"Testemunha de Tudo\" encerrará em 24 de Agosto às 9:00.\n3. Desbloqueie o \"Arquivo Avançado\" para resgatar recompensas extras ao completar tarefas.\n4. Por favor, note: O \"Arquivo Avançado\" desbloqueado neste evento é válido apenas para este evento. Guardiões, por favor, consuma de forma racional."
  },
  Activity_144359_BannerText = {
    Text = "Jornada Especial da Atividade por Tempo Limitado!"
  },
  Activity_145382_ActivityName = {
    Text = "Queda da Baleia"
  },
  Activity_145382_ActivityTips = {
    Text = "<Title:Regras do Evento>\nDurante o evento \"Queda da Baleia\", os Guardiões podem usar lineups predefinidos pelo sistema que incluem \"Lotan: Cetarchon\" para experimentar fases designadas um número ilimitado de vezes.\n Ao experimentar as fases do evento, os Corpos Despertos no lineup não podem ser ajustados.\n<Title:Recompensas do Evento>\nApós completar o desafio da fase pela primeira vez, você pode resgatar recompensas de teste na interface do evento."
  },
  Activity_145383_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_145383_ActivityPlot = {
    Text = "Após a compra, \"Lotan: Cetarchon\" pode ativar <BlueQuality:Despertar Espiritual 3>"
  },
  Activity_145384_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_145384_ActivityPlot = {
    Text = "Após a compra, \"Lotan: Cetarchon\" pode ativar\n<BlueQuality:Desenvolvimento da personalidade +4, Desbloquear Superexaltação>"
  },
  Activity_145458_ActivityName = {
    Text = "O Jogo do Leviatã"
  },
  Activity_145458_ActivityPlot = {
    Text = "Heróis gananciosos cobiçam tronos imortais, mães desesperadas buscam filhos ressuscitados, e magos loucos têm fome de conhecimento proibido — eles se ajoelham diante dEle, suplicando com as mesmas palavras que Ele ouve há mais de dez mil anos.\nEle lhes concede tudo, apenas para vê-los perder tudo. Ele testemunhou quatro mil disputas brutais, mas permanece insaciável.\nDesta vez, os portões da arena se abrem para você. Venha, diga a Ele — o que é que você deseja?\nDiga a Ele como você difere daquelas quatro mil almas caídas."
  },
  Activity_145458_ActivityStageEndContent = {
    Text = "Evento encerrado, apenas disponível para \"Texto Temporário\""
  },
  Activity_145458_ActivityTips = {
    Text = "<Title:Visão Geral do Evento>\nDurante o evento, os Guardiões podem coletar a moeda do evento \"Sacrifício Carmesim\" através do gameplay de tempo limitado \"Ganância e Sede de Sangue\" e \"Conquistas\". O \"Sacrifício Carmesim\" pode ser trocado por recompensas no \"Altar da Arena\", incluindo a Roda do destino SR exclusiva \"Osso Faminto Imortal\", Núcleo de Lumen, Núcleo Imaculado, Fragmentos de Pedra Sábia, Cristal de Mimese e mais.\n\n<Title:Ganância e Sede de Sangue>\n1. \"Ganância e Sede de Sangue\" contém 5 fases, com 1 fase desbloqueada automaticamente a cada 2 dias.\n2. Cada desafio consome 120 Lingfétide. Completar um desafio com sucesso recompensa a moeda do evento \"Sacrifício Carmesim\".\n3. Após limpar uma fase, a função \"Reproduzir\" para aquela fase é desbloqueada. Por favor, note: A Taxa de Sincronização não pode ser obtida ao usar a função \"Reproduzir\".\n4. Você pode usar o Suporte de Ex-Alunos para ajudá-lo a limpar as fases com mais facilidade.\n\n<Title:Bônus do Evento>\n1. Guardiões que possuem Corpos Despertos ou Rodas do destino específicos (não é necessário que estejam implantados) podem ganhar bônus de drop adicionais para \"Sacrifício Carmesim\" nas recompensas de missão da fase \"Ganância e Sede de Sangue\" (incluindo Reproduzir). Os bônus específicos são os seguintes:\nCorpo Desperto \"Lotan: Cetarchon\": Despertar Espiritual 0/1/2/3 ou acima, bônus 20%/30%/40%/50%.\nRoda do destino SSR \"Cetus Occasus\": Nível de empilhamento 0/1/2/3 ou acima, bônus 20%/30%/40%/50%.\nRoda do destino SR \"Osso Faminto Imortal\": Nível de empilhamento 0/1/2/3 ou acima, bônus 20%/30%/40%/50%.\n2. Os \"Bônus do Evento\" de diferentes Corpos Despertos ou Rodas do destino são calculados cumulativamente.\n3. Em particular, as recompensas de primeira limpeza para desafios de dificuldade de loucura não são afetadas pelos bônus acima.\n\n<Title:Navegação na consciência>\n1. Durante o evento, \"Navegação na consciência: Até a Queda do Cetus\" pode ser desbloqueado gratuitamente.\n2. Após o término do evento, o progresso de investigação de \"Navegação na consciência: Até a Queda do Cetus\" será mantido. Completar Investigação de eventos que não foram concluídas durante o evento ainda recompensará as mesmas recompensas de investigação que durante o evento. Se \"Navegação na consciência: Até a Queda do Cetus\" não foi desbloqueado durante o evento, ainda pode ser desbloqueado após o término do evento consumindo \"Ponto de partida real\" ×3.\n3. Independentemente de ser durante o período do evento ou não, limpar \"Navegação na consciência: Até a Queda do Cetus\" recompensará \"Ordem de chave: Tempestade Devoradora de Cetus\".\n\n<Title:Duração do Evento>\n1. 27 de Julho, 9:00 – 24 de Agosto, 9:00 (GMT+8): Todo o conteúdo da Visão Geral do Evento está disponível.\n2. 24 de Agosto, 9:00 – 31 de Agosto, 9:00 (GMT+8): Apenas \"Altar da Arena\" e \"Recompensas de Conquista\" permanecem disponíveis; todo o outro conteúdo encerrou e não está mais acessível.\n3. Após 31 de Agosto, 9:00 (GMT+8), qualquer \"Sacrifício Carmesim\" restante não trocado será convertido a uma taxa de 40 Cupom de ouro rosa por unidade. Por favor, verifique seu correio, Guardiões."
  },
  Activity_145458_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_145459_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_145465_ActivityName = {
    Text = "Se tudo como de costume: Atividade Despertar Reedição"
  },
  Activity_145465_ActivityPlot = {
    Text = "Você já imaginou como seria a vida de todos se o desastre nunca tivesse chegado? \n O poder que você tinha para salvar o mundo não tem mais lugar, e todos os dias você corre para a vida comum do campus e para ganhar créditos miseráveis. No campo de esportes, não há mais figuras treinando para a batalha, substituídas por fileiras de tendas de atividades de clubes, acompanhadas por gritos de recrutamento e brincadeiras; quando o sino da escola toca, os estudantes famintos imediatamente lotam o refeitório... \n Ao bater à porta das pessoas que você se preocupa, que sorrisos você verá?"
  },
  Activity_145465_ActivityStageEndContent = {
    Text = "Evento [Se Tudo Como de Costume] encerrado, atualmente só é possível participar de \"Prédio da Associação Estudantil\""
  },
  Activity_145465_ActivityTips = {
    Text = "<Title:Visão Geral do Evento>\n1. Durante o evento, você pode coletar a moeda do evento \"Conchas de produtos locais da praia\" através do gameplay de tempo limitado \"Nada de novo sob a luz do sol\". Você pode usar as \"Conchas de produtos locais da praia\" para comprar itens no \"Prédio do Diretório Estudantil\", incluindo Núcleo de Lumen, Núcleo Imaculado, Fragmentos de Pedra Sábia e mais.\n2. Durante o evento, \"Visão de Sonhos Estranhos: Adeus, Terra do Nunca\" estará disponível para acesso gratuito por tempo limitado!\n\n<Title:Duração do Evento>\n1. 3 de Agosto, 9:00 - 17 de Agosto, 9:00 (GMT+8): todo o gameplay do evento está disponível.\n2. 17 de Agosto, 9:00 - 24 de Agosto, 9:00 (GMT+8): você só pode participar do \"Prédio do Diretório Estudantil\" e resgatar Recompensas de Conquista.\n\n<Title:Nada de novo sob a luz do sol>\n1. \"Nada de novo sob a luz do sol\" consiste em 5 níveis, com um abrindo automaticamente a cada 2 dias.\n2. Cada desafio consumirá 120 Lingfétide, e desafios bem-sucedidos renderão moeda do evento para você.\n3. Após completar um nível, a função \"Reproduzir\" para aquele nível será desbloqueada. Nota: Ao usar a função \"Reproduzir\", você não pode obter Taxa de Sincronização.\n4. Você pode contar com a ajuda de Ex-Alunos para facilitar a passagem pelos níveis.<Title:Prédio do Diretório Estudantil>\nO \"Prédio do Diretório Estudantil\" tem uma loja que abre em 3 de Agosto às 9:00.\nNa loja, você pode selecionar itens para compra direta.\n\n<Title:Visão de Sonhos Estranhos>\n1. Durante o evento, você pode desbloquear \"Visão de Sonhos Estranhos: Adeus, Terra do Nunca\" gratuitamente.\n2. Após o término do evento, seu progresso de investigação em \"Visão de Sonhos Estranhos: Adeus, Terra do Nunca\" será mantido. Completar quaisquer Investigação de eventos não concluídas durante o período do evento ainda renderá recompensas de investigação consistentes com o período do evento para você. Se você não desbloqueou \"Visão de Sonhos Estranhos: Adeus, Terra do Nunca\" durante o evento, ainda poderá desbloqueá-lo após o evento consumindo \"Ponto de partida real\" *7.\n3. Independentemente de ser durante o evento ou não, completar \"Visão de Sonhos Estranhos: Adeus, Terra do Nunca\" concederá a você \"Ordem de chave: Momento de Sonho Bonito\"."
  },
  Activity_145465_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_145466_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_145717_ActivityName = {
    Text = "Lua Nova e Neve Profunda"
  },
  Activity_145717_ActivityPlot = {
    Text = "O sétuplo rito de adoração, o tríplice juramento sagrado — carregue uma fé devota na fada de branco puro e suba até onde o céu e a neve se encontram, e ela realizará cada um dos seus desejos. Cada um deles. Toda alma tem seu propósito, e por trás de cada propósito há sua própria mentira. Desenterre-os. Traga-os à luz... antes de se render à superfície impecável de sua narrativa. Não se afunde nesta neve profunda ao lado dela."
  },
  Activity_145717_ActivityStageEndContent = {
    Text = "O evento terminou. Atualmente, apenas \"Rituais da Fada\" está disponível."
  },
  Activity_145717_ActivityTips = {
    Text = "<Title:Visão Geral do Evento>\n1. Durante o evento, os Guardiões do segredo podem coletar as moedas do evento \"Maçã Carmesim\", \"Maçã de Ouro\" e \"Maçã Caramelada\" através da jogabilidade por tempo limitado \"Tesouros de Umapati\" e \"Conquistas\", e trocá-las por itens na \"Cerimônia da Fada\", incluindo a SR Roda do destino exclusiva \"Verdade serena\", Núcleo de Lumen, Núcleo Imaculado e muito mais.\n2. Completar conquistas do evento durante o evento também pode recompensar o avatar exclusivo \"Por nome da Chave de Prata: Caraboo\"!\n\n<Title:Duração do Evento>\n1. 24 de Agosto, 9:00 - 21 de Setembro, 9:00 (GMT+8): Toda a jogabilidade do evento está disponível.\n2. 21 de Setembro, 9:00 - 28 de Setembro, 9:00 (GMT+8): Apenas \"Rituais da Fada\" e recompensas de conquistas estão disponíveis.\n<Title:Tesouros de Umapati>\n1. \"Tesouros de Umapati\" contém 7 fases, com 1 fase desbloqueada automaticamente a cada dia.\n2. Cada desafio consome 120 Lingfétide. Completar um desafio com sucesso recompensa moeda do evento.\n3. Após concluir uma fase, a função \"Reproduzir\" para essa fase é desbloqueada. Atenção: a Taxa de Sincronização não pode ser obtida ao usar a função \"Reproduzir\".\n4. Você pode usar o Suporte de Ex-Alunos para ajudá-lo a concluir as fases com mais facilidade.\n\n<Title: Rituais da Fada>\n1. \"Rituais da Fada\" possui três lojas, com os horários de abertura a seguir:\n\"Bênção da Neve\": Abre às 9:00 do dia 24 de Agosto.\n\"Bênção da Geada\": Abre às 9:00 do dia 25 de Agosto.\n\"Bênção do Branco\": Abre às 9:00 do dia 26 de Agosto.\n2. Cada \"Receber Bênçãos\" consumirá 750 \"Maçã Carmesim\"/\"Maçã de Ouro\"/\"Maçã Caramelada\" para obter aleatoriamente cinco recompensas de itens dos \"Rituais da Fada\".\n3. As recompensas de itens em cada \"Rituais da Fada\" são divididas em dois tipos: \"Item Especial\" e \"Item comum\". Durante uma redefinição, a quantidade restante de recompensas de Item Especial pode ser redefinida ao limite. As regras específicas são as seguintes:\n(1) Primeiras 2 Redefinições: Quando os \"Itens Especiais\" não tiverem quantidade restante, os Guardiões do segredo podem optar por redefinir, o que redefinirá as quantidades restantes de \"Itens Especiais\" e \"Itens comuns\" ao limite; ou podem optar por continuar trocando. Quando os \"Itens comuns\" também não tiverem quantidade restante, uma redefinição deve ser realizada para continuar trocando.\n(2) A partir da 3ª Redefinição: Uma redefinição só pode ser realizada quando os \"Itens comuns\" não tiverem quantidade restante. A redefinição restaurará a quantidade restante de \"Itens comuns\" ao limite, enquanto os \"Itens Especiais\" não serão mais redefinidos.\n\n<Title:Bônus do Evento>\n1. Guardiões do segredo que possuem Corpos Despertos ou Rodas do destino específicos (não é necessário que estejam em campo) podem obter bônus de drop adicionais para as três moedas do evento nas recompensas de missão de fase de \"Tesouros de Umapati\":\nCorpo Desperto \"Caraboo\": Despertar Espiritual 0/1/2/3 ou acima, bônus de 20%/30%/40%/50%.\nSSR Roda do destino \"Mentira da Fruta Doce\": Posição sobreposta 0/1/2/3 ou acima, bônus de 20%/30%/40%/50%.\nSR Roda do destino \"Verdade serena\": Posição sobreposta 0/1/2/3 ou acima, bônus de 20%/30%/40%/50%.\n2. Múltiplos \"Bônus do Evento\" podem ser acumulados e calculados juntos.\n3. Atenção: As recompensas de primeira conclusão dos desafios de dificuldade de loucura não são afetadas pelo \"Bônus do Evento\"."
  },
  Activity_145717_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_146540_ActivityName = {
    Text = "Oferta Memorial de Jornada·Capítulo das Estrelas VI"
  },
  Activity_146540_ActivityPlot = {
    Text = "Um pedaço de memória selado e arquivado, uma jornada registrada no passado. Em momentos de lembrança, não se esqueça de oferecer sua reverente Visita."
  },
  Activity_146541_ActivityName = {
    Text = "Arquivos de Hiperbórea"
  },
  Activity_146541_ActivityTips = {
    Text = "Regras do Evento:\n1. Complete tarefas para reivindicar recompensas nos Arquivos de Hiperbórea\n2. Os Arquivos de Hiperbórea permanecem acessíveis permanentemente\n3. Desbloqueie o Arquivo Avançado para obter recompensas extras ao completar tarefas\nAtenção: O Arquivo Avançado ativado só tem efeito neste evento de Arquivos."
  },
  Activity_146799_ActivityName = {
    Text = "Texto temporário"
  },
  Activity_146799_ActivityPlot = {
    Text = "Texto temporário"
  },
  Activity_146799_ActivityStageEndContent = {
    Text = "Texto temporário"
  },
  Activity_146799_ActivityTips = {
    Text = "Texto temporário"
  },
  Activity_146799_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_147423_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_147423_ActivityPlot = {
    Text = "Após a compra, \"Tinct: Vespera\" pode ativar<BlueQuality:Despertar Espiritual 3>"
  },
  Activity_147424_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_147424_ActivityPlot = {
    Text = "Após a compra, \"Tinct: Vespera\" pode ativar\n<BlueQuality:Aprofundamento de Personalidade +4, desbloquear Explosão Superalimentada>"
  },
  Activity_147425_ActivityName = {
    Text = "Texto temporário"
  },
  Activity_147425_ActivityTips = {
    Text = "<Title:Regras do Evento>\nDurante o evento \"Origem: Poder Real\", os Guardiões do segredo podem usar equipes predefinidas pelo sistema que incluem Origem: Poder Real para experienciar níveis designados um número ilimitado de vezes.\nAo experienciar os níveis do evento, ajustes nos Corpos Despertos na formação da equipe não podem ser feitos.\n<Title:Recompensas do Evento>\nApós completar o desafio do nível pela primeira vez, você pode reivindicar as recompensas de demonstração na interface do evento."
  },
  Activity_147426_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_148119_ActivityName = {
    Text = "Tempo Extracurricular"
  },
  Activity_148119_ActivityTips = {
    Text = "<Title:Visão Geral do Evento>\n1. Após completar as tarefas designadas do Diário do Guardião do Segredo, os Guardiões do segredo podem reivindicar recompensas em \"Horas Após a Escola\".\n2. \"Horas Após a Escola\" encerrará em 21 de setembro às 9:00.\n3. Desbloqueie o \"Arquivo Avançado\" para reivindicar recompensas extras ao completar tarefas.\n4. Atenção: O \"Arquivo Avançado\" desbloqueado neste evento é válido apenas para este evento. Guardiões do segredo, por favor, consumam com moderação."
  },
  Activity_148119_BannerText = {
    Text = "Jornada Especial da Atividade por Tempo Limitado!"
  },
  Activity_148889_ActivityName = {
    Text = "Gênesis Ogier"
  },
  Activity_148889_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento \"Origem Ogier\", os Guardiões do segredo podem usar as equipes predefinidas pelo sistema que incluem Origem Ogier para experimentar as Fases designadas um número ilimitado de vezes.\n·Ao experimentar as Fases do evento, os Corpos Despertos na Formação não podem ser ajustados.\n<Title:Recompensas do Evento>\n·Após completar o desafio de uma Fase pela primeira vez, as recompensas de teste podem ser resgatadas na página do evento."
  },
  Activity_15788_ActivityName = {
    Text = "Estética da Alquimia"
  },
  Activity_15788_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Estética da alquimia\", após o Guardião de Segredos concluir a \"Busca de cupons de ouro\", algumas recompensas de materiais serão dobradas, até 3 vezes por dia.\n2. As chances de recompensa dobrada não utilizadas no dia serão redefinidas às 9:00 (GMT+8) do dia seguinte, então lembre-se de usá-las a tempo～"
  },
  Activity_15791_ActivityName = {
    Text = "Explosão de gnose"
  },
  Activity_15791_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Eclodimento de Conhecimento\", após o Guardião concluir a \"Preparação e tempera\", algumas recompensas de materiais serão dobradas, até 3 vezes por dia.\n2. As chances de recompensa dobrada não utilizadas no dia serão redefinidas às 9:00 (GMT+8) do dia seguinte, então lembre-se de usá-las a tempo～"
  },
  Activity_15793_ActivityName = {
    Text = "Sombra da cidade chuvosa"
  },
  Activity_15793_ActivityPlot = {
    Text = "Toda noite chuvosa é acompanhada de decepção e solidão.\nAlguns perdem o amor, outros perdem a dignidade.\nE alguns perdem a cabeça."
  },
  Activity_15793_ActivityTips = {
    Text = "<Title:Condições de Participação>\n·Completar \"Operação de Investigação\" 2-9 (Normal) para participar.\n<Title:Evento de Investigação>\n·Durante o período do evento, um novo evento de investigação em \"Sombras da Cidade da Chuva\" será lançado diariamente. Guardiões podem desbloquear e investigar sem consumir o inventário. Após completar o evento de investigação, recompensas como Núcleo Puro, Distintivo de Investigação e Experiência do Guardião podem ser obtidas.\n·Após o término do evento, o progresso da investigação de \"Sombras da Cidade da Chuva\" será mantido. Guardiões podem consumir Jóias D no Registro Especial para desbloquear investigações não completadas. Completar eventos de investigação não realizados durante o período do evento também concederá recompensas consistentes com aquelas durante o evento.<Title:Recompensas por Tempo Limitado>\n·Recompensas por tempo limitado estarão disponíveis durante o evento. Guardiões podem obter Núcleo Puro, Pedra Filosofal e recompensas de Prata após concluir \"Sombras da Cidade da Chuva\" (modo Normal) e completar eventos de investigação de \"Sombras da Cidade da Chuva\"! Recompensas por tempo limitado estão disponíveis apenas durante o período do evento e não podem ser completadas ou reclamadas após o término do evento."
  },
  Activity_15793_UnlockConditionExplanation = {
    Text = "Desbloqueado após completar \"Operação de Investigação\" 2-9 · Normal"
  },
  Activity_15797_ActivityName = {
    Text = "Soberano adormecido"
  },
  Activity_15797_ActivityTips = {
    Text = "<Title:Event Rules>\n·Durante o evento \"Soberano do Sono\", os Guardiães podem usar equipes pré-definidas pelo sistema que incluem Tulu para experimentar níveis designados infinitamente.\n·Ao experimentar níveis do evento, ajustes aos Despertadores na formação da equipe não são permitidos.\n<Title:Event Rewards>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_15805_ActivityName = {
    Text = "Viagem pela Cidade Neblinosa"
  },
  Activity_15805_ActivityTips = {
    Text = "\nRegras do Evento:\n1. Após concluir as tarefas de jornada especificadas, os Guardiões podem reivindicar recompensas na \"Jornada da Cidade da Névoa\".\n2. \"Jornada da Cidade da Névoa\" está aberta permanentemente.\n3. Após desbloquear a \"Jornada Avançada\", os Guardiões podem receber recompensas adicionais ao completar tarefas.\n4. Por favor, note: A \"Jornada Avançada\" desbloqueada neste evento é válida apenas durante este evento. Recomenda-se que os Guardiões consumam de forma razoável."
  },
  Activity_15809_ActivityName = {
    Text = "Semente Estelar (Expirada)"
  },
  Activity_15809_ActivityTips = {
    Text = "Regras do evento:\nApós o Guardião de Segredos completar as tarefas designadas, as recompensas podem ser resgatadas em \"Broto Nascido nas Estrelas\"."
  },
  Activity_15818_ActivityName = {
    Text = "Escultor (Expirado)"
  },
  Activity_15818_ActivityTips = {
    Text = "Regras do evento:\nApós o Guardião de Segredos completar as tarefas designadas, as recompensas podem ser resgatadas em \"A Escultora\"."
  },
  Activity_15821_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_15821_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_15825_ActivityName = {
    Text = "Poema Sem Nome (Vencido)"
  },
  Activity_15825_ActivityTips = {
    Text = "Regras do evento:\nApós o Guardião de Segredos completar as tarefas designadas, as recompensas podem ser resgatadas em \"Poema Sem Nome\"."
  },
  Activity_15828_ActivityName = {
    Text = "Cerimônia de entrada"
  },
  Activity_15828_ActivityTips = {
    Text = "\nRegras do Evento:\n1. Os Guardiões podem coletar recompensas na \"Cerimônia de Abertura\" quando seu nível de investigação atingir 5/15/25/35/45/55.\n2. A experiência do guardião pode ser obtida através dos níveis de investigação e interlúdios."
  },
  Activity_20344_ActivityName = {
    Text = "Encontro sem luz"
  },
  Activity_20344_ActivityTips = {
    Text = "\nRegras do Evento:\n1. Após completar as tarefas de jornada especificadas, os Guardiões podem reivindicar recompensas em \"Visão Inicial Sem Luz\".\n2. \"Visão Inicial Sem Luz\" está permanentemente aberta."
  },
  Activity_20683_ActivityName = {
    Text = "Edify performance"
  },
  Activity_20683_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", após o Guardião de Segredos concluir o \"Resíduo dimensional\", algumas recompensas de materiais serão dobradas, até 3 vezes por dia.\n2. As chances de recompensa dobrada não utilizadas no dia serão redefinidas às 9:00 (GMT+8) do dia seguinte, então lembre-se de usá-las a tempo～"
  },
  Activity_20684_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_20684_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", após o Guardião de Segredos concluir a \"Garganta de Schwarzschild\", algumas recompensas de materiais serão dobradas, até 3 vezes por dia.\n2. As chances de recompensa dobrada não utilizadas no dia serão redefinidas às 9:00 (GMT+8) do dia seguinte, então lembre-se de usá-las a tempo～"
  },
  Activity_20685_ActivityName = {
    Text = "Edify performance"
  },
  Activity_20685_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", após o Guardião de Segredos concluir o \"Resíduo orgânico\", algumas recompensas de materiais serão dobradas, até 3 vezes por dia.\n2. As chances de recompensa dobrada não utilizadas no dia serão redefinidas às 9:00 (GMT+8) do dia seguinte, então lembre-se de usá-las a tempo～"
  },
  Activity_20686_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_20686_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", após o Guardião de Segredos concluir as \"Ruínas de Ponape\", algumas recompensas de materiais serão dobradas, até 3 vezes por dia.\n2. As chances de recompensa dobrada não utilizadas no dia serão redefinidas às 9:00 (GMT+8) do dia seguinte, então lembre-se de usá-las a tempo～"
  },
  Activity_20687_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_20687_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", após o Guardião de Segredos concluir o \"Cluster caótico\", algumas recompensas de materiais serão dobradas, até 3 vezes por dia.\n2. As chances de recompensa dobrada não utilizadas no dia serão redefinidas às 9:00 (GMT+8) do dia seguinte, então lembre-se de usá-las a tempo～"
  },
  Activity_20688_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_20688_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", após o Guardião de Segredos concluir o \"Ninho de Vermes\", algumas recompensas de materiais serão dobradas, até 3 vezes por dia.\n2. As chances de recompensa dobrada não utilizadas no dia serão redefinidas às 9:00 (GMT+8) do dia seguinte, então lembre-se de usá-las a tempo～"
  },
  Activity_20689_ActivityName = {
    Text = "Edify performance"
  },
  Activity_20689_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", após o Guardião de Segredos concluir o \"Resíduo das Profundezas\", algumas recompensas de materiais serão dobradas, até 3 vezes por dia.\n2. As chances de recompensa dobrada não utilizadas no dia serão redefinidas às 9:00 (GMT+8) do dia seguinte, então lembre-se de usá-las a tempo～"
  },
  Activity_20690_ActivityName = {
    Text = "Edify performance"
  },
  Activity_20690_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", após o Guardião de Segredos concluir o \"Resíduo turvo\", algumas recompensas de materiais serão dobradas, até 3 vezes por dia.\n2. As chances de recompensa dobrada não utilizadas no dia serão redefinidas às 9:00 (GMT+8) do dia seguinte, então lembre-se de usá-las a tempo～"
  },
  Activity_20691_ActivityName = {
    Text = "Caçadora de crânios"
  },
  Activity_20691_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento \"Caçadora de Cranios\", os Guardiões podem usar equipes presetadas pelo sistema que incluem Narciso para experimentar níveis designados infinitamente.\n·Ao experimentar os níveis do evento, ajustes nos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_21502_ActivityName = {
    Text = "Apóstolo do mar"
  },
  Activity_21502_ActivityTips = {
    Text = "<Title:Regras do Evento>\n· Durante o evento \"Apostolo do Mar\", os Guardiães podem usar equipes pré-definidas pelo sistema que incluam Miryam para experimentar níveis designados infinitamente.\n· Ao experimentar os níveis do evento, ajustes aos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n· Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_21781_ActivityName = {
    Text = "Caixa de Seleção do Currículo"
  },
  Activity_21781_ActivityPlot = {
    Text = "Complete a missão para escolher um Despertador específico de \"Estudo do Reino\" ou uma roda específica do destino de \"Aspecto da Rotação\"!"
  },
  Activity_21781_ActivityTips = {
    Text = "Regras do Evento:\n1. Acumular 50 Despertares, fazer login por 3 dias e fazer login por 7 dias concederá recompensas do \"Parque Prototípico\". O \"Parque Prototípico\" pode ser usado em \"Suprimentos: Consumíveis.\" Ao usar, você pode selecionar 1 Corpo Desperto específico do \"Estudo de domínio\" para Despertar.\n2. Acumular 300 Despertares, 1000 Despertares e fazer login por 30 dias concederá recompensas do \"Livro de rotação\". O \"Livro de rotação\" pode ser usado em \"Suprimentos: Consumíveis.\" Ao usar, você pode selecionar 1 Roda do destino específica da \"Fase de Rotação\" para obter."
  },
  Activity_22367_ActivityName = {
    Text = "Explosão de gnose"
  },
  Activity_22367_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Eclodimento de Conhecimento\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Preparação e tempera\", sem limite diário."
  },
  Activity_23671_ActivityName = {
    Text = "Duelo de mergulho profundo"
  },
  Activity_23671_ActivityPlot = {
    Text = "Durante o evento, a Experiência do Guardião de Segredos obtida pelo Guardião de Segredos através do \"Mergulho Fantasmal\" e da \"Fase de Duelo\" será dobrada, com o limite diário aumentado para 480 pontos."
  },
  Activity_23671_ActivityTips = {
    Text = "\nRegras do Evento:\n1. Durante o evento \"Mergulho Fantasmagórico e Traphase\", o Guardião receberá o dobro de experiência do guardião a partir de \"Mergulho Fantasmagórico\" e \"Traphase\", com um limite diário aumentado para 480 pontos. Se o assunto principal também estiver desbloqueado, a experiência do guardião obtida por esse caminho será dobrada novamente, com um limite diário permanecendo em 480 pontos.\n2. Quaisquer experiências do guardião dobradas não utilizadas para o dia serão redefinidas às 9:00 AM (GMT+8) do dia seguinte, então lembre-se de usá-las a tempo, Guardião~"
  },
  Activity_23693_ActivityName = {
    Text = "Descendente Pálido"
  },
  Activity_23693_ActivityPlot = {
    Text = "Diz a lenda que sob Londinium existe uma única Porta.\nEla leva ao domínio da Senhora Pálida..."
  },
  Activity_23693_ActivityTips = {
    Text = "<Title:Condições de Participação>\n· A participação está disponível após completar o modo normal da viagem de consciência \"Desejo do Cavaleiro\". \n<Title:Eventos de Investigação>\n· Durante o período do evento, um novo evento de investigação será lançado diariamente em \"Descendente Pálido\". Os guardiões podem desbloquear e conduzir investigações sem consumir nenhum item do inventário, e completar eventos de investigação renderá recompensas, como núcleos puros, insígnias de investigação e experiência do guardião.\n· Após o término do evento, o progresso da investigação em \"Descendente Pálido\" será preservado. Os guardiões podem desbloquear quaisquer investigações bloqueadas na viagem de consciência consumindo D-jóias, e completar quaisquer eventos de investigação não finalizados durante o período do evento também renderá recompensas de investigação consistentes com aquelas disponíveis durante o evento.<Title:Recompensas por Tempo Limitado>\n· Recompensas por tempo limitado estarão disponíveis durante o período do evento. Os guardiões podem receber o Cadeado Sombrio e recompensas de Prata após completar o modo normal de \"Descendente Pálido\" e finalizar seus eventos de investigação! Recompensas por tempo limitado estão disponíveis apenas durante o evento e não podem ser completadas ou reivindicadas após seu término."
  },
  Activity_23693_UnlockConditionExplanation = {
    Text = "Complete o \"Desejo do Cavaleiro\" errante para desbloquear depois"
  },
  Activity_23723_ActivityName = {
    Text = "Tempestade está chegando"
  },
  Activity_23723_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento, o Capítulo 5 da Operação de investigação estará temporariamente fechado. A Ordem de chave \"Obsessão Eterna\" poderá ser obtida temporariamente ao concluir o Capítulo 4 da Operação de investigação.\n2. Após o término do evento, o Capítulo 5 da Operação de investigação será reaberto, e a Ordem de chave \"Obsessão Eterna\" voltará a exigir a conclusão do Capítulo 5 da Operação de investigação.\n3. Além disso, todas as Recompensas de conquista do Capítulo 5, Conquistas de Fase, recompensas de exploração e Recompensas de conclusão obtidas anteriormente serão mantidas. Quando reabrir (atualmente previsto para 27 de dezembro), o progresso concluído relacionado será transferido na medida do possível, portanto não será necessário refazê-los."
  },
  Activity_23870_ActivityName = {
    Text = "Inferência de Traphase"
  },
  Activity_23870_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento, complete as missões do evento para receber recompensas.\n2. Após o término do evento, as recompensas do evento não resgatadas não poderão mais ser obtidas. Guardiões do segredo, lembrem-se de resgatá-las a tempo～"
  },
  Activity_23936_ActivityName = {
    Text = "Edify performance"
  },
  Activity_23936_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo das Profundezas\", sem limite diário."
  },
  Activity_23937_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_23937_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa de materiais (excluindo Experiência do Guardião de Segredos e Cupom de ouro rosa) ao investigar ou Recriar em \"Cluster caótico\", sem limite diário."
  },
  Activity_23938_ActivityName = {
    Text = "Duelo de mergulho profundo"
  },
  Activity_23938_ActivityPlot = {
    Text = "Durante o evento, a Experiência do Guardião de Segredos obtida pelo Guardião de Segredos através do \"Mergulho Fantasmal\" e da \"Fase de Duelo\" será dobrada, com o limite diário aumentado para 480 pontos."
  },
  Activity_23938_ActivityTips = {
    Text = "\nRegras do Evento:\n1. Durante o evento \"Mergulho Fantasmagórico e Traphase\", o Guardião receberá o dobro de experiência do guardião a partir de \"Mergulho Fantasmagórico\" e \"Traphase\", com um limite diário aumentado para 480 pontos. Se o assunto principal também estiver desbloqueado, a experiência do guardião obtida por esse caminho será dobrada novamente, com um limite diário permanecendo em 480 pontos.\n2. Quaisquer experiências do guardião dobradas não utilizadas para o dia serão redefinidas às 9:00 AM (GMT+8) do dia seguinte, então lembre-se de usá-las a tempo, Guardião~"
  },
  Activity_23939_ActivityName = {
    Text = "Duelo de mergulho profundo"
  },
  Activity_23939_ActivityPlot = {
    Text = "Durante o evento, a Experiência do Guardião de Segredos obtida pelo Guardião de Segredos através do \"Mergulho Fantasmal\" e da \"Fase de Duelo\" será dobrada, com o limite diário aumentado para 480 pontos."
  },
  Activity_23939_ActivityTips = {
    Text = "\nRegras do Evento:\n1. Durante o evento \"Mergulho Fantasmagórico e Traphase\", o Guardião receberá o dobro de experiência do guardião a partir de \"Mergulho Fantasmagórico\" e \"Traphase\", com um limite diário aumentado para 480 pontos. Se o assunto principal também estiver desbloqueado, a experiência do guardião obtida por esse caminho será dobrada novamente, com um limite diário permanecendo em 480 pontos.\n2. Quaisquer experiências do guardião dobradas não utilizadas para o dia serão redefinidas às 9:00 AM (GMT+8) do dia seguinte, então lembre-se de usá-las a tempo, Guardião~"
  },
  Activity_23940_ActivityName = {
    Text = "Explosão de gnose"
  },
  Activity_23940_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Eclodimento de Conhecimento\", após o Guardião concluir a \"Preparação e tempera\", algumas recompensas de materiais serão dobradas, até 3 vezes por dia.\n2. As chances de recompensa dobrada não utilizadas no dia serão redefinidas às 9:00 (GMT+8) do dia seguinte, então lembre-se de usá-las a tempo～"
  },
  Activity_23941_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_23941_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa de materiais (excluindo Experiência do Guardião de Segredos e Cupom de ouro rosa) ao investigar ou Recriar em \"Garganta de Schwarzschild\", sem limite diário."
  },
  Activity_23942_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_23942_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", após o Guardião de Segredos concluir o \"Ninho de Vermes\", algumas recompensas de materiais serão dobradas, até 3 vezes por dia.\n2. As chances de recompensa dobrada não utilizadas no dia serão redefinidas às 9:00 (GMT+8) do dia seguinte, então lembre-se de usá-las a tempo～"
  },
  Activity_23943_ActivityName = {
    Text = "Edify performance"
  },
  Activity_23943_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo dimensional\", sem limite diário."
  },
  Activity_23944_ActivityName = {
    Text = "Edify performance"
  },
  Activity_23944_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo orgânico\", sem limite diário."
  },
  Activity_23945_ActivityName = {
    Text = "Edify performance"
  },
  Activity_23945_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", após o Guardião de Segredos concluir o \"Resíduo turvo\", algumas recompensas de materiais serão dobradas, até 3 vezes por dia.\n2. As chances de recompensa dobrada não utilizadas no dia serão redefinidas às 9:00 (GMT+8) do dia seguinte, então lembre-se de usá-las a tempo～"
  },
  Activity_23946_ActivityName = {
    Text = "Edify performance"
  },
  Activity_23946_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo dimensional\", sem limite diário."
  },
  Activity_23947_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_23947_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Ruínas de Ponape\", sem limite diário."
  },
  Activity_23948_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_23948_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Cluster caótico\", sem limite diário."
  },
  Activity_23949_ActivityName = {
    Text = "Edify performance"
  },
  Activity_23949_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo turvo\", sem limite diário."
  },
  Activity_23950_ActivityName = {
    Text = "Edify performance"
  },
  Activity_23950_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo das Profundezas\", sem limite diário."
  },
  Activity_23951_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_23951_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Cluster caótico\", sem limite diário."
  },
  Activity_23953_ActivityName = {
    Text = "Duelo de mergulho profundo"
  },
  Activity_23953_ActivityPlot = {
    Text = "Durante o evento, a Experiência do Guardião de Segredos obtida pelo Guardião de Segredos através do \"Mergulho Fantasmal\" e da \"Fase de Duelo\" será dobrada, com o limite diário aumentado para 480 pontos."
  },
  Activity_23953_ActivityTips = {
    Text = "\nRegras do Evento:\n1. Durante o evento \"Mergulho Fantasmagórico e Traphase\", o Guardião receberá o dobro de experiência do guardião a partir de \"Mergulho Fantasmagórico\" e \"Traphase\", com um limite diário aumentado para 480 pontos. Se o assunto principal também estiver desbloqueado, a experiência do guardião obtida por esse caminho será dobrada novamente, com um limite diário permanecendo em 480 pontos.\n2. Quaisquer experiências do guardião dobradas não utilizadas para o dia serão redefinidas às 9:00 AM (GMT+8) do dia seguinte, então lembre-se de usá-las a tempo, Guardião~"
  },
  Activity_23954_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_23954_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Cluster caótico\", sem limite diário."
  },
  Activity_23955_ActivityName = {
    Text = "Edify performance"
  },
  Activity_23955_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa de materiais (excluindo Experiência do Guardião de Segredos e Cupom de ouro rosa) ao investigar ou Recriar em \"Resíduo das Profundezas\", sem limite diário."
  },
  Activity_23956_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_23956_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Ruínas de Ponape\", sem limite diário."
  },
  Activity_23957_ActivityName = {
    Text = "Explosão de gnose"
  },
  Activity_23957_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Eclodimento de Conhecimento\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Preparação e tempera\", sem limite diário."
  },
  Activity_23958_ActivityName = {
    Text = "Edify performance"
  },
  Activity_23958_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo orgânico\", sem limite diário."
  },
  Activity_23959_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_23959_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Garganta de Schwarzschild\", sem limite diário."
  },
  Activity_23960_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_23960_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Ruínas de Ponape\", sem limite diário."
  },
  Activity_23961_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_23961_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Cluster caótico\", sem limite diário."
  },
  Activity_23962_ActivityName = {
    Text = "Explosão de gnose"
  },
  Activity_23962_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Eclodimento de Conhecimento\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Preparação e tempera\", sem limite diário."
  },
  Activity_23963_ActivityName = {
    Text = "Edify performance"
  },
  Activity_23963_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo das Profundezas\", sem limite diário."
  },
  Activity_23964_ActivityName = {
    Text = "Edify performance"
  },
  Activity_23964_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo dimensional\", sem limite diário."
  },
  Activity_23965_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_23965_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Cluster caótico\", sem limite diário."
  },
  Activity_23966_ActivityName = {
    Text = "Edify performance"
  },
  Activity_23966_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo dimensional\", sem limite diário."
  },
  Activity_23967_ActivityName = {
    Text = "Duelo de mergulho profundo"
  },
  Activity_23967_ActivityPlot = {
    Text = "Durante o evento, a Experiência do Guardião de Segredos obtida pelo Guardião de Segredos através do \"Mergulho Fantasmal\" e da \"Fase de Duelo\" será dobrada, com o limite diário aumentado para 480 pontos."
  },
  Activity_23967_ActivityTips = {
    Text = "\nRegras do Evento:\n1. Durante o evento \"Mergulho Fantasmagórico e Traphase\", o Guardião receberá o dobro de experiência do guardião a partir de \"Mergulho Fantasmagórico\" e \"Traphase\", com um limite diário aumentado para 480 pontos. Se o assunto principal também estiver desbloqueado, a experiência do guardião obtida por esse caminho será dobrada novamente, com um limite diário permanecendo em 480 pontos.\n2. Quaisquer experiências do guardião dobradas não utilizadas para o dia serão redefinidas às 9:00 AM (GMT+8) do dia seguinte, então lembre-se de usá-las a tempo, Guardião~"
  },
  Activity_23968_ActivityName = {
    Text = "Explosão de gnose"
  },
  Activity_23968_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Eclodimento de Conhecimento\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Preparação e tempera\", sem limite diário."
  },
  Activity_23969_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_23969_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Garganta de Schwarzschild\", sem limite diário."
  },
  Activity_23970_ActivityName = {
    Text = "Edify performance"
  },
  Activity_23970_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo das Profundezas\", sem limite diário."
  },
  Activity_23971_ActivityName = {
    Text = "Edify performance"
  },
  Activity_23971_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo dimensional\", sem limite diário."
  },
  Activity_23972_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_23972_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Ninho de Vermes\", sem limite diário."
  },
  Activity_23973_ActivityName = {
    Text = "Edify performance"
  },
  Activity_23973_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa de materiais (excluindo Experiência do Guardião de Segredos e Cupom de ouro rosa) ao investigar ou Recriar em \"Resíduo turvo\", sem limite diário."
  },
  Activity_23974_ActivityName = {
    Text = "Explosão de gnose"
  },
  Activity_23974_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Eclodimento de Conhecimento\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Preparação e tempera\", sem limite diário."
  },
  Activity_23975_ActivityName = {
    Text = "Edify performance"
  },
  Activity_23975_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", após o Guardião de Segredos concluir o \"Resíduo orgânico\", algumas recompensas de materiais serão dobradas, até 3 vezes por dia.\n2. As chances de recompensa dobrada não utilizadas no dia serão redefinidas às 9:00 (GMT+8) do dia seguinte, então lembre-se de usá-las a tempo～"
  },
  Activity_23976_ActivityName = {
    Text = "Edify performance"
  },
  Activity_23976_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo das Profundezas\", sem limite diário."
  },
  Activity_23977_ActivityName = {
    Text = "Estética da Alquimia"
  },
  Activity_23977_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Estética da alquimia\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Busca de cupons de ouro\", sem limite diário."
  },
  Activity_23978_ActivityName = {
    Text = "Explosão de gnose"
  },
  Activity_23978_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Eclodimento de Conhecimento\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Preparação e tempera\", sem limite diário."
  },
  Activity_23979_ActivityName = {
    Text = "Estética da Alquimia"
  },
  Activity_23979_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Estética da alquimia\", após o Guardião de Segredos concluir a \"Busca de cupons de ouro\", algumas recompensas de materiais serão dobradas, até 3 vezes por dia.\n2. As chances de recompensa dobrada não utilizadas no dia serão redefinidas às 9:00 (GMT+8) do dia seguinte, então lembre-se de usá-las a tempo～"
  },
  Activity_23980_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_23980_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", após o Guardião de Segredos concluir o \"Cluster caótico\", algumas recompensas de materiais serão dobradas, até 3 vezes por dia.\n2. As chances de recompensa dobrada não utilizadas no dia serão redefinidas às 9:00 (GMT+8) do dia seguinte, então lembre-se de usá-las a tempo～"
  },
  Activity_23981_ActivityName = {
    Text = "Edify performance"
  },
  Activity_23981_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo dimensional\", sem limite diário."
  },
  Activity_23982_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_23982_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Ninho de Vermes\", sem limite diário."
  },
  Activity_23983_ActivityName = {
    Text = "Edify performance"
  },
  Activity_23983_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", após o Guardião de Segredos concluir o \"Resíduo dimensional\", algumas recompensas de materiais serão dobradas, até 3 vezes por dia.\n2. As chances de recompensa dobrada não utilizadas no dia serão redefinidas às 9:00 (GMT+8) do dia seguinte, então lembre-se de usá-las a tempo～"
  },
  Activity_23984_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_23984_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Ninho de Vermes\", sem limite diário."
  },
  Activity_23985_ActivityName = {
    Text = "Explosão de gnose"
  },
  Activity_23985_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Eclodimento de Conhecimento\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Preparação e tempera\", sem limite diário."
  },
  Activity_23986_ActivityName = {
    Text = "Edify performance"
  },
  Activity_23986_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo turvo\", sem limite diário."
  },
  Activity_23987_ActivityName = {
    Text = "Explosão de gnose"
  },
  Activity_23987_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Eclodimento de Conhecimento\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Preparação e tempera\", sem limite diário."
  },
  Activity_23988_ActivityName = {
    Text = "Edify performance"
  },
  Activity_23988_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo turvo\", sem limite diário."
  },
  Activity_23989_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_23989_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Ninho de Vermes\", sem limite diário."
  },
  Activity_23990_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_23990_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Garganta de Schwarzschild\", sem limite diário."
  },
  Activity_23991_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_23991_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Ninho de Vermes\", sem limite diário."
  },
  Activity_23992_ActivityName = {
    Text = "Edify performance"
  },
  Activity_23992_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo das Profundezas\", sem limite diário."
  },
  Activity_23993_ActivityName = {
    Text = "Edify performance"
  },
  Activity_23993_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo orgânico\", sem limite diário."
  },
  Activity_23994_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_23994_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Cluster caótico\", sem limite diário."
  },
  Activity_23995_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_23995_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Garganta de Schwarzschild\", sem limite diário."
  },
  Activity_23996_ActivityName = {
    Text = "Duelo de mergulho profundo"
  },
  Activity_23996_ActivityPlot = {
    Text = "Durante o evento, a Experiência do Guardião de Segredos obtida pelo Guardião de Segredos através do \"Mergulho Fantasmal\" e da \"Fase de Duelo\" será dobrada, com o limite diário aumentado para 480 pontos."
  },
  Activity_23996_ActivityTips = {
    Text = "\nRegras do Evento:\n1. Durante o evento \"Mergulho Fantasmagórico e Traphase\", o Guardião receberá o dobro de experiência do guardião a partir de \"Mergulho Fantasmagórico\" e \"Traphase\", com um limite diário aumentado para 480 pontos. Se o assunto principal também estiver desbloqueado, a experiência do guardião obtida por esse caminho será dobrada novamente, com um limite diário permanecendo em 480 pontos.\n2. Quaisquer experiências do guardião dobradas não utilizadas para o dia serão redefinidas às 9:00 AM (GMT+8) do dia seguinte, então lembre-se de usá-las a tempo, Guardião~"
  },
  Activity_23997_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_23997_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Ruínas de Ponape\", sem limite diário."
  },
  Activity_23998_ActivityName = {
    Text = "Edify performance"
  },
  Activity_23998_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa de materiais (excluindo Experiência do Guardião de Segredos e Cupom de ouro rosa) ao investigar ou Recriar em \"Resíduo orgânico\", sem limite diário."
  },
  Activity_23999_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_23999_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Garganta de Schwarzschild\", sem limite diário."
  },
  Activity_24000_ActivityName = {
    Text = "Edify performance"
  },
  Activity_24000_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo das Profundezas\", sem limite diário."
  },
  Activity_24001_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_24001_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Cluster caótico\", sem limite diário."
  },
  Activity_24002_ActivityName = {
    Text = "Edify performance"
  },
  Activity_24002_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo orgânico\", sem limite diário."
  },
  Activity_24003_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_24003_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Ninho de Vermes\", sem limite diário."
  },
  Activity_24004_ActivityName = {
    Text = "Edify performance"
  },
  Activity_24004_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo dimensional\", sem limite diário."
  },
  Activity_24005_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_24005_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Garganta de Schwarzschild\", sem limite diário."
  },
  Activity_24006_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_24006_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Ruínas de Ponape\", sem limite diário."
  },
  Activity_24007_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_24007_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", após o Guardião de Segredos concluir as \"Ruínas de Ponape\", algumas recompensas de materiais serão dobradas, até 3 vezes por dia.\n2. As chances de recompensa dobrada não utilizadas no dia serão redefinidas às 9:00 (GMT+8) do dia seguinte, então lembre-se de usá-las a tempo～"
  },
  Activity_24009_ActivityName = {
    Text = "Edify performance"
  },
  Activity_24009_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo orgânico\", sem limite diário."
  },
  Activity_24010_ActivityName = {
    Text = "Edify performance"
  },
  Activity_24010_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo turvo\", sem limite diário."
  },
  Activity_24011_ActivityName = {
    Text = "Explosão de gnose"
  },
  Activity_24011_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Eclodimento de Conhecimento\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Preparação e tempera\", sem limite diário."
  },
  Activity_24012_ActivityName = {
    Text = "Edify performance"
  },
  Activity_24012_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo orgânico\", sem limite diário."
  },
  Activity_24013_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_24013_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Garganta de Schwarzschild\", sem limite diário."
  },
  Activity_24014_ActivityName = {
    Text = "Edify performance"
  },
  Activity_24014_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo turvo\", sem limite diário."
  },
  Activity_24015_ActivityName = {
    Text = "Explosão de gnose"
  },
  Activity_24015_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Eclodimento de Conhecimento\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Preparação e tempera\", sem limite diário."
  },
  Activity_24016_ActivityName = {
    Text = "Edify performance"
  },
  Activity_24016_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo das Profundezas\", sem limite diário."
  },
  Activity_24017_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_24017_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Garganta de Schwarzschild\", sem limite diário."
  },
  Activity_24018_ActivityName = {
    Text = "Edify performance"
  },
  Activity_24018_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo turvo\", sem limite diário."
  },
  Activity_24019_ActivityName = {
    Text = "Edify performance"
  },
  Activity_24019_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", após o Guardião de Segredos concluir o \"Resíduo das Profundezas\", algumas recompensas de materiais serão dobradas, até 3 vezes por dia.\n2. As chances de recompensa dobrada não utilizadas no dia serão redefinidas às 9:00 (GMT+8) do dia seguinte, então lembre-se de usá-las a tempo～"
  },
  Activity_24020_ActivityName = {
    Text = "Explosão de gnose"
  },
  Activity_24020_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Eclodimento de Conhecimento\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Preparação e tempera\", sem limite diário."
  },
  Activity_24021_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_24021_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Ruínas de Ponape\", sem limite diário."
  },
  Activity_24022_ActivityName = {
    Text = "Explosão de gnose"
  },
  Activity_24022_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Eclodimento de Conhecimento\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Preparação e tempera\", sem limite diário."
  },
  Activity_24023_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_24023_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", após o Guardião de Segredos concluir a \"Garganta de Schwarzschild\", algumas recompensas de materiais serão dobradas, até 3 vezes por dia.\n2. As chances de recompensa dobrada não utilizadas no dia serão redefinidas às 9:00 (GMT+8) do dia seguinte, então lembre-se de usá-las a tempo～"
  },
  Activity_24025_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_24025_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Ruínas de Ponape\", sem limite diário."
  },
  Activity_24026_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_24026_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa de materiais (excluindo Experiência do Guardião de Segredos e Cupom de ouro rosa) ao investigar ou Recriar em \"Ninho de Vermes\", sem limite diário."
  },
  Activity_24027_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_24027_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Ninho de Vermes\", sem limite diário."
  },
  Activity_24028_ActivityName = {
    Text = "Edify performance"
  },
  Activity_24028_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo orgânico\", sem limite diário."
  },
  Activity_24029_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_24029_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Garganta de Schwarzschild\", sem limite diário."
  },
  Activity_24030_ActivityName = {
    Text = "Edify performance"
  },
  Activity_24030_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo turvo\", sem limite diário."
  },
  Activity_24031_ActivityName = {
    Text = "Explosão de gnose"
  },
  Activity_24031_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Eclodimento de Conhecimento\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Preparação e tempera\", sem limite diário."
  },
  Activity_24032_ActivityName = {
    Text = "Edify performance"
  },
  Activity_24032_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo das Profundezas\", sem limite diário."
  },
  Activity_24033_ActivityName = {
    Text = "Edify performance"
  },
  Activity_24033_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo orgânico\", sem limite diário."
  },
  Activity_24034_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_24034_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Ruínas de Ponape\", sem limite diário."
  },
  Activity_24035_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_24035_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Ninho de Vermes\", sem limite diário."
  },
  Activity_24036_ActivityName = {
    Text = "Duelo de mergulho profundo"
  },
  Activity_24036_ActivityPlot = {
    Text = "Durante o evento, a Experiência do Guardião de Segredos obtida pelo Guardião de Segredos através do \"Mergulho Fantasmal\" e da \"Fase de Duelo\" será dobrada, com o limite diário aumentado para 480 pontos."
  },
  Activity_24036_ActivityTips = {
    Text = "\nRegras do Evento:\n1. Durante o evento \"Mergulho Fantasmagórico e Traphase\", o Guardião receberá o dobro de experiência do guardião a partir de \"Mergulho Fantasmagórico\" e \"Traphase\", com um limite diário aumentado para 480 pontos. Se o assunto principal também estiver desbloqueado, a experiência do guardião obtida por esse caminho será dobrada novamente, com um limite diário permanecendo em 480 pontos.\n2. Quaisquer experiências do guardião dobradas não utilizadas para o dia serão redefinidas às 9:00 AM (GMT+8) do dia seguinte, então lembre-se de usá-las a tempo, Guardião~"
  },
  Activity_24037_ActivityName = {
    Text = "Edify performance"
  },
  Activity_24037_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa de materiais (excluindo Experiência do Guardião de Segredos e Cupom de ouro rosa) ao investigar ou Recriar em \"Resíduo dimensional\", sem limite diário."
  },
  Activity_24038_ActivityName = {
    Text = "Duelo de mergulho profundo"
  },
  Activity_24038_ActivityPlot = {
    Text = "Durante o evento, a Experiência do Guardião de Segredos obtida pelo Guardião de Segredos através do \"Mergulho Fantasmal\" e da \"Fase de Duelo\" será dobrada, com o limite diário aumentado para 480 pontos."
  },
  Activity_24038_ActivityTips = {
    Text = "\nRegras do Evento:\n1. Durante o evento \"Mergulho Fantasmagórico e Traphase\", o Guardião receberá o dobro de experiência do guardião a partir de \"Mergulho Fantasmagórico\" e \"Traphase\", com um limite diário aumentado para 480 pontos. Se o assunto principal também estiver desbloqueado, a experiência do guardião obtida por esse caminho será dobrada novamente, com um limite diário permanecendo em 480 pontos.\n2. Quaisquer experiências do guardião dobradas não utilizadas para o dia serão redefinidas às 9:00 AM (GMT+8) do dia seguinte, então lembre-se de usá-las a tempo, Guardião~"
  },
  Activity_24039_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_24039_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Ninho de Vermes\", sem limite diário."
  },
  Activity_24040_ActivityName = {
    Text = "Explosão de gnose"
  },
  Activity_24040_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Eclodimento de Conhecimento\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Preparação e tempera\", sem limite diário."
  },
  Activity_24041_ActivityName = {
    Text = "Explosão de gnose"
  },
  Activity_24041_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Eclodimento de Conhecimento\", os Guardiões de Segredos receberão 50% a mais de recompensa de Elixir de Gnosis ao investigar ou Recriar em \"Preparação e tempera\", sem limite diário."
  },
  Activity_24042_ActivityName = {
    Text = "Edify performance"
  },
  Activity_24042_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo dimensional\", sem limite diário."
  },
  Activity_24043_ActivityName = {
    Text = "Explosão de gnose"
  },
  Activity_24043_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Eclodimento de Conhecimento\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Preparação e tempera\", sem limite diário."
  },
  Activity_24044_ActivityName = {
    Text = "Estética da Alquimia"
  },
  Activity_24044_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Estética da alquimia\", os Guardiões de Segredos receberão 50% a mais de recompensa de Cupom de ouro rosa ao investigar ou Recriar em \"Busca de cupons de ouro\", sem limite diário."
  },
  Activity_24045_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_24045_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Cluster caótico\", sem limite diário."
  },
  Activity_24046_ActivityName = {
    Text = "Explosão de gnose"
  },
  Activity_24046_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Eclodimento de Conhecimento\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Preparação e tempera\", sem limite diário."
  },
  Activity_24047_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_24047_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa de materiais (excluindo Experiência do Guardião de Segredos e Cupom de ouro rosa) ao investigar ou Recriar em \"Ruínas de Ponape\", sem limite diário."
  },
  Activity_24049_ActivityName = {
    Text = "Edify performance"
  },
  Activity_24049_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo orgânico\", sem limite diário."
  },
  Activity_24050_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_24050_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Ruínas de Ponape\", sem limite diário."
  },
  Activity_24051_ActivityName = {
    Text = "Treinamento intensivo"
  },
  Activity_24051_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Treinamento Intensivo\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Cluster caótico\", sem limite diário."
  },
  Activity_24052_ActivityName = {
    Text = "Explosão de gnose"
  },
  Activity_24052_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Eclodimento de Conhecimento\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Preparação e tempera\", sem limite diário."
  },
  Activity_24053_ActivityName = {
    Text = "Edify performance"
  },
  Activity_24053_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo turvo\", sem limite diário."
  },
  Activity_24054_ActivityName = {
    Text = "Edify performance"
  },
  Activity_24054_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo turvo\", sem limite diário."
  },
  Activity_24055_ActivityName = {
    Text = "Edify performance"
  },
  Activity_24055_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Cena de Ascensão\", os Guardiões de Segredos receberão 50% a mais de recompensa (excluindo Experiência do Guardião de Segredos) ao investigar ou Recriar em \"Resíduo dimensional\", sem limite diário."
  },
  Activity_24194_ActivityName = {
    Text = "Senhora de vermelho"
  },
  Activity_24194_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento \"Dama Vermelha\", os Guardiões podem usar equipes presetadas pelo sistema que incluem Sorel para experimentar níveis designados infinitamente.\n·Ao experimentar os níveis do evento, ajustes nos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_24195_ActivityName = {
    Text = "Florescer de Lodo"
  },
  Activity_24195_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento \"Flor do Lodo\", os Guardiões podem usar equipes presetadas pelo sistema que incluem Lily para experimentar níveis designados infinitamente.\n·Ao jogar os níveis do evento, ajustes nos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_24992_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_24992_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_25011_ActivityName = {
    Text = "Um passo de distância"
  },
  Activity_25011_ActivityPlot = {
    Text = "Você dá um passo à frente e cruza para outro tempo e espaço."
  },
  Activity_25011_ActivityTips = {
    Text = "<Title:Condições de Participação>\n·Completar a exploração da consciência \"Desejo do Cavaleiro\" no modo Normal para participar.\n<Title:Evento de Investigação>\n·Durante o período do evento, um novo evento de investigação de \"Um Passo Distante\" será lançado diariamente. Os Guardiães podem desbloquear e investigar sem consumir o inventário. Após completar o evento de investigação, recompensas como Núcleo Puro, Insígnia de Investigação e Experiência do Guardião podem ser obtidas.\n·Após o término do evento, o progresso da investigação de \"Um Passo Distante\" será retido, e os Guardiães podem consumir Jóias d na exploração da consciência para desbloquear investigações não completadas. Completar eventos de investigação não finalizados durante o período do evento também concederá recompensas consistentes com as do evento.<Title:Recompensas de Tempo Limitado>\n·Recompensas de tempo limitado estarão disponíveis durante o evento. Os Guardiães podem obter Doce da Sorte e recompensas em Prata após finalizar o modo Normal de \"Um Passo Distante\" e completar os eventos de investigação de \"Um Passo Distante\"! As recompensas de tempo limitado estão disponíveis apenas durante o período do evento e não podem ser completadas ou reivindicadas após o término do evento."
  },
  Activity_25011_UnlockConditionExplanation = {
    Text = "Complete o \"Desejo do Cavaleiro\" errante para desbloquear depois"
  },
  Activity_25012_ActivityName = {
    Text = "Hino à Rosa"
  },
  Activity_25012_ActivityPlot = {
    Text = "Senhoras e senhores.\nA noite gentil abriu suas cortinas—preparem sua melhor bebida.\nEsta é uma longa história. Permitam-nos contá-la com calma."
  },
  Activity_25012_ActivityTips = {
    Text = "<Title:Condições de Participação>\n·Completar \"Operação de Investigação\" 2-9 (Normal) para participar.\n<Title:Evento de Investigação>\n·Durante o período do evento, um novo evento de investigação de \"Tributo Rosado\" será lançado diariamente. Guardiões podem desbloquear e investigar sem consumir o inventário. Após completar o evento de investigação, recompensas como Núcleo Puro, Distintivo de Investigação e Experiência do Guardião podem ser obtidas.\n·Após o término do evento, o progresso da investigação de \"Tributo Rosado\" será mantido, e os Guardiões podem consumir Jóias D no Registro Especial para desbloquear investigações não completadas. Completar eventos de investigação não concluídos durante o período do evento também concederá recompensas consistentes com aquelas durante o evento.<Title:Recompensas por Tempo Limitado>\n·Recompensas por tempo limitado estarão disponíveis durante o evento. Os Guardiões podem obter Núcleo Puro, Pedra Filosofal e recompensas de Prata após completar o modo \"Tributo Rosado\" (Normal) e eventos de investigação de \"Tributo Rosado\"! Recompensas por tempo limitado só estão disponíveis durante o período do evento e não podem ser completadas ou reivindicadas após o término do evento."
  },
  Activity_25012_UnlockConditionExplanation = {
    Text = "Desbloqueado após completar \"Operação de Investigação\" 2-9 · Normal"
  },
  Activity_34754_ActivityName = {
    Text = "A Magia da História"
  },
  Activity_34754_ActivityTips = {
    Text = "<Title:Condições de Participação>\n·Complete \"Operação de Investigação\" 2-9 (Normal) para participar.\n<Title:Evento de Investigação>\n·Durante o período do evento, um novo evento de investigação de \"Magia das Histórias\" será lançado diariamente. Os Guardiões podem desbloquear e investigar sem consumir inventário. Após completar o evento de investigação, recompensas como Coração Puro, Insígnia de Investigação e Experiência do Guardião podem ser obtidas.\n·Após o término do evento, o progresso da investigação de \"Magia das Histórias\" será retido. Os Guardiões podem consumir Jóias d em um Registro Especial para desbloquear investigações não completadas. Completar eventos de investigação não finalizados durante o período do evento também concederá recompensas consistentes com aquelas durante o evento.<Title:Recompensas por Tempo Limitado>\n·Recompensas por tempo limitado estarão disponíveis durante o evento. Os Guardiões podem obter Coração Puro, Pedra Filosofal e recompensas de Prata após concluir \"Magia das Histórias\" (modo Normal) e completar eventos de investigação de \"Magia das Histórias\"! As recompensas por tempo limitado só estarão disponíveis durante o período do evento e não podem ser completadas ou reivindicadas após o término do evento."
  },
  Activity_34755_ActivityName = {
    Text = "A Magia da História"
  },
  Activity_34755_ActivityTips = {
    Text = "<Title:Introdução ao Evento>\n· Durante o evento, o modo \"Misterio do roteiro\" estará disponível por tempo limitado, e \"Registro da força-tarefa: A Magia da História\" será desbloqueado gratuitamente!\n\n<Title:Misterio do roteiro>\n· \"Misterio do roteiro\" contém 9 níveis de dificuldade, com uma faixa de nível recomendada de 30 a 70, desbloqueando níveis de dificuldade mais alta após concluir níveis de dificuldade mais baixa.\n· Cada desafio requer o consumo de Lingfétide ×60, e ao concluir cada um, você pode ganhar a moeda do evento \"Inspiração Errante\". Quanto maior a dificuldade do nível, mais \"Inspiração Errante\" você obterá!\n· \"Inspiração Errante\" pode ser trocada na \"Loja de roteiros mágicos\" por uma grande quantidade de materiais de cultivo para Corpo Desperto, além de poder trocar por um SR de Roda do destino limitado ao evento \"Mágica 35mm\", que pode ser relançado ou adicionado ao despertar permanente no futuro.\n· Durante cada desafio, além do líder, inimigos, eventos e mapas podem mudar, e mais Criações podem aparecer no nível!\n· É possível usar aliados da associação na \"Misterio do roteiro\".\n\n<Title:Resonância e Conquistas>\n· Consumindo \"Coração da interpretação\", ative \"Resonância: Código do Diretor\", permitindo que o Guardião se torne mais forte na \"Misterio do roteiro\", tornando os desafios mais fáceis.\n· Os Guardiões do segredo podem obter \"Coração da interpretação\" ao alcançar conquistas do evento, além disso, ao completar conquistas do evento, também podem ganhar o ícone de avatar limitado do evento \"Por nome da Chave de Prata: Lily\"!\n\n<Title:Registro da força-tarefa>\n· Durante o evento, um novo evento de investigação de \"A Magia da História\" será lançado diariamente, e os Guardiões do segredo poderão desbloquear e investigar sem consumir recursos, recebendo recompensas de investigação como Núcleo Imaculado, Medalha de investigação e Experiência do Guardião de Segredos após completar o evento de investigação.\n· Após o término do evento, o progresso da investigação de \"A Magia da História\" será preservado, e os Guardiões do segredo poderão consumir Perola de Erosão para desbloquear investigações não desbloqueadas, recebendo recompensas de investigação consistentes com o evento após completar eventos de investigação não concluídos durante o evento.\n· Durante o evento, recompensas de conquistas limitadas serão oferecidas, e os Guardiões do segredo podem receber recompensas de Núcleo de prata ao concluir o modo normal de \"A Magia da História\" e completar eventos de investigação de \"A Magia da História\"! As recompensas de conquistas estarão disponíveis apenas durante o evento, e não poderão ser completadas ou recebidas após o término do evento.\n"
  },
  Activity_34764_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34765_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34766_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34767_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34768_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34769_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34770_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34771_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34772_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34773_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34774_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34775_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34776_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34777_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34778_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34779_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34780_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34781_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34782_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34783_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34784_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34785_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34786_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34787_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34788_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34789_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34790_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34791_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34792_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34793_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34794_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34795_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34796_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34797_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34798_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34799_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34800_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34801_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34802_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34803_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34804_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34805_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34806_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34807_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34808_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34809_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34810_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34811_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34812_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34813_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34814_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34815_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34816_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34817_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34818_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34819_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34820_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34821_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34822_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34823_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34824_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34825_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34826_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34827_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_34828_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_35844_ActivityName = {
    Text = "Senhora das profundezas"
  },
  Activity_35844_ActivityTips = {
    Text = "<Title:Regras do Evento>\n· Durante o evento \"Senhorita Aequor\", os Guardiães podem usar equipes pré-definidas pelo sistema que incluam Murphy para experimentar níveis designados infinitamente.\n· Durante a experiência do nível do evento, ajustes aos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n· Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_35983_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_35983_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_36841_ActivityName = {
    Text = "Eadem omnia"
  },
  Activity_36841_ActivityPlot = {
    Text = "Este é um dia simples e feliz para Aurita. Este é o dia a dia Dela."
  },
  Activity_36841_ActivityTips = {
    Text = "<Title:Condições de Participação>\n·Complete o modo Normal da exploração da consciência \"Desejo do Cavaleiro\" para participar.\n<Title:Evento de Investigação>\n·Durante o período do evento, os Guardiões podem desbloquear e investigar sem consumir o inventário. Após completar o evento de investigação, recompensas como Núcleo Puro, Badge de Investigação e Experiência do Guardião podem ser obtidas.\n·Após o término do evento, o progresso da investigação de \"Tudo como Sempre\" será mantido. Os Guardiões podem consumir Jóia d na exploração da consciência para desbloquear investigações não concluídas. Completar eventos de investigação não concluídos durante o período do evento também concederá recompensas consistentes com aquelas durante o evento.<Title:Recompensas Limitadas no Tempo>\n·Recompensas limitadas no tempo estarão disponíveis durante o evento. Os Guardiões podem obter o Cadeado das Trevas e recompensas de Prata após finalizar o modo Normal de \"Tudo como Sempre\" e completar os eventos de investigação de \"Tudo como Sempre\"! Recompensas limitadas no tempo estão disponíveis apenas durante o período do evento e não podem ser concluídas ou reivindicadas após o término do evento."
  },
  Activity_36841_UnlockConditionExplanation = {
    Text = "Complete o \"Desejo do Cavaleiro\" errante para desbloquear depois"
  },
  Activity_36885_ActivityName = {
    Text = "Festa Ardente"
  },
  Activity_36886_ActivityName = {
    Text = "Rainha dos Espinhos"
  },
  Activity_36886_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento \"Rainha dos Espinhos\", os Guardiões podem usar equipes presetadas pelo sistema que incluem Wanda para experimentar níveis designados infinitamente.\n·Ao experimentar os níveis do evento, ajustes nos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_38716_ActivityName = {
    Text = "Investigação reiniciada"
  },
  Activity_38716_ActivityTips = {
    Text = "<Title:Event Introduction>\n· Os Guardiães podem reivindicar diretamente as recompensas de \"Suprimento de Reinício\" nas \"Recompensas de Volta às Aulas.\" \n· Complete as tarefas de treinamento designadas para receber recompensas no evento \"Reinício de Investigação\".\n· Completar todas as tarefas de treinamento também concederá recompensas adicionais."
  },
  Activity_38717_ActivityName = {
    Text = "Registro de volta às aulas"
  },
  Activity_38717_ActivityTips = {
    Text = "<Title:Event Overview>\n· Os Guardiães podem reivindicar a recompensa de registro diário em \"Relatório de Volta às Aulas\" após fazer login a cada dia.\n· As recompensas serão desbloqueadas sequencialmente com base nos logins acumulados dos Guardiães, e as recompensas de registro diário serão atualizadas às 9:00 AM (GMT+8)."
  },
  Activity_38805_ActivityName = {
    Text = "Festa Ardente"
  },
  Activity_38805_ActivityPlot = {
    Text = "Isalrauh, a cidade no lago, supostamente é a terra natal de wanda.\nDesta vez você passará pela porta do sonho e chegará àquela antiga torre repleta de línguas de sino"
  },
  Activity_38805_ActivityTips = {
    Text = "<Title:Introdução ao evento>\n·Durante o evento, o modo \"Festa Ardente\" estará disponível por tempo limitado, e a \"Navegação na consciência: Festa Ardente\" será desbloqueada gratuitamente por tempo limitado!\n\n<Title:Cidade no lago>\n·A \"Cidade no lago\" possui 7 fases, com 1 fase aberta a cada 2 dias! Os inimigos e eventos em cada fase podem mudar aleatoriamente.\n·Por favor, note que os tipos, quantidades e proporções dos materiais recompensados em cada fase podem mudar. As fases abertas mais cedo terão tipos mais simples, enquanto as fases abertas mais tarde terão tipos mais variados, mas em maior quantidade. Escolha a estratégia de acordo com suas necessidades!\n·Cada fase contém 7 níveis de dificuldade, com faixa de nível recomendada entre 15 e 65, e todas as dificuldades estão desbloqueadas por padrão.\n·Cada desafio requer o consumo de Lingfétide ×120; quanto maior a dificuldade, mais recompensas você receberá. Escolha uma dificuldade que se adapte a você para o desafio.\n·Os materiais recompensados nas fases podem ser trocados na loja \"A Caixa de Tesouros Exóticos de Wanda\" por muitos materiais de cultivo do Corpo Desperto, além do avatar exclusivo do evento \"Por nome da Chave de Prata: Wanda\".\n·Você pode usar o apoio da associação de ex-alunos e \"Resonância: Ordem secreta\" para ajudá-lo a passar pelas fases mais facilmente.\n\n<Title:Resonância e Conquista>\n·Consumindo \"Coração do prazer\", ative \"Resonância: Ordem secreta\", o que permitirá que o Guardião se torne mais forte na \"Cidade no lago\", tornando os desafios mais fáceis; também permite que o Guardião receba moeda do evento adicional ao concluir.\n·Os Guardiões do segredo podem obter \"Coração do prazer\" ao completar conquistas do evento, ou podem trocá-lo na loja \"A Caixa de Tesouros Exóticos de Wanda\".\n\n<Title:Navegação na consciência>\n·Durante o evento, \"Festa Ardente\" pode ser desbloqueada gratuitamente. Todos os dias, um novo evento de investigação será lançado em \"Festa Ardente\", e ao completar o evento de investigação, você pode ganhar Núcleo Imaculado, Medalha de investigação e experiência do Guardião de segredos como recompensas de investigação.\n·Após o término do evento, o progresso da investigação de \"Festa Ardente\" será mantido, e ao completar eventos de investigação não concluídos durante o evento, você poderá receber recompensas de investigação iguais às do período do evento. Se \"Festa Ardente\" não foi desbloqueada durante o evento, ainda será possível desbloqueá-la consumindo \"Ponto de partida real\" ×3 após o término do evento.\n·Durante o evento, recompensas de conquista por tempo limitado serão lançadas. Após completar os eventos de investigação de \"Festa Ardente\", os Guardiões do segredo poderão receber recompensas de Núcleo de prata nas conquistas do evento! As recompensas de conquista estarão disponíveis apenas durante o evento, e não poderão ser completadas ou coletadas após o término do evento.\n"
  },
  Activity_41378_ActivityName = {
    Text = "Treinamento Especial para Desastres"
  },
  Activity_41378_ActivityTips = {
    Text = "\nRegras do Evento:\n1. Após completar as tarefas especificadas, os Guardiões podem reivindicar recompensas em \"Treinamento de Desastre Bem-vindo\".\n2. \"Treinamento de Desastre Bem-vindo\" está permanentemente disponível.\n3. Após desbloquear \"Viagem Avançada\", os Guardiões podem receber recompensas adicionais ao completar tarefas.\n4. Por favor, note: A \"Viagem Avançada\" desbloqueada neste evento é válida somente durante este evento. Os Guardiões são aconselhados a consumir de forma racional."
  },
  Activity_43569_ActivityName = {
    Text = "Viagem oceânica"
  },
  Activity_43569_ActivityTips = {
    Text = "\nRegras do Evento:\n1. Após completar as tarefas de jornada especificadas, os Guardiões podem reivindicar recompensas em \"Viagem Oceânica\".\n2. \"Viagem Oceânica\" está permanentemente aberta.\n3. Após desbloquear \"Viagem Avançada\", os Guardiões podem receber recompensas adicionais ao completar tarefas.\n4. Por favor, note: A \"Viagem Avançada\" desbloqueada neste evento é válida somente durante este evento. Os Guardiões são aconselhados a consumir de forma racional."
  },
  Activity_43570_ActivityName = {
    Text = "Viagem à Vila da Neve"
  },
  Activity_43570_ActivityTips = {
    Text = "\nRegras do Evento:\n1. Após completar as tarefas de jornada especificadas, os Guardiões podem reivindicar recompensas em \"Viagem à Cidade da Neve\".\n2. \"Viagem à Cidade da Neve\" está permanentemente aberta.\n3. Após desbloquear \"Viagem Avançada\", os Guardiões podem receber recompensas adicionais ao completar tarefas.\n4. Por favor, note: A \"Viagem Avançada\" desbloqueada neste evento é válida somente durante este evento. Os Guardiões são aconselhados a consumir de forma razoável."
  },
  Activity_43572_ActivityName = {
    Text = "Estética da Alquimia"
  },
  Activity_43572_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Estética da alquimia\", os Guardiões do segredo receberão um bônus extra de 100% (excluindo Experiência do Guardião de Segredos) ao investigar ou reencenar em \"Busca de cupons de ouro\", limitado a 6 vezes por dia."
  },
  Activity_43573_ActivityName = {
    Text = "Estética da Alquimia"
  },
  Activity_43573_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Estética da alquimia\", os Guardiões do segredo receberão um bônus extra de 50% de Cupom de ouro rosa ao investigar ou reencenar em \"Busca de cupons de ouro\"."
  },
  Activity_43574_ActivityName = {
    Text = "Estética da Alquimia"
  },
  Activity_43574_ActivityTips = {
    Text = "Regras do evento:\n1. Durante o evento \"Estética da alquimia\", os Guardiões do segredo receberão um bônus extra de 50% de Cupom de ouro rosa ao investigar ou reencenar em \"Busca de cupons de ouro\"."
  },
  Activity_44273_ActivityName = {
    Text = "Pastor de almas"
  },
  Activity_44273_ActivityPlot = {
    Text = "Ele sofreu por você, suportou suas tribulações.\nAtravés da Carne e sangue que Ele sacrificou, você foi curado;\nAtravés da Vida que Ele deu, você foi perdoado."
  },
  Activity_44273_ActivityTips = {
    Text = "<Title:Descrição do Evento>\n1, Durante o evento, os Guardiões do Segredo podem coletar a moeda do evento \"Bônus de Venda Beneficente\" através de modos de jogo limitados \"Caminho do Santuário\", \"Bondade dos Cidadãos\" e \"Recompensa de Conquista\". Os \"Bônus de Venda Beneficente\" podem ser trocados por itens aleatórios na \"Venda Beneficente do Santuário\", incluindo a roda do destino SR exclusiva do evento \"Homem no Espelho\", Núcleo Imaculado, Núcleo de Lumen e outros. \n2, Completar \"Registro da Força-Tarefa: A Cor do Sangue\" concede a nova Ordem de Chave \"Chegada do Milagre\". Durante o evento, \"Registro da Força-Tarefa: A Cor do Sangue\" pode ser desbloqueado gratuitamente por tempo limitado, e completar as conquistas do evento também concede o avatar exclusivo do evento \"Por Nome da Chave de Prata: Salvador\"!\n\n<Title:Caminho do Santuário>\n1, \"Caminho do Santuário\" contém 5 fases, os Guardiões do Segredo podem desbloqueá-las completando as fases 2/4/6/7/9 de \"Registro da Força-Tarefa: A Cor do Sangue\". \n2, Cada fase possui 7 níveis de dificuldade, com níveis recomendados de 15 a 65, e todos os níveis de dificuldade estão desbloqueados por padrão. Os inimigos e eventos de cada fase podem mudar aleatoriamente. \n3, É possível usar a ajuda da Associação de Ex-Alunos e \"Ressonância: O Desvio da Alma\" para ajudar a passar pelas fases mais facilmente. \n4, Cada desafio requer 120 Lingfétide, quanto maior a dificuldade, mais \"Bônus de Venda Beneficente\" serão obtidos ao completar, além disso, os Guardiões do Segredo podem optar por um desafio em dobro, consumindo 240 Lingfétide, para ganhar o dobro de \"Bônus de Venda Beneficente\" e experiência de Guardião do Segredo. \n\n<Title:Bônus de Brilho>\n1, Sob a influência do \"Brilho da Alma\", o Corpo Desperto \"Salvador\", a roda do destino SSR \"Tábula das Escrituras\" e a roda do destino SR \"Homem no Espelho\" podem proporcionar um bônus extra nas recompensas de \"Bônus de Venda Beneficente\" nas missões das fases do \"Caminho do Santuário\". Os bônus específicos são os seguintes: \n(1) Método Um: O Guardião do Segredo possui um Corpo Desperto ou roda do destino específica (não é necessário estar em combate) \n· Corpo Desperto \"Salvador\": Despertar 0/1/2/3 ou mais, bônus de 30%/40%/50%/60%. \n· Roda do Destino SSR \"Tábula das Escrituras\": Sobreposição 0/1/2/3 ou mais, bônus de 30%/40%/50%/60%. \n· Roda do Destino SR \"Homem no Espelho\": Sobreposição 0/1/2/3 ou mais, bônus de 15%/20%/25%/30%. \n(2) Método Dois: Usar Corpo Desperto ou roda do destino específica para ajudar \n· Corpo Desperto \"Salvador\": bônus de 10%. \n· Roda do Destino SSR \"Tábula das Escrituras\": bônus de 10%. \n· Roda do Destino SR \"Homem no Espelho\": bônus de 5%. \n2, Para o mesmo Corpo Desperto ou roda do destino, o \"Bônus de Brilho\" será aplicado de acordo com a maneira que conceder o maior bônus, sem acumulação. \n3, O \"Bônus de Brilho\" de diferentes Corpos Despertos ou rodas do destino será calculado de forma acumulativa, seguindo as regras acima, o Guardião do Segredo pode obter no máximo 150% de \"Bônus de Brilho\"!\n\n<Title:Ressonância: O Desvio da Alma>\n1, Os Guardiões do Segredo podem obter \"Coração de Penitência\" completando as conquistas do evento. \n2, Consumindo \"Coração de Penitência\", ativar \"Ressonância: O Desvio da Alma\" pode conceder os seguintes bônus: \n(1) Permite que os Guardiões do Segredo se tornem mais fortes nos modos de jogo \"Caminho do Santuário\" e \"Registro da Força-Tarefa: A Cor do Sangue\", tornando os desafios mais fáceis. \n(2) Aumenta a taxa de sincronia obtida após completar o desafio do \"Caminho do Santuário\". \n(3) Ativa o modo de jogo \"Bondade dos Cidadãos\".\n\n<Title:Bondade dos Cidadãos>\n1, Após ativar a ressonância \"Forma Fácil\", ganha automaticamente 60 \"Bônus de Venda Beneficente\" a cada hora, armazenando até 25 horas. \n2, Após ativar a ressonância \"Redenção, Redenção\", ganha automaticamente 1800 cupons de ouro rosa a cada hora. \n\n<Title: Venda Beneficente do Santuário>\n1, Os Guardiões do Segredo podem usar \"Bônus de Venda Beneficente\" para trocar aleatoriamente por itens nas lojas da \"Venda Beneficente do Santuário\", incluindo a roda do destino SR exclusiva do evento \"Homem no Espelho\", Núcleo de Lumen e Núcleo Imaculado, entre outros itens esperando por você~ \n2, A Venda Beneficente do Santuário possui três lojas, com os seguintes horários de abertura: \n· Loja \"Loja da Sra. Grey\": aberta desde o início. \n· Loja \"Venda Mágica do Grande John\": aberta no 4º dia do evento. \n· Loja \"Venda especial de Smith\": aberta no 7º dia do evento. \n3, Os itens nas diferentes lojas são variados, os Guardiões do Segredo podem escolher os itens de acordo com suas necessidades. \n4, Cada loja contém itens especiais e comuns, cada troca consumirá 600 \"Bônus de Venda Beneficente\", ganhando aleatoriamente cinco itens da loja. \n5, Quando todos os itens especiais da loja forem trocados, os Guardiões do Segredo podem solicitar que a loja reabasteça os itens, ou optar por continuar trocando. Quando todos os itens da loja forem trocados, os Guardiões do Segredo devem escolher reabastecer os itens antes de continuar a troca. \n6, As duas primeiras vezes que a loja reabastecer os itens, a quantidade restante de todos os itens da loja será reabastecida ao limite, a partir da terceira vez de reabastecimento, os itens especiais não serão mais reabastecidos, apenas os itens comuns. Após reabastecer os itens, a quantidade restante dos itens que não foram trocados não será preservada, os Guardiões do Segredo devem pensar cuidadosamente antes de escolher reabastecer os itens~ \n\n<Title:Registro da Força-Tarefa>\n1, Durante o evento, o Registro da Força-Tarefa \"A Cor do Sangue\" pode ser desbloqueado gratuitamente. A cada 2 dias, um novo evento de investigação \"A Cor do Sangue\" será lançado, completando o evento de investigação pode conceder a Ordem de Chave \"Chegada do Milagre\", Núcleo Imaculado, Medalha de Investigação e experiência de Guardião do Segredo como recompensas de investigação. \n2, Após o término do evento, o progresso da investigação de \"A Cor do Sangue\" será preservado, completando os eventos de investigação que não foram concluídos durante o evento também concederá recompensas de investigação idênticas às do evento. Se \"A Cor do Sangue\" não foi desbloqueado durante o evento, ainda será possível consumir \"Ponto de Partida Real\" ×7 para desbloquear após o término do evento. \n3, Durante o evento, serão lançadas recompensas limitadas de conquistas, após os Guardiões do Segredo completarem todos os eventos de investigação de \"A Cor do Sangue\", poderão receber o avatar \"Por Nome da Chave de Prata: Salvador\" nas conquistas do evento! As recompensas de conquista estarão disponíveis apenas durante o evento, não podendo ser completadas ou recebidas após o término do evento. \n\n"
  },
  Activity_44626_ActivityName = {
    Text = "Pastor de almas"
  },
  Activity_44705_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_44705_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_44706_ActivityName = {
    Text = "Bishop de bálsamos"
  },
  Activity_44706_ActivityTips = {
    Text = "<Title:Regras da Atividade>\n·Durante o evento \"Bispo Benevolente\", os Guardiães podem usar equipes pré-definidas pelo sistema contendo Salvador para experimentar níveis designados um número ilimitado de vezes.\n·Ao jogar os níveis do evento, ajustes no Despertar do alinhamento da equipe não podem ser feitos.\n<Title:Recompensas da Atividade>\n·Após completar com sucesso um desafio de nível pela primeira vez, você pode reivindicar recompensas de teste na interface do evento."
  },
  Activity_44716_ActivityName = {
    Text = "Soberano adormecido"
  },
  Activity_44716_ActivityTips = {
    Text = "<Title:Event Rules>\n·Durante o evento \"Soberano do Sono\", os Guardiães podem usar equipes pré-definidas pelo sistema que incluem Tulu para experimentar níveis designados infinitamente.\n·Ao experimentar níveis do evento, ajustes aos Despertadores na formação da equipe não são permitidos.\n<Title:Event Rewards>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_45664_ActivityName = {
    Text = "A queda de um gigante"
  },
  Activity_45664_ActivityPlot = {
    Text = "O oceano infinito, o sol ardente, um herói Filisteu exilado e seu único acompanhante.\nEsta é uma história sobre \"busca.\""
  },
  Activity_45664_ActivityTips = {
    Text = "<Title:Condições de Participação>\nConclua a Navegação na consciência \"O Desejo do Cavaleiro\" modo Normal para participar.\n<Title:Investigação de eventos>\nDurante o período do evento, Guardiões do segredo podem desbloquear e investigar sem consumir inventário. Após concluir a investigação de eventos, recompensas como Núcleo Imaculado, Medalha de investigação e Experiência do Guardião de Segredos podem ser obtidas.\nApós o término do evento, o estado de desbloqueio e o progresso de investigação de \"A Queda do Gigante\" serão mantidos. Concluir investigações de eventos não concluídas durante o período do evento também concederá recompensas consistentes com as do evento; se não desbloqueado durante o período do evento, poderá ser desbloqueado após o término do evento consumindo Ponto de partida real *3.<Title:Recompensas por Tempo Limitado>\nRecompensas por tempo limitado estarão disponíveis durante o evento. Guardiões do segredo podem obter recompensas de Cristal de dimensão e Prata após concluir \"A Queda do Gigante\" modo Normal e completar investigações de eventos de \"A Queda do Gigante\"! Recompensas por tempo limitado estão disponíveis apenas durante o período do evento e não podem ser concluídas ou reivindicadas após o término do evento."
  },
  Activity_45664_UnlockConditionExplanation = {
    Text = "Complete o \"Desejo do Cavaleiro\" errante para desbloquear depois"
  },
  Activity_46167_ActivityName = {
    Text = "Paciente dissociativo: caos"
  },
  Activity_46167_ActivityTips = {
    Text = "<Title:Regras da Atividade>\n·Durante o evento \"Paciente Fragmentado: Caos\", os Guardiães podem usar equipes pré-definidas pelo sistema contendo \"24\" para experimentar níveis designados um número ilimitado de vezes.\n·Ao jogar os níveis do evento, ajustes no Despertar do alinhamento da equipe não podem ser feitos.\n<Title:Recompensas da Atividade>\n·Após completar com sucesso um desafio de nível pela primeira vez, você pode reivindicar recompensas de teste na interface do evento."
  },
  Activity_46168_ActivityName = {
    Text = "Caçadora de crânios"
  },
  Activity_46168_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento \"Caçadora de Cranios\", os Guardiões podem usar equipes presetadas pelo sistema que incluem Narciso para experimentar níveis designados infinitamente.\n·Ao experimentar os níveis do evento, ajustes nos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_46609_ActivityName = {
    Text = "Cura Múltipla"
  },
  Activity_46609_ActivityPlot = {
    Text = "Histeria. Chame de mania, chame de destruição da mente; nesta era, o diagnóstico é uma sentença de morte. Felizmente, os cientistas e investigadores da Misaq são possuídos por uma loucura própria: estão determinados a conquistar esse terror."
  },
  Activity_46609_ActivityStageEndContent = {
    Text = "O evento terminou. Atualmente, apenas \"Análise de Personalidade\" está disponível."
  },
  Activity_46609_ActivityTips = {
    Text = "<Title:Introdução ao Evento>\n1, Durante o evento, os Guardiões podem coletar a moeda do evento \"Puzzle de Memória\" através de modos limitados \"Código de Memória\", \"Armazenamento de Bordas\" e \"Recompensas de Conquista\". \"Puzzle de Memória\" pode ser usado para comprar itens na \"Análise de Personalidade\", incluindo a roda do destino SR exclusiva do evento \"Determinação do Bacalhau Prateado\", Núcleo de Lumen, Núcleo Imaculado, Pedra Filosofal e materiais de cultivo abundantes.\n2, Completar \"Registro da Força-Tarefa: Fissão Tranquila\" concede a nova Ordem de Chave \"Tudo dela\". Durante o evento, \"Registro da Força-Tarefa: Fissão Tranquila\" será desbloqueado gratuitamente por tempo limitado, e completar as conquistas do evento também concede o avatar exclusivo do evento \"Por nome da Chave de Prata: \"24\"#!\n\n<Title:Tempo do Evento>\n1, 27 de abril, 9:00 - 18 de maio, 9:00 (GMT+8), todos os modos do evento podem ser participados, \"Registro da Força-Tarefa: Fissão Tranquila\" será desbloqueado gratuitamente por tempo limitado.\n2, 18 de maio, 9:00 - 25 de maio, 9:00 (GMT+8), apenas \"Análise de Personalidade\" e Recompensas de Conquista podem ser participadas, \"Registro da Força-Tarefa: Fissão Tranquila\" requer 7 Pontos de Partida Real para desbloquear.\n\n<Title:Código de Memória>\n1, \"Código de Memória\" contém 5 fases, os Guardiões podem desbloquear uma a uma completando as fases 2/4/6/8/10 de \"Registro da Força-Tarefa: Fissão Tranquila\".\n2, Cada fase tem 7 dificuldades, com níveis recomendados de 15 a 65, todas as dificuldades estão desbloqueadas por padrão. Os inimigos e eventos de cada fase podem mudar aleatoriamente.\n3, Pode-se usar a assistência da Aliança de Antigos e \"Ressonância: Síndrome de Separação\" para ajudar a passar mais facilmente.\n4, Cada desafio consome 120 Lingfétide, quanto maior a dificuldade, mais \"Puzzle de Memória\" é obtido ao completar, além disso, os Guardiões podem escolher um desafio duplo, consumindo 240 Lingfétide, ganhando o dobro de \"Puzzle de Memória\" e experiência do Guardião.\n\n<Title:Aumento Racional>\n1, Guardiões que possuem corpos Despertados ou rodas do destino específicas (não é necessário estar em combate) podem fazer com que as recompensas da missão na fase \"Código de Memória\" tenham um aumento extra na queda de \"Puzzle de Memória\", os aumentos específicos são os seguintes:\n· Corpo Despertado \"24\": Despertar 0/1/2/3 ou mais, aumento de 15%/20%/25%/30%.\n· Corpo Despertado \"Daffodil\": Despertar 0/1/2/3 ou mais, aumento de 15%/20%/25%/30%.\n· Roda do Destino SSR \"Restituição do Corpo Deformado\": Sobreposição 0/1/2/3 ou mais, aumento de 15%/20%/25%/30%.\n· Roda do Destino SSR \"Raridade Preciosa\": Sobreposição 0/1/2/3 ou mais, aumento de 15%/20%/25%/30%.\n· Roda do Destino SR \"Determinação do Bacalhau Prateado\": Sobreposição 0/1/2/3 ou mais, aumento de 15%/20%/25%/30%.\n2, O \"Aumento Racional\" de diferentes corpos Despertados ou rodas do destino é calculado de forma acumulativa.\n\n<Title:Ressonância: Síndrome de Separação>\n1, Os Guardiões podem obter \"Coração Dividido\" completando conquistas do evento.\n2, Consumindo \"Coração Dividido\", ativando \"Ressonância: Síndrome de Separação\", é possível obter os seguintes aumentos:\n(1) Fazendo com que os Guardiões se tornem mais fortes nos modos de evento \"Código de Memória\" e \"Registro da Força-Tarefa: Fissão Tranquila\", tornando os desafios mais fáceis.\n(2) Aumenta as recompensas obtidas após completar o desafio \"Código de Memória\".\n(3) Ativa o modo de evento \"Armazenamento de Bordas\".\n\n<Title: Armazenamento de Bordas>\n· Após ativar a ressonância \"Diagnóstico: Esquizofrenia\", você recebe automaticamente 60 \"Puzzle de Memória α\" a cada hora, podendo armazenar no máximo por 25 horas.\n\n<Title:Registro da Força-Tarefa>\n1, Durante o evento, \"Registro da Força-Tarefa: Fissão Tranquila\" pode ser desbloqueado gratuitamente. A cada 2 dias, novos eventos de investigação \"Fissão Tranquila\" serão lançados, completando os eventos de investigação você pode obter a Ordem de Chave \"Tudo dela\", Núcleo Imaculado, Medalha de Investigação e experiência do Guardião como recompensas de investigação.\n2, Após o término do evento, o progresso da investigação de \"Registro da Força-Tarefa: Fissão Tranquila\" será mantido, completando eventos de investigação não concluídos durante o evento ainda será possível obter recompensas de investigação consistentes com o período do evento. Se \"Registro da Força-Tarefa: Fissão Tranquila\" não for desbloqueado durante o evento, ainda será possível desbloquear consumindo 7 Pontos de Partida Real após o término do evento.\n3, Durante o evento, recompensas de conquista limitadas serão lançadas, após completar todos os eventos de investigação de \"Registro da Força-Tarefa: Fissão Tranquila\", os Guardiões poderão receber o avatar \"Por nome da Chave de Prata: \"24\"\" nas conquistas do evento! As recompensas de conquista estarão disponíveis apenas durante o evento, não poderão ser completadas ou recebidas após o término do evento.\n\n\n"
  },
  Activity_46609_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_47534_ActivityName = {
    Text = "Fissão Tranquila"
  },
  Activity_48136_ActivityName = {
    Text = "Paciente dissociativo: aequor"
  },
  Activity_48136_ActivityTips = {
    Text = "<Title:Regras da Atividade>\n·Durante o evento \"Paciente Fragmentado: Aequor\", os Guardiães podem usar equipes pré-definidas pelo sistema contendo \"24\" para experimentar níveis designados um número ilimitado de vezes.\n·Ao jogar os níveis do evento, ajustes no Despertar do alinhamento da equipe não podem ser feitos.\n<Title:Recompensas da Atividade>\n·Após completar com sucesso um desafio de nível pela primeira vez, você pode reivindicar recompensas de teste na interface do evento."
  },
  Activity_48137_ActivityName = {
    Text = "Paciente dissociativo: caro"
  },
  Activity_48137_ActivityTips = {
    Text = "<Title:Event Rules>\n·Durante o evento \"Paciente Dividido: Caro\", os Guardiães podem usar equipes pré-definidas pelo sistema que incluem \"24\" para experimentar níveis designados infinitamente.\n·Ao experimentar níveis do evento, ajustes aos Despertadores na formação da equipe não são permitidos.\n<Title:Event Rewards>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_48138_ActivityName = {
    Text = "Paciente dissociativo: ultra"
  },
  Activity_48138_ActivityTips = {
    Text = "<Title:Event Rules>\n·Durante o evento \"Paciente Dividido: Ultra\", os Guardiães podem usar equipes pré-definidas pelo sistema que incluem \"24\" para experimentar níveis designados infinitamente.\n·Ao experimentar níveis do evento, ajustes aos Despertadores na formação da equipe não são permitidos.\n<Title:Event Rewards>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_48719_ActivityName = {
    Text = "Ondas de Desejo"
  },
  Activity_48719_ActivityPlot = {
    Text = "Sonhos são a revelação de desejos submersos. Aqueles que neles permanecem serão enredados pelas marés de desejo, tornando-se apóstolos da luxúria—a menos que..."
  },
  Activity_48719_ActivityStageEndContent = {
    Text = "O evento foi Concluído. Atualmente, apenas \"Desejo Corrupto\" está disponível."
  },
  Activity_48719_ActivityTips = {
    Text = "<Title:Descrição do evento>\n1. Durante o evento, o guardião poderá coletar a moeda do evento \"Sementes Mães\" através da jogabilidade limitada \"Desejo caótico\" e das \"Recompensas de Conquista\". As \"Sementes Mães\" podem ser trocadas por recompensas em \"Proliferação de Desejos\", incluindo Núcleo de Lumen, Núcleo Imaculado e valiosos materiais de desenvolvimento.\n2. Durante o evento, os guardiões que completarem a \"Operação de Investigação\" 2-9·Normal também poderão participar do \"Frenesi Reprodutivo\", e não será necessário atender aos requisitos de taxa de sincronização dos Corpos Despertados para desbloquear o \"Evento de Frenesi Reprodutivo\", além disso, a quantidade necessária de \"Ponto de partida real\" será reduzida para apenas 1!\n3. A chegada de uma força misteriosa parece ajudar você a estabelecer uma relação mais profunda com os Corpos Despertados. Durante o evento, a taxa de sincronização obtida por todos os meios será dobrada!\n\n<Title:Período do evento>\n1. 18 de maio 9:00 - 3 de junho 9:00 (GMT+8), todo o conteúdo descrito na descrição do evento estará disponível.\n2. 3 de junho 9:00 - 10 de junho 9:00 (GMT+8), apenas \"Proliferação de Desejos\" e \"Recompensas de Conquista\" estarão disponíveis, os demais conteúdos terão sido encerrados e não estarão mais acessíveis.\n\n<Title:Desejo caótico>\n1. \"Desejo caótico\" contém 10 estágios de materiais nos quais não é necessário explorar, indo diretamente para a batalha, sendo liberado 1 por dia.\n2. Nestes estágios de materiais, você despertará diretamente todos os Corpos Despertados e receberá Relíquias pré-definidas, além disso, após o sexto turno, receberá uma vez a ajuda de Thais.\n3. Cada desafio consome 60 pontos de endorfina, e após concluir os estágios desta atividade, será possível recriá-los.\n4. Você poderá usar o apoio dos Alumni para facilitar a conclusão dos estágios.\n\n<Title:Benefício de Ganância>\n1. Quando o guardião possuir Corpos Despertados ou Rodas do destino específicas (não é necessário tê-los em combate), isso concederá um bônus adicional na quantidade de \"Sementes Mães\" obtidas nas recompensas das missões dos estágios de \"Desejo caótico\" (incluindo recriações), conforme segue:\nCorpo Desperto \"Thais\": Despertar Espiritual 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%\nRoda de destino SSR \"Nutrição Misericordiosa\": Pilha 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%\nRoda de destino SR \"Queimar Adeus\": Pilha 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%\n2. Os \"Benefícios de Ganância\" de diferentes Corpos Despertados ou Rodas do destino são acumulativos.\n\n<Title:Frenesi Reprodutivo>\n1. Após concluir \"Operação de Investigação\" 7-3·Normal, será aberto o novo conteúdo especial de investigação \"Frenesi Reprodutivo\"!\n2. Com a chegada do evento \"Onda de Desejo\", os Corpos Despertados foram afetados por uma força misteriosa, caindo no estado de \"Frenesi Reprodutivo\"... Cuidem-se, guardiões!\n3. Quando a taxa de sincronização do Corpo Desperto atingir o nível 10, será possível desbloquear o \"Evento de Frenesi Reprodutivo\" deste Corpo Desperto, consumindo 7 \"Ponto de partida real\" para desbloquear, e ao completar você receberá 1 \"Núcleo Imaculado\"!\n4. Durante o evento \"Onda de Desejo\" (antes das 9:00 do dia 3 de junho), as condições para participação serão relaxadas para concluir a \"Operação de Investigação\" 2-9·Normal, e não será necessário atender aos requisitos de taxa de sincronização dos Corpos Despertados para desbloquear o \"Evento de Frenesi Reprodutivo\", além disso, a quantidade necessária de \"Ponto de partida real\" será reduzida para apenas 1!\n\n<Title:Sincronização Dobrada>\n1. A chegada de uma força misteriosa parece ajudar você a estabelecer uma relação mais profunda com os Corpos Despertados. Durante o evento, a taxa de sincronização obtida por todos os meios será dobrada!\n2. Será calculada de forma multiplicativa com outras bonificações de taxa de sincronização, como o bônus de sincronização por usar apoio.\n<Title:Recompensas de Conquista>\n1. Ao completar todas as missões, você receberá recompensas: Prata*800, grande quantidade de \"Sementes Mães\", Roda de destino SR exclusiva do evento \"Queimar Adeus\"*16 e avatar exclusivo do evento \"Em Nome da Chave de prata: Thais\".\n2. Contém 16 missões: Concluir cada estágio de \"Desejo caótico\" uma vez, recriar um total de 10/20/30/40/50 vezes em \"Desejo caótico\", completar todas as conquistas do evento.\n\n\n\n"
  },
  Activity_48719_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_48825_ActivityName = {
    Text = "Gratidão do gato da escola"
  },
  Activity_48825_ActivityPlot = {
    Text = "Os Guardiões do segredo podem escolher 1 dos seguintes Corpos Despertos limitados para Despertar!"
  },
  Activity_48825_ActivityTips = {
    Text = "<Title:Visão Geral>\nSe não fosse pela sua vigilância entusiástica, Misaq poderia ter ficado para sempre enterrado na longa noite. Agora, cumprimos nossa promessa, atravessamos dificuldades e chegamos ao momento de meio aniversário. Por isso, o gato da escola lhe presenteará com um presente especial como forma de agradecimento pela sua companhia ao longo de todo esse tempo.\n\n<Title:Regras do Evento>\nDurante o evento, cada Guardião pode escolher 1 Corpo Desperto entre 8 Corpos Despertos SSR limitados, incluindo Tulu, Daffodil, Sorel, Lily, Murphy, Wanda, Salvador e \"24\".\nQuando um Guardião selecionar um Corpo Desperto já despertado, ele será convertido no Fragmento correspondente*1 e sedimento fundamental*50; se o nível de Despertar Espiritual do Corpo Desperto correspondente estiver completo, será convertido em Fragmento de núcleo espiritual*1 e sedimento fundamental*150."
  },
  Activity_48825_BannerText = {
    Text = "Despertador Limitado Grátis"
  },
  Activity_48826_ActivityName = {
    Text = "Amanhecer e Crepúsculo"
  },
  Activity_48826_ActivityPlot = {
    Text = "Faça login diariamente para reivindicar a Roda do destino SSR limitada comemorativa \"Amanhecer e Crepúsculo\", até 16 no total!"
  },
  Activity_48826_ActivityTips = {
    Text = "<Title:Introdução>\nEste é um poema dedicado aos jogadores, sobre ideais, sobre fé e sobre o tempo passado juntos. Que o coração sincero nunca deixe de bater, e que a Chave de Prata guie o caminho adiante.\n\n<Title:Regras do Evento>\n· Durante o evento, os Guardiões podem fazer login diariamente para receber a roda comemorativa limitada SSR \"Noite Polar e Aurora\" de \"Noite Polar e Aurora\", com um total de até 16 reivindicações.\n· As recompensas serão desbloqueadas sequencialmente com base nos logins diários cumulativos dos Guardiões, e as recompensas diárias de login serão atualizadas às 9h (GMT+8)."
  },
  Activity_48826_BannerText = {
    Text = "Roda do destino SSR Limitada Grátis"
  },
  Activity_48827_ActivityName = {
    Text = "Prata no chapéu"
  },
  Activity_48827_ActivityPlot = {
    Text = "De acordo com estatísticas incompletas, nos últimos seis meses, o chapéu do Gato da escola foi acariciado milhares de vezes pelos Estudantes, e muitos pedaços minúsculos e discretos de Prata caíram no chão sem serem notados. Os zeladores ficaram bastante incomodados com isso. A escola agora recolheu e limpou completamente esses pedaços de Prata, armazenando-os nos achados e perdidos. Os proprietários são aconselhados a comparecer para reivindicá-los prontamente."
  },
  Activity_48827_ActivityTips = {
    Text = "<Title:Visão geral>\nDe acordo com estatísticas incompletas, nos últimos seis meses, os estudantes tiraram milhares de fotos do chapéu do gato da escola. Muitos pedaços pequenos e discretos de Prata caíram no chão, mas permanecem sem dono. Os zeladores responsáveis pela limpeza estão bastante incomodados. A escola agora recolheu esses pedaços de Prata, limpou-os completamente e os armazenou nos achados e perdidos. Os legítimos proprietários são convidados a comparecer para reivindicá-los.\n\n<Title:Regras do Evento>\nDurante o evento, os Guardiões do segredo podem fazer login diariamente para reivindicar 1000 de Prata em \"Núcleo de prata no chapéu\", com um máximo de 5 reivindicações.\nAs recompensas serão desbloqueadas sequencialmente com base nos logins acumulados dos Guardiões do segredo, e as recompensas diárias de login serão atualizadas às 9h (GMT+8)."
  },
  Activity_48827_BannerText = {
    Text = "Faça login para reivindicar toneladas de Prata"
  },
  Activity_48849_ActivityName = {
    Text = "Apóstolo do mar"
  },
  Activity_48849_ActivityTips = {
    Text = "<Title:Regras do Evento>\n· Durante o evento \"Apostolo do Mar\", os Guardiães podem usar equipes pré-definidas pelo sistema que incluam Miryam para experimentar níveis designados infinitamente.\n· Ao experimentar os níveis do evento, ajustes aos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n· Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_48850_ActivityName = {
    Text = "Sopro de fertilidade"
  },
  Activity_48850_ActivityTips = {
    Text = "<Title:Regras da Atividade>\n·Durante o evento \"Sopro Abundante\", os Guardiães podem usar equipes pré-definidas pelo sistema contendo Táias para experimentar níveis designados um número ilimitado de vezes.\n·Ao jogar os níveis do evento, ajustes no Despertar do alinhamento da equipe não podem ser feitos.\n<Title:Recompensas da Atividade>\n·Após completar com sucesso um desafio de nível pela primeira vez, você pode reivindicar recompensas de teste na interface do evento."
  },
  Activity_48851_ActivityName = {
    Text = "Senhora das profundezas"
  },
  Activity_48851_ActivityTips = {
    Text = "<Title:Regras do Evento>\n· Durante o evento \"Senhorita Aequor\", os Guardiães podem usar equipes pré-definidas pelo sistema que incluam Murphy para experimentar níveis designados infinitamente.\n· Durante a experiência do nível do evento, ajustes aos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n· Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_48852_ActivityName = {
    Text = "Rainha dos Espinhos"
  },
  Activity_48852_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento \"Rainha dos Espinhos\", os Guardiões podem usar equipes presetadas pelo sistema que incluem Wanda para experimentar níveis designados infinitamente.\n·Ao experimentar os níveis do evento, ajustes nos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_48853_ActivityName = {
    Text = "Poema Sem Nome"
  },
  Activity_48853_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento \"Poema Sem Nome\", os Guardiões podem usar equipes presetadas pelo sistema que incluem Horla para experimentar níveis designados infinitamente.\n·Enquanto experimenta os níveis do evento, ajustes nos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_48854_ActivityName = {
    Text = "Detetive sortudo"
  },
  Activity_48854_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento \"Lucky Detective\", os Guardiões podem usar equipes predefinidas pelo sistema que incluem Ryker para experimentar níveis designados infinitamente.\n·Ao experimentar os níveis do evento, ajustes aos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_48855_ActivityName = {
    Text = "Florescer de Lodo"
  },
  Activity_48855_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento \"Flor do Lodo\", os Guardiões podem usar equipes presetadas pelo sistema que incluem Lily para experimentar níveis designados infinitamente.\n·Ao jogar os níveis do evento, ajustes nos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_48856_ActivityName = {
    Text = "Senhora de vermelho"
  },
  Activity_48856_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento \"Dama Vermelha\", os Guardiões podem usar equipes presetadas pelo sistema que incluem Sorel para experimentar níveis designados infinitamente.\n·Ao experimentar os níveis do evento, ajustes nos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_49249_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_49249_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_49405_ActivityName = {
    Text = "Evento de Confissão: Atividade de Desbloqueio com Desconto"
  },
  Activity_49406_ActivityName = {
    Text = "Evento duplo de Afinidade"
  },
  Activity_51127_ActivityName = {
    Text = "História magia·cópia de luz"
  },
  Activity_51127_ActivityPlot = {
    Text = "As tarefas atribuídas por Boneca nunca são simples. \nMesmo com várias lembranças para todos se \"divertirem\", como os guardiões poderiam não ficar assustados ao levar um grupo de despertadores pela primeira vez? \nMas, não se esqueça de \"divertir-se\""
  },
  Activity_51127_ActivityStageEndContent = {
    Text = "O evento terminou, atualmente só é possível participar da\"Loja de script mágico\""
  },
  Activity_51127_ActivityTips = {
    Text = "<Title:Visão Geral do Evento>\n1. O evento de jogabilidade \"A Magia da História\" está de volta por tempo limitado! Guardiões do segredo podem acessar a \"Loja de roteiros mágicos\" e \"Recompensas de Conquista\" para obter a Roda do destino exclusiva do evento \"Mágica 35mm\" e o avatar exclusivo do evento \"Por nome da Chave de Prata: Lily\" mais uma vez!\n2. Durante o evento, \"Operação Especial: A Magia da História\" estará disponível para acesso gratuito por tempo limitado.\n\n<Title:Período do Evento>\n1. De 3 de junho, 9:00 a 17 de junho, 9:00 (GMT+8), todo o conteúdo na introdução do evento pode ser participado.\n2. De 17 de junho, 9:00 a 24 de junho, 9:00 (GMT+8), apenas a \"Loja de roteiros mágicos\" e as \"Recompensas de Conquista\" permanecerão acessíveis; outros conteúdos terão sido encerrados e não poderão ser participados.\n\n<Title:Misterio do Roteiro>\n1. \"Misterio do roteiro\" consiste em 9 fases de material, com uma fase sendo desbloqueada automaticamente a cada dia. Após o desbloqueio, você deve concluir a fase de Operação Especial anterior para desafiá-la.\n2. Cada desafio consome 60 pontos de Lingfétide. Desafios bem-sucedidos recompensam você com a moeda do evento \"Inspiração Errante\" e materiais de cultivo. Concluir as fases de material neste evento suporta reencenação.\n3. Você pode usar o apoio de Alumni e \"Resonância: Valor de Fase do Diretor\" para ajudar a concluir as fases mais facilmente.\n\n<Title:Bônus de Inspiração>\n1. Guardiões do segredo com Corpos Despertos ou Rodas do destino específicos (não é necessário estar na Formação) ganham bônus adicionais de drop de \"Inspiração Errante\" nas recompensas de tarefa de \"Misterio do roteiro\" (incluindo reencenação). Os bônus específicos são os seguintes:\nCorpo Desperto \"Lily\": Despertar Espiritual 0/1/2/3 e acima, bônus 20%/30%/40%/50%\nRoda do destino SSR \"Graça Através da Dor\": Empilhamento 0/1/2/3 e acima, bônus 20%/30%/40%/50%\nRoda do destino SR \"Mágica 35mm\": Empilhamento 0/1/2/3 e acima, bônus 20%/30%/40%/50%\n2. Os \"Bônus de Inspiração\" de diferentes Corpos Despertos ou Rodas do destino são acumuláveis.\n\n<Title:Resonância: Valor de Fase do Diretor>\n1. Guardiões do segredo podem adquirir \"Coração da interpretação\" ao completar conquistas do evento.\n2. Consumir \"Coração da interpretação\" para ativar \"Resonância: Valor de Fase do Diretor\" torna os Guardiões do segredo mais fortes na jogabilidade do evento \"Misterio do roteiro\" e \"Operação Especial: A Magia da História,\" e aprimora as recompensas de \"Inspiração Errante\" e Taxa de Sincronização obtidas após concluir desafios de \"Misterio do roteiro\".\n\n<Title:Recompensas de Conquista>\n1. Completar tarefas de conquista concede o avatar exclusivo do evento \"Por nome da Chave de Prata: Lily,\" moeda do evento \"Inspiração Errante,\" e Núcleo de prata.\n2. Inclui 25 tarefas: concluir cada fase de \"Misterio do roteiro\" uma vez, usar cada equipe de Domínio para concluir \"Misterio do roteiro\" 1/2 vezes, concluir cada evento de investigação em \"Operação Especial: A Magia da História\" uma vez, e completar todas as conquistas do evento.\n\n<Title:Operação Especial>\n1. Durante o evento, \"Operação Especial: A Magia da História\" pode ser desbloqueada gratuitamente.\n2. Em \"Operação Especial: A Magia da História,\" os Guardiões do segredo desafiarão usando uma configuração de equipe especial que inclui o preset de história \"Lily.\"\n\n<Title:Compensação de Ressurreição>\n1. Guardiões do segredo que desbloquearam anteriormente \"Operação Especial: A Magia da História\" receberão uma compensação de \"Inspiração Errante\" *1000 ao desbloquear novamente durante este evento de ressurreição.\nGuardiões do segredo que obtiveram anteriormente o avatar exclusivo do evento \"Por nome da Chave de Prata: Lily\" terão quaisquer recompensas repetidas automaticamente convertidas em \"Inspiração Errante\" *3000.\nGuardiões do segredo que obtiveram anteriormente o material de ativação de Resonância \"Coração da interpretação\" terão cada \"Coração da interpretação\" adicional obtido automaticamente convertido em \"Cupom de ouro rosa\" *5000.\n"
  },
  Activity_51127_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_51611_ActivityName = {
    Text = "A Magia da História"
  },
  Activity_51611_ActivityTips = {
    Text = "<Title:Condições de Participação>\n·Complete \"Operação de Investigação\" 2-9 (Normal) para participar.\n<Title:Evento de Investigação>\n·Durante o período do evento, um novo evento de investigação de \"Magia das Histórias\" será lançado diariamente. Os Guardiões podem desbloquear e investigar sem consumir inventário. Após completar o evento de investigação, recompensas como Coração Puro, Insígnia de Investigação e Experiência do Guardião podem ser obtidas.\n·Após o término do evento, o progresso da investigação de \"Magia das Histórias\" será retido. Os Guardiões podem consumir Jóias d em um Registro Especial para desbloquear investigações não completadas. Completar eventos de investigação não finalizados durante o período do evento também concederá recompensas consistentes com aquelas durante o evento.<Title:Recompensas por Tempo Limitado>\n·Recompensas por tempo limitado estarão disponíveis durante o evento. Os Guardiões podem obter Coração Puro, Pedra Filosofal e recompensas de Prata após concluir \"Magia das Histórias\" (modo Normal) e completar eventos de investigação de \"Magia das Histórias\"! As recompensas por tempo limitado só estarão disponíveis durante o período do evento e não podem ser completadas ou reivindicadas após o término do evento."
  },
  Activity_51888_ActivityName = {
    Text = "Profanação"
  },
  Activity_51905_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_51905_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_52040_ActivityName = {
    Text = "Cerimônia do Abismo"
  },
  Activity_52040_ActivityPlot = {
    Text = "No reflexo do mar profundo, o sonho do rei se dissipa, o reino dos deuses apodrece.\nEla vem dos sonhos antigos, entra nas ruínas do futuro.\nEla pergunta ao abismo, o abismo permanece em silêncio.\nEla oferece ao abismo, e a resposta é ela mesma"
  },
  Activity_52040_ActivityStageEndContent = {
    Text = "Evento encerrado, apenas disponível para \"Resposta do Abismo\""
  },
  Activity_52040_ActivityTips = {
    Text = "<Title:Introdução ao Evento>\n1 Durante o evento, os guardiões podem coletar moeda do evento através das atividades limitadas \"Nascimento do Reino Divino\", \"O Decreto do Rei\" e \"Recompensa de Conquista\". A moeda do evento pode ser usada para oferendas em \"Resposta do Abismo\" para obter recompensas de itens, incluindo a roda do destino SR exclusiva do evento \"O Chamado do Mar Profundo\", Pedra Filosofal, Núcleo Imaculado, Núcleo de Lumen, entre outros. \n2 Durante o evento, \"Visão de Sonhos Estranhos: Profanação\" será aberto gratuitamente. \n\n<Title: Tempo do Evento>\n1 De 17 de junho às 9:00 até 1 de julho às 9:00 (GMT+8), todos os conteúdos do evento poderão ser participados. \n2 De 1 de julho às 9:00 até 8 de julho às 9:00 (GMT+8), apenas \"Resposta do Abismo\" e \"Recompensa de Conquista\" estarão disponíveis, outros conteúdos estarão encerrados e não poderão ser participados. \n\n<Title: Nascimento do Reino Divino>\n1 \"Nascimento do Reino Divino\" contém 5 fases, uma fase será automaticamente aberta a cada 2 dias. \n2 Cada desafio consumirá \"Lingfétide\" × 120, e ao ter sucesso no desafio, o guardião receberá as moedas do evento \"Lágrimas do Sacerdote\", \"Sangue do adorador\" e \"Medula do Sacrificador\". Durante desafios em dobro, será necessário consumir 240 Lingfétide, e as recompensas das missões da fase também serão dobradas, enquanto a recompensa da taxa de sincronização permanecerá a mesma. \n3 Após alcançar 100% de conclusão na \"Recompensa de Conquista\", a função \"Reproduzir\" das fases já completadas será desbloqueada. Cada \"Reproduzir\" consumirá \"Lingfétide\" × 120. Por favor, note: ao usar a função \"Reproduzir\", não será possível obter a taxa de sincronização. \n4 Você pode usar a ajuda da associação de ex-alunos e \"Ressonância: Ritual do Abismo\" para facilitar sua conclusão das fases. \n\n<Title: Bonificação de Sacrifício>\n1 Os guardiões que possuem um corpo despertado ou roda do destino específicos (não é necessário estar em batalha) podem fazer com que as recompensas das missões da fase \"Nascimento do Reino Divino\" de \"Lágrimas do Sacerdote\", \"Sangue do adorador\" e \"Medula do Sacrificador\" recebam um bônus extra de queda (incluindo Reproduzir). Os bônus específicos são os seguintes: \n· Corpo Desperto \"Miryam\": Despertar 0/1/2/3 e acima, bônus de 20%/30%/40%/50% \n· Roda do destino SSR \"Poder do piedoso\": Posição sobreposta 0/1/2/3 e acima, bônus de 20%/30%/40%/50% \n· Roda do destino SR \"O Chamado do Mar Profundo\": Posição sobreposta 0/1/2/3 e acima, bônus de 20%/30%/40%/50% \n2 Os \"Bônus de Sacrifício\" de diferentes corpos despertos ou rodas do destino são calculados de forma acumulativa. \n\n<Title:Ressonância: Ritual do Abismo>\n1 Os guardiões podem obter \"Coração de piedade\" ao completar conquistas do evento. \n2 Consumindo \"Coração de piedade\", ativa \"Ressonância: Ritual do Abismo\", podendo obter os seguintes bônus: \n(1) Fazer com que os guardiões se tornem mais fortes na atividade \"Nascimento do Reino Divino\", tornando os desafios mais fáceis. \n(2) Aumentar a moeda do evento obtida após completar o desafio \"Nascimento do Reino Divino\". \n(3) Ativar a atividade \"O Decreto do Rei\". \n\n<Title: O Decreto do Rei>\n· Após ativar a ressonância \"Prova de Sacrifício\", o guardião receberá automaticamente 60 \"Lágrimas do Sacerdote\" a cada hora, podendo armazenar um máximo de 25 horas. \n\n<Title: Resposta do Abismo>\n1 \"Resposta do Abismo\" possui três altares, os horários de abertura são os seguintes: \n· \"Altar de Lágrimas Brilhantes\": Aberto em 17 de junho às 9:00. \n· \"Altar de Sangue de Gorila\": Aberto em 19 de junho às 9:00. \n· \"Altar de Medula Espiritual\": Aberto em 21 de junho às 9:00. \n2 Cada oferenda de sacrifício consumirá 500 \"Lágrimas do Sacerdote\"/\"Sangue do adorador\"/\"Medula do Sacrificador\", recebendo aleatoriamente cinco recompensas de itens do altar. \n3 As recompensas de itens de cada altar são divididas em \"Benção do Reino\" e \"Recompensa Comum\", ao redefinir, pode-se reiniciar a quantidade restante dos itens de recompensa designados para o limite máximo, as regras específicas são: \n(1) Para as 2 primeiras redefinições: quando não houver quantidade restante de \"Benção do Reino\", o guardião pode escolher redefinir, após a redefinição, a quantidade restante de \"Benção do Reino\" e \"Recompensa Comum\" será reiniciada para o limite máximo; também pode optar por continuar a oferecer sacrifícios, quando não houver quantidade restante de \"Recompensa Comum\", deve ser feita uma redefinição para continuar a oferecer sacrifícios. \n(2) A partir da 3ª redefinição: quando não houver quantidade restante de \"Recompensa Comum\", a redefinição poderá ser realizada, a redefinição reiniciará a quantidade restante de \"Recompensa Comum\" para o limite máximo, \"Benção do Reino\" não será mais redefinido. \n\n<Title: Visão de Sonhos Estranhos>\n1 \"Visão de Sonhos Estranhos\" é um novo tipo de investigação, que em comparação com a forma usual de interpretação narrativa, \"Visão de Sonhos Estranhos\" se concentrará mais na apresentação textual, com um maior volume de conteúdo textual. \n2 Em \"Visão de Sonhos Estranhos: Profanação\", você irá, através da conexão com o espírito de Miryam, ler diretamente suas memórias, testemunhando: a jovem Miryam passando pelas dificuldades de Lemuria, perdida em sua fé, lutando em sua fé, e finalmente trilhando o caminho de se tornar salvadora e destruidora... \n3 Durante o evento, \"Visão de Sonhos Estranhos: Profanação\" será aberto gratuitamente. A cada 2 dias, novos eventos serão lançados, ao completar \"Visão de Sonhos Estranhos: Profanação\", você poderá obter Núcleo de Prata, roda do destino SR exclusiva do evento \"O Chamado do Mar Profundo\" entre as recompensas da recompensa de conquista, as recompensas de conquista estarão abertas apenas durante o evento, após o término do evento, não será possível completar e receber. \n4 Após o término do evento, o progresso da investigação de \"Visão de Sonhos Estranhos: Profanação\" será mantido, se não for desbloqueado durante o evento, ainda será possível usar \"Ponto de partida real\" × 7 para desbloquear após o término do evento. \n5 Independentemente de estar durante o evento ou não, após completar \"Visão de Sonhos Estranhos: Profanação\", você poderá obter \"Ordem de chave: Festa do Mar\". \n\n\n\n"
  },
  Activity_52040_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_53727_ActivityName = {
    Text = "Dia de volta às aulas"
  },
  Activity_53727_ActivityTips = {
    Text = "<Title:Event Introduction>\n· As tarefas do \"Dia de Volta às Aulas\" estão divididas em 4 grupos, desbloqueando no 1º, 2º, 3º e 4º dias do evento.\n· Os Guardiães podem obter \"Convite de Volta às Aulas\" ao completar as tarefas do \"Dia de Volta às Aulas\".\n· Usar o \"Convite de Volta às Aulas\" permite que os Guardiães troquem por recompensas generosas na \"Loja de Volta às Aulas.\""
  },
  Activity_53728_ActivityName = {
    Text = "Ajuda para o caminho do peregrino"
  },
  Activity_53728_ActivityTips = {
    Text = "<Title:Visão Geral do Evento>\n Durante o evento \"Apoie a nova jornada\", os Guardiões do segredo receberão recompensas em dobro de Cupom de ouro rosa e materiais após concluir \"Preparação e tempera\", \"Resíduo turvo\", \"Resíduo das Profundezas\", \"Resíduo orgânico\", \"Resíduo dimensional\", \"Cluster caótico\", \"Ruínas de Ponape\", \"Ninho de Vermes\" e \"Garganta de Schwarzschild\". Um total de 6 recompensas em dobro pode ser aproveitado a cada dia.\nQuaisquer chances de recompensa em dobro não utilizadas no dia serão redefinidas às 9:00 (GMT+8) do dia seguinte. Guardiões do segredo, lembrem-se de usá-las a tempo!"
  },
  Activity_53729_ActivityName = {
    Text = "Registro de volta às aulas"
  },
  Activity_53729_ActivityTips = {
    Text = "<Title:Event Overview>\n· Os Guardiães podem reivindicar a recompensa de registro diário em \"Relatório de Volta às Aulas\" após fazer login a cada dia.\n· As recompensas serão desbloqueadas sequencialmente com base nos logins acumulados dos Guardiães, e as recompensas de registro diário serão atualizadas às 9:00 AM (GMT+8)."
  },
  Activity_53829_ActivityName = {
    Text = "Com o livro da rosa"
  },
  Activity_53829_ActivityPlot = {
    Text = "Diamantes dourados, pérolas brilhantes... \nInúmeros adornos luxuosos lhe deram uma ilusão de imperatriz \nAgora, ela está determinada a manter essa ilusão para sempre"
  },
  Activity_53829_ActivityStageEndContent = {
    Text = "Evento encerrado, apenas disponível para \"Festival Dourado\""
  },
  Activity_53829_ActivityTips = {
    Text = "<Title:Descrição da Atividade>\n1, Durante o período da atividade, os guardiões do segredo podem coletar a moeda da atividade \"Leque de Penas do Espírito Avestruz\" através dos modos limitados \"Memórias de Rosas\" e \"Recompensa de Conquista\". O \"Leque de Penas do Espírito Avestruz\" pode ser trocado por recompensas generosas no \"Celebração Dourada e Vermelha\", incluindo a roda do destino SR limitada da atividade \"Milhões de Olhares Amorosos\", \"Núcleo Imaculado\", \"Núcleo de Lumen\", \"Fragmentos de Pedra Sábia\", \"Cristal de Mimese\" e outros. \n2, Durante o período da atividade, completar as missões da \"Recompensa de Conquista\" pode resultar em um ícone limitado da atividade \"Por nome da Chave de Prata: Sorel\", a roda do destino SR limitada \"Milhões de Olhares Amorosos\", Núcleo de Prata e uma grande quantidade de moeda da atividade \"Leque de Penas do Espírito Avestruz\". \n3, Durante o período da atividade, \"Registro da força-tarefa: Hino à Rosa\" será aberto gratuitamente. \n\n<Title:Tempo da Atividade>\n1, 1 de julho às 9:00 - 15 de julho às 9:00 (GMT+8), todos os conteúdos da atividade estarão disponíveis para participação. \n2, 15 de julho às 9:00 - 22 de julho às 9:00 (GMT+8), apenas \"Celebração Dourada e Vermelha\" e \"Recompensa de Conquista\" serão mantidos; outros conteúdos estarão concluídos e não poderão ser participados. \n\n<Title: Memórias de Rosas>\n1, \"Memórias de Rosas\" contém 9 fases, uma será automaticamente aberta a cada dia. \n2, Cada desafio consumirá \"Lingfétide\" × 120. Desafiar diferentes fases não apenas resultará em diferentes materiais, mas também concederá a moeda da atividade \"Leque de Penas do Espírito Avestruz\". \n3, As fases da atividade desta vez são fases de combate direto, e após a conclusão, poderão ser reproduzidas! Cada \"Reproduzir\" consumirá \"Lingfétide\" × 120. \n4, Atenção: ao usar a função \"Reproduzir\", a taxa de sincronização não será obtida. \n\n<Title:Bônus do Leque>\n1, Os guardiões do segredo que possuem corpos despertos ou rodas do destino específicos (não é necessário estar em campo) podem fazer com que a moeda \"Leque de Penas do Espírito Avestruz\" nas recompensas das missões da fase \"Memórias de Rosas\" receba um bônus de queda adicional (incluindo reprodução), os bônus específicos são os seguintes: \n· Corpo Desperto \"Sorel\": Despertar 0/1/2/3 e acima, bônus de 20%/30%/40%/50% \n· Roda do destino SSR \"Em Nome de Rosa\": Posição sobreposta 0/1/2/3 e acima, bônus de 20%/30%/40%/50% \n· Roda do destino SR \"Milhões de Olhares Amorosos\": Posição sobreposta 0/1/2/3 e acima, bônus de 20%/30%/40%/50% \n2, Os bônus do \"Leque\" de diferentes corpos despertos ou rodas do destino serão contabilizados de forma acumulativa. \n\n<Title:Registro da Força-Tarefa>\n1, Durante o período da atividade, os guardiões do segredo que já desbloquearam \"Registro da força-tarefa: Hino à Rosa\" anteriormente receberão uma compensação de \"Leque de Penas do Espírito Avestruz\" ×600 ao desbloquear novamente. \n2, No \"Registro da força-tarefa: Hino à Rosa\", os guardiões do segredo usarão uma formação especial que inclui a pré-configuração da trama \"Sorel\" para desafios."
  },
  Activity_53829_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_54375_ActivityName = {
    Text = "Hino à Rosa"
  },
  Activity_54375_ActivityPlot = {
    Text = "Senhoras e senhores.\nA noite gentil abriu suas cortinas—preparem sua melhor bebida.\nEsta é uma longa história. Permitam-nos contá-la com calma."
  },
  Activity_54375_ActivityTips = {
    Text = "<Title:Condições de Participação>\n·Completar \"Operação de Investigação\" 2-9 (Normal) para participar.\n<Title:Evento de Investigação>\n·Durante o período do evento, um novo evento de investigação de \"Tributo Rosado\" será lançado diariamente. Guardiões podem desbloquear e investigar sem consumir o inventário. Após completar o evento de investigação, recompensas como Núcleo Puro, Distintivo de Investigação e Experiência do Guardião podem ser obtidas.\n·Após o término do evento, o progresso da investigação de \"Tributo Rosado\" será mantido, e os Guardiões podem consumir Jóias D no Registro Especial para desbloquear investigações não completadas. Completar eventos de investigação não concluídos durante o período do evento também concederá recompensas consistentes com aquelas durante o evento.<Title:Recompensas por Tempo Limitado>\n·Recompensas por tempo limitado estarão disponíveis durante o evento. Os Guardiões podem obter Núcleo Puro, Pedra Filosofal e recompensas de Prata após completar o modo \"Tributo Rosado\" (Normal) e eventos de investigação de \"Tributo Rosado\"! Recompensas por tempo limitado só estão disponíveis durante o período do evento e não podem ser completadas ou reivindicadas após o término do evento."
  },
  Activity_54402_ActivityName = {
    Text = "Paciente dissociativo: caos"
  },
  Activity_54402_ActivityTips = {
    Text = "<Title:Regras da Atividade>\n·Durante o evento \"Paciente Fragmentado: Caos\", os Guardiães podem usar equipes pré-definidas pelo sistema contendo \"24\" para experimentar níveis designados um número ilimitado de vezes.\n·Ao jogar os níveis do evento, ajustes no Despertar do alinhamento da equipe não podem ser feitos.\n<Title:Recompensas da Atividade>\n·Após completar com sucesso um desafio de nível pela primeira vez, você pode reivindicar recompensas de teste na interface do evento."
  },
  Activity_54403_ActivityName = {
    Text = "Chave para o portal"
  },
  Activity_54403_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento \"Key of the Door\", os Guardiões podem usar equipes predefinidas pelo sistema que incluem Tawil para experimentar níveis designados infinitamente.\n·Enquanto experimenta os níveis do evento, ajustes aos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_54404_ActivityName = {
    Text = "Bishop de bálsamos"
  },
  Activity_54404_ActivityTips = {
    Text = "<Title:Regras da Atividade>\n·Durante o evento \"Bispo Benevolente\", os Guardiães podem usar equipes pré-definidas pelo sistema contendo Salvador para experimentar níveis designados um número ilimitado de vezes.\n·Ao jogar os níveis do evento, ajustes no Despertar do alinhamento da equipe não podem ser feitos.\n<Title:Recompensas da Atividade>\n·Após completar com sucesso um desafio de nível pela primeira vez, você pode reivindicar recompensas de teste na interface do evento."
  },
  Activity_54405_ActivityName = {
    Text = "Paciente dissociativo: ultra"
  },
  Activity_54405_ActivityTips = {
    Text = "<Title:Event Rules>\n·Durante o evento \"Paciente Dividido: Ultra\", os Guardiães podem usar equipes pré-definidas pelo sistema que incluem \"24\" para experimentar níveis designados infinitamente.\n·Ao experimentar níveis do evento, ajustes aos Despertadores na formação da equipe não são permitidos.\n<Title:Event Rewards>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_54406_ActivityName = {
    Text = "Apóstolo do mar"
  },
  Activity_54406_ActivityTips = {
    Text = "<Title:Regras do Evento>\n· Durante o evento \"Apostolo do Mar\", os Guardiães podem usar equipes pré-definidas pelo sistema que incluam Miryam para experimentar níveis designados infinitamente.\n· Ao experimentar os níveis do evento, ajustes aos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n· Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_54407_ActivityName = {
    Text = "Artista Eterno"
  },
  Activity_54407_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento \"Eternal Performer\", os Guardiões podem usar equipes predefinidas pelo sistema que incluem Hameln para experimentar níveis designados infinitamente.\n·Ao experimentar os níveis do evento, ajustes aos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_54408_ActivityName = {
    Text = "Ceifador de almas"
  },
  Activity_54408_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento \"Colecionador de Almas\", os Guardiões podem usar equipes pré-definidas pelo sistema que incluem Hilota: Catena para experimentar níveis designados infinitamente.\n·Ao experimentar os níveis do evento, ajustes nos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_54409_ActivityName = {
    Text = "Paciente dissociativo: aequor"
  },
  Activity_54409_ActivityTips = {
    Text = "<Title:Regras da Atividade>\n·Durante o evento \"Paciente Fragmentado: Aequor\", os Guardiães podem usar equipes pré-definidas pelo sistema contendo \"24\" para experimentar níveis designados um número ilimitado de vezes.\n·Ao jogar os níveis do evento, ajustes no Despertar do alinhamento da equipe não podem ser feitos.\n<Title:Recompensas da Atividade>\n·Após completar com sucesso um desafio de nível pela primeira vez, você pode reivindicar recompensas de teste na interface do evento."
  },
  Activity_54410_ActivityName = {
    Text = "Paciente dissociativo: caro"
  },
  Activity_54410_ActivityTips = {
    Text = "<Title:Event Rules>\n·Durante o evento \"Paciente Dividido: Caro\", os Guardiães podem usar equipes pré-definidas pelo sistema que incluem \"24\" para experimentar níveis designados infinitamente.\n·Ao experimentar níveis do evento, ajustes aos Despertadores na formação da equipe não são permitidos.\n<Title:Event Rewards>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_54411_ActivityName = {
    Text = "Cérebro corrompido"
  },
  Activity_54411_ActivityTips = {
    Text = "<Title:Regras do evento>\n· Durante o evento \"Cérebro em decomposição\", o Guardião pode usar o esquadrão predefinido contendo \"Derretimento · Dore\" para experimentar infinitamente as fases designadas.\n· Ao experimentar as fases do evento, não é possível ajustar os corpos despertos no esquadrão.\n<Title:Recompensas do evento>\n· Após concluir o desafio da fase pela primeira vez, é possível coletar a recompensa de teste na interface do evento.\n\n."
  },
  Activity_54521_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_54521_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_54522_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_54522_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_54523_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_54523_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_54524_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_54524_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_54525_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_54525_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_54526_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_54526_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_54527_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_54527_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_54596_ActivityName = {
    Text = "Presente do conhecimento"
  },
  Activity_54596_ActivityTips = {
    Text = "<Title:Introdução ao Evento>\n1, Após os Guardiões do Segredo completarem as tarefas designadas do evento, poderão receber recompensas abundantes como \"Parque Prototípico\", \"Livro de rotação\", \"Horizonte de Protótipo\", \"modelo de loop\", \"Núcleo de Retorno da Alma\", \"Núcleo de Retorno do Destino\", além de \"Capítulo Esquecido\" com corpos despertos e rodas do destino limitados, e \"Capítulo das Estrelas\" com corpos despertos e rodas do destino limitados, além de um quadro de avatar exclusivo do evento \"Retângulo Prateado\" e aceleração da Experiência do Guardião de Segredos!\n2, Este evento estará permanentemente aberto. Após completar todas as tarefas do evento e reivindicar as recompensas, o evento terminará no dia seguinte às 9:00 (GMT+8) e não será mais exibido.\n\n<Title:Elogio Supremo>\n1, Completar as tarefas designadas do evento pode conceder o efeito \"Elogio Supremo\", acelerando a Experiência do Guardião de Segredos, podendo chegar até 100%. Quando múltiplos efeitos \"Elogio Supremo\" estiverem ativos, o efeito de aceleração mais alto será considerado.\n2, Ao desbloquear ou obter um efeito \"Elogio Supremo\" de nível mais alto, a Experiência do Guardião de Segredos será imediatamente aumentada de acordo com a proporção de aceleração e o total de Experiência do Guardião de Segredos que pode ser acelerada.\n3, Após desbloquear o \"Elogio Supremo\", cada vez que o Guardião do Segredo ganha Experiência do Guardião de Segredos, receberá uma quantidade adicional de Experiência do Guardião de Segredos correspondente à proporção de aceleração.\n4, Por favor, note que a Experiência do Guardião de Segredos adicional trazida pelo \"Elogio Supremo\" não será incluída no total de Experiência do Guardião de Segredos que pode ser acelerada.\n5, Total atual de Experiência do Guardião de Segredos que pode ser acelerada: {s1}.\n6, Experiência do Guardião de Segredos adicional acumulada por aceleração: {s2} ({s3}%)."
  },
  Activity_55110_ActivityName = {
    Text = "Antes que a primavera murche"
  },
  Activity_55110_ActivityPlot = {
    Text = "A risada das meninas ecoa no jardim antes que o fogo comece.\nPause para esse lindo passado, meu amigo.\nOuça as histórias da primavera não desbotada, suaves narradas."
  },
  Activity_55110_ActivityStageEndContent = {
    Text = "O evento terminou. Atualmente, apenas \"Casa Floral da Colette\" está disponível."
  },
  Activity_55110_ActivityTips = {
    Text = "<Title:Introdução ao Evento>\n1, Durante o evento, o Guardião pode coletar três tipos de \"poemas\" através das atividades limitadas \"Jardim de Memórias\", \"Beijo da Musa\" e \"Recompensa de Conquista\". Os \"poemas\" podem ser trocados na \"Casa de Flores da Colette\" para obter recompensas de itens, incluindo a Roda do Destino SR limitada ao evento \"Flores e Poemas do Passado\", \"Núcleo Imaculado\", \"Núcleo de Lumen\", \"Fragmentos de Pedra Sábia\", \"Cristal de Mimese\" e outros. \n2, Durante o evento, o \"Registro da Força-Tarefa: Morada da Rosa\" estará disponível gratuitamente. \n\n<Title: Período do Evento>\n1, 15 de julho, 9:00 - 29 de julho, 9:00 (GMT+8), todos os conteúdos do evento estão disponíveis para participação. \n2, 29 de julho, 9:00 - 5 de agosto, 9:00 (GMT+8), apenas a \"Casa de Flores da Colette\" e \"Recompensa de Conquista\" estarão disponíveis, todos os outros conteúdos terão terminado e não poderão ser participados. \n\n<Title: Jardim de Memórias>\n1, \"Jardim de Memórias\" contém 5 fases, cada uma se abrirá automaticamente a cada 2 dias. \n2, Cada desafio consumirá \"Lingfétide\" × 120, e ao completar com sucesso, o Guardião receberá a moeda do evento \"poesia melancólica\", \"Poema de Arrependimento\" e \"Poesia Alegre\". \n3, Após concluir a fase, a função \"Reproduzir\" será desbloqueada para essa fase. Observe: ao usar a função \"Reproduzir\", não será possível obter a Taxa de Sincronização. \n4, É possível usar a ajuda da associação de ex-alunos e \"Ressonância: Elegia do Jardim\" para facilitar a conclusão. \n5, No segundo dia após a fase ser desbloqueada, a dificuldade de loucura para essa fase será desbloqueada. Completar a primeira vez na dificuldade de loucura garantirá uma rica recompensa de moeda do evento. \n6, Observe: os desafios na dificuldade de loucura não consomem Lingfétide, não podem ser reproduzidos, e após a primeira conclusão, desafios repetidos não concederão mais recompensas de moeda do evento. \n\n<Title: Bônus de Poesia>\n1, O Guardião que possui um Corpo Desperto ou Roda do Destino específico (não é necessário estar em campo) pode fazer com que as recompensas das missões da fase \"Jardim de Memórias\" de \"poesia melancólica\", \"Poema de Arrependimento\" e \"Poesia Alegre\" obtenham um bônus de queda adicional (incluindo reprodução), os bônus específicos são os seguintes: \n· Corpo Desperto \"Horla\": Despertar 0/1/2/3 ou mais, bônus de 20%/30%/40%/50% \n· Roda do Destino SSR \"O Último Verso\": Sobreposição 0/1/2/3 ou mais, bônus de 20%/30%/40%/50% \n· Roda do Destino SR \"Flores e Poemas do Passado\": Sobreposição 0/1/2/3 ou mais, bônus de 20%/30%/40%/50% \n2, Diferentes Corpos Despertos ou Rodas do Destino têm o \"bônus de poesia\" calculado de forma acumulativa. \n3, Notavelmente, a recompensa do primeiro desafio na dificuldade de loucura não será afetada pelo \"bônus de poesia\". \n\n<Title: Ressonância: Elegia do Jardim>\n1, O Guardião pode obter \"Coração de Cinzas\" completando conquistas do evento. \n2, Consumindo \"Coração de Cinzas\", ativar \"Ressonância: Elegia do Jardim\" pode obter os seguintes bônus: \n(1) Fazendo o Guardião ficar mais forte na atividade \"Jardim de Memórias\", tornando os desafios mais fáceis. \n(2) Aumenta a moeda do evento obtida após completar o desafio \"Jardim de Memórias\". \n(3) Ativar a atividade \"Beijo da Musa\". \n\n<Title: Beijo da Musa>\n· Após ativar a ressonância \"Tudo cresce\", obtém automaticamente 60 \"poesia melancólica\" por hora, com um máximo de 25 horas armazenadas. \n· Após ativar a ressonância \"Trocar poema por flor\", \"Beijo da Musa\" pode obter 60 \"Poema de Arrependimento\" adicionais por hora. \n\n<Title: Casa de Flores da Colette>\n1, \"Casa de Flores da Colette\" tem três canteiros, os horários de abertura são os seguintes: \n· \"Canteiro de Íris\": Abre em 15 de julho às 9h. \n· \"Canteiro de Campânula\": Abre em 17 de julho às 9h. \n· \"Canteiro de Rosa\": Abre em 19 de julho às 9h. \n2, Cada troca consumirá 1000 \"poesia melancólica\"/\"Poema de Arrependimento\"/\"Poesia Alegre\", recebendo aleatoriamente cinco recompensas de itens do canteiro. \n3, As recompensas de itens de cada canteiro são divididas em \"itens especiais\" e \"itens comuns\", ao redefinir, é possível redefinir a quantidade restante de recompensas de itens especiais ao limite, as regras específicas são: \n(1) Nas duas primeiras redefinições: quando não houver quantidade restante de \"itens especiais\", o Guardião pode escolher redefinir; a redefinição restaurará a quantidade restante de \"itens especiais\" e \"itens comuns\" ao limite; também pode escolher continuar trocando, quando não houver quantidade restante de \"itens comuns\", será necessário redefinir para continuar trocando. \n(2) A partir da terceira redefinição: quando não houver quantidade restante de \"itens comuns\", será possível redefinir, a redefinição restaurará a quantidade restante de \"itens comuns\" ao limite, \"itens especiais\" não serão mais redefinidos. \n4, Após 5 de agosto, 9:00 (GMT+8), os \"poemas\" não trocados restantes serão recuperados na proporção de 200 por 5000 \"Cupom de ouro rosa\", por favor, o Guardião preste atenção ao verificar o e-mail. \n\n<Title: Registro da Força-Tarefa>\n1, Durante o evento, o \"Registro da Força-Tarefa: Morada da Rosa\" estará disponível gratuitamente. A cada 2 dias, novos eventos serão lançados, após concluir o \"Registro da Força-Tarefa: Morada da Rosa\", o Guardião poderá obter recompensas como Núcleo de Prata, Roda do Destino SR limitada ao evento \"Flores e Poemas do Passado\", entre outras, as recompensas de conquista estarão disponíveis apenas durante o evento, e não poderão ser completadas ou recebidas após o término do evento. \n2, Após o término do evento, o progresso da investigação do \"Registro da Força-Tarefa: Morada da Rosa\" será preservado, se não houver desbloqueio do \"Registro da Força-Tarefa: Morada da Rosa\" durante o evento, ainda será possível consumir \"Ponto de partida real\" ×7 para desbloquear após o término do evento. \n3, Independentemente de estar ou não durante o evento, após a conclusão do \"Registro da Força-Tarefa: Morada da Rosa\", o Guardião poderá obter \"Ordem de chave: Poema de oferenda da primavera\"."
  },
  Activity_55110_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_55457_ActivityName = {
    Text = "Fissão Tranquila"
  },
  Activity_56427_ActivityName = {
    Text = "Pastor das Almas: Reedição"
  },
  Activity_56427_ActivityPlot = {
    Text = "Ele sofreu por você, suportou suas tribulações.\nAtravés da Carne e sangue que Ele sacrificou, você foi curado;\nAtravés da Vida que Ele deu, você foi perdoado."
  },
  Activity_56427_ActivityStageEndContent = {
    Text = "O evento foi Concluído. Atualmente, apenas \"Local de venda beneficente da igreja\" está disponível."
  },
  Activity_56427_ActivityTips = {
    Text = "<Title:Descrição da Atividade>\n1. Durante o evento, o Guardião do Segredo pode coletar a moeda do evento \"Bônus de venda beneficente\" através das jogadas limitadas \"Caminho do Santuário\", \"Bondade dos Cidadãos\" e \"Recompensa de Conquista\". Os \"Bônus de venda beneficente\" podem ser trocados por itens aleatórios no \"Local de venda beneficente da igreja\", incluindo o SR Roda do destino limitado do evento \"Homem no espelho\", Núcleo Imaculado, Núcleo de Lumen, entre outros. \n2. Durante o evento, \"Registro da força-tarefa: A cor do sangue\" estará aberto gratuitamente. Completar as conquistas do evento também permitirá ganhar o ícone limitado do evento \"Por nome da Chave de Prata: Salvador\"!\n\n<Title:Período do Evento>\n1. De 26 de agosto às 9:00 até 9 de setembro às 9:00 (GMT+8), todos os conteúdos do evento estarão disponíveis para participação. \n2. De 9 de setembro às 9:00 até 16 de setembro às 9:00 (GMT+8), apenas o \"Local de venda beneficente da igreja\" e \"Recompensa de Conquista\" estarão disponíveis, enquanto os outros conteúdos estarão encerrados e não poderão ser acessados. \n\n<Title:Caminho do Santuário>\n1. O \"Caminho do Santuário\" contém 5 fases, sendo que uma nova fase será automaticamente desbloqueada a cada 2 dias. \n2. Cada tentativa de desafio consumirá \"Lingfétide\" × 120, e o sucesso no desafio resultará em \"Bônus de venda beneficente\". \n3. Após completar uma fase, a função de \"Reprodução\" dessa fase será desbloqueada. Atenção: Ao usar a função \"Reprodução\", não será possível obter a Taxa de Sincronização. \n4. Você pode usar a ajuda da associação de ex-alunos e \"Ressonância: O desvio da alma\" para facilitar sua passagem pelas fases. \n\n<Title:Aumento de Brilho>\n1. Sob a influência do \"Brilho da Alma\", o Guardião do Segredo que possui um corpo ou roda do destino específica (não é necessário estar em batalha) pode fazer com que os \"Bônus de venda beneficente\" nas recompensas das fases do \"Caminho do Santuário\" recebam um aumento de queda adicional (incluindo Reprodução). Os aumentos específicos são os seguintes: \n· Corpo Desperto \"Salvador\": Despertar 0/1/2/3 e acima, aumento de 20%/30%/40%/50%. \n· Roda do destino SSR \"Tábula das Escrituras\": sobreposição 0/1/2/3 e acima, aumento de 20%/30%/40%/50%. \n· Roda do destino SR \"Homem no espelho\": sobreposição 0/1/2/3 e acima, aumento de 20%/30%/40%/50%. \n2. Diferentes corpos ou rodas do destino têm seus \"Aumentos de Brilho\" calculados de forma acumulativa. \n3. Notavelmente, as recompensas de desafio da dificuldade de loucura não serão afetadas pelo \"Aumento de Brilho\". \n\n<Title:Ressonância: O desvio da alma>\n1. O Guardião do Segredo pode obter \"Coração de penitência\" ao completar as conquistas do evento. \n2. Consumindo \"Coração de penitência\", ative \"Ressonância: O desvio da alma\", podendo obter os seguintes aumentos: \n(1) Tornar o Guardião do Segredo mais forte nas jogadas do evento \"Caminho do Santuário\" e \"Registro da força-tarefa: A cor do sangue\", facilitando os desafios. \n(2) Aumentar a Taxa de Sincronização obtida após completar o desafio do \"Caminho do Santuário\". \n(3) Ativar a jogada do evento \"Bondade dos Cidadãos\". \n\n<Title:Bondade dos Cidadãos>\n1. Após ativar a ressonância \"Forma fácil\", você receberá automaticamente 60 \"Bônus de venda beneficente\" a cada hora, com um armazenamento máximo de 25 horas. \n2. Após ativar a ressonância \"Redenção, Redenção\", você receberá automaticamente 1800 Cupom de ouro rosa a cada hora. \n\n<Title: Local de venda beneficente da igreja>\n1. O \"Local de venda beneficente da igreja\" possui três lojas, com os horários de abertura a seguir: \n· \"Loja da Sra. Grey\": abre às 9:00 de 26 de agosto. \n· \"Venda Mágica do Grande John\": abre às 9:00 de 29 de agosto. \n· \"Venda especial de Smith\": abre às 9:00 de 1 de setembro. \n2. Cada troca consumirá 1000 \"Bônus de venda beneficente\", recebendo aleatoriamente cinco itens da loja como recompensa. \n3. As recompensas dos itens de cada loja são divididas em \"Item Especial\" e \"Item comum\", e ao reiniciar, poderá redefinir a quantidade restante das recompensas de itens especiais para o limite máximo. As regras específicas são: \n(1) Para as duas primeiras reinicializações: quando não houver mais itens especiais restantes, o Guardião do Segredo pode optar por reiniciar, o que irá redefinir as quantidades restantes dos itens especiais e comuns para o limite máximo; ou pode optar por continuar trocando, quando não houver mais itens comuns restantes, uma reinicialização será necessária para continuar trocando. \n(2) A partir da terceira reinicialização: somente quando não houver mais itens comuns restantes é que será possível reiniciar, e a reinicialização irá redefinir a quantidade restante dos itens comuns para o limite máximo, os itens especiais não serão mais redefinidos. \n4. Após 9 de setembro às 9:00 (GMT+8), os \"Bônus de venda beneficente\" não trocados restantes serão recuperados na proporção de 5000 Cupom de ouro rosa para cada 200 unidades, por favor, o Guardião do Segredo deve verificar o e-mail. \n\n<Title:Registro da força-tarefa>\n1. Durante o evento, \"Registro da força-tarefa: A cor do sangue\" estará aberto gratuitamente. \n2. Após o término do evento, o progresso da investigação do \"Registro da força-tarefa: A cor do sangue\" será mantido. Se não foi desbloqueado durante o evento, ainda será possível consumir \"Ponto de partida real\" × 7 para desbloquear após o término do evento. \n3. Independentemente de estar ou não durante o evento, após completar \"Registro da força-tarefa: A cor do sangue\", você receberá \"Ordem de chave: Chegada do Milagre\". \n\n<Title:Compensação de Reedição>\n1. Os Guardiões do Segredo que já desbloquearam \"Registro da força-tarefa: A cor do sangue\" receberão uma compensação de \"Bônus de venda beneficente\" × 700 durante este evento de reedição ao desbloqueá-lo novamente. \n2. Os Guardiões do Segredo que já obtiveram o ícone limitado do evento \"Por nome da Chave de Prata: Salvador\" ao obtê-lo novamente, serão automaticamente convertidos em \"Bônus de venda beneficente\" × 2000. \n3. Os Guardiões do Segredo que já obtiveram o material de ativação da ressonância \"Coração de penitência\", cada \"Coração de penitência\" adicional obtido será automaticamente convertido em \"Cupom de ouro rosa\" × 5000. \n"
  },
  Activity_56427_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_56428_ActivityName = {
    Text = "Sacrifício do Abismo: Repetição"
  },
  Activity_56428_ActivityPlot = {
    Text = "No reflexo do mar profundo, o sonho do rei se dissipa, o reino dos deuses apodrece.\nEla vem dos sonhos antigos, entra nas ruínas do futuro.\nEla pergunta ao abismo, o abismo permanece em silêncio.\nEla oferece ao abismo, e a resposta é ela mesma"
  },
  Activity_56428_ActivityStageEndContent = {
    Text = "Evento encerrado, apenas disponível para \"Resposta do Abismo\""
  },
  Activity_56428_ActivityTips = {
    Text = "<Title:Introdução ao Evento>\n1,Durante o evento, os guardiões podem coletar moeda do evento através das mecânicas limitadas \"Nascimento do Reino Divino\", \"O decreto do rei\" e \"Recompensa de conquista\". A moeda do evento pode ser usada em \"Resposta do Abismo\" para oferecer e obter recompensas de itens, incluindo a roda do destino SR exclusiva do evento \"O Chamado do Mar Profundo\", Pedra Filosofal, Núcleo Imaculado, Núcleo de Lumen, entre outros.\n2,Durante o evento, \"Visão de Sonhos Estranhos: Profanação\" estará disponível gratuitamente, e completar as conquistas do evento pode render o avatar exclusivo do evento \"Por nome da Chave de Prata: Miryam\"!\n\n<Title: Horário do Evento>\n1,De 4 de novembro às 9:00 até 18 de novembro às 9:00 (GMT+8), todo o conteúdo do evento estará disponível para participação.\n2,De 18 de novembro às 9:00 até 25 de novembro às 9:00 (GMT+8), apenas \"Resposta do Abismo\" e \"Recompensa de conquista\" estarão disponíveis, todos os outros conteúdos estarão encerrados e não poderão ser participados.\n\n<Title:Nascimento do Reino Divino>\n1,\"Nascimento do Reino Divino\" contém 5 fases, que serão abertas automaticamente a cada 2 dias.\n2,Cada desafio consumirá \"Lingfétide\" × 120, e ao completar o desafio, o guardião receberá moeda do evento.\n3,Após completar uma fase, a função \"Reproduzir\" dessa fase será desbloqueada. Atenção: ao usar a função \"Reproduzir\", não será possível obter taxa de sincronização.\n4,Os guardiões podem usar a ajuda da associação de ex-alunos e \"Ressonância: Ritual do Abismo\" para facilitar a conclusão das fases.\n\n<Title:Bonificação de Sacrifício>\n1,Os guardiões que possuírem um corpo despertado ou roda do destino específicos (não é necessário estar em batalha) podem fazer com que as recompensas das missões de \"Nascimento do Reino Divino\", como \"Lágrimas do Sacerdote\", \"Sangue do adorador\" e \"Medula do Sacrificador\", recebam um bônus adicional de queda (incluindo a reprodução) conforme mostrado abaixo:\n·Corpo Desperto \"Miryam\": Despertar 0/1/2/3 e acima, bônus de 20%/30%/40%/50%\n·Roda do destino SSR \"Poder do piedoso\": Sincronização 0/1/2/3 e acima, bônus de 20%/30%/40%/50%\n·Roda do destino SR \"O Chamado do Mar Profundo\": Sincronização 0/1/2/3 e acima, bônus de 20%/30%/40%/50%\n2,Os \"bônus de sacrifício\" de diferentes corpos despertados ou rodas do destino serão calculados de forma acumulativa.\n3,Notavelmente, as recompensas do primeiro desafio na dificuldade de loucura não serão afetadas pelos \"bônus de sacrifício\".\n\n<Title:Ressonância: Ritual do Abismo>\n1,Os guardiões podem obter \"Coração de piedade\" ao completar conquistas do evento.\n2,Ao consumir \"Coração de piedade\", ativar \"Ressonância: Ritual do Abismo\" pode fornecer os seguintes bônus:\n(1)Fazendo com que os guardiões se tornem mais fortes na mecânica do evento \"Nascimento do Reino Divino\", tornando os desafios mais fáceis.\n(2)Aumentando a moeda do evento obtida após completar os desafios de \"Nascimento do Reino Divino\".\n(3)Ativando a mecânica do evento \"O decreto do rei\".\n\n<Title:O decreto do rei>\n·Após ativar a ressonância \"Prova de Sacrifício\", o guardião receberá automaticamente 60 \"Lágrimas do Sacerdote\" a cada hora, acumulando até 25 horas.\n\n<Title:Resposta do Abismo>\n1,\"Resposta do Abismo\" possui três altares, com os seguintes horários de abertura:\n·\"Altar de Lágrimas Brilhantes\": de 4 de novembro às 9:00 até 25 de novembro às 9:00.\n·\"Altar de Sangue de Gorila\": de 6 de novembro às 9:00 até 25 de novembro às 9:00.\n·\"Altar de Medula Espiritual\": de 8 de novembro às 9:00 até 25 de novembro às 9:00.\n2,Cada oferta de sacrifício consumirá 1000 \"Lágrimas do Sacerdote\"/\"Sangue do adorador\"/\"Medula do Sacrificador\", recebendo aleatoriamente cinco recompensas de itens do altar.\n3,As recompensas de itens de cada altar são divididas em \"itens especiais\" e \"itens comuns\", e ao redefinir, a quantidade restante de itens designados será restaurada ao limite, as regras específicas são:\n(1)Nas 2 primeiras redefinições: quando não houver mais itens especiais restantes, o guardião pode escolher redefinir, após a redefinição, a quantidade restante de itens especiais e comuns será restaurada ao limite; também pode optar por continuar a oferecer sacrifícios, quando não houver mais itens comuns restantes, deve redefinir para continuar a oferecer sacrifícios.\n(2)A partir da 3ª redefinição: quando não houver mais itens comuns restantes, a redefinição pode ser feita, a redefinição restaurará a quantidade restante de itens comuns ao limite, os itens especiais não serão mais redefinidos.\n\n<Title:Visão de Sonhos Estranhos>\n1,Durante o evento, \"Visão de Sonhos Estranhos: Profanação\" estará disponível gratuitamente.\n2,Após o término do evento, o progresso da investigação de \"Visão de Sonhos Estranhos: Profanação\" será mantido, se \"Visão de Sonhos Estranhos: Profanação\" não for desbloqueada durante o evento, ainda será possível desbloquear consumindo \"Ponto de partida real\" × 7 após o término do evento.\n3,Independentemente de estar ou não durante o evento, ao completar \"Visão de Sonhos Estranhos: Profanação\", o guardião receberá \"Ordem de chave: Festa do Mar\".\n\n<Title:Compensação da Reedição>\n1,Os guardiões que já desbloquearam \"Visão de Sonhos Estranhos: Profanação\" receberão uma compensação de \"Lágrimas do Sacerdote\" × 700 durante o período da reedição do evento ao serem desbloqueados novamente.\n2,Os guardiões que já obtiveram o avatar exclusivo do evento \"Por nome da Chave de Prata: Miryam\" receberão automaticamente \"Lágrimas do Sacerdote\" × 2000 ao obterem novamente.\n3,Os guardiões que já obtiveram o material para ativar a ressonância \"Coração de piedade\", cada \"Coração de piedade\" extra obtido será automaticamente convertido em \"Vouchers de Rosa\" × 5000.\n"
  },
  Activity_56428_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_56429_ActivityName = {
    Text = "A meio passo"
  },
  Activity_56429_ActivityPlot = {
    Text = "Ela sempre está à frente do mundo.\nUm passo, dois passos—suas pegadas iluminam o caminho para todos.\nMas os tolos esquecem facilmente demais:\nA distância entre a genialidade e a loucura\né de apenas meio passo."
  },
  Activity_56429_ActivityStageEndContent = {
    Text = "O evento foi Concluído. Atualmente, apenas \"Ensino do Mestre\" está disponível."
  },
  Activity_56429_ActivityTips = {
    Text = "<Title:Descrição do evento>\nDurante o evento, o Guardião poderá coletar a moeda do evento \"Peças de boneca\" por meio das jogabilidades temporárias \"Porta do Nada\" e \"Recompensas de Conquista\". As \"Peças de boneca\" podem ser trocadas por recompensas em \"Ensino do Mestre\", incluindo a Roda do destino SR exclusiva do evento \"Cajado do Pastor\", Núcleo de Lumen, Núcleo Imaculado, Fragmentos de Pedra Sábia, Cristal de Mimese e outros.\n\n<Title:Porta do Nada>\n1. \"Porta do Nada\" contém 9 estágios de materiais nos quais não é necessário explorar, apenas lutar, e 1 estágio é aberto diariamente.\n2. Cada desafio consome 120 pontos de encefalina, e ao ter sucesso no desafio, você receberá materiais de desenvolvimento e moedas do evento.\n3. Após concluir um estágio, será desbloqueada a função \"Recriação\" desse estágio. Observe que, ao usar a função \"Recriação\", não será possível obter taxa de sincronização.\n4. Você pode usar o apoio da Alumni para facilitar a conclusão.\n\n<Title:Bônus de Peças de boneca>\n1. Quando o Guardião possuir Corpos Despertos ou Rodas do destino específicos (não é necessário colocá-los em combate), poderá obter bônus adicionais na quantidade de \"Peças de boneca\" nas recompensas das missões dos estágios de \"Porta do Nada\" (incluindo recriação). Os detalhes do bônus são os seguintes:\nCorpo Desperto \"Doll: Inferno\": Despertar Espiritual 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%\nRoda do destino SSR \"Modelo Anatômico do Esquecimento\": Sobreposição 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%\nRoda do destino SR \"Cajado do Pastor\": Sobreposição 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%\n2. Os bônus de \"Peças de boneca\" de diferentes Corpos Despertos ou Rodas do destino são acumulativos.\n3. Especialmente, as recompensas da primeira conclusão no modo de dificuldade Loucura não são afetadas pelos bônus acima.\n\n<Title:Ensino do Mestre>\n1. Cada \"Troca de Peças\" consumirá 750 \"Peças de boneca\", aleatoriamente concedendo cinco recompensas de itens em \"Ensino do Mestre\".\n2. As recompensas de itens em \"Ensino do Mestre\" são divididas em dois tipos: \"Item Especial\" e \"Item comum\". Ao redefinir, é possível redefinir a quantidade restante de recompensas de \"Item Especial\" ao limite máximo. As regras específicas são as seguintes:\n(1) Primeiras 5 redefinições: quando não houver mais quantidade restante de \"Item Especial\", o Guardião poderá escolher redefinir, após o que a quantidade restante de \"Item Especial\" e \"Item comum\" será redefinida ao limite máximo; também poderá optar por continuar trocando, e quando não houver mais quantidade restante de \"Item comum\", será necessário redefinir para continuar trocando.\n(2) A partir da 6ª redefinição: somente será possível redefinir quando não houver mais quantidade restante de \"Item comum\", e a redefinição redefinirá a quantidade restante de \"Item comum\" ao limite máximo, enquanto os \"Item Especial\" não serão mais redefinidos.\n\n<Title:Tempo do evento>\n1. 17 de fevereiro 9:00 - 3 de março 9:00 (GMT+8), todas as atividades mencionadas na descrição estarão disponíveis.\n2. 3 de março 9:00 - 10 de março 9:00 (GMT+8), apenas \"Ensino do Mestre\" e \"Recompensas de Conquista\" permanecerão, enquanto outras atividades estarão encerradas.\n3. Após 10 de março 9:00 (GMT+8), as \"Peças de boneca\" não trocadas serão recolhidas na proporção de 40 \"Cupom de ouro rosa\" por cada unidade. Por favor, fique atento para verificar seu e-mail."
  },
  Activity_56429_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_56430_ActivityName = {
    Text = "Sinfonia Imaterial"
  },
  Activity_56430_ActivityPlot = {
    Text = "A sinfonia é uma arte de tecer, onde as trajetórias dos instrumentos se entrelaçam.\nEm sua teia, cada nota tem seu papel.\nOuça, uma sinfonia magnífica está prestes a começar"
  },
  Activity_56430_ActivityStageEndContent = {
    Text = "Evento encerrado, apenas disponível para \"Palácio do Sono\""
  },
  Activity_56430_ActivityTips = {
    Text = "<Title:Introdução do Evento>\n1. Durante o evento, os Guardiões do Segredo podem coletar a moeda do evento \"Canto heroico\" através das mecânicas limitadas \"Som tonante\" e \"Recompensa de conquista\". \"Canto heroico\" pode ser trocado por recompensas valiosas no \"Palácio do Sono\", incluindo a roda SR limitada do evento \"Apresentação que Nunca Para\", \"Núcleo Imaculado\", \"Núcleo de Lumen\", \"Fragmentos de Pedra Sábia\", \"Cristal de Mimese\", entre outros.\n2. Durante o evento, completar as missões da \"Recompensa de conquista\" pode resultar em um avatar limitado do evento \"Por nome da Chave de Prata: Hameln\", a roda SR limitada do evento \"Apresentação que Nunca Para\", núcleos de prata e uma grande quantidade da moeda do evento \"Canto heroico\".\n\n<Title: Tempo do Evento>\n1. De 9 de setembro às 9:00 até 23 de setembro às 9:00 (GMT+8), todos os conteúdos do evento estarão disponíveis para participação.\n2. De 23 de setembro às 9:00 até 30 de setembro às 9:00 (GMT+8), apenas o \"Palácio do Sono\" e \"Recompensa de conquista\" estarão disponíveis, todos os outros conteúdos terão terminado e não poderão ser participados.\n\n<Title: Som Tonante>\n1. \"Som tonante\" contém 9 fases, que são liberadas automaticamente uma por dia.\n2. Cada desafio consumirá \"Lingfétide\" × 120. Ao desafiar diferentes fases, além de obter diferentes materiais, também receberá a moeda do evento \"Canto heroico\".\n3. As fases deste evento são de combate direto, e podem ser reproduzidas após a conclusão! Cada \"Reprodução\" consome \"Lingfétide\" × 120.\n4. Atenção: ao usar a função \"Reprodução\", a taxa de sincronização não será obtida.\n\n<Title: Bônus do Canto>\n1. Os Guardiões do Segredo que possuírem corpos despertos ou rodas específicas (não é necessário que estejam em campo) podem obter um bônus extra na recompensa da moeda \"Canto heroico\" nas missões da fase \"Som tonante\" (incluindo reprodução), os bônus específicos são os seguintes:\n· Corpo Desperto \"Hameln\": Despertar 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%\n· Roda SSR \"Réquiem Eterno\": Posição sobreposta 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%\n· Roda SR \"Apresentação que Nunca Para\": Posição sobreposta 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%\n2. Os \"Bônus do Canto\" de diferentes corpos despertos ou rodas são acumulativos.\n3. Especialmente, a recompensa do primeiro desafio na dificuldade de loucura não será afetada pelo \"Bônus do Canto\".\n\n<Title: Palácio do Sono>\n1. O \"Palácio do Sono\" estará aberto apenas de 9 de setembro às 9:00 até 30 de setembro às 9:00 (GMT+8).\n2. Após 30 de setembro às 9:00 (GMT+8), os \"Cantos heroicos\" restantes não trocados serão recuperados na proporção de 40 \"Cupons de ouro rosa\" por cada unidade, por favor, os Guardiões do Segredo devem verificar seus e-mails."
  },
  Activity_56430_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_56431_ActivityName = {
    Text = "As estrelas estão certas"
  },
  Activity_56431_ActivityPlot = {
    Text = "O Momento da Posição Normal se aproxima, o Movimento fetal em seu interior pulsa como um tambor.\nOs pesadelos de escuridão que a atormentaram por anos culminam em um final que leva incontáveis Crentes às lágrimas.\nDe Sua@1 escuridão @2, o grande @3 chega ao mundo."
  },
  Activity_56431_ActivityStageEndContent = {
    Text = "O evento foi Concluído. Atualmente, apenas \"Eclosão do embrião sagrado\" está disponível."
  },
  Activity_56431_ActivityTips = {
    Text = "<Title:Introdução ao Evento>\n1. Durante o evento, os Guardiões do Segredo podem coletar três tipos de \"embriões\" através das jogabilidades limitadas \"Útero Escuro\" e \"Recompensas de Conquista\". Os \"embriões\" podem ser trocados por recompensas de itens em \"Eclosão do Feto Sagrado\", incluindo a roda do destino SR exclusiva do evento \"Dormir Sob a Geleira\", \"Núcleo Imaculado\", \"Núcleo de Lumen\", \"Fragmentos de Pedra Sábia\", \"Cristal de Mimese\" e outros. \n2. Durante o evento, completar as missões de \"Recompensas de Conquista\" pode recompensar com o avatar exclusivo do evento \"Por nome da Chave de Prata: Goliath\", a roda do destino SR exclusiva do evento \"Dormir Sob a Geleira\" e uma grande quantidade de \"embriões\".\n\n<Title: Tempo do Evento>\n1. De 29 de julho às 9:00 até 12 de agosto às 9:00 (GMT+8), todo o conteúdo do evento estará disponível para participação. \n2. De 12 de agosto às 9:00 até 19 de agosto às 9:00 (GMT+8), apenas \"Eclosão do Feto Sagrado\" e \"Recompensas de Conquista\" estarão disponíveis, os demais conteúdos já terão terminado e não poderão ser participados. \n\n<Title: Útero Escuro>\n1. O \"Útero Escuro\" contém 7 fases, sendo que uma nova fase será automaticamente aberta a cada dia. \n2. Cada desafio consumirá \"Lingfétide\" × 120. Ao completar um desafio com sucesso, o jogador receberá moeda do evento \"Embrião Ignorante\", \"Embrião sem desejo\" e \"Embrião Insaciável\".\n3. Após completar uma fase, a função de \"Reproduzir\" dessa fase será desbloqueada. Atenção: ao usar a função \"Reproduzir\", não será possível obter a Taxa de Sincronização. \n4. É possível usar a ajuda da associação de ex-alunos para facilitar a conclusão das fases. \n5. Após completar qualquer dificuldade da fase, a dificuldade de loucura dessa fase será desbloqueada. Completar a primeira passagem da dificuldade de loucura pode render recompensas valiosas em moeda do evento. \n6. Atenção: os desafios da dificuldade de loucura não consomem Lingfétide, não podem ser reproduzidos, e após a primeira passagem, desafios repetidos não renderão mais recompensas em moeda do evento. \n\n<Title: Bônus de Embrião>\n1. Os Guardiões do Segredo que possuírem corpos despertos ou rodas do destino específicos (não é necessário que estejam em batalha) podem fazer com que as recompensas das missões da fase \"Útero Escuro\", \"Embrião Ignorante\", \"Embrião sem desejo\" e \"Embrião Insaciável\" recebam um bônus extra de queda (incluindo a reprodução). Os bônus específicos são os seguintes: \n· Corpo Desperto \"Murphy\": Despertar 0/1/2/3 ou mais, bônus de 20%/30%/40%/50% \n· Roda do destino SSR \"Nascimento Encoberto\": Posição sobreposta 0/1/2/3 ou mais, bônus de 20%/30%/40%/50% \n· Roda do destino SR \"Dormir Sob a Geleira\": Posição sobreposta 0/1/2/3 ou mais, bônus de 20%/30%/40%/50% \n2. Os \"Bônus de Embrião\" de diferentes corpos despertos ou rodas do destino serão calculados de forma acumulativa. \n3. Notavelmente, as recompensas do primeiro desafio da dificuldade de loucura não serão afetadas pelos \"Bônus de Embrião\".\n\n<Title: Eclosão do Feto Sagrado>\n1. \"Eclosão do Feto Sagrado\" estará disponível apenas de 29 de julho às 9:00 até 19 de agosto às 9:00 (GMT+8). \n2. Após 19 de agosto às 9:00 (GMT+8), os \"embriões\" restantes não trocados serão recuperados a uma taxa de 40 \"Cupom de ouro rosa\" por cada embrião. Os Guardiões do Segredo devem prestar atenção ao verificar seus e-mails."
  },
  Activity_56431_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_56432_ActivityName = {
    Text = "Até a neve derreter"
  },
  Activity_56432_ActivityPlot = {
    Text = "As neves de Elworth nunca derretem, assim como seu ódio.\nQuando as mãos do futuro e do passado se entrelaçam, o guerreiro levantará a espada, lançando um ataque de vingança contra o destino.\nQuando ela enfrenta as ondas negras, você é sua bandeira"
  },
  Activity_56432_ActivityStageEndContent = {
    Text = "Evento encerrado, apenas disponível para \"Boca da Montanha\""
  },
  Activity_56432_ActivityTips = {
    Text = "<Title:Introdução ao Evento>\n1. Durante o evento, os guardiões podem coletar três tipos de \"botões\" através das atividades limitadas \"Ambição da Besta\" e \"Recompensa de Conquista\". Os \"botões\" podem ser trocados na \"Boca Gigante da Montanha\" para obter recompensas de itens, incluindo a roda de destino SR limitada ao evento \"Até a fusão da montanha de neve\", \"Núcleo Imaculado\", \"Núcleo de Lumen\", \"Fragmentos de Pedra Sábia\", \"Cristal de Mimese\", entre outros. \n2. Durante o evento, \"Registro da força-tarefa: O Retornado de Elworth\" estará disponível gratuitamente. \n\n<Title:Tempo do Evento>\n1. 7 de Outubro, 9:00 - 21 de Outubro, 9:00 (GMT+8), todos os conteúdos do evento estarão disponíveis. \n2. 21 de Outubro, 9:00 - 28 de Outubro, 9:00 (GMT+8), apenas \"Boca Gigante da Montanha\" e \"Recompensa de Conquista\" estarão disponíveis, outros conteúdos estarão encerrados e não poderão ser participados. \n\n<Title: Ambição da Besta>\n1. \"Ambição da Besta\" contém 5 fases, uma nova fase será aberta automaticamente a cada 2 dias. \n2. Cada desafio consumirá \"Lingfétide\" × 120, e o sucesso no desafio concederá a moeda do evento \"Brotinho congelado\", \"Brotinho de prata com geada\" e \"Botão de sol\". \n3. Após concluir a fase, a função de \"Reproduzir\" da fase será desbloqueada. Atenção: ao usar a função \"Reproduzir\", não será possível obter a taxa de sincronização. \n4. Pode-se usar a ajuda da associação de ex-alunos e \"Ressonância: Devorar Montanhas\" para facilitar a conclusão da fase. \n5. No segundo dia após a fase ser desbloqueada, a dificuldade de loucura para essa fase será desbloqueada. Completar a primeira conclusão na dificuldade de loucura dará recompensas de moeda do evento generosas. \n6. Atenção: os desafios na dificuldade de loucura não consomem Lingfétide, não podem ser reproduzidos, e após a primeira conclusão, repetir o desafio não concederá mais recompensas de moeda do evento. \n\n<Title: Bônus de Botão>\n1. Guardiões que possuem um corpo desperto ou roda de destino específica (não requerendo estar em campo) podem fazer com que as recompensas das missões das fases de \"Ambição da Besta\" dos \"Brotinhos congelados\", \"Brotinhos de prata com geada\" e \"Botão de sol\" recebam um bônus extra de queda (incluindo reprodução), os bônus específicos são os seguintes: \n· Corpo Desperto \"Cadeia de Sangue\": Despertar 0/1/2/3 ou mais, bônus de 20%/30%/40%/50% \n· Roda de destino SSR \"Afogando-se em Carmesim\": Posição sobreposta 0/1/2/3 ou mais, bônus de 20%/30%/40%/50% \n· Roda de destino SR \"Até a fusão da montanha de neve\": Posição sobreposta 0/1/2/3 ou mais, bônus de 20%/30%/40%/50% \n2. Diferentes corpos despertos ou rodas de destino terão seus \"bônus de botão\" calculados de forma acumulativa. \n3. Especialmente, a recompensa do primeiro desafio na dificuldade de loucura não será afetada pelo \"bônus de botão\". \n\n<Title:Ressonância: Devorar Montanhas>\n1. Os guardiões podem obter \"Coração Devorador\" ao completar conquistas do evento. \n2. Consumindo \"Coração Devorador\", ativar \"Ressonância: Devorar Montanhas\" permitirá que os guardiões se tornem mais fortes nas atividades \"Ambição da Besta\", tornando os desafios mais fáceis. \n\n<Title: Boca Gigante da Montanha>\n1. \"Boca Gigante da Montanha\" tem três lojas de troca, os horários de abertura são os seguintes: \n· \"Ambição Devoradora\": 7 de Outubro, 9:00. \n· \"Espírito de Vingança\": 9 de Outubro, 9:00. \n· \"Esperança de Ressurreição\": 11 de Outubro, 9:00. \n2. Cada troca consumirá 1000 \"Brotinho congelado\"/\"Brotinho de prata com geada\"/\"Botão de sol\", ganhando aleatoriamente cinco itens de recompensa da loja de troca. \n3. As recompensas de itens de cada loja de troca são divididas em \"itens especiais\" e \"itens comuns\", ao redefinir, pode-se restaurar a quantidade restante de itens especiais ao limite, as regras específicas são: \n(1) Primeiras 2 redefinições: Quando \"itens especiais\" não tiverem mais quantidade restante, os guardiões podem optar por redefinir, após a redefinição, a quantidade restante de \"itens especiais\" e \"itens comuns\" será restaurada ao limite; também pode-se optar por continuar trocando, quando \"itens comuns\" também não tiverem mais quantidade restante, será necessário redefinir para continuar trocando. \n(2) A partir da 3ª redefinição: Quando \"itens comuns\" não tiverem mais quantidade restante, poderá ser feita a redefinição, a redefinição restaurará a quantidade restante de \"itens comuns\" ao limite, \"itens especiais\" não serão mais redefinidos. \n4. Após 28 de Outubro, 9:00 (GMT+8), os \"botões\" não trocados restantes serão recuperados na proporção de 40 \"Cupom de ouro rosa\" por cada um, os guardiões devem ficar atentos para checar o e-mail. \n\n<Title: Registro da força-tarefa>\n1. Durante o evento, \"Registro da força-tarefa: O Retornado de Elworth\" estará disponível gratuitamente. A cada 2 dias, novos eventos serão lançados, ao concluir \"Registro da força-tarefa: O Retornado de Elworth\", os guardiões poderão receber Núcleo de prata, a roda de destino SR limitada ao evento \"Até a fusão da montanha de neve\" como recompensas, as recompensas de conquista estarão disponíveis apenas durante o evento, e após o término do evento, não poderão ser completadas ou reivindicadas. \n2. Após o término do evento, o progresso de investigação de \"Registro da força-tarefa: O Retornado de Elworth\" será mantido, se o \"Registro da força-tarefa: O Retornado de Elworth\" não for desbloqueado durante o evento, ainda será possível consumir \"Ponto de partida real\" × 7 para desbloqueá-lo após o término do evento. \n3. Independentemente de estar durante o evento ou não, ao concluir \"Registro da força-tarefa: O Retornado de Elworth\", os guardiões poderão obter \"Ordem de chave: A Resolução das Montanhas\"."
  },
  Activity_56432_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_56433_ActivityName = {
    Text = "Manual do detetive"
  },
  Activity_56433_ActivityPlot = {
    Text = "Um manual comum.\nRegistra as experiências de um detetive ao longo dos anos.\nEsperamos que inspire jovens aspirantes a detetive"
  },
  Activity_56433_ActivityStageEndContent = {
    Text = "O evento terminou. Atualmente, apenas \"Clube da Boa Sorte\" está disponível."
  },
  Activity_56433_ActivityTips = {
    Text = "<Title:Introdução do Evento>\n1. Durante o evento, os Guardiões do Segredo podem coletar a moeda do evento \"Ficha decisiva\" através das jogabilidades limitadas \"Lenda da noite lunar\" e \"Recompensa de conquista\". As \"Fichas decisivas\" podem ser trocadas por recompensas generosas no \"Clube da Sorte\", incluindo a roda do destino SR exclusiva do evento \"Roulette do Destino\", \"Núcleo Imaculado\", \"Núcleo de Lumen\", \"Fragmentos de Pedra Sábia\", \"Cristal de Mimese\", entre outros.\n2. Durante o evento, completar as missões da \"Recompensa de conquista\" pode resultar em um avatar exclusivo do evento \"Por nome da Chave de Prata: Leik\", a roda do destino SR \"Roulette do Destino\", núcleos de prata e uma grande quantidade de moeda do evento \"Ficha decisiva\".\n3. Durante o evento, \"Registro da força-tarefa: Boa caça!\" estará aberto gratuitamente.\n\n<Title:Tempo do Evento>\n1. De 12 de agosto às 9:00 até 26 de agosto às 9:00 (GMT+8), todo o conteúdo do evento estará disponível para participação.\n2. De 26 de agosto às 9:00 até 2 de setembro às 9:00 (GMT+8), apenas o \"Clube da Sorte\" e a \"Recompensa de conquista\" estarão disponíveis, todo o restante estará encerrado e não poderá ser participado.\n\n<Title:Lenda da Noite Lunar>\n1. A \"Lenda da noite lunar\" contém 9 fases, uma nova fase será aberta automaticamente a cada dia.\n2. Cada desafio consumirá \"Lingfétide\" × 120. Ao desafiar diferentes fases, além de obter diferentes materiais, também receberá a moeda do evento \"Ficha decisiva\".\n3. As fases do evento consistem em combate direto, e podem ser reproduzidas após a conclusão! Cada \"Reprodução\" consumirá \"Lingfétide\" × 120.\n4. Atenção: ao usar a função \"Reproduzir\", não será possível obter a Taxa de Sincronização.\n\n<Title:Aumento de Fichas>\n1. Os Guardiões do Segredo que possuírem corpos despertos ou rodas do destino específicas (não é necessário que estejam em batalha) poderão obter um aumento extra nas \"Fichas decisivas\" das recompensas das fases da \"Lenda da noite lunar\" (incluindo reproduções), com os seguintes aumentos: \n· Corpo Desperto \"Leik\": Despertar 0/1/2/3 ou superior, aumento de 20%/30%/40%/50%\n· Roda do destino SSR \"Hora da Fortuna\": Posição sobreposta 0/1/2/3 ou superior, aumento de 20%/30%/40%/50%\n· Roda do destino SR \"Roulette do Destino\": Posição sobreposta 0/1/2/3 ou superior, aumento de 20%/30%/40%/50%\n2. O \"aumento de fichas\" de diferentes corpos despertos ou rodas do destino será contabilizado de forma acumulativa.\n3. Especialmente, as recompensas do desafio de primeira passagem na dificuldade de loucura não serão afetadas pelo \"aumento de fichas\".\n\n<Title:Clube da Sorte>\n1. O \"Clube da Sorte\" estará aberto apenas de 12 de agosto às 9:00 até 2 de setembro às 9:00 (GMT+8).\n2. Após 2 de setembro às 9:00 (GMT+8), as \"Fichas decisivas\" não trocadas serão recuperadas a uma taxa de 40 \"Cupom de ouro rosa\" por ficha. Os Guardiões do Segredo devem verificar seus e-mails.\n\n<Title:Registro da Força-Tarefa>\n1. Em \"Registro da força-tarefa: Boa caça!\", os Guardiões do Segredo usarão uma formação especial que inclui o personagem predefinido \"Leik\" para desafios.\n2. Completar \"Registro da força-tarefa: Boa caça!\" concederá uma nova Ordem de chave \"Ordem de chave: Um tiro\"."
  },
  Activity_56433_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_56434_ActivityName = {
    Text = "Porta dos Mil Fenômenos"
  },
  Activity_56434_ActivityPlot = {
    Text = "Ninguém sabe há quanto tempo ela monta guarda silenciosa na Porta da Extrema Pobreza.\nEla nunca pretendeu se manifestar em qualquer mundo tangível, nem ser arrastada por qualquer corrente espaço-temporal.\nLá, na Porta, ela permaneceu imperturbável—\nAté o momento em que seus olhos encontraram os seus."
  },
  Activity_56434_ActivityStageEndContent = {
    Text = "O evento foi Concluído. Atualmente, apenas \"Resonância\" está disponível."
  },
  Activity_56434_ActivityTips = {
    Text = "<Title:Atividade Introdução>\n1. Durante o evento, o guardião pode coletar a moeda de evento \"Ponteiro final\" através da jogabilidade limitada「Teste final」e「Recompensas por Conquistas」. O \"Ponteiro final\" pode ser trocado por recompensas generosas em「Eco」, incluindo a Roda do destino SR exclusiva do evento「Porta da Verdade」, Núcleo Imaculado, Núcleo de Lumen, Fragmentos de Pedra Sábia e Cristal de Mimese.\n2. Durante o evento, completar as missões de「Recompensas por Conquistas」você poderá obter o avatar exclusivo do evento「Em Nome da Chave de Prata: \"Tavi\"」, a Roda do destino SR exclusiva do evento「Porta da Verdade」, Prata e uma grande quantidade da moeda de evento \"Ponteiro final\".\n\n<Title:Tempo do Evento>\n1. 18 de novembro 9:00 - 2 de dezembro 9:00 (GMT+8), todos os conteúdos do evento estarão disponíveis.\n2. 2 de dezembro 9:00 - 9 de dezembro 9:00 (GMT+8), apenas「Eco」e「Recompensas por Conquistas」permanecerão, os demais conteúdos terão terminado e não estarão mais disponíveis.\n\n<Title:Teste final>\n1.「Teste final」contém 9 estágios, 1 será aberto automaticamente por dia.\n2. Cada desafio consumirá 120 pontos de neuropéptideo, desafiar diferentes estágios além de obter diferentes recompensas de materiais, também dará a moeda de evento \"Ponteiro final\".\n3. Os estágios desta atividade são estágios de materiais de batalha direta, após completar você poderá recriar! Cada「recriação」consome 120 pontos de neuropéptideo.\n4. Por favor, note: ao usar a função「Recriação」, não será possível obter taxa de sincronização.\n\n<Title:Bônus do Ponteiro final>\n1. Quando o guardião possuir Corpos Despertos ou Rodas do destino específicos (não é necessário estar em combate), poderá obter bônus adicionais na quantidade de \"Ponteiro final\" recebida nas recompensas das missões do estágio「Teste final」(incluindo recriação), os bônus específicos são os seguintes:\n· Corpo Desperto「\"Tavi\"」: Despertar Espiritual 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\n· Roda do destino SSR「Roda Invisível」: Nível de empilhamento 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\n· Roda do destino SR「Porta da Verdade」: Nível de empilhamento 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\n2. Os bônus de \"Ponteiro final\" de diferentes Corpos Despertos ou Rodas do destino serão acumulados.\n3. Especialmente, as recompensas da primeira conclusão no modo Loucura não são afetadas pelo bônus do \"Ponteiro final\".\n\n<Title:Eco>\n1.「Eco」estará disponível apenas entre 18 de novembro 9:00 - 9 de dezembro 9:00 (GMT+8).\n2. Após 9 de dezembro 9:00 (GMT+8), os \"Ponteiros finais\" restantes que não foram trocados serão recuperados na proporção de \"Cupom de ouro rosa *40\" por cada unidade, por favor, verifique seu e-mail."
  },
  Activity_56434_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_56435_ActivityName = {
    Text = "Cura múltipla: Réplica"
  },
  Activity_56435_ActivityPlot = {
    Text = "Histeria. Chame de mania, chame de destruição da mente; nesta era, o diagnóstico é uma sentença de morte. Felizmente, os cientistas e investigadores da Misaq são possuídos por uma loucura própria: estão determinados a conquistar esse terror."
  },
  Activity_56435_ActivityStageEndContent = {
    Text = "O evento terminou. Atualmente, apenas \"Análise de Personalidade\" está disponível."
  },
  Activity_56435_ActivityTips = {
    Text = "<Title:Introdução ao Evento>\n1, Durante o evento, os guardiões podem coletar a moeda do evento \"Puzzle de Memória\" através dos modos limitados \"Codificação de Memória\", \"Armazenamento na Periferia\" e \"Recompensas de Conquista\". \"Puzzle de Memória\" pode ser usado para comprar itens na \"Análise de Personalidade\", incluindo a roda do destino SR exclusiva do evento \"Determinação do Bacalhau Prateado\", Núcleo de Lumen, Núcleo Imaculado, entre outros.\n2, Durante o evento, \"Registro da Força-Tarefa: Fissão Tranquila\" será desbloqueado gratuitamente por tempo limitado e completar as conquistas do evento também permitirá ganhar o avatar exclusivo do evento \"Por nome da Chave de Prata: '24' \"!\n\n<Title:Tempo do Evento>\n1, 21 de outubro às 9:00 - 4 de novembro às 9:00 (GMT+8), todos os modos do evento estarão disponíveis para participação.\n2, 4 de novembro às 9:00 - 11 de novembro às 9:00 (GMT+8), apenas \"Análise de Personalidade\" e Recompensas de Conquista estarão disponíveis.\n\n<Title:Codificação de Memória>\n1, \"Codificação de Memória\" contém 5 fases, uma nova fase será desbloqueada automaticamente a cada 2 dias.\n2, Cada desafio consumirá \"Lingfétide\" × 120, e o sucesso no desafio resultará em moeda do evento.\n3, Após concluir a fase, a função \"Reproduzir\" dessa fase será desbloqueada. Observe: ao usar a função \"Reproduzir\", não será possível obter a Taxa de Sincronização.\n4, Você pode usar ajudas da associação de ex-alunos e \"Ressonância: Síndrome de Separação\" para facilitar a sua passagem pelas fases.\n\n<Title:Aumento Racional>\n1, Guardiões que possuem um Corpo Desperto ou roda do destino específica (não precisam estar em campo) podem fazer com que a recompensa de \"Puzzle de Memória\" nas tarefas de \"Codificação de Memória\" receba um aumento adicional de queda, com os seguintes bônus:\n· Corpo Desperto \"24\": Despertar 0/1/2/3 e acima, bônus de 20%/30%/40%/50%.\n· Roda do destino SSR \"Restituição do Corpo Deformado\": Sobreposição 0/1/2/3 e acima, bônus de 20%/30%/40%/50%.\n· Roda do destino SR \"Determinação do Bacalhau Prateado\": Sobreposição 0/1/2/3 e acima, bônus de 20%/30%/40%/50%.\n2, Os \"Aumentos Racionais\" de diferentes Corpos Despertos ou rodas do destino são calculados de forma acumulativa.\n3, Notavelmente, a recompensa do desafio de primeira conclusão na dificuldade de loucura não será afetada pelos \"Aumentos Racionais\".\n\n<Title:Ressonância: Síndrome de Separação>\n1, Guardiões podem obter \"Coração Dividido\" completando conquistas do evento.\n2, Consumindo \"Coração Dividido\", a \"Ressonância: Síndrome de Separação\" pode ser ativada, fornecendo os seguintes bônus:\n(1) Aumenta a força dos guardiões nos modos do evento \"Codificação de Memória\" e \"Registro da Força-Tarefa: Fissão Tranquila\", tornando os desafios mais fáceis.\n(2) Aumenta as recompensas obtidas após completar o desafio de \"Codificação de Memória\".\n(3) Ativa o modo do evento \"Armazenamento na Periferia\".\n\n<Title: Armazenamento na Periferia>\n1, Após ativar a ressonância \"Diagnóstico: Esquizofrenia\", você receberá automaticamente 60 \"Puzzle de Memória α\" a cada hora, com um máximo de armazenamento de 25 horas.\n2, Após ativar a ressonância \"Conhecimento Harmonizado\", você receberá automaticamente 30 \"Puzzle de Memória β\" a cada hora, com um máximo de armazenamento de 25 horas.\n\n<Title:Registro da Força-Tarefa>\n1, Durante o evento, \"Registro da Força-Tarefa: Fissão Tranquila\" pode ser desbloqueado gratuitamente.\n2, Após o término do evento, o progresso da investigação de \"Registro da Força-Tarefa: Fissão Tranquila\" será mantido, e completar eventos de investigação não concluídos durante o evento permitirá ganhar recompensas de investigação consistentes com as do período do evento. Se \"Registro da Força-Tarefa: Fissão Tranquila\" não foi desbloqueado durante o evento, ainda será possível desbloqueá-lo consumindo \"Ponto de partida real\" × 7 após o término do evento.\n3, Independentemente de estar ou não durante o evento, após concluir \"Registro da Força-Tarefa: Fissão Tranquila\", você receberá \"Ordem de chave: Tudo dela\".\n\n<Title:Compensação de Réplica>\n1, Guardiões que já desbloquearam \"Registro da Força-Tarefa: Fissão Tranquila\" anteriormente receberão uma compensação de \"Puzzle de Memória α\" × 700 ao desbloqueá-lo novamente durante este evento de réplica.\n2, Guardiões que já obtiveram o avatar exclusivo do evento \"Por nome da Chave de Prata: '24'\" receberão automaticamente \"Puzzle de Memória α\" × 2000 ao obtê-lo novamente.\n3, Guardiões que já obtiveram o material de ativação de ressonância \"Coração Dividido\" receberão automaticamente \"Cupom de Ouro Rosa\" × 5000 ao obter um \"Coração Dividido\" adicional"
  },
  Activity_56435_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_56436_ActivityName = {
    Text = "Banquete Ardente: Recorrência"
  },
  Activity_56436_ActivityPlot = {
    Text = "Isalrauh, a cidade no lago, supostamente é a terra natal de wanda.\nDesta vez você passará pela porta do sonho e chegará àquela antiga torre repleta de línguas de sino"
  },
  Activity_56436_ActivityStageEndContent = {
    Text = "O evento terminou, atualmente só é possível participar do\"Baú do tesouro de wanda\""
  },
  Activity_56436_ActivityTips = {
    Text = "<Title:Introdução ao Evento>\n1 Durante o período do evento, os guardiões podem coletar moedas do evento \"Tíbias Primitivas\", \"Amónito de folhas arredondadas\", \"Ruínas Espirais\" através das mecânicas limitadas \"Festa Ardente\" e \"Recompensa de Conquista\". As moedas do evento podem ser usadas para comprar produtos na \"A Caixa de Tesouros Exóticos de Wanda\", incluindo a roda do destino SR exclusiva do evento \"O olhar de Isarau\", Núcleo de Lumen, Núcleo Imaculado, entre outros. \n2 Durante o evento, a \"Navegação na consciência: Festa Ardente\" será desbloqueada gratuitamente por tempo limitado, e completar as conquistas do evento também permitirá que você obtenha o avatar exclusivo do evento \"Por nome da Chave de Prata: Wanda\"!\n\n<Title:Tempo do Evento>\n1 De 23 de setembro às 9:00 até 7 de outubro às 9:00 (GMT+8), todas as mecânicas do evento estarão disponíveis. \n2 De 7 de outubro às 9:00 até 14 de outubro às 9:00 (GMT+8), somente será possível participar da \"A Caixa de Tesouros Exóticos de Wanda\" e das recompensas de conquista. \n\n<Title:Cidade no Lago>\n1 A \"Cidade no Lago\" possui 7 fases, sendo que uma fase será desbloqueada automaticamente a cada dia. \n2 Cada desafio consumirá \"Lingfétide\" × 120, e o sucesso no desafio garantirá moedas do evento. \n3 Após completar a fase, a função \"Reproduzir\" dessa fase será desbloqueada. Atenção: ao usar a função \"Reproduzir\", não será possível obter a Taxa de Sincronização. \n4 Você pode usar a ajuda da associação de ex-alunos e \"Ressonância: Ordem secreta\" para facilitar sua passagem pelas fases. \n\n<Title:Bônus Exóticos>\n1 Guardiões que possuírem corpos despertos ou rodas do destino específicas (não é necessário que estejam em uso) poderão obter um bônus adicional nas moedas do evento na recompensa da tarefa da fase \"Cidade no Lago\", conforme os seguintes bônus: \n· Corpo Desperto \"Wanda\": Despertar 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%. \n· Roda do destino SSR \"Decreto da Rainha\": Posição sobreposta 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%. \n· Roda do destino SR \"O olhar de Isarau\": Posição sobreposta 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%. \n2 Os \"Bônus Exóticos\" de diferentes corpos despertos ou rodas do destino serão somados. \n3 Especialmente, a recompensa do desafio de dificuldade de loucura não será afetada pelos \"Bônus Exóticos\". \n\n<Title:Ressonância: Ordem Secreta>\n1 Os guardiões podem obter \"Coração do prazer\" ao completar as conquistas do evento. \n2 Consumindo \"Coração do prazer\", ativar \"Ressonância: Ordem secreta\" permitirá que os guardiões se tornem mais fortes na \"Cidade no Lago\", facilitando os desafios; também permitirá que os guardiões obtenham moedas do evento adicionais ao completar as fases. \n\n<Title:Navegação na Consciência>\n1 Durante o evento, a \"Festa Ardente\" pode ser desbloqueada gratuitamente. \n2 Após o término do evento, o progresso da investigação da \"Festa Ardente\" será mantido, e completar eventos de investigação não finalizados durante o período do evento também permitirá que você receba recompensas de investigação correspondentes ao período do evento. Se a \"Festa Ardente\" não foi desbloqueada durante o evento, ainda será possível desbloqueá-la após o término do evento consumindo \"Ponto de partida real\" × 3. \n3 Independentemente de estar ou não durante o evento, ao completar a \"Festa Ardente\", você pode obter \"Ordem de chave: Festim Podre\". \n\n<Title:Compensação de Reedição>\n1 Guardiões que já desbloquearam \"Navegação na consciência: Festa Ardente\" receberão uma compensação de \"Tíbias Primitivas\" × 300 durante o período da reedição ao desbloqueá-la novamente. \n2 Guardiões que já obtiveram o avatar exclusivo do evento \"Por nome da Chave de Prata: Wanda\" receberão \"Tíbias Primitivas\" × 2000 ao obtê-lo novamente. \n3 Guardiões que já obtiveram o material de ativação da ressonância \"Coração do prazer\", cada \"Coração do prazer\" adicional obtido será automaticamente convertido em \"Cupom de ouro rosa\" × 5000. \n"
  },
  Activity_56436_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_56477_ActivityName = {
    Text = "Profanação"
  },
  Activity_56478_ActivityName = {Text = "Boa caça!"},
  Activity_56479_ActivityName = {
    Text = "Pastor de almas"
  },
  Activity_56480_ActivityName = {
    Text = "Festa Ardente"
  },
  Activity_56481_ActivityName = {
    Text = "Elworth's returnee"
  },
  Activity_56482_ActivityName = {
    Text = "Fissão Tranquila"
  },
  Activity_59841_ActivityName = {
    Text = "Pacote de Crescimento de Valor (Descontinuado)"
  },
  Activity_59841_ActivityPlot = {
    Text = "Após a compra, \"Daffodil\" pode crescer para\n<BlueQuality:Nv50>, <BlueQuality:Todas as Habilidades Nv4>"
  },
  Activity_59842_ActivityName = {
    Text = "Pacote de Crescimento de Valor (Descontinuado)"
  },
  Activity_59842_ActivityPlot = {
    Text = "Após a compra, \"Wanda\" pode crescer para\n<BlueQuality:Lv50>, <BlueQuality:All Skills Lv4>"
  },
  Activity_59843_ActivityName = {
    Text = "Pacote de Crescimento de Valor (Descontinuado)"
  },
  Activity_59843_ActivityPlot = {
    Text = "Após a compra, \"Tulu\" pode crescer até\n<BlueQuality:Nv50>, <BlueQuality:Todas as Habilidades Nv4>"
  },
  Activity_59844_ActivityName = {
    Text = "Pacote de Crescimento de Valor (Descontinuado)"
  },
  Activity_59844_ActivityPlot = {
    Text = "Após a compra, \"Thais\" pode crescer para\n<BlueQuality:Lv50>, <BlueQuality:All Skills Lv4>"
  },
  Activity_59845_ActivityName = {
    Text = "Pacote de Crescimento de Valor (Descontinuado)"
  },
  Activity_59845_ActivityPlot = {
    Text = "Após a compra, \"Miryam\" pode crescer para\n<BlueQuality:Nv50>, <BlueQuality:Todas as Habilidades Nv4>"
  },
  Activity_59846_ActivityName = {
    Text = "Pacote de Crescimento de Valor (Descontinuado)"
  },
  Activity_59846_ActivityPlot = {
    Text = "Após a compra, \"Hameln\" pode crescer até\n<BlueQuality:Lv50>, <BlueQuality:Todas as Habilidades Lv4>"
  },
  Activity_59847_ActivityName = {
    Text = "Tributo Retrospectivo VIII"
  },
  Activity_59847_ActivityPlot = {
    Text = "Um pedaço de memória selado e arquivado, uma jornada registrada no passado. Em momentos de lembrança, não se esqueça de oferecer sua reverente Visita."
  },
  Activity_59848_ActivityName = {
    Text = "Tributo Retrospectivo III"
  },
  Activity_59848_ActivityPlot = {
    Text = "Um pedaço de memória selado e arquivado, uma jornada registrada no passado. Em momentos de lembrança, não se esqueça de oferecer sua reverente Visita."
  },
  Activity_59849_ActivityName = {
    Text = "Pacote de Crescimento de Valor (Descontinuado)"
  },
  Activity_59849_ActivityPlot = {
    Text = "Após a compra, \"Hilota·Catena\" pode crescer até\n<BlueQuality:Lv50>, <BlueQuality:All Skills Lv4>"
  },
  Activity_59850_ActivityName = {
    Text = "Comemoração da Jornada I"
  },
  Activity_59850_ActivityPlot = {
    Text = "Um pedaço de memória selado e arquivado, uma jornada registrada no passado. Em momentos de lembrança, não se esqueça de oferecer sua reverente Visita."
  },
  Activity_59851_ActivityName = {
    Text = "Tributo Retrospectivo: Prelúdio"
  },
  Activity_59851_ActivityPlot = {
    Text = "Um pedaço de memória selado e arquivado, uma jornada registrada no passado. Em momentos de lembrança, não se esqueça de oferecer sua reverente Visita."
  },
  Activity_59852_ActivityName = {
    Text = "Tributo Retrospectivo VII"
  },
  Activity_59852_ActivityPlot = {
    Text = "Um pedaço de memória selado e arquivado, uma jornada registrada no passado. Em momentos de lembrança, não se esqueça de oferecer sua reverente Visita."
  },
  Activity_59853_ActivityName = {
    Text = "Tributo Retrospectivo VI"
  },
  Activity_59853_ActivityPlot = {
    Text = "Um pedaço de memória selado e arquivado, uma jornada registrada no passado. Em momentos de lembrança, não se esqueça de oferecer sua reverente Visita."
  },
  Activity_59854_ActivityName = {
    Text = "Tributo Retrospectivo V"
  },
  Activity_59854_ActivityPlot = {
    Text = "Um pedaço de memória selado e arquivado, uma jornada registrada no passado. Em momentos de lembrança, não se esqueça de oferecer sua reverente Visita."
  },
  Activity_59855_ActivityName = {
    Text = "Tributo Retrospectivo IV"
  },
  Activity_59855_ActivityPlot = {
    Text = "Um pedaço de memória selado e arquivado, uma jornada registrada no passado. Em momentos de lembrança, não se esqueça de oferecer sua reverente Visita."
  },
  Activity_59856_ActivityName = {
    Text = "Pacote de Crescimento de Valor (Descontinuado)"
  },
  Activity_59856_ActivityPlot = {
    Text = "Após a compra, \"Murphy\" pode crescer até\n<BlueQuality:Lv50>, <BlueQuality:Todas as Habilidades Lv4>"
  },
  Activity_59857_ActivityName = {
    Text = "Pacote de Crescimento de Valor (Descontinuado)"
  },
  Activity_59857_ActivityPlot = {
    Text = "Após a compra, \"Ryker\" pode crescer para\n<BlueQuality:Nv50>, <BlueQuality:Todas as Habilidades Nv4>"
  },
  Activity_59858_ActivityName = {
    Text = "Tributo Retrospectivo II"
  },
  Activity_59858_ActivityPlot = {
    Text = "Um pedaço de memória selado e arquivado, uma jornada registrada no passado. Em momentos de lembrança, não se esqueça de oferecer sua reverente Visita."
  },
  Activity_59859_ActivityName = {
    Text = "Pacote de Crescimento de Valor (Descontinuado)"
  },
  Activity_59859_ActivityPlot = {
    Text = "Após a compra, \"Sorel\" pode crescer para\n<BlueQuality:Lv50>, <BlueQuality:All Skills Lv4>"
  },
  Activity_59860_ActivityName = {
    Text = "Pacote de Crescimento de Valor (Descontinuado)"
  },
  Activity_59860_ActivityPlot = {
    Text = "Após a compra, \"Horla\" pode crescer para\n<BlueQuality:Nv50>, <BlueQuality:Todas as Habilidades Nv4>"
  },
  Activity_59861_ActivityName = {
    Text = "Pacote de Crescimento de Valor (Descontinuado)"
  },
  Activity_59861_ActivityPlot = {
    Text = "Após a compra, \"Salvador\" pode crescer para\n<BlueQuality:Nv50>, <BlueQuality:Todas as Habilidades Nv4>"
  },
  Activity_59862_ActivityName = {
    Text = "Pacote de Crescimento de Valor (Descontinuado)"
  },
  Activity_59862_ActivityPlot = {
    Text = "Após a compra, \"Tavi\" pode crescer até\n<BlueQuality:Lv50>, <BlueQuality:Todas as Habilidades Lv4>"
  },
  Activity_59863_ActivityName = {
    Text = "Pacote de Crescimento de Valor (Descontinuado)"
  },
  Activity_59863_ActivityPlot = {
    Text = "Após a compra, \"Lily\" pode crescer para\n<BlueQuality:Nv50>, <BlueQuality:Todas as Habilidades Nv4>"
  },
  Activity_59864_ActivityName = {
    Text = "Pacote de Crescimento de Valor (Descontinuado)"
  },
  Activity_59864_ActivityPlot = {
    Text = "Após a compra, \"24\" pode crescer até\n<BlueQuality:Lv50>, <BlueQuality:Todas as Habilidades Lv4>"
  },
  Activity_59865_ActivityName = {
    Text = "Pacote de Crescimento de Valor (Descontinuado)"
  },
  Activity_59865_ActivityPlot = {
    Text = "Após a compra, \"Gênesis·Boneca\" pode crescer até\n<BlueQuality:Lv50>, <BlueQuality:All Skills Lv4>"
  },
  Activity_61156_ActivityName = {
    Text = "Jornada Final"
  },
  Activity_61156_ActivityTips = {
    Text = "Evento Regras:\n1. Após completar as tarefas especificadas do Guardião, as recompensas podem ser reivindicadas no \"Diário Final\".\n2. O \"Diário Final\" está permanentemente disponível.\n3. Desbloqueie o \"Diário Avançado\" para receber recompensas adicionais ao completar tarefas.\n4. Nota: O \"Diário Avançado\" desbloqueado durante este evento é válido apenas durante a duração deste evento. Os Guardiões são aconselhados a gastar com sabedoria."
  },
  Activity_61369_ActivityName = {
    Text = "Ritmo progressivo"
  },
  Activity_61369_ActivityPlot = {
    Text = "Os Guardiões do segredo podem escolher uma das seguintes Rodas do destino limitadas para Despertar gratuitamente!"
  },
  Activity_61369_ActivityTips = {
    Text = "<Title:Visão Geral>\nNo misterioso Lago Negro, onde nuvens de intriga se agitam, a Roda do destino gira repetidamente. Guiadas pela música de Hameln, incontáveis melodias se harmonizam na Roda da sua jornada. Que a ajuda delas o acompanhe até a nota final da sinfonia conclusiva.\n\n<Title:Regras do Evento>\nDurante o evento, faça login por um dia para selecionar e despertar uma das seguintes 12 Rodas limitadas, incluindo: Hino do Soberano, Raridade Preciosa, Em Nome de Rosa, Graça Através da Dor, Nascimento Encoberto, Decreto da Rainha, Tábula das Escrituras, Restituição do corpo deformado, Poder do Devoto, O Último Verso, Nutrição Misericordiosa e Hora da Fortuna."
  },
  Activity_61369_BannerText = {
    Text = "Reivindique uma Roda do destino limitada gratuitamente"
  },
  Activity_61370_ActivityName = {
    Text = "Coração de Prata"
  },
  Activity_61370_ActivityPlot = {
    Text = "Faça login diariamente para reivindicar a Roda do destino SSR comemorativa de edição limitada \"Coração de Prata Imaculada\", até 16 no total!"
  },
  Activity_61370_ActivityTips = {
    Text = "<Title:Introdução>\nNão importa como o mundo possa virar de cabeça para baixo, desde que todos guardem seu coração original e puro como a prata, a história inevitavelmente ciclará, e uma nova vida renascerá sobre a terra desolada.\n\n<Title:Regras do Evento>\n·Durante o evento, os guardiões podem se conectar diariamente para reivindicar a edição limitada SSR Roda do Destino \"Coração Puro de Prata\", com um total de 16 reivindicações.\n·As recompensas serão desbloqueadas em ordem de acordo com os logins acumulados dos guardiões, e as recompensas diárias de login serão atualizadas às 9h (GMT+8)"
  },
  Activity_61370_BannerText = {
    Text = "Roda do destino SSR Limitada Grátis"
  },
  Activity_61371_ActivityName = {
    Text = "Orações das asas hexad"
  },
  Activity_61371_ActivityPlot = {
    Text = "Em meio à turbulência do Lago Negro, Prata de infinitas Dimensões se espalhou ao longo de suas margens através de fendas dimensionais. Tawil cuidadosamente as recolheu e as colocou em um canto do Lago Negro. Embora essa Prata não possa deter a Propagação da Fusão, os sentimentos e emoções que ela guarda dentro de si brilharão intensamente para sempre."
  },
  Activity_61371_ActivityTips = {
    Text = "<Title:Visão Geral>\nEm meio à turbulência do Lago Negro, Prata dispersa através de fendas dimensionais de infinitas Dimensões jaz à beira do Lago Negro. Tawil cuidadosamente as recolhe e as coloca em um canto do Lago Negro. Embora essa Prata não possa deter a Propagação da Fusão, as memórias e sentimentos que ela abriga sempre brilharão intensamente.\n\n<Title:Regras do Evento>\nDurante o evento, os Guardiões do segredo podem fazer login diariamente para receber 1000 de Prata durante a atividade, com um máximo de 6 resgates.\nNo 7º dia de login acumulado, os Guardiões do segredo podem reivindicar diretamente o Corpo Desperto limitado \"Tavi\"!\nAs recompensas serão desbloqueadas sequencialmente com base nos logins diários acumulados dos Guardiões do segredo, e as recompensas de login diário serão atualizadas às 9h (GMT+8)."
  },
  Activity_61371_BannerText = {
    Text = "Faça login para reivindicar toneladas de Prata"
  },
  Activity_61482_ActivityName = {
    Text = "Presente Comemorativo de Promoção V"
  },
  Activity_61482_ActivityPlot = {
    Text = "O caminho se estende longo, envolto na escuridão da Fusão.\nA luz da Chave de prata nos guiará a todos."
  },
  Activity_61483_ActivityName = {
    Text = "Presente Comemorativo de Promoção IV"
  },
  Activity_61483_ActivityPlot = {
    Text = "O caminho se estende longo, envolto na escuridão da Fusão.\nA luz da Chave de prata nos guiará a todos."
  },
  Activity_61484_ActivityName = {
    Text = "Presente Comemorativo de Promoção VII"
  },
  Activity_61484_ActivityPlot = {
    Text = "O caminho se estende longo, envolto na escuridão da Fusão.\nA luz da Chave de prata nos guiará a todos."
  },
  Activity_61485_ActivityName = {
    Text = "Presente Comemorativo de Promoção VI"
  },
  Activity_61485_ActivityPlot = {
    Text = "O caminho se estende longo, envolto na escuridão da Fusão.\nA luz da Chave de prata nos guiará a todos."
  },
  Activity_61486_ActivityName = {
    Text = "Presente Comemorativo de Promoção I"
  },
  Activity_61486_ActivityPlot = {
    Text = "O caminho se estende longo, envolto na escuridão da Fusão.\nA luz da Chave de prata nos guiará a todos."
  },
  Activity_61487_ActivityName = {
    Text = "Presente Comemorativo de Promoção III"
  },
  Activity_61487_ActivityPlot = {
    Text = "O caminho se estende longo, envolto na escuridão da Fusão.\nA luz da Chave de prata nos guiará a todos."
  },
  Activity_61488_ActivityName = {
    Text = "Presente Comemorativo de Promoção II"
  },
  Activity_61488_ActivityPlot = {
    Text = "O caminho se estende longo, envolto na escuridão da Fusão.\nA luz da Chave de prata nos guiará a todos."
  },
  Activity_61489_ActivityName = {
    Text = "Presente Comemorativo de Promoção VIII"
  },
  Activity_61489_ActivityPlot = {
    Text = "O caminho se estende longo, envolto na escuridão da Fusão.\nA luz da Chave de prata nos guiará a todos."
  },
  Activity_61517_ActivityName = {
    Text = "Caixa de suprimentos de investigação"
  },
  Activity_61517_ActivityPlot = {
    Text = "Investigação de suprimentos fornecidos pelo Escritório Administrativo de Misaq. Refinados por Alistair a partir dos destroços do Lago Negro."
  },
  Activity_61546_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61546_ActivityPlot = {
    Text = "Ao adquirir, \"Tulu\" pode ser ativado\n<BlueQuality:Melhoria de persona +4, desbloquear Exaltação Excessiva>"
  },
  Activity_61547_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61547_ActivityPlot = {
    Text = "Após a compra, \"Horla\" pode ativar <BlueQuality:Iluminar 3>"
  },
  Activity_61548_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61548_ActivityPlot = {
    Text = "Após a compra, \"Faros\" pode ativar <BlueQuality:Iluminar 3>"
  },
  Activity_61549_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61549_ActivityPlot = {
    Text = "Após a compra, \"Alva\" pode ser ativado\n<BlueQuality:aprimoramento da Persona +4, desbloquear Super-Exaltação>"
  },
  Activity_61550_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61550_ActivityPlot = {
    Text = [[
Ao comprar, "Jenkin" pode ser ativado
<BlueQuality:Aprimoramento de Persona +4, desbloquear Over-Exaltation>]]
  },
  Activity_61551_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61551_ActivityPlot = {
    Text = [[
Ao comprar, "Pandia" pode ser ativado
<BlueQuality:Aprimoramento de Persona +4, desbloquear Over-Exaltation>]]
  },
  Activity_61552_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61552_ActivityPlot = {
    Text = "Após a compra, \"Celeste\" pode ativar <BlueQuality:Iluminar 3>"
  },
  Activity_61553_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61553_ActivityPlot = {
    Text = "Ao comprar, \"\"24\"\" ativa <BlueQuality:Iluminar 3>"
  },
  Activity_61554_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61554_ActivityPlot = {
    Text = "Após a compra, \"Desmaio\" pode ativar <BlueQuality:Iluminar 3>"
  },
  Activity_61555_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61555_ActivityPlot = {
    Text = "Ao adquirir, \"Tinta\" pode ser ativado\n<BlueQuality:Melhoria de persona +4, desbloquear Exaltação Excessiva>"
  },
  Activity_61556_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61556_ActivityPlot = {
    Text = "Ao comprar, \"Casiah\" ativa <BlueQuality:Iluminar 3>"
  },
  Activity_61557_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61557_ActivityPlot = {
    Text = "Após a compra, \"Salvador\" pode ativar <BlueQuality:Iluminar 3>"
  },
  Activity_61558_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61558_ActivityPlot = {
    Text = [[
Ao comprar, "Salvador" pode ser ativado
<BlueQuality:Aprimoramento de Persona +4, desbloquear Over-Exaltation>]]
  },
  Activity_61559_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61559_ActivityPlot = {
    Text = "Após a compra, \"Táias\" pode ativar <BlueQuality:Iluminar 3>"
  },
  Activity_61560_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61560_ActivityPlot = {
    Text = [[
Ao comprar, "Lily" pode ser ativado
<BlueQuality:Aprimoramento de Personalidade +4, desbloquear Over-Exaltation>]]
  },
  Activity_61561_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61561_ActivityPlot = {
    Text = "Após a compra, \"Golias\" pode ativar <BlueQuality:Iluminar 3>"
  },
  Activity_61562_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61562_ActivityPlot = {
    Text = "Após a compra, \"Lily\" pode ativar <BlueQuality:Iluminar 3>"
  },
  Activity_61563_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61563_ActivityPlot = {
    Text = "Após a compra, \"Sanga\" pode ativar <BlueQuality:Iluminar 3>"
  },
  Activity_61564_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61564_ActivityPlot = {
    Text = "Após a compra, \"Narciso\" pode ativar <BlueQuality:Iluminar 3>"
  },
  Activity_61565_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61565_ActivityPlot = {
    Text = "Ao comprar, \"Náutilo\" pode ser ativado\n<BlueQuality:Aprimoramento de Persona +4, desbloquear Over-Exaltation>"
  },
  Activity_61566_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61566_ActivityPlot = {
    Text = "Após a compra, \"Karen\" pode ativar <BlueQuality:Iluminar 3>"
  },
  Activity_61567_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61567_ActivityPlot = {
    Text = "Após a compra, \"Alva\" pode ativar <BlueQuality:Iluminar 3>"
  },
  Activity_61568_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61568_ActivityPlot = {
    Text = "Após a compra, \"Leigh\" pode ativar <BlueQuality:Iluminar 3>"
  },
  Activity_61569_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61569_ActivityPlot = {
    Text = "Ao comprar, \"Tulu\" ativa <BlueQuality:Iluminar 3>"
  },
  Activity_61570_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61570_ActivityPlot = {
    Text = "Ao comprar, \"Caecus\" ativa <BlueQuality:Iluminar 3>"
  },
  Activity_61571_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61571_ActivityPlot = {
    Text = "Ao adquirir, \"Búzio\" pode ser ativado\n<BlueQuality:Melhoria de persona +4, desbloquear Exaltação Excessiva>"
  },
  Activity_61572_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61572_ActivityPlot = {
    Text = "Ao adquirir, \"Wanda\" pode ser ativado\n<BlueQuality:Melhoria de persona +4, desbloquear Exaltação Excessiva>"
  },
  Activity_61573_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61573_ActivityPlot = {
    Text = [[
Ao comprar, "Golias" pode ser ativado
<BlueQuality:Aprimoramento de Personalidade +4, desbloquear Over-Exaltation>]]
  },
  Activity_61574_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61574_ActivityPlot = {
    Text = "Após a compra, \"Ryker\" pode ativar <BlueQuality:Iluminar 3>."
  },
  Activity_61575_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61575_ActivityPlot = {
    Text = "Após a compra, \"Nínfea\" pode ativar <BlueQuality:Iluminar 3>"
  },
  Activity_61576_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61576_ActivityPlot = {
    Text = "Após a compra, \"Caecus\" pode ser ativado\n<BlueQuality:aprimoramento da Persona +4, desbloquear Super-Exaltação>"
  },
  Activity_61577_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61577_ActivityPlot = {
    Text = "Após a compra, \"Miryam\" pode ativar <BlueQuality:Iluminar 3>"
  },
  Activity_61578_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61578_ActivityPlot = {
    Text = [[
Ao comprar, "Ryker" pode ser ativado
<BlueQuality:Aprimoramento de Persona +4, desbloquear Over-Exaltation>]]
  },
  Activity_61579_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61579_ActivityPlot = {
    Text = [[
Ao comprar, "Sanga" pode ser ativado
<BlueQuality:Aprimoramento de Personalidade +4, desbloquear Over-Exaltation>]]
  },
  Activity_61580_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61580_ActivityPlot = {
    Text = "Após a compra, \"Tinta\" pode ativar <BlueQuality:Iluminar 3>"
  },
  Activity_61581_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61581_ActivityPlot = {
    Text = [[
Ao comprar, "Leigh" pode ser ativado
<BlueQuality:Aprimoramento de Persona +4, desbloquear Over-Exaltation>]]
  },
  Activity_61582_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61582_ActivityPlot = {
    Text = "Após a compra, \"Liz\" pode ativar <BlueQuality:Iluminar 3>"
  },
  Activity_61583_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61583_ActivityPlot = {
    Text = [[
Ao comprar, "Hilota" pode ser ativado
<BlueQuality:Aprimoramento de Persona +4, desbloquear Over-Exaltation>]]
  },
  Activity_61584_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61584_ActivityPlot = {
    Text = "Após a compra, \"Casiah\" pode ser ativado\n<BlueQuality:aprimoramento da Persona +4, desbloquear Super-Exaltação>"
  },
  Activity_61585_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61585_ActivityPlot = {
    Text = "Ao comprar, \"Faróis\" pode ser ativado\n<BlueQuality:Aprimoramento de Persona +4, desbloquear Over-Exaltation>"
  },
  Activity_61586_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61586_ActivityPlot = {
    Text = "Após a compra, \"Agrippa\" pode ser ativado\n<BlueQuality:aprimoramento da Persona +4, desbloquear Super-Exaltação>"
  },
  Activity_61587_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61587_ActivityPlot = {
    Text = "Após a compra, \"Náutilo\" pode ativar <BlueQuality:Iluminar 3>"
  },
  Activity_61588_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61588_ActivityPlot = {
    Text = "Após a compra, \"Narciso\" pode ser ativado\n<BlueQuality:aprimoramento da Persona +4, desbloquear Super-Exaltação>"
  },
  Activity_61589_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61589_ActivityPlot = {
    Text = "Ao comprar, \"Hameln\" ativa <BlueQuality:Iluminar 3>"
  },
  Activity_61590_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61590_ActivityPlot = {
    Text = [[
Ao comprar, "Liz" pode ser ativado
<BlueQuality:Aprimoramento de Persona +4, desbloquear Over-Exaltation>]]
  },
  Activity_61591_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61591_ActivityPlot = {
    Text = [[
Ao comprar, "Miryam" pode ser ativado
<BlueQuality:Aprimoramento de Persona +4, desbloquear Over-Exaltation>]]
  },
  Activity_61592_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61592_ActivityPlot = {
    Text = "Após a compra, \"Wanda\" pode ativar <BlueQuality:Iluminar 3>"
  },
  Activity_61593_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61593_ActivityPlot = {
    Text = [[
Ao comprar, "Karen" pode ser ativado
<BlueQuality:Aprimoramento de Persona +4, desbloquear Over-Exaltation>]]
  },
  Activity_61594_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61594_ActivityPlot = {
    Text = "Após a compra, \"Uvhash\" pode ativar <BlueQuality:Iluminar 3>"
  },
  Activity_61595_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61595_ActivityPlot = {
    Text = "Ao adquirir, \"Táias\" pode ser ativado\n<BlueQuality:Melhoria de persona +4, desbloquear Exaltação Excessiva>"
  },
  Activity_61596_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61596_ActivityPlot = {
    Text = "Ao adquirir, \"Uvhash\" pode ser ativado\n<BlueQuality:Melhoria de persona +4, desbloquear Exaltação Excessiva>"
  },
  Activity_61597_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61597_ActivityPlot = {
    Text = [[
Ao comprar, "Hameln" pode ser ativado
<BlueQuality:Aprimoramento de Persona +4, desbloquear Over-Exaltation>]]
  },
  Activity_61598_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61598_ActivityPlot = {
    Text = "Após a compra, \"Murphy\" ativa <BlueQuality:Iluminar 3>"
  },
  Activity_61599_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61599_ActivityPlot = {
    Text = "Após a compra, \"Sorel\" pode ativar <BlueQuality:Iluminar 3>"
  },
  Activity_61600_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61600_ActivityPlot = {
    Text = [[
Ao comprar, "Sorel" pode ser ativado
<BlueQuality:Aprimoramento de Persona +4, desbloquear Over-Exaltation>]]
  },
  Activity_61601_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61601_ActivityPlot = {
    Text = "Após a compra, \"Hilota\" pode ativar <BlueQuality:Iluminar 3>"
  },
  Activity_61602_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61602_ActivityPlot = {
    Text = [[
Ao comprar, "Horla" pode ser ativado
<BlueQuality:Aprimoramento de Persona +4, desbloquear Over-Exaltation>]]
  },
  Activity_61603_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61603_ActivityPlot = {
    Text = "Após a compra, \"Tawil\" ativa <BlueQuality:Iluminar 3>"
  },
  Activity_61604_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61604_ActivityPlot = {
    Text = "Após a compra, \"\"24\"\" pode ser ativado\n<BlueQuality:aprimoramento da Persona +4, desbloquear Super-Exaltação>"
  },
  Activity_61605_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61605_ActivityPlot = {
    Text = "Ao comprar, \"Agrippa\" pode ativar <BlueQuality:Iluminar 3>"
  },
  Activity_61606_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61606_ActivityPlot = {
    Text = "Após a compra, \"Pandia\" pode ativar <BlueQuality:Iluminar 3>"
  },
  Activity_61607_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61607_ActivityPlot = {
    Text = "Após a compra, \"Hilota·Catena\" pode ser ativado\n<BlueQuality:Persona Deepening +4, Unlock Over-Exaltation>"
  },
  Activity_61608_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61608_ActivityPlot = {
    Text = "Após a compra, \"Jenkin\" pode ativar <BlueQuality:Iluminar 3>"
  },
  Activity_61609_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61609_ActivityPlot = {
    Text = "Ao comprar, \"Nínfea\" pode ser ativado\n<BlueQuality:+4 para Aprimoramento de Persona, desbloquear Over-Exaltation>"
  },
  Activity_61610_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61610_ActivityPlot = {
    Text = "Após a compra, \"Búzio\" pode ativar <BlueQuality:Iluminar 3>"
  },
  Activity_61611_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61611_ActivityPlot = {
    Text = [[
Ao comprar, "Desmaio" pode ser ativado
<BlueQuality:Aprimoramento de Persona +4, desbloquear Over-Exaltation>]]
  },
  Activity_61612_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61612_ActivityPlot = {
    Text = [[
Ao comprar, "Murphy" pode ser ativado
<BlueQuality:Aprimoramento de Persona +4, desbloquear Over-Exaltation>]]
  },
  Activity_61613_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61613_ActivityPlot = {
    Text = "Ao adquirir, \"Tawil\" pode ser ativado\n<BlueQuality:Melhoria de persona +4, desbloquear Exaltação Excessiva>"
  },
  Activity_61614_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_61614_ActivityPlot = {
    Text = "Após a compra, \"Hilota·Catena\" pode ativar <BlueQuality:Iluminar 3>"
  },
  Activity_61615_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_61615_ActivityPlot = {
    Text = "Após a compra, \"Celeste\" pode ser ativado\n<BlueQuality:aprimoramento da Persona +4, desbloquear Super-Exaltação>"
  },
  Activity_65387_ActivityName = {
    Text = "Desculpa do gato da escola"
  },
  Activity_65387_ActivityPlot = {
    Text = "Devido a vulnerabilidades recentes nas medidas de proteção da escola, <Del:\"Texto temporário, Ponto Vermelho\"> incidentes de Invasão de Fusão no campus têm aumentado, causando grande inconveniência aos estudantes. Portanto, a administração da escola estabeleceu múltiplos pontos de abastecimento para distribuir materiais como compensação. (Dada a responsabilidade pela falha na gestão das instalações, todos os materiais de abastecimento desta vez serão transportados inteiramente pelo Gato da Escola.)"
  },
  Activity_65387_ActivityTips = {
    Text = "<Title:Visão Geral>\nRecentemente, devido a falhas nas medidas de proteção da escola, tem havido um número crescente de <Del>\"texto temporário, ponto vermelho\"> incidentes de Fusão perturbando o campus, causando grande inconveniência aos estudantes. Portanto, a administração da escola estabeleceu múltiplos pontos de abastecimento para distribuir o inventário como compensação. (Devido à responsabilidade por erros na gestão das instalações, a distribuição dos materiais será inteiramente realizada pelo gato da escola.)\n\n<Title:Regras do Evento>\nDurante o evento, os Guardiões do segredo podem fazer login diariamente para reivindicar 500 de Prata da \"Desculpa do Gato da Escola\", com um máximo de 5 resgates.\nAs recompensas serão desbloqueadas sequencialmente com base nos logins diários acumulados dos Guardiões do segredo, e as recompensas de login diário serão atualizadas às 9h (GMT+8)."
  },
  Activity_65387_BannerText = {
    Text = "Faça login para reivindicar Prata"
  },
  Activity_65502_ActivityName = {
    Text = "Melodia Progressiva: Dueto"
  },
  Activity_65502_ActivityPlot = {
    Text = "Os Guardiões do segredo podem escolher uma das seguintes Rodas do destino limitadas para Despertar gratuitamente!"
  },
  Activity_65502_ActivityTips = {
    Text = "<Title:Visão Geral>\nNo misterioso Lago Negro, onde nuvens de intriga se agitam, a Roda do destino gira repetidamente. Guiadas pela música de Hameln, incontáveis melodias se harmonizam na Roda da sua jornada. Que a ajuda delas o acompanhe até a nota final da sinfonia conclusiva.\n\n<Title:Regras do Evento>\nDurante o evento, faça login por um dia para selecionar e despertar uma das seguintes 12 Rodas limitadas, incluindo: Hino do Soberano, Raridade Preciosa, Em Nome de Rosa, Graça Através da Dor, Nascimento Encoberto, Decreto da Rainha, Tábula das Escrituras, Restituição do corpo deformado, Poder do Devoto, O Último Verso, Nutrição Misericordiosa e Hora da Fortuna."
  },
  Activity_65502_BannerText = {
    Text = "Reivindique uma Roda do destino limitada gratuitamente"
  },
  Activity_65521_ActivityName = {
    Text = "Caixa de suprimentos de investigação"
  },
  Activity_65521_ActivityPlot = {
    Text = "Investigação de suprimentos fornecidos pelo Escritório Administrativo de Misaq. Refinados por Alistair a partir dos destroços do Lago Negro."
  },
  Activity_65949_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65949_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65950_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65950_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65951_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65951_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65952_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65952_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65953_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65953_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65954_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65954_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65955_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65955_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65956_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65956_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65957_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65957_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65958_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65958_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65959_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65959_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65960_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65960_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65961_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65961_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65962_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65962_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65963_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65963_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65964_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65964_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65965_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65965_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65966_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65966_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65967_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65967_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65968_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65968_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65969_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65969_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65970_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65970_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65971_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65971_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65972_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65972_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65973_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65973_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65974_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65974_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65975_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65975_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65976_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65976_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65977_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65977_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65978_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65978_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65979_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65979_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65980_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65980_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65981_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65981_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65982_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65982_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65983_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65983_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65984_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65984_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65985_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65985_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65986_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65986_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65987_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65987_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65988_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65988_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65989_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65989_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65990_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65990_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65991_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65991_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65992_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65992_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65993_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65993_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65994_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65994_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65995_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65995_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65996_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65996_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65997_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65997_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65998_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65998_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_65999_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_65999_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_66000_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_66000_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_66001_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_66001_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_66002_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_66002_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_66003_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_66003_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_66004_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_66004_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_66005_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_66005_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_66006_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_66006_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_66007_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_66007_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_66008_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_66008_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_66009_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_66009_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_66010_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_66010_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_66011_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_66011_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_66012_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_66012_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_66013_ActivityName = {
    Text = "Presentes de mythag"
  },
  Activity_66013_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem reivindicar recompensas diárias de login em \"Presente da Academia\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente com base nos dias acumulados de login do Guardião. As recompensas diárias de login serão atualizadas às 9:00 (GMT+8)."
  },
  Activity_66375_ActivityName = {
    Text = "Decisivo: Sombra primordial"
  },
  Activity_66375_ActivityPlot = {
    Text = "O seu olhar percorre inúmeras dimensões, e o que lhe encontra é uma multidão de sombras prateadas. \nEles são pequenos, frágil. Lutam para lembrar, até a morte"
  },
  Activity_66375_ActivityStageEndContent = {
    Text = "Evento concluído, continue investigando"
  },
  Activity_66375_ActivityTips = {
    Text = "<Title:Batalha Cooperativa: Primordial>\n·A \"Batalha Cooperativa: Primordial\" consiste em 7 níveis não repetíveis que desafiam diretamente a Visão do Primordial. Os primeiros 3 níveis serão abertos no primeiro dia do evento, e então 1 nível será aberto a cada 3 dias.\n·Cada vez que você desafiar com sucesso a correspondente Visão do Primordial, receberá a recompensa correspondente.\n·Cada tipo de Visão do Primordial tem múltiplos clones. Sempre que qualquer Guardião desafiar com sucesso um certo tipo de Visão do Primordial, a \"Contagem de Resíduo do Mundo\" desse tipo diminuirá em 1. Quando todos os clones desse tipo forem derrotados, o nível correspondente será fechado e não poderá ser desafiado novamente.\n·Todos os níveis são afetados pela \"Maré d do Efeito D-regional: Final\", mas cada nível fornecerá diferentes Relíquias de \"Núcleo Puro\", que lhe concederão poderosos bônus. Além disso, cada nível também fornecerá uma Relíquia \"Olho de Gnose\", que concederá a Tawil 120 Aliemus no início da batalha, aumentando todos os efeitos de Dano, Escudos e Cura causados por Tawil em 50%.\n·Todos os níveis devem escolher assistência. Durante todo o evento, cada Guardião que se segue mutuamente pode fornecer assistência apenas uma vez. Devido ao uso da assistência, a recompensa real de Afinidade aumentará em 50% além da recompensa base.\n·Os Guardiões devem completar as Operações de Investigação 2-9 pelo menos para participar deste evento.\n\n<Title:Operação de Investigação: Capítulo Final>\n·O corpo principal de cada Visão do Primordial ainda precisa ser derrotado por você nas Operações de Investigação 9-5 a 9-11. Estes níveis especiais não possuem conquistas, não têm classificações de estrelas, não podem usar a Relíquia \"Olho de Gnose\" ou assistência, e são mais difíceis.\n·Após o término do evento \"Batalha Cooperativa: Primordial\", os níveis subsequentes de \"Operação de Investigação: Capítulo Final\" serão desbloqueados. Quando você derrotar coletivamente todos os clones de várias Visões do Primordial com outros Guardiões, poderá desbloquear os níveis correspondentes nas Operações de Investigação 9-5 a 9-11 antecipadamente."
  },
  Activity_66375_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_66908_ActivityName = {
    Text = "Sopro de fertilidade"
  },
  Activity_66908_ActivityTips = {
    Text = "<Title:Regras da Atividade>\n·Durante o evento \"Sopro Abundante\", os Guardiães podem usar equipes pré-definidas pelo sistema contendo Táias para experimentar níveis designados um número ilimitado de vezes.\n·Ao jogar os níveis do evento, ajustes no Despertar do alinhamento da equipe não podem ser feitos.\n<Title:Recompensas da Atividade>\n·Após completar com sucesso um desafio de nível pela primeira vez, você pode reivindicar recompensas de teste na interface do evento."
  },
  Activity_67077_ActivityName = {
    Text = "Jornada da Lembrança IX"
  },
  Activity_67077_ActivityPlot = {
    Text = "Um pedaço de memória selado e arquivado, uma jornada registrada no passado. Em momentos de lembrança, não se esqueça de oferecer sua reverente Visita."
  },
  Activity_67718_ActivityName = {
    Text = "Antes da Murcha da Primavera·Reedição"
  },
  Activity_67718_ActivityPlot = {
    Text = "A risada das meninas ecoa no jardim antes que o fogo comece.\nPause para esse lindo passado, meu amigo.\nOuça as histórias da primavera não desbotada, suaves narradas."
  },
  Activity_67718_ActivityStageEndContent = {
    Text = "O evento terminou. Atualmente, apenas \"Casa Floral da Colette\" está disponível."
  },
  Activity_67718_ActivityTips = {
    Text = "<Title:Introdução da atividade>\n1, Durante o período da atividade, os Guardiões podem coletar três tipos de \"Poesia\" através das mecânicas de tempo limitado \"Jardim de memórias\",\"Beijo da Musa\" e \"Recompensas de Conquista\". A \"Poesia\" pode ser trocada em \"Casa de Flores da Colette\" para obter recompensas de itens, incluindo a Roda do destino SR limitada da atividade \"Poética de Tempos Passados\",\"Núcleo Imaculado\",\"Núcleo de Lumen\",\"Fragmentos de Pedra Sábia\",\"Cristal de Mimese\", entre outros.\n2, Durante o período da atividade,\"Registro da força-tarefa: Morada da Rosa\" será aberto gratuitamente.\n\n<Title:Período da atividade>\n1, 10 de agosto 9:00 - 7 de setembro 9:00(GMT+8), todos os conteúdos da atividade estão disponíveis.\n2, 7 de setembro 9:00 - 14 de setembro 9:00(GMT+8), apenas \"Casa de Flores da Colette\" e \"Recompensas de Conquista\" são mantidos; os demais conteúdos já foram encerrados e não estão disponíveis.\n\n<Title: Jardim de memórias>\n1,\"Jardim de memórias\" contém 5 fases, com 1 fase desbloqueada automaticamente a cada 2 dias.\n2, Cada desafio consumirá\"Lingfétide\" × 120. Ao concluir o desafio com sucesso, você receberá as moedas da atividade \"poesia melancólica\",\"Poema de Arrependimento\" e \"Poesia Alegre\".\n3, Após concluir uma fase, a função \"Recriar\" dessa fase será desbloqueada. Atenção: ao usar a função \"Recriar\", não é possível obter Taxa de Sincronização.\n4, Você pode usar o Apoio de batalha da associação de ex-alunos e \"Resonância: Elegia do Jardim\" para ajudá-lo a concluir as fases com mais facilidade.\n5, No 2º dia após o desbloqueio da fase, a dificuldade de loucura dessa fase será desbloqueada. Ao concluir a dificuldade de loucura pela primeira vez, você receberá generosas recompensas de moedas da atividade.\n6, Atenção: o desafio na dificuldade de loucura não consome Lingfétide, não pode ser recriado, e após a primeira conclusão, repetir o desafio não gerará mais recompensas de moedas da atividade.\n\n<Title: Bônus de Poesia>\n1, Se o Guardião possuir determinados Corpos Despertos ou Rodas do destino(não é necessário colocá-los em campo), as recompensas das missões de fase de \"Jardim de memórias\" referentes a \"poesia melancólica\",\"Poema de Arrependimento\" e \"Poesia Alegre\" receberão bônus de drop adicionais(incluindo Recriar). Os bônus específicos são os seguintes:\n·Corpo Desperto \"Horla\": Despertar Espiritual 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%\n·Roda do destino SSR \"O Último Verso\": Nível de empilhamento 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%\n·Roda do destino SR \"Poética de Tempos Passados\": Nível de empilhamento 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%\n2, O \"Bônus de Poesia\" de diferentes Corpos Despertos ou Rodas do destino é calculado de forma acumulativa.\n3, Em especial, as recompensas do primeiro desafio concluído na dificuldade de loucura não serão afetadas pelo \"Bônus de Poesia\".\n\n<Title:Resonância: Elegia do Jardim>\n1, Os Guardiões podem obter \"Coração de cinzas\" ao completar conquistas da atividade.\n2, Ao consumir \"Coração de cinzas\" para ativar \"Resonância: Elegia do Jardim\", você poderá obter os seguintes bônus:\n(1) Torna o Guardião mais forte na atividade de jogo \"Jardim de memórias\", tornando os desafios mais fáceis.\n(2) Aumenta as moedas da atividade obtidas ao concluir os desafios de \"Jardim de memórias\".\n(3) Ativa a atividade de jogo \"Beijo da Musa\".\n\n<Title: Beijo da Musa>\n·Após ativar a Resonância \"Tudo cresce\", a cada hora você obtém automaticamente \"poesia melancólica\" × 60, com capacidade máxima de armazenamento de 25 horas.\n·Após ativar a Resonância \"Trocar poema por flor\",\"Beijo da Musa\" pode obter adicionalmente \"Poema de Arrependimento\" × 60 por hora.\n\n<Title: Casa de Flores da Colette>\n1,\"Casa de Flores da Colette\" possui três canteiros de flores, com os seguintes horários de abertura:\n·\"Canteiro de Íris\": abre às 9h do dia 10 de agosto.\n·\"Canteiro de Balão\": abre às 9h do dia 12 de agosto.\n·\"Canteiro de Rosa\": abre às 9h do dia 14 de agosto.\n2, Cada troca consumirá\"poesia melancólica\"/\"Poema de Arrependimento\"/\"Poesia Alegre\" × 750, obtendo aleatoriamente cinco recompensas de itens do canteiro.\n3, As recompensas de itens de cada canteiro são divididas em \"Item Especial\" e \"Item comum\". Ao reiniciar, é possível restaurar a quantidade restante de recompensas de Item Especial ao limite máximo. As regras específicas são:\n(1) Primeiras 2 reinicializações: quando não houver mais \"Item Especial\" restante, o Guardião pode optar por reiniciar, restaurando a quantidade restante de \"Item Especial\" e \"Item comum\" ao limite máximo; ou pode optar por continuar trocando. Quando não houver mais \"Item comum\" restante, será necessário reiniciar para continuar trocando.\n(2) A partir da 3ª reinicialização: só é possível reiniciar quando não houver mais \"Item comum\" restante. A reinicialização restaurará a quantidade restante de \"Item comum\" ao limite máximo, e o \"Item Especial\" não será mais reiniciado.\n4, Após as 9:00(GMT+8) do dia 14 de setembro, as \"Poesias\" restantes não trocadas serão recolhidas na proporção de \"Cupom de ouro rosa\" × 40 por cada troca. Por favor, verifique o e-mail.\n\n<Title: Registro da força-tarefa>\n1, Durante o período da atividade,\"Registro da força-tarefa: Morada da Rosa\" será aberto gratuitamente. A cada 2 dias serão lançados novos eventos. Após concluir \"Registro da força-tarefa: Morada da Rosa\", você poderá obter Núcleo de prata, a Roda do destino SR limitada da atividade \"Poética de Tempos Passados\" e outras recompensas nas Recompensas de Conquista. As Recompensas de Conquista só estão disponíveis durante o período da atividade e não poderão ser concluídas ou recebidas após o término da atividade.\n2, Após o término da atividade, o progresso de investigação de \"Registro da força-tarefa: Morada da Rosa\" será preservado. Se \"Registro da força-tarefa: Morada da Rosa\" não foi desbloqueado durante o período da atividade, ainda será possível desbloqueá-lo após o término da atividade consumindo \"Ponto de partida real\" ×7.\n3, Independentemente de estar ou não no período da atividade, após concluir \"Registro da força-tarefa: Morada da Rosa\", você poderá obter \"Ordem de chave: Poema de oferenda da primavera\"."
  },
  Activity_67718_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_67719_ActivityName = {
    Text = "Evento de Confissão: Atividade de Desbloqueio com Desconto"
  },
  Activity_67721_ActivityName = {
    Text = "Antes da Murcha da Primavera·Reedição"
  },
  Activity_67721_ActivityPlot = {
    Text = "A risada das meninas ecoa no jardim antes que o fogo comece.\nPause para esse lindo passado, meu amigo.\nOuça as histórias da primavera não desbotada, suaves narradas."
  },
  Activity_67721_ActivityStageEndContent = {
    Text = "O evento terminou. Atualmente, apenas \"Casa Floral da Colette\" está disponível."
  },
  Activity_67721_ActivityTips = {
    Text = "<Title:Descrição do evento>\n1. Durante o evento, os Guardiões do Segredo poderão coletar três tipos de \"Poemas\" através das atividades limitadas \"Jardim de memórias\", \"Beijo da Musa\" e \"Recompensas de Logro\". Os \"Poemas\" poderão ser trocados na \"Estufa de Colette\" para obter recompensas, incluindo a Roda do destino SR exclusiva do evento \"Poética de Tempos Passados\", Núcleo Imaculado, Núcleo de Lumen, Fragmentos de Pedra Sábia, Cristal de Mimese, entre outros.\n2. Durante o evento, o \"Registro da força-tarefa: Morada da Rosa\" estará disponível gratuitamente.\n\n<Title:Período do evento>\n1. 25 de agosto 9:00 - 8 de setembro 9:00 (GMT+8), todos os conteúdos do evento estarão disponíveis.\n2. 8 de setembro 9:00 - 15 de setembro 9:00 (GMT+8), apenas \"Estufa de Colette\" e \"Recompensas de Logro\" estarão disponíveis, os demais conteúdos terão terminado e não estarão mais acessíveis.\n\n<Title: Jardim de memórias>\n1. \"Jardim de memórias\" contém 5 estágios, cada um será liberado automaticamente a cada 2 dias.\n2. Cada desafio consome 120 pontos de neuropéptida, e ao vencer você receberá a moeda do evento \"poesia melancólica\", \"Poema de Arrependimento\" e \"Poesia Alegre\".\n3. Após concluir um estágio, será desbloqueada a função \"Recriar\" deste estágio. Atenção: ao usar a função \"Recriar\", não será possível obter taxa de sincronização.\n4. Você poderá usar o apoio da Alumni e a \"Resonância: Elegia do Jardim\" para facilitar a conclusão.\n\n<Title: Bônus de Poemas>\n1. Se o Guardião do Segredo possuir Corpos Despertos ou Rodas do destino específicas (não é necessário equipá-los), poderá obter bônus adicionais na quantidade de \"poesia melancólica\", \"Poema de Arrependimento\" e \"Poesia Alegre\" obtidos nas recompensas das missões dos estágios de \"Jardim de memórias\" (incluindo Recriar). Os bônus específicos são os seguintes:\n Corpo Desperto \"Horla\": Despertar Espiritual 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\n Roda do destino SSR \"O Último Verso\": Nível de empilhamento 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\n Roda do destino SR \"Poética de Tempos Passados\": Nível de empilhamento 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\n2. Os bônus de \"Bônus de Poemas\" de diferentes Corpos Despertos ou Rodas do destino são acumulativos.\n3. Especialmente, as recompensas da primeira conclusão em dificuldade Loucura não são afetadas pelo \"Bônus de Poemas\".\n\n<Title: Resonância: Elegia do Jardim>\n1. Os Guardiões do Segredo poderão obter \"Coração de cinzas\" ao completar logros do evento.\n2. Ao consumir \"Coração de cinzas\", você poderá ativar a \"Resonância: Elegia do Jardim\", obtendo os seguintes bônus:\n(1) Tornará o Guardião do Segredo mais forte na atividade \"Jardim de memórias\", facilitando os desafios.\n(2) Aumentará a quantidade de moedas do evento obtidas após concluir \"Jardim de memórias\".\n(3) Ativará a atividade \"Beijo da Musa\".\n\n<Title: Beijo da Musa>\n Após ativar a resonância \"O Crescimento de Todas as Coisas\", você receberá automaticamente 60 \"poesia melancólica\" por hora, com armazenamento máximo de 25 horas.\n Após ativar a resonância \"Trocar poema por flor\", \"Beijo da Musa\" receberá adicionalmente 60 \"Poema de Arrependimento\" por hora.\n\n<Title: Estufa de Colette>\n1. A \"Estufa de Colette\" possui três jardins, com os seguintes horários de abertura:\n Jardim de íris: Abre às 9h do dia 25 de agosto.\n Jardim de Balloon Flower: Abre às 9h do dia 27 de agosto.\n Jardim de Rosas: Abre às 9h do dia 29 de agosto.\n2. Cada troca consome 750 \"poesia melancólica\"/\"Poema de Arrependimento\"/\"Poesia Alegre\", e aleatoriamente você receberá uma das cinco recompensas dos jardins.\n3. As recompensas dos jardins são divididas em \"Item Especial\" e \"Item comum\". Ao redefinir, a quantidade restante dos \"Item Especial\" será redefinida para o limite máximo. As regras específicas são as seguintes:\n(1) Primeiras 2 redefinições: Quando não houver mais \"Item Especial\" restantes, o Guardião do Segredo poderá escolher redefinir, restaurando a quantidade restante de \"Item Especial\" e \"Item comum\" ao limite máximo; também poderá continuar trocando, e quando não houver mais \"Item comum\", será necessário redefinir para continuar trocando.\n(2) A partir da 3ª redefinição: Somente quando não houver mais \"Item comum\" restantes será possível redefinir, restaurando a quantidade restante de \"Item comum\" ao limite máximo, enquanto os \"Item Especial\" não serão mais redefinidos.\n4. Após as 9:00 (GMT+8) de 15 de setembro, os \"Poemas\" restantes não trocados serão convertidos automaticamente em \"Cupom de ouro rosa*40\" a uma taxa fixa. Por favor, verifique seu e-mail.\n\n<Title: Registro da força-tarefa>\n1. Durante o evento, o \"Registro da força-tarefa: Morada da Rosa\" estará disponível gratuitamente. Novos eventos serão lançados a cada 2 dias. Após concluir \"Registro da força-tarefa: Morada da Rosa\", você poderá obter Núcleo de prata e a Roda do destino SR exclusiva do evento \"Poética de Tempos Passados\" nas recompensas de logro. As recompensas de logro só estarão disponíveis durante o evento, e após seu término não será mais possível completar ou coletar.\n2. Após o término do evento, o progresso de investigação de \"Registro da força-tarefa: Morada da Rosa\" será mantido. Se você não desbloqueou \"Registro da força-tarefa: Morada da Rosa\" durante o evento, ainda poderá desbloqueá-lo após o término consumindo 7 \"Ponto de partida real\".\n3. Independentemente de estar durante o evento ou não, após concluir \"Registro da força-tarefa: Morada da Rosa\" você poderá obter \"Selos-Chave: Manutenção da Primavera\"."
  },
  Activity_67721_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_67723_ActivityName = {
    Text = "Evento de Confissão: Atividade de Desbloqueio com Desconto"
  },
  Activity_67725_ActivityName = {
    Text = "Evento duplo de Afinidade"
  },
  Activity_67726_ActivityName = {
    Text = "Pastor das Almas: Reedição"
  },
  Activity_67726_ActivityPlot = {
    Text = "Ele sofreu por você, suportou suas tribulações.\nAtravés da Carne e sangue que Ele sacrificou, você foi curado;\nAtravés da Vida que Ele deu, você foi perdoado."
  },
  Activity_67726_ActivityStageEndContent = {
    Text = "O evento foi Concluído. Atualmente, apenas \"Local de venda beneficente da igreja\" está disponível."
  },
  Activity_67726_ActivityTips = {
    Text = "<Title:Atividade Introdução>\n1. Durante o evento, os Guardiões podem coletar a moeda do evento \"Cupom de Venda\" através das jogabilidades limitadas \"Caminho do Santuário\", \"Bondade dos Cidadãos\" e \"Recompensa por Conquista\". Os \"Cupons de Venda\" podem ser trocados por itens aleatórios no \"Leilão do Santuário\", incluindo a roda de destino SR exclusiva do evento \"Homem no Espelho\", Núcleo Imaculado, Núcleo Luminoso, etc.\n2. Durante o evento, o \"Registro de Operações: Cor da Sangue\" ficará disponível gratuitamente. Completar as conquistas do evento também permitirá obter o avatar exclusivo do evento \"Em Nome da Chave de Prata: Salvador\"!\n\n<Title:Tempo do Evento>\n1. 24 de março 9:00 - 7 de abril 9:00 (GMT+8), todos os conteúdos do evento estarão disponíveis.\n2. 7 de abril 9:00 - 14 de abril 9:00 (GMT+8), apenas o \"Leilão do Santuário\" e a \"Recompensa por Conquista\" permanecerão, os demais conteúdos estarão encerrados e indisponíveis.\n\n<Title:Caminho do Santuário>\n1. \"Caminho do Santuário\" contém 5 estágios, cada um será liberado automaticamente a cada 2 dias.\n2. Cada tentativa consome 120 pontos de endorfina, e ao ter sucesso na tentativa, você receberá a moeda do evento \"Cupom de Venda\".\n3. Após concluir um estágio, será desbloqueada a função \"Recriação\" desse estágio. Por favor, note: ao usar a função \"Recriação\", não será possível obter taxa de sincronização.\n4. Você pode usar o apoio da \"Associação de Ex-Alunos\" e a \"Ressonância: O Desvio da Alma\" para facilitar sua passagem.\n\n<Title:Resplandor de Bônus>\n1. Sob o efeito do \"Resplandor da Alma\", se o Guardião possuir determinados Despertados ou Rodas de Destino (não é necessário colocá-los em combate), poderá obter um bônus adicional de \"Cupom de Venda\" nas recompensas das missões dos estágios do \"Caminho do Santuário\" (incluindo recriação). Os bônus específicos são os seguintes:\n· Despertado \"Salvador\": Iluminação 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%.\n· Roda de Destino SSR \"Tábua Divina\": Sobreposição 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%.\n· Roda de Destino SR \"Homem no Espelho\": Sobreposição 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%.\n2. Os bônus de \"Resplandor\" de diferentes Despertados ou Rodas de Destino são acumulativos.\n3. Especialmente, as recompensas da primeira vitória no modo frenético não são afetadas pelo \"Resplandor de Bônus\".\n\n<Title:Ressonância: O Desvio da Alma>\n1. Os Guardiões podem obter o \"Coração Arrependido\" completando as conquistas do evento.\n2. Consumindo o \"Coração Arrependido\" para ativar a \"Ressonância: O Desvio da Alma\", você poderá obter os seguintes bônus:\n(1) Tornar o Guardião mais forte nas jogabilidades do evento \"Caminho do Santuário\" e \"Registro de Operações: Cor da Sangue\", facilitando os desafios.\n(2) Aumentar a taxa de sincronização obtida após concluir os desafios do \"Caminho do Santuário\".\n(3) Ativar a jogabilidade do evento \"Bondade dos Cidadãos\".\n\n<Title:Bondade dos Cidadãos>\n1. Após ativar a ressonância \"Um Caminho Fácil\", você receberá automaticamente 60 \"Cupons de Venda\" por hora, com um máximo de armazenamento de 25 horas.\n2. Após ativar a ressonância \"Penitência, Penitência\", você receberá automaticamente 1800 \"Vouchers de Rosa\" por hora.\n\n<Title:Leilão do Santuário>\n1. Existem três lojas no \"Leilão do Santuário\", com os seguintes horários de abertura:\n· Loja da Sra. Gray: abre às 9h do dia 24 de março.\n· Leilão Mágico do Grande João: abre às 9h do dia 27 de março.\n· Leilão Especial do Smith: abre às 9h do dia 30 de março.\n2. Cada troca consome 750 \"Cupons de Venda\", aleatoriamente obtendo recompensas de cinco itens dentre os disponíveis na loja.\n3. Os itens recompensados em cada loja são divididos em duas categorias: \"Itens Especiais\" e \"Itens Normais\". Ao reiniciar, a quantidade restante dos Itens Especiais será redefinida para o limite máximo. As regras específicas são as seguintes:\n(1) Primeiras 2 reinicializações: quando não houver mais Itens Especiais disponíveis, o Guardião poderá escolher reiniciar, o que redefinirá a quantidade restante dos Itens Especiais e Normais para o limite máximo; ou pode continuar trocando, e quando também não houver mais Itens Normais disponíveis, será necessário reiniciar para continuar trocando.\n(2) A partir da 3ª reinicialização: só será possível reiniciar quando não houver mais Itens Normais disponíveis, e a reinicialização redefinirá a quantidade restante dos Itens Normais para o limite máximo, enquanto os Itens Especiais não serão mais reiniciados.\n4. Após as 9h (GMT+8) do dia 14 de abril, os \"Cupons de Venda\" restantes não trocados serão convertidos em \"Vouchers de Rosa*40\" na proporção de 1 por cada, por favor, lembre-se de verificar seu e-mail.\n\n<Title:Registro de Operações>\n1. Durante o evento, o \"Registro de Operações: Cor da Sangue\" estará disponível gratuitamente.\n2. Após o término do evento, o progresso de investigação do \"Registro de Operações: Cor da Sangue\" será mantido. Se você não desbloqueou o \"Registro de Operações: Cor da Sangue\" durante o evento, ainda poderá desbloqueá-lo após o término consumindo 7 \"Pontos de Realidade\".\n3. Independentemente de estar ou não durante o evento, ao concluir o \"Registro de Operações: Cor da Sangue\", você poderá obter o \"Sinal: Milagre Divino\".\n\n<Title:Compensação de Reedição>\n1. Os Guardiões que já desbloquearam o \"Registro de Operações: Cor da Sangue\" anteriormente receberão uma compensação de 700 \"Cupons de Venda\" ao desbloqueá-lo novamente durante esta reedição.\n2. Os Guardiões que já obtiveram anteriormente o avatar exclusivo do evento \"Em Nome da Chave de Prata: Salvador\", ao obtê-lo novamente, ele será automaticamente convertido em 1 \"Convite do Invisível\".\n3. Os Guardiões que já obtiveram anteriormente o material de ativação da ressonância \"Coração Arrependido\", ao obter 1 \"Coração Arrependido\" extra adicional, ele será automaticamente convertido em \"Vouchers de Rosa*5000\".\n"
  },
  Activity_67726_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_67727_ActivityName = {
    Text = "Onda do Desejo·Reedição"
  },
  Activity_67727_ActivityPlot = {
    Text = "Sonhos são a revelação de desejos submersos. Aqueles que neles permanecem serão enredados pelas marés de desejo, tornando-se apóstolos da luxúria—a menos que..."
  },
  Activity_67727_ActivityStageEndContent = {
    Text = "O evento foi Concluído. Atualmente, apenas \"Desejo Corrupto\" está disponível."
  },
  Activity_67727_ActivityTips = {
    Text = "<Title:Apresentação do evento>\n1. Durante o evento, o guardião poderá coletar a moeda do evento \"Semente Mãe Fértil\" através da jogabilidade limitada \"Desejo caótico\" e recompensas de conquistas. As \"Sementes Mães Férteis\" poderão ser trocadas por recompensas em \"Reprodução de Desejos\", incluindo a Roda do destino SR exclusiva do evento \"Beijo de Despedida\", Núcleo de Lumen, Núcleo Imaculado, Fragmentos de Pedra Sábia e Cristal de Mimese, entre outros.\n2. Durante o evento, as condições para participar de \"Frenesi de Reprodução\" foram relaxadas para a conclusão da missão 2-9 (Normal) de \"Operação de investigação\", e não será necessário cumprir os requisitos de taxa de sintonia do Corpo Desperto para desbloquear o evento \"Frenesi de Reprodução\". Além disso, a quantidade de \"Ponto de partida real\" necessária será reduzida para apenas 1!\n3. A chegada de uma força misteriosa parece ajudar você a estabelecer uma relação mais profunda com os Corpos Despertos. Durante o evento, a taxa de sintonia obtida por todos os meios será dobrada!\n\n<Title:Desejo caótico>\n1. \"Desejo caótico\" contém 10 estágios de materiais que não exigem exploração, apenas batalhas, sendo aberto 1 estágio por dia.\n2. Nestes estágios de materiais, você Despertará diretamente todos os Corpos Despertos e receberá Relíquias predefinidas. Além disso, após o 6º turno, você receberá ajuda de Thais uma vez.\n3. Cada desafio consome 120 pontos de neuropeptídeo, e ao vencer, você receberá materiais de desenvolvimento e moedas do evento.\n4. Após concluir o estágio, será desbloqueada a função \"Recriar\" deste estágio. Por favor, note: ao usar a função \"Recriar\", não será possível obter taxa de sintonia.\n5. Você poderá usar o auxílio da Associação de Ex-Alunos para ajudá-lo a passar os estágios mais facilmente.\n\n<Title:Prêmio de Ganância>\n1. Se o guardião possuir Corpos Despertos ou Rodas do destino específicas (não é necessário equipá-los), poderá obter um bônus adicional na quantidade de \"Sementes Mães Férteis\" recebidas nas recompensas das missões em \"Desejo caótico\" (incluindo recriação). Os bônus específicos são os seguintes:\n· Corpo Desperto \"Thais\": Despertar Espiritual 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%\n· Roda do destino SSR \"Nutrição Misericordiosa\": Nível de empilhamento 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%\n· Roda do destino SR \"Beijo de Despedida\": Nível de empilhamento 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%\n2. Os bônus de \"Prêmio de Ganância\" de diferentes Corpos Despertos ou Rodas do destino são acumulativos.\n3. Especialmente, as recompensas da primeira conclusão em dificuldade Loucura não serão afetadas pelos bônus acima.\n\n<Title:Reprodução de Desejos>\n1. Cada \"Troca de Sementes\" consome 1000 \"Sementes Mães Férteis\" e aleatoriamente concede cinco itens dentre as recompensas disponíveis em \"Reprodução de Desejos\".\n3. As recompensas em \"Reprodução de Desejos\" são divididas em dois tipos: \"Item Especial\" e \"Itens Comuns\". Ao reiniciar, é possível redefinir a quantidade restante de recompensas \"Item Especial\" para o limite máximo. As regras específicas são as seguintes:\n(1) Primeiros 4 reinícios: quando não houver mais quantidade restante de \"Item Especial\", o guardião poderá escolher reiniciar, o que redefinirá a quantidade restante de \"Item Especial\" e \"Itens Comuns\" para o limite máximo; ou poderá continuar trocando, e quando também não houver mais quantidade restante de \"Itens Comuns\", será necessário reiniciar para continuar trocando.\n(2) A partir do 5º reinício: só será possível reiniciar quando não houver mais quantidade restante de \"Itens Comuns\". O reinício redefinirá a quantidade restante de \"Itens Comuns\" para o limite máximo, mas os \"Item Especial\" não serão mais redefinidos.\n\n<Title:Tempo do Evento>\n1. 16 de dezembro 9:00 - 30 de dezembro 9:00 (GMT+8), todos os conteúdos mencionados na apresentação do evento estarão disponíveis.\n2. 30 de dezembro 9:00 - 6 de janeiro 9:00 (GMT+8), apenas \"Reprodução de Desejos\" e \"Recompensas de Conquistas\" permanecerão disponíveis, os demais conteúdos serão encerrados e não poderão mais ser acessados.\n3. Após 6 de janeiro 9:00 (GMT+8), as \"Sementes Mães Férteis\" restantes que não forem trocadas serão recicladas na proporção de \"Cupom de ouro rosa*40\" por cada unidade, por favor, verifique seu e-mail."
  },
  Activity_67727_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_67728_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_67729_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_67731_ActivityName = {
    Text = "Banquete Ardente: Recorrência"
  },
  Activity_67731_ActivityPlot = {
    Text = "Isalrauh, a cidade no lago, supostamente é a terra natal de wanda.\nDesta vez você passará pela porta do sonho e chegará àquela antiga torre repleta de línguas de sino"
  },
  Activity_67731_ActivityStageEndContent = {
    Text = "O evento terminou, atualmente só é possível participar do\"Baú do tesouro de wanda\""
  },
  Activity_67731_ActivityTips = {
    Text = "<Title:Introdução ao Evento>\n1 Durante o período do evento, os guardiões podem coletar moedas do evento \"Tíbias Primitivas\", \"Amónito de folhas arredondadas\", \"Ruínas Espirais\" através das mecânicas limitadas \"Festa Ardente\" e \"Recompensa de Conquista\". As moedas do evento podem ser usadas para comprar produtos na \"A Caixa de Tesouros Exóticos de Wanda\", incluindo a roda do destino SR exclusiva do evento \"O olhar de Isarau\", Núcleo de Lumen, Núcleo Imaculado, entre outros. \n2 Durante o evento, a \"Navegação na consciência: Festa Ardente\" será desbloqueada gratuitamente por tempo limitado, e completar as conquistas do evento também permitirá que você obtenha o avatar exclusivo do evento \"Por nome da Chave de Prata: Wanda\"!\n\n<Title:Tempo do Evento>\n1 De 23 de setembro às 9:00 até 7 de outubro às 9:00 (GMT+8), todas as mecânicas do evento estarão disponíveis. \n2 De 7 de outubro às 9:00 até 14 de outubro às 9:00 (GMT+8), somente será possível participar da \"A Caixa de Tesouros Exóticos de Wanda\" e das recompensas de conquista. \n\n<Title:Cidade no Lago>\n1 A \"Cidade no Lago\" possui 7 fases, sendo que uma fase será desbloqueada automaticamente a cada dia. \n2 Cada desafio consumirá \"Lingfétide\" × 120, e o sucesso no desafio garantirá moedas do evento. \n3 Após completar a fase, a função \"Reproduzir\" dessa fase será desbloqueada. Atenção: ao usar a função \"Reproduzir\", não será possível obter a Taxa de Sincronização. \n4 Você pode usar a ajuda da associação de ex-alunos e \"Ressonância: Ordem secreta\" para facilitar sua passagem pelas fases. \n\n<Title:Bônus Exóticos>\n1 Guardiões que possuírem corpos despertos ou rodas do destino específicas (não é necessário que estejam em uso) poderão obter um bônus adicional nas moedas do evento na recompensa da tarefa da fase \"Cidade no Lago\", conforme os seguintes bônus: \n· Corpo Desperto \"Wanda\": Despertar 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%. \n· Roda do destino SSR \"Decreto da Rainha\": Posição sobreposta 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%. \n· Roda do destino SR \"O olhar de Isarau\": Posição sobreposta 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%. \n2 Os \"Bônus Exóticos\" de diferentes corpos despertos ou rodas do destino serão somados. \n3 Especialmente, a recompensa do desafio de dificuldade de loucura não será afetada pelos \"Bônus Exóticos\". \n\n<Title:Ressonância: Ordem Secreta>\n1 Os guardiões podem obter \"Coração do prazer\" ao completar as conquistas do evento. \n2 Consumindo \"Coração do prazer\", ativar \"Ressonância: Ordem secreta\" permitirá que os guardiões se tornem mais fortes na \"Cidade no Lago\", facilitando os desafios; também permitirá que os guardiões obtenham moedas do evento adicionais ao completar as fases. \n\n<Title:Navegação na Consciência>\n1 Durante o evento, a \"Festa Ardente\" pode ser desbloqueada gratuitamente. \n2 Após o término do evento, o progresso da investigação da \"Festa Ardente\" será mantido, e completar eventos de investigação não finalizados durante o período do evento também permitirá que você receba recompensas de investigação correspondentes ao período do evento. Se a \"Festa Ardente\" não foi desbloqueada durante o evento, ainda será possível desbloqueá-la após o término do evento consumindo \"Ponto de partida real\" × 3. \n3 Independentemente de estar ou não durante o evento, ao completar a \"Festa Ardente\", você pode obter \"Ordem de chave: Festim Podre\". \n\n<Title:Compensação de Reedição>\n1 Guardiões que já desbloquearam \"Navegação na consciência: Festa Ardente\" receberão uma compensação de \"Tíbias Primitivas\" × 300 durante o período da reedição ao desbloqueá-la novamente. \n2 Guardiões que já obtiveram o avatar exclusivo do evento \"Por nome da Chave de Prata: Wanda\" receberão \"Tíbias Primitivas\" × 2000 ao obtê-lo novamente. \n3 Guardiões que já obtiveram o material de ativação da ressonância \"Coração do prazer\", cada \"Coração do prazer\" adicional obtido será automaticamente convertido em \"Cupom de ouro rosa\" × 5000. \n"
  },
  Activity_67731_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_67732_ActivityName = {
    Text = "Manual do Detetive·Recuperação"
  },
  Activity_67732_ActivityPlot = {
    Text = "Um manual comum.\nRegistra as experiências de um detetive ao longo dos anos.\nEsperamos que inspire jovens aspirantes a detetive"
  },
  Activity_67732_ActivityStageEndContent = {
    Text = "O evento terminou. Atualmente, apenas \"Clube da Boa Sorte\" está disponível."
  },
  Activity_67732_ActivityTips = {
    Text = "<Title:Introdução do Evento>\n1. Durante o evento, os Guardiões do Segredo podem coletar a moeda do evento \"Ficha decisiva\" através das jogabilidades limitadas \"Lenda da noite lunar\" e \"Recompensa de conquista\". As \"Fichas decisivas\" podem ser trocadas por recompensas generosas no \"Clube da Sorte\", incluindo a roda do destino SR exclusiva do evento \"Roulette do Destino\", \"Núcleo Imaculado\", \"Núcleo de Lumen\", \"Fragmentos de Pedra Sábia\", \"Cristal de Mimese\", entre outros.\n2. Durante o evento, completar as missões da \"Recompensa de conquista\" pode resultar em um avatar exclusivo do evento \"Por nome da Chave de Prata: Leik\", a roda do destino SR \"Roulette do Destino\", núcleos de prata e uma grande quantidade de moeda do evento \"Ficha decisiva\".\n3. Durante o evento, \"Registro da força-tarefa: Boa caça!\" estará aberto gratuitamente.\n\n<Title:Tempo do Evento>\n1. De 12 de agosto às 9:00 até 26 de agosto às 9:00 (GMT+8), todo o conteúdo do evento estará disponível para participação.\n2. De 26 de agosto às 9:00 até 2 de setembro às 9:00 (GMT+8), apenas o \"Clube da Sorte\" e a \"Recompensa de conquista\" estarão disponíveis, todo o restante estará encerrado e não poderá ser participado.\n\n<Title:Lenda da Noite Lunar>\n1. A \"Lenda da noite lunar\" contém 9 fases, uma nova fase será aberta automaticamente a cada dia.\n2. Cada desafio consumirá \"Lingfétide\" × 120. Ao desafiar diferentes fases, além de obter diferentes materiais, também receberá a moeda do evento \"Ficha decisiva\".\n3. As fases do evento consistem em combate direto, e podem ser reproduzidas após a conclusão! Cada \"Reprodução\" consumirá \"Lingfétide\" × 120.\n4. Atenção: ao usar a função \"Reproduzir\", não será possível obter a Taxa de Sincronização.\n\n<Title:Aumento de Fichas>\n1. Os Guardiões do Segredo que possuírem corpos despertos ou rodas do destino específicas (não é necessário que estejam em batalha) poderão obter um aumento extra nas \"Fichas decisivas\" das recompensas das fases da \"Lenda da noite lunar\" (incluindo reproduções), com os seguintes aumentos: \n· Corpo Desperto \"Leik\": Despertar 0/1/2/3 ou superior, aumento de 20%/30%/40%/50%\n· Roda do destino SSR \"Hora da Fortuna\": Posição sobreposta 0/1/2/3 ou superior, aumento de 20%/30%/40%/50%\n· Roda do destino SR \"Roulette do Destino\": Posição sobreposta 0/1/2/3 ou superior, aumento de 20%/30%/40%/50%\n2. O \"aumento de fichas\" de diferentes corpos despertos ou rodas do destino será contabilizado de forma acumulativa.\n3. Especialmente, as recompensas do desafio de primeira passagem na dificuldade de loucura não serão afetadas pelo \"aumento de fichas\".\n\n<Title:Clube da Sorte>\n1. O \"Clube da Sorte\" estará aberto apenas de 12 de agosto às 9:00 até 2 de setembro às 9:00 (GMT+8).\n2. Após 2 de setembro às 9:00 (GMT+8), as \"Fichas decisivas\" não trocadas serão recuperadas a uma taxa de 40 \"Cupom de ouro rosa\" por ficha. Os Guardiões do Segredo devem verificar seus e-mails.\n\n<Title:Registro da Força-Tarefa>\n1. Em \"Registro da força-tarefa: Boa caça!\", os Guardiões do Segredo usarão uma formação especial que inclui o personagem predefinido \"Leik\" para desafios.\n2. Completar \"Registro da força-tarefa: Boa caça!\" concederá uma nova Ordem de chave \"Ordem de chave: Um tiro\"."
  },
  Activity_67732_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_67733_ActivityName = {
    Text = "Sacrifício do Abismo: Repetição"
  },
  Activity_67733_ActivityPlot = {
    Text = "No reflexo do mar profundo, o sonho do rei se dissipa, o reino dos deuses apodrece.\nEla vem dos sonhos antigos, entra nas ruínas do futuro.\nEla pergunta ao abismo, o abismo permanece em silêncio.\nEla oferece ao abismo, e a resposta é ela mesma"
  },
  Activity_67733_ActivityStageEndContent = {
    Text = "Evento encerrado, apenas disponível para \"Resposta do Abismo\""
  },
  Activity_67733_ActivityTips = {
    Text = "<Title:Logro de atividade>\n1. Durante o evento, os Guardiões do Segredo poderão coletar moedas de evento através das jogabilidades limitadas \"Nascimento do Reino Divino\", \"Santuario do Rei Deus\" e \"Recompensas por Conquistas\". As moedas do evento poderão ser usadas em \"Resposta do Abismo\" para oferecer sacrifícios e obter recompensas em itens, incluindo a Roda do destino SR exclusiva do evento \"Chamado do Mar Profundo\", Pedra Filosofal, Núcleo Imaculado, Núcleo de Lumen, entre outros.\n2. Durante o evento, o \"Visão de Sonhos Estranhos: Profanação\" será aberto gratuitamente. Ao completar conquistas do evento você ainda poderá obter o avatar exclusivo \"Em Nome da Chave de prata: Miryam\"!\n\n<Title:Período do Evento>\n1. 28 de julho 9:00 - 18 de agosto 9:00 (GMT+8), todos os conteúdos do evento estarão disponíveis.\n2. 18 de agosto 9:00 - 25 de agosto 9:00 (GMT+8), apenas \"Resposta do Abismo\" e \"Recompensas por Conquistas\" permanecerão disponíveis. Os demais conteúdos estarão encerrados e indisponíveis.\n\n<Title:Nascimento do Reino Divino>\n1. \"Nascimento do Reino Divino\" contém 5 estágios, cada um será liberado automaticamente a cada 2 dias.\n2. Cada desafio consome 120 pontos de neuropéptida, e ao vencer você receberá moedas do evento.\n3. Após concluir um estágio, será desbloqueada a função \"Recriar\" deste estágio. Por favor, note: ao usar a função \"Recriar\", não será possível obter taxa de sincronização.\n4. Você poderá usar o apoio da Alumni e a \"Resonância: Festa do Mar\" para facilitar a conclusão.\n\n<Title:Benefício de Sacrifícios>\n1. Quando o Guardião do Segredo possuir Corpos Despertos ou Rodas do destino específicas (não é necessário equipá-los), poderá obter bônus adicionais na quantidade de \"Lágrimas do Sacrificador\", \"Sangue do Sacrificador\" e \"Médula do Sacerdote\" obtidos nas recompensas das missões dos estágios de \"Nascimento do Reino Divino\" (incluindo a função Recriar). Os bônus específicos são os seguintes:\nCorpo Desperto \"Miryam\": Despertar Espiritual 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\nRoda do destino SSR \"Poder do Devoto\": Nível de empilhamento 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\nRoda do destino SR \"Chamado do Mar Profundo\": Nível de empilhamento 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\n2. Os bônus de sacrifícios de diferentes Corpos Despertos ou Rodas do destino são acumulativos.\n3. Especialmente, as recompensas da primeira conclusão em dificuldade Loucura não são afetadas pelos \"Benefícios de Sacrifícios\".\n\n<Title:Resonância: Festa do Mar>\n1. Os Guardiões do Segredo poderão obter \"Coração de piedade\" ao completar conquistas do evento.\n2. Ao consumir \"Coração de piedade\" e ativar a \"Resonância: Festa do Mar\", você poderá obter os seguintes benefícios:\n(1) Tornar os Guardiões do Segredo mais poderosos na jogabilidade do evento \"Nascimento do Reino Divino\", facilitando os desafios.\n(2) Aumentar a quantidade de moedas do evento obtidas após concluir os desafios de \"Nascimento do Reino Divino\".\n(3) Ativar a jogabilidade do evento \"Santuario do Rei Deus\".\n\n<Title:Benefício de Sacrifícios>\nApós ativar a resonância \"Prova de sacrifício\", você receberá automaticamente 60 \"Lágrimas do Sacrificador\" por hora, acumulando no máximo 25 horas.\n\n<Title:Resposta do Abismo>\n1. \"Resposta do Abismo\" possui três altares, os horários de abertura são os seguintes:\n\"Altar de Lágrimas Cristalinas\": 28 de julho às 9h ~ 25 de agosto às 9h.\n\"Altar de Sangue Carmesim\": 30 de julho às 9h ~ 25 de agosto às 9h.\n\"Altar da Medula Espiritual\": 1 de agosto às 9h ~ 25 de agosto às 9h.\n2. Cada oferenda consome 1000 unidades de \"Lágrimas do Sacrificador\"/\"Sangue do Sacrificador\"/\"Médula do Sacerdote\", e aleatoriamente você receberá uma das cinco recompensas dos altares.\n3. As recompensas dos altares são divididas em \"Item Especial\" e \"Item comum\". Ao redefinir, a quantidade restante dos itens selecionados será redefinida ao limite máximo. As regras específicas são as seguintes:\n(1) Primeiras 3 redefinições: quando não houver mais \"Item Especial\" disponíveis, o Guardião do Segredo poderá escolher redefinir, após o que a quantidade restante de \"Item Especial\" e \"Item comum\" será redefinida ao limite máximo; também poderá continuar fazendo oferendas, e quando os \"Item comum\" também se esgotarem, será necessário redefinir para continuar fazendo oferendas.\n(2) A partir da 4ª redefinição: somente quando os \"Item comum\" estiverem esgotados será possível redefinir, e após a redefinição a quantidade restante dos \"Item comum\" será redefinida ao limite máximo, enquanto os \"Item Especial\" não serão mais redefinidos.\n\n<Title:Visão de Sonhos Estranhos>\n1. Durante o evento, o \"Visão de Sonhos Estranhos: Profanação\" estará aberto gratuitamente.\n2. Após o término do evento, o progresso de investigação do \"Visão de Sonhos Estranhos: Profanação\" será mantido. Se você não desbloqueou o \"Visão de Sonhos Estranhos: Profanação\" durante o evento, ainda poderá desbloqueá-lo após o término consumindo 7 \"Ponto de partida real\".\n3. Independentemente de estar durante o evento ou não, ao concluir o \"Visão de Sonhos Estranhos: Profanação\" você poderá obter \"Chave: Festa do Mar\".\n\n<Title:Compensação de Reedição>\n1. Os Guardiões do Segredo que já desbloquearam o \"Visão de Sonhos Estranhos: Profanação\" anteriormente receberão uma compensação de 700 \"Lágrimas do Sacrificador\" ao desbloqueá-lo novamente durante esta reedição do evento.\n2. Os Guardiões do Segredo que já obtiveram anteriormente o avatar exclusivo do evento \"Em Nome da Chave de prata: Miryam\" terão recompensas duplicadas convertidas automaticamente em 1 \"Convite do Incorpóreo\".\n3. Os Guardiões do Segredo que já obtiveram anteriormente o material de ativação \"Coração de piedade\" terão cada unidade adicional obtida convertida automaticamente em 5000 \"Cupom de ouro rosa\"."
  },
  Activity_67733_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_67734_ActivityName = {
    Text = "Sinfonia Intangível·Reprodução"
  },
  Activity_67734_ActivityPlot = {
    Text = "A sinfonia é uma arte de tecer, onde as trajetórias dos instrumentos se entrelaçam.\nEm sua teia, cada nota tem seu papel.\nOuça, uma sinfonia magnífica está prestes a começar"
  },
  Activity_67734_ActivityStageEndContent = {
    Text = "Evento encerrado, apenas disponível para \"Palácio do Sono\""
  },
  Activity_67734_ActivityTips = {
    Text = "<Title:Introdução do Evento>\n1. Durante o evento, os Guardiões do Segredo podem coletar a moeda do evento \"Canto heroico\" através das mecânicas limitadas \"Som tonante\" e \"Recompensa de conquista\". \"Canto heroico\" pode ser trocado por recompensas valiosas no \"Palácio do Sono\", incluindo a roda SR limitada do evento \"Apresentação que Nunca Para\", \"Núcleo Imaculado\", \"Núcleo de Lumen\", \"Fragmentos de Pedra Sábia\", \"Cristal de Mimese\", entre outros.\n2. Durante o evento, completar as missões da \"Recompensa de conquista\" pode resultar em um avatar limitado do evento \"Por nome da Chave de Prata: Hameln\", a roda SR limitada do evento \"Apresentação que Nunca Para\", núcleos de prata e uma grande quantidade da moeda do evento \"Canto heroico\".\n\n<Title: Tempo do Evento>\n1. De 9 de setembro às 9:00 até 23 de setembro às 9:00 (GMT+8), todos os conteúdos do evento estarão disponíveis para participação.\n2. De 23 de setembro às 9:00 até 30 de setembro às 9:00 (GMT+8), apenas o \"Palácio do Sono\" e \"Recompensa de conquista\" estarão disponíveis, todos os outros conteúdos terão terminado e não poderão ser participados.\n\n<Title: Som Tonante>\n1. \"Som tonante\" contém 9 fases, que são liberadas automaticamente uma por dia.\n2. Cada desafio consumirá \"Lingfétide\" × 120. Ao desafiar diferentes fases, além de obter diferentes materiais, também receberá a moeda do evento \"Canto heroico\".\n3. As fases deste evento são de combate direto, e podem ser reproduzidas após a conclusão! Cada \"Reprodução\" consome \"Lingfétide\" × 120.\n4. Atenção: ao usar a função \"Reprodução\", a taxa de sincronização não será obtida.\n\n<Title: Bônus do Canto>\n1. Os Guardiões do Segredo que possuírem corpos despertos ou rodas específicas (não é necessário que estejam em campo) podem obter um bônus extra na recompensa da moeda \"Canto heroico\" nas missões da fase \"Som tonante\" (incluindo reprodução), os bônus específicos são os seguintes:\n· Corpo Desperto \"Hameln\": Despertar 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%\n· Roda SSR \"Réquiem Eterno\": Posição sobreposta 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%\n· Roda SR \"Apresentação que Nunca Para\": Posição sobreposta 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%\n2. Os \"Bônus do Canto\" de diferentes corpos despertos ou rodas são acumulativos.\n3. Especialmente, a recompensa do primeiro desafio na dificuldade de loucura não será afetada pelo \"Bônus do Canto\".\n\n<Title: Palácio do Sono>\n1. O \"Palácio do Sono\" estará aberto apenas de 9 de setembro às 9:00 até 30 de setembro às 9:00 (GMT+8).\n2. Após 30 de setembro às 9:00 (GMT+8), os \"Cantos heroicos\" restantes não trocados serão recuperados na proporção de 40 \"Cupons de ouro rosa\" por cada unidade, por favor, os Guardiões do Segredo devem verificar seus e-mails."
  },
  Activity_67734_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_67735_ActivityName = {
    Text = "Onda do Desejo·Reedição"
  },
  Activity_67735_ActivityPlot = {
    Text = "Sonhos são a revelação de desejos submersos. Aqueles que neles permanecem serão enredados pelas marés de desejo, tornando-se apóstolos da luxúria—a menos que..."
  },
  Activity_67735_ActivityStageEndContent = {
    Text = "O evento foi Concluído. Atualmente, apenas \"Desejo Corrupto\" está disponível."
  },
  Activity_67735_ActivityTips = {
    Text = "<Title:Apresentação do evento>\n1. Durante o evento, o guardião poderá coletar a moeda do evento \"Núcleo de Abundância\" através da jogabilidade limitada \"Desejo caótico\" e recompensas de conquistas. Os \"Núcleos de Abundância\" podem ser trocados em \"Desejo Corrupto\" por recompensas, incluindo a roda de destino SR exclusiva do evento \"Beijo de Despedida\", Núcleo de Lumen, Núcleo Imaculado, Fragmentos de Pedra Sábia, Cristal de Mimese e outros itens.\n2. Durante o evento, as condições para participar de \"Frenesi de reprodução\" foram relaxadas para a conclusão da Trama principal: 1-2: Normal, e não será necessário cumprir os requisitos de afinidade do Corpo Desperto para desbloquear o evento \"Frenesi de reprodução\". Além disso, a quantidade necessária de \"Ponto de partida real\" foi reduzida para apenas 1!\n3. A chegada de uma força misteriosa parece ajudar você a estabelecer uma relação mais profunda com os Corpos Despertos. Durante o evento, a afinidade obtida por todos os meios será dobrada!\n\n<Title:Desejo caótico>\n1. \"Desejo caótico\" contém 10 estágios de materiais que não exigem exploração, apenas batalhas diretas, com 1 estágio aberto por dia.\n2. Nestes estágios de materiais, todos os Corpos Despertos serão ativados automaticamente e receberão Relíquias pré-definidas. Além disso, após o 6º turno, você receberá uma ajuda de Thais.\n3. Cada desafio consome 120 pontos de neuropeptídeo, e ao vencer, você receberá materiais e moedas do evento.\n4. Após concluir o estágio, será desbloqueada a função \"Reproduzir\" deste estágio. Por favor, note: ao usar a função \"Reproduzir\", não será possível obter afinidade.\n5. Você pode usar o auxílio de suporte para ajudá-lo a passar os estágios com mais facilidade.\n\n<Title:Bônus de ganância>\n1. Se o guardião possuir Corpos Despertos ou rodas de destino específicas (não é necessário equipá-los), ele receberá um bônus adicional na quantidade de \"Núcleos de Abundância\" obtidos nas recompensas das missões dos estágios de \"Desejo caótico\" (incluindo reprodução). Os bônus específicos são os seguintes:\nCorpo Desperto \"Thais\": Despertar Espiritual 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\nRoda de destino SSR \"Nutrição Misericordiosa\": Nível de empilhamento 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\nRoda de destino SR \"Beijo de Despedida\": Nível de empilhamento 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\n2. Os bônus de \"Bônus de Ganância\" de diferentes Corpos Despertos ou rodas de destino são acumulativos.\n3. Especialmente, as recompensas da primeira conclusão em dificuldade de Loucura não serão afetadas pelos bônus acima.\n\n<Title:Desejo Corrupto>\n1. Cada \"Intercâmbio de Núcleos de Semente\" consumirá 750 \"Núcleos de Abundância\" e aleatoriamente concederá cinco itens dentre as recompensas de \"Desejo Corrupto\".\n3. As recompensas de itens em \"Desejo Corrupto\" são divididas em dois tipos: \"Item Especial\" e \"Item comum\". Ao reiniciar, é possível redefinir a quantidade restante de recompensas de itens especiais ao seu limite máximo. As regras específicas são as seguintes:\n(1) Primeiras 4 reinicializações: quando não houver mais quantidade restante de \"Item Especial\", o guardião poderá escolher reiniciar, o que redefinirá a quantidade restante de \"Item Especial\" e \"Item comum\" ao seu limite máximo; ou poderá continuar trocando, e quando também não houver mais quantidade restante de \"Item comum\", será necessário reiniciar para continuar trocando.\n(2) A partir da 5ª reinicialização e posteriores: só será possível reiniciar quando não houver mais quantidade restante de \"Item comum\". Ao reiniciar, a quantidade restante de \"Item comum\" será redefinida ao seu limite máximo, mas os \"Item Especial\" não serão mais redefinidos.\n\n<Title:Tempo do evento>\n1. 15 de dezembro 9:00 - 29 de dezembro 9:00 (GMT+8), todos os conteúdos descritos na apresentação do evento estarão disponíveis.\n2. 29 de dezembro 9:00 - 5 de janeiro 9:00 (GMT+8), apenas \"Desejo Corrupto\" e \"Recompensas de Conquistas\" estarão disponíveis, os demais conteúdos terão terminado e não poderão mais ser acessados.\n3. Após 5 de janeiro 9:00 (GMT+8), os \"Núcleos de Abundância\" restantes que não forem trocados serão reciclados na proporção de \"Cupom de ouro rosa *40\" por troca; por favor, verifique seu e-mail."
  },
  Activity_67735_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_67736_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_67737_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_67738_ActivityName = {
    Text = "Evento duplo de Afinidade"
  },
  Activity_67739_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_67741_ActivityName = {
    Text = "A magia da história · Recriação"
  },
  Activity_67741_ActivityPlot = {
    Text = "As tarefas atribuídas por Boneca nunca são simples. \nMesmo com várias lembranças para todos se \"divertirem\", como os guardiões poderiam não ficar assustados ao levar um grupo de despertadores pela primeira vez? \nMas, não se esqueça de \"divertir-se\""
  },
  Activity_67741_ActivityStageEndContent = {
    Text = "O evento terminou, atualmente só é possível participar da\"Loja de script mágico\""
  },
  Activity_67741_ActivityTips = {
    Text = "<Title:Apresentação da Atividade>\n1. A atividade de jogabilidade \"A Magia da História\" será temporariamente reaberta, e os guardiões poderão obter novamente a Roda do destino limitada da atividade \"Mágica 35mm\" e o avatar limitado \"Em Nome da Chave de Prata: Lily\" por meio da \"Loja de roteiros mágicos\" e das \"Recompensas de Conquistas\"!\n2. Durante a atividade, o \"Registro Especial: A Magia da História\" será desbloqueado gratuitamente por tempo limitado.\n\n<Title:Enigmas do Roteiro>\n1. \"Enigmas do Roteiro\" contém 9 estágios de materiais, 1 estágio será automaticamente aberto por dia.\n2. Cada desafio consome 120 pontos de encefalina, ao ter sucesso no desafio você receberá moedas da atividade.\n3. Após concluir o estágio, a função \"Recriar\" deste estágio será desbloqueada. Por favor, note: ao usar a função \"Recriar\", não será possível obter taxa de sincronização.\n4. Você pode usar o auxílio do Alumni e do \"Resonância: Valor de Fase do Diretor\" para ajudá-lo a passar pelos estágios mais facilmente.\n\n<Title:Inspiração Adicional>\n1. Quando o guardião possuir Corpos Despertos ou Rodas do destino específicas (não é necessário equipá-los), poderá obter bônus adicionais de queda de \"Inspiração Errante\" nas recompensas das missões dos estágios de \"Enigmas do Roteiro\" (incluindo recriação), os bônus específicos são os seguintes:\n· Corpo Desperto \"Lily\": Despertar Espiritual 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\n· Roda do destino SSR \"Graça Através da Dor\": Nível de empilhamento 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\n· Roda do destino SR \"Mágica 35mm\": Nível de empilhamento 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\n2. Os bônus de \"Inspiração Adicional\" de diferentes Corpos Despertos ou Rodas do destino são acumulativos.\n3. Especialmente, as recompensas da primeira conclusão em dificuldade Loucura não serão afetadas pelos bônus acima.\n\n<Title:Resonância: Valor de Fase do Diretor>\n1. Os guardiões podem obter \"Coração da interpretação\" ao completar conquistas da atividade.\n2. Ao consumir \"Coração da interpretação\", ative a \"Resonância: Valor de Fase do Diretor\", isso deixará o guardião mais forte nas mecânicas da atividade \"Enigmas do Roteiro\" e \"Registro Especial: A Magia da História\".\n\n<Title:Compensação de Reedição>\n1. Os guardiões que já tenham desbloqueado o \"Registro Especial: A Magia da História\" anteriormente receberão uma compensação de \"Inspiração Errante\" *700 ao re-desbloqueá-lo durante esta reedição da atividade.\nOs guardiões que já tenham obtido anteriormente o avatar limitado da atividade \"Em Nome da Chave de Prata: Lily\" terão cada obtenção subsequente automaticamente convertida em \"Inspiração Errante\" *2000.\nOs guardiões que já tenham obtido materiais de ativação de resonância \"Coração da interpretação\" terão cada \"Coração da interpretação\" adicional obtido automaticamente convertido em \"Cupom de ouro rosa\" *5000.\n\n<Title:Tempo da Atividade>\n1. 13 de janeiro 9:00 - 27 de janeiro 9:00 (GMT+8), todo o conteúdo mencionado na apresentação da atividade estará disponível.\n2. 27 de janeiro 9:00 - 3 de fevereiro 9:00 (GMT+8), apenas a \"Loja de roteiros mágicos\" e as \"Recompensas de Conquistas\" permanecerão, o restante do conteúdo será encerrado e não estará mais disponível.\n3. Após 3 de fevereiro 9:00 (GMT+8), as \"Inspirações Errantes\" restantes que não forem resgatadas serão recuperadas na proporção de 40 \"Cupom de ouro rosa\" por cada unidade, por favor, os guardiões fiquem atentos para verificar os e-mails."
  },
  Activity_67741_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_67742_ActivityName = {
    Text = "Com o Tomo da Rosa · Reedição"
  },
  Activity_67742_ActivityPlot = {
    Text = "Diamantes dourados, pérolas brilhantes... \nInúmeros adornos luxuosos lhe deram uma ilusão de imperatriz \nAgora, ela está determinada a manter essa ilusão para sempre"
  },
  Activity_67742_ActivityStageEndContent = {
    Text = "Evento encerrado, apenas disponível para \"Festival Dourado\""
  },
  Activity_67742_ActivityTips = {
    Text = "<Title:Atividade Introdução>\n1. Durante o evento, o Guardião poderá coletar a moeda da atividade \"Leque de Plumagem Espiritual\" através da jogabilidade limitada \"Memórias da Rosa\" e das \"Recompensas de Conquista\". Com ela, poderá trocar por recompensas generosas em \"Festival Carmesim\", incluindo a Roda do destino SR exclusiva da atividade \"Milhões de Olhares Amorosos\", Núcleo Imaculado, Núcleo de Lumen, Fragmentos de Pedra Sábia e Cristal de Mimese, entre outros.\n2. Durante o evento, ao completar as tarefas de \"Recompensas de Conquista\", você receberá o avatar exclusivo da atividade \"Em Nome da Chave de prata: Sorel\", a Roda do destino SR exclusiva \"Milhões de Olhares Amorosos\", Núcleo de prata e uma grande quantidade da moeda da atividade \"Leque de Plumagem Espiritual\".\n3. Durante o evento, o \"Registro da força-tarefa: Hino à Rosa\" será aberto gratuitamente.\n\n<Title:Memórias da Rosa>\n1. \"Memórias da Rosa\" contém 9 estágios, abrindo automaticamente 1 por dia.\n2. Cada desafio consome 120 pontos de encefalina. Ao desafiar diferentes estágios, além de obter diferentes materiais como recompensa, também receberá a moeda da atividade \"Leque de Plumagem Espiritual\".\n3. Após concluir um estágio, será desbloqueada a função \"Recriação\" deste estágio. Por favor, note: ao usar a função \"Recriação\", não será possível obter taxa de sincronização.\n4. Você pode usar o apoio da Alumni para ajudá-lo a passar os estágios mais facilmente.\n\n<Title:Bônus do Leque>\n1. Se o Guardião possuir Corpos Despertos ou Rodas do destino específicos (não é necessário colocá-los em combate), poderá obter bônus adicionais na quantidade de \"Leques de Plumagem Espiritual\" recebidos nas recompensas das missões dos estágios de \"Memórias da Rosa\" (incluindo a recriação). Os bônus específicos são os seguintes:\nCorpo Desperto \"Sorel\": Despertar Espiritual 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\nRoda do destino SSR \"Em Nome de Rosa\": Nível de Sobreposição 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\nRoda do destino SR \"Milhões de Olhares Amorosos\": Nível de Sobreposição 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\n2. Os bônus de \"Leque\" de diferentes Corpos Despertos ou Rodas do destino são acumulativos.\n3. Especialmente, as recompensas da primeira conclusão em dificuldade Loucura não são afetadas pelos bônus acima.\n\n<Title:Compensação de Reedição>\n1. Durante o evento, os Guardiões do segredo que já tenham desbloqueado anteriormente o \"Registro da força-tarefa: Hino à Rosa\" receberão uma compensação de 700 \"Leques de Plumagem Espiritual\" ao desbloqueá-lo novamente.\nOs Guardiões do segredo que já tenham obtido anteriormente o avatar exclusivo da atividade \"Em Nome da Chave de prata: Sorel\" converterão automaticamente a recompensa em 2000 \"Leques de Plumagem Espiritual\" caso a obtenham novamente.\n\n<Title:Tempo da Atividade>\n1. Das 9:00 de 27 de janeiro até as 9:00 de 10 de fevereiro (GMT+8), todos os conteúdos da atividade estarão disponíveis.\n2. Das 9:00 de 10 de fevereiro até as 9:00 de 17 de fevereiro (GMT+8), apenas estarão disponíveis o \"Festival Carmesim\" e as \"Recompensas de Conquista\", os demais conteúdos estarão encerrados e indisponíveis.\n3. Após as 9:00 de 17 de fevereiro (GMT+8), os \"Leques de Plumagem Espiritual\" restantes que não forem trocados serão recuperados na proporção de 40 \"Cupom de ouro rosa\" por cada unidade. Por favor, fique atento para verificar sua caixa de correio."
  },
  Activity_67742_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_67743_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_67744_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_67744_ActivityPlot = {
    Text = "Senhoras e senhores.\nA noite gentil abriu suas cortinas—preparem sua melhor bebida.\nEsta é uma longa história. Permitam-nos contá-la com calma."
  },
  Activity_67745_ActivityName = {
    Text = "Quando as montanhas nevadas derretem · Recriação"
  },
  Activity_67745_ActivityPlot = {
    Text = "As neves de Elworth nunca derretem, assim como seu ódio.\nQuando as mãos do futuro e do passado se entrelaçam, o guerreiro levantará a espada, lançando um ataque de vingança contra o destino.\nQuando ela enfrenta as ondas negras, você é sua bandeira"
  },
  Activity_67745_ActivityStageEndContent = {
    Text = "Evento encerrado, apenas disponível para \"Boca da Montanha\""
  },
  Activity_67745_ActivityTips = {
    Text = "<Title:Introdução da atividade>\n1, Durante a atividade, os Guardiões podem coletar três tipos de \"Brotinhos\" através do modo de jogo por tempo limitado \"Ambição da Besta\" e das \"Recompensas de Conquista\". Os \"Brotinhos\" podem ser trocados na \"Boca Gigante da Montanha\" por recompensas de itens, incluindo a Roda do destino SR limitada da atividade \"Até a Neve Derreter\",\"Núcleo Imaculado\",\"Núcleo de Lumen\",\"Fragmentos de Pedra Sábia\",\"Cristal de Mimese\", entre outros.\n2, Durante a atividade,\"Registro da força-tarefa: O Retornado de Elworth\" estará disponível gratuitamente.\n\n<Title:Período da atividade>\n1, 13 de julho, 9:00 - 10 de agosto, 9:00(GMT+8), todos os conteúdos da atividade estarão disponíveis.\n2, 10 de agosto, 9:00 - 17 de agosto, 9:00(GMT+8), apenas a \"Boca Gigante da Montanha\" e as \"Recompensas de Conquista\" serão mantidas; os demais conteúdos estarão Concluídos e não poderão ser participados.\n\n<Title: Ambição da Besta>\n1,\"Ambição da Besta\" contém 5 Fases, sendo 1 desbloqueada automaticamente a cada 2 dias.\n2, Cada desafio consumirá\"Lingfétide\" × 120. Ao concluir o desafio com sucesso, você obterá as moedas da atividade \"Brotinho congelado\",\"Brotinho de prata com geada\" e \"Botão de sol\".\n3, Após Concluir a Fase, a função \"Recriar\" dessa Fase será desbloqueada. Atenção: ao usar a função \"Recriar\", não é possível obter Taxa de Sincronização.\n4, Você pode usar o Apoio de batalha da associação de ex-alunos e a \"Resonância: Devorar montanhas\" para ajudá-lo a Concluir as Fases com mais facilidade.\n5, Atenção: os desafios de dificuldade de loucura não consomem Lingfétide, não podem ser Recriados, e desafios repetidos após a primeira conclusão não renderão mais recompensas de moedas da atividade.\n\n<Title: Bônus de Brotinhos>\n1, Guardiões que possuam determinados Corpos Despertos ou Rodas do destino(não é necessário colocá-los em campo) podem obter bônus adicionais de queda de \"Brotinho congelado\",\"Brotinho de prata com geada\" e \"Botão de sol\" nas recompensas de missões de Fase de \"Ambição da Besta\"(incluindo Recriar). Os bônus específicos são os seguintes:\n·Corpo Desperto \"Helot: Catena\": Despertar Espiritual 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%\n·Roda do destino SSR \"Afogando-se em Carmesim\": Nível de empilhamento 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%\n·Roda do destino SR \"Até a Neve Derreter\": Nível de empilhamento 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%\n2, O \"Bônus de Brotinhos\" de diferentes Corpos Despertos ou Rodas do destino é calculado de forma acumulada.\n3, Em especial, as recompensas da primeira conclusão do desafio de dificuldade de loucura não serão afetadas pelo \"Bônus de Brotinhos\".\n\n<Title:Resonância: Devorar montanhas>\n1, Os Guardiões podem obter o \"Coração Devorador\" completando as conquistas da atividade.\n2, Ao consumir o \"Coração Devorador\" e ativar a \"Resonância: Devorar montanhas\", os Guardiões ficarão mais fortes no modo de jogo da atividade \"Ambição da Besta\", tornando os desafios mais fáceis.\n\n<Title: Boca Gigante da Montanha>\n1, A \"Boca Gigante da Montanha\" possui três lojas de troca, com os seguintes horários de abertura:\n·\"Ambição Devoradora\": abre às 9h do dia 13 de julho.\n·\"Espírito de Vingança\": abre às 9h do dia 15 de julho.\n·\"Esperança de ressurreição\": abre às 9h do dia 17 de julho.\n2, Cada troca consumirá\"Brotinho congelado\"/\"Brotinho de prata com geada\"/\"Botão de sol\" × 750, obtendo aleatoriamente cinco recompensas de itens da loja de troca.\n3, As recompensas de itens de cada loja de troca são divididas em \"Item Especial\" e \"Item comum\". Ao reiniciar, é possível redefinir a quantidade Restante de recompensas de Item Especial ao limite máximo. As regras específicas são:\n(1)Primeiras 2 reinicializações: quando não houver quantidade Restante de \"Item Especial\", o Guardião pode optar por reiniciar, redefinindo a quantidade Restante de \"Item Especial\" e \"Item comum\" ao limite máximo; também pode optar por continuar trocando. Quando não houver quantidade Restante de \"Item comum\", será necessário reiniciar para continuar trocando.\n(2)A partir da 3ª reinicialização: só é possível reiniciar quando não houver quantidade Restante de \"Item comum\". A reinicialização redefinirá a quantidade Restante de \"Item comum\" ao limite máximo, e o \"Item Especial\" não será mais reiniciado.\n4, Após as 9:00 do dia 17 de agosto(GMT+8), os \"Brotinhos\" Restantes não trocados serão recuperados na proporção de \"Cupom de ouro rosa\" × 40 por unidade. Os Guardiões devem verificar seus e-mails.\n\n<Title: Registro da força-tarefa>\n1, Durante a atividade,\"Registro da força-tarefa: O Retornado de Elworth\" estará disponível gratuitamente. Após Concluir \"Registro da força-tarefa: O Retornado de Elworth\", é possível obter \"Núcleo de prata\", a Roda do destino SR limitada da atividade \"Até a Neve Derreter\" e outras recompensas nas Recompensas de Conquista. As Recompensas de Conquista só estarão disponíveis durante o período da atividade e não poderão ser concluídas ou recebidas após o término da atividade.\n2, Após o término da atividade, o progresso de investigação de \"Registro da força-tarefa: O Retornado de Elworth\" será Preservado. Se \"Registro da força-tarefa: O Retornado de Elworth\" não for desbloqueado durante a atividade, ainda será possível desbloqueá-lo após o término da atividade consumindo \"Ponto de partida real\" × 7.\n3, Independentemente de estar ou não no período da atividade, após Concluir \"Registro da força-tarefa: O Retornado de Elworth\", é possível obter \"Ordem de chave: A Resolução das Montanhas\"."
  },
  Activity_67745_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_67746_ActivityName = {
    Text = "Portal de todos os reinos: repetição"
  },
  Activity_67746_ActivityPlot = {
    Text = "Ninguém sabe há quanto tempo ela monta guarda silenciosa na Porta da Extrema Pobreza.\nEla nunca pretendeu se manifestar em qualquer mundo tangível, nem ser arrastada por qualquer corrente espaço-temporal.\nLá, na Porta, ela permaneceu imperturbável—\nAté o momento em que seus olhos encontraram os seus."
  },
  Activity_67746_ActivityStageEndContent = {
    Text = "O evento foi Concluído. Atualmente, apenas \"Resonância\" está disponível."
  },
  Activity_67746_ActivityTips = {
    Text = "<Title:Descrição do evento>\n1. Durante o evento, o guardião pode coletar a moeda do evento \"Ponteiro final\" através da jogabilidade limitada \"Teste final\" e \"Recompensas de Conquista\", e o \"Ponteiro final\" pode ser trocado por recompensas generosas em \"Eco\", incluindo a roda de destino SR exclusiva do evento \"Porta da Verdade\", Núcleo Imaculado, Núcleo de Lumen, Fragmentos de Pedra Sábia, Cristal de Mimese e outros itens.\n2. Durante o evento, ao completar as tarefas de \"Recompensas de Conquista\", você poderá obter o avatar exclusivo do evento \"Por nome da Chave de Prata: \"Tavi\"\", a roda de destino SR exclusiva do evento \"Porta da Verdade\", Núcleo de prata e uma grande quantidade da moeda do evento \"Ponteiro final\".\n\n<Title:Tempo do evento>\n1. 3 de novembro 9:00 - 17 de novembro 9:00 (GMT+8), todo o conteúdo do evento estará disponível.\n2. 17 de novembro 9:00 - 24 de novembro 9:00 (GMT+8), apenas \"Eco\" e \"Recompensas de Conquista\" estarão disponíveis, todo o outro conteúdo terá terminado e não poderá mais ser acessado.\n\n<Title:Teste final>\n1. \"Teste final\" contém 9 estágios, sendo liberado automaticamente 1 por dia.\n2. Cada desafio consome 120 pontos de neuropeptídeo, e ao desafiar estágios diferentes, além de obter diferentes materiais como recompensa, também receberá a moeda do evento \"Ponteiro final\".\n3. Os estágios deste evento são estágios de materiais com batalhas diretas, podendo ser reproduzidos após serem concluídos! Cada \"Reproduzir\" consome 120 pontos de neuropeptídeo.\n4. Atente-se: ao usar a função \"Reproduzir\", não será possível obter afinidade.\n\n<Title:Bônus do Ponteiro final>\n1. Ao possuir Corpos Despertos ou rodas de destino específicos (não é necessário equipá-los), o guardião poderá obter um bônus adicional na quantidade de \"Ponteiro final\" recebida nas recompensas das missões do estágio \"Teste final\" (incluindo reprodução), conforme descrito a seguir:\nCorpo Desperto \"Tavi\": Despertar Espiritual 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\nRoda de destino SSR \"Roda Invisível\": Nível de empilhamento 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\nRoda de destino SR \"Porta da Verdade\": Nível de empilhamento 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\n2. Os bônus de \"Ponteiro final\" de diferentes Corpos Despertos ou rodas de destino são acumulativos.\n3. Especificamente, as recompensas da primeira conclusão em dificuldade de Loucura não são afetadas pelo bônus do \"Ponteiro final\".\n\n<Title:Eco>\n1. \"Eco\" estará disponível apenas entre 3 de novembro 9:00 - 24 de novembro 9:00 (GMT+8).\n2. Após as 9:00 de 24 de novembro (GMT+8), os \"Ponteiros finais\" restantes que não foram trocados serão recuperados na proporção de \"Cupom de ouro rosa *40\" por troca; por favor, verifique seu e-mail."
  },
  Activity_67746_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_67746_UnlockConditionExplanation = {
    Text = "Desbloqueado após completar \"Operação de Investigação\" 2-9 · Normal"
  },
  Activity_67748_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_67749_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_68349_ActivityName = {
    Text = "Transcender as Estrelas · Pré-venda por tempo limitado"
  },
  Activity_68349_ActivityTips = {
    Text = "<Title: Além das Estrelas · Pré-venda Limitada>\n· Esta atividade de pré-venda limitada inclui 8 pacotes, sendo o primeiro pacote disponível gratuitamente e os pacotes do 2 ao 8 disponíveis somente após a compra de \"Além das Estrelas · Pré-venda Limitada\".\n· Após comprar \"Além das Estrelas · Pré-venda Limitada\", você poderá receber imediatamente a recompensa do segundo pacote; os pacotes subsequentes só poderão ser resgatados após aguardar um determinado período de tempo.\n· A compra de \"Além das Estrelas · Pré-venda Limitada\" tem limite de tempo e não estará mais disponível após o término. Por favor, compre com moderação, Guardião."
  },
  Activity_68374_ActivityName = {
    Text = "Caixa de Presente do Festival de Inverno"
  },
  Activity_68374_ActivityPlot = {
    Text = "Uma caixa de presente fornecida por Misaq para a celebração da Festa de Inverno. Nem o vento nem a geada podem destruir a vontade de Misaq de resistir à Fusão. Na luz festiva das fogueiras, almas que se apoiam mutuamente abrigarão todos que se recusam a ceder ao Destino."
  },
  Activity_68375_ActivityName = {
    Text = "Caixa de Presente Especial de Aniversário"
  },
  Activity_68375_ActivityPlot = {
    Text = "Remodelado pela Tecnologia Silvercore, Seu olhar assume novas formas para acompanhá-lo. Em cada momento do último ano, Ele esteve com você."
  },
  Activity_68404_ActivityName = {
    Text = "Texto temporário"
  },
  Activity_68404_ActivityPlot = {
    Text = "Texto temporário"
  },
  Activity_68404_ActivityStageEndContent = {
    Text = "Evento encerrado, apenas disponível para \"Texto Temporário\""
  },
  Activity_68404_ActivityTips = {
    Text = "<Title:Resumo do Evento>\nTexto Temporário"
  },
  Activity_68404_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_68405_ActivityName = {
    Text = "Revolução do Rei Divino"
  },
  Activity_68405_ActivityPlot = {
    Text = "No desejo interminável de desejos, desperta brevemente em seu longo sono e lança um olhar real para este mundo esmaecido.\nNa vida eterna, este olhar é tão breve"
  },
  Activity_68405_ActivityStageEndContent = {
    Text = "O evento terminou. Atualmente, apenas \"Abismo da Consciência\" está disponível."
  },
  Activity_68405_ActivityTips = {
    Text = "<Title:Breve introdução do evento>\n1. Durante o evento, os guardiões poderão coletar moedas de evento \"Pensamento Exausto\",\"Pensamento Triste\" e \"Pensamento Alegre\" através das jogabilidades limitadas \"Encarar o Mar Profundo\" e \"Recompensas de Conquistas\". As moedas de evento poderão ser usadas em \"Abismo da Consciência\" para comprar itens, incluindo a Roda do destino SR exclusiva do evento \"Trono de Pedra Azul\", Núcleo de Lumen, Núcleo Imaculado, Fragmentos de Pedra Sábia e Cristal de Mimese, entre outros.\n2. Durante o evento, completar conquistas do evento também permitirá obter o avatar exclusivo do evento \"Em Nome da Chave de Prata: Tulu\", a Roda do destino SR exclusiva do evento \"Trono de Pedra Azul\", Prata e uma grande quantidade de moedas de evento!\n\n<Title:Período do evento>\n1. 30 de dezembro 9:00 - 13 de janeiro 9:00(GMT+8), todas as jogabilidades do evento estarão disponíveis.\n2. 13 de janeiro 9:00 - 20 de janeiro 9:00(GMT+8), apenas \"Abismo da Consciência\" e recompensas de conquistas estarão disponíveis.\n\n<Title:Encarar o Mar Profundo>\n1.\"Encarar o Mar Profundo\" possui 5 estágios, cada um será liberado automaticamente a cada 2 dias.\n2. Cada desafio consome 120 pontos de lipofenina, ao vencer o desafio você receberá moedas de evento.\n3. Após concluir um estágio, será desbloqueada a função \"Recriar\" daquele estágio. Por favor, note: ao usar a função \"Recriar\", não será possível obter taxa de sincronização.\n4. Você poderá usar o apoio da \"Alumni\" para ajudá-lo a passar de fase mais facilmente.\n\n<Title:Bônus de Pensamento>\n1. Quando o guardião possuir Corpos Despertos específicos ou Rodas do destino(não é necessário equipá-los), poderá obter bônus adicionais nas moedas de evento obtidas nas recompensas das missões dos estágios de \"Encarar o Mar Profundo\", os bônus específicos são os seguintes:\n· Corpo Desperto \"Tulu\": Despertar Espiritual 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%.\n· Roda do destino SSR \"Hino do Soberano\": Nível de empilhamento 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%.\n· Roda do destino SR \"Trono de Pedra Azul\": Nível de empilhamento 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%.\n2. Os \"Bônus de Pensamento\" de diferentes Corpos Despertos ou Rodas do destino serão acumulados.\n3. Especialmente, as recompensas da primeira conclusão em dificuldade Loucura não serão afetadas pelos \"Bônus de Pensamento\".\n\n<Title:Abismo da Consciência>\n1.\"Abismo da Consciência\" estará disponível apenas entre 30 de dezembro 9:00 - 20 de janeiro 9:00(GMT+8).\n2. Após 20 de janeiro 9:00(GMT+8), os \"Pensamentos Exaustos\",\"Pensamentos Tristes\" e \"Pensamentos Alegres\" restantes que não forem resgatados serão recolhidos de acordo com a proporção de cada moeda ser convertida em \"Cupom de ouro rosa*40\", por favor, os guardiões fiquem atentos para verificar os e-mails recebidos."
  },
  Activity_68405_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_68406_ActivityName = {
    Text = "Enterrado na memória"
  },
  Activity_68406_ActivityPlot = {
    Text = "As pessoas enterram seus desejos nas profundezas de suas memórias, vestindo máscaras ilusórias para apaziguar o mundo.\nEscute—os gritos daquilo que jaz oculto sob a Carne e sangue, Ecoando através das brumas da memória.\nEsvazie sua mente, despoje-se de sua Carne e sangue, e abrace seu eu real."
  },
  Activity_68406_ActivityStageEndContent = {
    Text = "O evento foi Concluído. Atualmente, apenas \"Sala de Tratamento Neurológico\" está disponível."
  },
  Activity_68406_ActivityTips = {
    Text = "<Title:Descrição do evento>\nDurante o evento, o Guardião poderá coletar moedas do evento através das atividades limitadas \"Terapia do Medo\" e \"Recompensas por Conquistas\". As moedas do evento poderão ser trocadas na \"Clínica Neurológica\" para obter recompensas em itens, incluindo a roda de destino SR exclusiva do evento \"Pêndulo Hipnótico\", Pedra Filosofal, Núcleo Puro, Núcleo Luminoso e outros.\n\n<Title:Data do evento>\n1. 7 de abril 9:00 - 21 de abril 9:00 (GMT+8), todos os conteúdos do evento estarão disponíveis.\n2. 21 de abril 9:00 - 28 de abril 9:00 (GMT+8), apenas a \"Clínica Neurológica\" e \"Recompensas por Conquistas\" estarão disponíveis, os demais conteúdos terão terminado e não poderão mais ser acessados.\n\n<Title:Terapia do Medo>\n1. \"Terapia do Medo\" contém 5 estágios, cada 2 dias 1 estágio será automaticamente liberado.\n2. Cada desafio consome 120 pontos de menofim, ao vencer o desafio você receberá moedas do evento.\n3. Após concluir um estágio, será desbloqueada a função \"Recriação\" deste estágio. Por favor, note: ao usar a função \"Recriação\", não será possível obter taxa de sincronização.\n4. Você poderá usar o apoio da Alumni para ajudá-lo a passar os estágios mais facilmente.\n\n<Title:Bonificação do evento>\n1. Quando o Guardião possuir despertadores ou rodas de destino específicos (não é necessário tê-los em combate), poderá obter bônus adicional de queda de \"Relatório de Diagnóstico\" nas recompensas das missões dos estágios \"Terapia do Medo\" (incluindo Recriação), os bônus específicos são os seguintes:\n· Despertador \"Clementine\": Espírito Ativado em 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%\n· Roda de destino SSR \"Dor Oculta\": Sobreposição em 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%\n· Roda de destino SR \"Pêndulo Hipnótico\": Sobreposição em 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%\n2. Os \"Bônus do evento\" de diferentes despertadores ou rodas de destino serão acumulados.\n3. Especialmente, as recompensas da primeira conclusão em dificuldade frenética não serão afetadas pelos \"Bônus do evento\".\n\n<Title:Clínica Neurológica>\n1. Cada \"Enviar Relatório\" consumirá 1000 \"Relatórios de Diagnóstico\", aleatoriamente receberá uma das cinco recompensas disponíveis na \"Clínica Neurológica\".\n2. As recompensas da \"Clínica Neurológica\" são divididas em dois tipos: \"Itens Especiais\" e \"Itens Comuns\". Ao redefinir, a quantidade restante das recompensas \"Itens Especiais\" será redefinida para o limite máximo. As regras específicas são as seguintes:\n(1) Primeiras 5 redefinições: quando não houver mais quantidade restante de \"Itens Especiais\", o Guardião poderá escolher redefinir, após a redefinição, a quantidade restante de \"Itens Especiais\" e \"Itens Comuns\" será redefinida para o limite máximo; também poderá continuar trocando, quando não houver mais quantidade restante de \"Itens Comuns\", será necessário redefinir para continuar trocando.\n(2) A partir da 6ª redefinição: somente quando não houver mais quantidade restante de \"Itens Comuns\", será possível redefinir. A redefinição redefinirá a quantidade restante de \"Itens Comuns\" para o limite máximo, os \"Itens Especiais\" não serão mais redefinidos.\n3. Após 28 de abril 9:00 (GMT+8), os \"Relatórios de Diagnóstico\" restantes não resgatados serão recuperados na proporção de 40 \"Vouchers de Rosa\" por cada unidade, por favor, verifique seu e-mail."
  },
  Activity_68406_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_68407_ActivityName = {
    Text = "Texto temporário"
  },
  Activity_68407_ActivityPlot = {
    Text = "Texto temporário"
  },
  Activity_68407_ActivityStageEndContent = {
    Text = "Evento encerrado, apenas disponível para \"Texto Temporário\""
  },
  Activity_68407_ActivityTips = {
    Text = "<Title:Resumo do Evento>\nTexto Temporário"
  },
  Activity_68407_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_68409_ActivityName = {
    Text = "Texto temporário"
  },
  Activity_68409_ActivityPlot = {
    Text = "Texto temporário"
  },
  Activity_68409_ActivityStageEndContent = {
    Text = "Evento encerrado, apenas disponível para \"Texto Temporário\""
  },
  Activity_68409_ActivityTips = {
    Text = "<Title:Resumo do Evento>\nTexto Temporário"
  },
  Activity_68409_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_68410_ActivityName = {
    Text = "Sombra da cidade chuvosa"
  },
  Activity_68410_ActivityPlot = {
    Text = "Um encontro destinado espera na chuva úmida e nebulosa. Você conhece o nome dela e o rosto dela, e a voz dela ainda o embala em uma sensação de tranquilidade. \nMas lembre-se—apenas deuses e demônios são tão desesperados para satisfazer os desejos humanos. \nAdivinhe. Qual deles ela é?"
  },
  Activity_68410_ActivityStageEndContent = {
    Text = "O evento terminou. Você agora só pode participar do \"Cofr da Bruxa\"."
  },
  Activity_68410_ActivityTips = {
    Text = "<Title:Breve introdução da atividade>\n1. Durante a atividade, o Guardião poderá coletar moedas de atividade por meio das jogabilidades limitadas \"Loja da Bruxa\" e \"Recompensas de Conquista\". As moedas de atividade poderão ser usadas em \"O Tesouro da Bruxa\" para trocar por recompensas de itens, incluindo a Roda do destino SR exclusiva da atividade \"Chapéu de Aba Larga da Bruxa\", Pedra Filosofal, Núcleo Imaculado e Núcleo de Lumen, entre outros.\n2. Durante a atividade, o \"Registro da força-tarefa: Sombras da Cidade da Chuva\" estará disponível gratuitamente. Completar os logros da atividade também permitirá obter o avatar exclusivo da atividade \"Em Nome da Chave de prata: Daffodil\"!\n\n<Title:Período da atividade>\n1. De 24 de fevereiro às 9:00 até 10 de março às 9:00 (GMT+8), todos os conteúdos da atividade estarão disponíveis.\n2. De 10 de março às 9:00 até 17 de março às 9:00 (GMT+8), apenas \"O Tesouro da Bruxa\" e \"Recompensas de Conquista\" permanecerão disponíveis, os demais conteúdos serão encerrados e não poderão mais ser acessados.\n\n<Title:Loja da Bruxa>\n1. \"Loja da Bruxa\" contém 5 estágios, cada um será aberto automaticamente a cada 2 dias.\n2. Cada desafio consome 120 pontos de encefalina, e ao vencer o desafio você receberá moedas de atividade.\n3. Após concluir um estágio, será desbloqueada a função \"Recriação\" deste estágio. Por favor, note: ao usar a função \"Recriação\", não será possível obter taxa de sincronização.\n4. Você poderá usar o apoio dos Alumni para ajudá-lo a passar os estágios com mais facilidade.\n\n<Title:Bonificação da atividade>\n1. Se o Guardião possuir um determinado Corpo Desperto ou Roda do destino (não é necessário equipar), poderá obter bônus adicional na queda de \"Crânio do Animal Pálido\", \"Crânio de Fera Sombria\" e \"Crânio do Animal Escarlate\" nas recompensas das missões dos estágios de \"Loja da Bruxa\" (incluindo Recriação). Os detalhes do bônus são os seguintes:\nCorpo Desperto \"Daffodil\": Despertar Espiritual 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\nRoda do destino SSR \"Coleção Preciosa\": Níveis 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\nRoda do destino SR \"Chapéu de Aba Larga da Bruxa\": Níveis 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\n2. Os \"Bônus de Atividade\" de diferentes Corpos Despertos ou Rodas do destino são acumuláveis.\n3. Especialmente, as recompensas da primeira conclusão no modo Loucura não são afetadas pelos \"Bônus de Atividade\".\n\n<Title:O Tesouro da Bruxa>\n1. Existem três \"Tesouros da Bruxa\", com os seguintes horários de abertura:\n\"Remédio para as Preocupações\": de 24 de fevereiro às 9:00 até 17 de março às 9:00.\n\"Tesouro Precioso\": de 26 de fevereiro às 9:00 até 17 de março às 9:00.\n\"Mercadoria Rara e Preciosa\": de 28 de fevereiro às 9:00 até 17 de março às 9:00.\n2. Cada troca consome 750 \"Crânio do Animal Pálido\"/\"Crânio de Fera Sombria\"/\"Crânio do Animal Escarlate\", e aleatoriamente concede cinco recompensas de itens do tesouro.\n3. As recompensas dos tesouros são divididas em dois tipos: \"Item Especial\" e \"Item comum\". Ao redefinir, é possível redefinir a quantidade restante de recompensas específicas até o limite máximo. As regras detalhadas são as seguintes:\n(1) Primeiras 2 redefinições: quando não houver mais quantidade restante dos \"Item Especial\", o Guardião poderá escolher redefinir. Após a redefinição, a quantidade restante dos \"Item Especial\" e \"Item comum\" será redefinida para o limite máximo; também é possível continuar trocando, e quando não houver mais quantidade restante dos \"Item comum\", será necessário redefinir para continuar trocando.\n(2) A partir da 3ª redefinição: só será possível redefinir quando não houver mais quantidade restante dos \"Item comum\", a redefinição redefinirá a quantidade restante dos \"Item comum\" para o limite máximo, os \"Item Especial\" não serão mais redefinidos.\n\n<Title:Registro de Operações>\n1. Durante a atividade, o \"Registro da força-tarefa: Sombras da Cidade da Chuva\" estará disponível gratuitamente.\n2. Após o término da atividade, o progresso do \"Registro da força-tarefa: Sombras da Cidade da Chuva\" será mantido. Se você não desbloqueou o \"Registro da força-tarefa: Sombras da Cidade da Chuva\" durante a atividade, ainda poderá desbloqueá-lo após o término consumindo 7 \"Ponto de partida real\".\n3. Independentemente de estar ou não durante a atividade, após concluir o \"Registro da força-tarefa: Sombras da Cidade da Chuva\", você poderá obter o \"Selo-Chave: Verdadeiro Rosto da Névoa Cinza\"."
  },
  Activity_68410_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_68411_ActivityName = {
    Text = "Texto temporário"
  },
  Activity_68411_ActivityPlot = {
    Text = "Texto temporário"
  },
  Activity_68411_ActivityStageEndContent = {
    Text = "Evento encerrado, apenas disponível para \"Texto Temporário\""
  },
  Activity_68411_ActivityTips = {
    Text = "<Title:Resumo do Evento>\nTexto Temporário"
  },
  Activity_68411_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_70438_ActivityName = {
    Text = "Uma Nya Nya Rate"
  },
  Activity_70438_ActivityPlot = {
    Text = "O Festival da Oração pela Colheita está chegando, e todos estão focados nos preparativos do evento, sem notar que, nos cantos, manchas negras estão se movendo silenciosamente e o pequeno prisioneiro se transformou em líquido para escapar da prisão.\nEnquanto a fenda dimensional cintila, a pelota preta começa a se dividir... uma vasta maré de gatos negros está engolindo o campus inteiro!\nVocê inicialmente pretendia ignorar isso, bastaria entregar esse evento estranho à administração escolar.\nMas ao ver que eles deixam cair núcleos de prata e vales de ouro, você mudou de ideia."
  },
  Activity_70438_ActivityTips = {
    Text = "<Title:Breve introdução ao evento>\nO evento de jogabilidade \"Uma Nya Nya Rate\" está disponível por tempo limitado! Durante o evento, os Guardiões do Segredo podem atacar gatos escolares em \"Batalha dos Gatos\" e ganhar muitos Núcleos de prata e Cupons de ouro rosa!\n\n<Title:Período do evento>\n24 de janeiro 9:00 - 5 de fevereiro 9:00 (GMT+8). Durante o evento, os jogadores podem participar diariamente das fases \"Batalha dos Gatos\" desbloqueadas no dia. As fases concluídas não estarão mais disponíveis.\n\n<Title:Batalha dos Gatos>\n1. Existem 12 fases no total em \"Batalha dos Gatos\". Diferentes fases estarão disponíveis em dias diferentes, e as fases já concluídas não estarão mais disponíveis.\n2. Cada desafio não consome Mithril, e após completar cada fase você receberá Núcleo Imaculado, Núcleos de prata e Cupons de ouro rosa.\n3. Nesta fase, não é possível usar o apoio da Alumni.\n4. Na fase do dia, cada corpo desperto só pode participar uma vez.\n5. As fases de cada dia devem ser desafiadas com o domínio especificado:\n24 de janeiro: Domínio do Caos\n25 de janeiro: Domínio do Mar Profundo\n26 de janeiro: Domínio da Carne\n27 de janeiro: Ultra Domínio\n28 de janeiro: Sem restrição\n29 de janeiro: Sem restrição\n30 de janeiro: Domínio do Caos e Domínio do Mar Profundo\n31 de janeiro: Domínio da Carne e Ultra Domínio\n1 de fevereiro: Domínio do Caos e Domínio da Carne\n2 de fevereiro: Domínio do Mar Profundo e Ultra Domínio\n3 de fevereiro: Domínio do Caos e Ultra Domínio\n4 de fevereiro: Domínio da Carne e Domínio do Mar Profundo"
  },
  Activity_70438_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_71095_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_71095_ActivityTips = {
    Text = "<Title:Condições de Participação>\n·Complete \"Operação de Investigação\" 2-9 (Normal) para participar.\n<Title:Evento de Investigação>\n·Durante o período do evento, um novo evento de investigação de \"Magia das Histórias\" será lançado diariamente. Os Guardiões podem desbloquear e investigar sem consumir inventário. Após completar o evento de investigação, recompensas como Coração Puro, Insígnia de Investigação e Experiência do Guardião podem ser obtidas.\n·Após o término do evento, o progresso da investigação de \"Magia das Histórias\" será retido. Os Guardiões podem consumir Jóias d em um Registro Especial para desbloquear investigações não completadas. Completar eventos de investigação não finalizados durante o período do evento também concederá recompensas consistentes com aquelas durante o evento.<Title:Recompensas por Tempo Limitado>\n·Recompensas por tempo limitado estarão disponíveis durante o evento. Os Guardiões podem obter Coração Puro, Pedra Filosofal e recompensas de Prata após concluir \"Magia das Histórias\" (modo Normal) e completar eventos de investigação de \"Magia das Histórias\"! As recompensas por tempo limitado só estarão disponíveis durante o período do evento e não podem ser completadas ou reivindicadas após o término do evento."
  },
  Activity_71097_ActivityName = {
    Text = "Texto temporário"
  },
  Activity_71097_ActivityPlot = {
    Text = "Texto temporário"
  },
  Activity_71097_ActivityStageEndContent = {
    Text = "Evento encerrado, apenas disponível para \"Texto Temporário\""
  },
  Activity_71097_ActivityTips = {
    Text = "<Title:Resumo do Evento>\nTexto Temporário"
  },
  Activity_71097_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_71098_ActivityName = {
    Text = "A meio passo · Recriação"
  },
  Activity_71098_ActivityPlot = {
    Text = "Ela sempre está à frente do mundo.\nUm passo, dois passos—suas pegadas iluminam o caminho para todos.\nMas os tolos esquecem facilmente demais:\nA distância entre a genialidade e a loucura\né de apenas meio passo."
  },
  Activity_71098_ActivityStageEndContent = {
    Text = "O evento foi Concluído. Atualmente, apenas \"Ensino do Mestre\" está disponível."
  },
  Activity_71098_ActivityTips = {
    Text = "<Title:Descrição do evento>\nDurante o evento, o Guardião pode coletar a moeda do evento \"Peças de boneca\" por meio das atividades limitadas \"Porta do Nada\" e \"Recompensas de Conquista\". As \"Peças de boneca\" podem ser trocadas por recompensas em \"Ensino do Mestre\", incluindo a Roda do destino SR exclusiva do evento \"Cajado do Pastor\", Núcleo de Lumen, Núcleo Imaculado, lascas de Pedra do Sábio, Cristal de Mimese e outros.\n\n<Title:Porta do Nada>\n1. \"Porta do Nada\" contém 9 estágios de materiais que não exigem exploração, apenas batalhas, e 1 estágio é aberto diariamente.\n2. Cada desafio consome 120 pontos de Menophin, e ao ter sucesso, você receberá materiais de desenvolvimento e moedas do evento.\n3. Após concluir um estágio, será desbloqueada a função \"Recriação\" desse estágio. Observe: ao usar a função \"Recriação\", não será possível obter taxa de sincronização.\n4. Você pode usar o apoio da Alumni para passar mais facilmente.\n\n<Title:Bônus de Peças de boneca>\n1. Quando o Guardião possuir Corpos Despertos ou Rodas do destino específicos (não é necessário estar em combate), poderá obter um bônus adicional na quantidade de \"Peças de boneca\" nas recompensas das missões dos estágios de \"Porta do Nada\" (incluindo Recriação). Os detalhes são os seguintes:\nCorpo Desperto \"Doll: Inferno\": Despertar Espiritual 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\nRoda do destino SSR \"Modelo Anatômico do Esquecimento\": Nível de empilhamento 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\nRoda do destino SR \"Cajado do Pastor\": Nível de empilhamento 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\n2. Os bônus de \"Peças de boneca\" de diferentes Corpos Despertos ou Rodas do destino são acumulados.\n3. Especialmente, as recompensas da primeira conclusão em dificuldade Loucura não são afetadas pelos bônus acima.\n\n<Title:Ensino do Mestre>\n1. Cada \"Troca de Peças\" consumirá 750 \"Peças de boneca\", aleatoriamente concedendo cinco recompensas dentre os itens em \"Ensino do Mestre\".\n2. As recompensas em \"Ensino do Mestre\" são divididas em dois tipos: \"Item Especial\" e \"Item comum\". Ao Retroceder, a quantidade restante de itens especiais será redefinida para o limite máximo. As regras detalhadas são as seguintes:\n(1) Primeiros 5 Retroceder: quando não houver mais \"Item Especial\" disponíveis, o Guardião pode escolher Retroceder, o que redefinirá a quantidade restante tanto de \"Item Especial\" quanto de \"Item comum\" para o limite máximo; ou pode optar por continuar trocando, e quando também não houver mais \"Item comum\" disponíveis, será necessário Retroceder para continuar trocando.\n(2) A partir do 6º Retroceder: só será possível Retroceder quando não houver mais \"Item comum\" disponíveis. Ao Retroceder, a quantidade restante de \"Item comum\" será redefinida para o limite máximo, enquanto os \"Item Especial\" não serão mais reiniciados.\n\n<Title:Período do evento>\n1. 16 de junho 9:00 - 30 de junho 9:00 (GMT+8), todas as atividades mencionadas na descrição do evento estarão disponíveis.\n2. 30 de junho 9:00 - 7 de julho 9:00 (GMT+8), apenas \"Ensino do Mestre\" e \"Recompensas de Conquista\" permanecerão disponíveis, enquanto todas as demais atividades serão encerradas.\n3. Após 7 de julho 9:00 (GMT+8), as \"Peças de boneca\" restantes não resgatadas serão recicladas na proporção de cada unidade por \"Cupom de ouro rosa*40\". Por favor, lembre-se de verificar seu e-mail."
  },
  Activity_71098_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_71100_ActivityName = {
    Text = "Revolução do Rei Divino"
  },
  Activity_71100_ActivityPlot = {
    Text = "No desejo interminável de desejos, desperta brevemente em seu longo sono e lança um olhar real para este mundo esmaecido.\nNa vida eterna, este olhar é tão breve"
  },
  Activity_71100_ActivityStageEndContent = {
    Text = "O evento terminou. Atualmente, apenas \"Abismo da Consciência\" está disponível."
  },
  Activity_71100_ActivityTips = {
    Text = "<Title:Atividade Introdução>\n1. Durante o evento, os guardiões podem coletar moedas de evento \"Pensamentos cansados\",\"Pensamento Triste\",\"Pensamento Alegre\" através das atividades limitadas \"Olhar do Mar Profundo\" e \"Recompensa de conquista\". As moedas de evento podem ser usadas para comprar itens em \"Abismo do mar da percepção\", incluindo a Roda do destino SR limitada \"Trono de Pedra Verde\", Núcleo de Lumen, Núcleo Imaculado, Fragmentos de Pedra Sábia, Cristal de Mimese, entre outros.\n2. Durante o evento, completar conquistas de evento também permite ganhar o avatar limitado \"Em Nome da Chave de prata: Caecus\", a Roda do destino SR limitada \"Trono de Pedra Verde\", Prata e uma grande quantidade de moedas de evento!\n\n<Title:Tempo do Evento>\n1. 30 de dezembro 9:00 - 13 de janeiro 9:00(GMT+8), todas as atividades do evento estarão disponíveis.\n2. 13 de janeiro 9:00 - 20 de janeiro 9:00(GMT+8), apenas \"Abismo do mar da percepção\" e \"Recompensa de conquista\" estarão disponíveis.\n\n<Title:Olhar do Mar Profundo>\n1.\"Olhar do Mar Profundo\" possui 5 estágios, cada 2 dias um novo estágio será automaticamente desbloqueado.\n2. Cada desafio consome 120 pontos de neuropéptideo, ao vencer o desafio você receberá moedas de evento.\n3. Após concluir um estágio, será desbloqueada a função \"Recriar\" deste estágio. Por favor, note: ao usar a função \"Recriar\" não será possível ganhar taxa de sincronização.\n4. Você pode usar o apoio dos Alumni para ajudá-lo a passar de fase mais facilmente.\n\n<Title:Bonus de Pensamento>\n1. Quando o guardião possuir Corpos Despertados ou Rodas do destino específicas(não é necessário colocá-las em batalha), poderá obter bônus adicional de moedas nas recompensas das fases de \"Olhar do Mar Profundo\", conforme a seguir:\nCorpo Desperto \"Tulu\": Despertar Espiritual 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%.\nRoda do destino SSR \"Hino do Soberano\": Pilhas 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%.\nRoda do destino SR \"Trono de Pedra Verde\": Pilhas 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%.\n2. Os \"Bônus de Pensamento\" de diferentes Corpos Despertados ou Rodas do destino são acumulativos.\n3. Especialmente, as recompensas da primeira conclusão em dificuldade Loucura não são afetadas pelos \"Bônus de Pensamento\".\n\n<Title:Abismo do mar da percepção>\n1.\"Abismo do mar da percepção\" estará disponível apenas entre 30 de dezembro 9:00 - 20 de janeiro 9:00(GMT+8).\n2. Após 20 de janeiro 9:00(GMT+8), os \"Pensamentos cansados\",\"Pensamentos Tristes\",\"Pensamentos Alegres\" não resgatados serão recolhidos de acordo com a proporção de cada \"Cupom de ouro rosa *40\", por favor, os guardiões fiquem atentos para verificar os e-mails."
  },
  Activity_71100_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_71101_ActivityName = {
    Text = "Texto temporário"
  },
  Activity_71101_ActivityPlot = {
    Text = "Texto temporário"
  },
  Activity_71101_ActivityStageEndContent = {
    Text = "Evento encerrado, apenas disponível para \"Texto Temporário\""
  },
  Activity_71101_ActivityTips = {
    Text = "<Title:Resumo do Evento>\nTexto Temporário"
  },
  Activity_71101_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_71102_ActivityName = {
    Text = "A magia da história · Recriação"
  },
  Activity_71102_ActivityPlot = {
    Text = "As tarefas atribuídas por Boneca nunca são simples. \nMesmo com várias lembranças para todos se \"divertirem\", como os guardiões poderiam não ficar assustados ao levar um grupo de despertadores pela primeira vez? \nMas, não se esqueça de \"divertir-se\""
  },
  Activity_71102_ActivityStageEndContent = {
    Text = "O evento terminou, atualmente só é possível participar da\"Loja de script mágico\""
  },
  Activity_71102_ActivityTips = {
    Text = "<Title:Visão Geral do Evento>\n1. O evento de jogabilidade \"A Magia da História\" está de volta por tempo limitado! Guardiões do segredo podem acessar a \"Loja de roteiros mágicos\" e \"Recompensas de Conquista\" para obter a Roda do destino exclusiva do evento \"Mágica 35mm\" e o avatar exclusivo do evento \"Por nome da Chave de Prata: Lily\" mais uma vez!\n2. Durante o evento, \"Operação Especial: A Magia da História\" estará disponível para acesso gratuito por tempo limitado.\n\n<Title:Período do Evento>\n1. De 3 de junho, 9:00 a 17 de junho, 9:00 (GMT+8), todo o conteúdo na introdução do evento pode ser participado.\n2. De 17 de junho, 9:00 a 24 de junho, 9:00 (GMT+8), apenas a \"Loja de roteiros mágicos\" e as \"Recompensas de Conquista\" permanecerão acessíveis; outros conteúdos terão sido encerrados e não poderão ser participados.\n\n<Title:Misterio do Roteiro>\n1. \"Misterio do roteiro\" consiste em 9 fases de material, com uma fase sendo desbloqueada automaticamente a cada dia. Após o desbloqueio, você deve concluir a fase de Operação Especial anterior para desafiá-la.\n2. Cada desafio consome 60 pontos de Lingfétide. Desafios bem-sucedidos recompensam você com a moeda do evento \"Inspiração Errante\" e materiais de cultivo. Concluir as fases de material neste evento suporta reencenação.\n3. Você pode usar o apoio de Alumni e \"Resonância: Valor de Fase do Diretor\" para ajudar a concluir as fases mais facilmente.\n\n<Title:Bônus de Inspiração>\n1. Guardiões do segredo com Corpos Despertos ou Rodas do destino específicos (não é necessário estar na Formação) ganham bônus adicionais de drop de \"Inspiração Errante\" nas recompensas de tarefa de \"Misterio do roteiro\" (incluindo reencenação). Os bônus específicos são os seguintes:\nCorpo Desperto \"Lily\": Despertar Espiritual 0/1/2/3 e acima, bônus 20%/30%/40%/50%\nRoda do destino SSR \"Graça Através da Dor\": Empilhamento 0/1/2/3 e acima, bônus 20%/30%/40%/50%\nRoda do destino SR \"Mágica 35mm\": Empilhamento 0/1/2/3 e acima, bônus 20%/30%/40%/50%\n2. Os \"Bônus de Inspiração\" de diferentes Corpos Despertos ou Rodas do destino são acumuláveis.\n\n<Title:Resonância: Valor de Fase do Diretor>\n1. Guardiões do segredo podem adquirir \"Coração da interpretação\" ao completar conquistas do evento.\n2. Consumir \"Coração da interpretação\" para ativar \"Resonância: Valor de Fase do Diretor\" torna os Guardiões do segredo mais fortes na jogabilidade do evento \"Misterio do roteiro\" e \"Operação Especial: A Magia da História,\" e aprimora as recompensas de \"Inspiração Errante\" e Taxa de Sincronização obtidas após concluir desafios de \"Misterio do roteiro\".\n\n<Title:Recompensas de Conquista>\n1. Completar tarefas de conquista concede o avatar exclusivo do evento \"Por nome da Chave de Prata: Lily,\" moeda do evento \"Inspiração Errante,\" e Núcleo de prata.\n2. Inclui 25 tarefas: concluir cada fase de \"Misterio do roteiro\" uma vez, usar cada equipe de Domínio para concluir \"Misterio do roteiro\" 1/2 vezes, concluir cada evento de investigação em \"Operação Especial: A Magia da História\" uma vez, e completar todas as conquistas do evento.\n\n<Title:Operação Especial>\n1. Durante o evento, \"Operação Especial: A Magia da História\" pode ser desbloqueada gratuitamente.\n2. Em \"Operação Especial: A Magia da História,\" os Guardiões do segredo desafiarão usando uma configuração de equipe especial que inclui o preset de história \"Lily.\"\n\n<Title:Compensação de Ressurreição>\n1. Guardiões do segredo que desbloquearam anteriormente \"Operação Especial: A Magia da História\" receberão uma compensação de \"Inspiração Errante\" *1000 ao desbloquear novamente durante este evento de ressurreição.\nGuardiões do segredo que obtiveram anteriormente o avatar exclusivo do evento \"Por nome da Chave de Prata: Lily\" terão quaisquer recompensas repetidas automaticamente convertidas em \"Inspiração Errante\" *3000.\nGuardiões do segredo que obtiveram anteriormente o material de ativação de Resonância \"Coração da interpretação\" terão cada \"Coração da interpretação\" adicional obtido automaticamente convertido em \"Cupom de ouro rosa\" *5000.\n"
  },
  Activity_71102_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_71325_ActivityName = {
    Text = "Poema Sem Nome"
  },
  Activity_71325_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento \"Poema Sem Nome\", os Guardiões podem usar equipes presetadas pelo sistema que incluem Horla para experimentar níveis designados infinitamente.\n·Enquanto experimenta os níveis do evento, ajustes nos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_71329_ActivityName = {
    Text = "Florescer de Lodo"
  },
  Activity_71329_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento \"Flor do Lodo\", os Guardiões podem usar equipes presetadas pelo sistema que incluem Lily para experimentar níveis designados infinitamente.\n·Ao jogar os níveis do evento, ajustes nos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_71743_ActivityName = {
    Text = "Caçadora de crânios"
  },
  Activity_71743_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento \"Caçadora de Cranios\", os Guardiões podem usar equipes presetadas pelo sistema que incluem Narciso para experimentar níveis designados infinitamente.\n·Ao experimentar os níveis do evento, ajustes nos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_71744_ActivityName = {
    Text = "Bishop de bálsamos"
  },
  Activity_71744_ActivityTips = {
    Text = "<Title:Regras da Atividade>\n·Durante o evento \"Bispo Benevolente\", os Guardiães podem usar equipes pré-definidas pelo sistema contendo Salvador para experimentar níveis designados um número ilimitado de vezes.\n·Ao jogar os níveis do evento, ajustes no Despertar do alinhamento da equipe não podem ser feitos.\n<Title:Recompensas da Atividade>\n·Após completar com sucesso um desafio de nível pela primeira vez, você pode reivindicar recompensas de teste na interface do evento."
  },
  Activity_71745_ActivityName = {
    Text = "Senhora de vermelho"
  },
  Activity_71745_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento \"Dama Vermelha\", os Guardiões podem usar equipes presetadas pelo sistema que incluem Sorel para experimentar níveis designados infinitamente.\n·Ao experimentar os níveis do evento, ajustes nos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_71746_ActivityName = {
    Text = "Senhora das profundezas"
  },
  Activity_71746_ActivityTips = {
    Text = "<Title:Regras do Evento>\n· Durante o evento \"Senhorita Aequor\", os Guardiães podem usar equipes pré-definidas pelo sistema que incluam Murphy para experimentar níveis designados infinitamente.\n· Durante a experiência do nível do evento, ajustes aos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n· Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_71747_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_71956_ActivityName = {
    Text = "Presente de Promoção X"
  },
  Activity_71956_ActivityPlot = {
    Text = "O caminho se estende longo, envolto na escuridão da Fusão.\nA luz da Chave de prata nos guiará a todos."
  },
  Activity_71957_ActivityName = {
    Text = "Homenagem à reflexão da jornada IX"
  },
  Activity_71957_ActivityPlot = {
    Text = "O caminho se estende longo, envolto na escuridão da Fusão.\nA luz da Chave de prata nos guiará a todos."
  },
  Activity_71982_ActivityName = {
    Text = "Presente da Ressonância Espiritual"
  },
  Activity_71982_ActivityPlot = {
    Text = "Você chega ao escritório do diretor, apenas para descoberta de que a sala está vazia. Parece que a carta era apenas uma brincadeira.\nAssim que você está prestes a sair, vislumbra uma caixa de presente requintada no canto da sua visão, com um bilhete anexado — Para meu amado."
  },
  Activity_71983_ActivityName = {
    Text = "Espiando o Presente do Destino"
  },
  Activity_71983_ActivityPlot = {
    Text = "Um som de clique ecoa pela sala silenciosa. Quando você se aproxima para investigar, a janela aberta revela que o \"Visitante indesejado\" já partiu.\nA luz quente do sol incide sobre uma caixa de presente extra na mesa, sua caligrafia elegante brilhando com luz prateada — Que o Destino eternamente abençoe você."
  },
  Activity_72101_ActivityName = {
    Text = "Reversão de Fase"
  },
  Activity_72101_ActivityPlot = {
    Text = "\"Vou fazer com que todas as pessoas joguem Carta do Curso do Mundo!\"\nUm visitante de outras dimensões entrou acidentalmente no espaço de duelos da Traphase e o transformou em algo completamente diferente do original.\nPara reverter novamente o espaço, guardiões de diferentes dimensões decidirão quem é o mais forte e lançarão um desafio a esse visitante."
  },
  Activity_72101_ActivityTips = {
    Text = "<Title:Descrição do Evento>\n1. Durante o evento, os Guardiões do Segredo poderão completar conquistas em \"Recompensas por Conquistas\" participando de \"Confronto de Fases\" e coletar \"Bolotas Mágicas\".\n2. As \"Bolotas Mágicas\" podem ser usadas em \"Recompensa por Rodada\" para obter recompensas especiais, incluindo o avatar limitado \"Rodada Invertida: Cartas Cósmicas\", 10 emoticons exclusivos do evento e itens como \"Sonho Restante Fragmentado\" e \"Sonho Restante das Estrelas\".\n3. Durante o evento, \"Conexão Multidimensional: Rodada Invertida\" estará disponível gratuitamente!\n4. Durante o evento, os Guardiões do Segredo que completarem \"Conexão Multidimensional: Rodada Invertida: Visitante de Outro Mundo\" terão o cenário de batalha de \"Confronto de Fases\" substituído temporariamente por \"Rodada Invertida: Espaço de Consciência\".\n\n<Title:Recompensas por Conquistas>\n1. As \"Recompensas por Conquistas\" incluem conquistas de vitória com \"Corpo de Despertar\", conquistas de vitória com \"Roda do Destino\", conquistas de vitória com \"Selo de Chave\" e conquistas de quantidade de cartas jogadas. Os Guardiões do Segredo poderão coletar \"Bolotas Mágicas\" ao completar as conquistas.\n2. Em \"Confronto de Fases\", ao usar \"Corpo de Despertar\" de diferentes classes e jogar 25 cartas com cada classe, você receberá 30 \"Bolotas Mágicas\". Cada conquista de \"jogar cartas\" por classe pode ser completada no máximo 80 vezes.\n3. Conquista \"Corpo de Despertar\": Ao completar 1/3/6/10 vitórias com cada \"Corpo de Despertar\" em \"Confronto de Fases\", você receberá 10 \"Bolotas Mágicas\".\n4. Conquista \"Roda do Destino\": Ao completar 1/3/6 vitórias com cada \"Roda do Destino\" em \"Confronto de Fases\", você receberá 10 \"Bolotas Mágicas\".\n5. Conquista \"Selo de Chave\": Ao completar 1/3/6 vitórias com cada \"Selo de Chave\" em \"Confronto de Fases\", você receberá 10 \"Bolotas Mágicas\".\n6. Os \"Corpo de Despertar\", \"Roda do Destino\" e \"Selo de Chave\" desbloqueados temporariamente como parte de missões principais contarão normalmente para o número de vitórias e cartas jogadas, mas as recompensas por conquistas só poderão ser coletadas após obter os respectivos \"Corpo de Despertar\", \"Roda do Destino\" e \"Selo de Chave\".\n\n<Title:Recompensa por Rodada>\n1. Os Guardiões do Segredo poderão coletar recompensas acumulando \"Bolotas Mágicas\". Ao acumular 2500 \"Bolotas Mágicas\", você receberá todas as recompensas principais. Ao acumular 5000 \"Bolotas Mágicas\", você receberá todas as recompensas disponíveis!\n2. Após completar \"Rodada Invertida: Visitante de Outro Mundo\", serão desbloqueadas as recompensas por acumular de 100 a 900 \"Bolotas Mágicas\". Após completar \"Rodada Invertida: O Instante Cósmico Invertido\", serão desbloqueadas as recompensas por acumular de 1000 a 5000 \"Bolotas Mágicas\".\n\n<Title:Conexão Multidimensional>\n1. Durante o evento, \"Conexão Multidimensional: Rodada Invertida\" estará disponível gratuitamente.\n2. Durante o evento, será necessário acumular 1000 \"Bolotas Mágicas\" para desbloquear \"Rodada Invertida: A Absoluta que Persiste\".\n3. Após o término do evento, o progresso em \"Conexão Multidimensional: Rodada Invertida\" será mantido. Caso não tenha desbloqueado \"Conexão Multidimensional: Rodada Invertida\" durante o evento, você ainda poderá desbloqueá-la após o evento consumindo 3 \"Ponto de Partida Real\".\n4. Independentemente de estar durante o evento ou não, ao completar \"Conexão Multidimensional: Rodada Invertida\", você poderá obter \"Selo de Chave: Porta da Taverna\".\n\n<Title:Datas do Evento>\nEste evento estará disponível apenas das 9:00 do dia 18 de março às 9:00 do dia 1º de abril (GMT+8). Após as 9:00 do dia 1º de abril (GMT+8), o evento terminará. Lembre-se de coletar as recompensas em \"Recompensa por Rodada\"!"
  },
  Activity_72101_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_72101_UnlockConditionExplanation = {
    Text = "Desbloqueado após completar \"Operação de Investigação\" 3-2 · Normal"
  },
  Activity_73680_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_73680_ActivityPlot = {
    Text = "Após a compra, \"Fusão·Dora\" pode ativar\n<BlueQuality:aprofundamento da personalidade +4, desbloquear superexaltação>"
  },
  Activity_73681_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_73681_ActivityPlot = {
    Text = "Após a compra, \"Derretimento·Dora\" pode ativar <BlueQuality:iluminar 3>"
  },
  Activity_73879_ActivityName = {
    Text = "Alinhamento das Estrelas · Reproduzido"
  },
  Activity_73879_ActivityPlot = {
    Text = "O Momento da Posição Normal se aproxima, o Movimento fetal em seu interior pulsa como um tambor.\nOs pesadelos de escuridão que a atormentaram por anos culminam em um final que leva incontáveis Crentes às lágrimas.\nDe Sua@1 escuridão @2, o grande @3 chega ao mundo."
  },
  Activity_73879_ActivityStageEndContent = {
    Text = "O evento foi Concluído. Atualmente, apenas \"Eclosão do embrião sagrado\" está disponível."
  },
  Activity_73879_ActivityTips = {
    Text = "<Title:Descrição do evento>\n1. Durante o evento, o Guardião pode coletar três tipos de \"embriões\" através da jogatina limitada \"Útero das Trevas\" e das \"Recompensas de Conquistas\". Os \"embriões\" podem ser trocados por recompensas de itens na \"Incução do Embrião Sagrado\", incluindo a Roda do destino SR exclusiva do evento \"Sono sob os Glaciares\", Núcleo Imaculado, Núcleo de Lumen, Fragmentos de Pedra Sábia, Cristal de Mimese, entre outros.\n2. Durante o evento, completar as tarefas das \"Recompensas de Conquistas\" permitirá obter o avatar exclusivo do evento \"Em Nome da Chave de Prata: Murphy\", a Roda do destino SR exclusiva do evento \"Sono sob os Glaciares\" e uma grande quantidade de \"embriões\".\n\n<Title:Período do evento>\n1. De 10 de março às 9:00 até 24 de março às 9:00 (GMT+8), todos os conteúdos do evento estarão disponíveis.\n2. De 24 de março às 9:00 até 31 de março às 9:00 (GMT+8), apenas \"Incução do Embrião Sagrado\" e \"Recompensas de Conquistas\" permanecerão, os demais conteúdos estarão encerrados e indisponíveis.\n\n<Title:Útero das Trevas>\n1. \"Útero das Trevas\" contém 7 estágios, sendo liberado automaticamente 1 por dia.\n2. Cada desafio consome 120 pontos de encefalina, e ao vencer, você receberá a moeda do evento \"Embrião da Ignorância\", \"Embrião da Abstinência\" e \"Embrião da Ganância\".\n3. Após completar um estágio, será desbloqueada a função \"Recriação\" desse estágio. Por favor, note: ao usar a função \"Recriação\", não será possível obter taxa de sincronização.\n4. Você pode usar o apoio da Alumni para facilitar a passagem do estágio.\n5. Após completar qualquer dificuldade do estágio, será desbloqueada a dificuldade Loucura. Completar pela primeira vez a dificuldade Loucura permitirá obter uma recompensa generosa em moeda do evento.\n6. Por favor, note: a dificuldade Loucura não consome encefalina, não pode ser recriada e após a primeira conclusão, repetir o desafio não dará mais recompensas em moeda do evento.\n\n<Title:Bônus de Embriões>\n1. Se o Guardião possuir Corpos Despertos específicos ou Rodas do destino (não é necessário colocá-los em combate), poderá obter bônus adicionais na quantidade de \"Embrião da Ignorância\", \"Embrião da Abstinência\" e \"Embrião da Ganância\" obtidos nas recompensas das missões dos estágios de \"Útero das Trevas\" (incluindo recriação). Os bônus específicos são os seguintes:\nCorpo Desperto \"Murphy\": com Despertar Espiritual 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\nRoda do destino SSR \"Nascimento Oculto\": com empilhamento 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\nRoda do destino SR \"Sono sob os Glaciares\": com empilhamento 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\n2. Os bônus de embriões de Corpos Despertos ou Rodas do destino diferentes são acumulativos.\n3. Especialmente, as recompensas da primeira conclusão dos desafios na dificuldade Loucura não são afetadas pelo \"Bônus de Embriões\".\n\n<Title:Incução do Embrião Sagrado>\n1. \"Incução do Embrião Sagrado\" estará disponível apenas de 10 de março às 9:00 até 31 de março às 9:00 (GMT+8).\n2. Após as 9:00 de 31 de março (GMT+8), os \"embriões\" restantes que não forem trocados serão reciclados e convertidos em \"Voucher de Cupom de ouro rosa*40\" cada um. Por favor, lembre-se de verificar seu e-mail para receber a recompensa."
  },
  Activity_73879_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_74213_ActivityName = {
    Text = "Homenagem à Jornada · Crônica das Estrelas I"
  },
  Activity_74213_ActivityPlot = {
    Text = "Um pedaço de memória selado e arquivado, uma jornada registrada no passado. Em momentos de lembrança, não se esqueça de oferecer sua reverente Visita."
  },
  Activity_74340_ActivityName = {
    Text = "Turno inverso"
  },
  Activity_74364_ActivityName = {
    Text = "Manual do Detetive·Recuperação"
  },
  Activity_74364_ActivityPlot = {
    Text = "Um manual comum.\nRegistra as experiências de um detetive ao longo dos anos.\nEsperamos que inspire jovens aspirantes a detetive"
  },
  Activity_74364_ActivityStageEndContent = {
    Text = "O evento terminou. Atualmente, apenas \"Clube da Boa Sorte\" está disponível."
  },
  Activity_74364_ActivityTips = {
    Text = "<Title:Breve introdução do evento>\n1. Durante o evento, os Guardiões do Segredo poderão coletar a moeda do evento \"Ficha decisiva\" através das atividades limitadas \"Lenda da noite lunar\" e \"Recompensas por conquistas\". As \"Fichas decisivas\" poderão ser trocadas por recompensas generosas no \"Clube da Sorte\", incluindo a Roda do Destino SR exclusiva do evento \"Roleta do Destino\", Núcleo Imaculado, Núcleo de Lumen, Fragmentos de Pedra Sábia, Cristal de Mimese e outros itens.\n2. Durante o evento, ao completar as tarefas em \"Recompensas por conquistas\", você poderá obter o avatar exclusivo do evento \"Em nome da Chave de prata: Ryker\", a Roda do Destino SR exclusiva do evento \"Roleta do Destino\", Núcleo de prata e uma grande quantidade da moeda do evento \"Ficha decisiva\".\n3. Durante o evento, o \"Registro Especial: Boa caça!\" estará disponível gratuitamente.\n\n<Title:Data do evento>\n1. De 22 de setembro às 9:00 até 6 de outubro às 9:00 (GMT+8), todos os conteúdos do evento estarão disponíveis.\n2. De 6 de outubro às 9:00 até 13 de outubro às 9:00 (GMT+8), apenas \"Clube da Sorte\" e \"Recompensas por conquistas\" permanecerão, os demais conteúdos estarão encerrados e indisponíveis.\n\n<Title:Lenda da noite lunar>\n1. \"Lenda da noite lunar\" contém 9 estágios, sendo liberado 1 estágio automaticamente por dia.\n2. Cada desafio consome 120 pontos de Menophin. Ao desafiar diferentes estágios, além de obter diferentes materiais, também concederá a moeda do evento \"Ficha decisiva\".\n3. Os estágios desta atividade são missões de combate direto, e após completá-los, poderão ser refeitos! Cada \"repetição\" consome 120 pontos de Menophin.\n4. Atenção: Ao usar a função \"repetição\", não será possível obter taxa de sincronização.\n\n<Title:Bônus de fichas>\n1. Os Guardiões do Segredo que possuírem Corpos Despertos ou Rodas do Destino específicos (não é necessário utilizá-los na batalha) poderão obter bônus adicionais de \"Ficha decisiva\" nas recompensas das missões dos estágios de \"Lenda da noite lunar\" (incluindo repetições). Os bônus específicos são os seguintes:\nCorpo Desperto \"Ryker\": Despertar Espiritual 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\nRoda do Destino SSR \"Hora da Fortuna\": Nível de empilhamento 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\nRoda do Destino SR \"Roleta do Destino\": Nível de empilhamento 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\n2. Os bônus de \"bônus de fichas\" de diferentes Corpos Despertos ou Rodas do Destino são acumulativos.\n3. Especialmente, as recompensas da primeira conclusão em dificuldade de loucura não serão afetadas pelo \"bônus de fichas\".\n\n<Title:Clube da Sorte>\n1. \"Clube da Sorte\" estará disponível apenas entre 22 de setembro às 9:00 e 13 de outubro às 9:00 (GMT+8).\n2. Após as 9:00 de 13 de outubro (GMT+8), as \"Fichas decisivas\" restantes que não forem trocadas serão recicladas na proporção de cada ficha convertida em \"Cupom de ouro rosa ×40\", por favor, os Guardiões do Segredo fiquem atentos para verificar no e-mail.\n\n<Title:Registro Especial>\n1. Durante o evento, o \"Registro Especial: Boa caça!\" estará disponível gratuitamente.\n2. Após o término do evento, o progresso do \"Registro Especial: Boa caça!\" será mantido. Caso não tenha sido desbloqueado durante o evento, ainda será possível desbloqueá-lo após o término consumindo \"Ponto de partida real\" ×7.\n3. Independentemente de estar no período do evento ou não, ao concluir o \"Registro Especial: Boa caça!\" você poderá obter \"Chave: Um tiro\".\n\n<Title:Compensação por reedição>\n1. Os Guardiões do Segredo que já desbloquearam anteriormente o \"Registro Especial: Boa caça!\" receberão uma compensação de \"Fichas decisivas\" ×700 ao desbloqueá-lo novamente durante esta reedição.\n2. Os Guardiões do Segredo que já possuírem o avatar exclusivo do evento \"Em nome da Chave de prata: Ryker\" e o receberem novamente terão automaticamente convertido em \"Convite do Incorpóreo\" ×1."
  },
  Activity_74364_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_74365_ActivityName = {Text = "Boa caça!"},
  Activity_76217_ActivityName = {
    Text = "Viagem para uma Era Alternativa"
  },
  Activity_76217_ActivityTips = {
    Text = "Regras do evento: \n1. Após completar as missões designadas da jornada, os Guardiões do Segredo podem coletar recompensas em \"Viagem para uma Era Alternativa\". \n2. \"Viagem para uma Era Alternativa\" está permanentemente disponível. \n3. Após desbloquear a \"Jornada Avançada\", é possível coletar recompensas adicionais ao completar missões. \n4. Atenção: A \"Jornada Avançada\" desbloqueada neste evento só é válida durante este evento. Peça aos Guardiões do Segredo que consumam com moderação e racionalidade."
  },
  Activity_76218_ActivityName = {
    Text = "Crônica da Chegada"
  },
  Activity_76218_ActivityTips = {
    Text = "Regras do evento:\n1. Após completar as missões especificadas na \"Crônica da Chegada\", os Guardiões do Segredo podem coletar recompensas em \"Crônica da Chegada\".\n2. \"Crônica da Chegada\" está permanentemente disponível.\n3. Após desbloquear a \"Crônica Avançada\", é possível coletar recompensas adicionais ao completar missões.\n4. Atenção: A \"Crônica Avançada\" desbloqueada neste evento só é válida durante este evento. Os Guardiões do Segredo devem consumir com moderação e racionalidade."
  },
  Activity_77970_ActivityName = {Text = "Pólux"},
  Activity_77970_ActivityTips = {
    Text = "<Title:Regras do evento>\n· Durante o evento \"Pólux\", os Guardiões do Segredo podem usar equipes predefinidas pelo sistema que incluam Pólux para experimentar ilimitadamente as fases designadas.\n· Ao experimentar as fases do evento, não é possível ajustar os Corpos Despertados na formação da equipe.\n<Title:Recompensas do evento>\n· Após completar o desafio da fase pela primeira vez, é possível coletar a recompensa de teste na interface do evento.\n"
  },
  Activity_77972_ActivityName = {
    Text = "Shaggai hipnótico"
  },
  Activity_77972_ActivityTips = {
    Text = "<Title:Regras do evento>\n· Durante o evento \"Inseto Hipnótico\", o Guardião poderá utilizar equipes predefinidas pelo sistema contendo Clemantine para experimentar infinitamente as fases designadas.\n· Ao experimentar as fases do evento, não será possível ajustar os Corpos Despertados na equipe.\n<Title:Recompensas do evento>\n· Após completar o desafio da fase pela primeira vez, será possível receber as recompensas de teste na interface do evento.\n"
  },
  Activity_77974_ActivityName = {
    Text = "Brilho de Mareel"
  },
  Activity_77974_ActivityTips = {
    Text = "<Title:Regras do evento>\n· Durante o evento \"Luz Fria\", os Guardiões poderão usar equipes predefinidas pelo sistema contendo Kepeshiant para experimentar ilimitadamente as fases designadas.\n· Durante a experiência nas fases do evento, não será possível ajustar os Corpos Despertados na formação.\n<Title:Recompensas do evento>\n· Após completar o desafio da fase pela primeira vez, será possível coletar recompensas de teste na interface do evento."
  },
  Activity_77977_ActivityName = {
    Text = "Branca de Neve, a Fada"
  },
  Activity_77977_ActivityTips = {
    Text = "<Title:Regras do Evento>\nDurante o evento \"Branca de Neve a Fada\", os Guardiões do segredo podem usar formações predefinidas pelo sistema que incluem \"Caraboo\" para experienciar fases designadas um número ilimitado de vezes.\n Ao experienciar as fases do evento, os Corpos Despertos na formação não podem ser ajustados.\n<Title:Recompensas do Evento>\nApós completar o desafio da fase pela primeira vez, você pode reivindicar as recompensas de teste na interface do evento."
  },
  Activity_77979_ActivityName = {
    Text = "Mestre da Explosão"
  },
  Activity_77979_ActivityTips = {
    Text = "<Title:Regras do evento>\n· Durante o evento \"Senhor da Explosão\", o Guardião pode usar equipes predefinidas pelo sistema contendo Kittygra para jogar repetidamente as fases designadas.\n· Ao participar das fases do evento, não é possível ajustar os Corpos Despertados na equipe.\n<Title:Recompensas do evento>\n· Após completar o desafio da fase pela primeira vez, é possível coletar a recompensa de teste na interface do evento."
  },
  Activity_77980_ActivityName = {
    Text = "Teia Eterna"
  },
  Activity_77980_ActivityTips = {
    Text = "<Title:Regras do evento>\nDurante o evento \"Tela Perpetua\", os Guardiões podem usar equipes predefinidas pelo sistema contendo Arachne para experimentar ilimitadamente as fases designadas.\nAo experimentar as fases do evento, não é possível ajustar os Corpos Despertados dentro da equipe.\n<Title:Recompensas do evento>\nApós completar o desafio da fase pela primeira vez, é possível coletar recompensas de teste na interface do evento."
  },
  Activity_77984_ActivityName = {Text = "O pintor"},
  Activity_77984_ActivityTips = {
    Text = "<Title:Regras do Evento>\n· Durante o evento \"Pintor\", os Guardiões do Segredo podem usar equipes pré-definidas que incluem o Pikman para experimentar níveis designados sem limite. \n· Ao experimentar os níveis do evento, não é possível ajustar os Despertados na formação. \n<Title:Recompensas do Evento>\n· Após completar o desafio do nível pela primeira vez, você pode coletar recompensas de teste na interface do evento."
  },
  Activity_78501_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_78501_ActivityPlot = {
    Text = "Após a compra, \"Faraó Negro\" pode ativar\n<BlueQuality:aprofundamento da personalidade +4, desbloquear superexaltação>"
  },
  Activity_78502_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_78502_ActivityPlot = {
    Text = "Após a compra, \"Aracne\" pode ativar\n<BlueQuality: aprofundamento da personalidade +4, desbloquear superexaltação>"
  },
  Activity_78503_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_78503_ActivityPlot = {
    Text = "Após a compra, \"Kepsante\" pode ativar <BlueQuality:iluminar 3>"
  },
  Activity_78505_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_78505_ActivityPlot = {
    Text = "Após a compra, \"Clementine\" pode ativar\n<BlueQuality:Aprofundamento de Personalidade +4, Desbloquear Super-Exaltação>"
  },
  Activity_78506_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_78506_ActivityPlot = {
    Text = "Após a compra, \"Faraó Negro\" pode ativar <BlueQuality:iluminar 3>"
  },
  Activity_78507_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_78507_ActivityPlot = {
    Text = "Após a compra, \"Abutre\" pode ativar <BlueQuality:iluminar 3>"
  },
  Activity_78508_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_78508_ActivityPlot = {
    Text = "Após a compra, \"Afogamon\" pode ativar <BlueQuality:iluminar 3>"
  },
  Activity_78509_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_78509_ActivityPlot = {
    Text = "Após a compra, \"Pólux\" pode ativar <BlueQuality:iluminar 3>"
  },
  Activity_78511_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_78511_ActivityPlot = {
    Text = "Após a compra, \"Karabu\" pode ativar\n<BlueQuality:aprofundamento da personalidade +4, desbloquear superexaltação>"
  },
  Activity_78513_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_78513_ActivityPlot = {
    Text = "Após a compra, \"Aracne\" pode ativar <BlueQuality:iluminar 3>"
  },
  Activity_78514_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_78514_ActivityPlot = {
    Text = "Após a compra, \"Pickman\" pode ativar <BlueQuality:iluminar 3>"
  },
  Activity_78515_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_78515_ActivityPlot = {
    Text = "Após a compra, \"Pickman\" pode ativar\n<BlueQuality:aprofundamento da personalidade +4, desbloquear superexaltação>"
  },
  Activity_78516_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_78516_ActivityPlot = {
    Text = "Após a compra, \"Clementine\" pode ativar <BlueQuality:iluminar 3>"
  },
  Activity_78517_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_78517_ActivityPlot = {
    Text = "Após a compra, \"Kepsante\" pode ativar\n<BlueQuality:aprofundamento da personalidade +4, desbloquear superexaltação>"
  },
  Activity_78518_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_78518_ActivityPlot = {
    Text = "Após a compra, \"Abutre\" pode ativar\n<BlueQuality:aprofundamento da personalidade +4, desbloquear superexaltação>"
  },
  Activity_78519_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_78519_ActivityPlot = {
    Text = "Após a compra, \"Shartak\" pode ativar\n<BlueQuality:aprofundamento da personalidade +4, desbloquear superexaltação>"
  },
  Activity_78521_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_78521_ActivityPlot = {
    Text = "Após a compra, \"Pólux\" pode ser ativado\n<BlueQuality:aprofundamento da personalidade +4, desbloquear superexaltação>"
  },
  Activity_78523_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_78523_ActivityPlot = {
    Text = "Após a compra, \"Afogamon\" pode ativar\n<BlueQuality: aprofundamento da personalidade +4, desbloquear superexaltação>"
  },
  Activity_78524_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_78524_ActivityPlot = {
    Text = "Após a compra, \"Lantigos\" pode ser ativado\n<BlueQuality:aprofundamento da personalidade +4, desbloquear superexaltação>"
  },
  Activity_78525_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_78525_ActivityPlot = {
    Text = "Após a compra, \"Castor\" pode ativar\n<BlueQuality:Aprofundamento de Personalidade +4, Desbloquear Super-Exaltação>"
  },
  Activity_78526_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_78526_ActivityPlot = {
    Text = "Após a compra, \"Katygra\" pode ativar <BlueQuality:iluminar 3>"
  },
  Activity_78531_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_78531_ActivityPlot = {
    Text = "Após a compra, \"Shathak\" pode ativar <BlueQuality:iluminar 3>"
  },
  Activity_78532_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_78532_ActivityPlot = {
    Text = "Após a compra, \"Karabu\" pode ativar <BlueQuality:iluminar 3>"
  },
  Activity_78533_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_78533_ActivityPlot = {
    Text = "Após a compra, \"Castor\" pode ativar <BlueQuality:iluminar 3>"
  },
  Activity_78534_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_78534_ActivityPlot = {
    Text = "Após a compra, \"Lantigos\" pode ativar <BlueQuality:iluminar 3>"
  },
  Activity_78536_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_78536_ActivityPlot = {
    Text = "Após a compra, \"Catigura\" pode ativar\n<BlueQuality:aprofundamento da personalidade +4, desbloquear superexaltação>"
  },
  Activity_78651_ActivityName = {
    Text = "Fissão Tranquila"
  },
  Activity_78652_ActivityName = {
    Text = "Cura múltipla: Réplica"
  },
  Activity_78652_ActivityPlot = {
    Text = "Histeria. Chame de mania, chame de destruição da mente; nesta era, o diagnóstico é uma sentença de morte. Felizmente, os cientistas e investigadores da Misaq são possuídos por uma loucura própria: estão determinados a conquistar esse terror."
  },
  Activity_78652_ActivityStageEndContent = {
    Text = "O evento terminou. Atualmente, apenas \"Análise de Personalidade\" está disponível."
  },
  Activity_78652_ActivityTips = {
    Text = "<Title:Descrição do evento>\n1. Durante o evento, o Guardião do Segredo poderá coletar a moeda do evento \"Quebra-Cabeça da Memória\" através das atividades limitadas \"Codificação de Memória\", \"Armazenamento de Borda\" e \"Recompensas por Conquista\". Os \"Quebra-Cabeça da Memória\" podem ser usados para comprar itens na \"Análise de Personalidade\", incluindo a Roda do destino SR exclusiva do evento \"Determinação do Bacalhau Prateado\", Núcleo Imaculado e Núcleo de Lumen, entre outros.\n2. Durante o evento, o \"Registro de Operações: Fissão Tranquila\" estará disponível gratuitamente por tempo limitado. Completar os logros do evento também permitirá obter o avatar exclusivo do evento \"Em Nome da Chave de prata: '24'\".\n\n<Title:Período do evento>\n1. 21 de abril 9:00 - 5 de maio 9:00 (GMT+8), todas as atividades do evento estarão disponíveis.\n2. 5 de maio 9:00 - 12 de maio 9:00 (GMT+8), apenas a \"Análise de Personalidade\" e as recompensas por conquista estarão disponíveis.\n\n<Title:Codificação de Memória>\n1. \"Codificação de Memória\" contém 5 estágios, cada um será aberto automaticamente a cada 2 dias.\n2. Cada tentativa consome 120 pontos de Phez, e ao ter sucesso na tentativa, você receberá moedas do evento.\n3. Após concluir um estágio, será desbloqueada a função \"Recriar\" deste estágio. Por favor, note: ao usar a função \"Recriar\", não será possível obter taxa de sincronização.\n4. Você pode usar o apoio da Alumni e a \"Ressonância: Síndrome de Separação\" para ajudá-lo a passar de fase mais facilmente.\n\n<Title:Bonificação Racional>\n1. Se o Guardião do Segredo possuir um Corpo Desperto ou uma Roda do destino específicos (não é necessário estar em combate), poderá obter uma bonificação adicional de queda de \"Quebra-Cabeça da Memória\" nas recompensas das missões dos estágios de \"Codificação de Memória\", conforme descrito a seguir:\nCorpo Desperto \"24\": Despertar Espiritual 0/1/2/3 ou superior, bonificação de 20%/30%/40%/50%.\nRoda do destino SSR \"Restituição do corpo deformado\": Nível de empilhamento 0/1/2/3 ou superior, bonificação de 20%/30%/40%/50%.\nRoda do destino SR \"Determinação do Bacalhau Prateado\": Nível de empilhamento 0/1/2/3 ou superior, bonificação de 20%/30%/40%/50%.\n2. As \"Bonificações Racionais\" de diferentes Corpos Despertos ou Rodas do destino são acumulativas.\n3. Especialmente, as recompensas da primeira conclusão em dificuldade Loucura não são afetadas pela \"Bonificação Racional\".\n\n<Title:Ressonância: Síndrome de Separação>\n1. O Guardião do Segredo pode obter \"Coração dividido\" completando os logros do evento.\n2. Consumindo \"Coração dividido\" para ativar a \"Ressonância: Síndrome de Separação\", você poderá obter os seguintes bônus:\n(1) Tornará o Guardião do Segredo mais forte nas atividades do evento \"Codificação de Memória\" e \"Registro de Operações: Fissão Tranquila\", tornando os desafios mais fáceis.\n(2) Aumentará as recompensas obtidas após completar os desafios de \"Codificação de Memória\".\n(3) Ativará a atividade \"Armazenamento de Borda\".\n\n<Title:Armazenamento de Borda>\n1. Após ativar a ressonância \"Diagnóstico: Esquizofrenia\", você ganhará automaticamente 60 \"Puzzle de Memória α\" por hora, com um máximo de 25 horas armazenáveis.\n2. Após ativar a ressonância \"Sincronização Cognitiva\", você ganhará automaticamente 30 \"Puzzle de Memória β\" por hora, com um máximo de 25 horas armazenáveis.\n\n<Title:Registro de Operações>\n1. Durante o evento, o \"Registro de Operações: Fissão Tranquila\" poderá ser desbloqueado gratuitamente.\n2. Após o término do evento, o progresso do \"Registro de Operações: Fissão Tranquila\" será mantido, e você ainda poderá obter as mesmas recompensas ao completar eventos de investigação não concluídos durante o evento. Se você não desbloqueou o \"Registro de Operações: Fissão Tranquila\" durante o evento, ainda poderá desbloqueá-lo após o término consumindo 7 \"Ponto de partida real\".\n3. Independentemente de estar durante o evento ou não, ao concluir o \"Registro de Operações: Fissão Tranquila\", você poderá obter o \"Sinal: Tudo dela\".\n\n<Title:Compensação de Reedição>\n1. Guardiões do Segredo que já desbloquearam anteriormente o \"Registro de Operações: Fissão Tranquila\" receberão uma compensação de 700 \"Puzzle de Memória α\" ao desbloqueá-lo novamente durante este evento de reedição.\n2. Guardiões do Segredo que já possuem o avatar exclusivo do evento \"Em Nome da Chave de prata: '24'\", ao obtê-lo novamente ele será automaticamente convertido em 1 \"Convite do Incorpóreo\".\n3. Guardiões do Segredo que já possuem o material para ativar a ressonância \"Coração dividido\", cada \"Coração dividido\" adicional será automaticamente convertido em 5000 \"Cupom de ouro rosa\".\n"
  },
  Activity_78652_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_78722_ActivityName = {
    Text = "Maré Sombria e Sons de Insetos · Pré-venda por tempo limitado"
  },
  Activity_78722_ActivityTips = {
    Text = "<Title: Segredo dos Insetos nas Marés Escuras - Pré-venda Temporária>\n·Esta campanha de pré-venda temporária inclui 8 pacotes, sendo o primeiro gratuito e os pacotes de 2 a 8 disponíveis somente após a compra de \"Segredo dos Insetos nas Marés Escuras - Pré-venda Temporária\".\n·Após adquirir \"Segredo dos Insetos nas Marés Escuras - Pré-venda Temporária\", você poderá receber imediatamente a recompensa do segundo pacote; os pacotes subsequentes só poderão ser resgatados após esperar um determinado período de tempo.\n·A compra de \"Segredo dos Insetos nas Marés Escuras - Pré-venda Temporária\" tem limite de tempo e não será mais possível adquiri-la após o prazo. Por favor, compre com antecedência, agente secreto, antes das 9:00 do dia 7 de abril."
  },
  Activity_78751_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_78751_ActivityPlot = {
    Text = "Após a compra, \"Senhor do Sono Primordial\" pode ativar <BlueQuality:iluminar 3>"
  },
  Activity_78752_ActivityName = {
    Text = "Texto temporário"
  },
  Activity_78752_ActivityTips = {
    Text = "<Title:Regras do Evento>\nDurante o evento \"Origem: Poder Real\", os Guardiões do segredo podem usar equipes predefinidas pelo sistema que incluem Origem: Poder Real para experienciar níveis designados um número ilimitado de vezes.\nAo experienciar os níveis do evento, ajustes nos Corpos Despertos na formação da equipe não podem ser feitos.\n<Title:Recompensas do Evento>\nApós completar o desafio do nível pela primeira vez, você pode reivindicar as recompensas de demonstração na interface do evento."
  },
  Activity_78753_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_78753_ActivityPlot = {
    Text = "Após a compra, \"Senhor do Sono Primordial\" pode ativar\n<BlueQuality:aprofundamento da personalidade +4, desbloquear superexaltação>"
  },
  Activity_78776_ActivityName = {
    Text = "Gênesis Dama do Mar Profundo"
  },
  Activity_78776_ActivityTips = {
    Text = "<Title:Regras da Atividade>\n· Durante o período da atividade \"Lady do Mar Profundo Primordial\", os Guardiãs da Verdade poderão utilizar equipes predefinidas pelo sistema contendo a Lady do Mar Profundo Primordial para repetidamente experimentar as fases designadas.\n· Ao experimentar as fases da atividade, não será possível ajustar os Corpos Despertados dentro da formação da equipe.\n<Title:Recompensas da Atividade>\n· Após completar o desafio da fase pela primeira vez, será possível receber as recompensas de teste na interface da atividade."
  },
  Activity_78777_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_78777_ActivityPlot = {
    Text = "Após a compra, \"Dama do Mar Profundo Primordial\" pode ativar <BlueQuality:iluminar 3>"
  },
  Activity_78778_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_78778_ActivityPlot = {
    Text = "Após a compra, \"Dama do Mar Profundo Primordial\" pode ativar\n<BlueQuality:aprofundamento da personalidade +4, desbloquear superexaltação>"
  },
  Activity_78790_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_78791_ActivityName = {
    Text = "Quando as montanhas nevadas derretem · Recriação"
  },
  Activity_78791_ActivityPlot = {
    Text = "As neves de Elworth nunca derretem, assim como seu ódio.\nQuando as mãos do futuro e do passado se entrelaçam, o guerreiro levantará a espada, lançando um ataque de vingança contra o destino.\nQuando ela enfrenta as ondas negras, você é sua bandeira"
  },
  Activity_78791_ActivityStageEndContent = {
    Text = "Evento encerrado, apenas disponível para \"Boca da Montanha\""
  },
  Activity_78791_ActivityTips = {
    Text = "<Title:Descrição do evento>\n1. Durante a atividade, o Guardião do Segredo pode coletar três tipos de \"Botões de Flor\" através da jogabilidade limitada \"Coração da Fera\" e \"Recompensas de Conquista\". Os \"Botões de Flor\" podem ser trocados em \"Boca Gigante da Montanha\" para obter recompensas de itens, incluindo a roda de destino SR exclusiva da atividade \"Espera até a Montanha de Neve Derreter\", Núcleo Imaculado, Núcleo de Lumen, Fragmentos de Pedra Sábia e Cristal de Mimese, entre outros.\n2. Durante a atividade, o \"Registro Especial: O Retornado de Elworth\" estará disponível gratuitamente.\n\n<Title:Período da Atividade>\n1. De 19 de maio 9:00 até 2 de junho 9:00 (GMT+8), todo o conteúdo da atividade estará disponível.\n2. De 2 de junho 9:00 até 9 de junho 9:00 (GMT+8), apenas \"Boca Gigante da Montanha\" e \"Recompensas de Conquista\" estarão disponíveis, os demais conteúdos terão terminado e não poderão mais ser acessados.\n\n<Title:Coração da Fera>\n1. \"Coração da Fera\" contém 5 estágios, cada um será liberado automaticamente a cada 2 dias.\n2. Cada desafio consome 120 pontos de lipoferrina, e ao ter sucesso no desafio você receberá a moeda da atividade \"Brotinho congelado\", \"Brotinho de prata com geada\" e \"Botão de sol\".\n3. Após concluir um estágio, será desbloqueada a função \"Recriar\" deste estágio. Por favor, note: ao usar a função \"Recriar\", não será possível obter taxa de sincronização.\n4. Você pode usar o apoio dos Alumni e o \"Ressonância: Montanha Devoradora\" para ajudá-lo a passar pelos estágios com mais facilidade.\n5. No segundo dia após o estágio ser desbloqueado, será liberada a dificuldade Loucura deste estágio. Ao completar pela primeira vez a dificuldade Loucura, você receberá uma recompensa generosa em moedas da atividade.\n6. Por favor, note: os desafios na dificuldade Loucura não consomem lipoferrina, não podem ser recriados e após a primeira conclusão, os desafios repetidos não darão mais recompensas em moedas da atividade.\n\n<Title:Bônus de Botões de Flor>\n1. Se o Guardião do Segredo possuir um determinado Corpo Desperto ou Roda do destino (não é necessário equipar), poderá obter um bônus adicional na recompensa de missões do estágio \"Coração da Fera\" para \"Brotinho congelado\", \"Brotinho de prata com geada\" e \"Botão de sol\" (incluindo recriação), conforme segue:\nCorpo Desperto \"Helot: Catena\": Despertar Espiritual 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%\nRoda do destino SSR \"Afundar no Carmesim\": Nível de empilhamento 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%\nRoda do destino SR \"Espera até a Montanha de Neve Derreter\": Nível de empilhamento 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%\n2. Os bônus de \"Bônus de Botões de Flor\" de diferentes Corpos Despertos ou Rodas do destino são acumulativos.\n3. Especialmente, as recompensas do primeiro desafio na dificuldade Loucura não são afetadas pelo \"Bônus de Botões de Flor\".\n\n<Title:Ressonância: Montanha Devoradora>\n1. O Guardião do Segredo pode obter \"Coração dividido\" completando os logros da atividade.\n2. Consumindo o \"Coração dividido\", ative a \"Ressonância: Montanha Devoradora\", permitindo que o Guardião do Segredo fique mais forte na jogabilidade da atividade \"Coração da Fera\" e os desafios sejam mais fáceis.\n\n<Title:Boca Gigante da Montanha>\n1. \"Boca Gigante da Montanha\" possui um total de três lojas de troca, os horários de início são os seguintes:\n\"Ambição Devoradora\" começa às 9h do dia 19 de maio.\n\"Intenção de Vingança\" começa às 9h do dia 21 de maio.\n\"Esperança de Renascimento\" começa às 9h do dia 23 de maio.\n2. Cada troca consome 750 \"Brotinho congelado\"/\"Brotinho de prata com geada\"/\"Botão de sol\", e aleatoriamente recebe cinco recompensas de itens dentro da loja.\n3. As recompensas de itens em cada loja de troca são divididas em \"Item Especial\" e \"Item comum\". Ao reiniciar, a quantidade restante dos Itens Especiais pode ser redefinida para o limite máximo. As regras específicas são as seguintes:\n(1) Primeiras 2 reinicializações: quando não houver mais Itens Especiais disponíveis, o Guardião do Segredo pode escolher reiniciar, após o que a quantidade restante dos Itens Especiais e dos Itens Comuns será redefinida para o limite máximo; também pode optar por continuar trocando, e quando não houver mais Itens Comuns disponíveis, será necessário reiniciar para continuar trocando.\n(2) A partir da 3ª reinicialização: só será possível reiniciar quando não houver mais Itens Comuns disponíveis, a reinicialização redefinirá a quantidade restante dos Itens Comuns para o limite máximo, os Itens Especiais não serão mais reiniciados.\n4. Após as 9:00 de 9 de junho (GMT+8), os \"Botões de Flor\" restantes não trocados serão recuperados na proporção de cada troca convertida em \"Cupom de ouro rosa*40\". Por favor, fique atento para verificar seu e-mail.\n\n<Title:Registro Especial>\n1. Durante a atividade, o \"Registro Especial: O Retornado de Elworth\" estará disponível gratuitamente. Após concluir o \"Registro Especial: O Retornado de Elworth\", você poderá obter na recompensa de conquista a Roda do destino SR exclusiva da atividade \"Espera até a Montanha de Neve Derreter\" e outras recompensas. As recompensas de conquista estarão disponíveis apenas durante a atividade, após o término não será possível completar ou coletar.\n2. Após o término da atividade, o progresso do \"Registro Especial: O Retornado de Elworth\" será mantido. Se você não desbloqueou o \"Registro Especial: O Retornado de Elworth\" durante a atividade, ainda poderá desbloqueá-lo após o término consumindo 7 \"Ponto de partida real\".\n3. Independentemente de estar durante ou não a atividade, após concluir o \"Registro Especial: O Retornado de Elworth\", você poderá obter o \"Sinal: Iluminação das Montanhas\"."
  },
  Activity_78791_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_79851_ActivityName = {
    Text = "Resplendor Prateado: Partida - Edição Especial"
  },
  Activity_79851_ActivityPlot = {
    Text = "A radiância de Prata concede Bênçãos sinceras à jornada de cada Guardião de novo nascido curado. Que a Chave de Prata ilumine o seu caminho.\n*Após a compra, pode ser usado em \"Suprimentos – Consumíveis.\""
  },
  Activity_80163_ActivityName = {
    Text = "Paciente dissociativo: ultra"
  },
  Activity_80163_ActivityTips = {
    Text = "<Title:Event Rules>\n·Durante o evento \"Paciente Dividido: Ultra\", os Guardiães podem usar equipes pré-definidas pelo sistema que incluem \"24\" para experimentar níveis designados infinitamente.\n·Ao experimentar níveis do evento, ajustes aos Despertadores na formação da equipe não são permitidos.\n<Title:Event Rewards>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_80164_ActivityName = {
    Text = "Paciente dissociativo: caro"
  },
  Activity_80164_ActivityTips = {
    Text = "<Title:Event Rules>\n·Durante o evento \"Paciente Dividido: Caro\", os Guardiães podem usar equipes pré-definidas pelo sistema que incluem \"24\" para experimentar níveis designados infinitamente.\n·Ao experimentar níveis do evento, ajustes aos Despertadores na formação da equipe não são permitidos.\n<Title:Event Rewards>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_80165_ActivityName = {
    Text = "Paciente dissociativo: aequor"
  },
  Activity_80165_ActivityTips = {
    Text = "<Title:Regras da Atividade>\n·Durante o evento \"Paciente Fragmentado: Aequor\", os Guardiães podem usar equipes pré-definidas pelo sistema contendo \"24\" para experimentar níveis designados um número ilimitado de vezes.\n·Ao jogar os níveis do evento, ajustes no Despertar do alinhamento da equipe não podem ser feitos.\n<Title:Recompensas da Atividade>\n·Após completar com sucesso um desafio de nível pela primeira vez, você pode reivindicar recompensas de teste na interface do evento."
  },
  Activity_80166_ActivityName = {
    Text = "Paciente dissociativo: caos"
  },
  Activity_80166_ActivityTips = {
    Text = "<Title:Regras da Atividade>\n·Durante o evento \"Paciente Fragmentado: Caos\", os Guardiães podem usar equipes pré-definidas pelo sistema contendo \"24\" para experimentar níveis designados um número ilimitado de vezes.\n·Ao jogar os níveis do evento, ajustes no Despertar do alinhamento da equipe não podem ser feitos.\n<Title:Recompensas da Atividade>\n·Após completar com sucesso um desafio de nível pela primeira vez, você pode reivindicar recompensas de teste na interface do evento."
  },
  Activity_80167_ActivityName = {
    Text = "Ceifador de almas"
  },
  Activity_80167_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento \"Colecionador de Almas\", os Guardiões podem usar equipes pré-definidas pelo sistema que incluem Hilota: Catena para experimentar níveis designados infinitamente.\n·Ao experimentar os níveis do evento, ajustes nos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_80311_ActivityName = {
    Text = "Homenagem à Jornada · Crônica das Estrelas II"
  },
  Activity_80311_ActivityPlot = {
    Text = "Um pedaço de memória selado e arquivado, uma jornada registrada no passado. Em momentos de lembrança, não se esqueça de oferecer sua reverente Visita."
  },
  Activity_80312_ActivityName = {
    Text = "Jornada de Recuperação"
  },
  Activity_80312_ActivityTips = {
    Text = "Regras do evento:\n1. Após completar as missões designadas da \"Viagem Terapêutica\", os Guardiões do Segredo podem coletar recompensas em \"Viagem Terapêutica\".\n2. \"Viagem Terapêutica\" está permanentemente disponível.\n3. Após desbloquear a \"Viagem Avançada\", é possível coletar recompensas adicionais ao completar missões.\n4. Aviso: A \"Viagem Avançada\" desbloqueada neste evento só é válida durante este evento. Os Guardiões do Segredo devem consumir com moderação e consciência."
  },
  Activity_81019_ActivityName = {
    Text = "Viagem Extraordinária de Limpeza"
  },
  Activity_81019_ActivityPlot = {
    Text = "Quem percorre a onírica Cardas, limpando o lixo para seu mestre?\nÉ a Karen～ É a Karen!\nLimpar a Fusão～ Ventilação dos Sonhos～ Desinfecção dimensional～ Deixando tudo brilhando de limpo～\nAfinal, quando se trata de limpeza, eu, Karen, sou profissional!\nGostaria de tentar, Mestre? Vou te ensinar tudo o que sei sobre limpeza, sem esconder nada!"
  },
  Activity_81019_ActivityTips = {
    Text = "<Title:Visão Geral do Evento>\n1. Durante o evento, Guardiões do segredo podem participar do \"Progresso de Limpeza\" e coletar \"Ferramentas de Limpeza\".\n2. Quando as \"Ferramentas de Limpeza\" acumularem até uma certa quantidade, recompensas generosas podem ser resgatadas em \"Subsídio Antipoeira\", incluindo o avatar exclusivo do evento \"Mestre de Limpeza\", Prata, Núcleo Imaculado, Fragmentos de Pedra Sábia e mais.\n\n<Title: Progresso de Limpeza>\n1. \"Progresso de Limpeza\" contém múltiplos tipos de missões de Limpeza. Guardiões do segredo podem completar missões de Limpeza para coletar \"Ferramentas de Limpeza\". Uma recompensa adicional está disponível após completar todos os tipos de missões de Limpeza a cada dia!\n2. Durante o evento, uma Trama oculta será reproduzida cada vez que um novo tipo de missão de Limpeza for completado pela primeira vez.\n3. O \"Progresso de Limpeza\" será Atualizado e reiniciado diariamente às 9:00 (GMT+8) durante o evento.\n\n<Title: Subsídio Antipoeira>\n1. Guardiões do segredo podem resgatar recompensas correspondentes ao acumular \"Ferramentas de Limpeza\". Recompensas generosas de materiais podem ser resgatadas a cada 1.000 \"Ferramentas de Limpeza\" acumuladas. Acumular um total de 10.000 \"Ferramentas de Limpeza\" concederá o avatar exclusivo da Viagem Maravilhosa de Limpeza \"Mestre de Limpeza\".\n\n<Title:O presente de agradecimento de Karen>\nDurante o evento, você pode fazer check-in em \"O presente de agradecimento de Karen\" para receber os presentes que Karen preparou para os Guardiões do segredo!\n\n<Title:Duração do Evento>\nEste evento está disponível apenas de 28 de abril, 9:00 - 12 de maio, 9:00 (GMT+8). O evento terminará após 12 de maio, 9:00 (GMT+8). Lembrem-se de resgatar as recompensas em \"Subsídio Antipoeira\", Guardiões do segredo!"
  },
  Activity_81019_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_81178_ActivityName = {
    Text = "Na chuva torrencial, balançando suavemente"
  },
  Activity_81178_ActivityPlot = {
    Text = "Uma chuva torrencial despencava do céu sombrio, açoitando a superfície do mar com um estrépito implacável.\nRelâmpagos impiedosos rugiam à vontade, anunciando a chegada de um terror sem limites sob as ondas.\nO magnífico Nautilus balançava Frágil como um infante titubante em meio às marés revoltas.\nNinguém sabia que Destino os aguardava, assim como é somente quando o mar caprichoso Libera sua raiva que se compreende verdadeiramente quão insignificante se é."
  },
  Activity_81178_ActivityStageEndContent = {
    Text = "O evento foi Concluído. Atualmente, apenas \"Tesouros da Tripulação\" está disponível."
  },
  Activity_81178_ActivityTips = {
    Text = "<Title:Descrição do evento>\nDurante o evento, o Guardião poderá coletar a moeda do evento \"Bandeira de Sinalização\" através das jogabilidades temporárias \"Perdido nas Profundezas\" e \"Recompensas de Conquistas\". As \"Bandeiras de Sinalização\" poderão ser trocadas por recompensas em \"Tesouros da Tripulação\", incluindo a Roda do destino SR exclusiva do evento \"Navegador no Mar\", Núcleo de Lumen, Núcleo Imaculado, Fragmentos de Pedra Sábia, Cristal de Mimese e outros.\n\n<Title:Perdido nas Profundezas>\n1. \"Perdido nas Profundezas\" contém 9 estágios de materiais que não exigem exploração e vão direto para a batalha, sendo aberto 1 estágio por dia.\n2. Cada desafio consome 120 pontos de lipídeo, e ao vencer o desafio você receberá materiais de desenvolvimento e moedas do evento.\n3. Após concluir um estágio, será desbloqueada a função \"Recriar\" deste estágio. Por favor, note: ao usar a função \"Recriar\", não será possível obter taxa de sincronização.\n4. Você poderá usar o Apoio de batalha para ajudá-lo a passar os estágios mais facilmente.\n\n<Title:Bônus de Bandeira de Sinalização>\n1. Quando o Guardião possuir Corpos Despertos ou Rodas do destino específicas (não é necessário colocá-los em combate), poderá obter bônus adicionais na quantidade de \"Bandeiras de Sinalização\" obtidas nas recompensas das missões dos estágios de \"Perdido nas Profundezas\" (incluindo recriação). Os bônus específicos são os seguintes:\nCorpo Desperto \"Corposant\": Despertar Espiritual 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%\nRoda do destino SSR \"Navegador Flamenjante\": Nível de empilhamento 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%\nRoda do destino SR \"Navegador no Mar\": Nível de empilhamento 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%\n2. Os bônus de \"Bandeira de Sinalização\" de diferentes Corpos Despertos ou Rodas do destino são acumulativos.\n3. Especialmente, as recompensas da primeira conclusão em dificuldade Loucura não serão afetadas pelos bônus acima.\n\n<Title:Tesouros da Tripulação>\n1. Cada \"Entregar as Bandeiras\" consumirá 750 \"Bandeiras de Sinalização\", aleatoriamente obtendo cinco recompensas dentre os itens de \"Tesouros da Tripulação\".\n2. As recompensas em itens de \"Tesouros da Tripulação\" são divididas em dois tipos: \"Item Especial\" e \"Item comum\". Ao reiniciar, a quantidade restante dos \"Itens Especiais\" poderá ser redefinida para o limite máximo. As regras específicas são as seguintes:\n(1) Primeiras 5 reinicializações: quando não houver mais quantidade restante dos \"Itens Especiais\", o Guardião poderá escolher reiniciar, após o que a quantidade restante dos \"Itens Especiais\" e dos \"Itens Comuns\" será redefinida para o limite máximo; também poderá optar por continuar trocando, e quando não houver mais quantidade restante dos \"Itens Comuns\", será necessário reiniciar para continuar trocando.\n(2) A partir da 6ª reinicialização: só será possível reiniciar quando não houver mais quantidade restante dos \"Itens Comuns\", e ao reiniciar a quantidade restante dos \"Itens Comuns\" será redefinida para o limite máximo, enquanto os \"Itens Especiais\" não serão mais reiniciados.\n\n<Title:Tempo do evento>\n1. De 09:00 de 5 de maio até 09:00 de 19 de maio (GMT+8), todos os conteúdos mencionados na descrição do evento estarão disponíveis.\n2. De 09:00 de 19 de maio até 09:00 de 26 de maio (GMT+8), apenas \"Tesouros da Tripulação\" e \"Recompensas de Conquistas\" permanecerão disponíveis, enquanto os demais conteúdos terão terminado e não poderão mais ser acessados.\n3. Após 09:00 de 26 de maio (GMT+8), as \"Bandeiras de Sinalização\" restantes que não foram resgatadas serão recicladas na proporção de 40 Cupom de ouro rosa por bandeira. Por favor, preste atenção para verificar seu e-mail."
  },
  Activity_81178_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_81179_ActivityName = {
    Text = "Última Navegação"
  },
  Activity_81771_ActivityName = {
    Text = "A sombra que espreita o Reino Divino"
  },
  Activity_81771_ActivityPlot = {
    Text = "Ninguém vislumbrou a santíssima luz do Reino Divino, mas através da verdade acidentalmente revelada, as pessoas conseguem perceber a sombra do Reino Divino.\nEle está ali, sempre esteve ali, e incontáveis devotos farão com que ele realmente desça.\nNão importa quão graves pecados devam ser cometidos como preço."
  },
  Activity_81771_ActivityStageEndContent = {
    Text = "Evento encerrado"
  },
  Activity_81771_ActivityTips = {
    Text = "<Title:Maré Inquieta>\n\"Maré Inquieta\" contém 7 estágios. Os 3 primeiros estarão disponíveis no primeiro dia do evento, e a cada 3 dias será aberto 1 novo estágio. Cada estágio oferece recompensas diferentes e generosas!\nCada tipo de \"Maré Inquieta\" possui muitos grupos. Sempre que um grupo de um certo tipo for derrotado por qualquer Guardião, a quantidade de grupos desse tipo será reduzida em 1. Quando todos os grupos desse tipo forem eliminados, o estágio correspondente será encerrado permanentemente.\nCada Guardião pode repelir no máximo 20 vezes os grupos de \"Maré Inquieta\" por dia, e o número será redefinido diariamente às 9:00 (GMT+8) durante o período do evento.\nCada estágio oferece Relíquias diferentes, que fornecerão poderosos aumentos.\nTodos os estágios exigem escolher um companheiro de apoio. Durante todo o evento, cada Guardião que esteja mutuamente seguindo poderá oferecer apoio somente uma vez.\nO Guardião precisa ter concluído pelo menos a Operação de Investigação 2-9 para participar deste evento.\n\n<Title:Compensação de Nível>\nEm \"Dar uma espiada nas sombras do Reino Divino: Maré Inquieta\", existe um mecanismo de compensação de nível, para que todos os Guardiões possam juntos resistir à invasão!\nAs regras da compensação de nível são as seguintes:\nNa equipe de investigação, se o nível de um desperto for inferior a 60, ele será compensado para o nível 60 durante este desafio.\nNa equipe de investigação, se o nível de habilidade de um desperto for inferior a 5, ele será compensado para o nível 5 durante este desafio.\nNa equipe de investigação, se o nível de \"Presságio de Loucura\" de um desperto for inferior a 6, ele será compensado para o nível 6 durante este desafio.\nNa equipe de investigação, se o nível de \"Afinidade Espiritual\" de um desperto for inferior a 5, ele será compensado para o nível 5 durante este desafio.\nSe o nível do Guardião for inferior a 60, ele será compensado para o nível 60 durante este desafio.\n\n<Title:Missão Temporária>\nDurante o evento, ao acumular 30 vitórias contra a \"Maré Inquieta\", você concluirá a missão temporária e receberá 1 \"Vale de Roupa Fantástica Simples (1ª fase)\"!\nEntre 9:00 de 26 de maio a 9:00 de 9 de junho (GMT+8), você poderá usar o \"Vale de Roupa Fantástica Simples (1ª fase)\" na \"Loja: Encomenda de Traje\" para resgatar trajes simples.\nMais formas de obter o \"Vale de Roupa Fantástica Simples (1ª fase)\" podem ser encontradas na comunidade e nos anúncios."
  },
  Activity_81771_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_83305_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_83306_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_83307_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_83308_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_83309_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_83310_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_83311_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_83312_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_83313_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_83314_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_83315_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_83316_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_83317_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_83318_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_83319_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_83320_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_83321_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_83322_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_83323_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_83324_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_83325_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_83326_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_83327_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_83328_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_83329_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_83330_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_83331_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_83332_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_83333_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_83334_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_83335_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_83336_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_83337_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_83338_ActivityName = {
    Text = "Abismo dissoluto"
  },
  Activity_84175_ActivityName = {
    Text = "Ritmo da Jornada"
  },
  Activity_84175_ActivityTips = {
    Text = "Regras do evento:\n1. Após completar as missões designadas de \"Viagem Rítmica\", os Guardiões do Segredo podem coletar recompensas em \"Viagem Rítmica\".\n2. As missões são divididas em vários grupos, e um grupo será desbloqueado diariamente após o início do evento.\n3. Após desbloquear \"Viagem Rítmica\", recompensas adicionais poderão ser coletadas ao completar as missões.\n4. Atenção: O \"Viagem Rítmica\" desbloqueado neste evento só será válido durante este evento. Por favor, os Guardiões do Segredo devem consumir de forma racional."
  },
  Activity_84176_ActivityName = {
    Text = "Jornada do Fio Temporal"
  },
  Activity_84176_ActivityTips = {
    Text = "Regras do evento:\n1. Após completar as missões designadas de \"Viagem dos Laços Temporais\", os Guardiões do Segredo poderão coletar recompensas em \"Viagem dos Laços Temporais\".\n2. As missões são divididas em múltiplos grupos, e um grupo será desbloqueado diariamente após o início do evento.\n3. Após desbloquear \"Viagem dos Laços Temporais\", recompensas adicionais poderão ser coletadas ao completar as missões.\n4. Atenção: A \"Viagem dos Laços Temporais\" desbloqueada neste evento só será válida durante este evento. Peça aos Guardiões do Segredo que consumam com moderação e racionalidade."
  },
  Activity_89008_ActivityName = {
    Text = "Seguir dimensões em eco"
  },
  Activity_89008_ActivityPlot = {
    Text = "Ela atravessou incontáveis Dimensões, incontáveis mundos, e vivenciou incontáveis esperanças e desesperos, mas ela nunca vai parar. Porque ela sabe exatamente onde está seu destino — onde quer que você esteja."
  },
  Activity_89008_ActivityTips = {
    Text = "<Title:Resumo>\n1. Durante o evento, os Guardiões podem receber as recompensas diárias de login em \"Seguindo através das dimensões\" após fazer login a cada dia.\n2. As recompensas serão desbloqueadas sequencialmente conforme o número de dias de login acumulados dos Guardiões, e o check-in diário será resetado às 9h (GMT+8).\n\n<Title:Tarefas Temporárias>\nDurante o evento, ao fazer login acumulado por 7 dias, você poderá completar uma tarefa temporária e ganhar \"Vale de Roupa Fantástica Simples (1ª fase)\" *1!\nEntre 26 de maio às 9:00 e 9 de junho às 9:00 (GMT+8), você poderá usar o \"Vale de Roupa Fantástica Simples (1ª fase)\" em \"Loja: Pedidos de Traje Ilusório\" para resgatar trajes ilusórios simples.\nMais formas de obter o \"Vale de Roupa Fantástica Simples (1ª fase)\" podem ser encontradas nas comunidades e anúncios."
  },
  Activity_89008_BannerText = {
    Text = "Check-in para receber muitos Núcleos Imaculados"
  },
  Activity_89576_ActivityName = {
    Text = "Que a esperança germine novamente"
  },
  Activity_89576_ActivityPlot = {
    Text = "Faça login diariamente para receber a Roda do Destino SSR comemorativa \"Renascido na Terra em Ruínas\", totalizando 16 unidades!"
  },
  Activity_89576_ActivityTips = {
    Text = "<Title:Resumo>\nO mundo está em colapso. Neste mundo, o desespero é a norma, a dor é a norma. Eu devo me acostumar. Mas... ainda há calor escondido em meu coração, esperando romper o peito e emergir.\n\n<Title:Regras do evento>\n· Durante o evento, após fazer login diariamente, o Guardião do Segredo pode receber em \"Que a Esperança Renasça\" a Roda do Destino SSR comemorativa \"Renascido na Terra em Ruínas\", totalizando 16 recompensas no total.\n· As recompensas serão desbloqueadas de acordo com o login cumulativo do Guardião do Segredo, e as recompensas diárias serão atualizadas às 9h (GMT+8).\n\n."
  },
  Activity_89576_BannerText = {
    Text = "Roda do destino SSR Limitada Grátis"
  },
  Activity_89729_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_89730_ActivityName = {
    Text = "Prisioneiro da Imagem"
  },
  Activity_89730_ActivityPlot = {
    Text = "Pássaro, pássaro, por que há algemas partidas em seus pés?\nPássaro, pássaro, por que você canta solitariamente nas alturas?\nLivre-se dos espinhos, fuja da gaiola, você voa sobre as areias infinitas, mas seu canto triste não cessa. Afinal, quem é o companheiro fiel que você procura? Afinal, onde fica a verdadeira terra natal que você busca?"
  },
  Activity_89730_ActivityStageEndContent = {
    Text = "Evento encerrado, disponível apenas para \"Desejo de Sabedoria\""
  },
  Activity_89730_ActivityTips = {
    Text = "<Title:Descrição do evento>\n1. Durante o evento, o Guardião pode coletar moedas de evento \"Livro de Conhecimento Comum\", \"Livro de Conhecimento Matemático\" e \"Livro de Conhecimento Literário\" através das atividades limitadas \"Além do horizonte\", \"Navegação nos Sonhos\" e \"Recompensas por Conquistas\". As moedas mencionadas podem ser utilizadas na loja \"Desejo de conhecimento\" para adquirir itens, incluindo a Roda do destino SR exclusiva do evento \"Pena Solitária\", Núcleo de Lumen, Núcleo Imaculado, etc.\n2. Durante o evento, o capítulo \"Visão de Sonhos Estranhos: Além do horizonte Parte um\" estará disponível gratuitamente por tempo limitado. Completar as conquistas do evento também permitirá obter o avatar exclusivo \"Com a Chave de prata: Castor\"!\n\n<Title:Período do evento>\n1. 2 de junho 9:00 - 16 de junho 9:00 (GMT+8), todas as atividades do evento estarão disponíveis.\n2. 16 de junho 9:00 - 23 de junho 9:00 (GMT+8), apenas a loja \"Desejo de conhecimento\" e as recompensas por conquistas estarão disponíveis.\n\n<Title:Além do horizonte>\n1. \"Além do horizonte\" possui 7 estágios, um novo estágio será liberado automaticamente a cada 1 dia.\n2. Cada tentativa consome 120 pontos de Menophin, e ao ter sucesso na batalha, você receberá moedas de evento.\n3. Após concluir um estágio, será desbloqueada a função \"Recriar\" deste estágio. Por favor, note: ao utilizar a função \"Recriar\", não será possível obter taxa de sincronização.\n4. Você pode utilizar o apoio dos Alumni para facilitar a passagem.\n\n<Title:Desejo de conhecimento>\nExistem três lojas em \"Desejo de conhecimento\", os horários de abertura são os seguintes:\n\"Disciplinas eletivas gerais\": aberto às 9:00 do dia 2 de junho.\n\"Classe optativa de ciências\": aberto às 9:00 do dia 4 de junho.\n\"Classe optativa de literatura\": aberto às 9:00 do dia 6 de junho.\nDentro das lojas, você pode selecionar os itens desejados e comprá-los diretamente.\n\n<Title:Bonificação do evento>\n1. Se o Guardião possuir Corpos Despertos ou Rodas do destino específicas (não é necessário equipá-los), poderá obter bônus adicional nas recompensas das missões dos estágios \"Além do horizonte\", incluindo \"Livro de Conhecimento Comum\", \"Livro de Conhecimento Matemático\" e \"Livro de Conhecimento Literário\". Os detalhes do bônus são os seguintes:\nCorpo Desperto \"Castor\": com Despertar Espiritual em 0/1/2/3 ou mais, o bônus será de 20%/30%/40%/50%.\nRoda do destino SSR \"Liberdade Inquebrável\": com Nível de empilhamento em 0/1/2/3 ou mais, o bônus será de 20%/30%/40%/50%.\nRoda do destino SR \"Pena Solitária\": com Nível de empilhamento em 0/1/2/3 ou mais, o bônus será de 20%/30%/40%/50%.\n2. Os bônus de diferentes Corpos Despertos ou Rodas do destino são acumulativos.\n3. Especialmente, as recompensas da primeira conclusão em dificuldade Loucura não são afetadas pelos bônus do evento.\n\n<Title:Navegação nos Sonhos>\n1. A cada hora você receberá automaticamente 60 \"Livros de Conhecimento Comum\", podendo acumular no máximo 25 horas.\n\n<Title:Visão de Sonhos Estranhos>\n1. Durante o evento, o capítulo \"Visão de Sonhos Estranhos: Além do horizonte Parte um\" estará disponível gratuitamente.\n2. Após o término do evento, o progresso de investigação do capítulo \"Visão de Sonhos Estranhos: Além do horizonte Parte um\" será mantido. Após o término do evento, mesmo que não tenha concluído todos os eventos de investigação durante o evento, você ainda poderá obter recompensas de investigação idênticas às do período do evento. Caso não tenha desbloqueado o capítulo \"Visão de Sonhos Estranhos: Além do horizonte Parte um\" durante o evento, ainda será possível desbloqueá-lo após o término do evento consumindo \"Ponto de partida real\" *7.\n3. Independentemente de ter sido desbloqueado durante o evento ou não, ao concluir o capítulo \"Visão de Sonhos Estranhos: Além do horizonte Parte um\", você poderá obter \"Chave: Desvio do Destino\"."
  },
  Activity_89730_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_89899_ActivityName = {
    Text = "Costura de Roupa Fantasma"
  },
  Activity_89899_ActivityTips = {
    Text = "<Title:Breve introdução do evento>\n1. Durante o evento, os Guardiões do Segredo poderão realizar extrações utilizando o \"Espelho Único de Visão Fantasma\". A quantidade necessária de \"Espelhos Únicos de Visão Fantasma\" aumentará a cada extração.\n2. A Roupa Fantasma da Chave de Prata poderá ser obtida a partir da 5ª extração. Ao completar 10 extrações, garantirá receber a Roupa Fantasma da Chave de Prata desta edição.\n3. Após o término do evento, caso ainda reste algum \"Espelho Único de Visão Fantasma\", ele será automaticamente convertido em líquido de origem.\n\n."
  },
  Activity_89899_BannerText = {
    Text = "Evento de Jogo por Tempo Limitado!"
  },
  Activity_90052_ActivityName = {
    Text = "Cérebro corrompido"
  },
  Activity_90052_ActivityTips = {
    Text = "<Title:Regras do evento>\n· Durante o evento \"Cérebro em decomposição\", os guardiões poderão utilizar equipes predefinidas contendo \"Dol - Fusão\" para experimentar ilimitadamente as fases designadas.\n· Ao experimentar as fases do evento, não será possível ajustar os corpos despertos na equipe.\n<Title:Recompensas do evento>\n· Após concluir o desafio da fase pela primeira vez, será possível coletar a recompensa de teste na interface do evento."
  },
  Activity_90493_ActivityName = {
    Text = "Treino de Combate"
  },
  Activity_90493_ActivityTips = {
    Text = "Regras do Evento:\n1. Guardiões do segredo podem aprender e praticar conteúdo de combate relevante nas Fases correspondentes.\n2. Quando os Guardiões do segredo Concluírem as Fases de treinamento prático correspondentes, recompensas podem ser reivindicadas em \"Treinamento Prático.\""
  },
  Activity_90861_ActivityName = {
    Text = "Caminho Conjugado do Destino"
  },
  Activity_90861_ActivityTips = {
    Text = "<Title: Caminho Conjugado do Destino>\n·Esta Jornada por Tempo Limitado contém 8 pacotes, dos quais o primeiro pode ser coletado gratuitamente. Os pacotes 2 a 8 precisam ser adquiridos após a compra de \"Caminho Conjugado do Destino\".\n·Após a compra de \"Caminho Conjugado do Destino\", você pode imediatamente coletar a recompensa do segundo pacote; os pacotes subsequentes precisam esperar um certo tempo antes de serem coletados.\n·Ao comprar \"Caminho Conjugado do Destino\" antes das 9:00 do dia 20 de abril, você também receberá recompensas adicionais: ícone exclusivo \"Tecelão do Destino\" e \"Convite do Incorpóreo\" ×10! Compras feitas após as 9:00 do dia 20 de abril não receberão recompensas exclusivas limitadas.\n·Após a compra, a duração desta Jornada por Tempo Limitado se tornará permanente, e o evento será encerrado no dia seguinte após a coleta de todos os pacotes.\n·A compra de \"Caminho Conjugado do Destino\" tem um limite de tempo, e após o prazo, não será mais possível adquirir. Por favor, o Guardião deve comprar com cautela antes das 9:00 do dia 18 de maio."
  },
  Activity_90861_BannerText = {
    Text = "Jornada Especial da Atividade por Tempo Limitado!"
  },
  Activity_90862_ActivityName = {
    Text = "Texto temporário"
  },
  Activity_90862_ActivityTips = {
    Text = "<Title: Texto Temporário>\n·Esta atividade de pré-encomenda inclui 8 pacotes, sendo o primeiro disponível gratuitamente e os pacotes de 2 a 8 exigindo a compra do \"Texto Temporário\" para resgate.\n·Após adquirir o \"Texto Temporário\", você poderá resgatar imediatamente a recompensa do segundo pacote; os pacotes subsequentes só poderão ser resgatados após intervalos de tempo específicos.\n·A compra do \"Texto Temporário\" tem limite de tempo e não estará disponível após o prazo final. Por favor, realize suas compras com moderação antes das 9:00 do dia 7 de abril, Guardião."
  },
  Activity_90862_BannerText = {
    Text = "Jornada Especial da Atividade por Tempo Limitado!"
  },
  Activity_90863_ActivityName = {
    Text = "Miríade de Desejos"
  },
  Activity_90863_ActivityTips = {
    Text = "<Title:Miríade de Desejos>\nEste evento do Diário do Guardião do Segredo vem com 8 pacotes de presentes; o primeiro pacote pode ser resgatado gratuitamente.\nApós adquirir \"Miríade de Desejos\", você pode resgatar imediatamente o 2º pacote de presentes e desbloquear os pacotes 3–8 após períodos de espera específicos.\nCompre antes de 24 de Agosto às 9:00 para receber adicionalmente o avatar exclusivo \"Ardil em Movimento\" e \"Convite do Incorpóreo\" ×10!\nCompras feitas após este horário não incluirão essas recompensas exclusivas de tempo limitado. \"Miríade de Desejos\" está disponível por tempo limitado; por favor, conclua sua compra antes de 21 de Setembro às 9:00. Após a compra, o horário de término do evento do Diário do Guardião do Segredo será estendido para 28 de Setembro às 9:00, dando a todos os Guardiões tempo suficiente para resgatar suas recompensas!"
  },
  Activity_90863_BannerText = {
    Text = "Jornada Especial da Atividade por Tempo Limitado!"
  },
  Activity_90864_ActivityName = {
    Text = "Elegia do Crânio · Jornada por Tempo Limitado"
  },
  Activity_90864_ActivityTips = {
    Text = "<Title:Antífona do Ossuário: Jornada por Tempo Limitado>\nEsta Jornada por Tempo Limitado contém 8 pacotes. O primeiro pode ser resgatado gratuitamente, já os pacotes de 2 a 8 só poderão ser resgatados após a compra de \"Antífona do Ossuário: Jornada por Tempo Limitado\".\nApós comprar \"Antífona do Ossuário: Jornada por Tempo Limitado\", você poderá imediatamente resgatar a recompensa do segundo pacote; os pacotes subsequentes só poderão ser resgatados após esperar um determinado período de tempo.\nSe comprar antes das 9:00 de 21 de julho (GMT+8), você também receberá recompensas extras: o avatar exclusivo \"O olhar faminto da noite eterna\" e 10 \"Convite do Incorpóreo\"! Após as 9:00 de 21 de julho, a compra não dará mais direito às recompensas exclusivas por tempo limitado.\nDisponível até: 18 de agosto 9:00 (GMT+8)."
  },
  Activity_90865_ActivityName = {
    Text = "Texto temporário"
  },
  Activity_90865_ActivityTips = {
    Text = "<Title:Movimento fetal do abismo marinho: Jornada por Tempo Limitado>\nEsta Jornada por Tempo Limitado contém 8 pacotes. O primeiro pode ser recebido gratuitamente.\nOs pacotes de 2 a 8 só poderão ser recebidos após a compra de \"Movimento fetal do abismo marinho: Jornada por Tempo Limitado\".\nApós comprar, você poderá receber imediatamente a recompensa do segundo pacote. Os pacotes subsequentes só poderão ser recebidos após esperar um determinado período de tempo.\nPara um bônus exclusivo, compre antes das 9:00 de 17 de novembro para receber o avatar \"Canção de Adeus do Mar Profundo\" e 10 \"Convite do Incorpóreo\". Esta oferta é limitada e não estará disponível após o prazo.\nAtenção: a \"Movimento fetal do abismo marinho: Jornada por Tempo Limitado\" tem limite de tempo e não poderá mais ser comprada após as 9:00 de 15 de dezembro."
  },
  Activity_91026_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_91027_ActivityName = {
    Text = "Grande conquista"
  },
  Activity_91027_ActivityPlot = {
    Text = "Uma grande era talvez acabe perecendo, mas a vontade destes bravos guerreiros jamais desaparecerá. \nLápides não podem enterrá-los, correntes não conseguem domá-los. \nQuando uma nova jornada surge, suculentas carnes assadas os aguardam ao final do caminho da conquista; os guerreiros avançam em carga, recolhendo como presa a glória que lhes é devida. \nCantemos então a esta coragem imortal, cantemos ao sagrado império! \nRoma! Roma!"
  },
  Activity_91027_ActivityStageEndContent = {
    Text = "Evento encerrado, disponível apenas para \"Oferecer tributo\""
  },
  Activity_91027_ActivityTips = {
    Text = "<Title:Resumo do Evento>\n1. Durante o evento, os Guardiões poderão coletar a moeda do evento \"Delicioso churrasco de Leão\" através da atividade limitada \"Caça Divina\". Esta moeda pode ser usada para comprar itens em \"Oferecer tributo\", incluindo Núcleo de Lumen, Núcleo Imaculado, entre outros.\n2. Durante o evento, \"Visão de Sonhos Estranhos: Domínio Culinário\" será desbloqueado gratuitamente.\n\n<Title:Período do Evento>\n1. De 30 de junho às 9:00 até 21 de julho às 9:00 (GMT+8), todas as atividades do evento estarão disponíveis.\n2. De 21 de julho às 9:00 até 28 de julho às 9:00 (GMT+8), somente estarão disponíveis \"Oferecer tributo\" e recompensas por conquistas.\n\n<Title:Caça Divina>\n1. \"Caça Divina\" possui 5 estágios, cada um será aberto automaticamente a cada 2 dias.\n2. Cada desafio consome 120 pontos de Menophin, e ao vencer o desafio você receberá moedas do evento.\n3. Após concluir um estágio, será desbloqueada a função \"Reencenação\" desse estágio. Por favor, observe: ao utilizar a função \"Reencenação\", não será possível ganhar taxa de sincronização.\n4. Você poderá usar o apoio dos Alumni para ajudá-lo a passar de fase mais facilmente.\n\n<Title:Oferecer tributo> Na loja do evento será possível utilizar a moeda do evento \"Delicioso churrasco de Leão\" para escolher e comprar diretamente os itens desejados.\n\n<Title:Visão de Sonhos Estranhos>\n1. Durante o evento, \"Visão de Sonhos Estranhos: Domínio Culinário\" poderá ser desbloqueado gratuitamente.\n2. Após o término do evento, o progresso da investigação de \"Visão de Sonhos Estranhos: Domínio Culinário\" será mantido, e ao completar eventos investigativos não finalizados durante o evento, ainda será possível obter recompensas de investigação idênticas às do período do evento. Caso \"Visão de Sonhos Estranhos: Domínio Culinário\" não tenha sido desbloqueado durante o evento, ainda será possível desbloqueá-lo após o término mediante consumo de \"Ponto de partida real\" ×7.\n3. Independentemente de estar durante ou não o evento, ao concluir \"Visão de Sonhos Estranhos: Domínio Culinário\" será possível obter \"Chave: Resolução Voraz\"."
  },
  Activity_91027_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_91112_ActivityName = {Text = "Matsuka"},
  Activity_91112_ActivityTips = {
    Text = "<Title:Regras do Evento>\n· Durante o evento \"Aurora Selada\", os Guardiões podem usar formações pré-definidas pelo sistema que incluem Mouchette para experimentar os estágios designados um número ilimitado de vezes.\n· Ao experimentar os estágios do evento, ajustes aos Despertadores na formação não podem ser feitos.\n<Title:Recompensas do Evento>\n· Após completar o desafio do estágio pela primeira vez, você pode reivindicar recompensas de teste na interface do evento."
  },
  Activity_91355_ActivityName = {
    Text = "Homenagem à Jornada · Crônica das Estrelas III"
  },
  Activity_91355_ActivityPlot = {
    Text = "Um pedaço de memória selado e arquivado, uma jornada registrada no passado. Em momentos de lembrança, não se esqueça de oferecer sua reverente Visita."
  },
  Activity_91356_ActivityName = {
    Text = "Crônicas da Cidade Perdida"
  },
  Activity_91356_ActivityTips = {
    Text = "Regras do Evento:\n1. Os Guardiões podem receber recompensas em \"Jornada da Cidade do Desperdício\" após completar as tarefas designadas da jornada.\n2. \"Jornada da Cidade do Desperdício\" está permanentemente aberta.\n3. Após desbloquear a \"Jornada Avançada\", recompensas adicionais podem ser recebidas ao completar as tarefas.\n4. Por favor, note: A \"Jornada Avançada\" desbloqueada neste evento é válida apenas durante este evento. Os Guardiões devem consumir de forma razoável e judiciosa."
  },
  Activity_91719_ActivityName = {
    Text = "Cupom de Troca de Moda - Fase 2"
  },
  Activity_91719_ActivityPlot = {
    Text = "Cupom de Troca de Moda - Fase 2"
  },
  Activity_91719_ActivityTips = {
    Text = "<Title:Breve introdução do evento>\n1. Durante o evento, os Guardiões do Segredo poderão obter Vouchers de Fantasma Simples através de outros eventos"
  },
  Activity_91728_ActivityName = {
    Text = "Apóstolo do mar"
  },
  Activity_91728_ActivityTips = {
    Text = "<Title:Regras do Evento>\n· Durante o evento \"Apostolo do Mar\", os Guardiães podem usar equipes pré-definidas pelo sistema que incluam Miryam para experimentar níveis designados infinitamente.\n· Ao experimentar os níveis do evento, ajustes aos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n· Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_94858_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_94859_ActivityName = {
    Text = "Jornada de Verão"
  },
  Activity_94859_ActivityTips = {
    Text = "Regras do evento: \n1. Após completar as missões designadas, os Guardiões do Segredo podem coletar recompensas em \"Viagem de Verão\". \n2. Após desbloquear \"Jornada Avançada\", recompensas adicionais podem ser coletadas após completar as missões. \n3. A compra da \"Jornada Avançada\" tem um prazo limitado; após o prazo, não será mais possível comprar. Os Guardiões do Segredo devem considerar a compra até 6 de outubro às 9h. \n4. Atenção: a \"Jornada Avançada\" desbloqueada neste evento só é válida durante a vigência deste evento. Os Guardiões do Segredo devem consumir de forma consciente e racional."
  },
  Activity_94859_BannerText = {
    Text = "Operação Especial por Tempo Limitado!"
  },
  Activity_94860_ActivityName = {
    Text = "Verão sob o sol negro"
  },
  Activity_94860_ActivityPlot = {
    Text = "Verão, praia, sol brilhante e muitos rostos familiares.\nSob o brilho do Sol Negro, esqueça tudo e afunde-se nesta festa de sonhos que satisfaz todas as fantasias."
  },
  Activity_94860_ActivityTips = {
    Text = "<Title:Introdução ao Evento>\n1. Durante o evento, \"Visão de Sonhos Estranhos: Adeus, Terra do Nunca\" será desbloqueado gratuitamente por tempo limitado!\n2. Durante o evento, ao fazer login acumulado por 7 dias, você poderá obter \"Núcleo de Lumen\"*10 em \"Festa de Verão sem Fim\", e no 7º dia, receberá adicionalmente um avatar de batalha exclusivo \"Voleibol 'General'\".\n\n<Title:Período do Evento>\n1. De 1º de setembro às 9:00 até 6 de outubro às 9:00 (GMT+8), todos os eventos estarão disponíveis para participação.\n\n<Title:Visão de Sonhos Estranhos>\n1. Durante o evento, \"Visão de Sonhos Estranhos: Adeus, Terra do Nunca\" pode ser desbloqueado gratuitamente.\n2. Após o término do evento, o progresso de investigação de \"Visão de Sonhos Estranhos: Adeus, Terra do Nunca\" será mantido, e você poderá obter recompensas de investigação consistentes com o período do evento ao completar eventos de investigação não finalizados durante o evento. Se \"Visão de Sonhos Estranhos: Adeus, Terra do Nunca\" não for desbloqueado durante o evento, será possível desbloqueá-lo após o término do evento consumindo \"Ponto de partida real\"*7.\n3. Independentemente de ter participado do evento ou não, ao concluir \"Visão de Sonhos Estranhos: Adeus, Terra do Nunca\", você receberá \"Comando: Verão Congelado - Recordação de Verão\"."
  },
  Activity_94860_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_95190_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_95191_ActivityName = {
    Text = "A luz ofuscante da chegada de mil mundos"
  },
  Activity_95191_ActivityPlot = {
    Text = "Eles cantam uma canção de lembrança eterna, saudando o Senhor que jamais se apagará. \n Ele descerá do alto céu carregado de incontáveis luzes, proclamando a glória que jamais desaparecerá. \n No momento de Sua chegada, a luz âmbar cobrirá o mundo. \n Este é o funeral que Ele oferece ao mundo."
  },
  Activity_95191_ActivityStageEndContent = {
    Text = "O evento foi Concluído. Atualmente, apenas \"Base Secreta\" está disponível."
  },
  Activity_95191_ActivityTips = {
    Text = "<Title:Breve introdução do evento>\n1. Durante o evento, os Guardiões do Segredo poderão coletar moedas de evento \"Selo da Riqueza\", \"Selo da Morte\", \"Selo de Guerra\" através das atividades por tempo limitado \"Caça à Cinza\", \"A Festa Sem Conflitos\" e \"Recompensas de Conquistas\". As moedas \"Selo da Riqueza\", \"Selo da Morte\", \"Selo de Guerra\" podem ser usadas para comprar itens na \"Base Secreta\", incluindo a Roda do destino SR exclusiva do evento \"Sol Iminente\", Núcleo de Lumen, Núcleo Imaculado, entre outros.\n2. Durante o evento, o \"Dia Eterno e Imutável\" será desbloqueado gratuitamente por tempo limitado, e ao completar os logros do evento você também poderá obter o avatar exclusivo do evento \"Em Nome da Chave de prata: Katie Gula\"!\n\n<Title:Tempo do evento>\n1. 18 de agosto 9:00 - 1 de setembro 9:00 (GMT+8), todas as atividades estarão disponíveis.\n2. 1 de setembro 9:00 - 8 de setembro 9:00 (GMT+8), apenas a \"Base Secreta\" e as Recompensas de Conquistas estarão disponíveis.\n\n<Title:Caça à Cinza>\n1. \"Caça à Cinza\" possui 7 estágios, um novo estágio será liberado automaticamente a cada 1 dia.\n2. Cada desafio consome 120 pontos de neuropéptida, ao vencer o desafio você receberá moedas de evento.\n3. Após concluir um estágio, será desbloqueada a função \"Recriar\" desse estágio. Por favor, note: ao usar a função \"Recriar\", não será possível obter taxa de sincronização.\n4. Você pode usar o apoio dos Alumni para ajudá-lo a passar de fase mais facilmente.\n\n<Title>Base Secreta>\nA \"Base Secreta\" possui três lojas, os horários de abertura são os seguintes:\nCofre de Coleção: abertura às 9 horas do dia 18 de agosto.\nSala de Comissões: abertura às 9 horas do dia 20 de agosto.\nAcampamento de Combate: abertura às 9 horas do dia 22 de agosto.\nDentro das lojas é possível selecionar os itens e comprá-los diretamente.\n\n<Title:Bonificação de evento>\n1. Os Guardiões do Segredo que possuam Corpos Despertos ou Rodas do destino específicas (não é necessário equipá-los) poderão obter uma bonificação adicional nas recompensas de missões das fases de \"Caça à Cinza\", incluindo \"Selo da Riqueza\", \"Selo da Morte\", \"Selo de Guerra\". As bonificações específicas são as seguintes:\nCorpo Desperto \"Katie Gula\": Despertar Espiritual 0/1/2/3 ou mais, bonificação de 20%/30%/40%/50%.\nRoda do destino SSR \"Morte âmbar\": Nível de empilhamento 0/1/2/3 ou mais, bonificação de 20%/30%/40%/50%.\nRoda do destino SR \"Sol Iminente\": Nível de empilhamento 0/1/2/3 ou mais, bonificação de 20%/30%/40%/50%.\n2. As bonificações de diferentes Corpos Despertos ou Rodas do destino são acumulativas.\n3. Especialmente, as recompensas da primeira conclusão nas fases de dificuldade Loucura não são afetadas pelas bonificações de evento.\n\n<Title:A Festa Sem Conflitos>\n1. Ganhe automaticamente 60 \"Selo da Riqueza\" por hora, com armazenamento máximo de 25 horas.\n\n<Title:Navegação na consciência>\n1. Durante o evento, o \"Dia Eterno e Imutável\" poderá ser desbloqueado gratuitamente.\n2. Após o término do evento, o progresso da investigação do \"Dia Eterno e Imutável\" será mantido. Ao concluir os eventos de investigação não finalizados após o evento, você também poderá receber recompensas de investigação consistentes com as do período do evento. Se você não desbloquear o \"Dia Eterno e Imutável\" durante o evento, ainda poderá desbloqueá-lo após o término consumindo 3 \"Ponto de partida real\".\n3. Independentemente de estar durante ou não o evento, após concluir \"Navegação na consciência: Dia Eterno e Imutável\" você poderá obter a \"Chave: Sol Incrível\"."
  },
  Activity_95191_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_95492_ActivityName = {
    Text = "Recompensa do Rei"
  },
  Activity_95492_ActivityPlot = {
    Text = "Ele é um governante generoso, bondoso e misericordioso, que reina sobre um reino de morte. Bem-vindo, estranho que ainda não morreu, o aroma doce e agradável que emana de você já conquistou sua graça, então aceite esta recompensa, os portões deste castelo estarão sempre abertos para você."
  },
  Activity_95492_ActivityTips = {
    Text = "<Title:Descrição>\n1. Durante o evento, os Guardiões do Segredo podem coletar diariamente as recompensas de check-in em \"Recompensa do Monarca\".\n2. As recompensas serão desbloqueadas conforme o login acumulado dos Guardiões do Segredo, e o check-in diário será resetado às 9h (GMT+8).\n"
  },
  Activity_95492_BannerText = {
    Text = "Check-in para receber muitos Núcleos Imaculados"
  },
  Activity_95977_ActivityName = {
    Text = "A Estética dos Mortos-Vivos"
  },
  Activity_95977_ActivityPlot = {
    Text = "A morte está longe de ser o fim da vida. \nNão tema a morte, querido convidado. \nNo festival jubiloso, você estará ao lado daquela gentil senhora, testemunhando juntos a estética dos espíritos desencarnados."
  },
  Activity_95977_ActivityStageEndContent = {
    Text = "Evento encerrado, disponível apenas no \"Restaurante da Residência Real\""
  },
  Activity_95977_ActivityTips = {
    Text = "<Title:Descrição do Evento>\nDurante o evento, os Guardiões do segredo poderão coletar moedas de evento através das atividades limitadas \"Festa das Almas\" e \"Recompensas por Conquistas\". As moedas de evento poderão ser trocadas no \"Restaurante do Palácio Real\" para obter recompensas, incluindo a Roda do destino SR exclusiva do evento \"Iguaria Macabra\", Pedra Filosofal, Núcleo Imaculado, Núcleo de Lumen, entre outros.\n\n<Title:Data do Evento>\n1. 21 de julho 9:00 - 4 de agosto 9:00 (GMT+8), todas as atividades estarão disponíveis.\n2. 4 de agosto 9:00 - 11 de agosto 9:00 (GMT+8), apenas \"Restaurante do Palácio Real\" e \"Recompensas por Conquistas\" permanecerão, os demais conteúdos estarão encerrados e indisponíveis.\n\n<Title:Festa das Almas>\n1. \"Festa das Almas\" contém 5 estágios, cada um será aberto automaticamente a cada 2 dias.\n2. Cada desafio consome 120 pontos de Menophin, ao vencer o desafio você receberá moedas de evento.\n3. Após concluir um estágio, será desbloqueada a função \"Recriar\" deste estágio. Por favor, observe: ao usar a função \"Recriar\", não será possível obter taxa de sincronização.\n4. Você poderá usar o apoio da Alumni para ajudá-lo a passar os estágios mais facilmente.\n\n<Title:Bônus do Evento>\n1. Quando o Guardião possuir um determinado Corpo Desperto ou Roda do destino específico (não é necessário equipar), poderá obter bônus adicional na taxa de queda de \"Ossos Podres da Mão\" nas recompensas das missões dos estágios de \"Festa das Almas\" (incluindo Recriar), conforme a seguir:\nCorpo Desperto \"Doresain\": Despertar Espiritual 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\nRoda do destino SSR \"Beijo do Repouso\": Nível de empilhamento 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\nRoda do destino SR \"Iguaria Macabra\": Nível de empilhamento 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%\n2. Os bônus do evento de diferentes Corpos Despertos ou Rodas do destino serão acumulados.\n3. Especialmente, as recompensas da primeira conclusão em dificuldade Loucura não serão afetadas pelos bônus do evento.\n\n<Title:Restaurante do Palácio Real>\n1. Cada \"Enviar Relatório\" consumirá 750 \"Ossos Podres da Mão\" e aleatoriamente receberá uma das cinco recompensas disponíveis no \"Restaurante do Palácio Real\".\n2. As recompensas do \"Restaurante do Palácio Real\" são divididas em \"Item Especial\" e \"Item comum\". Ao Retroceder, a quantidade restante de itens especiais será redefinida para o limite máximo. As regras específicas são as seguintes:\n(1) Primeiros 5 Retroceder: quando não houver mais \"Item Especial\" restantes, o Guardião poderá escolher Retroceder, após o que a quantidade restante de \"Item Especial\" e \"Item comum\" será redefinida para o limite máximo; também poderá optar por continuar trocando, quando não houver mais \"Item comum\" restantes, será necessário Retroceder para continuar trocando.\n(2) A partir do 6º Retroceder: só será possível Retroceder quando não houver mais \"Item comum\" restantes, após Retroceder a quantidade restante de \"Item comum\" será redefinida para o limite máximo, \"Item Especial\" não serão mais reiniciados.\n3. Após 9:00 de 11 de agosto (GMT+8), os \"Ossos Podres da Mão\" não resgatados restantes serão convertidos na proporção de \"Cupom de ouro rosa*40\" por cada unidade, por favor, verifique seu correio."
  },
  Activity_95977_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_95978_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual I"
  },
  Activity_95978_ActivityPlot = {
    Text = "Após a compra, \"Dulesain\" pode ativar <BlueQuality:iluminar 3>"
  },
  Activity_95979_ActivityName = {
    Text = "Senhor de necrovia"
  },
  Activity_95979_ActivityTips = {
    Text = "<Title:Regras do evento>\n· Durante o evento \"Senhor dos Ossos\", o Guardião pode usar equipes predefinidas pelo sistema que incluam o personagem Dulsein para repetir infinitamente as fases designadas.\n· Durante a experiência nas fases do evento, não será possível ajustar os Despertados na equipe.\n<Title:Recompensas do evento>\n· Após completar o desafio da fase pela primeira vez, será possível coletar a recompensa de teste na interface do evento."
  },
  Activity_95980_ActivityName = {
    Text = "Caixa de Presente de Fixação de Núcleo Espiritual II"
  },
  Activity_95980_ActivityPlot = {
    Text = "Após a compra, \"Duresein\" pode ativar\n<BlueQuality:aprofundamento da personalidade +4, desbloquear superexaltação>"
  },
  Activity_96174_ActivityName = {
    Text = "Detetive sortudo"
  },
  Activity_96174_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento \"Lucky Detective\", os Guardiões podem usar equipes predefinidas pelo sistema que incluem Ryker para experimentar níveis designados infinitamente.\n·Ao experimentar os níveis do evento, ajustes aos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_96617_ActivityName = {
    Text = "Vários Tons de Vermelho Maple"
  },
  Activity_96617_ActivityTips = {
    Text = "<Title:Regras do Evento>\n1. Os Guardiões podem reivindicar recompensas em \"Vários Tons de Vermelho de Bordo\" após completar as tarefas designadas do arquivo.\n2. \"Vários Tons de Vermelho de Bordo\" terminará em 23 de março às 9:00 (GMT+8).\n3. Após desbloquear os \"Arquivos Premium\", recompensas adicionais podem ser reivindicadas após a conclusão das tarefas.\n4. Por favor, note: Os \"Arquivos Premium\" desbloqueados durante este evento são válidos apenas durante a duração deste evento. Os Guardiões são aconselhados a consumir de forma responsável."
  },
  Activity_96617_BannerText = {
    Text = "Jornada Especial da Atividade por Tempo Limitado!"
  },
  Activity_96838_ActivityName = {
    Text = "Texto temporário"
  },
  Activity_96838_ActivityPlot = {
    Text = "Uma explosão nuclear de cores, uma loucura de formas. \n Uma tela quase normal, manchada por toques de sangue, \n sob a espátula, almas penadas tremem e sussurram no lado escuro da tela. \n A arte mais verdadeira e perfeita está escondida atrás da loucura e do absurdo, \n apenas a loucura que rasga a superfície pode revelar o interior do mundo."
  },
  Activity_96838_ActivityStageEndContent = {
    Text = "Evento encerrado, apenas disponível para \"Ateliê de Pikman\""
  },
  Activity_96838_ActivityTips = {
    Text = "<Title:Breve introdução do evento>\n1. Durante o evento, os Guardiões do Segredo poderão coletar a moeda do evento \"Tingimento da Realidade\", \"Tinta do Sonho Fantasmal\" e \"Infecção de Loucura\" através da jogabilidade limitada \"Ilustração do Mundo Deformado\" e \"Recompensas de Conquista\". As \"Tingimento da Realidade\", \"Tinta do Sonho Fantasmal\" e \"Infecção de Loucura\" podem ser usadas no \"Ateliê do Pikman\" para comprar itens, incluindo a Roda do Destino SR exclusiva do evento \"Pincel do desejo\", Núcleo de Lumen, Núcleo Imaculado, etc. \n2. Durante o evento, \"Navegação na consciência: Ilustração do Mundo Deformado\" será desbloqueado gratuitamente por tempo limitado, e completar conquistas do evento também permitirá ganhar o avatar exclusivo do evento \"Em Nome da Chave de prata: Pickman\"!\n\n<Title:Tempo do Evento>\n1. 8 de setembro, 9:00 - 22 de setembro, 9:00 (GMT+8), todas as jogabilidades do evento estarão disponíveis. \n2. 22 de setembro, 9:00 - 29 de setembro, 9:00 (GMT+8), apenas \"Ateliê do Pikman\" e recompensas de conquista estarão disponíveis. \n\n<Title:Ilustração do Mundo Deformado>\n1. \"Ilustração do Mundo Deformado\" contém 7 estágios, sendo que 1 será desbloqueado automaticamente a cada dia. \n2. Cada desafio consumirá 120 pontos de Menophin, e ao vencer o desafio, o Guardião receberá a moeda do evento. \n3. Após completar o estágio, a função \"Recriação\" desse estágio será desbloqueada. Atenção: ao usar a função \"Recriação\", não será possível ganhar taxa de sincronia. \n4. Você pode usar a assistência da Alumni para ajudá-lo a passar pelos desafios mais facilmente. \n\n<Title:Ateliê do Pikman>\n1. \"Ateliê do Pikman\" possui três lojas, com os seguintes horários de abertura:\n \"Ateliê da Realidade\": abre em 8 de setembro, às 9h.\n \"Ateliê do Sonho Fantasmal\": abre em 10 de setembro, às 9h.\n \"Ateliê da Loucura\": abre em 12 de setembro, às 9h.\n2. Cada troca consumirá 750 \"Tingimento da Realidade\"/\"Tinta do Sonho Fantasmal\"/\"Infecção de Loucura\", ganhando aleatoriamente cinco recompensas de itens da loja. \n3. As recompensas de itens de cada loja são divididas em \"Item Especial\" e \"Item comum\". Ao resetar, é possível restaurar a quantidade restante de itens especiais ao limite. As regras específicas são: \n(1) Para os 2 primeiros resets: Quando não houver mais itens especiais restantes, o Guardião pode escolher resetar, o que restaurará a quantidade restante de \"Item Especial\" e \"Item comum\" ao limite; ou pode optar por continuar trocando. Quando não houver mais itens comuns restantes, será necessário resetar para continuar trocando. \n(2) A partir do 3º reset: O reset só pode ser feito quando não houver mais itens comuns restantes, e o reset restaurará a quantidade restante de itens comuns ao limite, enquanto os itens especiais não serão mais resetados. \n\n<Title:Adicionais do Evento>\n1. O Guardião que possuir Corpos Despertos ou Rodas do Destino específicas (não é necessário que estejam em campo) poderá fazer com que as recompensas das missões da \"Ilustração do Mundo Deformado\" que incluem \"Tingimento da Realidade\", \"Tinta do Sonho Fantasmal\" e \"Infecção de Loucura\" recebam um bônus adicional de drop, com os seguintes bônus específicos:\n Corpo Desperto \"Pickman\": Despertar Espiritual 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%.\n Roda do Destino SSR \"Paradoxo do Realismo\": Nível de empilhamento 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%.\n Roda do Destino SR \"Pincel do desejo\": Nível de empilhamento 0/1/2/3 ou mais, bônus de 20%/30%/40%/50%.\n2. Os \"adicionais do evento\" de diferentes Corpos Despertos ou Rodas do Destino serão calculados de forma acumulativa. \n3. Especialmente, as recompensas do primeiro desafio de dificuldade de loucura não serão afetadas pelos \"adicionais do evento\". \n\n<Title:Navegação na consciência>\n1. Durante o evento, \"Navegação na consciência: Ilustração do Mundo Deformado\" pode ser desbloqueado gratuitamente. \n2. Após o término do evento, o progresso da investigação de \"Navegação na consciência: Ilustração do Mundo Deformado\" será mantido. Completar eventos de investigação não finalizados durante o evento ainda permitirá ganhar recompensas de investigação idênticas às do evento. Se \"Navegação na consciência: Ilustração do Mundo Deformado\" não foi desbloqueado durante o evento, ainda é possível desbloqueá-lo após o término do evento consumindo \"Ponto de partida real\" *3. \n3. Independentemente de estar ou não durante o evento, ao completar \"Navegação na consciência: Ilustração do Mundo Deformado\", o Guardião poderá ganhar \"Chave: Cores do mundo ilusório\"."
  },
  Activity_96838_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_96839_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_97190_ActivityName = {
    Text = "Jornada do Requiem dos Ossos"
  },
  Activity_97190_ActivityTips = {
    Text = "Regras da atividade: \n1. Após o Investigador completar as missões designadas da Jornada, poderá receber recompensas na \"Jornada do Sepultamento\". \n2. Após desbloquear a \"Jornada Avançada\", poderá receber recompensas adicionais ao completar missões. \n3. A compra da \"Jornada Avançada\" desta vez tem limite de tempo; após o prazo, não será mais possível adquiri-la. Por favor, Investigadores, comprem conforme necessário antes das 9:00 do dia 18 de agosto. \n4. Por favor, estejam atentos: a \"Jornada Avançada\" desbloqueada neste evento será válida apenas durante este evento. Recomenda-se aos Investigadores que consumam com moderação."
  },
  Activity_97190_BannerText = {
    Text = "Jornada Especial da Atividade por Tempo Limitado!"
  },
  Activity_97297_ActivityName = {
    Text = "Rainha dos Espinhos"
  },
  Activity_97297_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento \"Rainha dos Espinhos\", os Guardiões podem usar equipes presetadas pelo sistema que incluem Wanda para experimentar níveis designados infinitamente.\n·Ao experimentar os níveis do evento, ajustes nos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_97672_ActivityName = {
    Text = "Texto temporário"
  },
  Activity_97672_ActivityPlot = {
    Text = "Texto temporário"
  },
  Activity_97672_ActivityStageEndContent = {
    Text = "Evento encerrado, atualmente só é possível participar de \"Sete dias de criação\""
  },
  Activity_97672_ActivityTips = {
    Text = "<Title:Breve introdução do evento>\n1. Durante o evento, os Guardiões do Segredo poderão coletar moedas de evento \"Aromaterapia Calmante\", \"Aroma de Pesadelo\" e \"Aromaterapia dos Caçadores de Sonhos\" através das atividades temporárias \"Sete dias de criação\" e \"Recompensas de Conquista\". As moedas de evento \"Aromaterapia Calmante\", \"Aroma de Pesadelo\" e \"Aromaterapia dos Caçadores de Sonhos\" podem ser usadas para comprar itens no \"Quarto da Mãe Divina\", incluindo a Roda do Destino SR exclusiva do evento \"Toxina do Anel Azul\", Núcleo de Lumen, Núcleo Imaculado etc.\n2. Completar conquistas do evento também concederá o avatar exclusivo do evento \"Por nome da Chave de Prata: Senhora das Profundezas da Origem\"!\n\n<Title:Tempo do evento>\n1. 24 de novembro 9:00 - 15 de dezembro 9:00 (GMT+8), todas as atividades estarão disponíveis.\n2. 15 de dezembro 9:00 - 22 de dezembro 9:00 (GMT+8), apenas o \"Quarto da Mãe Divina\" e as recompensas de conquista estarão disponíveis.\n\n<Title:Sete dias de criação>\n1. \"Sete dias de criação\" contém 7 estágios, um novo estágio será liberado automaticamente a cada 1 dia.\n2. Cada desafio consome 120 pontos de neuropeptídeo, e ao vencer o desafio você receberá moedas de evento.\n3. Após concluir um estágio, será desbloqueada a função \"Reproduzir\" desse estágio. Por favor, note: ao usar a função \"Reproduzir\", não será possível obter afinidade.\n4. Você pode usar o apoio dos Alumni para ajudá-lo a passar de fase mais facilmente.\n\n<Title:Profanação de Oração Desenfreada>\n Após o início do evento, você receberá automaticamente 60 \"Aromaterapia Calmante\" por hora, com armazenamento máximo de 25 horas.\n\n<Title:Quarto da Mãe Divina>\n1. Existem três lojas no \"Quarto da Mãe Divina\", os horários de abertura são os seguintes:\n\"Sonho Doce de Caminho Estranho\": abertura às 9:00 do dia 24 de novembro.\n\"Nascimento do Deus Profundo\": abertura às 9:00 do dia 25 de novembro.\n\"Pesadelo sem esperança\": abertura às 9:00 do dia 26 de novembro.\n2. Cada oferenda consumirá 750 \"Aromaterapia Calmante\"/\"Aroma de Pesadelo\"/\"Aromaterapia dos Caçadores de Sonhos\", concedendo aleatoriamente cinco itens de recompensa do quarto.\n3. As recompensas de itens de cada quarto são divididas em \"Item Especial\" e \"Item comum\". Ao reiniciar, é possível redefinir a quantidade restante de recompensas de itens especiais ao seu limite máximo. As regras específicas são:\n(1) Primeiras 2 reinicializações: quando não houver mais quantidade restante de \"Item Especial\", o Guardião poderá escolher reiniciar, o que redefinirá a quantidade restante de \"Item Especial\" e \"Item comum\" ao seu limite máximo; ou poderá continuar oferecendo, e quando também não houver mais quantidade restante de \"Item comum\", será necessário reiniciar para continuar oferecendo.\n(2) A partir da 3ª reinicialização: só será possível reiniciar quando não houver mais quantidade restante de \"Item comum\". Ao reiniciar, a quantidade restante de \"Item comum\" será redefinida ao seu limite máximo, mas os \"Item Especial\" não serão mais redefinidos.\n\n<Title:Bonificação do evento>\n1. Se o Guardião do Segredo possuir Corpos Despertos ou Rodas do Destino específicos (não é necessário equipá-los), poderá obter bônus adicionais nas recompensas de missão das fases de \"Sete dias de criação\", incluindo \"Aromaterapia Calmante\", \"Aroma de Pesadelo\" e \"Aromaterapia dos Caçadores de Sonhos\". Os bônus específicos são os seguintes:\nCorpo Desperto \"Senhora das Profundezas da Origem\": Despertar Espiritual 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%.\nRoda do Destino SSR \"Descanso na Escuridão\": Nível de empilhamento 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%.\nRoda do Destino SR \"Toxina do Anel Azul\": Nível de empilhamento 0/1/2/3 ou superior, bônus de 20%/30%/40%/50%.\n2. Os diferentes bônus de \"Bonificação do evento\" provenientes de Corpos Despertos ou Rodas do Destino são acumulativos.\n3. Especialmente, as recompensas da primeira conclusão em dificuldade de Loucura não são afetadas pela \"Bonificação do evento\"."
  },
  Activity_97672_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_97853_ActivityName = {
    Text = "Se tudo como de costume"
  },
  Activity_97853_ActivityPlot = {
    Text = "Você já imaginou como seria a vida de todos se o desastre nunca tivesse chegado? \n O poder que você tinha para salvar o mundo não tem mais lugar, e todos os dias você corre para a vida comum do campus e para ganhar créditos miseráveis. No campo de esportes, não há mais figuras treinando para a batalha, substituídas por fileiras de tendas de atividades de clubes, acompanhadas por gritos de recrutamento e brincadeiras; quando o sino da escola toca, os estudantes famintos imediatamente lotam o refeitório... \n Ao bater à porta das pessoas que você se preocupa, que sorrisos você verá?"
  },
  Activity_97853_ActivityStageEndContent = {
    Text = "Evento [Se Tudo Como de Costume] encerrado, atualmente só é possível participar de [Prédio da Associação Estudantil]"
  },
  Activity_97853_ActivityTips = {
    Text = "<Title:Resumo do Evento>\n1. Durante o evento, os Guardiões do Segredo podem coletar a moeda do evento \"Conchas de produtos locais da praia\" através da atividade temporária \"Nada de novo sob a luz do sol\". A \"Conchas de produtos locais da praia\" pode ser usada para comprar itens no \"Prédio do Diretório Estudantil\", incluindo Núcleo de Lumen, Núcleo Imaculado, Fragmentos de Pedra Sábia, entre outros. \n2. Durante o evento, \"Visão de Sonhos Estranhos: Adeus, Terra do Nunca\" será desbloqueado gratuitamente por tempo limitado!\n\n<Title:Período do Evento>\n1. De 6 de outubro, 9:00 - 20 de outubro, 9:00 (GMT+8), todas as atividades do evento podem ser participadas. \n2. De 20 de outubro, 9:00 - 27 de outubro, 9:00 (GMT+8), apenas o \"Prédio do Diretório Estudantil\" e recompensas de conquistas estarão disponíveis. \n\n<Title:Nada de novo sob a luz do sol>\n1. \"Nada de novo sob a luz do sol\" contém 5 estágios, com 1 novo sendo desbloqueado automaticamente a cada 2 dias. \n2. Cada desafio consumirá 120 pontos de Menophin, e ao completar o desafio, você ganhará a moeda do evento. \n3. Após completar um estágio, a função \"Repetir\" desse estágio será desbloqueada. Por favor, note: ao usar a função \"Repetir\", a taxa de sincronia não será obtida. \n4. Você pode usar a ajuda da Associação de Alumni para facilitar a conclusão dos desafios. \n\n<Title:Bônus de Atividade>\n1. Desbloqueie \"Arquivo Avançado\" na \"Jornada de Desenho e Medição\" para ativar um bônus de 100% de drop de \"Conchas de produtos locais da praia\" (incluindo repetições)\n\n<Title:Prédio do Diretório Estudantil>\nO \"Prédio do Diretório Estudantil\" tem uma loja que abrirá em 6 de outubro às 9:00. \nNa loja, você pode escolher os itens para comprar diretamente. \n\n<Title:Visão de Sonhos Estranhos>\n1. Durante o evento, \"Visão de Sonhos Estranhos: Adeus, Terra do Nunca\" poderá ser desbloqueado gratuitamente. \n2. Após o término do evento, o progresso de investigação de \"Visão de Sonhos Estranhos: Adeus, Terra do Nunca\" será mantido. Completar eventos de investigação não finalizados durante o evento também permitirá receber recompensas de investigação equivalentes às do período do evento. Se \"Visão de Sonhos Estranhos: Adeus, Terra do Nunca\" não foi desbloqueada durante o evento, ainda será possível desbloqueá-la após o término do evento consumindo \"Ponto de partida real\" * 7. \n3. Independentemente de estar ou não durante o evento, após completar \"Visão de Sonhos Estranhos: Adeus, Terra do Nunca\", você receberá a \"Chave: Momento de Sonho Bonito\"."
  },
  Activity_97853_BannerText = {
    Text = "Evento por Tempo Limitado Agora Disponível!"
  },
  Activity_97854_ActivityName = {
    Text = "Evento de Desbloqueio Gratuito"
  },
  Activity_97950_ActivityName = {
    Text = "Jornada de Pesquisa e Mapeamento"
  },
  Activity_97950_ActivityPromotionalText1 = {
    Text = "Aumentar a recompensa em moeda do evento na fase \"Nada de novo sob a luz do sol\" em 100%"
  },
  Activity_97950_ActivityTips = {
    Text = "Regras do evento: \n1. Após completar as tarefas designadas, os Guardiões do Segredo podem coletar recompensas em \"Registro de Mapeamento\". \n2. Após desbloquear \"Jornada Avançada\", recompensas extras podem ser obtidas após completar as missões. \n3. A compra da \"Jornada Avançada\" deste evento tem um tempo limitado, após o qual não será mais possível comprá-la. Por favor, os Guardiões do Segredo devem considerar a compra até às 9:00 do dia 17 de novembro. \n4. Atenção: a \"Jornada Avançada\" desbloqueada neste evento é válida apenas durante o evento. Os Guardiões do Segredo devem consumir de forma racional."
  },
  Activity_97950_BannerText = {
    Text = "Jornada Especial de Evento com Duração Limitada!"
  },
  Activity_97995_ActivityName = {
    Text = "Sem doces, sem travessuras!"
  },
  Activity_97995_ActivityTips = {
    Text = "<Title:Introdução>\nChamas de vela estranhas, uma festa animada, a pequena bruxa caçadora de doces faz uma grandiosa aparição cercada por fantasmas!\n\"Assalto! Coloque todos os seus doces - caramelo, chocolate, balas de leite, gomas de fruta... cough! Enfim, coloque todos os doces para mim!\"\n\"Você diz que é difícil guardar algodão doce? Ugh... me dê, eu vou eliminá-los agora mesmo!\"\n\n<Title:Regras do Evento>\n1. Durante o evento, os Guardiões do Segredo podem usar o \"Doce de Abóbora Estranha\" para sortear a nova Roupa Fantasma 4 estrelas \"Roubo de Doces\".\n2. O primeiro sorteio é grátis! Cada \"Doce de Abóbora Estranha\" custa \"Líquido de origem\" ×60 para comprar, e do 2º ao 10º sorteio precisa de \"Doce de Abóbora Estranha\" ×1/2/2/3/5/5/5/5/5.\n3. A partir do 5º sorteio, há uma chance de ganhar a Roupa Fantasma 4 estrelas, e ao sortear 10 vezes, você garantirá a Roupa Fantasma 4 estrelas do evento.\n4. Após o término do evento, os \"Doces de Abóbora Estranha\" restantes serão coletados por e-mail e devolvidos pelo preço original."
  },
  Activity_97995_BannerText = {
    Text = "Evento de Fantasia por Tempo Limitado!"
  },
  Activity_98445_ActivityName = {
    Text = "Artista Eterno"
  },
  Activity_98445_ActivityTips = {
    Text = "<Title:Regras do Evento>\n·Durante o evento \"Eternal Performer\", os Guardiões podem usar equipes predefinidas pelo sistema que incluem Hameln para experimentar níveis designados infinitamente.\n·Ao experimentar os níveis do evento, ajustes aos Despertadores na formação da equipe não são permitidos.\n<Title:Recompensas do Evento>\n·Após completar com sucesso o desafio de nível pela primeira vez, os jogadores podem reivindicar recompensas de teste na interface do evento."
  },
  Activity_98446_ActivityName = {
    Text = "Brilho de Mareel"
  },
  Activity_98446_ActivityTips = {
    Text = "<Title:Regras do evento>\n· Durante o evento \"Luz Fria\", os Guardiões podem usar equipes pré-configuradas do sistema contendo Kephasant para repetir ilimitadamente as fases designadas.\n· Ao participar das fases do evento, não será possível ajustar os Despertados na formação da equipe.\n<Title:Recompensas do evento>\n· Após completar o desafio da fase pela primeira vez, será possível coletar a recompensa de teste na interface do evento."
  },
  Activity_99296_ActivityName = {
    Text = "Nós, finalmente, nos reencontraremos"
  },
  Activity_99296_ActivityPlot = {
    Text = "Faça login diariamente para receber a Roda do Destino SSR comemorativa \"Nós, finalmente, nos reencontraremos\", totalizando 16 unidades!"
  },
  Activity_99296_ActivityTips = {
    Text = "<Title:Descrição>\nEsta é uma poesia dedicada aos jogadores, sobre ideais, sobre crenças, sobre os tempos de caminhar juntos. Que o coração sincero nunca pare de bater, que a Chave de Prata guie o caminho. \n\n<Title:Regras do evento>\n·Durante o evento, os Guardiões do Segredo podem coletar diariamente a Roda do Destino SSR exclusiva \"Nós, finalmente, nos reencontraremos\" em \"Nós, finalmente, nos reencontraremos\", totalizando 16 coletas. \n·As recompensas serão desbloqueadas conforme o login acumulado dos Guardiões do Segredo, e o check-in diário será resetado às 9h (GMT+8)."
  },
  Activity_99296_BannerText = {
    Text = "Roda do destino SSR Limitada Grátis"
  }
})
return Text_Activity
