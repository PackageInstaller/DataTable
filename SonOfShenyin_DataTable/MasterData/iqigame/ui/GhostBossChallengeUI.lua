-- chunkname: @IQIGame\\UI\\GhostBossChallengeUI.lua

local GhostBossChallengeUI = {}

GhostBossChallengeUI = Base:Extend("GhostBossChallengeUI", "IQIGame.Onigao.UI.GhostBossChallengeUI", GhostBossChallengeUI)

local bossItemClass = require("IQIGame/UI/ActiveActivityList/GhostActivity/GhostBossUI_bossTabItem")
local buffItemClass = require("IQIGame/UI/ActiveActivityList/GhostActivity/GhostBossUI_buffItem")
local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local scoreDetailPanelClass = require("IQIGame/UI/ActiveActivityList/GhostActivity/GhostBossUI_scoreDetailPanel")
local buffDetailPanelClass = require("IQIGame/UI/ActiveActivityList/GhostActivity/GhostBossUI_buffDetailPanel")
local dataName_mark = "mark"

function GhostBossChallengeUI:OnInit()
	self:InitMembers()
	self:InitDelegate()
	self:InitComponent()
end

function GhostBossChallengeUI:InitMembers()
	return
end

function GhostBossChallengeUI:InitComponent()
	self.returnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
	self.bossItemPool = UIViewObjectPool.New(self.TabPrefab, self.LeftTabContent.transform, function(_view)
		return bossItemClass.New(_view, self)
	end)
	self.bossBuffPool = UIViewObjectPool.New(self.effectCell, self.effectCellParent.transform, function(_view)
		return buffItemClass.New(_view, self)
	end)
	self.scoreDetailPanel = scoreDetailPanelClass.New(self.ScoreDetailsPanel, self)

	self.scoreDetailPanel:Hide()

	self.buffDetailPanel = buffDetailPanelClass.New(self.EffectDetailPanel, self)

	self.buffDetailPanel:Hide()
end

function GhostBossChallengeUI:InitDelegate()
	function self.onBossTabSelectEvent(diffItem)
		self:OnBossTabSelect(diffItem)
	end

	function self.delegateOnClickEnterGameBtn()
		self:OnClickEnterGameBtn()
	end

	function self.delegateOnClickShopBtn()
		self:OnClickShopBtn()
	end

	function self.delegateOnClickTaskBtn()
		self:OnClickTaskBtn()
	end

	function self.delegateOnClickScoreBtn()
		self:OnClickScoreBtn()
	end

	function self.onRefreshRedDot()
		self:Refresh()
		self:RefreshDetails()
	end
end

function GhostBossChallengeUI:OnAddListeners()
	self.EnterGameBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickEnterGameBtn)
	self.ShopBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickShopBtn)
	self.TaskBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickTaskBtn)
	self.ScoreBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickScoreBtn)
	EventDispatcher.AddEventListener(EventID.GhostActivity_OnBossItemSelectEvent, self.onBossTabSelectEvent)
	EventDispatcher.AddEventListener(EventID.OnTaskRedDotEvent, self.onRefreshRedDot)
end

function GhostBossChallengeUI:OnRemoveListeners()
	self.EnterGameBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickEnterGameBtn)
	self.ShopBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickShopBtn)
	self.TaskBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickTaskBtn)
	self.ScoreBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickScoreBtn)
	EventDispatcher.RemoveEventListener(EventID.GhostActivity_OnBossItemSelectEvent, self.onBossTabSelectEvent)
	EventDispatcher.RemoveEventListener(EventID.OnTaskRedDotEvent, self.onRefreshRedDot)
end

function GhostBossChallengeUI:OnClickScoreBtn()
	self.scoreDetailPanel:Show()
	self.scoreDetailPanel:Refresh(self.currentBossItem.data.ChapterId)
end

function GhostBossChallengeUI:OnClickTaskBtn()
	UIModule.Open(Constant.UIControllerName.GhostActivityTaskUI, Constant.UILayer.UI, {
		selectChapterId = self.currentBossItem.data.ChapterId
	})
end

function GhostBossChallengeUI:OnClickShopBtn()
	UIModule.Open(Constant.UIControllerName.ActivityShopUI, Constant.UILayer.UI, {
		activityPod = self.activityPod
	})
end

function GhostBossChallengeUI:OnClickEnterGameBtn()
	local userData = {}

	userData.OpenType = 2
	userData.ChapterType = Constant.ChapterPassType.Type_GhostBoss
	userData.StageId = self.currentBossItem.data.Id

	UIModule.Open(Constant.UIControllerName.FormationUI, Constant.UILayer.UI, userData)
end

