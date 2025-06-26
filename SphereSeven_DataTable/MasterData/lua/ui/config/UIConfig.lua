--[[
-- added by wsh @ 2017-11-30
-- UI模块配置表，添加新UI模块时需要在此处加入
--]]

local UIModule = {
	-- 模块 = 模块配置表
	UILogin = require "UI.UILogin.UILoginConfig",
	UISsLogin = require "UI.UISsLogin.UISsLoginConfig",
	UILoading = require "UI.UILoading.UILoadingConfig",
	UINoticeTip = require "UI.UINoticeTip.UINoticeTipConfig",
	UITestMain = require "UI.UITestMain.UITestMainConfig",
	UIHome = require "UI.UIHome.UIHomeConfig",
	UIPlayerInceptionInfo =require "UI.UIPlayerInceptionInfo.UIPlayerInceptionInfoConfig",
	UILaunchAtk = require "UI.UILaunchAtk.UILaunchAtkConfig",
	UISelect = require "UI.UISelect.UISelectConfig",
	UIThingsDetail = require "UI.UIThingsDetail.UIThingsDetailConfig",
	UIFormatNew = require "UI.UIFormatNew.UIFormatNewConfig",

	UISummon = require "UI.UISummon.UISummonConfig",
	
	UIShop = require"UI.UIShop.UIShopConfig",
	UIActivityShop = require"UI.UIShop.UIActivityShop.UIActivityShopConfig",
	
	UIRisk = require"UI.UIRisk.UIRiskConfig",

	UIFungusBg = require"UI.UIFungusBg.UIFungusBgConfig",
	UITestTool = require"UI.UITestTool.UITestToolConfig",
	UITestCurrency = require"UI.UITestCurrency.UITestCurrencyConfig",

	UIActivity = require("UI.UIActivity.UIActivityConfig"),
	UIActivityPop = require("UI.UIActivity.UIActivityPopConfig"),
	UIShowStarLightList = require("UI.UIActivity.UIShowStarLightList.UIShowStarLightListConfig"),
	UIActivityFightSoulelist = require("UI.UIActivity.UIActivityFightSoulelist.UIActivityFightSoulelistConfig"),

	--强化界面
	UIMainIntens = require"UI.UIIntens.UIMainIntens.UIMainIntensConfig", 
	UICardIntens = require"UI.UIIntens.UICardIntens.UICardIntensConfig",
	UIEquipIntens = require"UI.UIIntens.UIEquipIntens.UIEquipIntensConfig",
	
	UIEquipChangeState1 = require "UI.UIIntens.UIEquipIntens.UIEquipChangeState1.UIEquipChangeState1Config",
	UIEquipChangeState2 = require "UI.UIIntens.UIEquipIntens.UIEquipChangeState2.UIEquipChangeState2Config",

	UIFightSoulChangeState1 = require "UI.UIIntens.UIFightSoulIntens.UIFightSoulChangeState1.UIFightSoulChangeState1Config",
	UIFightSoulChangeState2 = require "UI.UIIntens.UIFightSoulIntens.UIFightSoulChangeState2.UIFightSoulChangeState2Config",
	
	UIEquipLvUpState1 = require "UI.UIIntens.UIEquipIntens.UIEquipLvUpState1.UIEquipLvUpState1Config",
	UIEquipLvUpState2 = require "UI.UIIntens.UIEquipIntens.UIEquipLvUpState2.UIEquipLvUpState2Config",

	UIEquipResolveProp = require "UI.UIIntens.UIEquipIntens.UIEquipResolveProp.UIEquipResolvePropConfig",
	
	UISkin = require"UI.UIIntens.UISkin.UISkinConfig",
	UIFightSoulIntens = require"UI.UIIntens.UIFightSoulIntens.UIFightSoulIntensConfig",

	UIEquipInfo = require"UI.UIEquipInfo.UIEquipInfoConfig",

	UIShowFightSoulProp =  require"UI.UIIntens.UIFightSoulIntens.UIShowFightSoulProp.UIShowFightSoulPropConfig",

	UIFightSoulInfo = require"UI.UIFightSoulInfo.UIFightSoulInfoConfig",

	UIFightSoulList = require"UI.UIFightSoulList.UIFightSoulListConfig",
	
	--物品栏
	UIShowProp = require"UI.UIShowProp.UIShowPropConfig",
	
	--角色选择
	UIShowCard = require"UI.UIShowCard.UIShowCardConfig",
	UIShowEquip = require"UI.UIShowEquip.UIShowEquipConfig",

	--提示框
	ToolTipFirst = require "UI.ToolTip.ToolTipConfig",
	
	--描述
	UIDetail = require"UI.UIDetail.UIDetailConfig",

	UICardMsg = require"UI.UICardMsg.UICardMsgConfig",

	UICardFace = require "UI.UICardFace.UICardFaceConfig",

	--UITeamIntens = require "UI.UITeamIntens.UITeamIntensConfig",
	
	--设置
	UISetting = require "UI.UISetting.UISettingConfig",
	
	UILoad = require "UI.UILoad.UILoadConfig",

	UITransition = require "UI.UITransition.UITransitionConfig",

	UIBattleSettle = require "UI.UIBattleSettle.UIBattleSettleConfig",


	UISupport = require "UI.UISupport.UISupportConfig",

	UIBattle = require "GameLogic.Battle.UI.UIBattleConfig",

	UISkillSkip=require "GameLogic.Battle.UI.UISkillSkip.UISkillSkipConfig",

	UIHandBook = require "UI.UIHandBook.UIHandBookConfig",

	UIRoom = require "UI.UIRoom.UIRoomConfig",

	UIFriend = require "UI.UIFriend.UIFriendConfig",
	
	UISignIn = require "UI.UIDailyReward.UIDailyRewardConfig",

	UITask = require "UI.UITask.UITaskConfig",

	UIPostBox = require "UI.UIPostBox.UIPostBoxConfig",

	UIInform = require "UI.UIInform.UIInformConfig",
	
	UIProp = require "UI.UIProp.UIPropConfig",

	UIBattleMode = require "UI.UIBattleMode.UIBattleModeConfig",

	UISevenStar = require "UI.UISevenStar.UISevenStarConfig",

	UINoviceGuide = require "UI.UINoviceGuide.UINoviceGuideConfig",

	UICardList = require "UI.UICardList.UICardListConfig",

	UITestLaunchAtk = require "UI.UITestLaunchAtk.UITestLaunchAtkConfig",

	UILordMode = require "UI.UILordMode.UILordModeConfig",
	
	UILordRoad = require "UI.UILordRoad.UILordRoadConfig",

	UILordTower = require "UI.UILordTower.UILordTowerConfig",
	UILordLand = require "UI.UILordLand.UILordLandConfig",

	UIBattleLose = require "UI.UIBattleLose.UIBattleLoseConfig",

	UISummonTip = require "UI.UISummonTip.UISummonTipConfig",

	UILaunchAtkBg = require "UI.UILaunchAtkBg.UILaunchAtkBgConfig",

	UISummonStage1 = require "UI.UISummonStage1.UISummonStage1Config",
	UISummonStage2 = require "UI.UISummonStage2.UISummonStage2Config",
	UISummonStage3 = require "UI.UISummonStage3.UISummonStage3Config",
	UISummonFormula = require "UI.UISummon.UISummonFormula.UISummonFormulaConfig",

	UISkinGuide = require "UI.UISkinGuide.UISkinGuideConfig",
	
	UIPlayerInfo = require "UI.UIPlayerInfo.UIPlayerInfoConfig",
	UIRoleInfo = require "UI.UIRoleInfo.UIRoleInfoConfig",

	UISoundSet = require "UI.UISoundSet.UISoundSetConfig",
	UINameEdit = require "UI.UINameEdit.UINameEditConfig",
	UISetIcon = require "UI.UISetIcon.UISetIconConfig",
	UICardSort = require "UI.UICardSort.UICardSortConfig",
	UIEquipSort1 = require "UI.UIEquipSort1.UIEquipSort1Config",
	UIEquipSort2 = require "UI.UIEquipSort2.UIEquipSort2Config",
	UIFightSoulSort = require "UI.UIFightSoulSort.UIFightSoulSortConfig",

	UICompetition = require "UI.UICompetition.UICompetitionConfig",
	UIChallenge = require "UI.UIChallenge.UIChallengeConfig",
	
	UIStoryChapter = require "UI.UIStoryChapter.UIStoryChapterConfig",
	
	UICompetitionRule = require "UI.UICompetitionRule.UICompetitionRuleConfig",
	UICompetitionPlayerInfo = require "UI.UICompetitionPlayerInfo.UICompetitionPlayerInfoConfig",
	UIEquipState = require "UI.UICompetitionPlayerInfo.UIEquipState.UIEquipStateConfig",
	UIFightSoulState = require "UI.UICompetitionPlayerInfo.UIFightSoulState.UIFightSoulStateConfig",


	UIReward = require "UI.UIReward.UIRewardConfig",

	UIShowPaint = require "UI.UIShowPaint.UIShowPaintConfig",

	UIDialog = require "UI.UIDialog.UIDialogConfig",

	UIOriginalPainting = require "UI.UIOriginalPainting.UIOriginalPaintingConfig",

	UILive2d = require "UI.UILive2d.UILive2dConfig",

	UIGetMarried = require "UI.UIGetMarried.UIGetMarriedConfig",
	
	UICardEvolve = require "UI.UIIntens.UICardIntens.UICardEvolve.UICardEvolveConfig",

	UICardLvUp = require "UI.UIIntens.UICardIntens.UICardLvUp.UICardLvUpConfig",

	UICardLimit = require "UI.UIIntens.UICardIntens.UICardLimit.UICardLimitConfig",

	UICardLvUpStage1 = require "UI.UIIntens.UICardIntens.UICardLvUpStage1.UICardLvUpStage1Config",

	UICardEvolveStage1 = require "UI.UIIntens.UICardIntens.UICardEvolveStage1.UICardEvolveStage1Config",

	UICardEvolveStage2 = require "UI.UIIntens.UICardIntens.UICardEvolveStage2.UICardEvolveStage2Config",

	UICardEvolveStage3 = require "UI.UIIntens.UICardIntens.UICardEvolveStage3.UICardEvolveStage3Config",


	UICardLimitStage1 = require "UI.UIIntens.UICardIntens.UICardLimitStage1.UICardLimitStage1Config",

	UICardLimitStage2 = require "UI.UIIntens.UICardIntens.UICardLimitStage2.UICardLimitStage2Config",

	UICardFriendlyMax = require "UI.UIIntens.UICardIntens.UICardFriendlyMax.UICardFriendlyMaxConfig",

	UIFightSoulFuse = require "UI.UIIntens.UIFightSoulIntens.UIFightSoulFuse.UIFightSoulFuseConfig",

	UIFightSoulFuseStage1 = require "UI.UIIntens.UIFightSoulIntens.UIFightSoulFuseStage1.UIFightSoulFuseStage1Config",

	UIFightSoulFuseStage2 = require "UI.UIIntens.UIFightSoulIntens.UIFightSoulFuseStage2.UIFightSoulFuseStage2Config",

	UISkipHint = require "UI.UISkipHint.UISkipHintConfig",

	UIEquipRecastFormula = require "UI.UIEquipRecastFormula.UIEquipRecastFormulaConfig",

	UIStorySectionInfo = require"UI.UIStorySectionInfo.UIStorySectionInfoConfig",

	UISevenStarSectionInfo = require"UI.UISevenStarSectionInfo.UISevenStarSectionInfoConfig",

	UILordRoadSectionInfo = require"UI.UILordRoadSectionInfo.UILordRoadSectionInfoConfig",

	UILordTowerSectionInfo = require "UI.UILordTowerSectionInfo.UILordTowerSectionInfoConfig",

	UIFightSoulFormula = require "UI.UIFightSoulFormula.UIFightSoulFormulaConfig",

	UIEquipProp = require "UI.UIEquipProp.UIEquipPropConfig",

	UIEchoChromeSettleConfig = require "UI.UIEchoChromeSettle.UIEchoChromeSettleConfig",

	UIExpeditionConfig = require "UI.UIExpedition.UIExpeditionConfig",

	UIExpeditionTipConfig = require "UI.UIExpeditionTip.UIExpeditionTipConfig",

	UIExpeditionSelectCardConfig = require "UI.UIExpeditionSelectCard.UIExpeditionSelectCardConfig",

	UIFightSoul = require"UI.UIFightSoul.UIFightSoulConfig",

	UIEquipLevelUp = require"UI.UIIntens.UIEquipIntens.UIEquipLevelUp.UIEquipLevelUpConfig",
	UIEquipScrap = require"UI.UIIntens.UIEquipIntens.UIEquipScrap.UIEquipScrapConfig",
	UIChooseEquip = require"UI.UIIntens.UIEquipIntens.UIChooseEquip.UIChooseEquipConfig",


	UICommonLevel = require"UI.UICommonLevel.UICommonLevelConfig",

	UIGameEvent = require"UI.UIGameEvent.UIGameEventConfig",
	
	UIBattlePass = require"UI.UIBattlePass.UIBattlePassConfig",

	UIBossraid = require "UI.UIBossraid.UIBossraidConfig",

	UIGameEventLevel = require"UI.UIGameEventLevel.UIGameEventLevelConfig",
}

local UIConfig = {}
for _,ui_module in pairs(UIModule) do
	for _,ui_config in pairs(ui_module) do
		local ui_name = ui_config.Name
	    assert(UIConfig.ui_name == nil, "Aready exsits : "..ui_name)
		if ui_config.View then
			assert(ui_config.PrefabPath ~= nil and #ui_config.PrefabPath > 0, ui_name.." PrefabPath empty.")
		end
		UIConfig[ui_name] = ui_config
	end
end

return ConstClass("UIConfig", UIConfig)