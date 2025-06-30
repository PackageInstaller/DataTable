-- chunkname: @IQIGame\\UI\\GhostActivityStageUI.lua

local GhostActivityStageUI = {}

GhostActivityStageUI = Base:Extend("GhostActivityStageUI", "IQIGame.Onigao.UI.GhostActivityStageUI", GhostActivityStageUI)

local detailPanelClass = require("IQIGame/UI/SummerActivity/SummerActivityStageUI_detailPanel")
local stagePanelClass = require("IQIGame/UI/SummerActivity/SummerActivityStageUI_stagePanel")
local tabItemClass = require("IQIGame/UI/SummerActivity/SummerActivityStageUI_tabItem")
local MultipleFightPopupView = require("IQIGame/UI/SummerActivity/SummerActivityStageUI_MultipleFightPop")

function GhostActivityStageUI:OnInit()
	self:InitMembers()
	self:InitComponent()
	self:InitDelegate()
end

function GhostActivityStageUI:InitMembers()
	self.tabDataArray = {}
	self.tabCellList = {}
end

function GhostActivityStageUI:InitComponent()
	self.detailPanel = detailPanelClass.New(self.stageDetailPanel, self)

	self.detailPanel:Hide()

	self.stageTabScroll = self.stageTabScroll:GetComponent("OptimizedScrollRect")

	self.stageTabScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateTabScroll(OptimizedParams, OptimizedViewsHolder)
	end)

	self.buttonReturn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
	self.moneyCell = CurrencyCell.New(self.currencyRoot)
	self.multipleFightPopupView = MultipleFightPopupView.New(self.MultipleFightPopupRoot)

	self.multipleFightPopupView:Hide()
end

function GhostActivityStageUI:InitDelegate()
	function self.showStageDetailEvent(worldMapItemId)
		self:ShowStageDetailPanel(worldMapItemId)
	end

	function self.delegateOnClickButtonTask()
		return
	end

	function self.delegateOnClickButtonShop()
		return
	end

	function self.delegateOnClickTipsBtn()
		self:OnClickTipsBtn()
	end
end

function GhostActivityStageUI:OnAddListeners()
	self.buttonTask:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonTask)
	self.buttonShop:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonShop)
	self.TipsBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickTipsBtn)
	EventDispatcher.AddEventListener(EventID.SummerActivityStageUI_ShowStageDetailPanel, self.showStageDetailEvent)
end

function GhostActivityStageUI:OnRemoveListeners()
	self.buttonTask:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonTask)
	self.buttonShop:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonShop)
	self.TipsBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickTipsBtn)
	EventDispatcher.RemoveEventListener(EventID.SummerActivityStageUI_ShowStageDetailPanel, self.showStageDetailEvent)
end

function GhostActivityStageUI:OnClickTipsBtn()
	UIModule.Open(Constant.UIControllerName.SummerActivityTipsUI, Constant.UILayer.UI)
end

function GhostActivityStageUI:OnClickButtonShop()
	UIModule.Open(Constant.UIControllerName.ActivityShopUI, Constant.UILayer.UI, {
		activityPod = self.activityPOD
	})
end

function GhostActivityStageUI:OnClickButtonTask()
	UIModule.Open(Constant.UIControllerName.SummerActivityTaskUI, Constant.UILayer.UI)
end

function GhostActivityStageUI:UpdateTabScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.tabDataArray[index + 1]

	if not self.tabCellList[instanceID] then
		self.tabCellList[instanceID] = tabItemClass.New(viewGameObject, self)
	end

	self.tabCellList[instanceID]:Refresh(data, index + 1)
end

function GhostActivityStageUI:OnOpen(userData)
	self.activityPOD = userData.activityPod
	self.activityCfg = CfgActivityTable[self.activityPOD.cid]
	self.chapterType = self.activityCfg.ExtraParam[3]

	self.multipleFightPopupView:Hide()
	self.detailPanel:Hide()
	self:Refresh()

	if userData.selectChapterId then
		self:SelectTabWithStage(SummerActivityModule.GetStageIs(userData.selectChapterId) - 1)
	else
		self:SelectTabWithStage(0)
	end