function GhostBossChallengeUI:OnBossTabSelect(diffItem)
	if self.currentBossItem then
		self.currentBossItem:UnSelected()

		self.currentBossItem = nil
	end

	self.currentBossItem = diffItem

	self.currentBossItem:Selected()
	self:RefreshDetails()
end

function GhostBossChallengeUI:OnOpen(userData)
	self.activityPod = userData.activityPod
	self.cfgActivity = CfgUtil.GetCfgActivityDataWithID(self.activityPod.cid)

	self:Refresh()

	if userData.selectChapterId then
		self:SelectWithStageId(userData.selectChapterId)
	else
		self:SelectFirst()
	end
end

function GhostBossChallengeUI:OnClose(userData)
	return
end

function GhostBossChallengeUI:GetPreloadAssetPaths()
	return nil
end

function GhostBossChallengeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GhostBossChallengeUI:IsManualShowOnOpen(userData)
	return false
end

function GhostBossChallengeUI:GetBGM(userData)
	return nil
end

function GhostBossChallengeUI:OnPause()
	return
end

function GhostBossChallengeUI:OnResume()
	return
end

function GhostBossChallengeUI:OnCover()
	return
end

function GhostBossChallengeUI:OnReveal()
	return
end

function GhostBossChallengeUI:OnRefocus(userData)
	return
end

function GhostBossChallengeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GhostBossChallengeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GhostBossChallengeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GhostBossChallengeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GhostBossChallengeUI:Refresh()
	self:RefreshTabScroll()
end

function GhostBossChallengeUI:RefreshRedDot()
	if not self.currentBossItem then
		return
	end

	local chapterData = self.currentBossItem:GetCfgBossStageData()

	LuaUtility.SetGameObjectShow(self.RedDot_task, RedDotModule.ghostBossTaskDic and RedDotModule.ghostBossTaskDic[chapterData.ChapterId])
end

function GhostBossChallengeUI:RefreshTabScroll()
	local bossArray = BossChapterModule.GetChapterDataWithType(self.cfgActivity.ExtraParam[3])

	self.bossItemPool:ForItems(function(_item)
		_item:Hide()
	end)

	local len = #bossArray

	for i = 1, len do
		local tabItem = self.bossItemPool:GetFree(function(_item)
			return not _item.gameObject.activeSelf
		end)

		tabItem:Show()
		tabItem:Refresh(bossArray[i], i)
	end
end

function GhostBossChallengeUI:RefreshDetails()
	if not self.currentBossItem then
		return
	end

	local cfgBossStage = self.currentBossItem:GetCfgBossStageData()

	LuaUtility.SetText(self.bossNameText, cfgBossStage.Name)
	LuaUtility.SetStateController(self.gameObject, dataName_mark, BossChapterModule.GetMarkWithScore(cfgBossStage.ChapterId, self.currentBossItem:GetChapterData().optimalIntegral and self.currentBossItem:GetChapterData().optimalIntegral or 0))
	LuaUtility.SetText(self.textScore, self.currentBossItem:GetChapterData().optimalIntegral and self.currentBossItem:GetChapterData().optimalIntegral or 0)
	LuaUtility.SetText(self.textRecommonLv, cfgBossStage.RecommendLevel)
	LuaUtility.LoadImage(self, UIGlobalApi.GetImagePath(self.currentBossItem:GetChapterData():GetCfg().ChapterNameImg), self.bossImg:GetComponent("Image"))
	self.bossBuffPool:ForItems(function(_item)
		_item:Hide()
	end)

	local buffArray = self.currentBossItem:GetChapterData():GetCfg().BossBuff
	local len = #buffArray

	for i = 1, len do
		local tabItem = self.bossBuffPool:GetFree(function(_item)
			return not _item.gameObject.activeSelf
		end)

		tabItem:Show()
		tabItem:Refresh(buffArray[i])
	end

	self:RefreshRedDot()
end

function GhostBossChallengeUI:ShowBuffDetail(buffId)
	self.buffDetailPanel:Show()
	self.buffDetailPanel:Refresh(buffId)
end

function GhostBossChallengeUI:SelectFirst()
	self.bossItemPool:ForItems(function(_item)
		if _item.index == 1 then
			_item:SelectFirst()

			return true
		end
	end)
end

function GhostBossChallengeUI:SelectWithStageId(stageId)
	self.bossItemPool:ForItems(function(_item)
		_item:SelectWithStageId(stageId)
	end)
end

function GhostBossChallengeUI:OnDestroy()
	self.bossItemPool:Dispose(function(_item)
		_item:OnDestroy()
	end)
	self.returnBtn:Dispose()
	AssetUtil.UnloadAsset(self)
end

return GhostBossChallengeUI
