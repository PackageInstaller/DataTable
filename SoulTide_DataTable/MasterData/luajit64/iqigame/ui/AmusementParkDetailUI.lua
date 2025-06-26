-- chunkname: @IQIGame\\UI\\AmusementParkDetailUI.lua

local AmusementParkDetailUI = {
	amusementParkIncomeRenders = {}
}

AmusementParkDetailUI = Base:Extend("AmusementParkDetailUI", "IQIGame.Onigao.UI.AmusementParkDetailUI", AmusementParkDetailUI)

require("IQIGame.UIExternalApi.AmusementParkDetailUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local AmusementParkDetailStoryView = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkDetail.AmusementParkDetailStoryView")
local AmusementParkDetailEventView = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkDetail.AmusementParkDetailEventView")
local AmusementParkDetailIncomeRender = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkDetail.AmusementParkDetailIncomeRender")
local AmusementParkDetailBuildCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkDetail.AmusementParkDetailBuildCell")
local AmusementParkBuildAreaData = require("IQIGame.Scene.AmusementPark.AmusementParkBuildAreaData")

function AmusementParkDetailUI:OnInit()
	function self.DelegateOnClickBtnGuide()
		self:OnClickBtnGuide()
	end

	function self.DelegateOnClickBtnBack()
		self:OnClickBtnBack()
	end

	function self.DelegateBtnPlot()
		self:OnBtnPlot()
	end

	function self.DelegateBtnEventRecord()
		self:OnBtnEventRecord()
	end

	function self.DelegateBuildLevelUp()
		self:OnBuildLevelUp()
	end

	function self.DelegateBtnReward()
		self:OnBtnGetReward()
	end

	function self.DelegateReceiveIncome()
		self:OnReceiveIncome()
	end

	function self.DelegateUpdateEvent()
		self:OnUpdateEvent()
	end

	self.amusementParkDetailStoryView = AmusementParkDetailStoryView.New(self.StoryView)
	self.amusementParkDetailEventView = AmusementParkDetailEventView.New(self.EventView)

	self.amusementParkDetailStoryView:Close()
	self.amusementParkDetailEventView:Close()
	self.IncomeMould:SetActive(false)

	self.amusementParkIncomeRenderPool = UIObjectPool.New(10, function()
		return AmusementParkDetailIncomeRender.New(UnityEngine.Object.Instantiate(self.IncomeMould))
	end, function(cell)
		cell:Dispose()
	end)

	self.BuildingMould:SetActive(false)

	self.parkDetailBuildCellPool = {}

	for i = 1, self.BuildPosNode.transform.childCount do
		local trans = self.BuildPosNode.transform:Find("Building" .. i)

		if trans then
			local buildAreaData = AmusementParkBuildAreaData.New(i)
			local buildAreaCell = AmusementParkDetailBuildCell.New(UnityEngine.GameObject.Instantiate(self.BuildingMould))

			buildAreaCell.View:SetActive(true)

			buildAreaCell.View.name = "BuildPos_" .. i

			buildAreaCell.View.transform:SetParent(trans, false)
			buildAreaCell:SetData(buildAreaData)

			self.parkDetailBuildCellPool[i] = buildAreaCell
		end
	end
end

function AmusementParkDetailUI:GetPreloadAssetPaths()
	return nil
end

function AmusementParkDetailUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function AmusementParkDetailUI:IsManualShowOnOpen(userData)
	return false
end

function AmusementParkDetailUI:GetBGM(userData)
	return nil
end

function AmusementParkDetailUI:OnOpen(userData)
	self:UpdateView()
end

function AmusementParkDetailUI:OnClose(userData)
	self.amusementParkDetailStoryView:Close()
	self.amusementParkDetailEventView:Close()
end

function AmusementParkDetailUI:OnAddListeners()
	self.BtnGuide:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnGuide)
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnBack)
	self.BtnPlot:GetComponent("Button").onClick:AddListener(self.DelegateBtnPlot)
	self.BtnEventRecord:GetComponent("Button").onClick:AddListener(self.DelegateBtnEventRecord)
	self.BtnReward:GetComponent("Button").onClick:AddListener(self.DelegateBtnReward)
	EventDispatcher.AddEventListener(EventID.APBuildLevelUpEvent, self.DelegateBuildLevelUp)
	EventDispatcher.AddEventListener(EventID.APReceiveIncomeEvent, self.DelegateReceiveIncome)
	EventDispatcher.AddEventListener(EventID.APUpdateEvent, self.DelegateUpdateEvent)
end

function AmusementParkDetailUI:OnRemoveListeners()
	self.BtnGuide:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnGuide)
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnBack)
	self.BtnPlot:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnPlot)
	self.BtnEventRecord:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnEventRecord)
	self.BtnReward:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnReward)
	EventDispatcher.RemoveEventListener(EventID.APBuildLevelUpEvent, self.DelegateBuildLevelUp)
	EventDispatcher.RemoveEventListener(EventID.APReceiveIncomeEvent, self.DelegateReceiveIncome)
	EventDispatcher.RemoveEventListener(EventID.APUpdateEvent, self.DelegateUpdateEvent)
