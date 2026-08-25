__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_CommonID = readonly({
  CommonID_Account_Desc = {Text = "Konto"},
  CommonID_AchieveCommemorativeData_Dmg_Desc = {
    Text = "Maximaler Schaden"
  },
  CommonID_AchieveCommemorativeData_Poison_Desc = {
    Text = "Maximale Etagen"
  },
  CommonID_AchieveCommemorativeData_Time_Desc = {
    Text = "Abschlusszeit"
  },
  CommonID_AchieveType0_Desc = {
    Text = "Alle Errungenschaften"
  },
  CommonID_AchieveType1_Desc = {
    Text = "Wachstumsgeschichte"
  },
  CommonID_AchieveType2_Desc = {
    Text = "Untersuchungsmarke"
  },
  CommonID_AchieveType3_Desc = {
    Text = "Kampfaufzeichnung"
  },
  CommonID_AchieveType4_Desc = {
    Text = "Das Leben des Geheimniswächters"
  },
  CommonID_Add_State_Desc = {
    Text = "Füge Zustand hinzu"
  },
  CommonID_All_Desc = {Text = "Alle"},
  CommonID_AnyAvgFirstTrigger_Desc = {
    Text = "Mission Abschlussbedingung: Triggern Sie einen beliebigen Geschichts-Knoten"
  },
  CommonID_AnyEntryInGroupUnlock_Desc = {
    Text = "Kriterien für den Abschluss der Mission: Jeden Eintrag im Gruppenkompendium freischalten"
  },
  CommonID_AnyEventFirstTrigger_Desc = {
    Text = "Kriterien zum Abschluss der Quest: Jedes [Ereignis] auslöse"
  },
  CommonID_AnyItemFirstGet_Desc = {
    Text = "Quest-Bedingung für den Abschluss: Erhalte einen beliebigen Gegenstand"
  },
  CommonID_AnyNodeTypeFirstTrigger_Desc = {
    Text = "Bedingung für den Abschluss der Mission: Irgendein Knotentyp auslösen"
  },
  CommonID_AnyRelicFirstGet_Desc = {
    Text = "Aufgabenerfüllungsbedingung: Erhalte irgendein Relikt"
  },
  CommonID_AnyStageFirstClear_Desc = {
    Text = "Mission Abschlusskriterien: Räumen Sie eine beliebige Etappe in der Liste zum ersten Mal ab"
  },
  CommonID_AppointTaskRewardAdd_Desc = {
    Text = "Zu weisen, um Belohnungen zu erhöhen"
  },
  CommonID_Attr_Promote_Desc = {
    Text = "Eigenschaftssteigerung"
  },
  CommonID_AwakerDied_Desc = {
    Text = "Erwachter Tod"
  },
  CommonID_AwakerMonster_Desc = {
    Text = "Erwecker Führer"
  },
  CommonID_BN_Desc = {
    Text = "Bengalisch (Alpha)"
  },
  CommonID_BanBattlePos_Desc = {
    Text = "Kann nicht eingesetzt werden"
  },
  CommonID_Battle_Desc = {Text = "Kampf"},
  CommonID_Blue_Desc = {Text = "Blau"},
  CommonID_Boss_Desc = {Text = "Anführer"},
  CommonID_BundleShortcutKey_Desc = {
    Text = "Schlüssel binden"
  },
  CommonID_CN_Desc = {
    Text = "Vereinfachtes Chinesisch"
  },
  CommonID_CardBorder_Desc = {
    Text = "Karten-Kosmetik"
  },
  CommonID_CardSlots_LevelUp_Desc = {
    Text = "Upgrade-Slot"
  },
  CommonID_Card_AdvancedImagery_Desc = {
    Text = "Hochrangige Vorstellung"
  },
  CommonID_Card_AttachPost_Desc = {Text = "Verfolgung"},
  CommonID_Card_Awake_Desc = {Text = "Erwecken"},
  CommonID_Card_Curse_Desc = {
    Text = "Symptom-Karte"
  },
  CommonID_Card_Defend_Desc = {
    Text = "Verteidigungskarte"
  },
  CommonID_Card_Developing_Desc = {
    Text = "In Entwicklung"
  },
  CommonID_Card_Extend_Desc = {
    Text = "Abgeleitete Karte"
  },
  CommonID_Card_Fraud_Desc = {Text = "Betrug"},
  CommonID_Card_Imagery_Desc = {
    Text = "Imagination"
  },
  CommonID_Card_KeeperSkill_Desc = {
    Text = "Posse Karte"
  },
  CommonID_Card_Potion_Desc = {Text = "Trankkarte"},
  CommonID_Card_Skill_Desc = {
    Text = "Fähigkeitskarte"
  },
  CommonID_Card_State_Desc = {
    Text = "Zustandskarte"
  },
  CommonID_Card_Strike_Desc = {
    Text = "Schlagkarte"
  },
  CommonID_Card_Weapon_Desc = {
    Text = "Rad des Schicksals Karte"
  },
  CommonID_CastSkillLevel_Desc = {
    Text = "Fähigkeit Casting Level"
  },
  CommonID_Challenge_Desc = {Text = "Ermittlung"},
  CommonID_Change_Skill_Desc = {
    Text = "Fähigkeit ersetzen"
  },
  CommonID_Chinese_Desc = {Text = "Chinesisch"},
  CommonID_ChooseHandCard_Desc = {
    Text = "Wählen Sie eine Handkarte aus"
  },
  CommonID_ClickToQuit_Desc = {
    Text = "Klicke, um zu beende"
  },
  CommonID_ClickToView_Desc = {
    Text = "Klicke, um anzuzeige"
  },
  CommonID_Click_Desc = {
    Text = "Klicken Sie, um zu springen"
  },
  CommonID_Close_Desc = {Text = "Schließen"},
  CommonID_ComingSoon_Desc = {Text = "Demnächst"},
  CommonID_CommonAttr_Desc = {
    Text = "Allgemeine Attributsteigerung"
  },
  CommonID_Common_Desc = {Text = "Normal"},
  CommonID_ContinuousSound_Desc = {
    Text = "Fortlaufende Wiedergabe"
  },
  CommonID_CopperAchieve_Desc = {Text = "Kupfer"},
  CommonID_CountingStart_Desc = {
    Text = "Unsere Runde - Countdown gestartet"
  },
  CommonID_Custom_Desc = {
    Text = "Benutzerdefiniert"
  },
  CommonID_DE_Desc = {
    Text = "Deutsch (GPT beta)"
  },
  CommonID_DPS_Desc = {Text = "ANG"},
  CommonID_DepressionHit_Desc = {
    Text = "Treffer-induzierte Depression"
  },
  CommonID_DisableKeeperSkill_Desc = {
    Text = "Protagonistenfähigkeiten deaktivieren"
  },
  CommonID_DisableTrinketSuitEffect_Desc = {
    Text = "Deaktiviere Bündnis"
  },
  CommonID_DisableWeapon_Desc = {
    Text = "Schicksrad deaktivieren"
  },
  CommonID_Display_Desc = {Text = "Visuell"},
  CommonID_DropdownList_Desc = {
    Text = "Dropdown-Liste"
  },
  CommonID_EN_Desc = {
    Text = "Englisch (GPT beta)"
  },
  CommonID_ES_Desc = {
    Text = "Spanisch (GPT beta)"
  },
  CommonID_Elite_Desc = {Text = "Elite"},
  CommonID_EmojiType_10_Desc = {
    Text = "Kleiner Mythag"
  },
  CommonID_EmojiType_11_Desc = {
    Text = "Ich bin dran"
  },
  CommonID_EmojiType_12_Desc = {
    Text = "Mythag täglich"
  },
  CommonID_EmojiType_13_Desc = {
    Text = "Glücklicher Mythag"
  },
  CommonID_EmojiType_14_Desc = {
    Text = "Unglücklicher Mythos"
  },
  CommonID_EmojiType_15_Desc = {Text = "Schulleben"},
  CommonID_EmojiType_16_Desc = {
    Text = "Friedlicher Tag"
  },
  CommonID_EmojiType_17_Desc = {
    Text = "Nach der Schule"
  },
  CommonID_EmojiType_18_Desc = {Text = "Misaq"},
  CommonID_EmojiType_19_Desc = {
    Text = "Misaq Ferien"
  },
  CommonID_EmojiType_1_Desc = {
    Text = "Dicker Mythag"
  },
  CommonID_EmojiType_20_Desc = {
    Text = "Winterüberfahrt Misaq"
  },
  CommonID_EmojiType_21_Desc = {
    Text = "Lebkuchenparty"
  },
  CommonID_EmojiType_22_Desc = {
    Text = "Campus-Fakten"
  },
  CommonID_EmojiType_23_Desc = {
    Text = "Mythag-Ermittler"
  },
  CommonID_EmojiType_24_Desc = {
    Text = "Misaq Zwischenakt"
  },
  CommonID_EmojiType_25_Desc = {
    Text = "Lied von Shaye"
  },
  CommonID_EmojiType_2_Desc = {Text = "Mori Mori"},
  CommonID_EmojiType_3_Desc = {
    Text = "Weltliche Wunder"
  },
  CommonID_EmojiType_4_Desc = {
    Text = "Mori-Chibis"
  },
  CommonID_EmojiType_5_Desc = {
    Text = "Traphase-Kommunikation"
  },
  CommonID_EmojiType_6_Desc = {
    Text = "Leuchtender Mythos"
  },
  CommonID_EmojiType_7_Desc = {
    Text = "Verrückter Mythag"
  },
  CommonID_EmojiType_8_Desc = {
    Text = "Einfache Mythag"
  },
  CommonID_EmojiType_9_Desc = {
    Text = "Weisheitsmythos"
  },
  CommonID_Enchant_Desc = {Text = "Gebet"},
  CommonID_Entrance_Desc = {
    Text = "Popup-Eintrag"
  },
  CommonID_FALSE_Desc = {Text = "Nein"},
  CommonID_FR_Desc = {
    Text = "Französisch (GPT beta)"
  },
  CommonID_Forged_Desc = {
    Text = "Verstärkung"
  },
  CommonID_FreeBattlePos_Desc = {
    Text = "Freie Bereitstellung"
  },
  CommonID_FullScreen_Desc = {Text = "Vollbild"},
  CommonID_Gender_Boy_Desc = {Text = "Männlich"},
  CommonID_Gender_Girl_Desc = {Text = "Frau"},
  CommonID_GetLikeLevel_Desc = {Text = "Funktion"},
  CommonID_GmaeVoice_Desc = {Text = "Spielaudio"},
  CommonID_GoldAchieve_Desc = {Text = "Gold"},
  CommonID_Hall_Desc = {Text = "Lounge"},
  CommonID_HarvestAdd_Desc = {
    Text = "Erhöhte Zuhause-Belohnunge"
  },
  CommonID_HaveAwaker_Desc = {
    Text = "Bedingung für den Abschluss der Mission: Besitze einen beliebigen Erwacher aus der Liste"
  },
  CommonID_HeadType_1_Desc = {
    Text = "Im Namen des Silbernen Schlüssels"
  },
  CommonID_HeadType_2_Desc = {
    Text = "Dossierfoto"
  },
  CommonID_HeadType_3_Desc = {
    Text = "Unvergängliches Gestern"
  },
  CommonID_HeadType_4_Desc = {
    Text = "Sammlung von Briefmarken"
  },
  CommonID_High_Desc = {Text = "Hoch"},
  CommonID_Holy_Desc = {Text = "Heiligung"},
  CommonID_ID_Desc = {
    Text = "Indonesisch (GPT beta)"
  },
  CommonID_IT_Desc = {
    Text = "Italienisch (Alpha)"
  },
  CommonID_Image_Desc = {Text = "Bild"},
  CommonID_Intent_AttackBuff_Desc = {
    Text = "Monster beabsichtigt anzugreifen und zu stärken."
  },
  CommonID_Intent_AttackDebuffD09Skill2_Desc = {
    Text = "Monsterabsicht Angriff und Schwächung"
  },
  CommonID_Intent_AttackDebuff_Desc = {
    Text = "Monsterabsicht Angriff und Schwächung"
  },
  CommonID_Intent_AttackDefence_Desc = {
    Text = "Monsterabsichten: Angriff und Verteidigung"
  },
  CommonID_Intent_Attack_Desc = {
    Text = "Monster beabsichtigt anzugreifen"
  },
  CommonID_Intent_Buff_Desc = {
    Text = "Das Monster beabsichtigt zu verstärken"
  },
  CommonID_Intent_Burst2_Desc = {
    Text = "Monsterabsichten: Aliemus (Nicht-Angriff)"
  },
  CommonID_Intent_Burst3_Desc = {
    Text = "Monsterabsicht: Super Aliemus"
  },
  CommonID_Intent_Burst4_Desc = {
    Text = "Das Monster beabsichtigt, das Ende zu entfesseln."
  },
  CommonID_Intent_Burst_Desc = {
    Text = "Monsterabsicht: Aliemus"
  },
  CommonID_Intent_DCB022Buff_Desc = {
    Text = "Das Monster beabsichtigt zu verstärken"
  },
  CommonID_Intent_DCB024Buff_Desc = {
    Text = "Das Monster beabsichtigt zu verstärken"
  },
  CommonID_Intent_Debuff_Desc = {
    Text = "Monster beabsichtigt zu schwächen"
  },
  CommonID_Intent_DefenceBuff_Desc = {
    Text = "Monster beabsichtigt zu verteidigen und zu stärken."
  },
  CommonID_Intent_DefenceDebuff_Desc = {
    Text = "Monsterabsichten: Verteidigung und Schwächen"
  },
  CommonID_Intent_Defence_Desc = {
    Text = "Monsterabsicht: Verteidigung"
  },
  CommonID_Intent_Dizzy_Desc = {
    Text = "Monsterabsicht: Betäuben"
  },
  CommonID_Intent_HeavyAttackDCB02_Desc = {
    Text = "Monsterabsicht schwerer Angriff"
  },
  CommonID_Intent_HeavyAttack_Desc = {
    Text = "Monsterabsicht schwerer Angriff"
  },
  CommonID_Intent_StrongBuff_Desc = {
    Text = "Monster beabsichtigt, signifikante Verstärkung zu erfahren"
  },
  CommonID_Intent_StrongDebuff_Desc = {
    Text = "Monster hat die Absicht, erheblich zu schwächen"
  },
  CommonID_Intent_Unknown1_Desc = {
    Text = "Monsterabsicht unklar"
  },
  CommonID_Intent_Unknown2_Desc = {
    Text = "Monsterabsicht unklar"
  },
  CommonID_Intent_Unknown3_Desc = {
    Text = "Monsterabsicht unklar"
  },
  CommonID_Intent_Unknown4_Desc = {
    Text = "Monsterabsicht unklar"
  },
  CommonID_Intent_Unknown5_Desc = {
    Text = "Monsterabsicht unklar"
  },
  CommonID_Intent_Unknown6_Desc = {
    Text = "Monsterabsicht unklar"
  },
  CommonID_Intent_Unknown_Desc = {
    Text = "Monsterabsicht unklar"
  },
  CommonID_ItemManagement_Desc = {Text = "Gegenstand"},
  CommonID_JP_Desc = {
    Text = "Japanisch (GPT beta)"
  },
  CommonID_KR_Desc = {
    Text = "Koreanisch (GPT beta)"
  },
  CommonID_Keeper_Skill_Desc = {
    Text = "Protagonistenfähigkeiten"
  },
  CommonID_KeyType_1_Desc = {
    Text = "Vergessenes Kapitel"
  },
  CommonID_KeyType_2_Desc = {Text = "Chaosreich"},
  CommonID_KeyType_3_Desc = {
    Text = "Aequor-Reich"
  },
  CommonID_KeyType_4_Desc = {
    Text = "Fleischreich"
  },
  CommonID_KeyType_5_Desc = {
    Text = "Ultra Reich"
  },
  CommonID_Key_Desc = {
    Text = "Schaltfläche"
  },
  CommonID_Language_Desc = {Text = "Sprache"},
  CommonID_LevelLimit_Promote_Desc = {
    Text = "Stufenobergrenze erhöht"
  },
  CommonID_Low_Desc = {Text = "Niedrig"},
  CommonID_Management_Desc = {
    Text = "Geh zur Verwaltung"
  },
  CommonID_ManiaHit_Desc = {
    Text = "Rasend bei Treffer"
  },
  CommonID_MasterVolume_Desc = {
    Text = "Gesamtsteuerung"
  },
  CommonID_MaterialsReturn_Desc = {
    Text = "Erstattete erschöpfte Ressource"
  },
  CommonID_MessagePush_Desc = {
    Text = "Benachrichtigungs-Push"
  },
  CommonID_Middle_Desc = {
    Text = "Vorgeschlagene Übersetzung"
  },
  CommonID_Modify_Desc = {
    Text = "Zum Ändern klicken"
  },
  CommonID_MonsterGrade1_Desc = {
    Text = "Ein Mob der Stufe 1"
  },
  CommonID_MonsterGrade2_Desc = {
    Text = "Stufe 2 Diener"
  },
  CommonID_MotherTreeMonster_Desc = {
    Text = "Der Mutterbaum"
  },
  CommonID_MultiplierXP_Desc = {
    Text = "Mehrfacher EXP Boost"
  },
  CommonID_Mute_Desc = {Text = "Stille"},
  CommonID_NotAwakerMonster_Desc = {
    Text = "Nicht-erwachter Anführer"
  },
  CommonID_Open_Desc = {Text = "Öffnen"},
  CommonID_OperationImpossible_Desc = {
    Text = "Der Spieler kann aus verschiedenen Gründen (unzureichende Rechenleistung, nicht eigene Spielrunde, versiegelt oder versteinert usw.) keine Aktion erfolgreich ausführen (Karte ausspielen, Wahnsinnseruption)"
  },
  CommonID_OperationStop_Desc = {
    Text = "Die kumulierte Denkdauer während unserer Runde hat den Maximalwert erreicht (in der Konstantentabelle konfiguriert)"
  },
  CommonID_Orange_Desc = {Text = "Gold"},
  CommonID_PT_Desc = {
    Text = "Portugiesisch (GPT beta)"
  },
  CommonID_PVP_Desc = {
    Text = "Phasenduell"
  },
  CommonID_PassiveSkill_Desc = {
    Text = "Passive Fähigkeit"
  },
  CommonID_PersonalProfile_Desc = {Text = "Profil"},
  CommonID_PlayerEnter_Desc = {
    Text = "Spielbeginn, nachdem die Spieler ihre Karten ausgewählt haben"
  },
  CommonID_PlayerFiles_Desc = {
    Text = "Schutzherr Archiv"
  },
  CommonID_Potency_Desc = {Text = "Erwachen"},
  CommonID_Privacy_Desc = {
    Text = "Privatsphäre"
  },
  CommonID_Purple_Desc = {
    Text = "Chrono-Pendel"
  },
  CommonID_RU_Desc = {
    Text = "Russisch (GPT beta)"
  },
  CommonID_RedGlow_Desc = {
    Text = "Rote Lichteffekt"
  },
  CommonID_Red_Desc = {Text = "Fluch"},
  CommonID_Redeem_Desc = {
    Text = "Geh zur Einlösung"
  },
  CommonID_ReletedAwakerInEnemies_Desc = {
    Text = "Gespräch zwischen Erweckten des feindlichen Lagers und unseren Erweckten"
  },
  CommonID_Relic_Desc = {Text = "Relikt"},
  CommonID_Repair_Desc = {
    Text = "Gehe zur Reparatur"
  },
  CommonID_ResNeedReduce_Desc = {
    Text = "Ressourcenanforderungen reduziert"
  },
  CommonID_SUP_Desc = {Text = "Chor"},
  CommonID_SellCard_Desc = {
    Text = "Karten verkaufen"
  },
  CommonID_ShortcutKey_Desc = {Text = "Hotkey"},
  CommonID_SilverAchieve_Desc = {Text = "Silber"},
  CommonID_Sin_Desc = {Text = "Ursünde"},
  CommonID_SkillReady_Desc = {
    Text = "Der Moment, in dem die Wahnsinn-Leiste voll ist und ein Wahnsinn-Ausbruch ausgelöst werden kann"
  },
  CommonID_Skill_LevelUp_Desc = {
    Text = "Upgrade Fähigkeit"
  },
  CommonID_Slider_Desc = {Text = "Wertregler"},
  CommonID_SlotCardLevel_Desc = {
    Text = "Ursprüngliches Slot-Niveau"
  },
  CommonID_SoundBalance_Desc = {Text = "Tonbalance"},
  CommonID_SpecificCommunicateTrig_Desc = {
    Text = "Bedingung für den Abschluss der Mission: Den vorgeschriebenen Kommunikationsdialog auslösen."
  },
  CommonID_StageDropAdd_Desc = {
    Text = "Erhöhte Dungeon-Ausbeute"
  },
  CommonID_Switch_Desc = {Text = "Wechseln"},
  CommonID_System_Desc = {Text = "System"},
  CommonID_TH_Desc = {
    Text = "Thai (GPT beta)"
  },
  CommonID_TRUE_Desc = {Text = "Ja"},
  CommonID_TR_Desc = {
    Text = "Türkisch (Alpha)"
  },
  CommonID_TW_Desc = {
    Text = "Traditionelles Chinesisch"
  },
  CommonID_T_Desc = {Text = "Wächter"},
  CommonID_TaskCount_Desc = {Text = "Zähle"},
  CommonID_TaskInProgress_Desc = {
    Text = "In Bearbeitung"
  },
  CommonID_TaweiMonster_Desc = {
    Text = "Tawil die Dunkle"
  },
  CommonID_Through1_Desc = {
    Text = "Passive Fähigkeit 1"
  },
  CommonID_Through2_Desc = {
    Text = "Passive Fähigkeit 2"
  },
  CommonID_Tips_Desc = {Text = "Hinweis"},
  CommonID_TranslationLabel_Desc = {
    Text = "Übersetzungsfortschrittsmarkierung"
  },
  CommonID_Ulti_Skill_Desc = {
    Text = "Verherrlichung"
  },
  CommonID_UtlSkill_Promote_Desc = {
    Text = "Über-Erhöhung"
  },
  CommonID_VN_Desc = {
    Text = "Vietnamesisch (GPT beta)"
  },
  CommonID_VeryHigh_Desc = {
    Text = "Extrem hoch"
  },
  CommonID_VeryLow_Desc = {
    Text = "Extrem niedrig"
  },
  CommonID_View_Desc = {
    Text = "Geh und schau es dir an"
  },
  CommonID_Voice_Desc = {Text = "Ton"},
  CommonID_Web_Desc = {
    Text = "Seitenweiterleitung"
  },
  CommonID_White_Desc = {Text = "Silber"},
  CommonID_WindowNotFocusVoice_Desc = {
    Text = "Fenster unscharfer Soundeffekt"
  },
  CommonID_Window_Desc = {Text = "Fenster"},
  CommonID_YellowGlow_Desc = {
    Text = "Gelbes Lichteffekt"
  }
})
return Text_CommonID
