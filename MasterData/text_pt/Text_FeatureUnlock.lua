__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_FeatureUnlock = readonly({
  FeatureUnlock_100551_LockTip = {
    Text = "Desbloqueia após completar \"Operação de Investigação\" 3-10·Normal"
  },
  FeatureUnlock_100552_LockTip = {
    Text = "Desbloqueado após completar \"Operação de Investigação\" 2-15 · Normal"
  },
  FeatureUnlock_116229_LockTip = {
    Text = "<Posse:Desbloqueado após completar \"Adeus à Terra do Nunca\"·normal>"
  },
  FeatureUnlock_116599_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_116600_FeatureName = {
    Text = "Atividade de Pólux"
  },
  FeatureUnlock_119961_FeatureName = {
    Text = "Loja de Trocas"
  },
  FeatureUnlock_119961_LockTip = {
    Text = "Concluir Prólogo Desbloqueado"
  },
  FeatureUnlock_120493_FeatureName = {
    Text = "\"Operação de Investigação\"Capítulo das Estrelas 4"
  },
  FeatureUnlock_120493_LockTip = {
    Text = "Completar a \"Operação de investigação\" Capítulo 3 · normal da série Estrelas para desbloquear"
  },
  FeatureUnlock_120493_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Operação de Investigação \"O Momento da Posição Normal das Estrelas · Paraíso\" Aberta>\n\n<FeatureUnlockDesc:Após meses à deriva no mar seguindo as pistas de William, você se depara com uma tempestade estranha e imprevisível...>"
  },
  FeatureUnlock_120494_FeatureName = {
    Text = "\"Operação de Investigação\"Capítulo das Estrelas 4 · Dificuldade"
  },
  FeatureUnlock_120494_LockTip = {
    Text = "Completar a \"Operação de investigação\" Capítulo das Estrelas 3 · Dificuldade e capítulo 4 · normal para desbloquear"
  },
  FeatureUnlock_120494_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Operação de Investigação \"Paraíso\"·Dificuldade Difícil desbloqueada>"
  },
  FeatureUnlock_120989_LockTip = {
    Text = "Ainda não disponível"
  },
  FeatureUnlock_120990_LockTip = {
    Text = "<Posse:complete a \"Operação de investigação\" Capítulo das Estrelas 4·normal para desbloquear>"
  },
  FeatureUnlock_120991_LockTip = {
    Text = "<Posse:complete a \"Cântico das Estrelas\"·normal para desbloquear>"
  },
  FeatureUnlock_122563_FeatureName = {
    Text = "Evento Mouchette"
  },
  FeatureUnlock_122564_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_123278_LockTip = {
    Text = "Desbloqueado após completar \"Batismo de Prata e Sangue\": Normal"
  },
  FeatureUnlock_123279_LockTip = {
    Text = "Ainda não disponível"
  },
  FeatureUnlock_125344_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_125345_FeatureName = {Text = "Evento Xu"},
  FeatureUnlock_126274_FeatureName = {
    Text = "Evento Arachne"
  },
  FeatureUnlock_126363_FeatureName = {
    Text = "\"Investigação\" Reinado Astral Capítulo 5"
  },
  FeatureUnlock_126363_LockTip = {
    Text = "Desbloqueia após completar \"Investigação\" Reinado Astral Capítulo 4: Normal"
  },
  FeatureUnlock_126363_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Operação de investigação \"O momento da posição correta das estrelas · Teatro do Destino\" desbloqueada>\n\n<FeatureUnlockDesc:Através da porta do dia negro, você voltou àquela cidade familiar, e tudo isso é apenas um palco personalizado...>"
  },
  FeatureUnlock_126364_FeatureName = {
    Text = "\"Investigação\" Reinado Astral Capítulo 5: Difícil"
  },
  FeatureUnlock_126364_LockTip = {
    Text = "Desbloqueia após completar \"Investigação\" Reinado Astral Capítulo 4: Difícil e Capítulo 5: Normal"
  },
  FeatureUnlock_126364_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Operação de investigação \"Teatro do Destino\" · Dificuldade Difícil desbloqueada>"
  },
  FeatureUnlock_128099_FeatureName = {Text = "Fliperama"},
  FeatureUnlock_128099_LockTip = {
    Text = "Complete \"Operação de Investigação\" 1-2 ・Normal desbloqueado"
  },
  FeatureUnlock_129487_FeatureName = {
    Text = "Trem de Alegria Acelerado"
  },
  FeatureUnlock_129507_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_129645_LockTip = {
    Text = "Complete \"Operação de Investigação\" 1-2 ・Normal desbloqueado"
  },
  FeatureUnlock_130172_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_130173_FeatureName = {
    Text = "Evento Shaye"
  },
  FeatureUnlock_130899_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_130900_FeatureName = {
    Text = "Evento Mosk"
  },
  FeatureUnlock_133714_FeatureName = {
    Text = "Notas do domínio"
  },
  FeatureUnlock_133714_LockTip = {
    Text = "Complete \"Operação de Investigação\" 1-11 ・Normal desbloqueado"
  },
  FeatureUnlock_133714_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Notas do domínio Pode ser coletado!>\n\n<FeatureUnlockDesc:Rotinas de treinamento básicas estabelecidas pela Misaq para manter os Investigadores em sua melhor forma.>"
  },
  FeatureUnlock_134019_FeatureName = {
    Text = "Treinamento Semanal"
  },
  FeatureUnlock_134019_LockTip = {
    Text = "Complete \"Operação de Investigação\" 1-11 ・Normal desbloqueado"
  },
  FeatureUnlock_134020_FeatureName = {
    Text = "Exercícios Diários"
  },
  FeatureUnlock_134020_LockTip = {
    Text = "Complete \"Operação de Investigação\" 1-11 ・Normal desbloqueado"
  },
  FeatureUnlock_140304_LockTip = {
    Text = "Desbloqueado após completar \"A Semente do Amor Esquecido\" · Normal"
  },
  FeatureUnlock_140305_LockTip = {
    Text = "Ainda não disponível"
  },
  FeatureUnlock_140473_FeatureName = {
    Text = "Prova Proibida"
  },
  FeatureUnlock_140473_LockTip = {
    Text = "Complete \"Operação de Investigação\" 1-11 ・Normal desbloqueado"
  },
  FeatureUnlock_141300_FeatureName = {
    Text = "Atividade de Pontos"
  },
  FeatureUnlock_141301_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_141798_FeatureName = {
    Text = "Atividade de Caraboo"
  },
  FeatureUnlock_143318_LockTip = {
    Text = "Ainda não disponível"
  },
  FeatureUnlock_143319_LockTip = {
    Text = "Desbloqueado após completar \"Ebwynnos Evermore\"·Normal"
  },
  FeatureUnlock_145361_FeatureName = {
    Text = "Evento Lotan: Cetarchon"
  },
  FeatureUnlock_145362_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_146356_FeatureName = {
    Text = "\"Operação de investigação\" Capítulo das Estrelas Capítulo 6"
  },
  FeatureUnlock_146356_LockTip = {
    Text = "Desbloqueie após concluir \"Operação de investigação\" Capítulo das Estrelas Capítulo 5 · Normal"
  },
  FeatureUnlock_146356_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Operação de investigação \"Quando a Montanha Festeja\": Desbloqueada>\n\n<FeatureUnlockDesc:Chacoalhando em um velho automóvel, você chega ao Continente do Norte Final, quatro mil metros acima do mundo. Aqui, no cume envolto em névoa da montanha gelada, um ritual sombrio aguarda os alpinistas.>"
  },
  FeatureUnlock_146357_FeatureName = {
    Text = "\"Operação de investigação\" Capítulo das Estrelas Capítulo 6 · Dificuldade"
  },
  FeatureUnlock_146357_LockTip = {
    Text = "Desbloqueie após concluir \"Operação de investigação\" Capítulo das Estrelas Capítulo 5 · Dificuldade e Capítulo 6 · Normal"
  },
  FeatureUnlock_146357_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Operação de investigação \"Quando a Montanha Festeja\" · Dificuldade foi desbloqueada>"
  },
  FeatureUnlock_147083_LockTip = {
    Text = "Desbloqueado após concluir \"Contos de Cinco Dias\"·Normal"
  },
  FeatureUnlock_147084_LockTip = {
    Text = "Ainda não disponível"
  },
  FeatureUnlock_147085_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_147086_FeatureName = {
    Text = "Atividade de Origem Ogier"
  },
  FeatureUnlock_147392_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_147393_LockTip = {
    Text = "Ainda não disponível"
  },
  FeatureUnlock_147394_LockTip = {
    Text = "Desbloqueie após concluir \"Texto Temporário\"·Normal."
  },
  FeatureUnlock_147395_FeatureName = {
    Text = "Atividade de Tinct: Vespera"
  },
  FeatureUnlock_147801_FeatureName = {
    Text = "Sintoma: Crash de Material"
  },
  FeatureUnlock_147801_LockTip = {
    Text = "Concluir Prólogo Desbloqueado"
  },
  FeatureUnlock_148487_FeatureName = {
    Text = "Transcrição Automática do Pacto"
  },
  FeatureUnlock_148487_LockTip = {
    Text = "Nível de Investigação 45 Desbloqueado"
  },
  FeatureUnlock_148488_FeatureName = {
    Text = "Imobilização de Mystik"
  },
  FeatureUnlock_148488_LockTip = {
    Text = "Desbloqueado no Nível 60 da Operação de investigação"
  },
  FeatureUnlock_148488_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Fusão de Pacto Desbloqueada>\n\n<FeatureUnlockDesc:O Misaq decifrou em textos antigos uma fórmula de fusão para inscrever pactos em núcleos espirituais, capaz de ampliar consideravelmente os efeitos de amplificação dos pactos. Experimente.\nFunda um pacto com um Corpo Desperto para obter bônus adicionais nos atributos primários.>"
  },
  FeatureUnlock_16955_FeatureName = {
    Text = "Síntese de materiais"
  },
  FeatureUnlock_16955_LockTip = {
    Text = "Desbloqueado após completar \"Operação de Investigação\" 2-15 · Normal"
  },
  FeatureUnlock_16956_LockTip = {
    Text = "Concluir Prólogo para desbloquear"
  },
  FeatureUnlock_16957_FeatureName = {
    Text = "Extração de líquido fonte"
  },
  FeatureUnlock_16957_LockTip = {
    Text = "Concluir Prólogo para desbloquear"
  },
  FeatureUnlock_16958_FeatureName = {
    Text = "\"Operação de Investigação\" Capítulo 2"
  },
  FeatureUnlock_16958_LockTip = {
    Text = "Desbloqueado após completar \"Operação de Investigação\" Capítulo 1·Normal"
  },
  FeatureUnlock_16958_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Operação de Investigação \"Em Nome da Cera\" Aberta>\n\n<FeatureUnlockDesc:Seguindo as pistas de Jenkins, vocês decidem ir ao nº 44 da Rua Southwark para descobrir a verdade por trás das estátuas de cera...>"
  },
  FeatureUnlock_16959_FeatureName = {
    Text = "\"Operação de Investigação\" Capítulo 3"
  },
  FeatureUnlock_16959_LockTip = {
    Text = "Desbloqueado após completar \"Operação de Investigação\" Capítulo 2·Normal"
  },
  FeatureUnlock_16959_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Operação de Investigação \"Cuidado com Cães Agressivos\" Aberta>\n\n<FeatureUnlockDesc:Seguindo os rumores do cão do inferno \"Cérbero\", os investigadores de Misaq chegaram à cidade de Rai, nos arredores de Londinium, para desvendar os segredos por trás dos desaparecimentos...>"
  },
  FeatureUnlock_16960_FeatureName = {
    Text = "Cidade Anômala"
  },
  FeatureUnlock_16960_LockTip = {
    Text = "Desbloqueia após completar \"Operação de Investigação\" Capítulo 3 · Normal"
  },
  FeatureUnlock_16961_FeatureName = {
    Text = "Jornada ultradimensional · Fissura de rotação"
  },
  FeatureUnlock_16961_LockTip = {
    Text = "Vença a Jornada Ultra·Fissura VIII para desbloquear"
  },
  FeatureUnlock_16962_FeatureName = {
    Text = "Jornada ultradimensional · Fissura de rotação"
  },
  FeatureUnlock_16962_LockTip = {
    Text = "Vença a Jornada Ultra·Fissura VIII para desbloquear"
  },
  FeatureUnlock_16963_FeatureName = {
    Text = "Jornada ultradimensional · Fissura de rotação"
  },
  FeatureUnlock_16963_LockTip = {
    Text = "Vença a Jornada Ultra·Fissura VIII para desbloquear"
  },
  FeatureUnlock_16964_FeatureName = {
    Text = "Cadeia de Escuridão"
  },
  FeatureUnlock_16964_LockTip = {
    Text = "Desbloqueia após completar \"Operação de Investigação\" Capítulo 3 · Normal"
  },
  FeatureUnlock_16965_FeatureName = {
    Text = "Desintegração do pacto"
  },
  FeatureUnlock_16965_LockTip = {
    Text = "Nível de Investigação 25 Desbloqueado"
  },
  FeatureUnlock_16966_FeatureName = {Text = "Guia"},
  FeatureUnlock_16966_LockTip = {
    Text = "Concluir Prólogo Desbloqueado"
  },
  FeatureUnlock_16967_FeatureName = {
    Text = "Prólogo da Missão Principal"
  },
  FeatureUnlock_16968_FeatureName = {
    Text = "Missão Principal"
  },
  FeatureUnlock_16969_FeatureName = {
    Text = "Montanhas do Caos"
  },
  FeatureUnlock_16969_LockTip = {
    Text = "Desbloqueia após completar \"Operação de Investigação\" Capítulo 4 · Normal"
  },
  FeatureUnlock_16970_FeatureName = {
    Text = "Reino sem luz"
  },
  FeatureUnlock_16970_LockTip = {
    Text = "Desbloqueado após completar \"Operação de Investigação\" 2-4 · Normal"
  },
  FeatureUnlock_16970_UnlockDesc = {
    Text = "<FeatureUnlockTitle: Reino Sombrio desbloqueado>\n\n<FeatureUnlockDesc: Encontre a verdade em uma visão sombria.\n O guardião pode enviar equipes de diferentes reinos para enfrentar desafios e obter recompensas abundantes.>"
  },
  FeatureUnlock_16971_FeatureName = {
    Text = "\"Operação de Investigação\" Capítulo 5 · Loucura"
  },
  FeatureUnlock_16971_LockTip = {Text = "Aguarde"},
  FeatureUnlock_16971_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Operação \"Olho da Tempestade\" · Nível de Dificuldade Loucura Desbloqueado>"
  },
  FeatureUnlock_16972_FeatureName = {
    Text = "Mergulho Fantasmal"
  },
  FeatureUnlock_16972_LockTip = {
    Text = "Desbloqueado após completar \"Operação de Investigação\" 2-12·Normal"
  },
  FeatureUnlock_16972_UnlockDesc = {
    Text = "<FeatureUnlockTitle: Mergulho Fantasmal agora desbloqueado>\n\n<FeatureUnlockDesc: Esse é um sonho antigo de seres superiores.\n Durante o mergulho, o guardião deve superar a alta pressão da ressonância negativa. Diferentes desafios esperam por você a cada dia.>"
  },
  FeatureUnlock_16973_FeatureName = {
    Text = "\"Operação de Investigação\" Capítulo 3 · Loucura"
  },
  FeatureUnlock_16973_LockTip = {Text = "Aguarde"},
  FeatureUnlock_16973_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Operação \"Cuidado com os Cães\" · Dificuldade Loucura foi desbloqueada>"
  },
  FeatureUnlock_16977_FeatureName = {
    Text = "\"Operação de Investigação\" Capítulo 4"
  },
  FeatureUnlock_16977_LockTip = {
    Text = "Desbloqueia após completar \"Operação de Investigação\" Capítulo 3 · Normal"
  },
  FeatureUnlock_16977_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Operação de Investigação \"No Silêncio\" Aberta>\n\n<FeatureUnlockDesc:O sanatório espiritual de Rai não será um lar feliz. Para desvendar o véu da disfarce, os investigadores devem se aprofundar...>"
  },
  FeatureUnlock_16978_FeatureName = {
    Text = "Museu de Cera Enlouquecido"
  },
  FeatureUnlock_16978_LockTip = {
    Text = "Desbloqueado após completar \"Operação de Investigação\" Capítulo 2·Normal"
  },
  FeatureUnlock_16979_FeatureName = {
    Text = "\"\"Investigação da Operação\" Capítulo 5"
  },
  FeatureUnlock_16979_LockTip = {
    Text = "Desbloqueia após completar \"Operação de Investigação\" Capítulo 4 · Normal"
  },
  FeatureUnlock_16979_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Operação de Investigação \"Olho da Tempestade\" Aberta>\n\n<FeatureUnlockDesc:Navios estranhos, garotas estranhas, inimigos estranhos. À deriva no mar, os investigadores enfrentam uma luta contra o destino...>"
  },
  FeatureUnlock_16980_FeatureName = {
    Text = "Atualização do pacto"
  },
  FeatureUnlock_16980_LockTip = {
    Text = "Nível de Investigação 35 Desbloqueado"
  },
  FeatureUnlock_16980_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Função de Melhoria do Mystik desbloqueada>\n\n<FeatureUnlockDesc:O Mystik nunca se mostra em sua verdadeira forma, você precisa esperar pacientemente pelo dia em que ele se formará.\nOs Guardiões do Segredo podem melhorar o Mystik na interface de reforço do Mystik, aumentando assim seu atributo principal.>"
  },
  FeatureUnlock_16981_FeatureName = {
    Text = "Domínio de área"
  },
  FeatureUnlock_16981_LockTip = {
    Text = "Complete \"Investigação\" 1-5·Normal para desbloquear"
  },
  FeatureUnlock_16982_FeatureName = {
    Text = "O segredo das figuras de cera"
  },
  FeatureUnlock_16982_LockTip = {
    Text = "Desbloqueia após completar \"Operação de Investigação\" 3-10·Normal"
  },
  FeatureUnlock_16983_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_16984_FeatureName = {
    Text = "\"Operação de Investigação\" Capítulo 6"
  },
  FeatureUnlock_16984_LockTip = {
    Text = "Desbloqueado após completar \"Operação de Investigação\" Capítulo 5·Normal"
  },
  FeatureUnlock_16984_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Operação de Investigação \"Estrelas Distorcidas\" Aberta>\n\n<FeatureUnlockDesc:O Sonanil é uma ilha móvel de Creta, carregando a esperança de todos para a liberdade...>"
  },
  FeatureUnlock_16985_FeatureName = {
    Text = "Registro Proibido"
  },
  FeatureUnlock_16985_LockTip = {
    Text = "Nível de Investigação 25 Desbloqueado"
  },
  FeatureUnlock_16985_UnlockDesc = {
    Text = "<FeatureUnlockTitle: Registro de Tabu desbloqueado>\n\n<FeatureUnlockDesc: Na Era das Trevas, esses símbolos eram proibidos de serem copiados e transcritos.\n Rastreie o passado do tabu e obtenha mais conjuntos de pactos.>"
  },
  FeatureUnlock_16986_FeatureName = {
    Text = "\"Operação de Investigação\" Capítulo 6 · Loucura"
  },
  FeatureUnlock_16986_LockTip = {Text = "Aguarde"},
  FeatureUnlock_16986_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Operação \"Estrelas Retorcidas\" · A dificuldade Loucura foi desbloqueada>"
  },
  FeatureUnlock_16988_FeatureName = {
    Text = "Ninho de Vermes"
  },
  FeatureUnlock_16988_LockTip = {
    Text = "Nível de Investigação 20 desbloqueado"
  },
  FeatureUnlock_16989_FeatureName = {
    Text = "\"Operação de Investigação\" Capítulo 2 · Loucura"
  },
  FeatureUnlock_16989_LockTip = {Text = "Aguarde"},
  FeatureUnlock_16989_UnlockDesc = {
    Text = "<FeatureUnlockTitle: Ação de Investigação \"Em Nome da Escultura de Cera\" · Dificuldade Loucura desbloqueada>"
  },
  FeatureUnlock_16990_FeatureName = {
    Text = "Domínio do caos·Interstício rotativo"
  },
  FeatureUnlock_16990_LockTip = {
    Text = "Vença o Domínio do Caos·Fissura VIII para desbloquear"
  },
  FeatureUnlock_16991_FeatureName = {
    Text = "Interlúdio"
  },
  FeatureUnlock_16991_LockTip = {
    Text = "Complete \"Operação de Investigação\" 1-2 ・Normal desbloqueado"
  },
  FeatureUnlock_16991_UnlockDesc = {
    Text = "<FeatureUnlockTitle: Interlúdio desbloqueado>\n\n<FeatureUnlockDesc: Em uma era de frequentes desastres, vocês só podem mergulhar nos sonhos antigos para escavar maravilhas do passado.\n Vá até o passado destruído para realizar testes e obter mais materiais.>"
  },
  FeatureUnlock_16992_FeatureName = {
    Text = "Domínio do caos·Interstício rotativo"
  },
  FeatureUnlock_16992_LockTip = {
    Text = "Vença o Domínio do Caos·Fissura VIII para desbloquear"
  },
  FeatureUnlock_16993_LockTip = {
    Text = "Ainda não disponível"
  },
  FeatureUnlock_16994_FeatureName = {
    Text = "Cidade da Névoa Monstruosa"
  },
  FeatureUnlock_16994_LockTip = {
    Text = "Desbloqueado após completar \"Operação de Investigação\" Capítulo 1·Normal"
  },
  FeatureUnlock_16996_FeatureName = {
    Text = "Grieta piadosa"
  },
  FeatureUnlock_16996_LockTip = {
    Text = "Desbloqueado após completar \"Operação de Investigação\" Capítulo 5·Normal"
  },
  FeatureUnlock_16998_FeatureName = {
    Text = "Ruínas de Ponape"
  },
  FeatureUnlock_16998_LockTip = {
    Text = "Nível de Investigação 20 desbloqueado"
  },
  FeatureUnlock_17000_FeatureName = {
    Text = "Registro de Crescimento"
  },
  FeatureUnlock_17000_LockTip = {
    Text = "Complete \"Investigação\" 1-5·Normal para desbloquear"
  },
  FeatureUnlock_17001_FeatureName = {
    Text = "Treinamento de Corrosão Insana (em desenvolvimento)"
  },
  FeatureUnlock_17001_LockTip = {Text = "Aguarde"},
  FeatureUnlock_17002_FeatureName = {
    Text = "Troca de Cupom de Ouro"
  },
  FeatureUnlock_17002_LockTip = {
    Text = "Complete \"Operação de Investigação\" 1-2 ・Normal desbloqueado"
  },
  FeatureUnlock_17003_FeatureName = {
    Text = "\"Operação de Investigação\" Capítulo 4 · Difícil"
  },
  FeatureUnlock_17003_LockTip = {
    Text = "Desbloquear após completar \"Operação\" Capítulo 3 · Difícil e Capítulo 4 · Normal"
  },
  FeatureUnlock_17003_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Operação de Investigação \"No Silêncio\"·Dificuldade Difícil Aberta>"
  },
  FeatureUnlock_17004_FeatureName = {
    Text = "Garganta de Schwarzschild"
  },
  FeatureUnlock_17004_LockTip = {
    Text = "Nível de Investigação 20 desbloqueado"
  },
  FeatureUnlock_17005_FeatureName = {
    Text = "Interlúdio (em desenvolvimento)"
  },
  FeatureUnlock_17005_LockTip = {Text = "Aguarde"},
  FeatureUnlock_17006_FeatureName = {
    Text = "Resíduo orgânico"
  },
  FeatureUnlock_17006_LockTip = {
    Text = "Complete \"Operação de Investigação\" 1-13 ・Normal desbloqueado"
  },
  FeatureUnlock_17007_FeatureName = {
    Text = "Resíduo dimensional"
  },
  FeatureUnlock_17007_LockTip = {
    Text = "Complete \"Operação de Investigação\" 1-13 ・Normal desbloqueado"
  },
  FeatureUnlock_17008_FeatureName = {Text = "Currículo"},
  FeatureUnlock_17008_LockTip = {
    Text = "Complete \"Operação de Investigação\" 1-11 ・Normal desbloqueado"
  },
  FeatureUnlock_17008_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Registro de temas Desbloqueado>\n\n<FeatureUnlockDesc:Guardiões do segredo também têm provas finais.\nComplete as missões para aumentar o nível e desbloqueie recompensas.>"
  },
  FeatureUnlock_17009_FeatureName = {
    Text = "Pântano de carne e sangue · Fissura"
  },
  FeatureUnlock_17009_LockTip = {
    Text = "Desbloqueado após completar \"Operação de Investigação\" 2-4 · Normal"
  },
  FeatureUnlock_17010_LockTip = {
    Text = "Desbloqueia após completar \"Sombras da Cidade da Chuva\" · Normal"
  },
  FeatureUnlock_17011_FeatureName = {
    Text = "Sombra além dos limites"
  },
  FeatureUnlock_17011_LockTip = {
    Text = "Desbloqueia após completar \"Operação de Investigação\" Capítulo 4 · Normal"
  },
  FeatureUnlock_17012_FeatureName = {Text = "Biblioteca"},
  FeatureUnlock_17012_LockTip = {
    Text = "Concluir Prólogo para desbloquear"
  },
  FeatureUnlock_17013_FeatureName = {
    Text = "Troca de Sedimentação"
  },
  FeatureUnlock_17013_LockTip = {
    Text = "Concluir Prólogo Desbloqueado"
  },
  FeatureUnlock_17014_FeatureName = {
    Text = "Reimpressão do pacto"
  },
  FeatureUnlock_17014_LockTip = {Text = "Aguarde"},
  FeatureUnlock_17015_FeatureName = {Text = "Despertar"},
  FeatureUnlock_17015_LockTip = {
    Text = "Concluir Prólogo Desbloqueado"
  },
  FeatureUnlock_17015_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Cerimônia de Despertar desbloqueada>\n\n<FeatureUnlockDesc:Você pode usar \"Núcleo Imaculado\" e \"Núcleo de Lumen\" para obter o Corpo Desperto e a Roda do Destino.\nAtravés da Cerimônia de Despertar, você também pode obter \"sedimento fundamental\" para trocar por materiais raros na Loja de Misaka.>"
  },
  FeatureUnlock_17016_FeatureName = {Text = "Alquimia"},
  FeatureUnlock_17016_LockTip = {
    Text = "Concluir Prólogo Desbloqueado"
  },
  FeatureUnlock_17017_FeatureName = {
    Text = "Resíduo das Profundezas"
  },
  FeatureUnlock_17017_LockTip = {
    Text = "Complete \"Operação de Investigação\" 1-13 ・Normal desbloqueado"
  },
  FeatureUnlock_17017_UnlockDesc = {
    Text = "<FeatureUnlockTitle: Ruínas da Dissolução: Materiais de Upgrade Desbloqueados>\n\n<FeatureUnlockDesc:Imagens de remanescentes de vários Reinos surgiram nas Ruínas da Dissolução. Registre-os por escrito antes que se dispersem.>"
  },
  FeatureUnlock_17018_FeatureName = {
    Text = "Despertar Espiritual"
  },
  FeatureUnlock_17019_LockTip = {
    Text = "Ainda não disponível"
  },
  FeatureUnlock_17020_FeatureName = {
    Text = "Navegação na consciência"
  },
  FeatureUnlock_17020_LockTip = {
    Text = "Concluir Prólogo para desbloquear"
  },
  FeatureUnlock_17021_LockTip = {
    Text = "Complete \"Sangue e Areia\" · Normal para desbloquear"
  },
  FeatureUnlock_17022_FeatureName = {Text = "Alunos"},
  FeatureUnlock_17022_LockTip = {
    Text = "Concluir Prólogo para desbloquear"
  },
  FeatureUnlock_17023_FeatureName = {
    Text = "Compra de Silver Core"
  },
  FeatureUnlock_17023_LockTip = {
    Text = "Concluir Prólogo Desbloqueado"
  },
  FeatureUnlock_17024_FeatureName = {
    Text = "Troca de Imersão Profunda"
  },
  FeatureUnlock_17024_LockTip = {
    Text = "Desbloqueado após completar \"Operação de Investigação\" 2-12·Normal"
  },
  FeatureUnlock_17025_FeatureName = {
    Text = "\"Operação de Investigação\" Capítulo 2 · Difícil"
  },
  FeatureUnlock_17025_LockTip = {
    Text = "Complete \"Operação de Investigação\" 1-8 ・Difícil desbloqueado"
  },
  FeatureUnlock_17025_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Operação de Investigação \"Em Nome da Cera\"·Dificuldade Difícil Aberta>"
  },
  FeatureUnlock_17026_LockTip = {
    Text = "Nível de Investigação 35 Desbloqueado"
  },
  FeatureUnlock_17027_LockTip = {
    Text = "Nível de Investigação 25 Desbloqueado"
  },
  FeatureUnlock_17028_LockTip = {
    Text = "Nível de Investigação 45 Desbloqueado"
  },
  FeatureUnlock_17029_LockTip = {
    Text = "Nível de Investigação 45 Desbloqueado"
  },
  FeatureUnlock_17030_LockTip = {
    Text = "Nível de Investigação 35 Desbloqueado"
  },
  FeatureUnlock_17031_FeatureName = {
    Text = "Domínio do caos·Interstício rotativo"
  },
  FeatureUnlock_17031_LockTip = {
    Text = "Vença o Domínio do Caos·Fissura VIII para desbloquear"
  },
  FeatureUnlock_17032_LockTip = {
    Text = "Concluir Prólogo Desbloqueado"
  },
  FeatureUnlock_17033_FeatureName = {
    Text = "Mar de Tempestade Exterior"
  },
  FeatureUnlock_17033_LockTip = {
    Text = "Desbloqueia após completar \"Operação de Investigação\" Capítulo 6 · Normal"
  },
  FeatureUnlock_17034_FeatureName = {
    Text = "Caixa de correio"
  },
  FeatureUnlock_17034_LockTip = {
    Text = "Concluir Prólogo Desbloqueado"
  },
  FeatureUnlock_17035_FeatureName = {
    Text = "Cluster caótico"
  },
  FeatureUnlock_17035_LockTip = {
    Text = "Nível de Investigação 20 desbloqueado"
  },
  FeatureUnlock_17035_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Ruínas da Dissolução: Materiais de Habilidade Desbloqueados>\n\n<FeatureUnlockDesc: Cansado de provas mundanas, desta vez você mergulhará nas profundezas da consciência além dos eons...\nUtilize as características do Reino para obter facilmente os materiais necessários para as atualizações de Habilidade do Despertador.>"
  },
  FeatureUnlock_17036_FeatureName = {Text = "Evento"},
  FeatureUnlock_17036_LockTip = {
    Text = "Complete \"Operação de Investigação\" 1-2 ・Normal desbloqueado"
  },
  FeatureUnlock_17036_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Evento Ativado>\n\nOs Guardiões do Segredo podem participar de atividades de benefícios e eventos especiais aqui, completar missões e receber recompensas!"
  },
  FeatureUnlock_17037_FeatureName = {
    Text = "Registro da força-tarefa"
  },
  FeatureUnlock_17037_LockTip = {
    Text = "Concluir Prólogo para desbloquear"
  },
  FeatureUnlock_17038_FeatureName = {
    Text = "\"Operação de Investigação\" Capítulo 5 · Difícil"
  },
  FeatureUnlock_17038_LockTip = {
    Text = "Desbloquear após completar \"Operação\" Capítulo 4 · Difícil e Capítulo 5 · Normal"
  },
  FeatureUnlock_17038_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Operação de Investigação \"Olho da Tempestade\"·Dificuldade Difícil Aberta>"
  },
  FeatureUnlock_17039_FeatureName = {
    Text = "Canto do Feto Sagrado"
  },
  FeatureUnlock_17039_LockTip = {
    Text = "Desbloqueia após completar \"Operação de Investigação\" Capítulo 6 · Normal"
  },
  FeatureUnlock_17040_FeatureName = {Text = "Registros"},
  FeatureUnlock_17040_LockTip = {
    Text = "Concluir Prólogo Desbloqueado"
  },
  FeatureUnlock_17041_FeatureName = {
    Text = "Ruínas de Fusão"
  },
  FeatureUnlock_17041_LockTip = {
    Text = "Complete \"Operação de Investigação\" 1-2 ・Normal desbloqueado"
  },
  FeatureUnlock_17041_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Ruínas de Fusão: Busca de cupons de ouro/Preparação e tempera desbloqueados>\n\n<FeatureUnlockDesc:Procure por relíquias entre os destroços da dissolução, que podem ser trocadas por cupons de ouro rosa ou elixires de gnose na secretaria de Misaq.>"
  },
  FeatureUnlock_17042_FeatureName = {Text = "Sociedade"},
  FeatureUnlock_17042_LockTip = {Text = "Aguarde"},
  FeatureUnlock_17043_FeatureName = {
    Text = "Transcrição do pacto"
  },
  FeatureUnlock_17043_LockTip = {
    Text = "Nível de Investigação 45 Desbloqueado"
  },
  FeatureUnlock_17043_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Função de Transcrição do Mystik desbloqueada>\n\n<FeatureUnlockDesc:Os escribas medievais eram condenados à morte por transcrever pactos, felizmente você agora está em uma era civilizada.\nOs Guardiões do Segredo podem escolher o tipo e o valor dos subatributos ao reforçar o Mystik.\nA transcrição não afeta o tipo e o valor do atributo principal do Mystik.>"
  },
  FeatureUnlock_17044_FeatureName = {
    Text = "\"Operação de Investigação\" Capítulo 3 · Difícil"
  },
  FeatureUnlock_17044_LockTip = {
    Text = "Desbloquear após completar \"Operação\" 3-5 · Normal e Capítulo 2 · Difícil"
  },
  FeatureUnlock_17044_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Operação \"Cuidado com os Cães\" · Dificuldade Difícil foi desbloqueada>"
  },
  FeatureUnlock_17045_FeatureName = {
    Text = "Desmontar roda do destino"
  },
  FeatureUnlock_17045_LockTip = {
    Text = "Concluir Prólogo Desbloqueado"
  },
  FeatureUnlock_17046_FeatureName = {
    Text = "Relatório de missão"
  },
  FeatureUnlock_17046_LockTip = {
    Text = "Complete \"Investigação\" 1-5·Normal para desbloquear"
  },
  FeatureUnlock_17047_FeatureName = {
    Text = "Resíduo turvo"
  },
  FeatureUnlock_17047_LockTip = {
    Text = "Complete \"Operação de Investigação\" 1-13 ・Normal desbloqueado"
  },
  FeatureUnlock_17048_FeatureName = {
    Text = "Loja de Pacotes"
  },
  FeatureUnlock_17048_LockTip = {
    Text = "Concluir Prólogo para desbloquear"
  },
  FeatureUnlock_17049_FeatureName = {
    Text = "Pântano de carne e sangue · Fissura rotativa"
  },
  FeatureUnlock_17049_LockTip = {
    Text = "Vença o Pântano de Carne·Fissura VIII para desbloquear"
  },
  FeatureUnlock_17050_FeatureName = {
    Text = "Pântano de carne e sangue · Fissura rotativa"
  },
  FeatureUnlock_17050_LockTip = {
    Text = "Vença o Pântano de Carne·Fissura VIII para desbloquear"
  },
  FeatureUnlock_17051_FeatureName = {
    Text = "Pântano de carne e sangue · Fissura rotativa"
  },
  FeatureUnlock_17051_LockTip = {
    Text = "Vença o Pântano de Carne·Fissura VIII para desbloquear"
  },
  FeatureUnlock_17052_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_17053_FeatureName = {
    Text = "Troca de Fase"
  },
  FeatureUnlock_17053_LockTip = {
    Text = "Desbloqueado após completar \"Operação de Investigação\" 3-2 · Normal"
  },
  FeatureUnlock_17054_FeatureName = {
    Text = "Fase de Duelo"
  },
  FeatureUnlock_17054_LockTip = {
    Text = "Desbloqueado após completar \"Operação de Investigação\" 3-2 · Normal"
  },
  FeatureUnlock_17054_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Fase de Armadilha Desbloqueada>\n\n<FeatureUnlockDesc:Quando diferentes fases de Prata começam a interagir e se entrelaçar, elas determinarão um único vencedor.\nEste modo é um recurso adicional de jogabilidade fornecido pelo jogo. Em busca de um ambiente de jogo mais interessante e equilibrado, a disponibilidade de cartas e a jogabilidade geral podem passar por mudanças significativas a cada temporada. Por favor, invista recursos neste modo com cautela.>"
  },
  FeatureUnlock_17055_FeatureName = {
    Text = "Substituição de materiais"
  },
  FeatureUnlock_17055_LockTip = {
    Text = "Desbloqueia após completar \"Operação de Investigação\" 3-10·Normal"
  },
  FeatureUnlock_17056_FeatureName = {
    Text = "\"Operação de Investigação\" · Loucura"
  },
  FeatureUnlock_17056_LockTip = {Text = "Aguarde"},
  FeatureUnlock_17056_UnlockDesc = {
    Text = "<FeatureUnlockTitle:\"Operação de Investigação\" · Dificuldade Loucura desbloqueada>"
  },
  FeatureUnlock_17057_LockTip = {
    Text = "Complete \"Operação de Investigação\" 1-2 ・Normal desbloqueado"
  },
  FeatureUnlock_17058_FeatureName = {Text = "Conquistas"},
  FeatureUnlock_17058_LockTip = {
    Text = "Complete \"Investigação\" 1-5·Normal para desbloquear"
  },
  FeatureUnlock_17059_LockTip = {
    Text = "Complete \"Operação de Investigação\" 1-2 ・Normal desbloqueado"
  },
  FeatureUnlock_17060_FeatureName = {
    Text = "Legado do profundo mar·Interstício rotativo"
  },
  FeatureUnlock_17060_LockTip = {
    Text = "Vença o Vazio do Mar Profundo·Fissura VIII para desbloquear"
  },
  FeatureUnlock_17061_FeatureName = {
    Text = "Legado do profundo mar·Interstício rotativo"
  },
  FeatureUnlock_17061_LockTip = {
    Text = "Vença o Vazio do Mar Profundo·Fissura VIII para desbloquear"
  },
  FeatureUnlock_17062_FeatureName = {
    Text = "Legado do profundo mar·Interstício rotativo"
  },
  FeatureUnlock_17062_LockTip = {
    Text = "Vença o Vazio do Mar Profundo·Fissura VIII para desbloquear"
  },
  FeatureUnlock_17063_FeatureName = {
    Text = "Jornada ultradimensional · Fissura"
  },
  FeatureUnlock_17063_LockTip = {
    Text = "Desbloqueado após completar \"Operação de Investigação\" 2-4 · Normal"
  },
  FeatureUnlock_17064_FeatureName = {
    Text = "\"Operação de Investigação\" Capítulo 1"
  },
  FeatureUnlock_17065_FeatureName = {
    Text = "Legado do profundo mar·Interstício"
  },
  FeatureUnlock_17065_LockTip = {
    Text = "Desbloqueado após completar \"Operação de Investigação\" 2-4 · Normal"
  },
  FeatureUnlock_17066_FeatureName = {
    Text = "\"Operação de Investigação\" Capítulo 4 · Loucura"
  },
  FeatureUnlock_17066_LockTip = {Text = "Aguarde"},
  FeatureUnlock_17066_UnlockDesc = {
    Text = "<FeatureUnlockTitle: Ação de Investigação \"No Silêncio\" · Dificuldade Loucura desbloqueada>"
  },
  FeatureUnlock_17067_FeatureName = {
    Text = "Domínio do caos·Interstício"
  },
  FeatureUnlock_17067_LockTip = {
    Text = "Desbloqueado após completar \"Operação de Investigação\" 2-4 · Normal"
  },
  FeatureUnlock_17068_FeatureName = {
    Text = "\"Operação de Investigação\" Capítulo 1 · Difícil"
  },
  FeatureUnlock_17068_LockTip = {
    Text = "Desbloquear após completar \"Investigação Operação\" 3-5 · Normal"
  },
  FeatureUnlock_17069_FeatureName = {
    Text = "\"Operação de Investigação\" · Difícil"
  },
  FeatureUnlock_17069_LockTip = {
    Text = "Desbloquear após completar \"Investigação Operação\" 3-5 · Normal"
  },
  FeatureUnlock_17069_UnlockDesc = {
    Text = "<FeatureUnlockTitle:\"Operação de Investigação\" · Dificuldade Difícil desbloqueada>"
  },
  FeatureUnlock_17070_FeatureName = {
    Text = "\"Operação de Investigação\" Capítulo 6 · Difícil"
  },
  FeatureUnlock_17070_LockTip = {
    Text = "Desbloquear após completar \"Operação\" Capítulo 5 · Difícil e Capítulo 6 · Normal"
  },
  FeatureUnlock_17070_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Operação de Investigação \"Estrelas Distorcidas\"·Dificuldade Difícil Aberta>"
  },
  FeatureUnlock_17071_FeatureName = {
    Text = "Barco das Águas Escuras"
  },
  FeatureUnlock_17071_LockTip = {
    Text = "Desbloqueado após completar \"Operação de Investigação\" Capítulo 5·Normal"
  },
  FeatureUnlock_17072_FeatureName = {
    Text = "Lágrimas de boneca"
  },
  FeatureUnlock_17072_LockTip = {
    Text = "Desbloqueia após completar \"Operação de Investigação\" 3-10·Normal"
  },
  FeatureUnlock_17073_FeatureName = {
    Text = "\"Operação de Investigação\" Capítulo 1 · Loucura"
  },
  FeatureUnlock_17073_LockTip = {Text = "Aguarde"},
  FeatureUnlock_17074_FeatureName = {
    Text = "Segunda vida"
  },
  FeatureUnlock_17074_LockTip = {
    Text = "Nível de Investigação 15 Desbloqueia Segundo Ciclo de Vida"
  },
  FeatureUnlock_17074_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Segunda Roda do Destino Desbloqueada>\n\n<FeatureUnlockDesc:Equipe uma segunda Roda aos Despertadores na interface da Roda. Máximo uma Roda de raridade SSR por Despertador. \nCombinações estratégicas podem melhorar muito as habilidades dos Despertadores.>"
  },
  FeatureUnlock_17075_FeatureName = {Text = "Envio"},
  FeatureUnlock_17075_LockTip = {
    Text = "Desbloqueado após completar \"Operação de Investigação\" 1-8·Normal"
  },
  FeatureUnlock_17075_UnlockDesc = {
    Text = "<FeatureUnlockTitle: Tarefas de Envio desbloqueadas>\n\n<FeatureUnlockDesc: Pequenas missões intercaladas entre investigações e deveres escolares.\n Envie despertadores para completar as tarefas e obtenha prata e vários materiais.>"
  },
  FeatureUnlock_20225_LockTip = {
    Text = "Desbloquear após completar \"Morte da Escultura\"·Normal"
  },
  FeatureUnlock_20226_LockTip = {
    Text = "Ainda não disponível"
  },
  FeatureUnlock_20227_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_20455_LockTip = {
    Text = "Desbloqueia após completar \"O Desejo do Cavaleiro\" · Normal"
  },
  FeatureUnlock_20456_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_20457_LockTip = {
    Text = "Ainda não disponível"
  },
  FeatureUnlock_20458_LockTip = {
    Text = "Complete \"Núcleo Torcido\" · Normal para desbloquear"
  },
  FeatureUnlock_20459_LockTip = {
    Text = "Ainda não disponível"
  },
  FeatureUnlock_20460_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_20461_LockTip = {
    Text = "Complete \"Senhor Pálido\" · Normal para desbloquear"
  },
  FeatureUnlock_20462_LockTip = {
    Text = "Ainda não disponível"
  },
  FeatureUnlock_20463_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_20785_FeatureName = {
    Text = "Troca de Investigação"
  },
  FeatureUnlock_20785_LockTip = {
    Text = "Complete \"Operação de Investigação\" 1-2 ・Normal desbloqueado"
  },
  FeatureUnlock_20786_FeatureName = {
    Text = "Troca Sem Luz"
  },
  FeatureUnlock_20786_LockTip = {
    Text = "Desbloqueado após completar \"Operação de Investigação\" 2-4 · Normal"
  },
  FeatureUnlock_21402_FeatureName = {
    Text = "Missão de Treinamento"
  },
  FeatureUnlock_21452_FeatureName = {
    Text = "Existência Transcendental"
  },
  FeatureUnlock_21452_LockTip = {
    Text = "Desbloqueia após completar \"Operação de Investigação\" 3-10·Normal"
  },
  FeatureUnlock_21452_UnlockDesc = {
    Text = "<FeatureUnlockTitle: Existência Transcendental desbloqueada>\n\n<FeatureUnlockDesc: Eles são existências tabu que ignoram todas as regras e causas.\nConsumir menofim para desafiar pode resultar em materiais de upgrade raros para habilidades do despertador.>"
  },
  FeatureUnlock_23667_FeatureName = {
    Text = "Jornada ultradimensional · Fissura de rotação"
  },
  FeatureUnlock_23667_LockTip = {
    Text = "Vença a Jornada Ultra·Fissura VIII para desbloquear"
  },
  FeatureUnlock_23668_FeatureName = {
    Text = "Domínio do caos·Interstício rotativo"
  },
  FeatureUnlock_23668_LockTip = {
    Text = "Vença o Domínio do Caos·Fissura VIII para desbloquear"
  },
  FeatureUnlock_23669_FeatureName = {
    Text = "Pântano de carne e sangue · Fissura rotativa"
  },
  FeatureUnlock_23669_LockTip = {
    Text = "Vença o Pântano de Carne·Fissura VIII para desbloquear"
  },
  FeatureUnlock_23670_FeatureName = {
    Text = "Legado do profundo mar·Interstício rotativo"
  },
  FeatureUnlock_23670_LockTip = {
    Text = "Vença o Vazio do Mar Profundo·Fissura VIII para desbloquear"
  },
  FeatureUnlock_23699_LockTip = {
    Text = "Complete \"Magia da História\" · Normal para desbloquear"
  },
  FeatureUnlock_23700_LockTip = {
    Text = "Ainda não disponível"
  },
  FeatureUnlock_23701_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_24502_LockTip = {
    Text = "Complete \"Louvor à Rosa\" · Normal para desbloquear"
  },
  FeatureUnlock_24503_LockTip = {
    Text = "Ainda não disponível"
  },
  FeatureUnlock_24504_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_25070_LockTip = {
    Text = "Complete \"A um passo\" · Normal para desbloquear"
  },
  FeatureUnlock_25071_LockTip = {
    Text = "Ainda não disponível"
  },
  FeatureUnlock_25072_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_25256_FeatureName = {
    Text = "Zona Proibida de Catástrofe de Fusão"
  },
  FeatureUnlock_25256_LockTip = {
    Text = "Desbloquear após completar \"Investigação Operação\" 4-3 · Normal"
  },
  FeatureUnlock_25256_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Zona Proibida de Catástrofe de Fusão desbloqueada>\n\n<FeatureUnlockDesc:Entre na área de explosão de desastres e desactive o alerta de crise da maré negra.\nO guardião do segredo pode enviar várias equipes para enfrentar desafios e obter recompensas abundantes, como Núcleo Espiritual Original, Núcleo de prata e Oferta preta.>"
  },
  FeatureUnlock_35576_FeatureName = {
    Text = "Loja de enredo mágico"
  },
  FeatureUnlock_35576_LockTip = {
    Text = "Complete \"Operação de Investigação\" 1-10 ・Normal desbloqueado"
  },
  FeatureUnlock_36165_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_36166_LockTip = {
    Text = "Complete \"Tudo como de Costume\" · Normal para desbloquear"
  },
  FeatureUnlock_36167_LockTip = {
    Text = "Ainda não disponível"
  },
  FeatureUnlock_36628_LockTip = {
    Text = "Ainda não disponível"
  },
  FeatureUnlock_36629_LockTip = {
    Text = "Complete \"Festa Ardente\" · Normal para desbloquear"
  },
  FeatureUnlock_36630_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_38850_FeatureName = {
    Text = "A Caixa de Tesouros Exóticos de Wanda"
  },
  FeatureUnlock_38850_LockTip = {
    Text = "Complete \"Operação de Investigação\" 1-10 ・Normal desbloqueado"
  },
  FeatureUnlock_38851_FeatureName = {
    Text = "Cidade no lago"
  },
  FeatureUnlock_43518_LockTip = {
    Text = "Ainda não disponível"
  },
  FeatureUnlock_43519_LockTip = {
    Text = "Complete \"Queda do Gigante\" · Normal para desbloquear"
  },
  FeatureUnlock_43520_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_44550_FeatureName = {Text = "Salvador"},
  FeatureUnlock_44568_LockTip = {
    Text = "Ainda não disponível"
  },
  FeatureUnlock_44569_LockTip = {
    Text = "Complete \"Cor do Sangue\" · Normal para desbloquear"
  },
  FeatureUnlock_44570_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_44700_LockTip = {
    Text = "Desbloqueado após completar \"Matar por Ciúmes\" no \"Registro Especial: A Cor do Sangue\""
  },
  FeatureUnlock_44701_LockTip = {
    Text = "Desbloqueado após completar \"Preencher a Fome\" no \"Registro Especial: A Cor do Sangue\""
  },
  FeatureUnlock_44702_LockTip = {
    Text = "Desbloqueado após completar \"Símbolo Sangrento\" no \"Registro Especial: A Cor do Sangue\""
  },
  FeatureUnlock_44703_LockTip = {
    Text = "Desbloqueado após completar \"Purificando Pecados\" no \"Registro Especial: A Cor do Sangue\""
  },
  FeatureUnlock_44704_LockTip = {
    Text = "Desbloqueado após completar \"Acender a Esperança Branca\" no \"Registro Especial: A Cor do Sangue\""
  },
  FeatureUnlock_46186_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_46187_LockTip = {
    Text = "Complete \"Fissão Tranquila\" · Normal para desbloquear"
  },
  FeatureUnlock_46188_LockTip = {
    Text = "Ainda não disponível"
  },
  FeatureUnlock_47456_FeatureName = {
    Text = "Cura Múltipla"
  },
  FeatureUnlock_47457_LockTip = {
    Text = "Desbloqueado após completar \"Fonte\" no \"Registro Especial: Fissão Tranquila\""
  },
  FeatureUnlock_47458_LockTip = {
    Text = "Desbloqueado após completar \"Pare Aqui\" no \"Registro Especial: Fissão Tranquila\""
  },
  FeatureUnlock_47459_LockTip = {
    Text = "Desbloqueado após completar \"Fuga Dourada\" no \"Registro Especial: Fissão Tranquila\""
  },
  FeatureUnlock_47460_LockTip = {
    Text = "Desbloqueado após completar \"Serpente da Insônia\" no \"Registro Especial: Fissão Tranquila\""
  },
  FeatureUnlock_47461_LockTip = {
    Text = "Desbloqueado após completar \"Conto de Fadas das Sombras\" no \"Registro Especial: Fissão Tranquila\""
  },
  FeatureUnlock_48920_FeatureName = {
    Text = "\"Operação de Investigação\" Capítulo 7"
  },
  FeatureUnlock_48920_LockTip = {
    Text = "Desbloqueia após completar \"Operação de Investigação\" Capítulo 6 · Normal"
  },
  FeatureUnlock_48920_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Operação de Investigação \"Rio do Desejo\" Aberta>\n\n<FeatureUnlockDesc:O Rio Sagrado Karage no norte de Lemwashi nutre o passado e o futuro do povo nômade Aran...>"
  },
  FeatureUnlock_48921_FeatureName = {
    Text = "\"Operação de Investigação\" Capítulo 7 · Difícil"
  },
  FeatureUnlock_48921_LockTip = {
    Text = "Desbloquear após completar \"Operação\" Capítulo 6 · Difícil e Capítulo 7 · Normal"
  },
  FeatureUnlock_48921_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Operação de Investigação \"Rio do Desejo\"·Dificuldade Difícil Aberta>"
  },
  FeatureUnlock_48922_FeatureName = {
    Text = "\"Operação de Investigação\" Capítulo 7 · Loucura"
  },
  FeatureUnlock_48922_LockTip = {Text = "Aguarde"},
  FeatureUnlock_48922_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Operação \"Rio do Desejo\" · Dificuldade de Loucura Desbloqueada>"
  },
  FeatureUnlock_49170_FeatureName = {
    Text = "Restos do Mar de Areia"
  },
  FeatureUnlock_49170_LockTip = {
    Text = "Desbloqueia após completar \"Operação de Investigação\" Capítulo 7 · Normal"
  },
  FeatureUnlock_49171_FeatureName = {
    Text = "Parede de Areia Desértica"
  },
  FeatureUnlock_49171_LockTip = {
    Text = "Desbloqueia após completar \"Operação de Investigação\" Capítulo 7 · Normal"
  },
  FeatureUnlock_49205_FeatureName = {
    Text = "Teste dos Despertos"
  },
  FeatureUnlock_49205_LockTip = {
    Text = "Concluir Prólogo para desbloquear"
  },
  FeatureUnlock_49296_FeatureName = {
    Text = "Roda do destino"
  },
  FeatureUnlock_49296_LockTip = {
    Text = "Sem coleção relacionada"
  },
  FeatureUnlock_49298_FeatureName = {Text = "Evento"},
  FeatureUnlock_49298_LockTip = {
    Text = "Sem coleção relacionada"
  },
  FeatureUnlock_49300_FeatureName = {
    Text = "CG do enredo"
  },
  FeatureUnlock_49300_LockTip = {
    Text = "Sem coleção relacionada"
  },
  FeatureUnlock_49301_FeatureName = {Text = "fonógrafo"},
  FeatureUnlock_49301_LockTip = {
    Text = "Sem coleção relacionada"
  },
  FeatureUnlock_49302_FeatureName = {Text = "Imagem"},
  FeatureUnlock_49302_LockTip = {
    Text = "Sem coleção relacionada"
  },
  FeatureUnlock_49303_FeatureName = {
    Text = "Mundo Hongji"
  },
  FeatureUnlock_49303_LockTip = {
    Text = "Sem coleção relacionada"
  },
  FeatureUnlock_49304_FeatureName = {Text = "Personagem"},
  FeatureUnlock_49304_LockTip = {
    Text = "Sem coleção relacionada"
  },
  FeatureUnlock_49305_FeatureName = {Text = "Mystik"},
  FeatureUnlock_49305_LockTip = {
    Text = "Sem coleção relacionada"
  },
  FeatureUnlock_49306_FeatureName = {
    Text = "Livro Proibido de Hongji"
  },
  FeatureUnlock_49306_LockTip = {
    Text = "Sem coleção relacionada"
  },
  FeatureUnlock_49307_FeatureName = {
    Text = "Organização"
  },
  FeatureUnlock_49307_LockTip = {
    Text = "Sem coleção relacionada"
  },
  FeatureUnlock_49308_FeatureName = {
    Text = "CG de cenário"
  },
  FeatureUnlock_49308_LockTip = {
    Text = "Sem coleção relacionada"
  },
  FeatureUnlock_49309_FeatureName = {Text = "Crônica"},
  FeatureUnlock_49309_LockTip = {
    Text = "Sem coleção relacionada"
  },
  FeatureUnlock_49310_FeatureName = {Text = "Criação"},
  FeatureUnlock_49310_LockTip = {
    Text = "Sem coleção relacionada"
  },
  FeatureUnlock_49311_LockTip = {
    Text = "Sem coleção relacionada"
  },
  FeatureUnlock_49418_FeatureName = {
    Text = "Tipo de Missão Geral"
  },
  FeatureUnlock_49418_LockTip = {
    Text = "Concluir Prólogo para desbloquear"
  },
  FeatureUnlock_49567_FeatureName = {
    Text = "Frenesi de reprodução"
  },
  FeatureUnlock_49567_LockTip = {
    Text = "Desbloqueia após completar \"Operação de Investigação\" 7-3 · Normal"
  },
  FeatureUnlock_49567_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Frenesi de Reprodução desbloqueado>\n\n<FeatureUnlockDesc:Influenciados por forças misteriosas, os Despertos entraram em estado de \"Frenesi de Reprodução\"... Cuidado, Guardiões!>"
  },
  FeatureUnlock_50092_FeatureName = {
    Text = "Ondas de Desejo"
  },
  FeatureUnlock_51255_FeatureName = {
    Text = "História magia·cópia de luz"
  },
  FeatureUnlock_51256_LockTip = {
    Text = "Desbloqueado após completar \"O Poder de Andy Johnson\" no \"Registro Especial: A Magia das Histórias\""
  },
  FeatureUnlock_51257_LockTip = {
    Text = "Desbloqueado após completar \"Buscando Histórias\" no \"Registro Especial: A Magia das Histórias\""
  },
  FeatureUnlock_51258_LockTip = {
    Text = "Desbloquear após completar \"Generosidade do Comerciante\" em \"Registro de Tarefa: Magia da História\""
  },
  FeatureUnlock_51259_LockTip = {
    Text = "Desbloqueado após completar \"A Pessoa Mais Sentida\" no \"Registro Especial: A Magia das Histórias\""
  },
  FeatureUnlock_51260_LockTip = {
    Text = "Desbloquear após completar \"Melhor Flor\" em \"Registro de Tarefa: A Magia das Histórias\""
  },
  FeatureUnlock_51261_LockTip = {
    Text = "Desbloqueado após completar \"O Final Mais Perfeito\" no \"Registro Especial: A Magia das Histórias\""
  },
  FeatureUnlock_51262_LockTip = {
    Text = "Desbloquear após completar \"A Ilusão Mais Grandiosa\" em \"Registro de Tarefa: Magia da História\""
  },
  FeatureUnlock_51263_LockTip = {
    Text = "Desbloqueado após completar \"O Final Mais Perfeito\" no \"Registro Especial: A Magia das Histórias\""
  },
  FeatureUnlock_51264_LockTip = {
    Text = "Desbloqueado após completar \"O Final Mais Perfeito\" no \"Registro Especial: A Magia das Histórias\""
  },
  FeatureUnlock_51757_FeatureName = {
    Text = "Visão de Sonhos Estranhos"
  },
  FeatureUnlock_51757_LockTip = {
    Text = "Concluir Prólogo para desbloquear"
  },
  FeatureUnlock_51759_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_54118_FeatureName = {
    Text = "Com o livro da rosa"
  },
  FeatureUnlock_55456_FeatureName = {
    Text = "Antes que o jardim murche"
  },
  FeatureUnlock_55458_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_55459_LockTip = {
    Text = "Complete \"Morada das Rosas\" · Normal para desbloquear"
  },
  FeatureUnlock_55460_LockTip = {
    Text = "Ainda não disponível"
  },
  FeatureUnlock_57707_LockTip = {
    Text = "Ainda não disponível"
  },
  FeatureUnlock_57708_LockTip = {
    Text = "Complete \"Boa Caça!\" · Normal para desbloquear"
  },
  FeatureUnlock_57709_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_57710_LockTip = {
    Text = "Ainda não disponível"
  },
  FeatureUnlock_57712_LockTip = {
    Text = "Complete \"Retorno de Elworth\" · Normal para desbloquear"
  },
  FeatureUnlock_57714_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_58025_FeatureName = {
    Text = "Murphy se moveu"
  },
  FeatureUnlock_58026_FeatureName = {
    Text = "Atividade de réplica de Miryam"
  },
  FeatureUnlock_58027_FeatureName = {
    Text = "Evento de réplica de Salvador"
  },
  FeatureUnlock_58028_FeatureName = {
    Text = "Gênesis Boneca atividade"
  },
  FeatureUnlock_58029_FeatureName = {
    Text = "Atividade de Gênesis Hilota"
  },
  FeatureUnlock_58030_FeatureName = {
    Text = "Atividades de Tawil"
  },
  FeatureUnlock_58031_FeatureName = {
    Text = "Hameln ativa"
  },
  FeatureUnlock_58032_FeatureName = {
    Text = "Ryker em ação"
  },
  FeatureUnlock_58033_FeatureName = {
    Text = "Evento de Reedição de Wanda"
  },
  FeatureUnlock_58034_FeatureName = {
    Text = "Evento de réplica 24"
  },
  FeatureUnlock_58907_FeatureName = {
    Text = "\"\"Investigação da Operação\" Capítulo 8"
  },
  FeatureUnlock_58907_LockTip = {
    Text = "Desbloqueia após completar \"Operação de Investigação\" Capítulo 7 · Normal"
  },
  FeatureUnlock_58907_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Operação \"Sinfonia Final\" foi desbloqueada>\n\n<FeatureUnlockDesc:Entre. Sente-se em silêncio. Espere. Deseje.\nA batuta do maestro se ergue suavemente. Você está pronto para ouvir os segredos mais profundos do universo?>"
  },
  FeatureUnlock_58908_FeatureName = {
    Text = "\"\"Operação\" Final"
  },
  FeatureUnlock_58908_LockTip = {
    Text = "Desbloquear após completar \"Operação\" Capítulo 8 · Normal"
  },
  FeatureUnlock_58908_UnlockDesc = {
    Text = "<FeatureUnlockTitle: Ação de Investigação \"Sonho longo terminado\" desbloqueada>\n\n<FeatureUnlockDesc: Ele teve um longo sonho.\nEle sonhou com deuses e estrelas, sonhou com a poeira gerando civilizações, as civilizações se transformando em poeira.\nEle sonhou com ódio e amor, sonhou com alegria e medo.\nEle acordou de um sono profundo. Nada no sonho nunca existiu.>"
  },
  FeatureUnlock_58909_FeatureName = {
    Text = "\"\"Operação\" Final · Difícil"
  },
  FeatureUnlock_58909_LockTip = {
    Text = "Complete o Capítulo 8 da \"Operação\" na dificuldade Difícil e o Capítulo 9 na dificuldade Normal para desbloquear"
  },
  FeatureUnlock_58909_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Operação \"Quando o Longo Sonho Termina\" · Nível de Dificuldade Difícil desbloqueado>"
  },
  FeatureUnlock_58911_FeatureName = {
    Text = "\"Operação de Investigação\" Capítulo 8 · Difícil"
  },
  FeatureUnlock_58911_LockTip = {
    Text = "Completar a «operação» capítulo 7·difícil e capítulo 8·normal para desbloquear"
  },
  FeatureUnlock_58911_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Operação \"Sinfonia Final\" · A dificuldade Difícil foi desbloqueada>"
  },
  FeatureUnlock_58912_FeatureName = {
    Text = "\"Operação de Investigação\" Capítulo 8 · Loucura"
  },
  FeatureUnlock_58912_LockTip = {Text = "Aguarde"},
  FeatureUnlock_58912_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Operação \"Sinfonia Final\" · Nível de Dificuldade Loucura Desbloqueado>"
  },
  FeatureUnlock_58913_FeatureName = {
    Text = "Fissura Primordial"
  },
  FeatureUnlock_58913_LockTip = {
    Text = "Desbloquear após completar \"Operação\" Capítulo 8 · Normal"
  },
  FeatureUnlock_58914_FeatureName = {
    Text = "Maré do Poço Negro"
  },
  FeatureUnlock_58914_LockTip = {
    Text = "Desbloquear após completar \"Operação\" Capítulo 8 · Normal"
  },
  FeatureUnlock_58915_FeatureName = {
    Text = "\"\"Operação\" Final · Loucura"
  },
  FeatureUnlock_58915_LockTip = {Text = "Aguarde"},
  FeatureUnlock_58915_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Operação \"Quando o Longo Sonho Termina\" · Nível de Dificuldade Loucura Desbloqueado>"
  },
  FeatureUnlock_60580_FeatureName = {
    Text = "Comunicação Silver Core"
  },
  FeatureUnlock_60580_LockTip = {
    Text = "Desbloqueado após completar \"Operação de Investigação\" 2-1 · Normal"
  },
  FeatureUnlock_60580_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Comunicação de Núcleo de Prata Aberta>\n\n<FeatureUnlockDesc:Aliados, camaradas, amigos, agite a caixa mágica para contatá-los.>"
  },
  FeatureUnlock_68887_FeatureName = {
    Text = "Evento Clementine"
  },
  FeatureUnlock_68888_FeatureName = {
    Text = "Atividade de Gênesis Tulu"
  },
  FeatureUnlock_68889_FeatureName = {
    Text = "Atividade Tulu"
  },
  FeatureUnlock_68890_FeatureName = {
    Text = "Atividade de Gênesis Murphy"
  },
  FeatureUnlock_68891_FeatureName = {
    Text = "Evento Daffodil"
  },
  FeatureUnlock_68892_FeatureName = {
    Text = "Mordiggian Ativa"
  },
  FeatureUnlock_68893_FeatureName = {
    Text = "Rulim Ativa"
  },
  FeatureUnlock_68894_FeatureName = {
    Text = "Evento Antarak"
  },
  FeatureUnlock_70556_FeatureName = {Text = "Evento"},
  FeatureUnlock_70556_LockTip = {
    Text = "Sem coleção relacionada"
  },
  FeatureUnlock_71851_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_72031_FeatureName = {
    Text = "\"Operação de Investigação\": Capítulos Estrela 1"
  },
  FeatureUnlock_72031_LockTip = {
    Text = "Desbloquear após completar \"Operação\" Capítulo 9 · Normal"
  },
  FeatureUnlock_72031_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Ação de Investigação \"O Momento da Estrela Brilhante - Retorno à Cidade da Névoa\" foi iniciada>\n\n<FeatureUnlockDesc:Entre a respiração, partículas de poeira se movem; o sol decadente mal consegue penetrar>"
  },
  FeatureUnlock_72035_FeatureName = {
    Text = "Concluir a história do capítulo Esquecimento"
  },
  FeatureUnlock_72035_LockTip = {
    Text = "Complete o Capítulo 9 da \"Operação\" na dificuldade Normal, depois retorne à interface principal para reprodução."
  },
  FeatureUnlock_72076_FeatureName = {
    Text = "\"Operação de Investigação\": Capítulos Estrela 1 · Difícil"
  },
  FeatureUnlock_72076_LockTip = {
    Text = "Desbloqueado após completar \"Operação: Investigação\" Capítulo 1 · Normal"
  },
  FeatureUnlock_72076_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Operação de Investigação \"O Regresso à Cidade Nebulosa\" · Dificuldade Difícil Ativada>"
  },
  FeatureUnlock_73800_FeatureName = {
    Text = "Atividade de Recriação de Murphy"
  },
  FeatureUnlock_74239_LockTip = {
    Text = "Desbloqueia após concluir \"Paixão ao pó\" - Normal"
  },
  FeatureUnlock_74240_LockTip = {
    Text = "Ainda não disponível"
  },
  FeatureUnlock_74241_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_74337_FeatureName = {
    Text = "Reverter o turno ativo"
  },
  FeatureUnlock_74341_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_74348_FeatureName = {
    Text = "Evento de réplica de Salvador"
  },
  FeatureUnlock_74362_FeatureName = {
    Text = "Evento de réplica de Ryker"
  },
  FeatureUnlock_75909_FeatureName = {
    Text = "Radioteatro"
  },
  FeatureUnlock_75909_LockTip = {
    Text = "Sem coleção relacionada"
  },
  FeatureUnlock_78650_FeatureName = {
    Text = "Evento de réplica 24"
  },
  FeatureUnlock_78734_FeatureName = {
    Text = "Conexão multidimensional"
  },
  FeatureUnlock_78734_LockTip = {
    Text = "Concluir Prólogo para desbloquear"
  },
  FeatureUnlock_78793_FeatureName = {
    Text = "Atividade de Gênesis Hilota"
  },
  FeatureUnlock_79686_FeatureName = {
    Text = "Moda dos Despertos"
  },
  FeatureUnlock_79686_LockTip = {
    Text = "Concluir Prólogo Desbloqueado"
  },
  FeatureUnlock_80156_LockTip = {
    Text = "Desbloqueado após completar \"Operação de Investigação\" 1-9 · Normal"
  },
  FeatureUnlock_80317_FeatureName = {
    Text = "\"Operação de Investigação\" Capítulo Estrela 2 · Difícil"
  },
  FeatureUnlock_80317_LockTip = {
    Text = "Complete a «operação» Capítulo 1 · Difícil da série Estelar e Capítulo 2 · Normal para desbloquear"
  },
  FeatureUnlock_80317_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Operação de Investigação \"Transformação\"·Dificuldade Difícil Agora Aberta>"
  },
  FeatureUnlock_80318_FeatureName = {
    Text = "\"Operação de Investigação\" Capítulo Estrela 2"
  },
  FeatureUnlock_80318_LockTip = {
    Text = "Desbloqueado após completar \"Operação: Investigação\" Capítulo 1 · Normal"
  },
  FeatureUnlock_80318_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Ação de Investigação \"O Momento da Estrela Dourada · Transformação\" foi iniciada>\n\n<FeatureUnlockDesc:Siga a figura familiar de cabelos dourados, o Guardião do Segredo chega a um sanatório desconhecido. Aqui, escondem-se inúmeros segredos e almas quebradas.>"
  },
  FeatureUnlock_83813_LockTip = {
    Text = "Complete \"Operação de Investigação\" 1-2 ・Normal desbloqueado"
  },
  FeatureUnlock_84307_FeatureName = {
    Text = "Evento de Kupersante"
  },
  FeatureUnlock_84356_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_88941_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_88942_FeatureName = {
    Text = "Evento Castor"
  },
  FeatureUnlock_89531_FeatureName = {
    Text = "Loja de Moda"
  },
  FeatureUnlock_89531_LockTip = {
    Text = "Concluir Prólogo para desbloquear"
  },
  FeatureUnlock_90492_LockTip = {
    Text = "Complete \"Operação de Investigação\" 1-2 ・Normal desbloqueado"
  },
  FeatureUnlock_91201_FeatureName = {
    Text = "Código de convite de amigo"
  },
  FeatureUnlock_91201_LockTip = {
    Text = "Concluir Prólogo Desbloqueado"
  },
  FeatureUnlock_91202_FeatureName = {
    Text = "\"Investigação Operação\" Capítulo Estelar Capítulo 3"
  },
  FeatureUnlock_91202_LockTip = {
    Text = "Desbloqueia após completar \"Operações Investigativas\" Capítulo Estelar 2 · Normal"
  },
  FeatureUnlock_91202_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Ação de Investigação \"O Momento da Estrela Dourada · Banquete\" foi iniciada>\n\n<FeatureUnlockDesc:Atravesse a névoa do cemitério, a grandiosa cidade real surge diante de você.\nO rei dos ghoul está à sua espera, ansioso para que você se junte ao seu banquete.>"
  },
  FeatureUnlock_91203_FeatureName = {
    Text = "\"Investigação Operação\" Capítulo Estelar Capítulo 3 · Difícil"
  },
  FeatureUnlock_91203_LockTip = {
    Text = "Desbloqueia após completar \"Operações Investigativas\" Capítulo Estelar 2 · Difícil e Capítulo 3 · Normal"
  },
  FeatureUnlock_91203_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Operação de Investigação \"Festa\"·Dificuldade Difícil Desbloqueada>"
  },
  FeatureUnlock_91238_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_91239_FeatureName = {
    Text = "Evento de Roma"
  },
  FeatureUnlock_94856_FeatureName = {
    Text = "Evento Especial de Verão - Parte 1"
  },
  FeatureUnlock_94857_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_95783_FeatureName = {
    Text = "Dulesain Ativa"
  },
  FeatureUnlock_97143_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_97144_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_97145_FeatureName = {
    Text = "Evento Catigura"
  },
  FeatureUnlock_97146_FeatureName = {
    Text = "Pikman em Ação"
  },
  FeatureUnlock_97671_FeatureName = {
    Text = "Gênesis Dama do Mar Profundo Evento"
  },
  FeatureUnlock_97894_LockTip = {
    Text = "<Posse:complete a \"operação\" 2-9·normal para desbloquear>"
  },
  FeatureUnlock_97895_FeatureName = {
    Text = "Evento Especial de Verão - Parte 2"
  },
  FeatureUnlock_97929_LockTip = {
    Text = "<Posse:Desbloqueado após completar \"Adeus à Terra do Nunca\"·normal>"
  }
})
return Text_FeatureUnlock
