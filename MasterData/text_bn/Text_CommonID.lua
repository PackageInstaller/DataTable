__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_CommonID = readonly({
  CommonID_Account_Desc = {
    Text = "অ্যাকাউন্ট"
  },
  CommonID_AchieveCommemorativeData_Dmg_Desc = {
    Text = "সর্বোচ্চ ক্ষতি"
  },
  CommonID_AchieveCommemorativeData_Poison_Desc = {
    Text = "সর্বোচ্চ তলা"
  },
  CommonID_AchieveCommemorativeData_Time_Desc = {
    Text = "সম্পন্নের সময়"
  },
  CommonID_AchieveType0_Desc = {
    Text = "সমস্ত অর্জন"
  },
  CommonID_AchieveType1_Desc = {
    Text = "বিকাশের গল্প"
  },
  CommonID_AchieveType2_Desc = {
    Text = "তদন্ত চিহ্ন"
  },
  CommonID_AchieveType3_Desc = {
    Text = "যুদ্ধের রেকর্ড"
  },
  CommonID_AchieveType4_Desc = {
    Text = "রক্ষকের জীবন"
  },
  CommonID_Add_State_Desc = {
    Text = "অবস্থা যুক্ত করুন"
  },
  CommonID_All_Desc = {Text = "সব"},
  CommonID_AnyAvgFirstTrigger_Desc = {
    Text = "মিশন সম্পন্ন শর্ত: যেকোনো গল্প ট্রিগার করুন"
  },
  CommonID_AnyEntryInGroupUnlock_Desc = {
    Text = "মিশন সম্পন্ন শর্ত: যেকোনো এন্ট্রি আনলক করুন"
  },
  CommonID_AnyEventFirstTrigger_Desc = {
    Text = "মিশন সম্পন্ন শর্ত: যেকোনো ইভেন্ট ট্রিগার করুন"
  },
  CommonID_AnyItemFirstGet_Desc = {
    Text = "মিশন সম্পন্ন শর্ত: যেকোনো আইটেম অর্জন করুন"
  },
  CommonID_AnyNodeTypeFirstTrigger_Desc = {
    Text = "মিশন সম্পন্ন শর্ত: যেকোনো নোড ট্রিগার করুন"
  },
  CommonID_AnyRelicFirstGet_Desc = {
    Text = "মিশন সম্পন্ন শর্ত: যেকোনো রেলিক অর্জন করুন"
  },
  CommonID_AnyStageFirstClear_Desc = {
    Text = "মিশন সম্পন্ন শর্ত: যেকোনো স্তর·ক্লিয়ার"
  },
  CommonID_AppointTaskRewardAdd_Desc = {
    Text = "পুরস্কার বাড়াতে নিয়োগ করুন"
  },
  CommonID_Attr_Promote_Desc = {
    Text = "গুণাবলীর উন্নয়ন"
  },
  CommonID_AwakerDied_Desc = {
    Text = "জাগরণকারীর মৃত্যু"
  },
  CommonID_AwakerMonster_Desc = {
    Text = "জাগরণকারী বস"
  },
  CommonID_BN_Desc = {
    Text = "বাংলা (alpha)"
  },
  CommonID_BanBattlePos_Desc = {
    Text = "মোতায়েন করা যাবে না"
  },
  CommonID_Battle_Desc = {
    Text = "যুদ্ধ"
  },
  CommonID_Blue_Desc = {Text = "নীল"},
  CommonID_Boss_Desc = {Text = "বস"},
  CommonID_BundleShortcutKey_Desc = {
    Text = "চাবি বন্ধন"
  },
  CommonID_CN_Desc = {
    Text = "সরলীকৃত চীনা"
  },
  CommonID_CardBorder_Desc = {
    Text = "কার্ডের চেহারা"
  },
  CommonID_CardSlots_LevelUp_Desc = {
    Text = "স্লট উন্নয়ন অর্জন"
  },
  CommonID_Card_AdvancedImagery_Desc = {
    Text = "উন্নত চিত্রকল্প"
  },
  CommonID_Card_AttachPost_Desc = {
    Text = "পশ্চাদ্ধাবন"
  },
  CommonID_Card_Awake_Desc = {
    Text = "জাগরণ"
  },
  CommonID_Card_Curse_Desc = {
    Text = "লক্ষণ"
  },
  CommonID_Card_Defend_Desc = {
    Text = "প্রতিরক্ষা কার্ড"
  },
  CommonID_Card_Developing_Desc = {
    Text = "উন্নয়নাধীন"
  },
  CommonID_Card_Extend_Desc = {
    Text = "উদ্ভূত কার্ড"
  },
  CommonID_Card_Fraud_Desc = {
    Text = "প্রতারণা"
  },
  CommonID_Card_Imagery_Desc = {
    Text = "চিত্রকল্প"
  },
  CommonID_Card_KeeperSkill_Desc = {
    Text = "দলবল কার্ড"
  },
  CommonID_Card_Potion_Desc = {
    Text = "ঔষধ কার্ড"
  },
  CommonID_Card_Skill_Desc = {
    Text = "দক্ষতা কার্ড"
  },
  CommonID_Card_State_Desc = {
    Text = "অবস্থা কার্ড"
  },
  CommonID_Card_Strike_Desc = {
    Text = "স্ট্রাইক কার্ড"
  },
  CommonID_Card_Weapon_Desc = {
    Text = "নিয়তিচক্র"
  },
  CommonID_CastSkillLevel_Desc = {
    Text = "দক্ষতা নিক্ষেপ স্তর"
  },
  CommonID_Challenge_Desc = {
    Text = "তদন্ত"
  },
  CommonID_Change_Skill_Desc = {
    Text = "দক্ষতা প্রতিস্থাপন"
  },
  CommonID_Chinese_Desc = {
    Text = "চীনা"
  },
  CommonID_ChooseHandCard_Desc = {
    Text = "একটি হাতের কার্ড বেছে নিন"
  },
  CommonID_ClickToQuit_Desc = {
    Text = "বের হতে ক্লিক করুন"
  },
  CommonID_ClickToView_Desc = {
    Text = "দেখতে ক্লিক করুন"
  },
  CommonID_Click_Desc = {
    Text = "লাফ দিতে ক্লিক করুন"
  },
  CommonID_Close_Desc = {
    Text = "বন্ধ করুন"
  },
  CommonID_ComingSoon_Desc = {
    Text = "অপেক্ষায় থাকুন"
  },
  CommonID_CommonAttr_Desc = {
    Text = "সাধারণ গুণাবলি বোনাস"
  },
  CommonID_Common_Desc = {
    Text = "সাধারণ"
  },
  CommonID_ContinuousSound_Desc = {
    Text = "খেলা চালিয়ে যান"
  },
  CommonID_CopperAchieve_Desc = {
    Text = "তামা"
  },
  CommonID_CountingStart_Desc = {
    Text = "আমাদের পালায় কাউন্টডাউন শুরু হয়"
  },
  CommonID_Custom_Desc = {
    Text = "কাস্টম"
  },
  CommonID_DE_Desc = {
    Text = "জার্মান (আলফা)"
  },
  CommonID_DPS_Desc = {
    Text = "আক্রমণ"
  },
  CommonID_DepressionHit_Desc = {
    Text = "আঘাতে বিষণ্নতা"
  },
  CommonID_DisableKeeperSkill_Desc = {
    Text = "প্রধান চরিত্রের দক্ষতা নিষ্ক্রিয় করুন"
  },
  CommonID_DisableTrinketSuitEffect_Desc = {
    Text = "কভেন্যান্ট নিষ্ক্রিয় করুন"
  },
  CommonID_DisableWeapon_Desc = {
    Text = "নিয়তিচক্র নিষ্ক্রিয় করুন"
  },
  CommonID_Display_Desc = {
    Text = "দৃশ্যমানতা"
  },
  CommonID_DropdownList_Desc = {
    Text = "ড্রপডাউন তালিকা"
  },
  CommonID_EN_Desc = {
    Text = "ইংরেজি (বেটা)"
  },
  CommonID_ES_Desc = {
    Text = "স্প্যানিশ (আলফা)"
  },
  CommonID_Elite_Desc = {
    Text = "এলিট"
  },
  CommonID_EmojiType_10_Desc = {
    Text = "ছোট্ট মিথাগ"
  },
  CommonID_EmojiType_11_Desc = {
    Text = "আমার পালা"
  },
  CommonID_EmojiType_12_Desc = {
    Text = "মিথাগ দৈনন্দিন"
  },
  CommonID_EmojiType_13_Desc = {
    Text = "হ্যাপি মিথাগ"
  },
  CommonID_EmojiType_14_Desc = {
    Text = "অসুখী মিথাগ"
  },
  CommonID_EmojiType_15_Desc = {
    Text = "স্কুল জীবন পর্ব"
  },
  CommonID_EmojiType_16_Desc = {
    Text = "শান্তির একটি দিন"
  },
  CommonID_EmojiType_17_Desc = {
    Text = "স্কুলের পরে"
  },
  CommonID_EmojiType_18_Desc = {
    Text = "লাভ ইউ মিথাগ"
  },
  CommonID_EmojiType_19_Desc = {
    Text = "মিথাগ ছুটি"
  },
  CommonID_EmojiType_1_Desc = {
    Text = "নরম মিথ্যাগ"
  },
  CommonID_EmojiType_20_Desc = {
    Text = "ক্রিসমাস মিথাগ"
  },
  CommonID_EmojiType_21_Desc = {
    Text = "জিঞ্জারব্রেড পার্টি"
  },
  CommonID_EmojiType_22_Desc = {
    Text = "ক্যাম্পাসের উপাখ্যান"
  },
  CommonID_EmojiType_23_Desc = {
    Text = "মিথাগ অনুসন্ধান কর্মকর্তা"
  },
  CommonID_EmojiType_24_Desc = {
    Text = "মিথাগ অন্তর্বর্তী মহড়া"
  },
  CommonID_EmojiType_25_Desc = {
    Text = "সায়ার গান"
  },
  CommonID_EmojiType_2_Desc = {
    Text = "মোরি মোরি"
  },
  CommonID_EmojiType_3_Desc = {
    Text = "জাগতিক বিচিত্রতা"
  },
  CommonID_EmojiType_4_Desc = {
    Text = "মরি-চিবিস"
  },
  CommonID_EmojiType_5_Desc = {
    Text = "ট্র্যাফেজ কম"
  },
  CommonID_EmojiType_6_Desc = {
    Text = "উজ্জ্বল মিথ্যাগ"
  },
  CommonID_EmojiType_7_Desc = {
    Text = "উন্মাদ মিথাগ"
  },
  CommonID_EmojiType_8_Desc = {
    Text = "সহজ মিথ্যাগ"
  },
  CommonID_EmojiType_9_Desc = {
    Text = "প্রজ্ঞা মিথাগ"
  },
  CommonID_Enchant_Desc = {
    Text = "প্রার্থনাগাথা"
  },
  CommonID_Entrance_Desc = {
    Text = "পপআপ এন্ট্রি"
  },
  CommonID_FALSE_Desc = {Text = "না"},
  CommonID_FR_Desc = {
    Text = "ফরাসি (আলফা)"
  },
  CommonID_Forged_Desc = {
    Text = "উন্নত করুন"
  },
  CommonID_FreeBattlePos_Desc = {
    Text = "বিনামূল্যে মোতায়েন"
  },
  CommonID_FullScreen_Desc = {
    Text = "পূর্ণ পর্দা"
  },
  CommonID_Gender_Boy_Desc = {
    Text = "পুরুষ"
  },
  CommonID_Gender_Girl_Desc = {
    Text = "নারী"
  },
  CommonID_GetLikeLevel_Desc = {
    Text = "কার্যপ্রণালী"
  },
  CommonID_GmaeVoice_Desc = {
    Text = "গেম অডিও"
  },
  CommonID_GoldAchieve_Desc = {
    Text = "সোনা"
  },
  CommonID_Hall_Desc = {Text = "লবি"},
  CommonID_HarvestAdd_Desc = {
    Text = "স্বদেশ পুরস্কার বৃদ্ধি"
  },
  CommonID_HaveAwaker_Desc = {
    Text = "মিশন সম্পন্ন শর্ত: যেকোনো জাগরণকারী মালিকানায় রাখুন"
  },
  CommonID_HeadType_1_Desc = {
    Text = "রৌপ্য চাবির নামে"
  },
  CommonID_HeadType_2_Desc = {
    Text = "চিবি মাগশট"
  },
  CommonID_HeadType_3_Desc = {
    Text = "কখনো ম্লান হয় না এমন গতকাল"
  },
  CommonID_HeadType_4_Desc = {
    Text = "সংগ্রাহকের স্ট্যাম্প"
  },
  CommonID_High_Desc = {
    Text = "উচ্চ"
  },
  CommonID_Holy_Desc = {
    Text = "পবিত্রকরণ"
  },
  CommonID_ID_Desc = {
    Text = "ইন্দোনেশীয় (আলফা)"
  },
  CommonID_IT_Desc = {
    Text = "ইতালীয় (alpha)"
  },
  CommonID_Image_Desc = {Text = "ছবি"},
  CommonID_Intent_AttackBuff_Desc = {
    Text = "দানবের অভিপ্রায়: আক্রমণ ও শক্তিবৃদ্ধি"
  },
  CommonID_Intent_AttackDebuffD09Skill2_Desc = {
    Text = "দানবের অভিপ্রায়: আক্রমণ ও দুর্বলতা আরোপ"
  },
  CommonID_Intent_AttackDebuff_Desc = {
    Text = "দানবের অভিপ্রায়: আক্রমণ ও দুর্বলতা আরোপ"
  },
  CommonID_Intent_AttackDefence_Desc = {
    Text = "দানবের অভিপ্রায়: আক্রমণ ও প্রতিরক্ষা"
  },
  CommonID_Intent_Attack_Desc = {
    Text = "দানবের অভিপ্রায়: আক্রমণ"
  },
  CommonID_Intent_Buff_Desc = {
    Text = "দানবের অভিপ্রায়: শক্তিবৃদ্ধি"
  },
  CommonID_Intent_Burst2_Desc = {
    Text = "দানবের অভিপ্রায়: অ্যালিমাস (অ-আক্রমণ)"
  },
  CommonID_Intent_Burst3_Desc = {
    Text = "দানবের অভিপ্রায়: সুপার অ্যালিমাস"
  },
  CommonID_Intent_Burst4_Desc = {
    Text = "দানবের অভিপ্রায়: মুক্ত করো সমাপ্তি"
  },
  CommonID_Intent_Burst_Desc = {
    Text = "দানবের অভিপ্রায়: অ্যালিমাস"
  },
  CommonID_Intent_DCB022Buff_Desc = {
    Text = "দানবের অভিপ্রায়: শক্তিবৃদ্ধি"
  },
  CommonID_Intent_DCB024Buff_Desc = {
    Text = "দানবের অভিপ্রায়: শক্তিবৃদ্ধি"
  },
  CommonID_Intent_Debuff_Desc = {
    Text = "দানবের অভিপ্রায়: দুর্বলতা আরোপ"
  },
  CommonID_Intent_DefenceBuff_Desc = {
    Text = "দানবের অভিপ্রায়: প্রতিরক্ষা ও শক্তিবৃদ্ধি"
  },
  CommonID_Intent_DefenceDebuff_Desc = {
    Text = "দানবের অভিপ্রায়: প্রতিরক্ষা ও দুর্বলতা আরোপ"
  },
  CommonID_Intent_Defence_Desc = {
    Text = "দানবের অভিপ্রায়: প্রতিরক্ষা"
  },
  CommonID_Intent_Dizzy_Desc = {
    Text = "দানবের অভিপ্রায়: স্তব্ধতা"
  },
  CommonID_Intent_HeavyAttackDCB02_Desc = {
    Text = "দানবের অভিপ্রায়: প্রচণ্ড আক্রমণ"
  },
  CommonID_Intent_HeavyAttack_Desc = {
    Text = "দানবের অভিপ্রায়: প্রচণ্ড আক্রমণ"
  },
  CommonID_Intent_StrongBuff_Desc = {
    Text = "দানবের অভিপ্রায়: মেজর শক্তিবৃদ্ধি"
  },
  CommonID_Intent_StrongDebuff_Desc = {
    Text = "দানবের অভিপ্রায়: মেজর দুর্বলতা আরোপ"
  },
  CommonID_Intent_Unknown1_Desc = {
    Text = "দানবের অভিপ্রায়: অজানা জীব"
  },
  CommonID_Intent_Unknown2_Desc = {
    Text = "দানবের অভিপ্রায়: অজানা জীব"
  },
  CommonID_Intent_Unknown3_Desc = {
    Text = "দানবের অভিপ্রায়: অজানা জীব"
  },
  CommonID_Intent_Unknown4_Desc = {
    Text = "দানবের অভিপ্রায়: অজানা জীব"
  },
  CommonID_Intent_Unknown5_Desc = {
    Text = "দানবের অভিপ্রায়: অজানা জীব"
  },
  CommonID_Intent_Unknown6_Desc = {
    Text = "দানবের অভিপ্রায়: অজানা জীব"
  },
  CommonID_Intent_Unknown_Desc = {
    Text = "দানবের অভিপ্রায়: অজানা জীব"
  },
  CommonID_ItemManagement_Desc = {
    Text = "আইটেম"
  },
  CommonID_JP_Desc = {
    Text = "জাপানি (আলফা)"
  },
  CommonID_KR_Desc = {
    Text = "কোরিয়ান (আলফা)"
  },
  CommonID_Keeper_Skill_Desc = {
    Text = "রক্ষক দক্ষতা"
  },
  CommonID_KeyType_1_Desc = {
    Text = "বিস্মৃত উত্তরাধিকার"
  },
  CommonID_KeyType_2_Desc = {
    Text = "কেওস"
  },
  CommonID_KeyType_3_Desc = {
    Text = "অ্যাকুওর"
  },
  CommonID_KeyType_4_Desc = {
    Text = "কারো"
  },
  CommonID_KeyType_5_Desc = {
    Text = "আল্ট্রা"
  },
  CommonID_Key_Desc = {
    Text = "বোতাম"
  },
  CommonID_Language_Desc = {
    Text = "ভাষা"
  },
  CommonID_LevelLimit_Promote_Desc = {
    Text = "স্তরের ঊর্ধ্বসীমা বৃদ্ধি"
  },
  CommonID_Low_Desc = {
    Text = "নিম্ন"
  },
  CommonID_Management_Desc = {
    Text = "গবেষণা ও উন্নয়ন ব্যবস্থাপনা-তে যান"
  },
  CommonID_ManiaHit_Desc = {
    Text = "আঘাতে উন্মত্ততা"
  },
  CommonID_MasterVolume_Desc = {
    Text = "সামগ্রিক নিয়ন্ত্রণ"
  },
  CommonID_MaterialsReturn_Desc = {
    Text = "ব্যবহৃত সম্পদের ফেরত"
  },
  CommonID_MessagePush_Desc = {
    Text = "নোটিফিকেশন পুশ"
  },
  CommonID_Middle_Desc = {
    Text = "মাঝারি"
  },
  CommonID_Modify_Desc = {
    Text = "পরিবর্তন করতে ক্লিক করুন"
  },
  CommonID_MonsterGrade1_Desc = {
    Text = "স্তর 1 অনুচর"
  },
  CommonID_MonsterGrade2_Desc = {
    Text = "স্তর ২ অনুচর"
  },
  CommonID_MotherTreeMonster_Desc = {
    Text = "\"「উর্বরতার মাতৃবৃক্ষ」\""
  },
  CommonID_MultiplierXP_Desc = {
    Text = "একাধিক অভিজ্ঞতা বুস্ট"
  },
  CommonID_Mute_Desc = {
    Text = "নীরবতা"
  },
  CommonID_NotAwakerMonster_Desc = {
    Text = "অজাগ্রত বস"
  },
  CommonID_Open_Desc = {
    Text = "খুলুন"
  },
  CommonID_OperationImpossible_Desc = {
    Text = "বিভিন্ন কারণে (অপর্যাপ্ত অ্যারিথমেটিকা, খেলোয়াড়ের টার্ন না থাকা, সিলড, পেট্রিফাইড ইত্যাদি) খেলোয়াড় কোনো ক্রিয়া (কার্ড খেলা, এক্সাল্ট) সম্পাদনে ব্যর্থ হয়"
  },
  CommonID_OperationStop_Desc = {
    Text = "আমাদের টার্নের সঞ্চিত চিন্তার সময় নির্ধারিত সর্বোচ্চ মানে (কনস্ট্যান্ট টেবিলে কনফিগার করা) পৌঁছে যায়"
  },
  CommonID_Orange_Desc = {
    Text = "সোনা"
  },
  CommonID_PT_Desc = {
    Text = "পর্তুগিজ (আলফা)"
  },
  CommonID_PVP_Desc = {
    Text = "ট্র্যাফেজ"
  },
  CommonID_PassiveSkill_Desc = {
    Text = "নিষ্ক্রিয় দক্ষতা"
  },
  CommonID_PersonalProfile_Desc = {
    Text = "প্রোফাইল"
  },
  CommonID_PlayerEnter_Desc = {
    Text = "গেম শুরু, খেলোয়াড় তাদের কার্ড নির্বাচন করার পরে"
  },
  CommonID_PlayerFiles_Desc = {
    Text = "রক্ষকের প্রোফাইল"
  },
  CommonID_Potency_Desc = {
    Text = "আত্মজাগরণ"
  },
  CommonID_Privacy_Desc = {
    Text = "গোপনীয়তা"
  },
  CommonID_Purple_Desc = {
    Text = "ক্রোনো পেন্ডুলাম"
  },
  CommonID_RU_Desc = {
    Text = "রুশ (আলফা)"
  },
  CommonID_RedGlow_Desc = {
    Text = "লাল আলোর প্রভাব"
  },
  CommonID_Red_Desc = {
    Text = "অভিশাপ"
  },
  CommonID_Redeem_Desc = {
    Text = "রিডিম-এ যান"
  },
  CommonID_ReletedAwakerInEnemies_Desc = {
    Text = "শত্রু অ্যাওয়েকনার এবং মিত্র অ্যাওয়েকনারের মধ্যকার সংলাপ"
  },
  CommonID_Relic_Desc = {
    Text = "রেলিক"
  },
  CommonID_Repair_Desc = {
    Text = "মেরামতে যান"
  },
  CommonID_ResNeedReduce_Desc = {
    Text = "সম্পদ ব্যয় হ্রাস"
  },
  CommonID_SUP_Desc = {
    Text = "কোরাস"
  },
  CommonID_SellCard_Desc = {
    Text = "কার্ড বিক্রি করো"
  },
  CommonID_ShortcutKey_Desc = {
    Text = "হটকি"
  },
  CommonID_SilverAchieve_Desc = {
    Text = "সিলভার"
  },
  CommonID_Sin_Desc = {
    Text = "আদিম পাপ"
  },
  CommonID_SkillReady_Desc = {
    Text = "অ্যালিমাস গেজ পূর্ণ হয়ে গেলে এবং এক্সাল্ট মুক্ত করো করার জন্য ক্লিক করা সম্ভব হওয়ার মুহূর্ত"
  },
  CommonID_Skill_LevelUp_Desc = {
    Text = "দক্ষতা উন্নয়ন অর্জন"
  },
  CommonID_Slider_Desc = {
    Text = "মান স্লাইডার"
  },
  CommonID_SlotCardLevel_Desc = {
    Text = "ডিফল্ট স্লট স্তর"
  },
  CommonID_SoundBalance_Desc = {
    Text = "সাউন্ড ভারসাম্য"
  },
  CommonID_SpecificCommunicateTrig_Desc = {
    Text = "মিশন সম্পন্নের শর্ত: নির্দিষ্ট সংলাপ ট্রিগার করো"
  },
  CommonID_StageDropAdd_Desc = {
    Text = "ডানজিয়ন আউটপুট বৃদ্ধি"
  },
  CommonID_Switch_Desc = {
    Text = "পরিবর্তন"
  },
  CommonID_System_Desc = {
    Text = "সিস্টেম"
  },
  CommonID_TH_Desc = {
    Text = "থাই (আলফা)"
  },
  CommonID_TRUE_Desc = {
    Text = "হ্যাঁ"
  },
  CommonID_TR_Desc = {
    Text = "তুর্কি (alpha)"
  },
  CommonID_TW_Desc = {
    Text = "প্রচলিত চীনা"
  },
  CommonID_T_Desc = {
    Text = "রক্ষক"
  },
  CommonID_TaskCount_Desc = {
    Text = "গণনা"
  },
  CommonID_TaskInProgress_Desc = {
    Text = "চলছে"
  },
  CommonID_TaweiMonster_Desc = {
    Text = "অন্ধকার তাবিল"
  },
  CommonID_Through1_Desc = {
    Text = "প্যাসিভ দক্ষতা ১"
  },
  CommonID_Through2_Desc = {
    Text = "প্যাসিভ দক্ষতা ২"
  },
  CommonID_Tips_Desc = {
    Text = "তদন্ত চলমান"
  },
  CommonID_TranslationLabel_Desc = {
    Text = "অফিসিয়াল অনুবাদ লেবেল"
  },
  CommonID_Ulti_Skill_Desc = {
    Text = "এক্সাল্ট"
  },
  CommonID_UtlSkill_Promote_Desc = {
    Text = "ওভার-এক্সাল্ট"
  },
  CommonID_VN_Desc = {
    Text = "ভিয়েতনামি (আলফা)"
  },
  CommonID_VeryHigh_Desc = {
    Text = "অত্যন্ত উচ্চ"
  },
  CommonID_VeryLow_Desc = {
    Text = "অত্যন্ত নিম্ন"
  },
  CommonID_View_Desc = {
    Text = "পরীক্ষা করতে যান"
  },
  CommonID_Voice_Desc = {
    Text = "শব্দ।"
  },
  CommonID_Web_Desc = {
    Text = "পৃষ্ঠা পুনর্নির্দেশ"
  },
  CommonID_White_Desc = {
    Text = "সিলভার"
  },
  CommonID_WindowNotFocusVoice_Desc = {
    Text = "উইন্ডো অনফোকাসড সাউন্ড প্রভাব"
  },
  CommonID_Window_Desc = {
    Text = "উইন্ডো মোড"
  },
  CommonID_YellowGlow_Desc = {
    Text = "হলুদ আলোর প্রভাব"
  }
})
return Text_CommonID
