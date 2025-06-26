-- chunkname: @IQIGame\\UI\\ChallengeWorldBossUI.lua

local ChallengeWorldBossUI_RightView = require("IQIGame/UI/ChallengeWorldBossUI/ChallengeWorldBossUI_RightView")
local ChallengeWorldBossUI_EntryPopupView = require("IQIGame/UI/ChallengeWorldBossUI/ChallengeWorldBossUI_EntryPopupView")
local FormationEnemyView = require("IQIGame/UI/Formation/FormationEnemyView")
local ChallengeWorldBossUI = {}

ChallengeWorldBossUI = Base:Extend("ChallengeWorldBossUI", "IQIGame.Onigao.UI.ChallengeWorldBossUI", ChallengeWorldBossUI)

function ChallengeWorldBossUI:OnInit()
	self.commonReturnBtn = CommonReturnBtn.New(self.CommonReturnBtnRoot, self)
	self.rightView = ChallengeWorldBossUI_RightView.New(self.RightViewRoot)
	self.entryPopupView = ChallengeWorldBossUI_EntryPopupView.New(self.EntryPopupViewRoot)
	self.commonNpcTalk = CommonNpcTalkView.New(self.CommonTalkRoot)
	self.monsterTeamView = FormationEnemyView.New(self.EnemyTeamViewRoot)
end

function ChallengeWorldBossUI:GetPreloadAssetPaths()
	return nil
end

function ChallengeWorldBossUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ChallengeWorldBossUI:IsManualShowOnOpen(userData)
	return false
end

function ChallengeWorldBossUI:GetBGM(userData)
	return nil
end

function ChallengeWorldBossUI:OnOpen(userData)
	self.entryPopupView:Hide()
	self.monsterTeamView:Hide()
	self.PreviewBtn.gameObject:SetActive(false)

	local chapterCfg = ChallengeWorldBossModule.GetCurChapterCfg()

	self.chapterCid = chapterCfg.Id

	local stageCfg = ChallengeWorldBossModule.GetCurWorldBossStageCfg(self.chapterCid)

	self.stageCid = stageCfg.Id

	self.commonNpcTalk:Refresh(stageCfg.GroupId, Constant.NPCTriggerType.OpenUI, getHourText(PlayerModule.GetServerTime()))
	self.rightView:Show(self.chapterCid, stageCfg, userData.rankData, userData.goalieData)
end

function ChallengeWorldBossUI:OnClose(userData)
	return
end

function ChallengeWorldBossUI:OnAddListeners()
	UIEventUtil.AddClickEventListener_Button(self, "PreviewBtn", self.__OnPreviewBtnClickHandler)
	UIEventUtil.AddClickEventListener_Button(self, "TopRewardBtn", self.__OnTopRewardBtnClickHandler)
	UIEventUtil.AddClickEventListener_Button(self, "TopBtn", self.__OnTopBtnClickHandler)
	UIEventUtil.AddClickEventListener_Button(self, "ShopBtn", self.__OnShopBtnClickHandler)
	EventUtil.AddEventListener(self, EventID.ChallengeWorldBossUI_EntryItemClick, self.__OnEntryItemClickHandler)
	EventUtil.AddEventListener(self, EventID.ChallengeWorldBossUI_MonsterItemClick, self.__OnMonsterItemClickHandler)
end

function ChallengeWorldBossUI:OnRemoveListeners()
	UIEventUtil.ClearEventListener(self)
	EventUtil.ClearEventListener(self)
end

function ChallengeWorldBossUI:OnPause()
	return
end

function ChallengeWorldBossUI:OnResume()
	return
end

function ChallengeWorldBossUI:OnCover()
	return
end

function ChallengeWorldBossUI:OnReveal()
	return
end

function ChallengeWorldBossUI:OnRefocus(userData)
	return
end

function ChallengeWorldBossUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.commonNpcTalk:Update(elapseSeconds, realElapseSeconds)
end

function ChallengeWorldBossUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ChallengeWorldBossUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ChallengeWorldBossUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ChallengeWorldBossUI:OnDestroy()
	self.monsterTeamView:Dispose()
	self.commonNpcTalk:Dispose()
	self.entryPopupView:Dispose()
	self.commonReturnBtn:Dispose()
	self.rightView:Dispose()
end

function ChallengeWorldBossUI:__OnPreviewBtnClickHandler()
	return
end

function ChallengeWorldBossUI:__OnTopRewardBtnClickHandler()
	ChallengeWorldBossModule.OpenChallengeWorldBossRewardUI()
end

function ChallengeWorldBossUI:__OnTopBtnClickHandler()
	ChallengeWorldBossModule.OpenChallengeWorldBossRankUI()
end

function ChallengeWorldBossUI:__OnShopBtnClickHandler()
	JumpModule.Jump(20000074)
end

function ChallengeWorldBossUI:__OnEntryItemClickHandler(entryCid)
	self.entryPopupView:Show(entryCid)
end

function ChallengeWorldBossUI:__OnMonsterItemClickHandler(chapterCid, stageCid, monsterCid)
	local curStageCfg = ChallengeWorldBossModule.GetCurWorldBossStageCfg(chapterCid)

	self.monsterTeamView:Show(curStageCfg.MonsterTeam)
end

return ChallengeWorldBossUI