end

function AmusementParkDetailUI:OnPause()
	return
end

function AmusementParkDetailUI:OnResume()
	return
end

function AmusementParkDetailUI:OnCover()
	return
end

function AmusementParkDetailUI:OnReveal()
	return
end

function AmusementParkDetailUI:OnRefocus(userData)
	return
end

function AmusementParkDetailUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function AmusementParkDetailUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function AmusementParkDetailUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function AmusementParkDetailUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function AmusementParkDetailUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.amusementParkDetailEventView:Dispose()

	self.amusementParkDetailEventView = nil

	self.amusementParkDetailStoryView:Dispose()

	self.amusementParkDetailStoryView = nil

	for i, v in pairs(self.amusementParkIncomeRenders) do
		self.amusementParkIncomeRenderPool:Release(v)
	end

	self.amusementParkIncomeRenders = {}

	self.amusementParkIncomeRenderPool:Dispose()

	for i, v in pairs(self.parkDetailBuildCellPool) do
		v:Dispose()
	end

	self.parkDetailBuildCellPool = {}
end

function AmusementParkDetailUI:OnBuildLevelUp()
	self:UpdateView()
end

function AmusementParkDetailUI:OnReceiveIncome()
	self:RefreshIncome()
end

function AmusementParkDetailUI:OnUpdateEvent()
	self.amusementParkDetailEventView:UpdateView()
	self:RefreshRedPoint()
end

function AmusementParkDetailUI:UpdateView()
	UGUIUtil.SetText(self.TextLv, AmusementParkDetailUIApi:GetString("TextLv", AmusementParkModule.AmusementParkInfoPOD.amusementParkAttPOD.level))
	UGUIUtil.SetText(self.TextWorkerNum, AmusementParkDetailUIApi:GetString("TextWorkerNum", #AmusementParkModule.AmusementParkInfoPOD.amusementParkVoRolesHave))
	self:RefreshBuildAttr()
	self:RefreshBuilds()
	self.amusementParkDetailEventView:UpdateView()
	self:RefreshRedPoint()
end

function AmusementParkDetailUI:RefreshBuilds()
	for i, v in pairs(self.parkDetailBuildCellPool) do
		v:Refresh()
	end
end

function AmusementParkDetailUI:RefreshBuildAttr()
	for i, v in pairs(self.amusementParkIncomeRenders) do
		v.View:SetActive(false)
		v.View.transform:SetParent(self.UIController.transform, false)
		self.amusementParkIncomeRenderPool:Release(v)
	end

	self.amusementParkIncomeRenders = {}

	local attrs = AmusementParkModule.GetRankParkAttr()

	for i = 1, #attrs do
		local attrData = attrs[i]
		local render = self.amusementParkIncomeRenderPool:Obtain()

		render.View:SetActive(true)
		render.View.transform:SetParent(self.IncomeNode.transform, false)
		render:SetData(attrData.attrID, attrData.attrValue)
		table.insert(self.amusementParkIncomeRenders, render)
	end

	local count = AmusementParkModule.DailyDupPOD.amusementParkPOD.numberOfReturns or 0
	local cfgRestaurantOperationControlData = CfgAmusementParkControlTable[AmusementParkModule.GlobalCid]
	local totalCount = cfgRestaurantOperationControlData.MaxTimes

	count = totalCount < count and totalCount or count

	UGUIUtil.SetText(self.TextPer, AmusementParkDetailUIApi:GetString("TextPer", count))
	UGUIUtil.SetText(self.TextMaxPer, totalCount)
	UGUIUtil.SetText(self.TextOpenLv, AmusementParkDetailUIApi:GetString("TextOpenLv", AmusementParkModule.AmusementParkInfoPOD.amusementParkAttPOD.level))
	self:RefreshIncome()
end

function AmusementParkDetailUI:RefreshIncome()
	local isShow, num, maxNum = AmusementParkModule.CanGetReceiveIncome()

	UGUIUtil.SetText(self.TextPer, AmusementParkDetailUIApi:GetString("TextPer", num))
	self.BtnReward:SetActive(num > 0)
end

function AmusementParkDetailUI:RefreshRedPoint()
	local result = AmusementParkModule.CheckEventRed()

	self.RedPointEvent:SetActive(result)
end

function AmusementParkDetailUI:OnClickBtnGuide()
	return
end

function AmusementParkDetailUI:OnClickBtnBack()
	UIModule.CloseSelf(self)
end

function AmusementParkDetailUI:OnBtnPlot()
	self.amusementParkDetailStoryView:Open()
end

function AmusementParkDetailUI:OnBtnEventRecord()
	AmusementParkModule.ReadBurst()
	self.amusementParkDetailEventView:Open()
end

function AmusementParkDetailUI:OnBtnGetReward()
	AmusementParkModule.ReceiveIncome()
end

return AmusementParkDetailUI
