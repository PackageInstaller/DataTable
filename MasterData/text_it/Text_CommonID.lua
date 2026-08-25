__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_CommonID = readonly({
  CommonID_Account_Desc = {Text = "Account"},
  CommonID_AchieveCommemorativeData_Dmg_Desc = {
    Text = "Danno massimo"
  },
  CommonID_AchieveCommemorativeData_Poison_Desc = {
    Text = "Piani massimi"
  },
  CommonID_AchieveCommemorativeData_Time_Desc = {
    Text = "Tempo di completamento"
  },
  CommonID_AchieveType0_Desc = {
    Text = "Tutti i traguardi"
  },
  CommonID_AchieveType1_Desc = {
    Text = "Storia di crescita"
  },
  CommonID_AchieveType2_Desc = {
    Text = "Segno d'Indagine"
  },
  CommonID_AchieveType3_Desc = {
    Text = "Registro di combattimento"
  },
  CommonID_AchieveType4_Desc = {
    Text = "Vita del Custode"
  },
  CommonID_Add_State_Desc = {
    Text = "Aggiungi Stato"
  },
  CommonID_All_Desc = {Text = "Tutti"},
  CommonID_AnyAvgFirstTrigger_Desc = {
    Text = "Condizione di completamento missione: Attivare una Storia qualsiasi"
  },
  CommonID_AnyEntryInGroupUnlock_Desc = {
    Text = "Condizione di completamento missione: Sbloccare una voce qualsiasi"
  },
  CommonID_AnyEventFirstTrigger_Desc = {
    Text = "Condizione di completamento missione: Attivare un Evento qualsiasi"
  },
  CommonID_AnyItemFirstGet_Desc = {
    Text = "Condizione di completamento missione: Ottenere un Oggetto qualsiasi"
  },
  CommonID_AnyNodeTypeFirstTrigger_Desc = {
    Text = "Condizione di completamento missione: Attivare un nodo qualsiasi"
  },
  CommonID_AnyRelicFirstGet_Desc = {
    Text = "Condizione di completamento missione: Ottenere una Reliquia qualsiasi"
  },
  CommonID_AnyStageFirstClear_Desc = {
    Text = "Condizione di completamento missione: Completamento di un livello qualsiasi"
  },
  CommonID_AppointTaskRewardAdd_Desc = {
    Text = "Assegna per aumentare le ricompense"
  },
  CommonID_Attr_Promote_Desc = {
    Text = "Potenziamento Attributi"
  },
  CommonID_AwakerDied_Desc = {
    Text = "Morte del Risvegliatore"
  },
  CommonID_AwakerMonster_Desc = {
    Text = "Boss del Risveglio"
  },
  CommonID_BN_Desc = {
    Text = "Bengalese (alpha)"
  },
  CommonID_BanBattlePos_Desc = {
    Text = "Non può essere schierato"
  },
  CommonID_Battle_Desc = {Text = "Battaglia"},
  CommonID_Blue_Desc = {Text = "Blu"},
  CommonID_Boss_Desc = {Text = "Boss"},
  CommonID_BundleShortcutKey_Desc = {
    Text = "Assegnazione Tasti"
  },
  CommonID_CN_Desc = {
    Text = "Cinese semplificato"
  },
  CommonID_CardBorder_Desc = {
    Text = "Cosmetico carta"
  },
  CommonID_CardSlots_LevelUp_Desc = {
    Text = "Potenzia Slot"
  },
  CommonID_Card_AdvancedImagery_Desc = {
    Text = "Immaginario Avanzato"
  },
  CommonID_Card_AttachPost_Desc = {
    Text = "Inseguimento"
  },
  CommonID_Card_Awake_Desc = {Text = "Risveglio"},
  CommonID_Card_Curse_Desc = {Text = "Sintomo"},
  CommonID_Card_Defend_Desc = {
    Text = "Carta difesa"
  },
  CommonID_Card_Developing_Desc = {
    Text = "In Sviluppo"
  },
  CommonID_Card_Extend_Desc = {
    Text = "Carta Derivato"
  },
  CommonID_Card_Fraud_Desc = {Text = "Frode"},
  CommonID_Card_Imagery_Desc = {
    Text = "Immaginario"
  },
  CommonID_Card_KeeperSkill_Desc = {
    Text = "Carta squadra"
  },
  CommonID_Card_Potion_Desc = {
    Text = "Carta pozione"
  },
  CommonID_Card_Skill_Desc = {
    Text = "Carta abilità"
  },
  CommonID_Card_State_Desc = {
    Text = "Carta di stato"
  },
  CommonID_Card_Strike_Desc = {
    Text = "Carta Colpo"
  },
  CommonID_Card_Weapon_Desc = {
    Text = "Ruota del destino"
  },
  CommonID_CastSkillLevel_Desc = {
    Text = "Livello Lancio Abilità"
  },
  CommonID_Challenge_Desc = {Text = "Indagine"},
  CommonID_Change_Skill_Desc = {
    Text = "Sostituisci Abilità"
  },
  CommonID_Chinese_Desc = {Text = "Cinese"},
  CommonID_ChooseHandCard_Desc = {
    Text = "Scegli una Carta dalla Mano"
  },
  CommonID_ClickToQuit_Desc = {
    Text = "Clicca per Uscire"
  },
  CommonID_ClickToView_Desc = {
    Text = "Clicca per Visualizzare"
  },
  CommonID_Click_Desc = {
    Text = "Clicca per Saltare"
  },
  CommonID_Close_Desc = {Text = "Chiudi"},
  CommonID_ComingSoon_Desc = {
    Text = "Restate sintonizzati"
  },
  CommonID_CommonAttr_Desc = {
    Text = "Bonus Statistiche Generali"
  },
  CommonID_Common_Desc = {Text = "Normale"},
  CommonID_ContinuousSound_Desc = {
    Text = "Continua a Giocare"
  },
  CommonID_CopperAchieve_Desc = {Text = "Rame"},
  CommonID_CountingStart_Desc = {
    Text = "Il conto alla rovescia inizia al nostro turno"
  },
  CommonID_Custom_Desc = {
    Text = "Personalizzato"
  },
  CommonID_DE_Desc = {
    Text = "Tedesco (alpha)"
  },
  CommonID_DPS_Desc = {Text = "Assalto"},
  CommonID_DepressionHit_Desc = {
    Text = "Depressione al Colpo"
  },
  CommonID_DisableKeeperSkill_Desc = {
    Text = "Disabilita abilità del protagonista"
  },
  CommonID_DisableTrinketSuitEffect_Desc = {
    Text = "Disabilita Patto"
  },
  CommonID_DisableWeapon_Desc = {
    Text = "Disabilita Ruota del destino"
  },
  CommonID_Display_Desc = {Text = "Grafica"},
  CommonID_DropdownList_Desc = {
    Text = "Menu a Tendina"
  },
  CommonID_EN_Desc = {
    Text = "Inglese (beta)"
  },
  CommonID_ES_Desc = {
    Text = "Spagnolo (alpha)"
  },
  CommonID_Elite_Desc = {Text = "Élite"},
  CommonID_EmojiType_10_Desc = {
    Text = "Piccolo Mythag"
  },
  CommonID_EmojiType_11_Desc = {
    Text = "Il Mio Turno"
  },
  CommonID_EmojiType_12_Desc = {
    Text = "Quotidiano di Mythag"
  },
  CommonID_EmojiType_13_Desc = {
    Text = "Mythag Felice"
  },
  CommonID_EmojiType_14_Desc = {
    Text = "Mythag Infelice"
  },
  CommonID_EmojiType_15_Desc = {
    Text = "Vita Scolastica"
  },
  CommonID_EmojiType_16_Desc = {
    Text = "Un Giorno di Pace"
  },
  CommonID_EmojiType_17_Desc = {
    Text = "Dopo la Scuola"
  },
  CommonID_EmojiType_18_Desc = {
    Text = "Mythag col Cuore"
  },
  CommonID_EmojiType_19_Desc = {
    Text = "Vacanza di Mythag"
  },
  CommonID_EmojiType_1_Desc = {
    Text = "Mythag Paffuto"
  },
  CommonID_EmojiType_20_Desc = {
    Text = "Mythag di Natale"
  },
  CommonID_EmojiType_21_Desc = {
    Text = "Festa di Pan di Zenzero"
  },
  CommonID_EmojiType_22_Desc = {
    Text = "Aneddoti del campus"
  },
  CommonID_EmojiType_23_Desc = {
    Text = "Investigatore Mythag"
  },
  CommonID_EmojiType_24_Desc = {
    Text = "Interludio Mythag"
  },
  CommonID_EmojiType_25_Desc = {
    Text = "La Canzone di Saya"
  },
  CommonID_EmojiType_2_Desc = {Text = "Mori Mori"},
  CommonID_EmojiType_3_Desc = {
    Text = "Meraviglie del Mondo"
  },
  CommonID_EmojiType_4_Desc = {
    Text = "Mori-Chibis"
  },
  CommonID_EmojiType_5_Desc = {
    Text = "Comunicazione Traphase"
  },
  CommonID_EmojiType_6_Desc = {
    Text = "Mythag Brillante"
  },
  CommonID_EmojiType_7_Desc = {
    Text = "Mythag Impazzito"
  },
  CommonID_EmojiType_8_Desc = {
    Text = "Mythag Rilassato"
  },
  CommonID_EmojiType_9_Desc = {
    Text = "Mythag della Saggezza"
  },
  CommonID_Enchant_Desc = {Text = "Orazione"},
  CommonID_Entrance_Desc = {
    Text = "Voce a Comparsa"
  },
  CommonID_FALSE_Desc = {Text = "No"},
  CommonID_FR_Desc = {
    Text = "Francese (alpha)"
  },
  CommonID_Forged_Desc = {Text = "Potenzia"},
  CommonID_FreeBattlePos_Desc = {
    Text = "Schieramento gratuito"
  },
  CommonID_FullScreen_Desc = {
    Text = "Schermo Intero"
  },
  CommonID_Gender_Boy_Desc = {Text = "Maschio"},
  CommonID_Gender_Girl_Desc = {Text = "Femmina"},
  CommonID_GetLikeLevel_Desc = {Text = "Funzione"},
  CommonID_GmaeVoice_Desc = {
    Text = "Audio di Gioco"
  },
  CommonID_GoldAchieve_Desc = {Text = "Oro"},
  CommonID_Hall_Desc = {Text = "Lobby"},
  CommonID_HarvestAdd_Desc = {
    Text = "Ricompense del Focolare aumentate"
  },
  CommonID_HaveAwaker_Desc = {
    Text = "Condizione di completamento missione: Possedere un Risvegliatore qualsiasi"
  },
  CommonID_HeadType_1_Desc = {
    Text = "Per la Chiave d'argento"
  },
  CommonID_HeadType_2_Desc = {
    Text = "Foto Segnaletica Chibi"
  },
  CommonID_HeadType_3_Desc = {
    Text = "Un Ieri che Non Sbiadisce"
  },
  CommonID_HeadType_4_Desc = {
    Text = "Francobollo da Collezione"
  },
  CommonID_High_Desc = {Text = "Alto"},
  CommonID_Holy_Desc = {
    Text = "Santificazione"
  },
  CommonID_ID_Desc = {
    Text = "Indonesiano (alpha)"
  },
  CommonID_IT_Desc = {
    Text = "Italiano (alpha)"
  },
  CommonID_Image_Desc = {Text = "Immagine"},
  CommonID_Intent_AttackBuff_Desc = {
    Text = "Intento Mostro: Attacco e Potenziamento"
  },
  CommonID_Intent_AttackDebuffD09Skill2_Desc = {
    Text = "Intento Mostro: Attacco e Indebolimento"
  },
  CommonID_Intent_AttackDebuff_Desc = {
    Text = "Intento Mostro: Attacco e Indebolimento"
  },
  CommonID_Intent_AttackDefence_Desc = {
    Text = "Intento Mostro: Attacco e Difesa"
  },
  CommonID_Intent_Attack_Desc = {
    Text = "Intento Mostro: Attacco"
  },
  CommonID_Intent_Buff_Desc = {
    Text = "Intento Mostro: Potenziamento"
  },
  CommonID_Intent_Burst2_Desc = {
    Text = "Intento Mostro: Aliemus (Non-Attacco)"
  },
  CommonID_Intent_Burst3_Desc = {
    Text = "Intento Mostro: Super Aliemus"
  },
  CommonID_Intent_Burst4_Desc = {
    Text = "Intento Mostro: Fine Scatenare"
  },
  CommonID_Intent_Burst_Desc = {
    Text = "Intento Mostro: Aliemus"
  },
  CommonID_Intent_DCB022Buff_Desc = {
    Text = "Intento Mostro: Potenziamento"
  },
  CommonID_Intent_DCB024Buff_Desc = {
    Text = "Intento Mostro: Potenziamento"
  },
  CommonID_Intent_Debuff_Desc = {
    Text = "Intento Mostro: Indebolimento"
  },
  CommonID_Intent_DefenceBuff_Desc = {
    Text = "Intento Mostro: Difesa e Potenziamento"
  },
  CommonID_Intent_DefenceDebuff_Desc = {
    Text = "Intento Mostro: Difesa e Indebolimento"
  },
  CommonID_Intent_Defence_Desc = {
    Text = "Intento Mostro: Difesa"
  },
  CommonID_Intent_Dizzy_Desc = {
    Text = "Intento Mostro: Stordimento"
  },
  CommonID_Intent_HeavyAttackDCB02_Desc = {
    Text = "Intento Mostro: Attacco Pesante"
  },
  CommonID_Intent_HeavyAttack_Desc = {
    Text = "Intento Mostro: Attacco Pesante"
  },
  CommonID_Intent_StrongBuff_Desc = {
    Text = "Intento Mostro: Potenziamento Maggiore"
  },
  CommonID_Intent_StrongDebuff_Desc = {
    Text = "Intento Mostro: Indebolimento Maggiore"
  },
  CommonID_Intent_Unknown1_Desc = {
    Text = "Intento Mostro: Creatura Sconosciuta"
  },
  CommonID_Intent_Unknown2_Desc = {
    Text = "Intento Mostro: Creatura Sconosciuta"
  },
  CommonID_Intent_Unknown3_Desc = {
    Text = "Intento Mostro: Creatura Sconosciuta"
  },
  CommonID_Intent_Unknown4_Desc = {
    Text = "Intento Mostro: Creatura Sconosciuta"
  },
  CommonID_Intent_Unknown5_Desc = {
    Text = "Intento Mostro: Creatura Sconosciuta"
  },
  CommonID_Intent_Unknown6_Desc = {
    Text = "Intento Mostro: Creatura Sconosciuta"
  },
  CommonID_Intent_Unknown_Desc = {
    Text = "Intento Mostro: Creatura Sconosciuta"
  },
  CommonID_ItemManagement_Desc = {Text = "Oggetto"},
  CommonID_JP_Desc = {
    Text = "Giapponese (alpha)"
  },
  CommonID_KR_Desc = {
    Text = "Coreano (alpha)"
  },
  CommonID_Keeper_Skill_Desc = {
    Text = "Abilità del Custode"
  },
  CommonID_KeyType_1_Desc = {
    Text = "Capitolo dell'Oblio"
  },
  CommonID_KeyType_2_Desc = {Text = "Caos"},
  CommonID_KeyType_3_Desc = {Text = "Aequor"},
  CommonID_KeyType_4_Desc = {Text = "Caro"},
  CommonID_KeyType_5_Desc = {Text = "Ultra"},
  CommonID_Key_Desc = {Text = "Pulsante"},
  CommonID_Language_Desc = {Text = "Lingua"},
  CommonID_LevelLimit_Promote_Desc = {
    Text = "Aumento Limite Livello"
  },
  CommonID_Low_Desc = {Text = "Basso"},
  CommonID_Management_Desc = {
    Text = "Vai alla Gestione"
  },
  CommonID_ManiaHit_Desc = {
    Text = "Mania al Colpo"
  },
  CommonID_MasterVolume_Desc = {
    Text = "Controllo Generale"
  },
  CommonID_MaterialsReturn_Desc = {
    Text = "Rimborso risorse consumate"
  },
  CommonID_MessagePush_Desc = {
    Text = "Notifiche Push"
  },
  CommonID_Middle_Desc = {Text = "Medio"},
  CommonID_Modify_Desc = {
    Text = "Clicca per modificare"
  },
  CommonID_MonsterGrade1_Desc = {
    Text = "Servitore Grado 1"
  },
  CommonID_MonsterGrade2_Desc = {
    Text = "Servitore Grado 2"
  },
  CommonID_MotherTreeMonster_Desc = {
    Text = "\"Albero Madre della Fertilità\""
  },
  CommonID_MultiplierXP_Desc = {
    Text = "Moltiplicatore ESP"
  },
  CommonID_Mute_Desc = {Text = "Silenzio"},
  CommonID_NotAwakerMonster_Desc = {
    Text = "Boss Non Risvegliato"
  },
  CommonID_Open_Desc = {Text = "Apri"},
  CommonID_OperationImpossible_Desc = {
    Text = "Il giocatore non riesce a compiere azioni (giocare carte, Esaltare) per varie ragioni (Arithmetica insufficiente, turno non del giocatore, stato Sigillato, Pietrificato, ecc.)"
  },
  CommonID_OperationStop_Desc = {
    Text = "Il tempo di riflessione accumulato del nostro turno raggiunge il valore massimo (configurato nella tabella delle costanti)"
  },
  CommonID_Orange_Desc = {Text = "Oro"},
  CommonID_PT_Desc = {
    Text = "Portoghese (alpha)"
  },
  CommonID_PVP_Desc = {Text = "Traphase"},
  CommonID_PassiveSkill_Desc = {
    Text = "Abilità Passiva"
  },
  CommonID_PersonalProfile_Desc = {Text = "Profilo"},
  CommonID_PlayerEnter_Desc = {
    Text = "Inizio partita, dopo che il giocatore ha selezionato le proprie carte"
  },
  CommonID_PlayerFiles_Desc = {
    Text = "Profilo Custode"
  },
  CommonID_Potency_Desc = {Text = "Illuminare"},
  CommonID_Privacy_Desc = {Text = "Privacy"},
  CommonID_Purple_Desc = {
    Text = "Pendolo Crono"
  },
  CommonID_RU_Desc = {
    Text = "Russo (alpha)"
  },
  CommonID_RedGlow_Desc = {
    Text = "Effetto luce rossa"
  },
  CommonID_Red_Desc = {
    Text = "Maledizione"
  },
  CommonID_Redeem_Desc = {
    Text = "Vai al Riscatto"
  },
  CommonID_ReletedAwakerInEnemies_Desc = {
    Text = "Dialogo tra Risvegliatore nemico e Risvegliatore alleato"
  },
  CommonID_Relic_Desc = {Text = "Reliquia"},
  CommonID_Repair_Desc = {
    Text = "Vai alla Riparazione"
  },
  CommonID_ResNeedReduce_Desc = {
    Text = "Costo risorse ridotto"
  },
  CommonID_SUP_Desc = {Text = "Coro"},
  CommonID_SellCard_Desc = {
    Text = "Vendi Carte"
  },
  CommonID_ShortcutKey_Desc = {
    Text = "Tasto Rapido"
  },
  CommonID_SilverAchieve_Desc = {Text = "Argento"},
  CommonID_Sin_Desc = {
    Text = "Peccato Originale"
  },
  CommonID_SkillReady_Desc = {
    Text = "Il momento in cui l'indicatore Aliemus è pieno e può essere cliccato per Scatenare l'Esaltazione"
  },
  CommonID_Skill_LevelUp_Desc = {
    Text = "Potenzia Abilità"
  },
  CommonID_Slider_Desc = {
    Text = "Cursore del Valore"
  },
  CommonID_SlotCardLevel_Desc = {
    Text = "Livello Slot Predefinito"
  },
  CommonID_SoundBalance_Desc = {
    Text = "Equilibrio Sonoro"
  },
  CommonID_SpecificCommunicateTrig_Desc = {
    Text = "Condizione di completamento missione: attivare il dialogo designato"
  },
  CommonID_StageDropAdd_Desc = {
    Text = "Produzione del dungeon aumentata"
  },
  CommonID_Switch_Desc = {Text = "Cambia"},
  CommonID_System_Desc = {Text = "Sistema"},
  CommonID_TH_Desc = {
    Text = "Thailandese (alpha)"
  },
  CommonID_TRUE_Desc = {Text = "Sì"},
  CommonID_TR_Desc = {
    Text = "Turco (alpha)"
  },
  CommonID_TW_Desc = {
    Text = "Cinese tradizionale"
  },
  CommonID_T_Desc = {Text = "Guardiano"},
  CommonID_TaskCount_Desc = {Text = "Conteggio"},
  CommonID_TaskInProgress_Desc = {Text = "In corso"},
  CommonID_TaweiMonster_Desc = {
    Text = "Tawil l'Oscuro"
  },
  CommonID_Through1_Desc = {
    Text = "Abilità passiva 1"
  },
  CommonID_Through2_Desc = {
    Text = "Abilità passiva 2"
  },
  CommonID_Tips_Desc = {
    Text = "Indagine in corso"
  },
  CommonID_TranslationLabel_Desc = {
    Text = "Etichetta traduzione ufficiale"
  },
  CommonID_Ulti_Skill_Desc = {
    Text = "Esaltazione"
  },
  CommonID_UtlSkill_Promote_Desc = {
    Text = "Sovra-Esaltazione"
  },
  CommonID_VN_Desc = {
    Text = "Vietnamita (alpha)"
  },
  CommonID_VeryHigh_Desc = {
    Text = "Estremamente Alto"
  },
  CommonID_VeryLow_Desc = {
    Text = "Estremamente Basso"
  },
  CommonID_View_Desc = {
    Text = "Vai alla Verifica"
  },
  CommonID_Voice_Desc = {Text = "Suono."},
  CommonID_Web_Desc = {
    Text = "Reindirizzamento Pagina"
  },
  CommonID_White_Desc = {Text = "Argento"},
  CommonID_WindowNotFocusVoice_Desc = {
    Text = "Effetto Sonoro con Finestra non in Primo Piano"
  },
  CommonID_Window_Desc = {Text = "Finestra"},
  CommonID_YellowGlow_Desc = {
    Text = "Effetto luce gialla"
  }
})
return Text_CommonID
