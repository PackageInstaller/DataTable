__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_CommonID = readonly({
  CommonID_Account_Desc = {Text = "Account"},
  CommonID_AchieveCommemorativeData_Dmg_Desc = {Text = "Max Damage"},
  CommonID_AchieveCommemorativeData_Poison_Desc = {Text = "Max Floors"},
  CommonID_AchieveCommemorativeData_Time_Desc = {
    Text = "Completion Time"
  },
  CommonID_AchieveType0_Desc = {
    Text = "All Achievements"
  },
  CommonID_AchieveType1_Desc = {
    Text = "Growth Story"
  },
  CommonID_AchieveType2_Desc = {
    Text = "Investigation Mark"
  },
  CommonID_AchieveType3_Desc = {
    Text = "Combat Record"
  },
  CommonID_AchieveType4_Desc = {
    Text = "Achievements"
  },
  CommonID_Add_State_Desc = {Text = "Add State"},
  CommonID_All_Desc = {Text = "All"},
  CommonID_AnyAvgFirstTrigger_Desc = {
    Text = "Mission Complete Condition: Trigger Any Story"
  },
  CommonID_AnyEntryInGroupUnlock_Desc = {
    Text = "Mission Complete Condition: Unlock Any Entry"
  },
  CommonID_AnyEventFirstTrigger_Desc = {
    Text = "Mission Complete Condition: Trigger Any Event"
  },
  CommonID_AnyItemFirstGet_Desc = {
    Text = "Mission Complete Condition: Obtain Any Item"
  },
  CommonID_AnyNodeTypeFirstTrigger_Desc = {
    Text = "Mission Complete Condition: Trigger Any Node"
  },
  CommonID_AnyRelicFirstGet_Desc = {
    Text = "Mission Complete Condition: Obtain Any Relic"
  },
  CommonID_AnyStageFirstClear_Desc = {
    Text = "Mission Complete Condition: Clear Any Level"
  },
  CommonID_AppointTaskRewardAdd_Desc = {
    Text = "Assign to Increase Rewards"
  },
  CommonID_Attr_Promote_Desc = {
    Text = "Attribute Enhancement"
  },
  CommonID_AwakerDied_Desc = {
    Text = "Awakener Death"
  },
  CommonID_AwakerMonster_Desc = {
    Text = "Awakener Boss"
  },
  CommonID_BanBattlePos_Desc = {
    Text = "Cannot Be Deployed"
  },
  CommonID_Battle_Desc = {Text = "Battle"},
  CommonID_Blue_Desc = {Text = "Blue"},
  CommonID_Boss_Desc = {Text = "Boss"},
  CommonID_BundleShortcutKey_Desc = {
    Text = "Key Binding"
  },
  CommonID_CN_Desc = {
    Text = "Simplified Chinese"
  },
  CommonID_CardSlots_LevelUp_Desc = {
    Text = "Upgrade Slot"
  },
  CommonID_Card_AdvancedImagery_Desc = {
    Text = "Advanced Imagery"
  },
  CommonID_Card_AttachPost_Desc = {Text = "Pursuit"},
  CommonID_Card_Awake_Desc = {Text = "Rouse"},
  CommonID_Card_Curse_Desc = {Text = "Symptom"},
  CommonID_Card_Defend_Desc = {
    Text = "Defense Card"
  },
  CommonID_Card_Developing_Desc = {
    Text = "Under Development"
  },
  CommonID_Card_Extend_Desc = {
    Text = "Derived Card"
  },
  CommonID_Card_Imagery_Desc = {Text = "Imagery"},
  CommonID_Card_KeeperSkill_Desc = {Text = "Posse Card"},
  CommonID_Card_Potion_Desc = {
    Text = "Potion Card"
  },
  CommonID_Card_Skill_Desc = {Text = "Skill Card"},
  CommonID_Card_State_Desc = {Text = "State Card"},
  CommonID_Card_Strike_Desc = {
    Text = "Strike Card"
  },
  CommonID_Card_Weapon_Desc = {
    Text = "Wheel of Destiny"
  },
  CommonID_CastSkillLevel_Desc = {
    Text = "Skill Casting Level"
  },
  CommonID_Challenge_Desc = {
    Text = "Investigation"
  },
  CommonID_Change_Skill_Desc = {
    Text = "Replace Skill"
  },
  CommonID_Chinese_Desc = {Text = "Chinese"},
  CommonID_ChooseHandCard_Desc = {
    Text = "Choose a Card"
  },
  CommonID_ClickToQuit_Desc = {
    Text = "Click to Exit"
  },
  CommonID_ClickToView_Desc = {
    Text = "Click to View"
  },
  CommonID_Click_Desc = {
    Text = "Click to Jump"
  },
  CommonID_Close_Desc = {Text = "Off"},
  CommonID_ComingSoon_Desc = {
    Text = "Stay Tuned..."
  },
  CommonID_CommonAttr_Desc = {
    Text = "General Stat Bonus"
  },
  CommonID_Common_Desc = {Text = "Normal"},
  CommonID_ContinuousSound_Desc = {Text = "Play"},
  CommonID_CopperAchieve_Desc = {Text = "Copper"},
  CommonID_CountingStart_Desc = {
    Text = "Countdown begins on our turn"
  },
  CommonID_Custom_Desc = {Text = "Custom"},
  CommonID_DE_Desc = {
    Text = "German (alpha)"
  },
  CommonID_DPS_Desc = {Text = "Assault"},
  CommonID_DepressionHit_Desc = {
    Text = "Depression on Hit"
  },
  CommonID_DisableKeeperSkill_Desc = {
    Text = "Disable Protagonist Skills"
  },
  CommonID_DisableTrinketSuitEffect_Desc = {
    Text = "Disable Covenants"
  },
  CommonID_DisableWeapon_Desc = {
    Text = "Disable WoDs"
  },
  CommonID_Display_Desc = {Text = "Visual"},
  CommonID_DropdownList_Desc = {
    Text = "Dropdown List"
  },
  CommonID_EN_Desc = {Text = "English"},
  CommonID_ES_Desc = {
    Text = "Spanish (alpha)"
  },
  CommonID_Elite_Desc = {Text = "Elite"},
  CommonID_EmojiType_10_Desc = {
    Text = "Little Mythag"
  },
  CommonID_EmojiType_11_Desc = {Text = "My Turn"},
  CommonID_EmojiType_12_Desc = {
    Text = "Mythag Daily"
  },
  CommonID_EmojiType_13_Desc = {
    Text = "Happy Mythag"
  },
  CommonID_EmojiType_14_Desc = {
    Text = "Unhappy Mythag"
  },
  CommonID_EmojiType_15_Desc = {
    Text = "School Life"
  },
  CommonID_EmojiType_16_Desc = {
    Text = "Peaceful Day"
  },
  CommonID_EmojiType_17_Desc = {
    Text = "After School"
  },
  CommonID_EmojiType_18_Desc = {
    Text = "Love U Mythag"
  },
  CommonID_EmojiType_19_Desc = {
    Text = "Mythag Holiday"
  },
  CommonID_EmojiType_1_Desc = {
    Text = "Chubby Mythag"
  },
  CommonID_EmojiType_20_Desc = {
    Text = "Xmas Mythag"
  },
  CommonID_EmojiType_21_Desc = {
    Text = "Gingerbread Party"
  },
  CommonID_EmojiType_22_Desc = {
    Text = "Campus Anecdotes"
  },
  CommonID_EmojiType_23_Desc = {
    Text = "Mythag Investigator"
  },
  CommonID_EmojiType_24_Desc = {
    Text = "Mythag Interlude"
  },
  CommonID_EmojiType_2_Desc = {Text = "Mori Mori"},
  CommonID_EmojiType_3_Desc = {
    Text = "Worldly Wonders"
  },
  CommonID_EmojiType_4_Desc = {
    Text = "Mori-Chibis"
  },
  CommonID_EmojiType_5_Desc = {
    Text = "Traphase Comm"
  },
  CommonID_EmojiType_6_Desc = {
    Text = "Shining Mythag"
  },
  CommonID_EmojiType_7_Desc = {
    Text = "Crazy Mythag"
  },
  CommonID_EmojiType_8_Desc = {
    Text = "Easy Mythag"
  },
  CommonID_EmojiType_9_Desc = {
    Text = "Wisdom Mythag"
  },
  CommonID_Enchant_Desc = {Text = "Engrave"},
  CommonID_English_Desc = {Text = "English"},
  CommonID_Entrance_Desc = {
    Text = "Popup Entry"
  },
  CommonID_FALSE_Desc = {Text = "No"},
  CommonID_FR_Desc = {
    Text = "French (alpha)"
  },
  CommonID_Forged_Desc = {Text = "Enhance"},
  CommonID_FreeBattlePos_Desc = {
    Text = "Free Deployment"
  },
  CommonID_FullScreen_Desc = {Text = "Fullscreen"},
  CommonID_Gender_Boy_Desc = {Text = "Male"},
  CommonID_Gender_Girl_Desc = {Text = "Female"},
  CommonID_GetLikeLevel_Desc = {Text = "Function"},
  CommonID_GmaeVoice_Desc = {Text = "Game Audio"},
  CommonID_GoldAchieve_Desc = {Text = "Gold"},
  CommonID_Hall_Desc = {Text = "Lobby"},
  CommonID_HarvestAdd_Desc = {
    Text = "Increased Home Rewards"
  },
  CommonID_HaveAwaker_Desc = {
    Text = "Mission Complete Condition: Own Any Awakener"
  },
  CommonID_HeadType_1_Desc = {
    Text = "By the Silver Key"
  },
  CommonID_HeadType_2_Desc = {
    Text = "Chibi Mug Shot"
  },
  CommonID_HeadType_3_Desc = {
    Text = "Unfading Yesterday"
  },
  CommonID_HeadType_4_Desc = {
    Text = "Collector's Stamp"
  },
  CommonID_High_Desc = {Text = "High"},
  CommonID_Holy_Desc = {
    Text = "Sanctification"
  },
  CommonID_ID_Desc = {
    Text = "Indonesian (alpha)"
  },
  CommonID_Image_Desc = {Text = "Image"},
  CommonID_Intent_AttackBuff_Desc = {
    Text = "Monster Intent: Attack & Enhance"
  },
  CommonID_Intent_AttackDebuffD09Skill2_Desc = {
    Text = "Monster intends to attack and weaken."
  },
  CommonID_Intent_AttackDebuff_Desc = {
    Text = "Monster Intent: Attack & Weaken"
  },
  CommonID_Intent_AttackDefence_Desc = {
    Text = "Monster Intent: Attack & Defend"
  },
  CommonID_Intent_Attack_Desc = {
    Text = "Monster Intent: Attack"
  },
  CommonID_Intent_Buff_Desc = {
    Text = "Monster Intent: Enhance"
  },
  CommonID_Intent_Burst2_Desc = {
    Text = "Monster Intent: Aliemus (Non-Attack)"
  },
  CommonID_Intent_Burst3_Desc = {
    Text = "Monster Intent: Super Aliemus"
  },
  CommonID_Intent_Burst4_Desc = {
    Text = "Monster Intent: Unleash End"
  },
  CommonID_Intent_Burst_Desc = {
    Text = "Monster Intent: Aliemus"
  },
  CommonID_Intent_DCB022Buff_Desc = {
    Text = "Monster Intention: Strengthen"
  },
  CommonID_Intent_DCB024Buff_Desc = {
    Text = "Monster Intention: Strengthen"
  },
  CommonID_Intent_Debuff_Desc = {
    Text = "Monster Intent: Weaken"
  },
  CommonID_Intent_DefenceBuff_Desc = {
    Text = "Monster Intent: Defend & Enhance"
  },
  CommonID_Intent_DefenceDebuff_Desc = {
    Text = "Monster Intent: Defend & Weaken"
  },
  CommonID_Intent_Defence_Desc = {
    Text = "Monster Intent: Defend"
  },
  CommonID_Intent_Dizzy_Desc = {
    Text = "Monster Intent: Stun"
  },
  CommonID_Intent_HeavyAttackDCB02_Desc = {
    Text = "Monster Intention: Heavy Attack"
  },
  CommonID_Intent_HeavyAttack_Desc = {
    Text = "Monster Intent: Heavy Attack"
  },
  CommonID_Intent_StrongBuff_Desc = {
    Text = "Monster Intent: Major Enhance"
  },
  CommonID_Intent_StrongDebuff_Desc = {
    Text = "Monster Intent: Major Weaken"
  },
  CommonID_Intent_Unknown1_Desc = {
    Text = "The monster's intentions are unclear."
  },
  CommonID_Intent_Unknown2_Desc = {
    Text = "The monster's intentions are unclear."
  },
  CommonID_Intent_Unknown3_Desc = {
    Text = "The monster's intentions are unclear."
  },
  CommonID_Intent_Unknown4_Desc = {
    Text = "The monster's intentions are unclear."
  },
  CommonID_Intent_Unknown5_Desc = {
    Text = "The monster's intentions are unclear."
  },
  CommonID_Intent_Unknown6_Desc = {
    Text = "The monster's intentions are unclear."
  },
  CommonID_Intent_Unknown_Desc = {
    Text = "Monster Intent: Unknown"
  },
  CommonID_ItemManagement_Desc = {Text = "Item"},
  CommonID_JP_Desc = {
    Text = "Japanese (alpha)"
  },
  CommonID_Japanese_Desc = {Text = "Japanese"},
  CommonID_KR_Desc = {
    Text = "Korean (alpha)"
  },
  CommonID_Keeper_Skill_Desc = {
    Text = "Keeper Skill"
  },
  CommonID_KeyType_1_Desc = {
    Text = "Faded Legacy"
  },
  CommonID_KeyType_2_Desc = {Text = "Chaos"},
  CommonID_KeyType_3_Desc = {Text = "Aequor"},
  CommonID_KeyType_4_Desc = {Text = "Caro"},
  CommonID_KeyType_5_Desc = {Text = "Ultra"},
  CommonID_Key_Desc = {Text = "Button"},
  CommonID_Language_Desc = {Text = "Language"},
  CommonID_LevelLimit_Promote_Desc = {
    Text = "Level Cap Increase"
  },
  CommonID_Low_Desc = {Text = "Low"},
  CommonID_Management_Desc = {Text = "Configure"},
  CommonID_ManiaHit_Desc = {
    Text = "Mania on Hit"
  },
  CommonID_MasterVolume_Desc = {
    Text = "Overall Control"
  },
  CommonID_MaterialsReturn_Desc = {
    Text = "Refund Consumed Resources"
  },
  CommonID_MessagePush_Desc = {
    Text = "Notification Push"
  },
  CommonID_Middle_Desc = {Text = "Medium"},
  CommonID_MonsterGrade1_Desc = {
    Text = "Tier 1 Minion"
  },
  CommonID_MonsterGrade2_Desc = {
    Text = "Tier 2 Minion"
  },
  CommonID_MotherTreeMonster_Desc = {
    Text = "\"The Mother Tree\""
  },
  CommonID_MultiplierXP_Desc = {
    Text = "Multiple EXP Boost"
  },
  CommonID_Mute_Desc = {Text = "Mute"},
  CommonID_NotAwakerMonster_Desc = {
    Text = "Non-Awakened Boss"
  },
  CommonID_Open_Desc = {Text = "On"},
  CommonID_OperationImpossible_Desc = {
    Text = "Player fails to perform actions (play cards, Exalt) due to various reasons (insufficient Arithmetica, non-player turn, being Sealed, Petrified, etc.)"
  },
  CommonID_OperationStop_Desc = {
    Text = "Our turn's accumulated thinking time reaches the maximum value (configured in the constant table)"
  },
  CommonID_Orange_Desc = {Text = "Gold"},
  CommonID_PT_Desc = {
    Text = "Portuguese (alpha)"
  },
  CommonID_PVP_Desc = {Text = "Traphase"},
  CommonID_PassiveSkill_Desc = {
    Text = "Passive Skill"
  },
  CommonID_PersonalProfile_Desc = {Text = "Profile"},
  CommonID_PlayerEnter_Desc = {
    Text = "Game Start, after the player selects their cards"
  },
  CommonID_PlayerFiles_Desc = {
    Text = "Keeper Profile"
  },
  CommonID_Potency_Desc = {Text = "Enlighten"},
  CommonID_Privacy_Desc = {Text = "Privacy"},
  CommonID_Purple_Desc = {
    Text = "Chrono Pendulum"
  },
  CommonID_RU_Desc = {
    Text = "Russian (alpha)"
  },
  CommonID_RedGlow_Desc = {
    Text = "Red Light Effect"
  },
  CommonID_Red_Desc = {Text = "Curse"},
  CommonID_Redeem_Desc = {
    Text = "Go to Redeem"
  },
  CommonID_ReletedAwakerInEnemies_Desc = {
    Text = "Dialogue between enemy Awakener and allied Awakener"
  },
  CommonID_Relic_Desc = {Text = "Relic"},
  CommonID_Repair_Desc = {
    Text = "Go to Repair"
  },
  CommonID_ResNeedReduce_Desc = {
    Text = "Resource Cost Reduced"
  },
  CommonID_SUP_Desc = {Text = "Chorus"},
  CommonID_SellCard_Desc = {Text = "Sell Cards"},
  CommonID_ShortcutKey_Desc = {Text = "Hotkey"},
  CommonID_SilverAchieve_Desc = {Text = "Silver"},
  CommonID_Sin_Desc = {
    Text = "Original Sin"
  },
  CommonID_SkillReady_Desc = {
    Text = "The moment the Aliemus gauge is full and can be clicked to unleash Exalt"
  },
  CommonID_Skill_LevelUp_Desc = {
    Text = "Upgrade Skill"
  },
  CommonID_Slider_Desc = {
    Text = "Value Slider"
  },
  CommonID_SlotCardLevel_Desc = {
    Text = "Default Slot Level"
  },
  CommonID_SoundBalance_Desc = {
    Text = "Sound Balance"
  },
  CommonID_SpecificCommunicateTrig_Desc = {
    Text = "Mission Complete Condition: Trigger Designated Dialog"
  },
  CommonID_StageDropAdd_Desc = {
    Text = "Increased Dungeon Output"
  },
  CommonID_Switch_Desc = {Text = "Switch"},
  CommonID_System_Desc = {Text = "System"},
  CommonID_TH_Desc = {
    Text = "Thai (alpha)"
  },
  CommonID_TRUE_Desc = {Text = "Yes"},
  CommonID_TW_Desc = {
    Text = "Traditional Chinese"
  },
  CommonID_T_Desc = {Text = "Warden"},
  CommonID_TaskCount_Desc = {Text = "Count"},
  CommonID_TaskInProgress_Desc = {
    Text = "In Progress"
  },
  CommonID_TaweiMonster_Desc = {
    Text = "Tawil the Dark"
  },
  CommonID_Through1_Desc = {
    Text = "Passive Skill 1"
  },
  CommonID_Through2_Desc = {
    Text = "Passive Skill 2"
  },
  CommonID_Tips_Desc = {
    Text = "Investigation in Progress"
  },
  CommonID_Ulti_Skill_Desc = {Text = "Exalt"},
  CommonID_UtlSkill_Promote_Desc = {Text = "Over-Exalt"},
  CommonID_VN_Desc = {
    Text = "Vietnamese (alpha)"
  },
  CommonID_VeryHigh_Desc = {
    Text = "Extremely High"
  },
  CommonID_VeryLow_Desc = {
    Text = "Extremely Low"
  },
  CommonID_View_Desc = {
    Text = "Click to View"
  },
  CommonID_Voice_Desc = {Text = "Sound"},
  CommonID_Web_Desc = {
    Text = "Page Redirect"
  },
  CommonID_White_Desc = {Text = "Silver"},
  CommonID_WindowNotFocusVoice_Desc = {
    Text = "Window Unfocused Sound Effect"
  },
  CommonID_Window_Desc = {Text = "Window"},
  CommonID_YellowGlow_Desc = {
    Text = "Yellow Light Effect"
  }
})
return Text_CommonID