end

function GhostActivityStageUI:OnClose(userData)
	self.multipleFightPopupView:Hide()
end

function GhostActivityStageUI:GetPreloadAssetPaths()
	return nil
end

function GhostActivityStageUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GhostActivityStageUI:IsManualShowOnOpen(userData)
	return false
end

function GhostActivityStageUI:GetBGM(userData)
	return nil
end

function GhostActivityStageUI:OnPause()
	return
end

function GhostActivityStageUI:OnResume()
	return
end

function GhostActivityStageUI:OnCover()
	return
end

function GhostActivityStageUI:OnReveal()
	return
end

function GhostActivityStageUI:OnRefocus(userData)
	return
end

function GhostActivityStageUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GhostActivityStageUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GhostActivityStageUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GhostActivityStageUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GhostActivityStageUI:Refresh()
	self.tabDataArray = SummerActivityModule.GetStageCfgArray(self.chapterType)

	self.stageTabScroll:RefreshByItemCount(#self.tabDataArray)
	self.moneyCell:RefreshItem(Constant.TopMoneyType.SummerActivityStage)
end

function GhostActivityStageUI:RefreshDungeon()
	local cfgGeneralDup = CfgUtil.GetCfgGeneralDupChapterDataWithID(self.currentSelectedTabId)

	if not cfgGeneralDup then
		return
	end

	if self.currentStagePanel then
		self.currentStagePanel:OnDestroy()

		self.currentStagePanel = nil
	end

	local path = cfgGeneralDup.Chaptercomponents

	if LuaUtility.StrIsNullOrEmpty(path) then
		logError(string.format("【夏日活动】关卡 id = %s没有配置关卡预制体 “Chaptercomponents” ", cfgGeneralDup.Id))

		return
	end

	AssetUtil.LoadAsset(self, path, self._OnDungeonPrefabLoadSuccess)
end

function GhostActivityStageUI:_OnDungeonPrefabLoadSuccess(assetName, asset, duration, userData)
	local o = GameObject.Instantiate(asset, self.stageRoot.transform)

	self.currentStagePanel = stagePanelClass.New(o, self)

	self.currentStagePanel:Refresh()
end

function GhostActivityStageUI:OnTabSelected(tabItem)
	if self.currentSelectedTabItem then
		self.currentSelectedTabItem:UnSelected()

		self.currentSelectedTabItem = nil
	end

	self.currentSelectedTabItem = tabItem

	self.currentSelectedTabItem:Selected()

	self.currentSelectedTabId = self.currentSelectedTabItem.data.Id

	self:RefreshDungeon()
end

function GhostActivityStageUI:SelectTabWithStage(stage)
	local viewsHolder = self.stageTabScroll:GetItemViewsHolder(stage)

	if viewsHolder then
		local instanceID = viewsHolder.instanceID

		self.tabCellList[instanceID]:OnClickButtonClick()
	end
end

function GhostActivityStageUI:ShowStageDetailPanel(worldMapItemId)
	self.detailPanel:Show()
	self.detailPanel:Refresh(worldMapItemId, self.chapterType)
end

function GhostActivityStageUI:OnDestroy()
	if self.currentStagePanel then
		self.currentStagePanel:OnDestroy()

		self.currentStagePanel = nil
	end

	for _, v in pairs(self.tabCellList) do
		v:OnDestroy()
	end

	self.detailPanel:OnDestroy()

	self.tabCellList = {}

	self.buttonReturn:Dispose()
	self.moneyCell:Dispose()
	self.multipleFightPopupView:Dispose()
	AssetUtil.UnloadAsset(self)
end

return GhostActivityStageUI
