-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResUIData.lua

local Data = {
	[9] = {
		id = 9,
		prefab = "BlockCanvas",
		prefabKey = "BlockCanvas"
	},
	[12] = {
		id = 12,
		prefab = "System/Login/ClickCanvas",
		ui_type = 4,
		ui_order = 130,
		prefabKey = "ClickCanvas"
	},
	[101] = {
		need_state_name = "sMainHome",
		prefab = "System/MainMenu/MainMenuCanvas",
		ui_group = 20,
		ui_order = 19,
		id = 101,
		ui_type = 1,
		prefabKey = "MainMenuCanvas"
	},
	[102] = {
		need_state_name = "sMainStage",
		prefab = "System/MainMenu/MainMenuOutsideCanvas",
		ui_group = 20,
		ui_order = 19,
		id = 102,
		ui_type = 1,
		prefabKey = "MainMenuOutsideCanvas"
	},
	[103] = {
		id = 103,
		prefab = "System/MainMenu/PlayerLvUpCanvas",
		ui_type = 4,
		ui_order = 19,
		prefabKey = "PlayerLvUpCanvas"
	},
	[104] = {
		need_state_name = "sMainHome",
		prefab = "System/MainMenu/MainMenuModelStageCanvas",
		ui_order = 18,
		ui_type = 4,
		id = 104,
		prefabKey = "MainMenuModelStageCanvas"
	},
	[105] = {
		id = 105,
		ui_group = 40,
		block_pause_delay = 0.04,
		prefab = "System/MainMenu/MainMenuHoldCanvas",
		ui_type = 2,
		ui_block = 0,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "MainMenuHoldCanvas"
	},
	[201] = {
		need_hdr = 1,
		prefab = "System/Hero/HeroMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 201,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "HeroMainCanvas"
	},
	[202] = {
		ui_group = 40,
		prefab = "System/Hero/HeroCardListSetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 202,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "HeroCardListSetCanvas"
	},
	[203] = {
		id = 203,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Hero/HeroUpgradeResultCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "HeroUpgradeResultCanvas"
	},
	[204] = {
		ui_group = 40,
		prefab = "System/Hero/HeroStarUpMaterialCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 204,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "HeroStarUpMaterialCanvas"
	},
	[205] = {
		ui_group = 20,
		prefab = "System/Hero/HeroEquipWearCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 205,
		shut_down_cam = 1,
		prefabKey = "HeroEquipWearCanvas"
	},
	[206] = {
		need_hdr = 1,
		prefab = "System/Hero/HeroEquipUpGradeCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 206,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "HeroEquipUpGradeCanvas"
	},
	[207] = {
		ui_group = 20,
		prefab = "System/Hero/HeroSellCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 207,
		shut_down_cam = 1,
		prefabKey = "HeroSellCanvas"
	},
	[208] = {
		ui_group = 60,
		prefab = "System/Hero/HeroSellRewardCanvas",
		ui_block = 1,
		ui_order = 60,
		id = 208,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "HeroSellRewardCanvas"
	},
	[209] = {
		ui_group = 100,
		prefab = "System/Common/Tips/SkillTipsCanvas",
		ui_block = 1,
		ui_order = 666,
		id = 209,
		block_alpha = 1,
		ui_type = 5,
		prefabKey = "SkillTipsCanvas"
	},
	[210] = {
		ui_group = 40,
		prefab = "System/Common/SiftBox/HeroSellSiftBoxCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 210,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "HeroSellSiftBoxCanvas"
	},
	[211] = {
		ui_order = 40,
		prefab = "System/Hero/ResetBoxCanvas",
		ui_block = 0,
		ui_group = 40,
		ui_type = 2,
		id = 211,
		block_alpha = 1,
		shut_down_cam = 1,
		prefabKey = "ResetBoxCanvas"
	},
	[212] = {
		ui_group = 40,
		prefab = "System/Hero/HeroGroupCareerInfoCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 212,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "HeroGroupCareerInfoCanvas"
	},
	[213] = {
		ui_group = 40,
		prefab = "System/Hero/HeroUpgradeCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 213,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "HeroUpgradeCanvas"
	},
	[214] = {
		ui_group = 20,
		prefab = "System/Hero/HeroEquipEvolutionCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 214,
		shut_down_cam = 1,
		prefabKey = "HeroEquipEvolutionCanvas"
	},
	[215] = {
		ui_group = 40,
		prefab = "System/Hero/HeroEquipEvolutionSuccessCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 215,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "HeroEquipEvolutionSuccessCanvas"
	},
	[216] = {
		ui_group = 40,
		prefab = "System/Hero/HeroUpgradeFastCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 216,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "HeroUpgradeFastCanvas"
	},
	[217] = {
		ui_order = 40,
		prefab = "System/Hero/ResetOrderCanvas",
		ui_block = 0,
		ui_group = 40,
		ui_type = 2,
		id = 217,
		block_alpha = 1,
		shut_down_cam = 1,
		prefabKey = "ResetOrderCanvas"
	},
	[218] = {
		ui_order = 40,
		prefab = "System/Hero/GetSkinConfirmCanvas",
		ui_block = 0,
		ui_group = 40,
		ui_type = 2,
		id = 218,
		block_alpha = 1,
		shut_down_cam = 1,
		prefabKey = "GetSkinConfirmCanvas"
	},
	[219] = {
		ui_group = 100,
		prefab = "System/Common/Tips/SkinTipsCanvas",
		ui_block = 1,
		ui_order = 666,
		id = 219,
		block_alpha = 1,
		ui_type = 5,
		prefabKey = "SkinTipsCanvas"
	},
	[220] = {
		ui_group = 100,
		prefab = "System/Hero/SkinPreviewCanvas",
		ui_block = 1,
		ui_order = 666,
		id = 220,
		block_alpha = 1,
		ui_type = 5,
		prefabKey = "SkinPreviewCanvas"
	},
	[221] = {
		ui_group = 40,
		prefab = "System/Hero/AttrInfoCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 221,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "AttrInfoCanvas"
	},
	[222] = {
		prefab = "System/Hero/HeroGrowRecommendCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 222,
		prefabKey = "HeroGrowRecommendCanvas"
	},
	[223] = {
		ui_group = 40,
		prefab = "System/Hero/HeroBecomeLeaderCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 223,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "HeroBecomeLeaderCanvas"
	},
	[224] = {
		ui_group = 40,
		prefab = "System/Hero/HeroGrowBecomeLeaderCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 224,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "HeroGrowBecomeLeaderCanvas"
	},
	[225] = {
		ui_group = 40,
		prefab = "System/Hero/HeroGuideEvaluateCanvas",
		ui_block = 0,
		ui_order = 58,
		id = 225,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "HeroGuideEvaluateCanvas"
	},
	[226] = {
		ui_group = 60,
		prefab = "System/Hero/HeroEvaluateCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 226,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "HeroEvaluateCanvas"
	},
	[227] = {
		prefab = "System/Hero/HeroStageUpSkillDetailCanvas",
		ui_group = 40,
		ui_order = 40,
		ui_type = 2,
		id = 227,
		prefabKey = "HeroStageUpSkillDetailCanvas"
	},
	[228] = {
		prefab = "System/Hero/HeroCoatingCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 228,
		prefabKey = "HeroCoatingCanvas"
	},
	[229] = {
		ui_order = 40,
		prefab = "System/Hero/ResetBoxTransferCanvas",
		ui_block = 0,
		ui_group = 40,
		ui_type = 2,
		id = 229,
		block_alpha = 1,
		shut_down_cam = 1,
		prefabKey = "ResetBoxTransferCanvas"
	},
	[230] = {
		ui_order = 60,
		prefab = "System/Hero/HeroEquipConfirmBox",
		ui_block = 0,
		ui_group = 60,
		ui_type = 3,
		with_state_close = 1,
		id = 230,
		block_alpha = 1,
		prefabKey = "HeroEquipConfirmBox"
	},
	[231] = {
		ui_group = 40,
		prefab = "System/Hero/VanityHeroDetailCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 231,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "VanityHeroDetailCanvas"
	},
	[232] = {
		prefab = "System/Hero/VanityHeroStarChangeCanvas",
		ui_group = 40,
		ui_block = 1,
		logic_flag = 1,
		ui_type = 2,
		ui_order = 39,
		need_hdr = 1,
		id = 232,
		block_alpha = 1,
		prefabKey = "VanityHeroStarChangeCanvas"
	},
	[233] = {
		ui_group = 40,
		prefab = "System/Hero/HeroCoatingTransitionCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 233,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "HeroCoatingTransitionCanvas"
	},
	[234] = {
		ui_group = 20,
		prefab = "System/Hero/HeroEquipPowerUpCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 234,
		shut_down_cam = 1,
		prefabKey = "HeroEquipPowerUpCanvas"
	},
	[235] = {
		ui_group = 60,
		prefab = "System/Hero/VanityHeroConfirmBox",
		ui_block = 1,
		ui_order = 60,
		id = 235,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "VanityHeroConfirmBox"
	},
	[236] = {
		ui_group = 100,
		prefab = "System/Hero/HeroSkinStoryCanvas",
		ui_block = 1,
		ui_order = 666,
		id = 236,
		block_alpha = 1,
		ui_type = 5,
		prefabKey = "HeroSkinStoryCanvas"
	},
	[303] = {
		ui_group = 41,
		prefab = "System/MainBattle/MainBattleHookAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 303,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "MainBattleHookAwardCanvas"
	},
	[304] = {
		id = 304,
		prefab = "System/MainBattle/MainBattleSpeedUpCanvas",
		ui_type = 4,
		ui_order = 61,
		prefabKey = "MainBattleSpeedUpCanvas"
	},
	[305] = {
		ui_group = 40,
		prefab = "System/MainBattle/BossInfoCanvas",
		ui_block = 1,
		ui_order = 61,
		id = 305,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "BossInfoCanvas"
	},
	[306] = {
		id = 306,
		prefab = "System/MainBattle/MainBattleChangeSceneCanvas",
		ui_type = 4,
		ui_order = 17,
		prefabKey = "MainBattleChangeSceneCanvas"
	},
	[307] = {
		ui_group = 40,
		prefab = "System/MainBattle/MainBattleLvInfoCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 307,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "MainBattleLvInfoCanvas"
	},
	[308] = {
		ui_group = 120,
		prefab = "System/MainBattle/MainBattleChangeChapterCanvas",
		ui_order = 120,
		ui_type = 6,
		id = 308,
		shut_down_cam = 1,
		prefabKey = "MainBattleChangeChapterCanvas"
	},
	[309] = {
		prefab = "System/MainBattle/MainBattleCityNameCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 309,
		prefabKey = "MainBattleCityNameCanvas"
	},
	[310] = {
		ui_group = 40,
		prefab = "System/MainBattle/MainBattleSkipCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 310,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "MainBattleSkipCanvas"
	},
	[311] = {
		ui_group = 60,
		prefab = "System/MainBattle/MainBattleRecommend/MainBattleRecommendCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 311,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "MainBattleRecommendCanvas"
	},
	[501] = {
		ui_group = 20,
		prefab = "System/Bag/BagMainCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 501,
		shut_down_cam = 1,
		prefabKey = "BagMainCanvas"
	},
	[502] = {
		ui_group = 100,
		prefab = "System/Common/Tips/ShatterTipsCanvas",
		ui_block = 1,
		ui_order = 666,
		id = 502,
		block_alpha = 1,
		ui_type = 5,
		prefabKey = "ShatterTipsCanvas"
	},
	[503] = {
		ui_group = 100,
		prefab = "System/Common/Tips/MaterialTipsCanvas",
		ui_block = 1,
		ui_order = 666,
		id = 503,
		block_alpha = 1,
		ui_type = 5,
		prefabKey = "MaterialTipsCanvas"
	},
	[504] = {
		ui_group = 40,
		prefab = "System/Bag/SellItemConfirmCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 504,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "SellItemConfirmCanvas"
	},
	[506] = {
		ui_group = 100,
		prefab = "System/Common/Tips/EquipTipsCanvas",
		ui_block = 1,
		ui_order = 666,
		id = 506,
		block_alpha = 1,
		ui_type = 5,
		prefabKey = "EquipTipsCanvas"
	},
	[507] = {
		ui_group = 104,
		prefab = "System/Common/Tips/BadgeTipsCanvas",
		ui_block = 1,
		ui_order = 666,
		id = 507,
		block_alpha = 1,
		ui_type = 5,
		prefabKey = "BadgeTipsCanvas"
	},
	[508] = {
		ui_group = 60,
		prefab = "System/Bag/BagGridAddCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 508,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "BagGridAddCanvas"
	},
	[509] = {
		ui_group = 100,
		prefab = "System/Common/Tips/EquipRandomTipsCanvas",
		ui_block = 1,
		ui_order = 666,
		id = 509,
		block_alpha = 1,
		ui_type = 5,
		prefabKey = "EquipRandomTipsCanvas"
	},
	[510] = {
		ui_group = 40,
		prefab = "System/Bag/OpenGiftConfirmCanvas",
		ui_block = 0,
		ui_order = 84,
		id = 510,
		block_alpha = 1,
		ui_type = 4,
		prefabKey = "OpenGiftConfirmCanvas"
	},
	[511] = {
		ui_group = 100,
		prefab = "System/Common/Tips/RelicTipsCanvas",
		ui_block = 1,
		ui_order = 666,
		id = 511,
		block_alpha = 1,
		ui_type = 5,
		prefabKey = "RelicTipsCanvas"
	},
	[512] = {
		ui_group = 40,
		prefab = "System/Bag/EquipChangeInfoCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 512,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "EquipChangeInfoCanvas"
	},
	[513] = {
		ui_group = 60,
		prefab = "System/Bag/EditProgramCanvas",
		ui_block = 1,
		ui_order = 60,
		id = 513,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "EditProgramCanvas"
	},
	[514] = {
		ui_group = 60,
		prefab = "System/Bag/BagWearingPlanListCanvas",
		ui_block = 1,
		ui_order = 60,
		id = 514,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "BagWearingPlanListCanvas"
	},
	[515] = {
		ui_group = 20,
		prefab = "System/Bag/ArrayEquipWearingCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 515,
		shut_down_cam = 1,
		prefabKey = "ArrayEquipWearingCanvas"
	},
	[516] = {
		ui_group = 60,
		prefab = "System/Bag/CustomWearingCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 516,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "CustomWearingCanvas"
	},
	[517] = {
		ui_group = 100,
		prefab = "System/Common/ItemProbabilityCanvas",
		ui_block = 1,
		ui_order = 666,
		id = 517,
		block_alpha = 1,
		ui_type = 5,
		prefabKey = "ItemProbabilityCanvas"
	},
	[601] = {
		id = 601,
		prefab = "System/Common/MsgMoveUI",
		ui_type = 4,
		ui_order = 306,
		prefabKey = "MsgMoveUI"
	},
	[701] = {
		need_hdr = 1,
		prefab = "System/Battle/BattleField/BattleMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 701,
		ui_type = 1,
		prefabKey = "BattleMainCanvas"
	},
	[702] = {
		prefab = "System/Battle/BattleField/BattleSequenceFramePlayer",
		ui_group = 21,
		ui_order = 30,
		ui_type = 1,
		id = 702,
		prefabKey = "BattleSequenceFramePlayer"
	},
	[703] = {
		prefab = "System/Battle/BattleField/BattleNameCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 703,
		prefabKey = "BattleNameCanvas"
	},
	[704] = {
		prefab = "System/Battle/BattleField/BattleStartCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 704,
		prefabKey = "BattleStartCanvas"
	},
	[705] = {
		prefab = "System/Battle/BattleField/BattleReplayCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 705,
		prefabKey = "BattleReplayCanvas"
	},
	[706] = {
		id = 706,
		prefab = "System/Battle/BattleField/BattleUIEfxCanvas",
		ui_type = 4,
		ui_order = 15,
		prefabKey = "BattleUIEfxCanvas"
	},
	[707] = {
		need_hdr = 1,
		prefab = "System/Battle/BattleField/BattleMainChallengeBossCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 707,
		ui_type = 1,
		prefabKey = "BattleMainChallengeBossCanvas"
	},
	[708] = {
		id = 708,
		prefab = "System/Battle/BattleField/BattleSkillShowCanvas",
		ui_type = 4,
		ui_order = 14,
		prefabKey = "BattleSkillShowCanvas"
	},
	[709] = {
		need_hdr = 1,
		prefab = "System/Battle/BattleField/BattleMainMazzCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 709,
		ui_type = 1,
		prefabKey = "BattleMainMazzCanvas"
	},
	[710] = {
		prefab = "System/Battle/BattleField/BattleStartSeniorPVPCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 710,
		prefabKey = "BattleStartSeniorPVPCanvas"
	},
	[711] = {
		id = 711,
		ui_group = 60,
		ui_block = 1,
		prefab = "System/Battle/BattleField/BattleDataRecordCanvas",
		ui_type = 3,
		need_hdr = 1,
		ui_order = 60,
		block_alpha = 1,
		prefabKey = "BattleDataRecordCanvas"
	},
	[712] = {
		prefab = "System/Battle/BattleField/BattleMainChallengeBossReplayCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 712,
		prefabKey = "BattleMainChallengeBossReplayCanvas"
	},
	[713] = {
		ui_group = 40,
		prefab = "System/Battle/BattleField/BattleStartTopPVPCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 713,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "BattleStartTopPVPCanvas"
	},
	[714] = {
		ui_group = 40,
		prefab = "System/Battle/BattleField/BattleStartWorldBossEliteCanvas1",
		ui_block = 0,
		ui_order = 40,
		id = 714,
		block_alpha = 0,
		ui_type = 2,
		prefabKey = "BattleStartWorldBossEliteCanvas1"
	},
	[715] = {
		ui_group = 40,
		prefab = "System/Battle/BattleField/BattleStartWorldBossEliteCanvas2",
		ui_block = 0,
		ui_order = 40,
		id = 715,
		block_alpha = 0,
		ui_type = 2,
		prefabKey = "BattleStartWorldBossEliteCanvas2"
	},
	[801] = {
		prefab = "System/Battle/Result/BattleResultMainWinCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 801,
		prefabKey = "BattleResultMainWinCanvas"
	},
	[802] = {
		prefab = "System/Battle/Result/BattleResultMainWinAwardCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 802,
		prefabKey = "BattleResultMainWinAwardCanvas"
	},
	[803] = {
		ui_group = 100,
		prefab = "System/Battle/Result/BattleDataTipsCanvas",
		ui_block = 1,
		ui_order = 666,
		id = 803,
		block_alpha = 1,
		ui_type = 5,
		prefabKey = "BattleDataTipsCanvas"
	},
	[804] = {
		prefab = "System/Battle/Result/BattleResultFailCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 804,
		prefabKey = "BattleResultFailCanvas"
	},
	[805] = {
		prefab = "System/Battle/Result/BattleResultStageTowerWinCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 805,
		prefabKey = "BattleResultStageTowerWinCanvas"
	},
	[806] = {
		ui_group = 40,
		prefab = "System/Battle/Result/BattleResultAsynPVPCleanCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 806,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "BattleResultAsynPVPCleanCanvas"
	},
	[807] = {
		prefab = "System/Battle/Result/BattleResultAsynPVPCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 807,
		prefabKey = "BattleResultAsynPVPCanvas"
	},
	[808] = {
		prefab = "System/Battle/Result/BattleResultAsynPVPAwardCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 808,
		prefabKey = "BattleResultAsynPVPAwardCanvas"
	},
	[809] = {
		need_hdr = 1,
		prefab = "System/Battle/Result/BattleResultChallengeBossCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 809,
		ui_type = 1,
		prefabKey = "BattleResultChallengeBossCanvas"
	},
	[810] = {
		prefab = "System/Battle/Result/BattleResultMazzWinCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 810,
		prefabKey = "BattleResultMazzWinCanvas"
	},
	[811] = {
		prefab = "System/Battle/Result/BattleResultMazzFailCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 811,
		prefabKey = "BattleResultMazzFailCanvas"
	},
	[812] = {
		prefab = "System/Battle/Result/BattleResultStageTowerAwardCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 812,
		prefabKey = "BattleResultStageTowerAwardCanvas"
	},
	[813] = {
		need_hdr = 1,
		prefab = "System/Battle/Result/BattleResultChallengeBossPerfectCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 813,
		ui_type = 1,
		prefabKey = "BattleResultChallengeBossPerfectCanvas"
	},
	[814] = {
		prefab = "System/Battle/Result/BattleResultChallengeBossAwardCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 814,
		prefabKey = "BattleResultChallengeBossAwardCanvas"
	},
	[815] = {
		need_hdr = 1,
		prefab = "System/Battle/Result/BattleResultSeniorPVPWinCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 815,
		ui_type = 1,
		prefabKey = "BattleResultSeniorPVPWinCanvas"
	},
	[816] = {
		need_hdr = 1,
		prefab = "System/Battle/Result/BattleResultSeniorPVPFailCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 816,
		ui_type = 1,
		prefabKey = "BattleResultSeniorPVPFailCanvas"
	},
	[817] = {
		need_hdr = 1,
		prefab = "System/Battle/Result/BattleResultActivityPVPWinCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 817,
		ui_type = 1,
		prefabKey = "BattleResultActivityPVPWinCanvas"
	},
	[818] = {
		need_hdr = 1,
		prefab = "System/Battle/Result/BattleResultActivityPVPFailCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 818,
		ui_type = 1,
		prefabKey = "BattleResultActivityPVPFailCanvas"
	},
	[819] = {
		prefab = "System/Battle/Result/BattleResultSeasonTowerFailCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 819,
		prefabKey = "BattleResultSeasonTowerFailCanvas"
	},
	[820] = {
		prefab = "System/Battle/Result/BattleResultCircleFailCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 820,
		prefabKey = "BattleResultCircleFailCanvas"
	},
	[821] = {
		prefab = "System/Battle/Result/BattleResultNewSeasonTowerAwardCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 821,
		prefabKey = "BattleResultNewSeasonTowerAwardCanvas"
	},
	[822] = {
		prefab = "System/Battle/Result/BattleResultTopPVPWinCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 822,
		prefabKey = "BattleResultTopPVPWinCanvas"
	},
	[823] = {
		prefab = "System/Battle/Result/BattleResultTopPVPFailCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 823,
		prefabKey = "BattleResultTopPVPFailCanvas"
	},
	[824] = {
		need_hdr = 1,
		prefab = "System/Battle/Result/BattleResultMazzPetBossCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 824,
		ui_type = 1,
		prefabKey = "BattleResultMazzPetBossCanvas"
	},
	[825] = {
		need_hdr = 1,
		prefab = "System/Battle/Result/BattleResultMazzPetPerfectCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 825,
		ui_type = 1,
		prefabKey = "BattleResultMazzPetPerfectCanvas"
	},
	[826] = {
		prefab = "System/TopPVP/TopPVPWatchingResultCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 826,
		prefabKey = "TopPVPWatchingResultCanvas"
	},
	[827] = {
		prefab = "System/Battle/Result/BattleResultSneakBattleWinCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 827,
		prefabKey = "BattleResultSneakBattleWinCanvas"
	},
	[828] = {
		prefab = "System/Battle/Result/BattleResultSneakBattleFailCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 828,
		prefabKey = "BattleResultSneakBattleFailCanvas"
	},
	[829] = {
		prefab = "System/Battle/Result/BattleResultChallengeBossEliteCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 829,
		prefabKey = "BattleResultChallengeBossEliteCanvas"
	},
	[830] = {
		prefab = "System/Battle/Result/BattleResultChallengeBossEliteAwardCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 830,
		prefabKey = "BattleResultChallengeBossEliteAwardCanvas"
	},
	[831] = {
		ui_group = 100,
		prefab = "System/Battle/Result/BattleDataTipsWorldBossEliteCanvas",
		ui_block = 1,
		ui_order = 666,
		id = 831,
		block_alpha = 1,
		ui_type = 5,
		prefabKey = "BattleDataTipsWorldBossEliteCanvas"
	},
	[901] = {
		prefab = "System/TeamSet/TeamSetMainCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 901,
		prefabKey = "TeamSetMainCanvas"
	},
	[902] = {
		ui_group = 104,
		prefab = "System/Common/Tips/HeroTipsCanvas",
		ui_block = 1,
		ui_order = 666,
		id = 902,
		block_alpha = 1,
		ui_type = 5,
		prefabKey = "HeroTipsCanvas"
	},
	[903] = {
		prefab = "System/Common/Tips/HeroTipsSpCanvas",
		ui_group = 40,
		ui_order = 40,
		ui_type = 2,
		id = 903,
		prefabKey = "HeroTipsSpCanvas"
	},
	[999] = {
		id = 999,
		prefab = "Debug/DebugEntry",
		ui_order = 999,
		prefabKey = "DebugEntry"
	},
	[1002] = {
		ui_group = 20,
		prefab = "System/OtherBattle/StageTowerCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 1002,
		shut_down_cam = 1,
		prefabKey = "StageTowerCanvas"
	},
	[1101] = {
		prefab = "System/MainBattle/MainBattleLoadingCanvas",
		ui_group = 120,
		ui_order = 120,
		ui_type = 6,
		id = 1101,
		prefabKey = "MainBattleLoadingCanvas"
	},
	[1201] = {
		ui_group = 20,
		prefab = "System/AVG/AVGTalkCanvas",
		ui_order = 88,
		ui_type = 1,
		id = 1201,
		shut_down_cam = 1,
		prefabKey = "AVGTalkCanvas"
	},
	[1202] = {
		id = 1202,
		prefab = "System/AVG/AVGBlockCanvas",
		ui_type = 4,
		with_state_close = 1,
		ui_order = 84,
		prefabKey = "AVGBlockCanvas"
	},
	[1203] = {
		ui_order = 86,
		prefab = "System/AVG/AVGTalkFramePlayer",
		ui_type = 4,
		id = 1203,
		shut_down_cam = 1,
		prefabKey = "AVGTalkFramePlayer"
	},
	[1204] = {
		id = 1204,
		prefab = "System/AVG/AVGChatEmoCanvas",
		ui_type = 4,
		ui_order = 301,
		prefabKey = "AVGChatEmoCanvas"
	},
	[1205] = {
		id = 1205,
		prefab = "System/AVG/AVGBulletScreenCanvas",
		ui_type = 5,
		ui_order = 666,
		prefabKey = "AVGBulletScreenCanvas"
	},
	[1206] = {
		ui_order = 315,
		prefab = "System/AVG/AVGConfirmBox",
		ui_block = 0,
		ui_type = 4,
		id = 1206,
		block_alpha = 1,
		prefabKey = "AVGConfirmBox"
	},
	[1301] = {
		need_hdr = 1,
		prefab = "System/HeroPool/HeroPoolMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 1301,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "HeroPoolMainCanvas"
	},
	[1302] = {
		prefab = "System/HeroPool/HeroPoolResultCanvas",
		ui_group = 40,
		ui_block = 0,
		ui_order = 40,
		ui_type = 2,
		need_hdr = 1,
		id = 1302,
		block_alpha = 1,
		shut_down_cam = 1,
		prefabKey = "HeroPoolResultCanvas"
	},
	[1304] = {
		ui_group = 20,
		prefab = "System/HeroPool/HeroPoolOpenBox",
		ui_order = 20,
		ui_type = 1,
		id = 1304,
		shut_down_cam = 1,
		prefabKey = "HeroPoolOpenBox"
	},
	[1305] = {
		ui_group = 43,
		prefab = "System/HeroPool/HeroPoolBoxCanvas",
		ui_block = 0,
		ui_order = 43,
		id = 1305,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "HeroPoolBoxCanvas"
	},
	[1306] = {
		ui_group = 20,
		prefab = "System/HeroPool/HeroPoolOpenBoxCanvas2",
		ui_order = 20,
		ui_type = 1,
		id = 1306,
		shut_down_cam = 1,
		prefabKey = "HeroPoolOpenBoxCanvas2"
	},
	[1307] = {
		need_hdr = 1,
		prefab = "System/HeroPool/HeroPoolNewCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 1307,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "HeroPoolNewCanvas"
	},
	[1308] = {
		id = 1308,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/HeroPool/HeroUPCardPreviewCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "HeroUPCardPreviewCanvas"
	},
	[1309] = {
		id = 1309,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/HeroPool/GroupChooseCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "GroupChooseCanvas"
	},
	[1310] = {
		need_hdr = 1,
		prefab = "System/HeroPool/HeroPoolResultGridCanvas",
		ui_group = 40,
		ui_order = 40,
		id = 1310,
		ui_type = 2,
		prefabKey = "HeroPoolResultGridCanvas"
	},
	[1311] = {
		ui_group = 40,
		prefab = "System/HeroPool/HeroPoolWishCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 1311,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "HeroPoolWishCanvas"
	},
	[1312] = {
		ui_group = 40,
		prefab = "System/HeroPool/GroupChooseHeroCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 1312,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "GroupChooseHeroCanvas"
	},
	[1313] = {
		ui_group = 40,
		prefab = "System/HeroPool/HeroProbabilityCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 1313,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "HeroProbabilityCanvas"
	},
	[1314] = {
		prefab = "System/HeroPool/HeroPoolResultCanvas1",
		ui_group = 40,
		ui_block = 0,
		ui_order = 40,
		ui_type = 2,
		need_hdr = 1,
		id = 1314,
		block_alpha = 1,
		shut_down_cam = 1,
		prefabKey = "HeroPoolResultCanvas1"
	},
	[1315] = {
		need_hdr = 1,
		prefab = "System/HeroPool/HeroPoolResultGridCanvas1",
		ui_group = 40,
		ui_order = 40,
		id = 1315,
		ui_type = 2,
		prefabKey = "HeroPoolResultGridCanvas1"
	},
	[1316] = {
		ui_group = 40,
		prefab = "System/HeroPool/HeroPoolNewStoreCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 1316,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "HeroPoolNewStoreCanvas"
	},
	[1317] = {
		id = 1317,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/HeroPool/HeroPoolProbabilityCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "HeroPoolProbabilityCanvas"
	},
	[1318] = {
		id = 1318,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/HeroPool/HeroPoolDrawLogCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "HeroPoolDrawLogCanvas"
	},
	[1319] = {
		ui_group = 40,
		prefab = "System/HeroPool/HeroPoolNewStoreCanvas02",
		ui_block = 0,
		ui_order = 40,
		id = 1319,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "HeroPoolNewStoreCanvas02"
	},
	[1320] = {
		ui_group = 40,
		prefab = "System/HeroPool/SkillStrengthenCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 1320,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "SkillStrengthenCanvas"
	},
	[1321] = {
		ui_group = 40,
		prefab = "System/HeroPool/GroupChooseHeroCanvas2",
		ui_block = 1,
		ui_order = 40,
		id = 1321,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "GroupChooseHeroCanvas2"
	},
	[1322] = {
		ui_group = 40,
		prefab = "System/HeroPool/GroupChooseHeroCanvas3",
		ui_block = 1,
		ui_order = 40,
		id = 1322,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "GroupChooseHeroCanvas3"
	},
	[1323] = {
		ui_group = 40,
		prefab = "System/HeroPool/HeroPoolNewStoreCanvas03",
		ui_block = 0,
		ui_order = 40,
		id = 1323,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "HeroPoolNewStoreCanvas03"
	},
	[1401] = {
		ui_order = 96,
		prefab = "System/Common/ConfirmBox/ConfirmBox1",
		ui_block = 0,
		ui_type = 3,
		id = 1401,
		block_alpha = 1,
		with_state_close = 1,
		prefabKey = "ConfirmBox1"
	},
	[1402] = {
		ui_group = 40,
		prefab = "System/Common/CleanResultCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 1402,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CleanResultCanvas"
	},
	[1403] = {
		ui_group = 85,
		prefab = "System/Common/Tips/RuleCommonRuleTipsCanvas",
		ui_block = 1,
		ui_order = 86,
		id = 1403,
		block_alpha = 1,
		ui_type = 4,
		prefabKey = "RuleCommonRuleTipsCanvas"
	},
	[1405] = {
		ui_group = 40,
		prefab = "System/Common/CleanShowCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 1405,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CleanShowCanvas"
	},
	[1406] = {
		ui_order = 60,
		prefab = "System/Common/ConfirmBox/DeductConfirmBox",
		ui_block = 0,
		ui_type = 3,
		id = 1406,
		block_alpha = 1,
		with_state_close = 1,
		prefabKey = "DeductConfirmBox"
	},
	[1407] = {
		ui_group = 60,
		prefab = "System/Common/Tips/RuleSpeRuleTipsCanvas",
		ui_block = 1,
		ui_order = 60,
		id = 1407,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "RuleSpeRuleTipsCanvas"
	},
	[1408] = {
		ui_group = 40,
		prefab = "System/Common/ShowAwardPrivilegeCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 1408,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ShowAwardPrivilegeCanvas"
	},
	[1409] = {
		ui_group = 60,
		prefab = "System/Common/ConfirmBox/GameEvaluateCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 1409,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "GameEvaluateCanvas"
	},
	[1410] = {
		ui_group = 40,
		prefab = "System/Common/GiftChooseCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 1410,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "GiftChooseCanvas"
	},
	[1411] = {
		ui_order = 96,
		prefab = "System/Common/ConfirmBox/ConfirmBoxToggle",
		ui_block = 0,
		ui_type = 3,
		id = 1411,
		block_alpha = 1,
		prefabKey = "ConfirmBoxToggle"
	},
	[1412] = {
		ui_order = 60,
		prefab = "System/Common/ConfirmBox/DiamondHaveConfirmBox",
		ui_block = 0,
		ui_group = 60,
		ui_type = 3,
		with_state_close = 1,
		id = 1412,
		block_alpha = 1,
		prefabKey = "DiamondHaveConfirmBox"
	},
	[1413] = {
		ui_group = 60,
		prefab = "System/Common/ConfirmBox/CurrencyConvertCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 1413,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "CurrencyConvertCanvas"
	},
	[1414] = {
		ui_group = 60,
		prefab = "System/Common/ConfirmBox/EditAdressCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 1414,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "EditAdressCanvas"
	},
	[1415] = {
		ui_group = 40,
		prefab = "System/AutoChallenge/AutoChallengeCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 1415,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "AutoChallengeCanvas"
	},
	[1416] = {
		ui_group = 85,
		prefab = "System/Common/Tips/RuleWorldBossEliteTipsCanvas",
		ui_block = 1,
		ui_order = 86,
		id = 1416,
		block_alpha = 1,
		ui_type = 4,
		prefabKey = "RuleWorldBossEliteTipsCanvas"
	},
	[1501] = {
		prefab = "System/Chat/ChatMainCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 1501,
		prefabKey = "ChatMainCanvas"
	},
	[1601] = {
		ui_group = 40,
		prefab = "System/SetMainCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 1601,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "SetMainCanvas"
	},
	[1701] = {
		ui_group = 20,
		prefab = "System/MailBox/MailBoxCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 1701,
		shut_down_cam = 1,
		prefabKey = "MailBoxCanvas"
	},
	[1702] = {
		ui_group = 60,
		prefab = "System/MailBox/RewardGetCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 1702,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "RewardGetCanvas"
	},
	[1703] = {
		ui_group = 40,
		prefab = "System/Common/SiftBox/SiftBoxCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 1703,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "SiftBoxCanvas"
	},
	[1704] = {
		id = 1704,
		prefab = "System/Common/FlyIconCanvas",
		ui_type = 4,
		ui_order = 100,
		prefabKey = "FlyIconCanvas"
	},
	[1705] = {
		id = 1705,
		prefab = "System/Common/FlyIcon3DCanvas",
		ui_type = 4,
		ui_order = 0,
		prefabKey = "FlyIcon3DCanvas"
	},
	[1706] = {
		ui_group = 40,
		prefab = "System/Common/BuyCapacityCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 1706,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "BuyCapacityCanvas"
	},
	[1707] = {
		ui_group = 40,
		prefab = "System/Common/ConfirmBox/DownloadConfirmBox",
		ui_block = 0,
		ui_order = 40,
		id = 1707,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "DownloadConfirmBox"
	},
	[1708] = {
		ui_group = 45,
		prefab = "System/Common/ConfirmBox/PlotRewindConfirmBox",
		ui_block = 0,
		ui_order = 666,
		id = 1708,
		block_alpha = 1,
		ui_type = 5,
		prefabKey = "PlotRewindConfirmBox"
	},
	[1800] = {
		ui_group = 20,
		prefab = "System/RechargeTemCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 1800,
		shut_down_cam = 1,
		prefabKey = "RechargeTemCanvas"
	},
	[1801] = {
		ui_group = 60,
		prefab = "System/Common/ConfirmBox/IDConfirmBox",
		ui_block = 0,
		ui_order = 60,
		id = 1801,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "IDConfirmBox"
	},
	[1802] = {
		ui_group = 60,
		prefab = "System/Common/ConfirmBox/GifExchangeConfirmBox",
		ui_block = 0,
		ui_order = 60,
		id = 1802,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "GifExchangeConfirmBox"
	},
	[1803] = {
		prefab = "System/HeroAllCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 1803,
		prefabKey = "HeroAllCanvas"
	},
	[1901] = {
		ui_group = 20,
		prefab = "System/Store/StoreMainCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 1901,
		shut_down_cam = 1,
		prefabKey = "StoreMainCanvas"
	},
	[1902] = {
		ui_group = 45,
		prefab = "System/Store/BuyItemConfirmCanvas",
		ui_block = 0,
		ui_order = 666,
		id = 1902,
		block_alpha = 1,
		ui_type = 5,
		prefabKey = "BuyItemConfirmCanvas"
	},
	[1903] = {
		ui_group = 60,
		prefab = "System/Common/ConfirmBox/ExchangeConfirmBox",
		ui_block = 0,
		ui_order = 60,
		id = 1903,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "ExchangeConfirmBox"
	},
	[1904] = {
		ui_group = 40,
		prefab = "System/Store/StoreMonthCardResultCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 1904,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "StoreMonthCardResultCanvas"
	},
	[1905] = {
		ui_group = 40,
		prefab = "System/Store/RecGiftCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 1905,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "RecGiftCanvas"
	},
	[1906] = {
		ui_group = 40,
		prefab = "System/Store/StoreBPVIPCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 1906,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "StoreBPVIPCanvas"
	},
	[1907] = {
		ui_group = 40,
		prefab = "System/Store/StoreBPSpeedUpCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 1907,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "StoreBPSpeedUpCanvas"
	},
	[1908] = {
		ui_group = 40,
		prefab = "System/Store/StoreBPLvUpCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 1908,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "StoreBPLvUpCanvas"
	},
	[1909] = {
		ui_group = 100,
		prefab = "System/Common/Tips/HeroTipsModelCanvas",
		ui_order = 666,
		ui_type = 5,
		id = 1909,
		shut_down_cam = 1,
		prefabKey = "HeroTipsModelCanvas"
	},
	[1910] = {
		ui_group = 40,
		prefab = "System/Store/FirstRechargeGiftCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 1910,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "FirstRechargeGiftCanvas"
	},
	[1911] = {
		ui_group = 20,
		prefab = "System/Store/RechargeVIPCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 1911,
		shut_down_cam = 1,
		prefabKey = "RechargeVIPCanvas"
	},
	[1912] = {
		id = 1912,
		ui_group = 60,
		ui_block = 1,
		prefab = "System/Store/StoreBPResultCanvas",
		ui_type = 3,
		need_hdr = 1,
		ui_order = 60,
		block_alpha = 1,
		prefabKey = "StoreBPResultCanvas"
	},
	[1913] = {
		id = 1913,
		ui_group = 60,
		ui_block = 1,
		prefab = "System/Store/StoreGiftFundResultCanvas",
		ui_type = 3,
		need_hdr = 1,
		ui_order = 60,
		block_alpha = 1,
		prefabKey = "StoreGiftFundResultCanvas"
	},
	[1914] = {
		id = 1914,
		ui_group = 41,
		ui_block = 1,
		prefab = "System/Store/RecGiftResultCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 61,
		block_alpha = 1,
		prefabKey = "RecGiftResultCanvas"
	},
	[1915] = {
		id = 1915,
		ui_group = 60,
		ui_block = 1,
		prefab = "System/Store/StoreMoneyResultCanvas",
		ui_type = 3,
		need_hdr = 1,
		ui_order = 58,
		block_alpha = 1,
		prefabKey = "StoreMoneyResultCanvas"
	},
	[1916] = {
		ui_group = 45,
		prefab = "System/Store/BuyRelicConfirmCanvas",
		ui_block = 0,
		ui_order = 666,
		id = 1916,
		block_alpha = 1,
		ui_type = 5,
		prefabKey = "BuyRelicConfirmCanvas"
	},
	[1917] = {
		ui_group = 45,
		prefab = "System/Store/BuyRelicPackConfirmCanvas",
		ui_block = 0,
		ui_order = 666,
		id = 1917,
		block_alpha = 1,
		ui_type = 5,
		prefabKey = "BuyRelicPackConfirmCanvas"
	},
	[1918] = {
		id = 1918,
		ui_group = 60,
		ui_block = 1,
		prefab = "System/Store/StoreVIPResultCanvas",
		ui_type = 3,
		need_hdr = 1,
		ui_order = 60,
		block_alpha = 1,
		prefabKey = "StoreVIPResultCanvas"
	},
	[1919] = {
		ui_group = 60,
		prefab = "System/Common/ConfirmBox/ExchangeConfirmBox02",
		ui_block = 1,
		ui_order = 60,
		id = 1919,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "ExchangeConfirmBox02"
	},
	[1920] = {
		ui_group = 40,
		prefab = "System/Store/AddGiftCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 1920,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "AddGiftCanvas"
	},
	[1921] = {
		ui_group = 40,
		prefab = "System/Store/MysteryStoreCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 1921,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "MysteryStoreCanvas"
	},
	[1922] = {
		ui_group = 45,
		prefab = "System/Store/BuyPetGemConfirmCanvas",
		ui_block = 0,
		ui_order = 666,
		id = 1922,
		block_alpha = 1,
		ui_type = 5,
		prefabKey = "BuyPetGemConfirmCanvas"
	},
	[1923] = {
		ui_group = 40,
		prefab = "System/Store/FirstRechargeGiftCanvas2",
		ui_block = 1,
		ui_order = 40,
		id = 1923,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "FirstRechargeGiftCanvas2"
	},
	[1924] = {
		ui_group = 40,
		prefab = "System/Store/AddGiftCanvas2",
		ui_block = 1,
		ui_order = 40,
		id = 1924,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "AddGiftCanvas2"
	},
	[1925] = {
		ui_group = 40,
		prefab = "System/Store/StorePrivilegeAwardCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 1925,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "StorePrivilegeAwardCanvas"
	},
	[1926] = {
		ui_group = 40,
		prefab = "System/Store/FirstRechargeGiftCanvas3",
		ui_block = 1,
		ui_order = 40,
		id = 1926,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "FirstRechargeGiftCanvas3"
	},
	[2001] = {
		id = 2001,
		prefab = "System/Chat/NoticeLampCanvas",
		ui_type = 4,
		ui_order = 82,
		prefabKey = "NoticeLampCanvas"
	},
	[2002] = {
		ui_order = 80,
		prefab = "System/Chat/ChatMainCanvas",
		ui_block = 1,
		with_state_close = 1,
		ui_type = 4,
		need_hdr = 1,
		id = 2002,
		block_alpha = 0,
		prefabKey = "ChatMainCanvas"
	},
	[2003] = {
		ui_order = 81,
		prefab = "System/Chat/ChatEmoCanvas",
		ui_block = 1,
		ui_type = 4,
		id = 2003,
		block_alpha = 0,
		prefabKey = "ChatEmoCanvas"
	},
	[2004] = {
		ui_group = 100,
		prefab = "System/Chat/ChooseFriendCanvas",
		ui_block = 0,
		ui_order = 666,
		id = 2004,
		block_alpha = 1,
		ui_type = 5,
		prefabKey = "ChooseFriendCanvas"
	},
	[2005] = {
		id = 2005,
		prefab = "System/Chat/BulletScreenCanvas",
		ui_type = 4,
		ui_order = 140,
		prefabKey = "BulletScreenCanvas"
	},
	[2006] = {
		ui_group = 40,
		prefab = "System/Chat/RedMoneyChooseCanvas",
		ui_block = 0,
		ui_order = 82,
		id = 2006,
		block_alpha = 1,
		ui_type = 4,
		prefabKey = "RedMoneyChooseCanvas"
	},
	[2007] = {
		ui_group = 40,
		prefab = "System/Chat/RedMoneyReceiveCanvas",
		ui_block = 0,
		ui_order = 84,
		id = 2007,
		block_alpha = 1,
		ui_type = 4,
		prefabKey = "RedMoneyReceiveCanvas"
	},
	[2008] = {
		ui_group = 40,
		prefab = "System/Chat/RedMoney/RedMoneyChooseCanvas",
		ui_block = 0,
		ui_order = 82,
		id = 2008,
		block_alpha = 1,
		ui_type = 4,
		prefabKey = "RedMoneyChooseCanvas"
	},
	[2009] = {
		ui_group = 40,
		prefab = "System/Chat/RedMoney/RedMoneyReceiveCanvas",
		ui_block = 0,
		ui_order = 84,
		id = 2009,
		block_alpha = 1,
		ui_type = 4,
		prefabKey = "RedMoneyReceiveCanvas"
	},
	[2010] = {
		id = 2010,
		prefab = "System/Chat/RedMoneyFireworksEfxCanvas",
		ui_type = 4,
		ui_order = 83,
		prefabKey = "RedMoneyFireworksEfxCanvas"
	},
	[2101] = {
		ui_group = 20,
		prefab = "System/EquipTower/EquipTowerMainCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 2101,
		shut_down_cam = 1,
		prefabKey = "EquipTowerMainCanvas"
	},
	[2102] = {
		ui_group = 20,
		prefab = "System/EquipTower/EquipTowerLvCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 2102,
		shut_down_cam = 1,
		prefabKey = "EquipTowerLvCanvas"
	},
	[2103] = {
		ui_group = 60,
		prefab = "System/EquipTower/EquipTowerMoreAwardCanvas",
		ui_block = 1,
		ui_order = 60,
		id = 2103,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "EquipTowerMoreAwardCanvas"
	},
	[2104] = {
		ui_group = 40,
		prefab = "System/EquipTower/EquipTowerChooseSuitCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2104,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "EquipTowerChooseSuitCanvas"
	},
	[2105] = {
		ui_group = 60,
		prefab = "System/EquipTower/EquipTowerEquipHaveCanvas",
		ui_block = 1,
		ui_order = 60,
		id = 2105,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "EquipTowerEquipHaveCanvas"
	},
	[2106] = {
		ui_group = 40,
		prefab = "System/EquipTower/EquipSuitSpeInquireCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2106,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "EquipSuitSpeInquireCanvas"
	},
	[2201] = {
		ui_group = 20,
		prefab = "System/OneTimeTower/OneTimeTowerCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 2201,
		shut_down_cam = 1,
		prefabKey = "OneTimeTowerCanvas"
	},
	[2202] = {
		ui_group = 60,
		prefab = "System/OneTimeTower/PlayerVideoCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 2202,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "PlayerVideoCanvas"
	},
	[2203] = {
		ui_group = 60,
		prefab = "System/OneTimeTower/OneTimeTowerMonsterCanvas",
		ui_block = 1,
		ui_order = 60,
		id = 2203,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "OneTimeTowerMonsterCanvas"
	},
	[2204] = {
		ui_group = 20,
		prefab = "System/OneTimeTower/OneTimeTowerAttrChooseCanvas",
		ui_block = 0,
		ui_order = 20,
		id = 2204,
		block_alpha = 1,
		ui_type = 1,
		prefabKey = "OneTimeTowerAttrChooseCanvas"
	},
	[2301] = {
		ui_group = 20,
		prefab = "System/AsynPVP/AsynPVPMainCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 2301,
		shut_down_cam = 1,
		prefabKey = "AsynPVPMainCanvas"
	},
	[2302] = {
		ui_group = 40,
		prefab = "System/AsynPVP/AsynPVPRankAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2302,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "AsynPVPRankAwardCanvas"
	},
	[2303] = {
		ui_group = 40,
		prefab = "System/AsynPVP/AsynPVPEnemyCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2303,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "AsynPVPEnemyCanvas"
	},
	[2304] = {
		ui_group = 40,
		prefab = "System/AsynPVP/AsynPVPRecordCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2304,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "AsynPVPRecordCanvas"
	},
	[2305] = {
		prefab = "System/AsynPVP/AsynPVPTeamSetCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 2305,
		prefabKey = "AsynPVPTeamSetCanvas"
	},
	[2306] = {
		need_hdr = 1,
		prefab = "System/AsynPVP/PVPMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 2306,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "PVPMainCanvas"
	},
	[2307] = {
		prefab = "System/AsynPVP/SeniorPVPTeamSetCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 2307,
		prefabKey = "SeniorPVPTeamSetCanvas"
	},
	[2308] = {
		ui_group = 40,
		prefab = "System/AsynPVP/SeniorPVPEditTeamCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 2308,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "SeniorPVPEditTeamCanvas"
	},
	[2309] = {
		prefab = "System/AsynPVP/SeniorPVPMainCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 2309,
		prefabKey = "SeniorPVPMainCanvas"
	},
	[2310] = {
		ui_group = 60,
		prefab = "System/AsynPVP/SeniorPVPCheckTeamCanvas",
		ui_block = 1,
		ui_order = 60,
		id = 2310,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "SeniorPVPCheckTeamCanvas"
	},
	[2311] = {
		ui_group = 40,
		prefab = "System/AsynPVP/SeniorPVPRecordCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2311,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "SeniorPVPRecordCanvas"
	},
	[2312] = {
		ui_group = 60,
		prefab = "System/AsynPVP/SeniorPVPRecordInfoCanvas",
		ui_block = 1,
		ui_order = 60,
		id = 2312,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "SeniorPVPRecordInfoCanvas"
	},
	[2313] = {
		ui_group = 40,
		prefab = "System/AsynPVP/SeniorPVPEnemyCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2313,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "SeniorPVPEnemyCanvas"
	},
	[2401] = {
		ui_group = 20,
		prefab = "System/ChallengeBoss/ChallengeBossMainCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 2401,
		shut_down_cam = 1,
		prefabKey = "ChallengeBossMainCanvas"
	},
	[2402] = {
		ui_group = 20,
		prefab = "System/ChallengeBoss/ChallengeBossLvCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 2402,
		shut_down_cam = 1,
		prefabKey = "ChallengeBossLvCanvas"
	},
	[2404] = {
		ui_group = 40,
		prefab = "System/ChallengeBoss/ChallengeBossAwardNmlCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2404,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ChallengeBossAwardNmlCanvas"
	},
	[2405] = {
		ui_group = 40,
		prefab = "System/ChallengeBoss/ChallengeBossAwardVicCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2405,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ChallengeBossAwardVicCanvas"
	},
	[2406] = {
		ui_group = 40,
		prefab = "System/ChallengeBoss/ChallengeBossAwardCircleCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2406,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ChallengeBossAwardCircleCanvas"
	},
	[2407] = {
		ui_group = 20,
		prefab = "System/ChallengeBoss/NewChallengeBossMainCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 2407,
		shut_down_cam = 1,
		prefabKey = "NewChallengeBossMainCanvas"
	},
	[2408] = {
		need_hdr = 1,
		prefab = "System/ChallengeBoss/NewChallengeBossLvCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 2408,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "NewChallengeBossLvCanvas"
	},
	[2409] = {
		id = 2409,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/ChallengeBoss/ShowNewDifficultCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ShowNewDifficultCanvas"
	},
	[2410] = {
		ui_group = 40,
		prefab = "System/ChallengeBoss/ChallengeBossAwardInfoCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2410,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ChallengeBossAwardInfoCanvas"
	},
	[2501] = {
		prefab = "System/PlayerGuide/PlayerGuideMainCanvas",
		ui_group = 101,
		ui_order = 300,
		ui_type = 4,
		id = 2501,
		prefabKey = "PlayerGuideMainCanvas"
	},
	[2502] = {
		ui_group = 102,
		prefab = "System/PlayerGuide/PlayerGuideTalkCanvas",
		ui_order = 300,
		ui_type = 4,
		id = 2502,
		shut_down_cam = 1,
		prefabKey = "PlayerGuideTalkCanvas"
	},
	[2503] = {
		ui_order = 85,
		prefab = "System/PlayerGuide/PlayerGuidePageCanvas",
		ui_block = 0,
		ui_type = 4,
		id = 2503,
		prefabKey = "PlayerGuidePageCanvas"
	},
	[2504] = {
		id = 2504,
		prefab = "System/PlayerGuide/PlayerGuideDiaCanvas",
		ui_type = 4,
		ui_order = 21,
		prefabKey = "PlayerGuideDiaCanvas"
	},
	[2505] = {
		ui_group = 40,
		prefab = "System/PlayerGuide/CreateCharacterCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2505,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CreateCharacterCanvas"
	},
	[2506] = {
		prefab = "System/PlayerGuide/CreateCharacterResultCanvas",
		ui_group = 40,
		ui_order = 40,
		ui_type = 2,
		id = 2506,
		prefabKey = "CreateCharacterResultCanvas"
	},
	[2507] = {
		ui_group = 40,
		prefab = "System/PlayerGuide/QualitySelectionCanvas",
		ui_block = 0,
		ui_order = 86,
		id = 2507,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "QualitySelectionCanvas"
	},
	[2508] = {
		need_hdr = 1,
		prefab = "System/PlayerGuide/PlayerGuideSetTeamPageCanvas",
		ui_block = 0,
		ui_order = 85,
		id = 2508,
		block_alpha = 1,
		ui_type = 4,
		prefabKey = "PlayerGuideSetTeamPageCanvas"
	},
	[2601] = {
		ui_group = 20,
		prefab = "System/Task/BeginnerTaskCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 2601,
		shut_down_cam = 1,
		prefabKey = "BeginnerTaskCanvas"
	},
	[2602] = {
		need_hdr = 1,
		prefab = "System/Task/TaskMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 2602,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "TaskMainCanvas"
	},
	[2603] = {
		ui_group = 40,
		prefab = "System/Task/PreviewAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2603,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "PreviewAwardCanvas"
	},
	[2604] = {
		prefab = "System/Task/BeginnerTaskBPCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 2604,
		prefabKey = "BeginnerTaskBPCanvas"
	},
	[2605] = {
		ui_group = 40,
		prefab = "System/Task/TaskBPConfirmCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2605,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "TaskBPConfirmCanvas"
	},
	[2606] = {
		ui_group = 40,
		prefab = "System/Task/ChapterPreviewCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2606,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ChapterPreviewCanvas"
	},
	[2701] = {
		ui_group = 20,
		prefab = "System/Friend/FriendCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 2701,
		shut_down_cam = 1,
		prefabKey = "FriendCanvas"
	},
	[2702] = {
		ui_group = 40,
		prefab = "System/Friend/FriendAddCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2702,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "FriendAddCanvas"
	},
	[2703] = {
		ui_group = 40,
		prefab = "System/Friend/FriendRequestCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2703,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "FriendRequestCanvas"
	},
	[2704] = {
		ui_group = 40,
		prefab = "System/Friend/FriendBlackListCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2704,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "FriendBlackListCanvas"
	},
	[2706] = {
		ui_group = 100,
		prefab = "System/Common/Tips/PlayerReportCanvas",
		ui_block = 0,
		ui_order = 666,
		id = 2706,
		block_alpha = 1,
		ui_type = 5,
		prefabKey = "PlayerReportCanvas"
	},
	[2801] = {
		need_hdr = 1,
		prefab = "System/Login/LoginCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 2801,
		ui_type = 1,
		prefabKey = "LoginCanvas"
	},
	[2802] = {
		prefab = "System/Login/PatchCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 2802,
		prefabKey = "PatchCanvas"
	},
	[2803] = {
		ui_group = 60,
		prefab = "System/Login/AccountCenterCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 2803,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "AccountCenterCanvas"
	},
	[2804] = {
		ui_group = 40,
		prefab = "System/Login/AgreementCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2804,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "AgreementCanvas"
	},
	[2805] = {
		ui_group = 40,
		prefab = "System/Login/NoticeCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2805,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "NoticeCanvas"
	},
	[2806] = {
		ui_group = 40,
		prefab = "System/Login/CheckInCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2806,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CheckInCanvas"
	},
	[2807] = {
		ui_group = 40,
		prefab = "System/Login/FlowAccountsCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2807,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "FlowAccountsCanvas"
	},
	[2808] = {
		ui_group = 60,
		prefab = "System/Login/ServerCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 2808,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "ServerCanvas"
	},
	[2809] = {
		ui_group = 40,
		prefab = "System/Login/WaitTipsCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2809,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "WaitTipsCanvas"
	},
	[2811] = {
		ui_group = 40,
		prefab = "System/Common/ConfirmBox/PatchConfirmBox",
		ui_block = 0,
		ui_order = 40,
		id = 2811,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "PatchConfirmBox"
	},
	[2812] = {
		id = 2812,
		prefab = "System/Login/DebugLoginCanvas",
		ui_type = 1,
		ui_order = 30,
		prefabKey = "DebugLoginCanvas"
	},
	[2813] = {
		id = 2813,
		prefab = "System/Login/LoginSuccessCanvas",
		ui_type = 4,
		ui_order = 49,
		prefabKey = "LoginSuccessCanvas"
	},
	[2814] = {
		ui_order = 301,
		prefab = "System/Common/RelinkCanvas",
		ui_block = 0,
		ui_type = 4,
		id = 2814,
		block_alpha = 1,
		prefabKey = "RelinkCanvas"
	},
	[2815] = {
		id = 2815,
		prefab = "System/Common/ReLoginCanvas",
		ui_type = 4,
		ui_order = 301,
		prefabKey = "ReLoginCanvas"
	},
	[2816] = {
		ui_order = 301,
		prefab = "System/Common/RelinkBattleCanvas",
		ui_block = 0,
		ui_type = 4,
		id = 2816,
		block_alpha = 1,
		prefabKey = "RelinkBattleCanvas"
	},
	[2817] = {
		ui_group = 40,
		prefab = "System/Login/AccountBindCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2817,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "AccountBindCanvas"
	},
	[2818] = {
		ui_group = 40,
		prefab = "System/Login/AccountBindInputCanvas",
		ui_block = 0,
		ui_order = 29,
		id = 2818,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "AccountBindInputCanvas"
	},
	[2819] = {
		ui_group = 40,
		prefab = "System/Login/AccountChooseCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2819,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "AccountChooseCanvas"
	},
	[2820] = {
		ui_group = 60,
		prefab = "System/Login/LoginRightConfrimCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 2820,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "LoginRightConfrimCanvas"
	},
	[2821] = {
		ui_group = 40,
		prefab = "System/Login/LoginAgreementConfirmBox",
		ui_block = 0,
		ui_order = 40,
		id = 2821,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "LoginAgreementConfirmBox"
	},
	[2822] = {
		ui_group = 40,
		prefab = "System/Login/PlayerBackCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2822,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "PlayerBackCanvas"
	},
	[2823] = {
		ui_group = 40,
		prefab = "System/Login/LoginChangeZoneCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2823,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "LoginChangeZoneCanvas"
	},
	[2824] = {
		ui_group = 40,
		prefab = "System/Login/AccountLeadCodeCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2824,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "AccountLeadCodeCanvas"
	},
	[2825] = {
		ui_group = 200,
		prefab = "System/Login/AccountInputCodeCanvas",
		ui_block = 0,
		ui_order = 200,
		id = 2825,
		block_alpha = 1,
		ui_type = 5,
		prefabKey = "AccountInputCodeCanvas"
	},
	[2827] = {
		ui_group = 40,
		prefab = "System/Login/AccountSetCodeCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2827,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "AccountSetCodeCanvas"
	},
	[2828] = {
		ui_group = 40,
		prefab = "System/Login/AccountLeadCodeConfirmBox",
		ui_block = 1,
		ui_order = 40,
		id = 2828,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "AccountLeadCodeConfirmBox"
	},
	[2901] = {
		need_state_name = "sMainMaze",
		prefab = "System/Mazz/MazzMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 2901,
		ui_type = 1,
		prefabKey = "MazzMainCanvas"
	},
	[2902] = {
		ui_group = 20,
		prefab = "System/Mazz/MazzHeroCheckCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 2902,
		shut_down_cam = 1,
		prefabKey = "MazzHeroCheckCanvas"
	},
	[2903] = {
		ui_group = 40,
		prefab = "System/Mazz/MazzLvInfoCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 2903,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "MazzLvInfoCanvas"
	},
	[2904] = {
		ui_group = 40,
		prefab = "System/Mazz/MazzHallowChooseCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2904,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "MazzHallowChooseCanvas"
	},
	[2905] = {
		prefab = "System/Mazz/MazzTeamSetCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 2905,
		prefabKey = "MazzTeamSetCanvas"
	},
	[2906] = {
		need_hdr = 1,
		prefab = "System/Mazz/MazzChooseCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 2906,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "MazzChooseCanvas"
	},
	[2907] = {
		ui_group = 40,
		prefab = "System/Mazz/MazzRebornCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2907,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "MazzRebornCanvas"
	},
	[2908] = {
		ui_group = 40,
		prefab = "System/Mazz/MazzFinishCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2908,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "MazzFinishCanvas"
	},
	[2909] = {
		ui_group = 120,
		prefab = "System/Mazz/MazzChangeDiffCanvas",
		ui_order = 120,
		ui_type = 6,
		id = 2909,
		shut_down_cam = 1,
		prefabKey = "MazzChangeDiffCanvas"
	},
	[2910] = {
		ui_group = 60,
		prefab = "System/Mazz/MazzAwardCheckCanvas",
		ui_block = 1,
		ui_order = 60,
		id = 2910,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "MazzAwardCheckCanvas"
	},
	[2911] = {
		ui_group = 40,
		prefab = "System/Mazz/MazzFirstPassCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2911,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "MazzFirstPassCanvas"
	},
	[2912] = {
		ui_group = 40,
		prefab = "System/Mazz/MazzCleanAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2912,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "MazzCleanAwardCanvas"
	},
	[2913] = {
		need_hdr = 1,
		prefab = "System/MazzPet/MazzPetMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 2913,
		ui_type = 1,
		prefabKey = "MazzPetMainCanvas"
	},
	[2914] = {
		id = 2914,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/MazzPet/BattleNmlInfoCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "BattleNmlInfoCanvas"
	},
	[2915] = {
		id = 2915,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/MazzPet/BattleBossInfoCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "BattleBossInfoCanvas"
	},
	[2916] = {
		id = 2916,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/MazzPet/MazzPetAchiCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "MazzPetAchiCanvas"
	},
	[2917] = {
		ui_group = 40,
		prefab = "System/MazzPet/MazzPetResetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 2917,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "MazzPetResetCanvas"
	},
	[2918] = {
		ui_group = 60,
		prefab = "System/MazzPet/MazzPetResetConfirmBox",
		ui_block = 0,
		ui_order = 60,
		id = 2918,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "MazzPetResetConfirmBox"
	},
	[2919] = {
		ui_group = 60,
		prefab = "System/MazzPet/MazzPetBuffPreviewCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 2919,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "MazzPetBuffPreviewCanvas"
	},
	[2920] = {
		ui_group = 60,
		prefab = "System/MazzPet/MazzPetMonsterCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 2920,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "MazzPetMonsterCanvas"
	},
	[2921] = {
		ui_group = 60,
		prefab = "System/MazzPet/MazzPetBossAwardCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 2921,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "MazzPetBossAwardCanvas"
	},
	[2922] = {
		need_hdr = 1,
		prefab = "System/MazzPet/MazzChooseMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 2922,
		ui_type = 1,
		prefabKey = "MazzChooseMainCanvas"
	},
	[2923] = {
		ui_group = 40,
		prefab = "System/MazzPet/MazzPetCleanAwardCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 2923,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "MazzPetCleanAwardCanvas"
	},
	[3001] = {
		need_state_name = "sMainRearHouse",
		prefab = "System/Backyard/BackyardMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 3001,
		ui_type = 1,
		prefabKey = "BackyardMainCanvas"
	},
	[3002] = {
		prefab = "System/Backyard/BackyardEditCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 3002,
		prefabKey = "BackyardEditCanvas"
	},
	[3003] = {
		ui_group = 40,
		prefab = "System/Backyard/BackyardLvUpCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 3003,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "BackyardLvUpCanvas"
	},
	[3004] = {
		ui_group = 42,
		prefab = "System/Backyard/BackyardUnlockCanvas",
		ui_block = 0,
		ui_order = 42,
		id = 3004,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "BackyardUnlockCanvas"
	},
	[3005] = {
		ui_group = 40,
		prefab = "System/Backyard/BackyardCrystalInfoCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 3005,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "BackyardCrystalInfoCanvas"
	},
	[3006] = {
		ui_group = 20,
		prefab = "System/Backyard/BackyardStoreCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 3006,
		shut_down_cam = 1,
		prefabKey = "BackyardStoreCanvas"
	},
	[3007] = {
		ui_group = 40,
		prefab = "System/Backyard/BackyardCrystalLvCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3007,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "BackyardCrystalLvCanvas"
	},
	[3008] = {
		ui_group = 40,
		prefab = "System/Backyard/BackyardCrystalResultCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3008,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "BackyardCrystalResultCanvas"
	},
	[3009] = {
		ui_group = 40,
		prefab = "System/Backyard/BackyardDispatchCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3009,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "BackyardDispatchCanvas"
	},
	[3010] = {
		ui_group = 60,
		prefab = "System/Backyard/BackyardDispatchInfoCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 3010,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "BackyardDispatchInfoCanvas"
	},
	[3011] = {
		ui_group = 60,
		prefab = "System/Backyard/BackyardAdditionalCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 3011,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "BackyardAdditionalCanvas"
	},
	[3012] = {
		id = 3012,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/Backyard/BackyardComfortableCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "BackyardComfortableCanvas"
	},
	[3013] = {
		ui_group = 40,
		prefab = "System/Backyard/BackyardCleanCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3013,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "BackyardCleanCanvas"
	},
	[3014] = {
		ui_group = 60,
		prefab = "System/Backyard/BackyardCleanAwardCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 3014,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "BackyardCleanAwardCanvas"
	},
	[3015] = {
		prefab = "System/Backyard/BackyardOthersCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 3015,
		prefabKey = "BackyardOthersCanvas"
	},
	[3016] = {
		ui_group = 40,
		prefab = "System/Backyard/BackyardVisitCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3016,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "BackyardVisitCanvas"
	},
	[3017] = {
		ui_order = 100,
		prefab = "System/Backyard/BackyardLoadingCanvas",
		ui_type = 4,
		id = 3017,
		shut_down_cam = 1,
		prefabKey = "BackyardLoadingCanvas"
	},
	[3018] = {
		ui_group = 40,
		prefab = "System/Backyard/BackyardAttrCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 3018,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "BackyardAttrCanvas"
	},
	[3019] = {
		ui_group = 42,
		prefab = "System/Backyard/BackyardUnlockAttrCanvas",
		ui_block = 0,
		ui_order = 42,
		id = 3019,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "BackyardUnlockAttrCanvas"
	},
	[3020] = {
		id = 3020,
		ui_group = 20,
		ui_block = 1,
		prefab = "System/Backyard/BackyardCrystalLvUpCanvas",
		ui_type = 1,
		need_hdr = 1,
		ui_order = 20,
		block_alpha = 1,
		prefabKey = "BackyardCrystalLvUpCanvas"
	},
	[3021] = {
		id = 3021,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/Backyard/BackyardCollectAchiCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "BackyardCollectAchiCanvas"
	},
	[3022] = {
		id = 3022,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Backyard/BackyardCrystalLvUpResultCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "BackyardCrystalLvUpResultCanvas"
	},
	[3023] = {
		id = 3023,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/Backyard/BackyardCrystalLvUpAwardCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "BackyardCrystalLvUpAwardCanvas"
	},
	[3024] = {
		ui_group = 20,
		prefab = "System/Backyard/BackyardPopularityAwardCanvas",
		ui_block = 0,
		ui_order = 20,
		id = 3024,
		block_alpha = 1,
		ui_type = 1,
		prefabKey = "BackyardPopularityAwardCanvas"
	},
	[3025] = {
		ui_group = 60,
		prefab = "System/Backyard/CommentCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 3025,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "CommentCanvas"
	},
	[3101] = {
		ui_group = 40,
		prefab = "System/Rank/RankingCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3101,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "RankingCanvas"
	},
	[3102] = {
		ui_group = 60,
		prefab = "System/Rank/RankingRuleCanvas",
		ui_block = 1,
		ui_order = 60,
		id = 3102,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "RankingRuleCanvas"
	},
	[3103] = {
		ui_group = 60,
		prefab = "System/Rank/RankingAwardCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 3103,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "RankingAwardCanvas"
	},
	[3201] = {
		ui_group = 20,
		prefab = "System/HandBook/HandBookMainCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 3201,
		shut_down_cam = 1,
		prefabKey = "HandBookMainCanvas"
	},
	[3202] = {
		ui_group = 20,
		prefab = "System/HandBook/HandBookHeroListCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 3202,
		shut_down_cam = 1,
		prefabKey = "HandBookHeroListCanvas"
	},
	[3203] = {
		ui_group = 20,
		prefab = "System/HandBook/HandBookHeroInfoCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 3203,
		shut_down_cam = 1,
		prefabKey = "HandBookHeroInfoCanvas"
	},
	[3204] = {
		ui_group = 20,
		prefab = "System/HandBook/HandBookBadgeCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 3204,
		shut_down_cam = 1,
		prefabKey = "HandBookBadgeCanvas"
	},
	[3205] = {
		ui_group = 20,
		prefab = "System/HandBook/HandBookAwardCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 3205,
		shut_down_cam = 1,
		prefabKey = "HandBookAwardCanvas"
	},
	[3206] = {
		ui_group = 20,
		prefab = "System/HandBook/HandBookRankSelectCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 3206,
		shut_down_cam = 1,
		prefabKey = "HandBookRankSelectCanvas"
	},
	[3207] = {
		ui_group = 20,
		prefab = "System/HandBook/HandBookRankInfoCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 3207,
		shut_down_cam = 1,
		prefabKey = "HandBookRankInfoCanvas"
	},
	[3208] = {
		prefab = "System/HandBook/HandBookTeamOverviewCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 3208,
		prefabKey = "HandBookTeamOverviewCanvas"
	},
	[3209] = {
		need_hdr = 1,
		prefab = "System/HandBook/HandBookTeamDetailCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 3209,
		ui_type = 1,
		prefabKey = "HandBookTeamDetailCanvas"
	},
	[3210] = {
		id = 3210,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/HandBook/HandBookTeamGetGPCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "HandBookTeamGetGPCanvas"
	},
	[3211] = {
		id = 3211,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/HandBook/HandBookTeamUpgradeCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "HandBookTeamUpgradeCanvas"
	},
	[3212] = {
		prefab = "System/HandBook/HandBookPlotRewindCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 3212,
		prefabKey = "HandBookPlotRewindCanvas"
	},
	[3213] = {
		need_hdr = 1,
		prefab = "System/HandBook/HandBookPlotMainLineCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 3213,
		ui_type = 1,
		prefabKey = "HandBookPlotMainLineCanvas"
	},
	[3214] = {
		need_hdr = 1,
		prefab = "System/HandBook/HandBookPlotSideLineCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 3214,
		ui_type = 1,
		prefabKey = "HandBookPlotSideLineCanvas"
	},
	[3215] = {
		id = 3215,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/HandBook/HandBookPlotStoryListCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "HandBookPlotStoryListCanvas"
	},
	[3216] = {
		ui_group = 60,
		prefab = "System/HandBook/HandBookShowAvgCanvas",
		ui_block = 1,
		ui_order = 60,
		id = 3216,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "HandBookShowAvgCanvas"
	},
	[3217] = {
		ui_group = 20,
		prefab = "System/HandBook/HandBookAchievementCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 3217,
		shut_down_cam = 1,
		prefabKey = "HandBookAchievementCanvas"
	},
	[3218] = {
		ui_group = 104,
		prefab = "System/HandBook/AchievementTipsCanvas",
		ui_block = 1,
		ui_order = 666,
		id = 3218,
		block_alpha = 1,
		ui_type = 6,
		prefabKey = "AchievementTipsCanvas"
	},
	[3219] = {
		prefab = "System/HandBook/HandBookTeamPatchCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 3219,
		prefabKey = "HandBookTeamPatchCanvas"
	},
	[3220] = {
		id = 3220,
		ui_group = 60,
		ui_block = 1,
		prefab = "System/HandBook/HandBookTeamPatchSelectCanvas",
		ui_type = 3,
		need_hdr = 1,
		ui_order = 60,
		block_alpha = 1,
		prefabKey = "HandBookTeamPatchSelectCanvas"
	},
	[3221] = {
		ui_group = 20,
		prefab = "System/HandBook/HandBookRankSelectCanvas1",
		ui_order = 20,
		ui_type = 1,
		id = 3221,
		shut_down_cam = 1,
		prefabKey = "HandBookRankSelectCanvas1"
	},
	[3222] = {
		ui_group = 40,
		prefab = "System/HandBook/RankSelectRequestCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3222,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "RankSelectRequestCanvas"
	},
	[3223] = {
		ui_group = 40,
		prefab = "System/HandBook/RankSelectTeacherAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3223,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "RankSelectTeacherAwardCanvas"
	},
	[3224] = {
		ui_group = 40,
		prefab = "System/HandBook/RankSelectStudentAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3224,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "RankSelectStudentAwardCanvas"
	},
	[3225] = {
		ui_group = 40,
		prefab = "System/HandBook/RankSelectGuideCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3225,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "RankSelectGuideCanvas"
	},
	[3301] = {
		ui_order = 64,
		prefab = "System/Common/GetNewHeroCanvas",
		ui_block = 1,
		ui_group = 41,
		ui_type = 2,
		id = 3301,
		block_alpha = 0,
		shut_down_cam = 1,
		prefabKey = "GetNewHeroCanvas"
	},
	[3302] = {
		id = 3302,
		ui_group = 60,
		ui_block = 1,
		prefab = "System/Common/ShowAwardCanvas",
		ui_type = 3,
		logic_flag = 1,
		ui_order = 60,
		block_alpha = 1,
		prefabKey = "ShowAwardCanvas"
	},
	[3303] = {
		id = 3303,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Common/ShowHeroCardCanvas",
		ui_type = 2,
		logic_flag = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ShowHeroCardCanvas"
	},
	[3304] = {
		ui_order = 61,
		prefab = "System/Common/GetNewSkinCanvas",
		ui_block = 1,
		ui_group = 41,
		ui_type = 2,
		id = 3304,
		block_alpha = 0,
		shut_down_cam = 1,
		prefabKey = "GetNewSkinCanvas"
	},
	[3305] = {
		id = 3305,
		ui_group = 60,
		ui_block = 1,
		prefab = "System/Common/ShowAwardHigherCanvas",
		ui_type = 4,
		logic_flag = 1,
		ui_order = 83,
		block_alpha = 1,
		prefabKey = "ShowAwardHigherCanvas"
	},
	[3306] = {
		ui_group = 40,
		prefab = "System/Common/PreviewAwardCommonCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 3306,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "PreviewAwardCommonCanvas"
	},
	[3307] = {
		ui_group = 40,
		prefab = "System/Common/ActivityAchiDiceCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3307,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityAchiDiceCanvas"
	},
	[3308] = {
		ui_order = 64,
		prefab = "System/Common/GetNewPetCanvas",
		ui_block = 1,
		ui_group = 41,
		ui_type = 2,
		id = 3308,
		block_alpha = 0,
		shut_down_cam = 1,
		prefabKey = "GetNewPetCanvas"
	},
	[3401] = {
		ui_group = 20,
		prefab = "System/StarUp/HeroStarUpCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 3401,
		shut_down_cam = 1,
		prefabKey = "HeroStarUpCanvas"
	},
	[3402] = {
		ui_group = 40,
		prefab = "System/StarUp/HeroStarUpInfoCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3402,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "HeroStarUpInfoCanvas"
	},
	[3403] = {
		ui_group = 40,
		prefab = "System/StarUp/HeroStarUpFinishCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 3403,
		block_alpha = 0,
		ui_type = 2,
		prefabKey = "HeroStarUpFinishCanvas"
	},
	[3404] = {
		ui_order = 40,
		prefab = "System/StarUp/HeroStarUpFastCanvas",
		ui_block = 0,
		ui_group = 40,
		ui_type = 2,
		id = 3404,
		block_alpha = 1,
		shut_down_cam = 1,
		prefabKey = "HeroStarUpFastCanvas"
	},
	[3405] = {
		need_hdr = 1,
		prefab = "System/StarUp/HeroStarUpAnimationCanvas",
		ui_group = 42,
		ui_order = 50,
		id = 3405,
		ui_type = 2,
		shut_down_cam = 1,
		prefabKey = "HeroStarUpAnimationCanvas"
	},
	[3406] = {
		ui_order = 45,
		prefab = "System/StarUp/StarUpUnlockCanvas",
		ui_block = 1,
		ui_group = 41,
		ui_type = 2,
		id = 3406,
		block_alpha = 1,
		shut_down_cam = 1,
		prefabKey = "StarUpUnlockCanvas"
	},
	[3407] = {
		ui_group = 40,
		prefab = "System/StarUp/HeroStarUpRevertCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3407,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "HeroStarUpRevertCanvas"
	},
	[3408] = {
		ui_group = 60,
		prefab = "System/StarUp/StarUpRevertGuideCanvas",
		ui_block = 1,
		ui_order = 60,
		id = 3408,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "StarUpRevertGuideCanvas"
	},
	[3501] = {
		ui_group = 40,
		prefab = "System/Bag/OpenBoxChooseCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 3501,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "OpenBoxChooseCanvas"
	},
	[3502] = {
		ui_group = 40,
		prefab = "System/Bag/OpenBoxChoose02Canvas",
		ui_block = 1,
		ui_order = 40,
		id = 3502,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "OpenBoxChoose02Canvas"
	},
	[3601] = {
		ui_group = 42,
		prefab = "System/PlayerInfor/PlayerInforPersonalCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 3601,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "PlayerInforPersonalCanvas"
	},
	[3602] = {
		ui_group = 103,
		prefab = "System/PlayerInfor/PlayerInforOtherCanvas",
		ui_block = 1,
		ui_order = 666,
		id = 3602,
		block_alpha = 1,
		ui_type = 5,
		prefabKey = "PlayerInforOtherCanvas"
	},
	[3603] = {
		ui_group = 60,
		prefab = "System/PlayerInfor/EditNameCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 3603,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "EditNameCanvas"
	},
	[3604] = {
		ui_group = 60,
		prefab = "System/PlayerInfor/EditSexCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 3604,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "EditSexCanvas"
	},
	[3605] = {
		ui_group = 60,
		prefab = "System/PlayerInfor/EditSignCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 3605,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "EditSignCanvas"
	},
	[3606] = {
		id = 3606,
		prefab = "System/PlayerInfor/PlayerInforHeroCanvas",
		ui_type = 5,
		ui_order = 666,
		prefabKey = "PlayerInforHeroCanvas"
	},
	[3607] = {
		ui_group = 60,
		prefab = "System/PlayerInfor/EditPlayerHeadCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 3607,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "EditPlayerHeadCanvas"
	},
	[3608] = {
		ui_order = 82,
		prefab = "System/PlayerInfor/EditPlayerHeadAttrInfoCanvas",
		ui_block = 1,
		ui_type = 4,
		id = 3608,
		block_alpha = 1,
		prefabKey = "EditPlayerHeadAttrInfoCanvas"
	},
	[3701] = {
		ui_group = 20,
		prefab = "System/Circle/CircleListCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 3701,
		shut_down_cam = 1,
		prefabKey = "CircleListCanvas"
	},
	[3702] = {
		ui_order = 86,
		prefab = "System/Circle/ShowCircleCanvas",
		ui_block = 0,
		ui_type = 4,
		id = 3702,
		block_alpha = 1,
		prefabKey = "ShowCircleCanvas"
	},
	[3703] = {
		ui_group = 60,
		prefab = "System/Circle/CreateCircleCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 3703,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "CreateCircleCanvas"
	},
	[3704] = {
		ui_group = 20,
		prefab = "System/Circle/CircleMainCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 3704,
		shut_down_cam = 1,
		prefabKey = "CircleMainCanvas"
	},
	[3705] = {
		ui_group = 40,
		prefab = "System/Circle/EditCircleHeadCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3705,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "EditCircleHeadCanvas"
	},
	[3706] = {
		ui_group = 40,
		prefab = "System/Circle/EditCircleNameCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3706,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "EditCircleNameCanvas"
	},
	[3707] = {
		ui_group = 40,
		prefab = "System/Circle/EditNoticeCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3707,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "EditNoticeCanvas"
	},
	[3708] = {
		ui_group = 40,
		prefab = "System/Circle/AppointCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3708,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "AppointCanvas"
	},
	[3709] = {
		ui_group = 40,
		prefab = "System/Circle/ExitCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3709,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ExitCanvas"
	},
	[3710] = {
		ui_group = 40,
		prefab = "System/Circle/EditCircleMailCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3710,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "EditCircleMailCanvas"
	},
	[3711] = {
		ui_group = 40,
		prefab = "System/Circle/CircleAchievementCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3711,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CircleAchievementCanvas"
	},
	[3712] = {
		ui_group = 60,
		prefab = "System/Circle/EditCircleHeadNewCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 3712,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "EditCircleHeadNewCanvas"
	},
	[3713] = {
		ui_group = 40,
		prefab = "System/Circle/CircleInviteInfoCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3713,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CircleInviteInfoCanvas"
	},
	[3714] = {
		ui_group = 60,
		prefab = "System/Circle/EditCircleShareCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 3714,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "EditCircleShareCanvas"
	},
	[3801] = {
		id = 3801,
		ui_group = 20,
		ui_block = 1,
		prefab = "System/Activity/ActivityMainCanvas",
		ui_type = 1,
		need_hdr = 1,
		ui_order = 20,
		block_alpha = 1,
		prefabKey = "ActivityMainCanvas"
	},
	[3802] = {
		ui_group = 20,
		prefab = "System/Activity/ActivityMonopoly/ActivityMonopolyMainCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 3802,
		shut_down_cam = 1,
		prefabKey = "ActivityMonopolyMainCanvas"
	},
	[3803] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityMonopoly/ActivityMonopolyAchiCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 3803,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityMonopolyAchiCanvas"
	},
	[3804] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityMonopoly/ActivityMonopolyRandomCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 3804,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityMonopolyRandomCanvas"
	},
	[3805] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityMonopoly/ActivityMonopolyDiceCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3805,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityMonopolyDiceCanvas"
	},
	[3806] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityMonopoly/ActivityMonopolyBadLuckCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 3806,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityMonopolyBadLuckCanvas"
	},
	[3807] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityMonopoly/ActivityMonopolyBuyDiceCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3807,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityMonopolyBuyDiceCanvas"
	},
	[3808] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityMonopoly/ActivityMonopolyGoodLuckCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 3808,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityMonopolyGoodLuckCanvas"
	},
	[3809] = {
		ui_group = 20,
		prefab = "System/Activity/ActivityStoreMainCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 3809,
		shut_down_cam = 1,
		prefabKey = "ActivityStoreMainCanvas"
	},
	[3810] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityBingo/ActivityBingoMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 3810,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityBingoMainCanvas"
	},
	[3811] = {
		id = 3811,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Activity/ActivityBingo/ActivityBingoAwardCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivityBingoAwardCanvas"
	},
	[3812] = {
		id = 3812,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/Activity/ActivityBingo/ActivityBingoEfxCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 0,
		prefabKey = "ActivityBingoEfxCanvas"
	},
	[3813] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityBingo/ActivityBingoFinalAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3813,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityBingoFinalAwardCanvas"
	},
	[3814] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityFlot/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 3814,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[3815] = {
		ui_group = 20,
		prefab = "System/Activity/ActivityFlot/ActivityFlotInfoCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 3815,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotInfoCanvas"
	},
	[3816] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityFlot/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 3816,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[3817] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityFlot/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3817,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[3818] = {
		prefab = "System/Activity/ActivityFlot/BattleResultActivityFlotWinCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 3818,
		prefabKey = "BattleResultActivityFlotWinCanvas"
	},
	[3819] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlotCommon/ActivityCleanAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3819,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityCleanAwardCanvas"
	},
	[3820] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14201/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 3820,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[3821] = {
		id = 3821,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Activity/ActivityOpenAchiCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivityOpenAchiCanvas"
	},
	[3822] = {
		ui_group = 20,
		prefab = "System/Activity/ActivityPlot14201/ActivityFlotInfoCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 3822,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotInfoCanvas"
	},
	[3823] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14201/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 3823,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[3824] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot14201/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3824,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[3825] = {
		prefab = "System/Activity/ActivityBingo2/ActivityBingoMainCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 3825,
		prefabKey = "ActivityBingoMainCanvas"
	},
	[3826] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityBingo2/ActivityBingoAwardCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 3826,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityBingoAwardCanvas"
	},
	[3827] = {
		id = 3827,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/Activity/ActivityBingo2/ActivityBingoEfxCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 0,
		prefabKey = "ActivityBingoEfxCanvas"
	},
	[3828] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityBingo2/ActivityBingoFinalAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3828,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityBingoFinalAwardCanvas"
	},
	[3829] = {
		ui_group = 20,
		prefab = "System/Activity/ActivityMonopoly2/ActivityMonopolyMainCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 3829,
		shut_down_cam = 1,
		prefabKey = "ActivityMonopolyMainCanvas"
	},
	[3830] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityMonopoly2/ActivityMonopolyAchiCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 3830,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityMonopolyAchiCanvas"
	},
	[3831] = {
		ui_group = 60,
		prefab = "System/Activity/ActivityDoubleEleven/ActivityPrizeCodeCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 3831,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "ActivityPrizeCodeCanvas"
	},
	[3832] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityBingo3/ActivityBingoMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 3832,
		ui_type = 1,
		prefabKey = "ActivityBingoMainCanvas"
	},
	[3833] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityBingo3/ActivityBingoAwardCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 3833,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityBingoAwardCanvas"
	},
	[3834] = {
		id = 3834,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/Activity/ActivityBingo3/ActivityBingoEfxCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 0,
		prefabKey = "ActivityBingoEfxCanvas"
	},
	[3835] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityBingo3/ActivityBingoFinalAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3835,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityBingoFinalAwardCanvas"
	},
	[3836] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14012/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 3836,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[3837] = {
		ui_group = 20,
		prefab = "System/Activity/ActivityPlot14012/ActivityFlotInfoCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 3837,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotInfoCanvas"
	},
	[3838] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14012/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 3838,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[3839] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot14012/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3839,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[3840] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot14012/ActivityCleanAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3840,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityCleanAwardCanvas"
	},
	[3841] = {
		ui_group = 40,
		prefab = "System/Activity/ReturnSignInCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3841,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ReturnSignInCanvas"
	},
	[3842] = {
		ui_group = 40,
		prefab = "System/Activity/SignInWishCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3842,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "SignInWishCanvas"
	},
	[3843] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityTokenStoreAchiCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 3843,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityTokenStoreAchiCanvas"
	},
	[3844] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityBingo4/ActivityBingoMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 3844,
		ui_type = 1,
		prefabKey = "ActivityBingoMainCanvas"
	},
	[3845] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityBingo4/ActivityBingoAwardCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 3845,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityBingoAwardCanvas"
	},
	[3846] = {
		id = 3846,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/Activity/ActivityBingo4/ActivityBingoEfxCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 0,
		prefabKey = "ActivityBingoEfxCanvas"
	},
	[3847] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityBingo4/ActivityBingoFinalAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3847,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityBingoFinalAwardCanvas"
	},
	[3848] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14011/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 3848,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[3849] = {
		ui_group = 20,
		prefab = "System/Activity/ActivityPlot14011/ActivityFlotInfoCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 3849,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotInfoCanvas"
	},
	[3850] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14011/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 3850,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[3851] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot14011/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3851,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[3852] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot14011/ActivityCleanAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3852,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityCleanAwardCanvas"
	},
	[3853] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityBingo5/ActivityBingoMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 3853,
		ui_type = 1,
		prefabKey = "ActivityBingoMainCanvas"
	},
	[3854] = {
		id = 3854,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Activity/ActivityBingo5/ActivityBingoAwardCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivityBingoAwardCanvas"
	},
	[3855] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityBingo5/ActivityBingoEfxCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3855,
		block_alpha = 0,
		ui_type = 2,
		prefabKey = "ActivityBingoEfxCanvas"
	},
	[3856] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityBingo5/ActivityBingoFinalAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3856,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityBingoFinalAwardCanvas"
	},
	[3857] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot12012/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 3857,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[3858] = {
		ui_group = 20,
		prefab = "System/Activity/ActivityPlot12012/ActivityFlotInfoCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 3858,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotInfoCanvas"
	},
	[3859] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot12012/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 3859,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[3860] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot12012/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3860,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[3861] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot12012/ActivityCleanAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3861,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityCleanAwardCanvas"
	},
	[3862] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot11010/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 3862,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[3863] = {
		ui_group = 20,
		prefab = "System/Activity/ActivityPlot11010/ActivityFlotInfoCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 3863,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotInfoCanvas"
	},
	[3864] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot11010/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 3864,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[3865] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot11010/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3865,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[3866] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot11010/ActivityCleanAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3866,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityCleanAwardCanvas"
	},
	[3867] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityNewYearEve/ActivityNewYearEveMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 3867,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityNewYearEveMainCanvas"
	},
	[3868] = {
		id = 3868,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/Activity/ActivityNewYearEve/ActivityEveKitchenLevelCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivityEveKitchenLevelCanvas"
	},
	[3869] = {
		id = 3869,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/Activity/ActivityNewYearEve/ActivityEveAvgPreviewCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivityEveAvgPreviewCanvas"
	},
	[3870] = {
		id = 3870,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Activity/ActivityNewYearEve/ActivityEveAwardCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivityEveAwardCanvas"
	},
	[3871] = {
		id = 3871,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Activity/ActivityNewYearEve/ActivityEveUpLevelCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivityEveUpLevelCanvas"
	},
	[3872] = {
		id = 3872,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/Activity/ActivityNewYearEve/ActivityEveSpeedUpCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivityEveSpeedUpCanvas"
	},
	[3873] = {
		ui_group = 45,
		prefab = "System/Activity/ActivityPrivilegePreviewCanvas",
		ui_block = 1,
		ui_order = 666,
		id = 3873,
		block_alpha = 1,
		ui_type = 5,
		prefabKey = "ActivityPrivilegePreviewCanvas"
	},
	[3874] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityBingo6/ActivityBingoMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 3874,
		ui_type = 1,
		prefabKey = "ActivityBingoMainCanvas"
	},
	[3875] = {
		id = 3875,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Activity/ActivityBingo6/ActivityBingoAwardCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivityBingoAwardCanvas"
	},
	[3876] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityBingo6/ActivityBingoEfxCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3876,
		block_alpha = 0,
		ui_type = 2,
		prefabKey = "ActivityBingoEfxCanvas"
	},
	[3877] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityBingo6/ActivityBingoFinalAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3877,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityBingoFinalAwardCanvas"
	},
	[3878] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityMiKuConcert/ActivityMiKuConcertMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 3878,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityMiKuConcertMainCanvas"
	},
	[3879] = {
		id = 3879,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/Activity/ActivityMiKuConcert/ActivityMiKuCumulativeCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivityMiKuCumulativeCanvas"
	},
	[3880] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityBingo7/ActivityBingoMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 3880,
		ui_type = 1,
		prefabKey = "ActivityBingoMainCanvas"
	},
	[3881] = {
		id = 3881,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Activity/ActivityBingo7/ActivityBingoAwardCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivityBingoAwardCanvas"
	},
	[3882] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityBingo7/ActivityBingoEfxCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3882,
		block_alpha = 0,
		ui_type = 2,
		prefabKey = "ActivityBingoEfxCanvas"
	},
	[3883] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityBingo7/ActivityBingoFinalAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3883,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityBingoFinalAwardCanvas"
	},
	[3884] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot13103/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 3884,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[3885] = {
		ui_group = 20,
		prefab = "System/Activity/ActivityPlot13103/ActivityFlotInfoCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 3885,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotInfoCanvas"
	},
	[3886] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot13103/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 3886,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[3887] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot13103/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3887,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[3888] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot13103/ActivityCleanAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3888,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityCleanAwardCanvas"
	},
	[3889] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot14201/ActivityCleanAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3889,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityCleanAwardCanvas"
	},
	[3890] = {
		ui_group = 20,
		prefab = "System/Activity/ActivityMonopoly3/ActivityMonopolyMainCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 3890,
		shut_down_cam = 1,
		prefabKey = "ActivityMonopolyMainCanvas"
	},
	[3891] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityMonopoly3/ActivityMonopolyRandomCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 3891,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityMonopolyRandomCanvas"
	},
	[3892] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityMonopoly3/ActivityMonopolyDiceCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3892,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityMonopolyDiceCanvas"
	},
	[3893] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityMonopoly3/ActivityMonopolyBadLuckCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 3893,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityMonopolyBadLuckCanvas"
	},
	[3894] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityMonopoly3/ActivityMonopolyBuyDiceCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 3894,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityMonopolyBuyDiceCanvas"
	},
	[3895] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityMonopoly3/ActivityMonopolyGoodLuckCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 3895,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityMonopolyGoodLuckCanvas"
	},
	[3896] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityMonopoly3/ActivityMonopolyAwardChooseCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 3896,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityMonopolyAwardChooseCanvas"
	},
	[3897] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityAIChannelLive/ActivityAIChannelLiveMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 3897,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityAIChannelLiveMainCanvas"
	},
	[3898] = {
		id = 3898,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/Activity/ActivityAIChannelLive/ActivityAICumulativeCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivityAICumulativeCanvas"
	},
	[3899] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityMonopoly2/ActivityMonopolyAwardCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 3899,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityMonopolyAwardCanvas"
	},
	[3901] = {
		prefab = "System/GetLightBlackHero/GetLightBlackHeroCanvas212201",
		ui_group = 41,
		ui_block = 0,
		ui_order = 61,
		ui_type = 2,
		need_hdr = 1,
		id = 3901,
		block_alpha = 0,
		shut_down_cam = 1,
		prefabKey = "GetLightBlackHeroCanvas212201"
	},
	[3902] = {
		prefab = "System/GetLightBlackHero/GetLightBlackHeroCanvas211201",
		ui_group = 41,
		ui_block = 0,
		ui_order = 61,
		ui_type = 2,
		need_hdr = 1,
		id = 3902,
		block_alpha = 0,
		shut_down_cam = 1,
		prefabKey = "GetLightBlackHeroCanvas211201"
	},
	[3903] = {
		prefab = "System/GetLightBlackHero/GetLightBlackHeroCanvas213201",
		ui_group = 41,
		ui_block = 0,
		ui_order = 61,
		ui_type = 2,
		need_hdr = 1,
		id = 3903,
		block_alpha = 0,
		shut_down_cam = 1,
		prefabKey = "GetLightBlackHeroCanvas213201"
	},
	[3904] = {
		prefab = "System/GetLightBlackHero/GetLightBlackHeroCanvas214201",
		ui_group = 41,
		ui_block = 0,
		ui_order = 61,
		ui_type = 2,
		need_hdr = 1,
		id = 3904,
		block_alpha = 0,
		shut_down_cam = 1,
		prefabKey = "GetLightBlackHeroCanvas214201"
	},
	[3905] = {
		prefab = "System/GetLightBlackHero/GetLightBlackHeroCanvas215201",
		ui_group = 41,
		ui_block = 0,
		ui_order = 61,
		ui_type = 2,
		need_hdr = 1,
		id = 3905,
		block_alpha = 0,
		shut_down_cam = 1,
		prefabKey = "GetLightBlackHeroCanvas215201"
	},
	[3906] = {
		prefab = "System/GetLightBlackHero/GetLightBlackHeroCanvas213202",
		ui_group = 41,
		ui_block = 0,
		ui_order = 61,
		ui_type = 2,
		need_hdr = 1,
		id = 3906,
		block_alpha = 0,
		shut_down_cam = 1,
		prefabKey = "GetLightBlackHeroCanvas213202"
	},
	[3907] = {
		prefab = "System/GetLightBlackHero/GetLightBlackHeroCanvas212203",
		ui_group = 41,
		ui_block = 0,
		ui_order = 61,
		ui_type = 2,
		need_hdr = 1,
		id = 3907,
		block_alpha = 0,
		shut_down_cam = 1,
		prefabKey = "GetLightBlackHeroCanvas212203"
	},
	[3908] = {
		prefab = "System/GetLightBlackHero/GetLightBlackHeroCanvas213203",
		ui_group = 41,
		ui_block = 0,
		ui_order = 61,
		ui_type = 2,
		need_hdr = 1,
		id = 3908,
		block_alpha = 0,
		shut_down_cam = 1,
		prefabKey = "GetLightBlackHeroCanvas213203"
	},
	[3909] = {
		prefab = "System/GetLightBlackHero/GetLightBlackHeroCanvas214202",
		ui_group = 41,
		ui_block = 0,
		ui_order = 61,
		ui_type = 2,
		need_hdr = 1,
		id = 3909,
		block_alpha = 0,
		shut_down_cam = 1,
		prefabKey = "GetLightBlackHeroCanvas214202"
	},
	[3910] = {
		prefab = "System/GetLightBlackHero/GetLightBlackHeroCanvas211203",
		ui_group = 41,
		ui_block = 0,
		ui_order = 61,
		ui_type = 2,
		need_hdr = 1,
		id = 3910,
		block_alpha = 0,
		shut_down_cam = 1,
		prefabKey = "GetLightBlackHeroCanvas211203"
	},
	[3911] = {
		prefab = "System/GetLightBlackHero/GetLightBlackHeroCanvas215202",
		ui_group = 41,
		ui_block = 0,
		ui_order = 61,
		ui_type = 2,
		need_hdr = 1,
		id = 3911,
		block_alpha = 0,
		shut_down_cam = 1,
		prefabKey = "GetLightBlackHeroCanvas215202"
	},
	[3912] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityCatRace/ActivityCatRaceMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 3912,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityCatRaceMainCanvas"
	},
	[3913] = {
		id = 3913,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/Activity/ActivityCatRace/ActivityCatRaceTaskCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivityCatRaceTaskCanvas"
	},
	[3914] = {
		id = 3914,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/Activity/ActivityCatRace/ActivityCatRaceFriendCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivityCatRaceFriendCanvas"
	},
	[3915] = {
		id = 3915,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/Activity/ActivityCatRace/ActivityCatRaceMileAwardCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivityCatRaceMileAwardCanvas"
	},
	[3916] = {
		id = 3916,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/Activity/ActivityCatRace/ActivityCatRaceTaskChooseCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivityCatRaceTaskChooseCanvas"
	},
	[3917] = {
		ui_group = 60,
		prefab = "System/Activity/ActivityCatRace/ActivityCatRaceUseItemCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 3917,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "ActivityCatRaceUseItemCanvas"
	},
	[3918] = {
		ui_group = 60,
		prefab = "System/Activity/ActivityCatRace/ActivityCatRaceSetCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 3918,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "ActivityCatRaceSetCanvas"
	},
	[3919] = {
		prefab = "System/GetLightBlackHero/GetLightBlackHeroCanvas212204",
		ui_group = 41,
		ui_block = 0,
		ui_order = 61,
		ui_type = 2,
		need_hdr = 1,
		id = 3919,
		block_alpha = 0,
		shut_down_cam = 1,
		prefabKey = "GetLightBlackHeroCanvas212204"
	},
	[3920] = {
		prefab = "System/GetLightBlackHero/GetLightBlackHeroCanvas213104",
		ui_group = 41,
		ui_block = 0,
		ui_order = 61,
		ui_type = 2,
		need_hdr = 1,
		id = 3920,
		block_alpha = 0,
		shut_down_cam = 1,
		prefabKey = "GetLightBlackHeroCanvas213104"
	},
	[3921] = {
		prefab = "System/GetLightBlackHero/GetLightBlackHeroCanvas213205",
		ui_group = 41,
		ui_block = 0,
		ui_order = 61,
		ui_type = 2,
		need_hdr = 1,
		id = 3921,
		block_alpha = 0,
		shut_down_cam = 1,
		prefabKey = "GetLightBlackHeroCanvas213205"
	},
	[3922] = {
		prefab = "System/GetLightBlackHero/GetLightBlackHeroCanvas212106",
		ui_group = 41,
		ui_block = 0,
		ui_order = 61,
		ui_type = 2,
		need_hdr = 1,
		id = 3922,
		block_alpha = 0,
		shut_down_cam = 1,
		prefabKey = "GetLightBlackHeroCanvas212106"
	},
	[3923] = {
		prefab = "System/GetLightBlackHero/GetLightBlackHeroCanvas211204",
		ui_group = 41,
		ui_block = 0,
		ui_order = 61,
		ui_type = 2,
		need_hdr = 1,
		id = 3923,
		block_alpha = 0,
		shut_down_cam = 1,
		prefabKey = "GetLightBlackHeroCanvas211204"
	},
	[3924] = {
		prefab = "System/GetLightBlackHero/GetLightBlackHeroCanvas213204",
		ui_group = 41,
		ui_block = 0,
		ui_order = 61,
		ui_type = 2,
		need_hdr = 1,
		id = 3924,
		block_alpha = 0,
		shut_down_cam = 1,
		prefabKey = "GetLightBlackHeroCanvas213204"
	},
	[3925] = {
		prefab = "System/GetLightBlackHero/GetLightBlackHeroCanvas212107",
		ui_group = 41,
		ui_block = 0,
		ui_order = 61,
		ui_type = 2,
		need_hdr = 1,
		id = 3925,
		block_alpha = 0,
		shut_down_cam = 1,
		prefabKey = "GetLightBlackHeroCanvas212107"
	},
	[3926] = {
		prefab = "System/GetLightBlackHero/GetLightBlackHeroCanvas212206",
		ui_group = 41,
		ui_block = 0,
		ui_order = 61,
		ui_type = 2,
		need_hdr = 1,
		id = 3926,
		block_alpha = 0,
		shut_down_cam = 1,
		prefabKey = "GetLightBlackHeroCanvas212206"
	},
	[3927] = {
		prefab = "System/GetLightBlackHero/GetLightBlackHeroCanvas211103",
		ui_group = 41,
		ui_block = 0,
		ui_order = 61,
		ui_type = 2,
		need_hdr = 1,
		id = 3927,
		block_alpha = 0,
		shut_down_cam = 1,
		prefabKey = "GetLightBlackHeroCanvas211103"
	},
	[3928] = {
		prefab = "System/GetLightBlackHero/GetLightBlackHeroCanvas212207",
		ui_group = 41,
		ui_block = 0,
		ui_order = 61,
		ui_type = 2,
		need_hdr = 1,
		id = 3928,
		block_alpha = 0,
		shut_down_cam = 1,
		prefabKey = "GetLightBlackHeroCanvas212207"
	},
	[3929] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityNewYear2023/ActivityNewYearEveMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 3929,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityNewYearEveMainCanvas"
	},
	[3930] = {
		id = 3930,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/Activity/ActivityNewYear2023/ActivityEveKitchenLevelCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivityEveKitchenLevelCanvas"
	},
	[3931] = {
		id = 3931,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/Activity/ActivityNewYear2023/ActivityEveAvgPreviewCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivityEveAvgPreviewCanvas"
	},
	[3932] = {
		id = 3932,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Activity/ActivityNewYear2023/ActivityEveAwardCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivityEveAwardCanvas"
	},
	[3933] = {
		id = 3933,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Activity/ActivityNewYear2023/ActivityEveUpLevelCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivityEveUpLevelCanvas"
	},
	[3934] = {
		id = 3934,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/Activity/ActivityNewYear2023/ActivityEveSpeedUpCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivityEveSpeedUpCanvas"
	},
	[3935] = {
		prefab = "System/GetLightBlackHero/GetLightBlackHeroCanvas212108",
		ui_group = 41,
		ui_block = 0,
		ui_order = 61,
		ui_type = 2,
		need_hdr = 1,
		id = 3935,
		block_alpha = 0,
		shut_down_cam = 1,
		prefabKey = "GetLightBlackHeroCanvas212108"
	},
	[3936] = {
		prefab = "System/GetLightBlackHero/GetLightBlackHeroCanvas212205",
		ui_group = 41,
		ui_block = 0,
		ui_order = 61,
		ui_type = 2,
		need_hdr = 1,
		id = 3936,
		block_alpha = 0,
		shut_down_cam = 1,
		prefabKey = "GetLightBlackHeroCanvas212205"
	},
	[3937] = {
		prefab = "System/GetLightBlackHero/GetLightBlackHeroCanvas213109",
		ui_group = 41,
		ui_block = 0,
		ui_order = 61,
		ui_type = 2,
		need_hdr = 1,
		id = 3937,
		block_alpha = 0,
		shut_down_cam = 1,
		prefabKey = "GetLightBlackHeroCanvas213109"
	},
	[3938] = {
		prefab = "System/GetLightBlackHero/GetLightBlackHeroCanvas213110",
		ui_group = 41,
		ui_block = 0,
		ui_order = 61,
		ui_type = 2,
		need_hdr = 1,
		id = 3938,
		block_alpha = 0,
		shut_down_cam = 1,
		prefabKey = "GetLightBlackHeroCanvas213110"
	},
	[3939] = {
		prefab = "System/GetLightBlackHero/GetLightBlackHeroCanvas212110",
		ui_group = 41,
		ui_block = 0,
		ui_order = 61,
		ui_type = 2,
		need_hdr = 1,
		id = 3939,
		block_alpha = 0,
		shut_down_cam = 1,
		prefabKey = "GetLightBlackHeroCanvas212110"
	},
	[3940] = {
		prefab = "System/GetLightBlackHero/GetLightBlackHeroCanvas215203",
		ui_group = 41,
		ui_block = 0,
		ui_order = 61,
		ui_type = 2,
		need_hdr = 1,
		id = 3940,
		block_alpha = 0,
		shut_down_cam = 1,
		prefabKey = "GetLightBlackHeroCanvas215203"
	},
	[3941] = {
		prefab = "System/GetLightBlackHero/GetLightBlackHeroCanvas213112",
		ui_group = 41,
		ui_block = 0,
		ui_order = 61,
		ui_type = 2,
		need_hdr = 1,
		id = 3941,
		block_alpha = 0,
		shut_down_cam = 1,
		prefabKey = "GetLightBlackHeroCanvas213112"
	},
	[3942] = {
		prefab = "System/GetLightBlackHero/GetLightBlackHeroCanvas211205",
		ui_group = 41,
		ui_block = 0,
		ui_order = 61,
		ui_type = 2,
		need_hdr = 1,
		id = 3942,
		block_alpha = 0,
		shut_down_cam = 1,
		prefabKey = "GetLightBlackHeroCanvas211205"
	},
	[4001] = {
		need_hdr = 1,
		prefab = "System/WorldBoss/WorldBossMainCanvas",
		ui_group = 20,
		ui_order = 24,
		id = 4001,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "WorldBossMainCanvas"
	},
	[4002] = {
		ui_group = 40,
		prefab = "System/WorldBoss/WorldBossRecordCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 4002,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "WorldBossRecordCanvas"
	},
	[4003] = {
		ui_group = 40,
		prefab = "System/WorldBoss/WorldBossAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 4003,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "WorldBossAwardCanvas"
	},
	[4004] = {
		ui_group = 40,
		prefab = "System/WorldBoss/WorldBossAnnounceCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 4004,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "WorldBossAnnounceCanvas"
	},
	[4005] = {
		ui_group = 40,
		prefab = "System/WorldBoss/WorldBossPointAwardGetCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 4005,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "WorldBossPointAwardGetCanvas"
	},
	[4006] = {
		ui_group = 40,
		prefab = "System/WorldBoss/WorldBossEliteUnlockCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 4006,
		block_alpha = 0,
		ui_type = 2,
		prefabKey = "WorldBossEliteUnlockCanvas"
	},
	[4101] = {
		prefab = "System/Relic/RelicWearCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 4101,
		prefabKey = "RelicWearCanvas"
	},
	[4102] = {
		id = 4102,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/Relic/RelicUpgradeResultCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "RelicUpgradeResultCanvas"
	},
	[4103] = {
		ui_group = 60,
		prefab = "System/Relic/ShowRelicCanvas",
		ui_block = 1,
		ui_order = 60,
		id = 4103,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "ShowRelicCanvas"
	},
	[4104] = {
		id = 4104,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/Relic/RelicPackOpenCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "RelicPackOpenCanvas"
	},
	[4201] = {
		ui_group = 20,
		prefab = "System/AR/ARCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 4201,
		shut_down_cam = 1,
		prefabKey = "ARCanvas"
	},
	[4202] = {
		prefab = "System/AR/ShareCanvas",
		ui_group = 60,
		ui_order = 70,
		ui_type = 3,
		id = 4202,
		prefabKey = "ShareCanvas"
	},
	[4203] = {
		ui_group = 20,
		prefab = "System/AR/ARMainMenuCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 4203,
		shut_down_cam = 1,
		prefabKey = "ARMainMenuCanvas"
	},
	[4301] = {
		need_hdr = 1,
		prefab = "System/ActivityPVP/ActivityPVPMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 4301,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityPVPMainCanvas"
	},
	[4302] = {
		ui_group = 40,
		prefab = "System/ActivityPVP/ActivityPVPEnemyCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 4302,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityPVPEnemyCanvas"
	},
	[4303] = {
		ui_group = 40,
		prefab = "System/ActivityPVP/ActivityPVPRecordCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 4303,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityPVPRecordCanvas"
	},
	[4304] = {
		id = 4304,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/ActivityPVP/ActivityPVPWelcomeCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivityPVPWelcomeCanvas"
	},
	[4305] = {
		ui_group = 40,
		prefab = "System/ActivityPVP/ActivityPVPRankAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 4305,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityPVPRankAwardCanvas"
	},
	[4306] = {
		ui_group = 40,
		prefab = "System/ActivityPVP/ActivityPVPRankChangeCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 4306,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityPVPRankChangeCanvas"
	},
	[4307] = {
		id = 4307,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/ActivityPVP/ActivityPVPTopRankCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivityPVPTopRankCanvas"
	},
	[4308] = {
		ui_group = 20,
		prefab = "System/TopPVP/TopPVPMainCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 4308,
		shut_down_cam = 1,
		prefabKey = "TopPVPMainCanvas"
	},
	[4309] = {
		ui_group = 40,
		prefab = "System/TopPVP/TopPVPRecordCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 4309,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "TopPVPRecordCanvas"
	},
	[4310] = {
		ui_group = 40,
		prefab = "System/TopPVP/BPTeamCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 4310,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "BPTeamCanvas"
	},
	[4311] = {
		ui_group = 40,
		prefab = "System/TopPVP/TopPVPReadyCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 4311,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "TopPVPReadyCanvas"
	},
	[4312] = {
		ui_group = 20,
		prefab = "System/TopPVP/TopPVPCoinCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 4312,
		shut_down_cam = 1,
		prefabKey = "TopPVPCoinCanvas"
	},
	[4313] = {
		ui_group = 100,
		prefab = "System/TopPVP/TopPVPBPCanvas",
		ui_order = 100,
		ui_type = 5,
		id = 4313,
		shut_down_cam = 1,
		prefabKey = "TopPVPBPCanvas"
	},
	[4314] = {
		ui_group = 120,
		prefab = "System/TopPVP/TopPVPBPMoreCanvas",
		ui_block = 1,
		ui_order = 120,
		id = 4314,
		block_alpha = 1,
		ui_type = 6,
		prefabKey = "TopPVPBPMoreCanvas"
	},
	[4315] = {
		ui_group = 40,
		prefab = "System/TopPVP/TopPVPGambleMainCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 4315,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "TopPVPGambleMainCanvas"
	},
	[4316] = {
		ui_group = 120,
		prefab = "System/TopPVP/TopPVPGambleSimpleCanvas",
		ui_block = 0,
		ui_order = 120,
		id = 4316,
		block_alpha = 1,
		ui_type = 6,
		prefabKey = "TopPVPGambleSimpleCanvas"
	},
	[4317] = {
		ui_group = 60,
		prefab = "System/TopPVP/TopPVPLiveConfirmCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 4317,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "TopPVPLiveConfirmCanvas"
	},
	[4318] = {
		ui_group = 60,
		prefab = "System/TopPVP/TopPVPBPReplayCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 4318,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "TopPVPBPReplayCanvas"
	},
	[4319] = {
		need_hdr = 1,
		prefab = "System/TopPVP/TopPVPLiveLoadingCanvas",
		ui_group = 40,
		ui_order = 40,
		id = 4319,
		ui_type = 2,
		prefabKey = "TopPVPLiveLoadingCanvas"
	},
	[4320] = {
		prefab = "System/TopPVP/TopPVPWaitingCanvas",
		ui_group = 100,
		ui_order = 100,
		ui_type = 5,
		id = 4320,
		prefabKey = "TopPVPWaitingCanvas"
	},
	[4321] = {
		ui_group = 40,
		prefab = "System/TopPVP/TopPVPRecordInfoCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 4321,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "TopPVPRecordInfoCanvas"
	},
	[4322] = {
		ui_group = 60,
		prefab = "System/TopPVP/TopPVPGambleAwardTipsCanvas",
		ui_block = 1,
		ui_order = 60,
		id = 4322,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "TopPVPGambleAwardTipsCanvas"
	},
	[4323] = {
		id = 4323,
		prefab = "System/TopPVP/NoticeLampTopPVPCanvas",
		ui_type = 4,
		ui_order = 82,
		prefabKey = "NoticeLampTopPVPCanvas"
	},
	[4324] = {
		ui_group = 100,
		prefab = "System/TopPVP/TopPVPAutoResultCanvas",
		ui_block = 1,
		ui_order = 100,
		id = 4324,
		block_alpha = 1,
		ui_type = 5,
		prefabKey = "TopPVPAutoResultCanvas"
	},
	[4325] = {
		ui_group = 40,
		prefab = "System/TopPVP/TopPVPWaitCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 4325,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "TopPVPWaitCanvas"
	},
	[4326] = {
		ui_group = 60,
		prefab = "System/TopPVP/TopPVPBPSettingCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 4326,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "TopPVPBPSettingCanvas"
	},
	[4327] = {
		prefab = "System/TopPVP/TopPVPTimeCanvas",
		ui_group = 100,
		ui_order = 777,
		ui_type = 5,
		id = 4327,
		prefabKey = "TopPVPTimeCanvas"
	},
	[4401] = {
		prefab = "System/SeasonTower/SeasonTowerMainCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 4401,
		prefabKey = "SeasonTowerMainCanvas"
	},
	[4402] = {
		need_hdr = 1,
		prefab = "System/SeasonTower/SeasonTowerLvCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 4402,
		ui_type = 1,
		prefabKey = "SeasonTowerLvCanvas"
	},
	[4403] = {
		ui_group = 40,
		prefab = "System/SeasonTower/SeasonTowerBuffChooseCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 4403,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "SeasonTowerBuffChooseCanvas"
	},
	[4404] = {
		ui_group = 40,
		prefab = "System/SeasonTower/SeasonTowerCleanAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 4404,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "SeasonTowerCleanAwardCanvas"
	},
	[4405] = {
		ui_group = 40,
		prefab = "System/SeasonTower/SeasonTowerGetBuffCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 4405,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "SeasonTowerGetBuffCanvas"
	},
	[4406] = {
		ui_group = 40,
		prefab = "System/SeasonTower/SeasonTowerBuffPreviewCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 4406,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "SeasonTowerBuffPreviewCanvas"
	},
	[4407] = {
		prefab = "System/Battle/Result/BattleResultSeasonTowerAwardCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 4407,
		prefabKey = "BattleResultSeasonTowerAwardCanvas"
	},
	[4408] = {
		ui_group = 40,
		prefab = "System/SeasonTower/SeasonTowerAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 4408,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "SeasonTowerAwardCanvas"
	},
	[4409] = {
		ui_group = 40,
		prefab = "System/SeasonTower/SeasonTowerRuleCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 4409,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "SeasonTowerRuleCanvas"
	},
	[4410] = {
		ui_group = 40,
		prefab = "System/SeasonTower/SeasonTowerLvAwardCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 4410,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "SeasonTowerLvAwardCanvas"
	},
	[4411] = {
		ui_group = 60,
		prefab = "System/SeasonTower/SeasonTowerRecordInfoCanvas",
		ui_block = 1,
		ui_order = 60,
		id = 4411,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "SeasonTowerRecordInfoCanvas"
	},
	[4412] = {
		prefab = "System/SeasonTower/NewSeasonTowerMainCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 4412,
		prefabKey = "NewSeasonTowerMainCanvas"
	},
	[4413] = {
		need_hdr = 1,
		prefab = "System/SeasonTower/NewSeasonTowerLvCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 4413,
		ui_type = 1,
		prefabKey = "NewSeasonTowerLvCanvas"
	},
	[4414] = {
		id = 4414,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/SeasonTower/NewSeasonTowerTapAwardCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "NewSeasonTowerTapAwardCanvas"
	},
	[4415] = {
		ui_group = 40,
		prefab = "System/SeasonTower/NewSeasonTowerCleanAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 4415,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "NewSeasonTowerCleanAwardCanvas"
	},
	[4416] = {
		ui_group = 40,
		prefab = "System/SeasonTower/NewSeasonTowerShowCleanCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 4416,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "NewSeasonTowerShowCleanCanvas"
	},
	[4501] = {
		need_hdr = 1,
		prefab = "System/MainMenu/GameGatherMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 4501,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "GameGatherMainCanvas"
	},
	[4601] = {
		ui_group = 20,
		prefab = "System/CaseTask/CaseTaskMainCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 4601,
		shut_down_cam = 1,
		prefabKey = "CaseTaskMainCanvas"
	},
	[4602] = {
		ui_group = 40,
		prefab = "System/CaseTask/CaseTaskBossCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 4602,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CaseTaskBossCanvas"
	},
	[4603] = {
		ui_group = 40,
		prefab = "System/CaseTask/CaseTaskRequestCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 4603,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CaseTaskRequestCanvas"
	},
	[4604] = {
		ui_group = 40,
		prefab = "System/CaseTask/CaseTaskWriteLetterCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 4604,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CaseTaskWriteLetterCanvas"
	},
	[4605] = {
		ui_group = 41,
		prefab = "System/CaseTask/CaseTaskSetupTeamCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 4605,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CaseTaskSetupTeamCanvas"
	},
	[4606] = {
		ui_group = 40,
		prefab = "System/CaseTask/CaseTaskReceiveLetterCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 4606,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CaseTaskReceiveLetterCanvas"
	},
	[4607] = {
		ui_group = 40,
		prefab = "System/CaseTask/CaseTaskLetterInfoCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 4607,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CaseTaskLetterInfoCanvas"
	},
	[4608] = {
		ui_group = 40,
		prefab = "System/CaseTask/CaseTaskRecordCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 4608,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CaseTaskRecordCanvas"
	},
	[4609] = {
		ui_group = 40,
		prefab = "System/CaseTask/CaseTaskRecordLetterCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 4609,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CaseTaskRecordLetterCanvas"
	},
	[4610] = {
		ui_group = 60,
		prefab = "System/CaseTask/ShowAwardCaseTaskCanvas",
		ui_block = 1,
		ui_order = 60,
		id = 4610,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "ShowAwardCaseTaskCanvas"
	},
	[4701] = {
		prefab = "System/HeroShowRoom/HeroShowRoomMainCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 4701,
		prefabKey = "HeroShowRoomMainCanvas"
	},
	[4702] = {
		prefab = "System/HeroShowRoom/HeroShowRoomListCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 4702,
		prefabKey = "HeroShowRoomListCanvas"
	},
	[4703] = {
		prefab = "System/HeroShowRoom/HeroShowRoomGrowUpCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 4703,
		prefabKey = "HeroShowRoomGrowUpCanvas"
	},
	[4704] = {
		ui_group = 40,
		prefab = "System/HeroShowRoom/HeroShowRoomNewStageCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 4704,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "HeroShowRoomNewStageCanvas"
	},
	[4705] = {
		ui_group = 40,
		prefab = "System/HeroShowRoom/HeroShowRoomStoryCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 4705,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "HeroShowRoomStoryCanvas"
	},
	[4706] = {
		ui_group = 40,
		prefab = "System/HeroShowRoom/HeroShowRoomPartsCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 4706,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "HeroShowRoomPartsCanvas"
	},
	[4707] = {
		ui_group = 40,
		prefab = "System/HeroShowRoom/HeroShowRoomVideoCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 4707,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "HeroShowRoomVideoCanvas"
	},
	[4708] = {
		ui_group = 40,
		prefab = "System/HeroShowRoom/HeroShowRoomLoveBookCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 4708,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "HeroShowRoomLoveBookCanvas"
	},
	[4709] = {
		id = 4709,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/HeroShowRoom/HeroShowRoomAcquireCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "HeroShowRoomAcquireCanvas"
	},
	[4710] = {
		id = 4710,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/HeroShowRoom/UniversalTransitionCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "UniversalTransitionCanvas"
	},
	[4801] = {
		ui_group = 20,
		prefab = "System/SneakBattle/SneakBattleMainCanvas",
		ui_block = 0,
		ui_order = 20,
		id = 4801,
		block_alpha = 0,
		ui_type = 1,
		prefabKey = "SneakBattleMainCanvas"
	},
	[4802] = {
		ui_group = 40,
		prefab = "System/SneakBattle/SneakBattleAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 4802,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "SneakBattleAwardCanvas"
	},
	[4803] = {
		ui_group = 40,
		prefab = "System/SneakBattle/SneakBattleAnnounceCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 4803,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "SneakBattleAnnounceCanvas"
	},
	[4804] = {
		ui_group = 40,
		prefab = "System/SneakBattle/SneakBattleInheritDifficultyCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 4804,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "SneakBattleInheritDifficultyCanvas"
	},
	[4805] = {
		ui_group = 20,
		prefab = "System/SneakBattle/SneakBattleDifficultyMainCanvas",
		ui_block = 0,
		ui_order = 20,
		id = 4805,
		block_alpha = 1,
		ui_type = 1,
		prefabKey = "SneakBattleDifficultyMainCanvas"
	},
	[4806] = {
		ui_group = 40,
		prefab = "System/SneakBattle/SneakBattleLimitCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 4806,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "SneakBattleLimitCanvas"
	},
	[4807] = {
		ui_group = 40,
		prefab = "System/SneakBattle/SneakBattleLevelInfoCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 4807,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "SneakBattleLevelInfoCanvas"
	},
	[4808] = {
		ui_group = 20,
		prefab = "System/SneakBattle/SneakBattleHeroCheckCanvas",
		ui_block = 0,
		ui_order = 20,
		id = 4808,
		block_alpha = 1,
		ui_type = 1,
		prefabKey = "SneakBattleHeroCheckCanvas"
	},
	[4809] = {
		ui_group = 100,
		prefab = "System/SneakBattle/SneakBattleFinishDifficultyCanvas",
		ui_block = 0,
		ui_order = 100,
		id = 4809,
		block_alpha = 1,
		ui_type = 5,
		prefabKey = "SneakBattleFinishDifficultyCanvas"
	},
	[4810] = {
		ui_group = 40,
		prefab = "System/SneakBattle/SneakBattleTeamSetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 4810,
		block_alpha = 0,
		ui_type = 2,
		prefabKey = "SneakBattleTeamSetCanvas"
	},
	[4901] = {
		ui_group = 20,
		prefab = "System/MiniGame/MiniGameMainCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 4901,
		shut_down_cam = 1,
		prefabKey = "MiniGameMainCanvas"
	},
	[4902] = {
		ui_group = 20,
		prefab = "System/MiniGame/MiniGameInfoCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 4902,
		shut_down_cam = 1,
		prefabKey = "MiniGameInfoCanvas"
	},
	[4903] = {
		prefab = "System/MiniGame/MiniGamePalyCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 4903,
		prefabKey = "MiniGamePalyCanvas"
	},
	[4904] = {
		id = 4904,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/MiniGame/MiniGameShowAwardCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "MiniGameShowAwardCanvas"
	},
	[4905] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityGM/ActivityGMStoreCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 4905,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityGMStoreCanvas"
	},
	[4906] = {
		prefab = "System/MainBattle/MainBattleAutoCanvas",
		ui_group = 100,
		ui_order = 777,
		ui_type = 5,
		id = 4906,
		prefabKey = "MainBattleAutoCanvas"
	},
	[4907] = {
		ui_group = 40,
		prefab = "System/Store/RecGift02Canvas",
		ui_block = 0,
		ui_order = 40,
		id = 4907,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "RecGift02Canvas"
	},
	[4908] = {
		ui_group = 40,
		prefab = "System/Store/RecGift03Canvas",
		ui_block = 0,
		ui_order = 40,
		id = 4908,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "RecGift03Canvas"
	},
	[4909] = {
		ui_group = 40,
		prefab = "System/Store/RecGift04Canvas",
		ui_block = 0,
		ui_order = 40,
		id = 4909,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "RecGift04Canvas"
	},
	[4910] = {
		ui_group = 40,
		prefab = "System/Task/ChapterPreviewCanvas02",
		ui_block = 0,
		ui_order = 40,
		id = 4910,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ChapterPreviewCanvas02"
	},
	[5001] = {
		ui_group = 40,
		prefab = "System/QQ/QQPrivilegeCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 5001,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "QQPrivilegeCanvas"
	},
	[5002] = {
		ui_group = 60,
		prefab = "System/QQ/BrowserCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 5002,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "BrowserCanvas"
	},
	[5101] = {
		prefab = "System/GameAssistant/GameAssistantMainCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 5101,
		prefabKey = "GameAssistantMainCanvas"
	},
	[5102] = {
		id = 5102,
		prefab = "System/GameAssistant/NoticeGameAssistantCanvas",
		ui_type = 4,
		ui_order = 82,
		prefabKey = "NoticeGameAssistantCanvas"
	},
	[5201] = {
		need_hdr = 1,
		prefab = "System/SeasonPlayCommon/SeasonPlayMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 5201,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "SeasonPlayMainCanvas"
	},
	[5202] = {
		ui_group = 40,
		prefab = "System/SeasonPlayCommon/SeasonPlayListCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 5202,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "SeasonPlayListCanvas"
	},
	[5203] = {
		need_hdr = 1,
		prefab = "System/SeasonPlay/SeasonPlaySkinPoolCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 5203,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "SeasonPlaySkinPoolCanvas"
	},
	[5204] = {
		id = 5204,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/SeasonPlay/SeasonPlayUpCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "SeasonPlayUpCanvas"
	},
	[5205] = {
		id = 5205,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/SeasonPlay/SeasonPlayExchangeCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "SeasonPlayExchangeCanvas"
	},
	[5206] = {
		ui_group = 40,
		prefab = "System/SeasonPlayCommon/SeasonPlayProbabilityCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 5206,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "SeasonPlayProbabilityCanvas"
	},
	[5207] = {
		ui_group = 40,
		prefab = "System/SeasonPlayCommon/SeasonPlayDrawLogCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 5207,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "SeasonPlayDrawLogCanvas"
	},
	[5208] = {
		id = 5208,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/SeasonPlayCommon/SeasonPlayGetSkinCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 0,
		prefabKey = "SeasonPlayGetSkinCanvas"
	},
	[5209] = {
		id = 5209,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/SeasonPlayCommon/SeasonPlayShowAwardCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 0,
		prefabKey = "SeasonPlayShowAwardCanvas"
	},
	[5210] = {
		id = 5210,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/SeasonPlayCommon/SeasonPlayLvUpCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "SeasonPlayLvUpCanvas"
	},
	[5211] = {
		id = 5211,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/SeasonPlayCommon/SeasonPlaySettleAwardCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "SeasonPlaySettleAwardCanvas"
	},
	[6001] = {
		ui_group = 40,
		prefab = "System/CircleBattle/CircleBattleSceneBattleInfo1Canvas",
		ui_block = 0,
		ui_order = 40,
		id = 6001,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CircleBattleSceneBattleInfo1Canvas"
	},
	[6002] = {
		ui_group = 40,
		prefab = "System/CircleBattle/CircleBattleSceneBattleInfo2Canvas",
		ui_block = 0,
		ui_order = 40,
		id = 6002,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CircleBattleSceneBattleInfo2Canvas"
	},
	[6003] = {
		id = 6003,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/CircleBattle/CircleBattleSceneBattleInfo3Canvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "CircleBattleSceneBattleInfo3Canvas"
	},
	[6004] = {
		id = 6004,
		ui_group = 60,
		ui_block = 0,
		prefab = "System/CircleBattle/CircleBattleSceneConfirmCanvas",
		ui_type = 3,
		need_hdr = 1,
		ui_order = 60,
		block_alpha = 1,
		prefabKey = "CircleBattleSceneConfirmCanvas"
	},
	[6005] = {
		ui_group = 40,
		prefab = "System/CircleBattle/CircleBattleSceneEndCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 6005,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CircleBattleSceneEndCanvas"
	},
	[6006] = {
		ui_group = 40,
		prefab = "System/CircleBattle/CircleBattleSceneRuneCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 6006,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CircleBattleSceneRuneCanvas"
	},
	[6007] = {
		id = 6007,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/CircleBattle/CircleBattleSceneTreasureCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "CircleBattleSceneTreasureCanvas"
	},
	[6008] = {
		need_state_name = "sMainCircle",
		prefab = "System/CircleBattle/CircleBattleMainCanvas",
		need_hdr = 1,
		ui_group = 20,
		id = 6008,
		ui_order = 20,
		ui_type = 1,
		prefabKey = "CircleBattleMainCanvas"
	},
	[6009] = {
		ui_group = 40,
		prefab = "System/CircleBattle/CircleBattleCircleSkillCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 6009,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CircleBattleCircleSkillCanvas"
	},
	[6010] = {
		ui_group = 40,
		prefab = "System/CircleBattle/CircleBattleStratageCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 6010,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CircleBattleStratageCanvas"
	},
	[6011] = {
		ui_group = 60,
		prefab = "System/CircleBattle/CircleBattleRuneCanvas",
		ui_block = 1,
		ui_order = 60,
		id = 6011,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "CircleBattleRuneCanvas"
	},
	[6012] = {
		id = 6012,
		ui_group = 20,
		ui_block = 1,
		prefab = "System/CircleBattle/CircleBattleWelComeCanvas",
		ui_type = 1,
		need_hdr = 1,
		ui_order = 20,
		block_alpha = 1,
		prefabKey = "CircleBattleWelComeCanvas"
	},
	[6013] = {
		need_hdr = 1,
		prefab = "System/CircleBattle/CircleBattleLoadingCanvas",
		ui_order = 360,
		ui_type = 4,
		id = 6013,
		prefabKey = "CircleBattleLoadingCanvas"
	},
	[6014] = {
		ui_group = 40,
		prefab = "System/CircleBattle/CircleBattleProgressCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 6014,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CircleBattleProgressCanvas"
	},
	[6015] = {
		id = 6015,
		ui_group = 60,
		ui_block = 1,
		prefab = "System/CircleBattle/CircleBattlePointRecordCanvas",
		ui_type = 3,
		need_hdr = 1,
		ui_order = 60,
		block_alpha = 1,
		prefabKey = "CircleBattlePointRecordCanvas"
	},
	[6016] = {
		ui_group = 40,
		prefab = "System/CircleBattle/CircleBattlePointAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 6016,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CircleBattlePointAwardCanvas"
	},
	[6017] = {
		ui_group = 40,
		prefab = "System/CircleBattle/CircleBattleHonorCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 6017,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CircleBattleHonorCanvas"
	},
	[6018] = {
		ui_group = 60,
		prefab = "System/CircleBattle/CircleBattleActionRecordCanvas",
		ui_block = 1,
		ui_order = 60,
		id = 6018,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "CircleBattleActionRecordCanvas"
	},
	[6019] = {
		ui_group = 40,
		prefab = "System/CircleBattle/CircleBattleTalentCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 6019,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CircleBattleTalentCanvas"
	},
	[6020] = {
		ui_group = 40,
		prefab = "System/CircleBattle/CircleBattleBossAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 6020,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CircleBattleBossAwardCanvas"
	},
	[6021] = {
		ui_group = 20,
		prefab = "System/CircleBattle/CircleBattleHeroListCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 6021,
		shut_down_cam = 1,
		prefabKey = "CircleBattleHeroListCanvas"
	},
	[6022] = {
		ui_group = 40,
		prefab = "System/CircleBattle/CircleBattleChangeModelCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 6022,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CircleBattleChangeModelCanvas"
	},
	[6023] = {
		ui_group = 40,
		prefab = "System/CircleBattle/CircleBattleSceneMorePlayerCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 6023,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CircleBattleSceneMorePlayerCanvas"
	},
	[6024] = {
		prefab = "System/CircleBattle/CircleBattleHeroInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 6024,
		prefabKey = "CircleBattleHeroInfoCanvas"
	},
	[6025] = {
		id = 6025,
		ui_group = 60,
		ui_block = 0,
		prefab = "System/CircleBattle/CircleBattleSceneKillBoss2",
		ui_type = 3,
		need_hdr = 1,
		ui_order = 60,
		block_alpha = 1,
		prefabKey = "CircleBattleSceneKillBoss2"
	},
	[6026] = {
		id = 6026,
		ui_group = 60,
		ui_block = 0,
		prefab = "System/CircleBattle/CircleBattleSceneKillBoss3",
		ui_type = 3,
		need_hdr = 1,
		ui_order = 60,
		block_alpha = 1,
		prefabKey = "CircleBattleSceneKillBoss3"
	},
	[6027] = {
		need_hdr = 1,
		prefab = "System/CircleBattle/CircleBattleBattleLoadingCanvas",
		ui_order = 100,
		ui_type = 4,
		id = 6027,
		prefabKey = "CircleBattleBattleLoadingCanvas"
	},
	[6100] = {
		ui_group = 20,
		prefab = "System/Return/ReturnAwardCanvas",
		ui_block = 0,
		ui_order = 20,
		id = 6100,
		block_alpha = 1,
		ui_type = 1,
		prefabKey = "ReturnAwardCanvas"
	},
	[6101] = {
		ui_group = 20,
		prefab = "System/Return/ActivityReturnBPCanvas",
		ui_block = 0,
		ui_order = 20,
		id = 6101,
		block_alpha = 1,
		ui_type = 1,
		prefabKey = "ActivityReturnBPCanvas"
	},
	[6103] = {
		ui_group = 40,
		prefab = "System/Return/ActivityReturnStoreCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 6103,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityReturnStoreCanvas"
	},
	[6104] = {
		ui_group = 20,
		prefab = "System/Return/ReturnChtAwardCanvas",
		ui_block = 0,
		ui_order = 20,
		id = 6104,
		block_alpha = 1,
		ui_type = 1,
		prefabKey = "ReturnChtAwardCanvas"
	},
	[6105] = {
		ui_group = 60,
		prefab = "System/Return/ReturnChtConfirmCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 6105,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "ReturnChtConfirmCanvas"
	},
	[6201] = {
		need_hdr = 1,
		prefab = "System/Rogue/RogueChooseCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 6201,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "RogueChooseCanvas"
	},
	[6202] = {
		id = 6202,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Rogue/RogueBoxDetailCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "RogueBoxDetailCanvas"
	},
	[6203] = {
		ui_group = 20,
		prefab = "System/Rogue/RogueMainCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 6203,
		shut_down_cam = 1,
		prefabKey = "RogueMainCanvas"
	},
	[6204] = {
		ui_group = 40,
		prefab = "System/Rogue/RogueEventDetailCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 6204,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "RogueEventDetailCanvas"
	},
	[6205] = {
		ui_group = 40,
		prefab = "System/Rogue/RogueStoreCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 6205,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "RogueStoreCanvas"
	},
	[6206] = {
		ui_group = 60,
		prefab = "System/Rogue/RogueStoreLvCanvas",
		ui_block = 1,
		ui_order = 60,
		id = 6206,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "RogueStoreLvCanvas"
	},
	[6207] = {
		ui_group = 40,
		prefab = "System/Rogue/RogueChooseThreeCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 6207,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "RogueChooseThreeCanvas"
	},
	[6208] = {
		ui_group = 20,
		prefab = "System/Rogue/RogueBattleHeroListCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 6208,
		shut_down_cam = 1,
		prefabKey = "RogueBattleHeroListCanvas"
	},
	[6209] = {
		prefab = "System/Rogue/RogueBattleHeroInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 6209,
		prefabKey = "RogueBattleHeroInfoCanvas"
	},
	[6210] = {
		ui_group = 40,
		prefab = "System/Rogue/RogueHallowPreviewCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 6210,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "RogueHallowPreviewCanvas"
	},
	[6211] = {
		ui_group = 40,
		prefab = "System/Rogue/RogueAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 6211,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "RogueAwardCanvas"
	},
	[6212] = {
		prefab = "System/Rogue/RogueTeamSetCanvas",
		ui_group = 20,
		ui_order = 20,
		ui_type = 1,
		id = 6212,
		prefabKey = "RogueTeamSetCanvas"
	},
	[6213] = {
		ui_group = 40,
		prefab = "System/Rogue/RogueCombatSettlement",
		ui_block = 0,
		ui_order = 40,
		id = 6213,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "RogueCombatSettlement"
	},
	[6214] = {
		id = 6214,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Rogue/RogueStageHintCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "RogueStageHintCanvas"
	},
	[6215] = {
		id = 6215,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/Rogue/RogueAwardHintCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "RogueAwardHintCanvas"
	},
	[6216] = {
		ui_group = 40,
		prefab = "System/Rogue/RogueHaloPreviewCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 6216,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "RogueHaloPreviewCanvas"
	},
	[6217] = {
		id = 6217,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Rogue/HeroFeatures/RogueHeroCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "RogueHeroCanvas"
	},
	[6218] = {
		ui_group = 40,
		prefab = "System/Rogue/RogueRandomDetailCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 6218,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "RogueRandomDetailCanvas"
	},
	[6219] = {
		ui_group = 40,
		prefab = "System/Rogue/RogueRandomWinResultCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 6219,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "RogueRandomWinResultCanvas"
	},
	[6220] = {
		ui_group = 40,
		prefab = "System/Rogue/RogueRandomLoseResultCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 6220,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "RogueRandomLoseResultCanvas"
	},
	[6221] = {
		ui_group = 40,
		prefab = "System/Rogue/RogueRandomMoreToOneCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 6221,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "RogueRandomMoreToOneCanvas"
	},
	[6222] = {
		id = 6222,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/Rogue/RogueRandomWinHintCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "RogueRandomWinHintCanvas"
	},
	[6223] = {
		ui_group = 40,
		prefab = "System/Rogue/RogueRandomLoseHintCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 6223,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "RogueRandomLoseHintCanvas"
	},
	[6224] = {
		ui_group = 60,
		prefab = "System/Rogue/RogueInheritCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 6224,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "RogueInheritCanvas"
	},
	[6225] = {
		ui_group = 40,
		prefab = "System/Rogue/RogueBossPreviewCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 6225,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "RogueBossPreviewCanvas"
	},
	[6226] = {
		ui_group = 40,
		prefab = "System/Rogue/RogueEnchantCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 6226,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "RogueEnchantCanvas"
	},
	[6227] = {
		ui_group = 60,
		prefab = "System/Rogue/RogueShowAwardCanvas",
		ui_block = 1,
		ui_order = 60,
		id = 6227,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "RogueShowAwardCanvas"
	},
	[6228] = {
		ui_group = 60,
		prefab = "System/Rogue/RogueReplaceCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 6228,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "RogueReplaceCanvas"
	},
	[6229] = {
		ui_group = 40,
		prefab = "System/Rogue/RogueHandbookCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 6229,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "RogueHandbookCanvas"
	},
	[6230] = {
		ui_group = 40,
		prefab = "System/Rogue/RogueCareerChooseCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 6230,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "RogueCareerChooseCanvas"
	},
	[6231] = {
		ui_group = 40,
		prefab = "System/Rogue/RogueSkillCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 6231,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "RogueSkillCanvas"
	},
	[6232] = {
		ui_order = 60,
		prefab = "System/Rogue/RogueConfirmBox",
		ui_block = 0,
		ui_group = 60,
		ui_type = 3,
		with_state_close = 1,
		id = 6232,
		block_alpha = 1,
		prefabKey = "RogueConfirmBox"
	},
	[6301] = {
		ui_group = 20,
		prefab = "System/Pet/PetMainCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 6301,
		shut_down_cam = 1,
		prefabKey = "PetMainCanvas"
	},
	[6302] = {
		ui_group = 20,
		prefab = "System/Pet/PetInfoCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 6302,
		shut_down_cam = 1,
		prefabKey = "PetInfoCanvas"
	},
	[6303] = {
		id = 6303,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Pet/FasionLevelCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "FasionLevelCanvas"
	},
	[6304] = {
		id = 6304,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Pet/FasionLevelUpCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "FasionLevelUpCanvas"
	},
	[6305] = {
		ui_group = 20,
		prefab = "System/Pet/PetSellCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 6305,
		shut_down_cam = 1,
		prefabKey = "PetSellCanvas"
	},
	[6306] = {
		id = 6306,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Pet/PetLevelUpCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "PetLevelUpCanvas"
	},
	[6307] = {
		id = 6307,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Pet/PetShowCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "PetShowCanvas"
	},
	[6308] = {
		ui_group = 100,
		prefab = "System/Pet/PetSkillTipsCanvas",
		ui_block = 1,
		ui_order = 666,
		id = 6308,
		block_alpha = 1,
		ui_type = 5,
		prefabKey = "PetSkillTipsCanvas"
	},
	[6309] = {
		ui_group = 40,
		prefab = "System/Pet/PetSkillWearCanvas",
		ui_order = 40,
		ui_type = 2,
		id = 6309,
		shut_down_cam = 1,
		prefabKey = "PetSkillWearCanvas"
	},
	[6310] = {
		ui_group = 40,
		prefab = "System/Pet/PetSkillUpGradeCanvas",
		ui_order = 40,
		ui_type = 2,
		id = 6310,
		shut_down_cam = 1,
		prefabKey = "PetSkillUpGradeCanvas"
	},
	[6311] = {
		ui_group = 40,
		prefab = "System/Pet/PetSkillMainCanvas",
		ui_order = 40,
		ui_type = 2,
		id = 6311,
		shut_down_cam = 1,
		prefabKey = "PetSkillMainCanvas"
	},
	[6312] = {
		id = 6312,
		ui_group = 60,
		ui_block = 1,
		prefab = "System/Pet/PetShowAwardCanvas",
		ui_type = 3,
		logic_flag = 1,
		ui_order = 60,
		block_alpha = 1,
		prefabKey = "PetShowAwardCanvas"
	},
	[6313] = {
		ui_group = 100,
		prefab = "System/Pet/PetGemTipsCanvas",
		ui_block = 1,
		ui_order = 666,
		id = 6313,
		block_alpha = 1,
		ui_type = 5,
		prefabKey = "PetGemTipsCanvas"
	},
	[6314] = {
		ui_group = 40,
		prefab = "System/Pet/PetGemLvUpCanvas",
		ui_order = 40,
		ui_type = 2,
		id = 6314,
		shut_down_cam = 1,
		prefabKey = "PetGemLvUpCanvas"
	},
	[6315] = {
		ui_group = 20,
		prefab = "System/Pet/PetGemMainCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 6315,
		shut_down_cam = 1,
		prefabKey = "PetGemMainCanvas"
	},
	[6316] = {
		id = 6316,
		ui_group = 60,
		ui_block = 1,
		prefab = "System/Pet/PetGemLvUpShowCanvas",
		ui_type = 3,
		logic_flag = 1,
		ui_order = 60,
		block_alpha = 1,
		prefabKey = "PetGemLvUpShowCanvas"
	},
	[6317] = {
		id = 6317,
		ui_group = 60,
		ui_block = 1,
		prefab = "System/Pet/PetGemLvUpFastCanvas",
		ui_type = 3,
		logic_flag = 1,
		ui_order = 60,
		block_alpha = 1,
		prefabKey = "PetGemLvUpFastCanvas"
	},
	[6318] = {
		need_hdr = 1,
		prefab = "System/Pet/PetRuneMainCanvas",
		ui_group = 40,
		ui_order = 40,
		id = 6318,
		ui_type = 2,
		shut_down_cam = 1,
		prefabKey = "PetRuneMainCanvas"
	},
	[6319] = {
		need_hdr = 1,
		prefab = "System/PetPool/PetPoolCommon/PetPoolMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 6319,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "PetPoolMainCanvas"
	},
	[6320] = {
		ui_group = 40,
		prefab = "System/PetPool/PetPoolSpeChooseCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 6320,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "PetPoolSpeChooseCanvas"
	},
	[6321] = {
		ui_group = 40,
		prefab = "System/PetPool/PetPoolProbabilityCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 6321,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "PetPoolProbabilityCanvas"
	},
	[6322] = {
		ui_group = 40,
		prefab = "System/PetPool/PetPoolDrawLogCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 6322,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "PetPoolDrawLogCanvas"
	},
	[6323] = {
		prefab = "System/PetPool/PetPoolResultGridCanvas",
		ui_group = 40,
		ui_block = 0,
		ui_order = 40,
		ui_type = 2,
		need_hdr = 1,
		id = 6323,
		block_alpha = 1,
		shut_down_cam = 1,
		prefabKey = "PetPoolResultGridCanvas"
	},
	[6324] = {
		need_hdr = 1,
		prefab = "System/PetPool/PetPoolLinked/PetPoolMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 6324,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "PetPoolMainCanvas"
	},
	[6325] = {
		ui_group = 100,
		prefab = "System/Pet/PetGemRandomTipsCanvas",
		ui_block = 1,
		ui_order = 666,
		id = 6325,
		block_alpha = 1,
		ui_type = 5,
		prefabKey = "PetGemRandomTipsCanvas"
	},
	[6326] = {
		ui_group = 20,
		prefab = "System/Pet/PetStoreMainCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 6326,
		shut_down_cam = 1,
		prefabKey = "PetStoreMainCanvas"
	},
	[6327] = {
		need_hdr = 1,
		prefab = "System/PetPool/PetPoolLinked01/PetPoolMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 6327,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "PetPoolMainCanvas"
	},
	[6328] = {
		ui_group = 20,
		prefab = "System/Pet/PetGemSwitchCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 6328,
		shut_down_cam = 1,
		prefabKey = "PetGemSwitchCanvas"
	},
	[6329] = {
		ui_group = 20,
		prefab = "System/Pet/PetGemWashCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 6329,
		shut_down_cam = 1,
		prefabKey = "PetGemWashCanvas"
	},
	[6330] = {
		id = 6330,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/Pet/PetGemChangeShowCanvas",
		ui_type = 2,
		logic_flag = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "PetGemChangeShowCanvas"
	},
	[6331] = {
		ui_group = 40,
		prefab = "System/PetPool/PetPoolFullStarCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 6331,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "PetPoolFullStarCanvas"
	},
	[6332] = {
		ui_group = 20,
		prefab = "System/Pet/PetEnchantMainCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 6332,
		shut_down_cam = 1,
		prefabKey = "PetEnchantMainCanvas"
	},
	[6333] = {
		ui_group = 40,
		prefab = "System/Pet/PetEnchantCareerCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 6333,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "PetEnchantCareerCanvas"
	},
	[6334] = {
		ui_group = 40,
		prefab = "System/Pet/PetEnchantInfoCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 6334,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "PetEnchantInfoCanvas"
	},
	[6335] = {
		ui_group = 60,
		prefab = "System/Pet/PetEnchantAllSkillCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 6335,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "PetEnchantAllSkillCanvas"
	},
	[6336] = {
		ui_group = 60,
		prefab = "System/Pet/PetEnchantAttrWashCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 6336,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "PetEnchantAttrWashCanvas"
	},
	[6337] = {
		ui_group = 60,
		prefab = "System/Pet/PetEnchantGetSkillCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 6337,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "PetEnchantGetSkillCanvas"
	},
	[6338] = {
		need_hdr = 1,
		prefab = "System/PetPool/PetPoolLinked02/PetPoolMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 6338,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "PetPoolMainCanvas"
	},
	[6339] = {
		ui_group = 20,
		prefab = "System/Pet/PetWearingCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 6339,
		shut_down_cam = 1,
		prefabKey = "PetWearingCanvas"
	},
	[6340] = {
		ui_group = 60,
		prefab = "System/Pet/PetGemLvUpAdCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 6340,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "PetGemLvUpAdCanvas"
	},
	[6341] = {
		need_hdr = 1,
		prefab = "System/PetPool/PetPoolLinked03/PetPoolMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 6341,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "PetPoolMainCanvas"
	},
	[6342] = {
		need_hdr = 1,
		prefab = "System/PetPool/PetPoolLinked04/PetPoolMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 6342,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "PetPoolMainCanvas"
	},
	[9001] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot13012/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9001,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9002] = {
		ui_group = 20,
		prefab = "System/Activity/ActivityPlot13012/ActivityFlotInfoCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 9002,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotInfoCanvas"
	},
	[9003] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot13012/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9003,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9004] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot13012/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9004,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9005] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot13012/ActivityCleanAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9005,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityCleanAwardCanvas"
	},
	[9006] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot13013/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9006,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9007] = {
		ui_group = 20,
		prefab = "System/Activity/ActivityPlot13013/ActivityFlotInfoCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 9007,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotInfoCanvas"
	},
	[9008] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot13013/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9008,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9009] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot13013/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9009,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9010] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot13013/ActivityCleanAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9010,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityCleanAwardCanvas"
	},
	[9011] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityMayDayCleanMentionCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9011,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityMayDayCleanMentionCanvas"
	},
	[9012] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityMayDayCleanMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9012,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityMayDayCleanMainCanvas"
	},
	[9013] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityMayDayCleanInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9013,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityMayDayCleanInfoCanvas"
	},
	[9014] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityMayDayCleanAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9014,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityMayDayCleanAwardCanvas"
	},
	[9015] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot12102/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9015,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9016] = {
		ui_group = 20,
		prefab = "System/Activity/ActivityPlot12102/ActivityFlotInfoCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 9016,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotInfoCanvas"
	},
	[9017] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot12102/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9017,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9018] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot12102/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9018,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9019] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot12102/ActivityCleanAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9019,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityCleanAwardCanvas"
	},
	[9020] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot13014/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9020,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9021] = {
		ui_group = 20,
		prefab = "System/Activity/ActivityPlot13014/ActivityFlotInfoCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 9021,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotInfoCanvas"
	},
	[9022] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot13014/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9022,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9023] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot13014/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9023,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9024] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot13014/ActivityCleanAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9024,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityCleanAwardCanvas"
	},
	[9025] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityMayDayEventCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9025,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityMayDayEventCanvas"
	},
	[9026] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityMonopoly/ActivityMonopolyAwardCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 9026,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityMonopolyAwardCanvas"
	},
	[9027] = {
		ui_group = 20,
		prefab = "System/Activity/ActivityMonopoly4/ActivityMonopolyMainCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 9027,
		shut_down_cam = 1,
		prefabKey = "ActivityMonopolyMainCanvas"
	},
	[9028] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityMonopoly4/ActivityMonopolyAwardCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 9028,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityMonopolyAwardCanvas"
	},
	[9029] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivitySkinLottery/ActivitySkinLotteryMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9029,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivitySkinLotteryMainCanvas"
	},
	[9030] = {
		id = 9030,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Activity/ActivitySkinLottery/ActivitySkinLotteryClearCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivitySkinLotteryClearCanvas"
	},
	[9031] = {
		id = 9031,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Activity/ActivitySkinLottery/ActivitySkinLotteryResultCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivitySkinLotteryResultCanvas"
	},
	[9032] = {
		ui_group = 40,
		prefab = "System/Activity/ActivitySpeGift/ActivitySpeGiftCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9032,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivitySpeGiftCanvas"
	},
	[9033] = {
		ui_group = 20,
		prefab = "System/Activity/ActivitySpecialStore/ActivitySpecialStoreCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 9033,
		shut_down_cam = 1,
		prefabKey = "ActivitySpecialStoreCanvas"
	},
	[9034] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot12011/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9034,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9035] = {
		ui_group = 20,
		prefab = "System/Activity/ActivityPlot12011/ActivityFlotInfoCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 9035,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotInfoCanvas"
	},
	[9036] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot12011/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9036,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9037] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot12011/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9037,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9038] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot12011/ActivityCleanAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9038,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityCleanAwardCanvas"
	},
	[9039] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14013/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9039,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9040] = {
		ui_group = 20,
		prefab = "System/Activity/ActivityPlot14013/ActivityFlotInfoCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 9040,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotInfoCanvas"
	},
	[9041] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14013/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9041,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9042] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot14013/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9042,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9043] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot14013/ActivityCleanAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9043,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityCleanAwardCanvas"
	},
	[9044] = {
		ui_group = 40,
		prefab = "System/Activity/TokenStorePreviewCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 9044,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "TokenStorePreviewCanvas"
	},
	[9045] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivitySnowOrNightBP12204/ActivitySnowOrNightBPCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9045,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivitySnowOrNightBPCanvas"
	},
	[9046] = {
		ui_group = 40,
		prefab = "System/Activity/ActivitySnowOrNightBP12204/SnowOrNightStarUnLockCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9046,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "SnowOrNightStarUnLockCanvas"
	},
	[9047] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot11011/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9047,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9048] = {
		ui_group = 20,
		prefab = "System/Activity/ActivityPlot11011/ActivityFlotInfoCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 9048,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotInfoCanvas"
	},
	[9049] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot11011/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9049,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9050] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot11011/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9050,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9051] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot11011/ActivityCleanAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9051,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityCleanAwardCanvas"
	},
	[9052] = {
		ui_group = 40,
		prefab = "System/Activity/StoreSpecialAwardCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 9052,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "StoreSpecialAwardCanvas"
	},
	[9053] = {
		need_hdr = 1,
		prefab = "System/Activity/CollectWords/ActivityCollectWordsCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9053,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityCollectWordsCanvas"
	},
	[9054] = {
		id = 9054,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/Activity/CollectWords/ActivityCollectWordsGet",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 0,
		prefabKey = "ActivityCollectWordsGet"
	},
	[9055] = {
		ui_group = 40,
		prefab = "System/Activity/CollectWords/CollectWordsPointTaskCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9055,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CollectWordsPointTaskCanvas"
	},
	[9057] = {
		ui_group = 40,
		prefab = "System/Activity/CollectWords/CollectWordsChooseUseCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 9057,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CollectWordsChooseUseCanvas"
	},
	[9058] = {
		ui_group = 40,
		prefab = "System/Activity/CollectWords/CollectWordsUseCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9058,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CollectWordsUseCanvas"
	},
	[9059] = {
		ui_group = 40,
		prefab = "System/Activity/CollectWords/CollectWordsAVGPreviewCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9059,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CollectWordsAVGPreviewCanvas"
	},
	[9060] = {
		need_hdr = 1,
		prefab = "System/Activity/CollectWords/ActivityCollectWordsComposeCanvas",
		ui_group = 62,
		ui_order = 60,
		id = 9060,
		ui_type = 3,
		prefabKey = "ActivityCollectWordsComposeCanvas"
	},
	[9061] = {
		id = 9061,
		ui_group = 60,
		ui_block = 1,
		prefab = "System/Activity/CollectWords/CollectWordsShowAwardCanvas",
		ui_type = 3,
		logic_flag = 1,
		ui_order = 60,
		block_alpha = 1,
		prefabKey = "CollectWordsShowAwardCanvas"
	},
	[9062] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot12104/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9062,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9063] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot12104/ActivityPlotInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9063,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityPlotInfoCanvas"
	},
	[9064] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot12104/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9064,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9065] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot12104/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9065,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9067] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivitySlimeSupport/ActivitySlimeSupportMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9067,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivitySlimeSupportMainCanvas"
	},
	[9068] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityAdventurerStoreCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9068,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityAdventurerStoreCanvas"
	},
	[9069] = {
		ui_group = 60,
		prefab = "System/Activity/ActivityASUSPrize/ActivityASUSPrizeCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 9069,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "ActivityASUSPrizeCanvas"
	},
	[9070] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot12013/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9070,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9071] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot12013/ActivityPlotInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9071,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityPlotInfoCanvas"
	},
	[9072] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot12013/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9072,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9073] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot12013/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9073,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9074] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot13015/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9074,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9075] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot13015/ActivityPlotInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9075,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityPlotInfoCanvas"
	},
	[9076] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot13015/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9076,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9077] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot13015/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9077,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9078] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivitySkinLotteryChristmas/ActivitySkinLotteryMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9078,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivitySkinLotteryMainCanvas"
	},
	[9079] = {
		id = 9079,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Activity/ActivitySkinLotteryChristmas/ActivitySkinLotteryClearCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivitySkinLotteryClearCanvas"
	},
	[9080] = {
		id = 9080,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Activity/ActivitySkinLotteryChristmas/ActivitySkinLotteryResultCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivitySkinLotteryResultCanvas"
	},
	[9081] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14014/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9081,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9082] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14014/ActivityPlotInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9082,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityPlotInfoCanvas"
	},
	[9083] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14014/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9083,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9084] = {
		id = 9084,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/Activity/ActivityPlot14014/ActivityFlotTargetCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9085] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot13105/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9085,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9086] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot13105/ActivityPlotInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9086,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityPlotInfoCanvas"
	},
	[9087] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot13105/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9087,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9088] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot13105/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9088,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9089] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityNewYear2022/ActivityNewYearEveMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9089,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityNewYearEveMainCanvas"
	},
	[9090] = {
		id = 9090,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/Activity/ActivityNewYear2022/ActivityEveKitchenLevelCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivityEveKitchenLevelCanvas"
	},
	[9091] = {
		id = 9091,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/Activity/ActivityNewYear2022/ActivityEveAvgPreviewCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivityEveAvgPreviewCanvas"
	},
	[9092] = {
		id = 9092,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Activity/ActivityNewYear2022/ActivityEveAwardCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivityEveAwardCanvas"
	},
	[9093] = {
		id = 9093,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Activity/ActivityNewYear2022/ActivityEveUpLevelCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivityEveUpLevelCanvas"
	},
	[9094] = {
		id = 9094,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/Activity/ActivityNewYear2022/ActivityEveSpeedUpCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivityEveSpeedUpCanvas"
	},
	[9095] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot12105/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9095,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9096] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot12105/ActivityPlotInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9096,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityPlotInfoCanvas"
	},
	[9097] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot12105/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9097,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9098] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot12105/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9098,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9099] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityCookValentine/ActivityValentineMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9099,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityValentineMainCanvas"
	},
	[9100] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityCookValentine/ValentineChatCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9100,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ValentineChatCanvas"
	},
	[9101] = {
		ui_group = 42,
		prefab = "System/Activity/ActivityCookValentine/ValentineChatEndCanvas",
		ui_block = 1,
		ui_order = 42,
		id = 9101,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ValentineChatEndCanvas"
	},
	[9102] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityCookValentine/ValentineMackCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9102,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ValentineMackCanvas"
	},
	[9103] = {
		ui_group = 60,
		prefab = "System/Activity/ActivityCookValentine/ValentineMackAwardCanvas",
		ui_block = 1,
		ui_order = 60,
		id = 9103,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "ValentineMackAwardCanvas"
	},
	[9104] = {
		ui_group = 60,
		prefab = "System/Activity/ActivityCookValentine/ValentineRecipeCanvas",
		ui_block = 1,
		ui_order = 60,
		id = 9104,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "ValentineRecipeCanvas"
	},
	[9105] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityCookValentine/ValentineGiveCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9105,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ValentineGiveCanvas"
	},
	[9106] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivitySnowOrNightBP13205/ActivitySnowOrNightBPCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9106,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivitySnowOrNightBPCanvas"
	},
	[9107] = {
		ui_group = 40,
		prefab = "System/Activity/ActivitySnowOrNightBP13205/SnowOrNightStarUnLockCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9107,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "SnowOrNightStarUnLockCanvas"
	},
	[9108] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityRailGunSupport/ActivityRailGunSupportMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9108,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityRailGunSupportMainCanvas"
	},
	[9109] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityAltmanSupport/ActivityAltmanSupportCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9109,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityAltmanSupportCanvas"
	},
	[9110] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityDispatch/ActivityDispatchMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9110,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityDispatchMainCanvas"
	},
	[9111] = {
		id = 9111,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/Activity/ActivityDispatch/ActivityDispatchSubmitCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivityDispatchSubmitCanvas"
	},
	[9112] = {
		id = 9112,
		ui_group = 60,
		ui_block = 1,
		prefab = "System/Activity/ActivityDispatch/ActivityDispatchTipsCanvas",
		ui_type = 3,
		need_hdr = 1,
		ui_order = 60,
		block_alpha = 1,
		prefabKey = "ActivityDispatchTipsCanvas"
	},
	[9113] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot11102/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9113,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9114] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot11102/ActivityPlotInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9114,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityPlotInfoCanvas"
	},
	[9115] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot11102/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9115,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9116] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot11102/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9116,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9117] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14016/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9117,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9118] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14016/ActivityPlotInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9118,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityPlotInfoCanvas"
	},
	[9119] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14016/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9119,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9120] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot14016/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9120,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9121] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivitySkinLotterySpring/ActivitySkinLotteryMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9121,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivitySkinLotteryMainCanvas"
	},
	[9122] = {
		id = 9122,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Activity/ActivitySkinLotterySpring/ActivitySkinLotteryClearCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivitySkinLotteryClearCanvas"
	},
	[9123] = {
		id = 9123,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Activity/ActivitySkinLotterySpring/ActivitySkinLotteryResultCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivitySkinLotteryResultCanvas"
	},
	[9124] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivitySnowOrNightBP11204/ActivitySnowOrNightBPCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9124,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivitySnowOrNightBPCanvas"
	},
	[9125] = {
		ui_group = 40,
		prefab = "System/Activity/ActivitySnowOrNightBP11204/SnowOrNightStarUnLockCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9125,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "SnowOrNightStarUnLockCanvas"
	},
	[9126] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot13016/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9126,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9127] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot13016/ActivityPlotInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9127,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityPlotInfoCanvas"
	},
	[9128] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot13016/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9128,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9129] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot13016/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9129,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9130] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityMayDayClean1/ActivityMayDayCleanMentionCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9130,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityMayDayCleanMentionCanvas"
	},
	[9131] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityMayDayClean1/ActivityMayDayCleanMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9131,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityMayDayCleanMainCanvas"
	},
	[9132] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityMayDayClean1/ActivityMayDayCleanInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9132,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityMayDayCleanInfoCanvas"
	},
	[9133] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityMayDayClean1/ActivityMayDayCleanAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9133,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityMayDayCleanAwardCanvas"
	},
	[9134] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityMayDayClean1/ActivityMayDayEventCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9134,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityMayDayEventCanvas"
	},
	[9135] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityFigureGuess/ActivityFigureGuessMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9135,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFigureGuessMainCanvas"
	},
	[9136] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityFigureGuess/GuessConfirmCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9136,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "GuessConfirmCanvas"
	},
	[9137] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityFigureGuess/ActivityGuessPondCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9137,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityGuessPondCanvas"
	},
	[9138] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityFigureGuess/GuessWinResultCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9138,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "GuessWinResultCanvas"
	},
	[9139] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityFigureGuess/GuessLoseResultCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9139,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "GuessLoseResultCanvas"
	},
	[9140] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14017/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9140,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9141] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14017/ActivityPlotInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9141,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityPlotInfoCanvas"
	},
	[9142] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14017/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9142,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9143] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot14017/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9143,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9144] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityFigureGuess/ActivityFigureGuessRankingCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9144,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFigureGuessRankingCanvas"
	},
	[9145] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14102/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9145,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9146] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14102/ActivityPlotInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9146,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityPlotInfoCanvas"
	},
	[9147] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14102/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9147,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9148] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot14102/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9148,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9149] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityBlackRockSupport/ActivityBlackRockSupportMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9149,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityBlackRockSupportMainCanvas"
	},
	[9150] = {
		prefab = "System/Activity/ActivityBlackRockSupport/BlackRockVanityInfoCanvas",
		ui_group = 40,
		ui_block = 1,
		ui_order = 40,
		ui_type = 2,
		need_hdr = 1,
		id = 9150,
		block_alpha = 1,
		shut_down_cam = 1,
		prefabKey = "BlackRockVanityInfoCanvas"
	},
	[9151] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivitySkinLottery/ActivitySkinLotteryMainCanvas2",
		ui_group = 20,
		ui_order = 20,
		id = 9151,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivitySkinLotteryMainCanvas2"
	},
	[9152] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityManagement1/ActivityManagementMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9152,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityManagementMainCanvas"
	},
	[9153] = {
		id = 9153,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Activity/ActivityManagement1/ActivityBPCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivityBPCanvas"
	},
	[9154] = {
		ui_group = 60,
		prefab = "System/Activity/ActivityManagement1/ActivityManagementToyInfoCanvas",
		ui_block = 1,
		ui_order = 60,
		id = 9154,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "ActivityManagementToyInfoCanvas"
	},
	[9155] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityManagement1/ActivityManagementChooseCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9155,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityManagementChooseCanvas"
	},
	[9156] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityManagement1/ActivityManagementInfoCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9156,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityManagementInfoCanvas"
	},
	[9157] = {
		id = 9157,
		ui_group = 20,
		ui_block = 0,
		prefab = "System/Activity/ActivityPreviewCanvas",
		ui_type = 1,
		need_hdr = 1,
		ui_order = 20,
		block_alpha = 1,
		prefabKey = "ActivityPreviewCanvas"
	},
	[9158] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot12014/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9158,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9159] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot12014/ActivityPlotInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9159,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityPlotInfoCanvas"
	},
	[9160] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot12014/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9160,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9161] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot12014/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9161,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9162] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityCookMidAutumn/ActivityMidAutumnMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9162,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityMidAutumnMainCanvas"
	},
	[9163] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityCookMidAutumn/MidAutumnChatCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9163,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "MidAutumnChatCanvas"
	},
	[9164] = {
		ui_group = 42,
		prefab = "System/Activity/ActivityCookMidAutumn/MidAutumnChatEndCanvas",
		ui_block = 1,
		ui_order = 42,
		id = 9164,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "MidAutumnChatEndCanvas"
	},
	[9165] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityCookMidAutumn/MidAutumnMackCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9165,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "MidAutumnMackCanvas"
	},
	[9166] = {
		ui_group = 60,
		prefab = "System/Activity/ActivityCookMidAutumn/MidAutumnMackAwardCanvas",
		ui_block = 1,
		ui_order = 60,
		id = 9166,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "MidAutumnMackAwardCanvas"
	},
	[9167] = {
		ui_group = 60,
		prefab = "System/Activity/ActivityCookMidAutumn/MidAutumnRecipeCanvas",
		ui_block = 1,
		ui_order = 60,
		id = 9167,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "MidAutumnRecipeCanvas"
	},
	[9168] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityCookMidAutumn/MidAutumnGiveCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9168,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "MidAutumnGiveCanvas"
	},
	[9169] = {
		ui_group = 60,
		prefab = "System/Activity/ActivityAnniversaryDraw/ActivityAnniversaryDrawCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 9169,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "ActivityAnniversaryDrawCanvas"
	},
	[9170] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot11012/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9170,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9171] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot11012/ActivityPlotInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9171,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityPlotInfoCanvas"
	},
	[9172] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot11012/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9172,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9173] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot11012/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9173,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9174] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivitySnowOrNightBP12206/ActivitySnowOrNightBPCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9174,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivitySnowOrNightBPCanvas"
	},
	[9175] = {
		ui_group = 40,
		prefab = "System/Activity/ActivitySnowOrNightBP12206/SnowOrNightStarUnLockCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9175,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "SnowOrNightStarUnLockCanvas"
	},
	[9176] = {
		need_hdr = 1,
		prefab = "System/Activity/CollectWords2/ActivityCollectWordsCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9176,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityCollectWordsCanvas"
	},
	[9177] = {
		id = 9177,
		ui_group = 40,
		ui_block = 0,
		prefab = "System/Activity/CollectWords2/ActivityCollectWordsGet",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 0,
		prefabKey = "ActivityCollectWordsGet"
	},
	[9178] = {
		ui_group = 40,
		prefab = "System/Activity/CollectWords2/CollectWordsPointTaskCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9178,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CollectWordsPointTaskCanvas"
	},
	[9179] = {
		ui_group = 40,
		prefab = "System/Activity/CollectWords2/CollectWordsChooseUseCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 9179,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CollectWordsChooseUseCanvas"
	},
	[9180] = {
		ui_group = 40,
		prefab = "System/Activity/CollectWords2/CollectWordsUseCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9180,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CollectWordsUseCanvas"
	},
	[9181] = {
		ui_group = 40,
		prefab = "System/Activity/CollectWords2/CollectWordsAVGPreviewCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9181,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "CollectWordsAVGPreviewCanvas"
	},
	[9182] = {
		need_hdr = 1,
		prefab = "System/Activity/CollectWords2/ActivityCollectWordsComposeCanvas",
		ui_group = 62,
		ui_order = 60,
		id = 9182,
		ui_type = 3,
		prefabKey = "ActivityCollectWordsComposeCanvas"
	},
	[9183] = {
		id = 9183,
		ui_group = 60,
		ui_block = 1,
		prefab = "System/Activity/CollectWords2/CollectWordsShowAwardCanvas",
		ui_type = 3,
		logic_flag = 1,
		ui_order = 60,
		block_alpha = 1,
		prefabKey = "CollectWordsShowAwardCanvas"
	},
	[9184] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot13017/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9184,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9185] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot13017/ActivityPlotInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9185,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityPlotInfoCanvas"
	},
	[9186] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot13017/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9186,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9187] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot13017/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9187,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9188] = {
		id = 9188,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Activity/ActivityGroupon/ActivityGrouponDrawLogCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivityGrouponDrawLogCanvas"
	},
	[9189] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPettyPay/ActivityPettyPayCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9189,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityPettyPayCanvas"
	},
	[9190] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPettyPay/ActivityDailyGiftCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9190,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityDailyGiftCanvas"
	},
	[9191] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPettyPay/Activity30DaysSignInCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9191,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "Activity30DaysSignInCanvas"
	},
	[9192] = {
		ui_group = 60,
		prefab = "System/Activity/ActivityGroupon/ActivityGroupon01/ActivityGrouponWinnerCanvas",
		ui_block = 0,
		ui_order = 60,
		id = 9192,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "ActivityGrouponWinnerCanvas"
	},
	[9193] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14018/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9193,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9194] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14018/ActivityPlotInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9194,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityPlotInfoCanvas"
	},
	[9195] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14018/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9195,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9196] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot14018/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9196,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9197] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot13108/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9197,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9198] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot13108/ActivityPlotInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9198,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityPlotInfoCanvas"
	},
	[9199] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot13108/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9199,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9200] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot13108/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9200,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9201] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityEquipWash/ActivityEquipWashChooseCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9201,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityEquipWashChooseCanvas"
	},
	[9202] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityEquipWash/ActivityEquipCustomCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9202,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityEquipCustomCanvas"
	},
	[9203] = {
		ui_group = 60,
		prefab = "System/Activity/ActivityEquipWash/ActivityEquipCustomRangeCanvas",
		ui_block = 1,
		ui_order = 60,
		id = 9203,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "ActivityEquipCustomRangeCanvas"
	},
	[9204] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityEquipWash/ActivityEquipCustomFinishCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9204,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityEquipCustomFinishCanvas"
	},
	[9205] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityEquipWash/ActivityEquipWashSuccessCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 9205,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityEquipWashSuccessCanvas"
	},
	[9206] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityEquipWash/ActivityEquipWashingCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9206,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityEquipWashingCanvas"
	},
	[9207] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityEquipWash/ActivityEquipWashingLvCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 9207,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityEquipWashingLvCanvas"
	},
	[9208] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityEquipWash/ActivityEquipWashingLvUpCanvas",
		ui_block = 1,
		ui_order = 40,
		id = 9208,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityEquipWashingLvUpCanvas"
	},
	[9209] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityDoaxvvSupport/ActivityDoaxvvSupportMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9209,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityDoaxvvSupportMainCanvas"
	},
	[9210] = {
		prefab = "System/Activity/ActivityDoaxvvSupport/DoaxvvVanityInfoCanvas",
		ui_group = 40,
		ui_block = 1,
		ui_order = 40,
		ui_type = 2,
		need_hdr = 1,
		id = 9210,
		block_alpha = 1,
		shut_down_cam = 1,
		prefabKey = "DoaxvvVanityInfoCanvas"
	},
	[9211] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivitySkinLotteryChristmas/ActivitySkinLotteryMainCanvas2",
		ui_group = 20,
		ui_order = 20,
		id = 9211,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivitySkinLotteryMainCanvas2"
	},
	[9212] = {
		ui_order = 96,
		prefab = "System/Activity/ActivityGroupon/GrouponConfirmBox",
		ui_block = 0,
		ui_type = 3,
		id = 9212,
		block_alpha = 1,
		with_state_close = 1,
		prefabKey = "GrouponConfirmBox"
	},
	[9213] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivitySnowOrNightBP12207/ActivitySnowOrNightBPCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9213,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivitySnowOrNightBPCanvas"
	},
	[9214] = {
		ui_group = 40,
		prefab = "System/Activity/ActivitySnowOrNightBP12207/SnowOrNightStarUnLockCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9214,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "SnowOrNightStarUnLockCanvas"
	},
	[9215] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot13018/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9215,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9216] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot13018/ActivityPlotInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9216,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityPlotInfoCanvas"
	},
	[9217] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot13018/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9217,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9218] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot13018/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9218,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9219] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityCookValentine/ValentineChatCanvas02",
		ui_block = 0,
		ui_order = 40,
		id = 9219,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ValentineChatCanvas02"
	},
	[9220] = {
		ui_group = 42,
		prefab = "System/Activity/ActivityCookValentine/ValentineChatEndCanvas02",
		ui_block = 1,
		ui_order = 42,
		id = 9220,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ValentineChatEndCanvas02"
	},
	[9221] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityCookValentine/ValentineGiveCanvas02",
		ui_block = 0,
		ui_order = 40,
		id = 9221,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ValentineGiveCanvas02"
	},
	[9222] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14015/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9222,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9223] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14015/ActivityPlotInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9223,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityPlotInfoCanvas"
	},
	[9224] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14015/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9224,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9225] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot14015/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9225,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9226] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot15102/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9226,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9227] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot15102/ActivityPlotInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9227,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityPlotInfoCanvas"
	},
	[9228] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot15102/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9228,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9229] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot15102/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9229,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9230] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityBaisheSupport/ActivityBaisheSupportMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9230,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityBaisheSupportMainCanvas"
	},
	[9231] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivitySnowOrNightBP12205/ActivitySnowOrNightBPCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9231,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivitySnowOrNightBPCanvas"
	},
	[9232] = {
		ui_group = 40,
		prefab = "System/Activity/ActivitySnowOrNightBP12205/SnowOrNightStarUnLockCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9232,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "SnowOrNightStarUnLockCanvas"
	},
	[9233] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivitySkinLotterySpring02/ActivitySkinLotteryMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9233,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivitySkinLotteryMainCanvas"
	},
	[9234] = {
		id = 9234,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Activity/ActivitySkinLotterySpring02/ActivitySkinLotteryClearCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivitySkinLotteryClearCanvas"
	},
	[9235] = {
		id = 9235,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Activity/ActivitySkinLotterySpring02/ActivitySkinLotteryResultCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivitySkinLotteryResultCanvas"
	},
	[9236] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14019/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9236,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9237] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14019/ActivityPlotInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9237,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityPlotInfoCanvas"
	},
	[9238] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14019/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9238,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9239] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot14019/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9239,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9240] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityAngelBeatsSupport/ActivityAngelBeatsSupportMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9240,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityAngelBeatsSupportMainCanvas"
	},
	[9241] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot11104/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9241,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9242] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot11104/ActivityPlotInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9242,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityPlotInfoCanvas"
	},
	[9243] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot11104/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9243,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9244] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot11104/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9244,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9245] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot12015/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9245,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9246] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot12015/ActivityPlotInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9246,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityPlotInfoCanvas"
	},
	[9247] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot12015/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9247,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9248] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot12015/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9248,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9249] = {
		id = 9249,
		ui_group = 60,
		ui_block = 1,
		prefab = "System/Activity/ActivityNewcomerBP/ShowAwardCanvas",
		ui_type = 3,
		need_hdr = 1,
		ui_order = 60,
		block_alpha = 1,
		prefabKey = "ShowAwardCanvas"
	},
	[9250] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityEquipRecycle/ActivityEquipRecycleInitialCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9250,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityEquipRecycleInitialCanvas"
	},
	[9251] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityEquipRecycle/ActivityEquipRecycleCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9251,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityEquipRecycleCanvas"
	},
	[9252] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityEquipRecycle/ActivityEquipRecycleEditCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9252,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityEquipRecycleEditCanvas"
	},
	[9253] = {
		id = 9253,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Activity/ActivityEquipRecycle/ActivityEquipRecycleRewardCanvas",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivityEquipRecycleRewardCanvas"
	},
	[9254] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityEquipRecycle/ActivityBraceletExchangeCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9254,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityBraceletExchangeCanvas"
	},
	[9255] = {
		ui_group = 60,
		prefab = "System/Activity/ActivityEquipRecycle/EquipRecycleSiftBoxCanvas",
		ui_block = 1,
		ui_order = 60,
		id = 9255,
		block_alpha = 1,
		ui_type = 3,
		prefabKey = "EquipRecycleSiftBoxCanvas"
	},
	[9256] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14020/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9256,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9257] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14020/ActivityPlotInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9257,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityPlotInfoCanvas"
	},
	[9258] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14020/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9258,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9259] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot14020/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9259,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9260] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivitySkinLottery/ActivitySkinLotteryMainCanvas3",
		ui_group = 20,
		ui_order = 20,
		id = 9260,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivitySkinLotteryMainCanvas3"
	},
	[9261] = {
		id = 9261,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Activity/ActivitySkinLottery/ActivitySkinLotteryClearCanvas2",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivitySkinLotteryClearCanvas2"
	},
	[9262] = {
		id = 9262,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Activity/ActivitySkinLottery/ActivitySkinLotteryResultCanvas2",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivitySkinLotteryResultCanvas2"
	},
	[9263] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot15103/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9263,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9264] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot15103/ActivityPlotInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9264,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityPlotInfoCanvas"
	},
	[9265] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot15103/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9265,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9266] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot15103/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9266,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9267] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityClannadSupport/ActivityClannadSupportMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9267,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityClannadSupportMainCanvas"
	},
	[9268] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot12016/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9268,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9269] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot12016/ActivityPlotInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9269,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityPlotInfoCanvas"
	},
	[9270] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot12016/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9270,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9271] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot12016/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9271,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9272] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityCookMidAutumn/MidAutumnChatCanvas02",
		ui_block = 0,
		ui_order = 40,
		id = 9272,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "MidAutumnChatCanvas02"
	},
	[9273] = {
		ui_group = 42,
		prefab = "System/Activity/ActivityCookMidAutumn/MidAutumnChatEndCanvas02",
		ui_block = 1,
		ui_order = 42,
		id = 9273,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "MidAutumnChatEndCanvas02"
	},
	[9274] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityCookMidAutumn/MidAutumnGiveCanvas02",
		ui_block = 0,
		ui_order = 40,
		id = 9274,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "MidAutumnGiveCanvas02"
	},
	[9275] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityLittleBustersSupport/ActivityLittleBustersSupportMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9275,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityLittleBustersSupportMainCanvas"
	},
	[9276] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14103/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9276,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9277] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14103/ActivityPlotInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9277,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityPlotInfoCanvas"
	},
	[9278] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14103/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9278,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9279] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot14103/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9279,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9280] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot11013/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9280,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9281] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot11013/ActivityPlotInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9281,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityPlotInfoCanvas"
	},
	[9282] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot11013/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9282,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9283] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot11013/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9283,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9284] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivitySkinLotteryChristmas/ActivitySkinLotteryMainCanvas3",
		ui_group = 20,
		ui_order = 20,
		id = 9284,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivitySkinLotteryMainCanvas3"
	},
	[9285] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14021/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9285,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9286] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14021/ActivityPlotInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9286,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityPlotInfoCanvas"
	},
	[9287] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14021/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9287,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9288] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot14021/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9288,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9289] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot11014/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9289,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9290] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot11014/ActivityPlotInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9290,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityPlotInfoCanvas"
	},
	[9291] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot11014/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9291,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9292] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot11014/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9292,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9293] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot13019/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9293,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9294] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot13019/ActivityPlotInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9294,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityPlotInfoCanvas"
	},
	[9295] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot13019/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9295,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9296] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot13019/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9296,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9297] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivitySnowOrNightBP15203/ActivitySnowOrNightBPCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9297,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivitySnowOrNightBPCanvas"
	},
	[9298] = {
		ui_group = 40,
		prefab = "System/Activity/ActivitySnowOrNightBP15203/SnowOrNightStarUnLockCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9298,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "SnowOrNightStarUnLockCanvas"
	},
	[9299] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot12017/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9299,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9300] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot12017/ActivityPlotInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9300,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityPlotInfoCanvas"
	},
	[9301] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot12017/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9301,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9302] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot12017/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9302,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9303] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityAliceSupport/ActivityAliceSupportMainCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9303,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityAliceSupportMainCanvas"
	},
	[9304] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14022/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9304,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9305] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14022/ActivityPlotInfoCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9305,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityPlotInfoCanvas"
	},
	[9306] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot14022/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9306,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9307] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot14022/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9307,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9308] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot12018/ActivityFlotCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9308,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotCanvas"
	},
	[9309] = {
		ui_group = 20,
		prefab = "System/Activity/ActivityPlot12018/ActivityFlotInfoCanvas",
		ui_order = 20,
		ui_type = 1,
		id = 9309,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotInfoCanvas"
	},
	[9310] = {
		need_hdr = 1,
		prefab = "System/Activity/ActivityPlot12018/ActivityFlotFightCanvas",
		ui_group = 20,
		ui_order = 20,
		id = 9310,
		ui_type = 1,
		shut_down_cam = 1,
		prefabKey = "ActivityFlotFightCanvas"
	},
	[9311] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot12018/ActivityFlotTargetCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9311,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityFlotTargetCanvas"
	},
	[9312] = {
		ui_group = 40,
		prefab = "System/Activity/ActivityPlot12018/ActivityCleanAwardCanvas",
		ui_block = 0,
		ui_order = 40,
		id = 9312,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "ActivityCleanAwardCanvas"
	},
	[9992] = {
		ui_order = 50,
		prefab = "LoadingCanvas",
		ui_type = 4,
		id = 9992,
		shut_down_cam = 1,
		prefabKey = "LoadingCanvas"
	},
	[1001401] = {
		ui_order = 60,
		prefab = "System/Common/ConfirmBox/BirthdayConfirmBox_ja",
		ui_block = 0,
		ui_group = 60,
		ui_type = 3,
		with_state_close = 1,
		id = 1001401,
		block_alpha = 1,
		prefabKey = "BirthdayConfirmBox_ja"
	},
	[1001402] = {
		ui_order = 60,
		prefab = "System/Common/ConfirmBox/DiamondConfirmBox_ja",
		ui_block = 0,
		ui_group = 60,
		ui_type = 3,
		with_state_close = 1,
		id = 1001402,
		block_alpha = 1,
		prefabKey = "DiamondConfirmBox_ja"
	},
	[1001901] = {
		ui_group = 40,
		prefab = "System/Store/StoreLawCheckCanvas_ja",
		ui_block = 0,
		ui_order = 40,
		id = 1001901,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "StoreLawCheckCanvas_ja"
	},
	[1001902] = {
		ui_group = 40,
		prefab = "System/Store/MonthCardConfirmBox_ja",
		ui_block = 0,
		ui_order = 40,
		id = 1001902,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "MonthCardConfirmBox_ja"
	},
	[1002801] = {
		ui_group = 40,
		prefab = "System/Login/AnnouncementCanvas_ja",
		ui_block = 0,
		ui_order = 40,
		id = 1002801,
		block_alpha = 1,
		ui_type = 2,
		prefabKey = "AnnouncementCanvas_ja"
	},
	[3003801] = {
		id = 3003801,
		ui_group = 40,
		ui_block = 1,
		prefab = "System/Activity/ActivityBilibiliOpenAchiCanvas_cht",
		ui_type = 2,
		need_hdr = 1,
		ui_order = 40,
		block_alpha = 1,
		prefabKey = "ActivityBilibiliOpenAchiCanvas_cht"
	}
}

return Data
