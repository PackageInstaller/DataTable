__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_CommonID = readonly({
  CommonID_Account_Desc = {Text = "Cuenta"},
  CommonID_AchieveCommemorativeData_Dmg_Desc = {
    Text = "Daño máximo"
  },
  CommonID_AchieveCommemorativeData_Poison_Desc = {Text = "Máx Pisos"},
  CommonID_AchieveCommemorativeData_Time_Desc = {
    Text = "Tiempo de Compleción"
  },
  CommonID_AchieveType0_Desc = {
    Text = "Todos los Logros"
  },
  CommonID_AchieveType1_Desc = {
    Text = "Historia de Crecimiento"
  },
  CommonID_AchieveType2_Desc = {
    Text = "Marca de Investigación"
  },
  CommonID_AchieveType3_Desc = {
    Text = "Registro de Combate"
  },
  CommonID_AchieveType4_Desc = {
    Text = "La Vida del Guardián del Secreto"
  },
  CommonID_Add_State_Desc = {
    Text = "Agrega Estado"
  },
  CommonID_All_Desc = {Text = "Todo"},
  CommonID_AnyAvgFirstTrigger_Desc = {
    Text = "Condición de finalización de la misión: activar cualquier nodo de la historia"
  },
  CommonID_AnyEntryInGroupUnlock_Desc = {
    Text = "Criterios de finalización de la misión: desbloquear cualquier entrada en el compendio grupal"
  },
  CommonID_AnyEventFirstTrigger_Desc = {
    Text = "Criterios de Finalización de la Misión: Activa cualquier [Evento]"
  },
  CommonID_AnyItemFirstGet_Desc = {
    Text = "Condición de Finalización de la Misión: Obtener cualquier objeto"
  },
  CommonID_AnyNodeTypeFirstTrigger_Desc = {
    Text = "Condición de finalización de la misión: activar cualquier tipo de nodo"
  },
  CommonID_AnyRelicFirstGet_Desc = {
    Text = "Condición de completación de tarea: Obtener cualquier Reliquia"
  },
  CommonID_AnyStageFirstClear_Desc = {
    Text = "Criterios de finalización de la misión: completar cualquier fase de la lista por primera vez"
  },
  CommonID_AppointTaskRewardAdd_Desc = {
    Text = "Asignar para aumentar recompensas"
  },
  CommonID_Attr_Promote_Desc = {
    Text = "Mejora de atributos"
  },
  CommonID_AwakerDied_Desc = {
    Text = "Despertado fallecido"
  },
  CommonID_AwakerMonster_Desc = {
    Text = "Líder de Despertador"
  },
  CommonID_BN_Desc = {
    Text = "Bengalí (alpha)"
  },
  CommonID_BanBattlePos_Desc = {
    Text = "No se puede desplegar"
  },
  CommonID_Battle_Desc = {Text = "Batalla"},
  CommonID_Blue_Desc = {Text = "Azul"},
  CommonID_Boss_Desc = {Text = "Líder"},
  CommonID_BundleShortcutKey_Desc = {
    Text = "Vinculación de Llave"
  },
  CommonID_CN_Desc = {
    Text = "Chino simplificado"
  },
  CommonID_CardBorder_Desc = {
    Text = "Cosmético de carta"
  },
  CommonID_CardSlots_LevelUp_Desc = {
    Text = "Actualizar espacio"
  },
  CommonID_Card_AdvancedImagery_Desc = {
    Text = "Imágenes avanzadas"
  },
  CommonID_Card_AttachPost_Desc = {Text = "Perseguir"},
  CommonID_Card_Awake_Desc = {Text = "Activar"},
  CommonID_Card_Curse_Desc = {
    Text = "Carta de síntoma"
  },
  CommonID_Card_Defend_Desc = {
    Text = "Carta de Defensa"
  },
  CommonID_Card_Developing_Desc = {
    Text = "En desarrollo"
  },
  CommonID_Card_Extend_Desc = {
    Text = "Carta Derivada"
  },
  CommonID_Card_Fraud_Desc = {Text = "Fraude"},
  CommonID_Card_Imagery_Desc = {Text = "Imágenes"},
  CommonID_Card_KeeperSkill_Desc = {
    Text = "Carta de Posse"
  },
  CommonID_Card_Potion_Desc = {
    Text = "Carta de Poción"
  },
  CommonID_Card_Skill_Desc = {
    Text = "Carta de habilidad"
  },
  CommonID_Card_State_Desc = {
    Text = "Carta de estado"
  },
  CommonID_Card_Strike_Desc = {
    Text = "Carta de Golpe"
  },
  CommonID_Card_Weapon_Desc = {
    Text = "Carta de la Rueda del Destino"
  },
  CommonID_CastSkillLevel_Desc = {
    Text = "Nivel de lanzamiento de habilidades"
  },
  CommonID_Challenge_Desc = {
    Text = "Investigación"
  },
  CommonID_Change_Skill_Desc = {
    Text = "Reemplazar Habilidad"
  },
  CommonID_Chinese_Desc = {Text = "Chino"},
  CommonID_ChooseHandCard_Desc = {
    Text = "Elige una carta de mano"
  },
  CommonID_ClickToQuit_Desc = {
    Text = "Haz clic para salir"
  },
  CommonID_ClickToView_Desc = {
    Text = "Haz clic para ver"
  },
  CommonID_Click_Desc = {
    Text = "Haz clic para Saltar"
  },
  CommonID_Close_Desc = {Text = "Cerrar"},
  CommonID_ComingSoon_Desc = {
    Text = "Próximamente"
  },
  CommonID_CommonAttr_Desc = {
    Text = "Aumento de Atributo General"
  },
  CommonID_Common_Desc = {Text = "Normal"},
  CommonID_ContinuousSound_Desc = {
    Text = "Reproducción continua"
  },
  CommonID_CopperAchieve_Desc = {Text = "Cobre"},
  CommonID_CountingStart_Desc = {
    Text = "Inicio de la cuenta regresiva en mi turno"
  },
  CommonID_Custom_Desc = {
    Text = "Personalizado"
  },
  CommonID_DE_Desc = {
    Text = "Alemán (GPT beta)"
  },
  CommonID_DPS_Desc = {Text = "Ofensivo"},
  CommonID_DepressionHit_Desc = {
    Text = "Depresión inducida por un golpe"
  },
  CommonID_DisableKeeperSkill_Desc = {
    Text = "Deshabilitar habilidades del protagonista"
  },
  CommonID_DisableTrinketSuitEffect_Desc = {
    Text = "Deshabilitar pacto"
  },
  CommonID_DisableWeapon_Desc = {
    Text = "Desactivar rueda del destino"
  },
  CommonID_Display_Desc = {Text = "Visual"},
  CommonID_DropdownList_Desc = {
    Text = "Lista Desplegable"
  },
  CommonID_EN_Desc = {
    Text = "Inglés (GPT beta)"
  },
  CommonID_ES_Desc = {
    Text = "Español (GPT beta)"
  },
  CommonID_Elite_Desc = {Text = "Élite"},
  CommonID_EmojiType_10_Desc = {
    Text = "Pequeño Mythag"
  },
  CommonID_EmojiType_11_Desc = {Text = "Mi turno"},
  CommonID_EmojiType_12_Desc = {
    Text = "Mythag diario"
  },
  CommonID_EmojiType_13_Desc = {Text = "Feliz mito"},
  CommonID_EmojiType_14_Desc = {
    Text = "Enfadado con Misaq"
  },
  CommonID_EmojiType_15_Desc = {
    Text = "Vida escolar"
  },
  CommonID_EmojiType_16_Desc = {
    Text = "Día pacífico"
  },
  CommonID_EmojiType_17_Desc = {
    Text = "Después de clase"
  },
  CommonID_EmojiType_18_Desc = {Text = "Misaq"},
  CommonID_EmojiType_19_Desc = {
    Text = "Vacaciones de Misaq"
  },
  CommonID_EmojiType_1_Desc = {
    Text = "Mito regordete"
  },
  CommonID_EmojiType_20_Desc = {
    Text = "Misaq del Festival de Invierno"
  },
  CommonID_EmojiType_21_Desc = {
    Text = "Fiesta de Jengibre"
  },
  CommonID_EmojiType_22_Desc = {
    Text = "Datos divertidos del campus"
  },
  CommonID_EmojiType_23_Desc = {
    Text = "Investigador de Misaq"
  },
  CommonID_EmojiType_24_Desc = {
    Text = "Interludio de Misaq"
  },
  CommonID_EmojiType_25_Desc = {
    Text = "Canción de Saya"
  },
  CommonID_EmojiType_2_Desc = {Text = "Mori mori"},
  CommonID_EmojiType_3_Desc = {
    Text = "Maravillas del mundo"
  },
  CommonID_EmojiType_4_Desc = {
    Text = "Mori-chibis"
  },
  CommonID_EmojiType_5_Desc = {
    Text = "Traphase comm"
  },
  CommonID_EmojiType_6_Desc = {
    Text = "Mito brillante"
  },
  CommonID_EmojiType_7_Desc = {Text = "Mito loco"},
  CommonID_EmojiType_8_Desc = {
    Text = "Easy mythag"
  },
  CommonID_EmojiType_9_Desc = {
    Text = "Sabiduría mitag"
  },
  CommonID_Enchant_Desc = {
    Text = "Inscripción"
  },
  CommonID_Entrance_Desc = {
    Text = "Entrada Emergente"
  },
  CommonID_FALSE_Desc = {Text = "No"},
  CommonID_FR_Desc = {
    Text = "Francés (GPT beta)"
  },
  CommonID_Forged_Desc = {Text = "Refuerzo"},
  CommonID_FreeBattlePos_Desc = {
    Text = "Despliegue Libre"
  },
  CommonID_FullScreen_Desc = {
    Text = "Pantalla Completa"
  },
  CommonID_Gender_Boy_Desc = {Text = "Hombre"},
  CommonID_Gender_Girl_Desc = {Text = "Mujer"},
  CommonID_GetLikeLevel_Desc = {Text = "Función"},
  CommonID_GmaeVoice_Desc = {
    Text = "Audio del Juego"
  },
  CommonID_GoldAchieve_Desc = {Text = "Oro"},
  CommonID_Hall_Desc = {Text = "Lobby"},
  CommonID_HarvestAdd_Desc = {
    Text = "Aumenta las recompensas del Hogar"
  },
  CommonID_HaveAwaker_Desc = {
    Text = "Condición de finalización de misión: Poseer cualquier Despertador de la lista"
  },
  CommonID_HeadType_1_Desc = {
    Text = "Por la Llave de Plata"
  },
  CommonID_HeadType_2_Desc = {
    Text = "Archivo de Dandelion"
  },
  CommonID_HeadType_3_Desc = {
    Text = "Ayer que no desvanece"
  },
  CommonID_HeadType_4_Desc = {
    Text = "Colección de sellos"
  },
  CommonID_High_Desc = {Text = "Alto"},
  CommonID_Holy_Desc = {
    Text = "Sanctificación"
  },
  CommonID_ID_Desc = {
    Text = "Indonesio (GPT beta)"
  },
  CommonID_IT_Desc = {
    Text = "Italiano (alpha)"
  },
  CommonID_Image_Desc = {Text = "Imagen"},
  CommonID_Intent_AttackBuff_Desc = {
    Text = "El monstruo tiene la intención de atacar y fortalecer."
  },
  CommonID_Intent_AttackDebuffD09Skill2_Desc = {
    Text = "Intención del monstruo atacar y debilitar"
  },
  CommonID_Intent_AttackDebuff_Desc = {
    Text = "Intención del monstruo atacar y debilitar"
  },
  CommonID_Intent_AttackDefence_Desc = {
    Text = "Intenciones del Monstruo: Ataque y Defensa"
  },
  CommonID_Intent_Attack_Desc = {
    Text = "El monstruo tiene la intención de atacar"
  },
  CommonID_Intent_Buff_Desc = {
    Text = "Intención del monstruo fortalecer"
  },
  CommonID_Intent_Burst2_Desc = {
    Text = "Intenciones del Monstruo: Aliemus (No Ataque)"
  },
  CommonID_Intent_Burst3_Desc = {
    Text = "Intención del Monstruo: Super Aliemus"
  },
  CommonID_Intent_Burst4_Desc = {
    Text = "El monstruo pretende desatar el fin."
  },
  CommonID_Intent_Burst_Desc = {
    Text = "Intención del Monstruo: Aliemus"
  },
  CommonID_Intent_DCB022Buff_Desc = {
    Text = "Intención del monstruo fortalecer"
  },
  CommonID_Intent_DCB024Buff_Desc = {
    Text = "Intención del monstruo fortalecer"
  },
  CommonID_Intent_Debuff_Desc = {
    Text = "El monstruo tiene la intención de debilitar"
  },
  CommonID_Intent_DefenceBuff_Desc = {
    Text = "El monstruo tiene la intención de defender y fortalecer."
  },
  CommonID_Intent_DefenceDebuff_Desc = {
    Text = "Intenciones del Monstruo: Defensa y Debilitamiento"
  },
  CommonID_Intent_Defence_Desc = {
    Text = "Intención del Monstruo: Defensa"
  },
  CommonID_Intent_Dizzy_Desc = {
    Text = "Intención del Monstruo: Aturdir"
  },
  CommonID_Intent_HeavyAttackDCB02_Desc = {
    Text = "Intención del monstruo ataque fuerte"
  },
  CommonID_Intent_HeavyAttack_Desc = {
    Text = "Intención del monstruo ataque fuerte"
  },
  CommonID_Intent_StrongBuff_Desc = {
    Text = "El monstruo tiene la intención de someterse a un fortalecimiento significativo"
  },
  CommonID_Intent_StrongDebuff_Desc = {
    Text = "El monstruo tiene la intención de debilitarse significativamente"
  },
  CommonID_Intent_Unknown1_Desc = {
    Text = "Intención del monstruo desconocida"
  },
  CommonID_Intent_Unknown2_Desc = {
    Text = "Intención del monstruo desconocida"
  },
  CommonID_Intent_Unknown3_Desc = {
    Text = "Intención del monstruo desconocida"
  },
  CommonID_Intent_Unknown4_Desc = {
    Text = "Intención del monstruo desconocida"
  },
  CommonID_Intent_Unknown5_Desc = {
    Text = "Intención del monstruo desconocida"
  },
  CommonID_Intent_Unknown6_Desc = {
    Text = "Intención del monstruo desconocida"
  },
  CommonID_Intent_Unknown_Desc = {
    Text = "Intención del monstruo desconocida"
  },
  CommonID_ItemManagement_Desc = {Text = "Objeto"},
  CommonID_JP_Desc = {
    Text = "Japonés (GPT beta)"
  },
  CommonID_KR_Desc = {
    Text = "Coreano (GPT beta)"
  },
  CommonID_Keeper_Skill_Desc = {
    Text = "Habilidades del Protagonista"
  },
  CommonID_KeyType_1_Desc = {
    Text = "Capítulo Olvidado"
  },
  CommonID_KeyType_2_Desc = {
    Text = "Reino del Caos"
  },
  CommonID_KeyType_3_Desc = {
    Text = "Reino Aequor"
  },
  CommonID_KeyType_4_Desc = {
    Text = "Reino de carne y sangre"
  },
  CommonID_KeyType_5_Desc = {
    Text = "Reino ultra"
  },
  CommonID_Key_Desc = {Text = "Botón"},
  CommonID_Language_Desc = {Text = "Lenguaje"},
  CommonID_LevelLimit_Promote_Desc = {
    Text = "Aumento del límite de nivel"
  },
  CommonID_Low_Desc = {Text = "Bajo"},
  CommonID_Management_Desc = {
    Text = "Ve a Gestió"
  },
  CommonID_ManiaHit_Desc = {
    Text = "Frenético al Golpear"
  },
  CommonID_MasterVolume_Desc = {
    Text = "Control total"
  },
  CommonID_MaterialsReturn_Desc = {
    Text = "Reembolsar recursos agotados"
  },
  CommonID_MessagePush_Desc = {
    Text = "Notificación Push"
  },
  CommonID_Middle_Desc = {
    Text = "Traducción Sugerida"
  },
  CommonID_Modify_Desc = {
    Text = "Pulsa para modificar"
  },
  CommonID_MonsterGrade1_Desc = {
    Text = "Un Mob de Nivel 1"
  },
  CommonID_MonsterGrade2_Desc = {
    Text = "Minion de Nivel 2"
  },
  CommonID_MotherTreeMonster_Desc = {
    Text = "El árbol madre"
  },
  CommonID_MultiplierXP_Desc = {
    Text = "Aumento de EXP Múltiple"
  },
  CommonID_Mute_Desc = {Text = "Silencio"},
  CommonID_NotAwakerMonster_Desc = {
    Text = "Líder No Despertado"
  },
  CommonID_Open_Desc = {Text = "Abierto"},
  CommonID_OperationImpossible_Desc = {
    Text = "El jugador no puede realizar con éxito la operación (jugar una carta, estallido de locura) por varias razones (falta de aritmética, no ser su turno, estar sellado o petrificado, etc.)"
  },
  CommonID_OperationStop_Desc = {
    Text = "Se ha alcanzado el valor máximo acumulado para el tiempo de pensamiento durante el turno del jugador (configurado en la tabla de constantes)"
  },
  CommonID_Orange_Desc = {Text = "Oro"},
  CommonID_PT_Desc = {
    Text = "Portugués (GPT beta)"
  },
  CommonID_PVP_Desc = {
    Text = "Fase de Duelo"
  },
  CommonID_PassiveSkill_Desc = {
    Text = "Habilidad Pasiva"
  },
  CommonID_PersonalProfile_Desc = {Text = "Perfil"},
  CommonID_PlayerEnter_Desc = {
    Text = "Al comenzar el juego, después de que los jugadores seleccionan sus cartas"
  },
  CommonID_PlayerFiles_Desc = {
    Text = "Archivo del Guardián"
  },
  CommonID_Potency_Desc = {
    Text = "Despertar Espiritual"
  },
  CommonID_Privacy_Desc = {Text = "Privacidad"},
  CommonID_Purple_Desc = {
    Text = "Péndulo crono"
  },
  CommonID_RU_Desc = {
    Text = "Ruso (GPT beta)"
  },
  CommonID_RedGlow_Desc = {
    Text = "Efecto de Luz Roja"
  },
  CommonID_Red_Desc = {Text = "Maldición"},
  CommonID_Redeem_Desc = {
    Text = "Ve a Canjear"
  },
  CommonID_ReletedAwakerInEnemies_Desc = {
    Text = "Diálogo entre Despertados de mi facción y Despertados de la facción enemiga"
  },
  CommonID_Relic_Desc = {Text = "Reliquia"},
  CommonID_Repair_Desc = {
    Text = "Procede a Reparar"
  },
  CommonID_ResNeedReduce_Desc = {
    Text = "Requisitos de recursos reducidos"
  },
  CommonID_SUP_Desc = {Text = "Apoyo"},
  CommonID_SellCard_Desc = {
    Text = "Vender Cartas"
  },
  CommonID_ShortcutKey_Desc = {
    Text = "Tecla de acceso rápido"
  },
  CommonID_SilverAchieve_Desc = {Text = "Plata"},
  CommonID_Sin_Desc = {
    Text = "Pecado Original"
  },
  CommonID_SkillReady_Desc = {
    Text = "El momento en que la barra de locura se llena y se puede hacer clic para exaltar"
  },
  CommonID_Skill_LevelUp_Desc = {
    Text = "Mejora Habilidad"
  },
  CommonID_Slider_Desc = {
    Text = "Deslizador de Valor"
  },
  CommonID_SlotCardLevel_Desc = {
    Text = "Nivel de Espacio Original"
  },
  CommonID_SoundBalance_Desc = {
    Text = "Balance Sonoro"
  },
  CommonID_SpecificCommunicateTrig_Desc = {
    Text = "Condición de finalización de la misión: activar el diálogo del comunicador designado."
  },
  CommonID_StageDropAdd_Desc = {
    Text = "Aumenta la producción de la mazmorras"
  },
  CommonID_Switch_Desc = {Text = "Cambiar"},
  CommonID_System_Desc = {Text = "Sistema"},
  CommonID_TH_Desc = {
    Text = "Tailandés (GPT beta)"
  },
  CommonID_TRUE_Desc = {Text = "Sí"},
  CommonID_TR_Desc = {
    Text = "Turco (alpha)"
  },
  CommonID_TW_Desc = {
    Text = "Chino Tradicional"
  },
  CommonID_T_Desc = {Text = "Defensivo"},
  CommonID_TaskCount_Desc = {Text = "Contar"},
  CommonID_TaskInProgress_Desc = {
    Text = "En progreso"
  },
  CommonID_TaweiMonster_Desc = {
    Text = "Tawil la Oscura"
  },
  CommonID_Through1_Desc = {
    Text = "Habilidad Pasiva 1"
  },
  CommonID_Through2_Desc = {
    Text = "Habilidad Pasiva 2"
  },
  CommonID_Tips_Desc = {Text = "Sugerencia"},
  CommonID_TranslationLabel_Desc = {
    Text = "Marcador de progreso de traducción"
  },
  CommonID_Ulti_Skill_Desc = {Text = "Exaltar"},
  CommonID_UtlSkill_Promote_Desc = {
    Text = "Sobreexaltación"
  },
  CommonID_VN_Desc = {
    Text = "Vietnamita (GPT beta)"
  },
  CommonID_VeryHigh_Desc = {
    Text = "Extremadamente Alto"
  },
  CommonID_VeryLow_Desc = {
    Text = "Extremadamente Bajo"
  },
  CommonID_View_Desc = {
    Text = "Ve y revisa"
  },
  CommonID_Voice_Desc = {Text = "Sonido"},
  CommonID_Web_Desc = {
    Text = "Redireccionamiento de Página"
  },
  CommonID_White_Desc = {Text = "Plata"},
  CommonID_WindowNotFocusVoice_Desc = {
    Text = "Efecto de sonido no enfocado de la ventana"
  },
  CommonID_Window_Desc = {Text = "Ventana"},
  CommonID_YellowGlow_Desc = {
    Text = "Efecto de Luz Amarilla"
  }
})
return Text_CommonID
