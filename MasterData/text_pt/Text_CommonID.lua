__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_CommonID = readonly({
  CommonID_Account_Desc = {Text = "Conta"},
  CommonID_AchieveCommemorativeData_Dmg_Desc = {
    Text = "Dano Máximo"
  },
  CommonID_AchieveCommemorativeData_Poison_Desc = {
    Text = "Máx Andares"
  },
  CommonID_AchieveCommemorativeData_Time_Desc = {
    Text = "Tempo de Conclusão"
  },
  CommonID_AchieveType0_Desc = {
    Text = "Todas as Conquistas"
  },
  CommonID_AchieveType1_Desc = {
    Text = "História de Crescimento"
  },
  CommonID_AchieveType2_Desc = {
    Text = "Marca de Investigação"
  },
  CommonID_AchieveType3_Desc = {
    Text = "Registro de Combate"
  },
  CommonID_AchieveType4_Desc = {
    Text = "A Vida do Guardião do Segredo"
  },
  CommonID_Add_State_Desc = {
    Text = "Adicione Estado"
  },
  CommonID_All_Desc = {Text = "Tudo"},
  CommonID_AnyAvgFirstTrigger_Desc = {
    Text = "Condição de conclusão da missão: acionar qualquer nó da história"
  },
  CommonID_AnyEntryInGroupUnlock_Desc = {
    Text = "Critérios de Conclusão da Missão: Desbloquear qualquer entrada no compêndio do grupo"
  },
  CommonID_AnyEventFirstTrigger_Desc = {
    Text = "Critérios de Conclusão da Quest: Acione qualquer [Evento]"
  },
  CommonID_AnyItemFirstGet_Desc = {
    Text = "Condição de Conclusão da Missão: Obter qualquer item"
  },
  CommonID_AnyNodeTypeFirstTrigger_Desc = {
    Text = "Condição de Conclusão da Missão: Ativar qualquer tipo de nó"
  },
  CommonID_AnyRelicFirstGet_Desc = {
    Text = "Condição de conclusão da tarefa: Obter qualquer Relíquia"
  },
  CommonID_AnyStageFirstClear_Desc = {
    Text = "Critérios de conclusão da missão: eliminar qualquer estágio na lista pela primeira vez"
  },
  CommonID_AppointTaskRewardAdd_Desc = {
    Text = "Atribuir para Aumentar Recompensas"
  },
  CommonID_Attr_Promote_Desc = {
    Text = "Aumento de atributos"
  },
  CommonID_AwakerDied_Desc = {
    Text = "Despertador morto"
  },
  CommonID_AwakerMonster_Desc = {
    Text = "Líder do Despertar"
  },
  CommonID_BN_Desc = {
    Text = "Bengali (alpha)"
  },
  CommonID_BanBattlePos_Desc = {
    Text = "Não pode ser implantado"
  },
  CommonID_Battle_Desc = {Text = "Batalha"},
  CommonID_Blue_Desc = {Text = "Azul"},
  CommonID_Boss_Desc = {Text = "Líder"},
  CommonID_BundleShortcutKey_Desc = {
    Text = "Vinculação de Chave"
  },
  CommonID_CN_Desc = {
    Text = "Chinês Simplificado"
  },
  CommonID_CardBorder_Desc = {
    Text = "Cosmético de Carta"
  },
  CommonID_CardSlots_LevelUp_Desc = {
    Text = "Atualize Espaço"
  },
  CommonID_Card_AdvancedImagery_Desc = {
    Text = "Imagens avançadas"
  },
  CommonID_Card_AttachPost_Desc = {
    Text = "Perseguição"
  },
  CommonID_Card_Awake_Desc = {
    Text = "Despertar do Conhecimento Espiritual"
  },
  CommonID_Card_Curse_Desc = {
    Text = "Carta de sintoma"
  },
  CommonID_Card_Defend_Desc = {
    Text = "Cartão de Defesa"
  },
  CommonID_Card_Developing_Desc = {
    Text = "Em desenvolvimento"
  },
  CommonID_Card_Extend_Desc = {
    Text = "Cartão Derivado"
  },
  CommonID_Card_Fraud_Desc = {Text = "Fraude"},
  CommonID_Card_Imagery_Desc = {Text = "Imagem"},
  CommonID_Card_KeeperSkill_Desc = {
    Text = "Cartão de Posse"
  },
  CommonID_Card_Potion_Desc = {
    Text = "Carta de Poção"
  },
  CommonID_Card_Skill_Desc = {
    Text = "Carta de habilidade"
  },
  CommonID_Card_State_Desc = {
    Text = "Carta de estado"
  },
  CommonID_Card_Strike_Desc = {
    Text = "Cartão de Ataque"
  },
  CommonID_Card_Weapon_Desc = {
    Text = "Cartão da Roda do Destino"
  },
  CommonID_CastSkillLevel_Desc = {
    Text = "Nível de Lançamento de Habilidade"
  },
  CommonID_Challenge_Desc = {
    Text = "Investigação"
  },
  CommonID_Change_Skill_Desc = {
    Text = "Substituir Habilidade"
  },
  CommonID_Chinese_Desc = {Text = "Chinês"},
  CommonID_ChooseHandCard_Desc = {
    Text = "Escolha um cartão da mão"
  },
  CommonID_ClickToQuit_Desc = {
    Text = "Clique para Sair"
  },
  CommonID_ClickToView_Desc = {
    Text = "Clique para Ver"
  },
  CommonID_Click_Desc = {
    Text = "Clique para Saltar"
  },
  CommonID_Close_Desc = {Text = "Fechar"},
  CommonID_ComingSoon_Desc = {Text = "Aguarde"},
  CommonID_CommonAttr_Desc = {
    Text = "Aumento Geral de Atributo"
  },
  CommonID_Common_Desc = {Text = "Comum"},
  CommonID_ContinuousSound_Desc = {
    Text = "Reprodução contínua"
  },
  CommonID_CopperAchieve_Desc = {Text = "Cobre"},
  CommonID_CountingStart_Desc = {
    Text = "Contagem regressiva iniciada durante o turno da equipe"
  },
  CommonID_Custom_Desc = {
    Text = "Personalizado"
  },
  CommonID_DE_Desc = {
    Text = "Alemão (GPT beta)"
  },
  CommonID_DPS_Desc = {Text = "Dano"},
  CommonID_DepressionHit_Desc = {
    Text = "Depressão Induzida por Golpes"
  },
  CommonID_DisableKeeperSkill_Desc = {
    Text = "Desativar Habilidades do Protagonista"
  },
  CommonID_DisableTrinketSuitEffect_Desc = {
    Text = "Pacto desativado"
  },
  CommonID_DisableWeapon_Desc = {
    Text = "Desativar Roda do destino"
  },
  CommonID_Display_Desc = {Text = "Visual"},
  CommonID_DropdownList_Desc = {
    Text = "Lista suspensa"
  },
  CommonID_EN_Desc = {
    Text = "Inglês (GPT beta)"
  },
  CommonID_ES_Desc = {
    Text = "Espanhol (GPT beta)"
  },
  CommonID_Elite_Desc = {Text = "Elite"},
  CommonID_EmojiType_10_Desc = {
    Text = "Pequeno mythag"
  },
  CommonID_EmojiType_11_Desc = {
    Text = "Turno inverso"
  },
  CommonID_EmojiType_12_Desc = {
    Text = "Mythag diário"
  },
  CommonID_EmojiType_13_Desc = {
    Text = "Mitologia feliz"
  },
  CommonID_EmojiType_14_Desc = {
    Text = "Mito infeliz"
  },
  CommonID_EmojiType_15_Desc = {
    Text = "Vida escolar"
  },
  CommonID_EmojiType_16_Desc = {
    Text = "Dia pacífico"
  },
  CommonID_EmojiType_17_Desc = {
    Text = "Após a escola"
  },
  CommonID_EmojiType_18_Desc = {
    Text = "Misaq do Coração"
  },
  CommonID_EmojiType_19_Desc = {
    Text = "Férias de Misaq"
  },
  CommonID_EmojiType_1_Desc = {
    Text = "Mito gordinho"
  },
  CommonID_EmojiType_20_Desc = {
    Text = "Misaq do Festival de Inverno"
  },
  CommonID_EmojiType_21_Desc = {
    Text = "Festa de Gengibre"
  },
  CommonID_EmojiType_22_Desc = {
    Text = "Fatos Divertidos do Campus"
  },
  CommonID_EmojiType_23_Desc = {
    Text = "Investigador Mythag"
  },
  CommonID_EmojiType_24_Desc = {
    Text = "Peça interlúdio de Misaq"
  },
  CommonID_EmojiType_25_Desc = {
    Text = "Canção de Saya"
  },
  CommonID_EmojiType_2_Desc = {Text = "Mori mori"},
  CommonID_EmojiType_3_Desc = {
    Text = "Maravilhas mundanas"
  },
  CommonID_EmojiType_4_Desc = {
    Text = "Mori-chibis"
  },
  CommonID_EmojiType_5_Desc = {
    Text = "Comunicado de Traphase"
  },
  CommonID_EmojiType_6_Desc = {
    Text = "Brilhe Missaga"
  },
  CommonID_EmojiType_7_Desc = {Text = "Mito louco"},
  CommonID_EmojiType_8_Desc = {
    Text = "Easy mythag"
  },
  CommonID_EmojiType_9_Desc = {
    Text = "Sabedoria Missaga"
  },
  CommonID_Enchant_Desc = {Text = "Gravura"},
  CommonID_Entrance_Desc = {
    Text = "Entrada Popup"
  },
  CommonID_FALSE_Desc = {Text = "Não"},
  CommonID_FR_Desc = {
    Text = "Francês (GPT beta)"
  },
  CommonID_Forged_Desc = {Text = "Reforço"},
  CommonID_FreeBattlePos_Desc = {
    Text = "Desdobramento Livre"
  },
  CommonID_FullScreen_Desc = {Text = "Tela Cheia"},
  CommonID_Gender_Boy_Desc = {Text = "Homem"},
  CommonID_Gender_Girl_Desc = {Text = "Mulher"},
  CommonID_GetLikeLevel_Desc = {Text = "Função"},
  CommonID_GmaeVoice_Desc = {
    Text = "Áudio do Jogo"
  },
  CommonID_GoldAchieve_Desc = {Text = "Ouro"},
  CommonID_Hall_Desc = {Text = "Saguão"},
  CommonID_HarvestAdd_Desc = {
    Text = "Recompensas de Lar Aumentadas"
  },
  CommonID_HaveAwaker_Desc = {
    Text = "Condição de conclusão da missão: Possuir qualquer Despertador da lista"
  },
  CommonID_HeadType_1_Desc = {
    Text = "Por nome da Chave de Prata"
  },
  CommonID_HeadType_2_Desc = {
    Text = "Foto do Arquivo Bobo"
  },
  CommonID_HeadType_3_Desc = {
    Text = "Ontem que não desvanece"
  },
  CommonID_HeadType_4_Desc = {
    Text = "Coleção de Selos"
  },
  CommonID_High_Desc = {Text = "Alto"},
  CommonID_Holy_Desc = {
    Text = "Sanctificação"
  },
  CommonID_ID_Desc = {
    Text = "Indonésio (GPT beta)"
  },
  CommonID_IT_Desc = {
    Text = "Italiano (alpha)"
  },
  CommonID_Image_Desc = {Text = "Imagem"},
  CommonID_Intent_AttackBuff_Desc = {
    Text = "O monstro pretende atacar e fortalecer."
  },
  CommonID_Intent_AttackDebuffD09Skill2_Desc = {
    Text = "Intenção do Monstro Atacar e Enfraquecer"
  },
  CommonID_Intent_AttackDebuff_Desc = {
    Text = "Intenção do Monstro Atacar e Enfraquecer"
  },
  CommonID_Intent_AttackDefence_Desc = {
    Text = "Intenções do Monstro: Ataque e Defesa"
  },
  CommonID_Intent_Attack_Desc = {
    Text = "Monstro pretende atacar"
  },
  CommonID_Intent_Buff_Desc = {
    Text = "Intenção do Monstro Fortalecer"
  },
  CommonID_Intent_Burst2_Desc = {
    Text = "Intenções do Monstro: Aliemus (Não-Ataque)"
  },
  CommonID_Intent_Burst3_Desc = {
    Text = "Intenção do Monstro: Super Aliemus"
  },
  CommonID_Intent_Burst4_Desc = {
    Text = "O monstro pretende desencadear o fim."
  },
  CommonID_Intent_Burst_Desc = {
    Text = "Intenção do Monstro: Aliemus"
  },
  CommonID_Intent_DCB022Buff_Desc = {
    Text = "Intenção do Monstro Fortalecer"
  },
  CommonID_Intent_DCB024Buff_Desc = {
    Text = "Intenção do Monstro Fortalecer"
  },
  CommonID_Intent_Debuff_Desc = {
    Text = "Monstro pretende enfraquecer"
  },
  CommonID_Intent_DefenceBuff_Desc = {
    Text = "O monstro pretende defender e fortalecer."
  },
  CommonID_Intent_DefenceDebuff_Desc = {
    Text = "Intenções do Monstro: Defesa e Enfraquecimento"
  },
  CommonID_Intent_Defence_Desc = {
    Text = "Intenção do Monstro: Defesa"
  },
  CommonID_Intent_Dizzy_Desc = {
    Text = "Intenção do Monstro: Atordoar"
  },
  CommonID_Intent_HeavyAttackDCB02_Desc = {
    Text = "Intenção do Monstro Ataque Pesado"
  },
  CommonID_Intent_HeavyAttack_Desc = {
    Text = "Intenção do Monstro Ataque Pesado"
  },
  CommonID_Intent_StrongBuff_Desc = {
    Text = "O monstro pretende passar por um fortalecimento significativo"
  },
  CommonID_Intent_StrongDebuff_Desc = {
    Text = "O monstro pretende enfraquecer significativamente"
  },
  CommonID_Intent_Unknown1_Desc = {
    Text = "Intenção do Monstro Desconhecida"
  },
  CommonID_Intent_Unknown2_Desc = {
    Text = "Intenção do Monstro Desconhecida"
  },
  CommonID_Intent_Unknown3_Desc = {
    Text = "Intenção do Monstro Desconhecida"
  },
  CommonID_Intent_Unknown4_Desc = {
    Text = "Intenção do Monstro Desconhecida"
  },
  CommonID_Intent_Unknown5_Desc = {
    Text = "Intenção do Monstro Desconhecida"
  },
  CommonID_Intent_Unknown6_Desc = {
    Text = "Intenção do Monstro Desconhecida"
  },
  CommonID_Intent_Unknown_Desc = {
    Text = "Intenção do Monstro Desconhecida"
  },
  CommonID_ItemManagement_Desc = {Text = "Item"},
  CommonID_JP_Desc = {
    Text = "Japonês (GPT beta)"
  },
  CommonID_KR_Desc = {
    Text = "Coreano (GPT beta)"
  },
  CommonID_Keeper_Skill_Desc = {
    Text = "Habilidades do Protagonista"
  },
  CommonID_KeyType_1_Desc = {
    Text = "Capítulo Esquecido"
  },
  CommonID_KeyType_2_Desc = {
    Text = "Domínio do Caos"
  },
  CommonID_KeyType_3_Desc = {
    Text = "Reino Aequor"
  },
  CommonID_KeyType_4_Desc = {
    Text = "Domínio de Carne e Sangue"
  },
  CommonID_KeyType_5_Desc = {
    Text = "Reino ultra"
  },
  CommonID_Key_Desc = {Text = "Botão"},
  CommonID_Language_Desc = {Text = "Linguagem"},
  CommonID_LevelLimit_Promote_Desc = {
    Text = "Aumento do limite de nível"
  },
  CommonID_Low_Desc = {Text = "Baixo"},
  CommonID_Management_Desc = {
    Text = "Vá para a Gestão"
  },
  CommonID_ManiaHit_Desc = {
    Text = "Frenético ao Acertar"
  },
  CommonID_MasterVolume_Desc = {
    Text = "Controle geral"
  },
  CommonID_MaterialsReturn_Desc = {
    Text = "Reembolso de recursos esgotados"
  },
  CommonID_MessagePush_Desc = {
    Text = "Notificação Push"
  },
  CommonID_Middle_Desc = {
    Text = "Tradução Sugerida"
  },
  CommonID_Modify_Desc = {
    Text = "Clique para modificar"
  },
  CommonID_MonsterGrade1_Desc = {
    Text = "Um Mob de Nível 1"
  },
  CommonID_MonsterGrade2_Desc = {
    Text = "Minion de Nível 2"
  },
  CommonID_MotherTreeMonster_Desc = {
    Text = "A árvore mãe"
  },
  CommonID_MultiplierXP_Desc = {
    Text = "Múltiplos Aumentos de EXP"
  },
  CommonID_Mute_Desc = {Text = "Silêncio"},
  CommonID_NotAwakerMonster_Desc = {
    Text = "Líder Não Despertado"
  },
  CommonID_Open_Desc = {Text = "Abra"},
  CommonID_OperationImpossible_Desc = {
    Text = "O jogador não consegue realizar a ação (jogar uma carta, ativar uma explosão de insanidade, etc.) por várias razões (falta de poder computacional, não ser o seu turno, estar selado ou petrificado, etc.)"
  },
  CommonID_OperationStop_Desc = {
    Text = "O tempo acumulado de pensamento durante o turno do nosso lado atingiu o valor máximo (configurado na tabela de constantes)"
  },
  CommonID_Orange_Desc = {Text = "Ouro"},
  CommonID_PT_Desc = {
    Text = "Português (GPT beta)"
  },
  CommonID_PVP_Desc = {
    Text = "Fase de Duelo"
  },
  CommonID_PassiveSkill_Desc = {
    Text = "Habilidade Passiva"
  },
  CommonID_PersonalProfile_Desc = {Text = "Perfil"},
  CommonID_PlayerEnter_Desc = {
    Text = "Jogo iniciado, após o jogador selecionar as cartas"
  },
  CommonID_PlayerFiles_Desc = {
    Text = "Arquivo do Guardião"
  },
  CommonID_Potency_Desc = {
    Text = "Despertar Espiritual"
  },
  CommonID_Privacy_Desc = {
    Text = "Privacidade"
  },
  CommonID_Purple_Desc = {
    Text = "Pêndulo crono"
  },
  CommonID_RU_Desc = {
    Text = "Russo (GPT beta)"
  },
  CommonID_RedGlow_Desc = {
    Text = "Efeito de Luz Vermelha"
  },
  CommonID_Red_Desc = {Text = "maldição"},
  CommonID_Redeem_Desc = {
    Text = "Vá para Resgatar"
  },
  CommonID_ReletedAwakerInEnemies_Desc = {
    Text = "Diálogo entre Despertados do nosso lado e do lado inimigo"
  },
  CommonID_Relic_Desc = {Text = "Criação"},
  CommonID_Repair_Desc = {
    Text = "Prossiga para Reparar"
  },
  CommonID_ResNeedReduce_Desc = {
    Text = "Requisitos de recursos reduzidos"
  },
  CommonID_SUP_Desc = {Text = "Apoio"},
  CommonID_SellCard_Desc = {
    Text = "Vender Cartões"
  },
  CommonID_ShortcutKey_Desc = {
    Text = "Tecla de atalho"
  },
  CommonID_SilverAchieve_Desc = {Text = "Prata"},
  CommonID_Sin_Desc = {
    Text = "Pecado Original"
  },
  CommonID_SkillReady_Desc = {
    Text = "Instante em que a barra de insanidade está cheia e pode ser clicada para exaltar"
  },
  CommonID_Skill_LevelUp_Desc = {
    Text = "Aprimorar Habilidade"
  },
  CommonID_Slider_Desc = {
    Text = "Controle Deslizante de Valor"
  },
  CommonID_SlotCardLevel_Desc = {
    Text = "Nível de Slot Original"
  },
  CommonID_SoundBalance_Desc = {
    Text = "Equilíbrio de Som"
  },
  CommonID_SpecificCommunicateTrig_Desc = {
    Text = "Condição de Conclusão da Missão: Ativar o diálogo do comunicador designado."
  },
  CommonID_StageDropAdd_Desc = {
    Text = "Aumento da produção de masmorras"
  },
  CommonID_Switch_Desc = {Text = "Trocar"},
  CommonID_System_Desc = {Text = "Sistema"},
  CommonID_TH_Desc = {
    Text = "Tailandês (GPT beta)"
  },
  CommonID_TRUE_Desc = {Text = "Sim"},
  CommonID_TR_Desc = {
    Text = "Turco (alpha)"
  },
  CommonID_TW_Desc = {
    Text = "Chinês Tradicional"
  },
  CommonID_T_Desc = {Text = "Defensivo"},
  CommonID_TaskCount_Desc = {Text = "Conde"},
  CommonID_TaskInProgress_Desc = {
    Text = "Em andamento"
  },
  CommonID_TaweiMonster_Desc = {
    Text = "Tawil a Sombria"
  },
  CommonID_Through1_Desc = {
    Text = "Habilidade Passiva 1"
  },
  CommonID_Through2_Desc = {
    Text = "Habilidade Passiva 2"
  },
  CommonID_Tips_Desc = {Text = "Dica"},
  CommonID_TranslationLabel_Desc = {
    Text = "Marcador de Progresso de Tradução"
  },
  CommonID_Ulti_Skill_Desc = {
    Text = "Fúria Explosiva"
  },
  CommonID_UtlSkill_Promote_Desc = {
    Text = "Superexaltação"
  },
  CommonID_VN_Desc = {
    Text = "Vietnamita (GPT beta)"
  },
  CommonID_VeryHigh_Desc = {
    Text = "Extremamente Alto"
  },
  CommonID_VeryLow_Desc = {
    Text = "Extremamente Baixo"
  },
  CommonID_View_Desc = {
    Text = "Vá e confira"
  },
  CommonID_Voice_Desc = {Text = "Som"},
  CommonID_Web_Desc = {
    Text = "Redirecionamento de Página"
  },
  CommonID_White_Desc = {Text = "Prata"},
  CommonID_WindowNotFocusVoice_Desc = {
    Text = "Efeito sonoro de janela desfocada"
  },
  CommonID_Window_Desc = {Text = "Janela"},
  CommonID_YellowGlow_Desc = {
    Text = "Efeito de Luz Amarela"
  }
})
return Text_CommonID
