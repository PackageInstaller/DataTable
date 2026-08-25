__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_CommonID = readonly({
  CommonID_Account_Desc = {Text = "Compte"},
  CommonID_AchieveCommemorativeData_Dmg_Desc = {
    Text = "Maximum Dégâts"
  },
  CommonID_AchieveCommemorativeData_Poison_Desc = {
    Text = "Max Étages"
  },
  CommonID_AchieveCommemorativeData_Time_Desc = {
    Text = "Temps de Complétion"
  },
  CommonID_AchieveType0_Desc = {
    Text = "Tous les Succès"
  },
  CommonID_AchieveType1_Desc = {
    Text = "Histoire de croissance"
  },
  CommonID_AchieveType2_Desc = {
    Text = "Marque d'investigation"
  },
  CommonID_AchieveType3_Desc = {
    Text = "Enregistrement de Combat"
  },
  CommonID_AchieveType4_Desc = {
    Text = "La Vie du Gardien Secret"
  },
  CommonID_Add_State_Desc = {
    Text = "Ajoutez État"
  },
  CommonID_All_Desc = {Text = "Tout"},
  CommonID_AnyAvgFirstTrigger_Desc = {
    Text = "Condition de complétion de la mission : déclencher tout nœud d'histoire"
  },
  CommonID_AnyEntryInGroupUnlock_Desc = {
    Text = "Critères de complétion de la mission : Déverrouiller n'importe quelle entrée dans le recueil de groupe"
  },
  CommonID_AnyEventFirstTrigger_Desc = {
    Text = "Critères d'achèvement de la quête : Déclenchez n'importe quel [Événement]"
  },
  CommonID_AnyItemFirstGet_Desc = {
    Text = "Condition de Complétion de la Quête : Obtenez n'importe quel objet"
  },
  CommonID_AnyNodeTypeFirstTrigger_Desc = {
    Text = "Condition de complétion de la mission : Déclencher n'importe quel type de nœud"
  },
  CommonID_AnyRelicFirstGet_Desc = {
    Text = "Condition d'achèvement de la tâche : Obtenez n'importe quelle Relique"
  },
  CommonID_AnyStageFirstClear_Desc = {
    Text = "Critères de complétion de la mission : nettoyer n'importe quelle étape de la liste pour la première fois"
  },
  CommonID_AppointTaskRewardAdd_Desc = {
    Text = "Attribuer pour augmenter les récompenses"
  },
  CommonID_Attr_Promote_Desc = {
    Text = "Amélioration des attributs"
  },
  CommonID_AwakerDied_Desc = {
    Text = "Réveilleur décédé"
  },
  CommonID_AwakerMonster_Desc = {
    Text = "Leader Éveilleur"
  },
  CommonID_BN_Desc = {
    Text = "Bengali (alpha)"
  },
  CommonID_BanBattlePos_Desc = {
    Text = "Impossible de déployer"
  },
  CommonID_Battle_Desc = {Text = "Bataille"},
  CommonID_Blue_Desc = {Text = "Bleu"},
  CommonID_Boss_Desc = {Text = "Chef"},
  CommonID_BundleShortcutKey_Desc = {
    Text = "Liaison de clé"
  },
  CommonID_CN_Desc = {
    Text = ": Chinois simplifié"
  },
  CommonID_CardBorder_Desc = {
    Text = "Cosmétique de carte"
  },
  CommonID_CardSlots_LevelUp_Desc = {
    Text = "Améliorer l'emplacement"
  },
  CommonID_Card_AdvancedImagery_Desc = {
    Text = "Imagerie avancée"
  },
  CommonID_Card_AttachPost_Desc = {Text = "Poursuite"},
  CommonID_Card_Awake_Desc = {Text = "Éveiller"},
  CommonID_Card_Curse_Desc = {
    Text = "Carte de symptôme"
  },
  CommonID_Card_Defend_Desc = {
    Text = "Carte de Défense"
  },
  CommonID_Card_Developing_Desc = {
    Text = "En développement"
  },
  CommonID_Card_Extend_Desc = {
    Text = "Carte Dérivée"
  },
  CommonID_Card_Fraud_Desc = {Text = "Fraude"},
  CommonID_Card_Imagery_Desc = {Text = "Imagerie"},
  CommonID_Card_KeeperSkill_Desc = {
    Text = "Carte de Posse"
  },
  CommonID_Card_Potion_Desc = {
    Text = "Carte de Potion"
  },
  CommonID_Card_Skill_Desc = {
    Text = "Carte de compétence"
  },
  CommonID_Card_State_Desc = {
    Text = "Carte d'état"
  },
  CommonID_Card_Strike_Desc = {
    Text = "Carte de frappe"
  },
  CommonID_Card_Weapon_Desc = {
    Text = "Roulette de la Destinée Carte"
  },
  CommonID_CastSkillLevel_Desc = {
    Text = "Niveau de lancement de compétence"
  },
  CommonID_Challenge_Desc = {
    Text = "Investigation"
  },
  CommonID_Change_Skill_Desc = {
    Text = "Remplacer la compétence"
  },
  CommonID_Chinese_Desc = {Text = "Chinois"},
  CommonID_ChooseHandCard_Desc = {
    Text = "Choisissez une carte de mai"
  },
  CommonID_ClickToQuit_Desc = {
    Text = "Cliquez pour quitter"
  },
  CommonID_ClickToView_Desc = {
    Text = "Cliquez pour voir"
  },
  CommonID_Click_Desc = {
    Text = "Cliquez pour sauter"
  },
  CommonID_Close_Desc = {Text = "Fermer"},
  CommonID_ComingSoon_Desc = {Text = "À suivre"},
  CommonID_CommonAttr_Desc = {
    Text = "Augmentation d'attribut général"
  },
  CommonID_Common_Desc = {Text = "Ordinaire"},
  CommonID_ContinuousSound_Desc = {
    Text = "Lecture continue"
  },
  CommonID_CopperAchieve_Desc = {Text = "Cuivre"},
  CommonID_CountingStart_Desc = {
    Text = "Compte à rebours lancé pendant notre tour"
  },
  CommonID_Custom_Desc = {
    Text = "Personnalisé"
  },
  CommonID_DE_Desc = {
    Text = "Allemand (GPT beta)"
  },
  CommonID_DPS_Desc = {Text = "Assaut"},
  CommonID_DepressionHit_Desc = {
    Text = "Dépression induite par un coup"
  },
  CommonID_DisableKeeperSkill_Desc = {
    Text = "Désactiver les Compétences du Protagoniste"
  },
  CommonID_DisableTrinketSuitEffect_Desc = {
    Text = "Désactiver le pacte"
  },
  CommonID_DisableWeapon_Desc = {
    Text = "Désactiver la Roue du Destin"
  },
  CommonID_Display_Desc = {Text = "Visuel"},
  CommonID_DropdownList_Desc = {
    Text = "Liste déroulante"
  },
  CommonID_EN_Desc = {
    Text = "Anglais (bêta)"
  },
  CommonID_ES_Desc = {
    Text = "Espagnol (GPT beta)"
  },
  CommonID_Elite_Desc = {Text = "Élite"},
  CommonID_EmojiType_10_Desc = {
    Text = "Petit mythag"
  },
  CommonID_EmojiType_11_Desc = {
    Text = "Tour inverse"
  },
  CommonID_EmojiType_12_Desc = {
    Text = "Mythag quotidien"
  },
  CommonID_EmojiType_13_Desc = {
    Text = "Mythag heureux"
  },
  CommonID_EmojiType_14_Desc = {
    Text = "Myrthag mécontent"
  },
  CommonID_EmojiType_15_Desc = {
    Text = "Vie scolaire"
  },
  CommonID_EmojiType_16_Desc = {
    Text = "Journée paisible"
  },
  CommonID_EmojiType_17_Desc = {
    Text = "Après l'école"
  },
  CommonID_EmojiType_18_Desc = {
    Text = "Mizag avec amour"
  },
  CommonID_EmojiType_19_Desc = {
    Text = "Vacances de Mizag"
  },
  CommonID_EmojiType_1_Desc = {
    Text = "Mythag dodu"
  },
  CommonID_EmojiType_20_Desc = {
    Text = "Hiver Mizag"
  },
  CommonID_EmojiType_21_Desc = {
    Text = "Fête en pain d'épice"
  },
  CommonID_EmojiType_22_Desc = {
    Text = "Faits amusants sur le campus"
  },
  CommonID_EmojiType_23_Desc = {
    Text = "Enquêteur de Mythag"
  },
  CommonID_EmojiType_24_Desc = {
    Text = "Interlude de Mizag"
  },
  CommonID_EmojiType_25_Desc = {
    Text = "Chant de Saya"
  },
  CommonID_EmojiType_2_Desc = {Text = "Mori mori"},
  CommonID_EmojiType_3_Desc = {
    Text = "Merveilles matérielles"
  },
  CommonID_EmojiType_4_Desc = {
    Text = "Mori-chibis"
  },
  CommonID_EmojiType_5_Desc = {
    Text = "Traphase comm"
  },
  CommonID_EmojiType_6_Desc = {
    Text = "Mythag brillant"
  },
  CommonID_EmojiType_7_Desc = {Text = "Mythag fou"},
  CommonID_EmojiType_8_Desc = {
    Text = "Easy mythag"
  },
  CommonID_EmojiType_9_Desc = {
    Text = "Sagesse de Myrhag"
  },
  CommonID_Enchant_Desc = {Text = "Oraison"},
  CommonID_Entrance_Desc = {
    Text = "Entrée Pop-up"
  },
  CommonID_FALSE_Desc = {Text = "Non"},
  CommonID_FR_Desc = {
    Text = "Français (GPT beta)"
  },
  CommonID_Forged_Desc = {
    Text = "Renforcement"
  },
  CommonID_FreeBattlePos_Desc = {
    Text = "Déploiement Gratuit"
  },
  CommonID_FullScreen_Desc = {
    Text = "Plein écran"
  },
  CommonID_Gender_Boy_Desc = {Text = "Homme"},
  CommonID_Gender_Girl_Desc = {Text = "Femme"},
  CommonID_GetLikeLevel_Desc = {Text = "Fonction"},
  CommonID_GmaeVoice_Desc = {
    Text = "Audio du Jeu"
  },
  CommonID_GoldAchieve_Desc = {Text = "Or"},
  CommonID_Hall_Desc = {Text = "Hall"},
  CommonID_HarvestAdd_Desc = {
    Text = "Augmentation des récompenses de Foyer"
  },
  CommonID_HaveAwaker_Desc = {
    Text = "Condition de complétion de la mission : Posséder un quelconque Réveiller de la liste"
  },
  CommonID_HeadType_1_Desc = {
    Text = "Au nom de la Clé d'Argent"
  },
  CommonID_HeadType_2_Desc = {
    Text = "Photo de dossier mélancolique"
  },
  CommonID_HeadType_3_Desc = {
    Text = "Hier qui ne s'estompe pas"
  },
  CommonID_HeadType_4_Desc = {
    Text = "Collection de timbres"
  },
  CommonID_High_Desc = {Text = "Élevé"},
  CommonID_Holy_Desc = {
    Text = "Sanctification"
  },
  CommonID_ID_Desc = {
    Text = "Indonésien (GPT beta)"
  },
  CommonID_IT_Desc = {
    Text = "Italien (alpha)"
  },
  CommonID_Image_Desc = {Text = "Image"},
  CommonID_Intent_AttackBuff_Desc = {
    Text = "Le Monstre a l'intention d'attaquer et de renforcer."
  },
  CommonID_Intent_AttackDebuffD09Skill2_Desc = {
    Text = ": Intention du monstre d'attaquer et d'affaiblir"
  },
  CommonID_Intent_AttackDebuff_Desc = {
    Text = ": Intention du monstre d'attaquer et d'affaiblir"
  },
  CommonID_Intent_AttackDefence_Desc = {
    Text = "Intentions du Monstre : Attaque et Défense"
  },
  CommonID_Intent_Attack_Desc = {
    Text = "Le monstre a l'intention d'attaquer"
  },
  CommonID_Intent_Buff_Desc = {
    Text = ": Intention du monstre de renforcer"
  },
  CommonID_Intent_Burst2_Desc = {
    Text = "Intentions du Monstre : Aliemus (Non-Attaque)"
  },
  CommonID_Intent_Burst3_Desc = {
    Text = "Intention du Monstre : Super Aliemus"
  },
  CommonID_Intent_Burst4_Desc = {
    Text = "Le monstre a l'intention de libérer la fin."
  },
  CommonID_Intent_Burst_Desc = {
    Text = "Intention du Monstre : Aliemus"
  },
  CommonID_Intent_DCB022Buff_Desc = {
    Text = ": Intention du monstre de renforcer"
  },
  CommonID_Intent_DCB024Buff_Desc = {
    Text = ": Intention du monstre de renforcer"
  },
  CommonID_Intent_Debuff_Desc = {
    Text = "Le monstre a l'intention d'affaiblir"
  },
  CommonID_Intent_DefenceBuff_Desc = {
    Text = "Le Monstre a l'intention de défendre et de renforcer."
  },
  CommonID_Intent_DefenceDebuff_Desc = {
    Text = "Intentions du Monstre : Défense et Affaiblir"
  },
  CommonID_Intent_Defence_Desc = {
    Text = "Intention du Monstre : Défense"
  },
  CommonID_Intent_Dizzy_Desc = {
    Text = "Intention du Monstre : Étourdissement"
  },
  CommonID_Intent_HeavyAttackDCB02_Desc = {
    Text = ": Intention du monstre d'attaque lourde"
  },
  CommonID_Intent_HeavyAttack_Desc = {
    Text = ": Intention du monstre d'attaque lourde"
  },
  CommonID_Intent_StrongBuff_Desc = {
    Text = "Le Monstre a l'intention de subir un renforcement significatif"
  },
  CommonID_Intent_StrongDebuff_Desc = {
    Text = "Le Monstre a l'intention d'affaiblir significativement"
  },
  CommonID_Intent_Unknown1_Desc = {
    Text = ": Intention du monstre inconnue"
  },
  CommonID_Intent_Unknown2_Desc = {
    Text = ": Intention du monstre inconnue"
  },
  CommonID_Intent_Unknown3_Desc = {
    Text = ": Intention du monstre inconnue"
  },
  CommonID_Intent_Unknown4_Desc = {
    Text = ": Intention du monstre inconnue"
  },
  CommonID_Intent_Unknown5_Desc = {
    Text = ": Intention du monstre inconnue"
  },
  CommonID_Intent_Unknown6_Desc = {
    Text = ": Intention du monstre inconnue"
  },
  CommonID_Intent_Unknown_Desc = {
    Text = ": Intention du monstre inconnue"
  },
  CommonID_ItemManagement_Desc = {Text = "Objet"},
  CommonID_JP_Desc = {
    Text = "Japonais (GPT beta)"
  },
  CommonID_KR_Desc = {
    Text = "Coréen (GPT beta)"
  },
  CommonID_Keeper_Skill_Desc = {
    Text = "Compétences du protagoniste"
  },
  CommonID_KeyType_1_Desc = {Text = "Oubli"},
  CommonID_KeyType_2_Desc = {
    Text = "Domaine du Chaos"
  },
  CommonID_KeyType_3_Desc = {
    Text = "Royaume d'Aequor"
  },
  CommonID_KeyType_4_Desc = {
    Text = "Royaume de Chair et de Sang"
  },
  CommonID_KeyType_5_Desc = {
    Text = "Ultra royaume"
  },
  CommonID_Key_Desc = {Text = "Bouto"},
  CommonID_Language_Desc = {Text = "Langue"},
  CommonID_LevelLimit_Promote_Desc = {
    Text = ": Limite de niveau augmentée"
  },
  CommonID_Low_Desc = {Text = "Bas"},
  CommonID_Management_Desc = {
    Text = "Va à la Gestion"
  },
  CommonID_ManiaHit_Desc = {
    Text = "Frénétique à l'impact"
  },
  CommonID_MasterVolume_Desc = {
    Text = "Contrôle général"
  },
  CommonID_MaterialsReturn_Desc = {
    Text = "Rembourser des ressources épuisées"
  },
  CommonID_MessagePush_Desc = {
    Text = "Notification Push"
  },
  CommonID_Middle_Desc = {
    Text = "Traduction Suggerée"
  },
  CommonID_Modify_Desc = {
    Text = "Cliquez pour modifier"
  },
  CommonID_MonsterGrade1_Desc = {
    Text = "Un Mob de Niveau 1"
  },
  CommonID_MonsterGrade2_Desc = {
    Text = "Minion de Niveau 2"
  },
  CommonID_MotherTreeMonster_Desc = {
    Text = "L'arbre mère"
  },
  CommonID_MultiplierXP_Desc = {
    Text = "Boost d'EXP Multiple"
  },
  CommonID_Mute_Desc = {Text = "Silence"},
  CommonID_NotAwakerMonster_Desc = {
    Text = "Leader non-éveillé"
  },
  CommonID_Open_Desc = {Text = "Ouvrir"},
  CommonID_OperationImpossible_Desc = {
    Text = "Le joueur ne peut pas effectuer d'actions (jouer des cartes, libérer l'exaltation) en raison de diverses raisons (puissance de calcul insuffisante, tour adverse, scellement, pétrification, etc.)."
  },
  CommonID_OperationStop_Desc = {
    Text = "La durée cumulée de réflexion pendant le tour allié a atteint sa valeur maximale (configurée dans la table des constantes)"
  },
  CommonID_Orange_Desc = {Text = "Or"},
  CommonID_PT_Desc = {
    Text = "Portugais (GPT beta)"
  },
  CommonID_PVP_Desc = {
    Text = "Échecs de Phase"
  },
  CommonID_PassiveSkill_Desc = {
    Text = "Compétence passive"
  },
  CommonID_PersonalProfile_Desc = {Text = "Profil"},
  CommonID_PlayerEnter_Desc = {
    Text = "Début du jeu, après que les joueurs aient choisi leurs cartes"
  },
  CommonID_PlayerFiles_Desc = {
    Text = "Dossier du Gardien"
  },
  CommonID_Potency_Desc = {
    Text = "Dégagement"
  },
  CommonID_Privacy_Desc = {
    Text = "Confidentialité"
  },
  CommonID_Purple_Desc = {
    Text = "Pendule chronique"
  },
  CommonID_RU_Desc = {
    Text = "Russe (GPT beta)"
  },
  CommonID_RedGlow_Desc = {
    Text = "Effet de lumière rouge"
  },
  CommonID_Red_Desc = {
    Text = "malédiction"
  },
  CommonID_Redeem_Desc = {
    Text = "Va à l'Échange"
  },
  CommonID_ReletedAwakerInEnemies_Desc = {
    Text = "Dialogue entre l'éveillé adverse et les éveillés de notre équipe"
  },
  CommonID_Relic_Desc = {Text = "Relique"},
  CommonID_Repair_Desc = {
    Text = "Procédez à la Réparation"
  },
  CommonID_ResNeedReduce_Desc = {
    Text = "Exigences en Ressources réduites"
  },
  CommonID_SUP_Desc = {Text = "Chœur"},
  CommonID_SellCard_Desc = {
    Text = "Vendre des cartes"
  },
  CommonID_ShortcutKey_Desc = {
    Text = "Touche de raccourci"
  },
  CommonID_SilverAchieve_Desc = {Text = "Argent"},
  CommonID_Sin_Desc = {
    Text = "Péché Originel"
  },
  CommonID_SkillReady_Desc = {
    Text = "Moment où la jauge de folie est pleine et peut être activée par un clic pour déclencher une exaltation"
  },
  CommonID_Skill_LevelUp_Desc = {
    Text = "Améliorer la Compétence"
  },
  CommonID_Slider_Desc = {
    Text = "Curseur de Valeur"
  },
  CommonID_SlotCardLevel_Desc = {
    Text = "Niveau de Fente Original"
  },
  CommonID_SoundBalance_Desc = {
    Text = "Équilibre Sonore"
  },
  CommonID_SpecificCommunicateTrig_Desc = {
    Text = "Condition de complétion de la mission : Déclencher le dialogue du communicateur désigné."
  },
  CommonID_StageDropAdd_Desc = {
    Text = "Augmentation de la production de donjons"
  },
  CommonID_Switch_Desc = {Text = "Changer"},
  CommonID_System_Desc = {Text = "Système"},
  CommonID_TH_Desc = {
    Text = "Thaï (GPT beta)"
  },
  CommonID_TRUE_Desc = {Text = "Oui"},
  CommonID_TR_Desc = {
    Text = "Turc (alpha)"
  },
  CommonID_TW_Desc = {
    Text = "Chinois traditionnel"
  },
  CommonID_T_Desc = {Text = "Guardien"},
  CommonID_TaskCount_Desc = {Text = "Comte"},
  CommonID_TaskInProgress_Desc = {Text = "En cours"},
  CommonID_TaweiMonster_Desc = {
    Text = "Tawil la Sombre"
  },
  CommonID_Through1_Desc = {
    Text = "Compétence passive 1"
  },
  CommonID_Through2_Desc = {
    Text = "Compétence passive 2"
  },
  CommonID_Tips_Desc = {
    Text = "Avertissement"
  },
  CommonID_TranslationLabel_Desc = {
    Text = "Marqueur de progression de la traduction"
  },
  CommonID_Ulti_Skill_Desc = {Text = "Exaltation"},
  CommonID_UtlSkill_Promote_Desc = {
    Text = "Surexaltation"
  },
  CommonID_VN_Desc = {
    Text = "Vietnamien (GPT beta)"
  },
  CommonID_VeryHigh_Desc = {
    Text = "Extrêmement élevé"
  },
  CommonID_VeryLow_Desc = {
    Text = "Extrêmement bas"
  },
  CommonID_View_Desc = {Text = "Va voir"},
  CommonID_Voice_Desc = {Text = "Son"},
  CommonID_Web_Desc = {
    Text = "Redirection de page"
  },
  CommonID_White_Desc = {Text = "Argent"},
  CommonID_WindowNotFocusVoice_Desc = {
    Text = "Effet sonore de fenêtre non focalisée"
  },
  CommonID_Window_Desc = {Text = "Fenêtre"},
  CommonID_YellowGlow_Desc = {
    Text = "Effet de lumière jaune"
  }
})
return Text_CommonID
