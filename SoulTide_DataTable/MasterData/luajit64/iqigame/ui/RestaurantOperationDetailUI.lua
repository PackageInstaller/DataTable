-- chunkname: @IQIGame\\UI\\RestaurantOperationDetailUI.lua

local RestaurantOperationDetailUI = {
	canLevelUp = false,
	roAttributeRenders = {},
	roPostControl = {},
	roLevelUpNeedAttrRenders = {},
	roIncomeRenders = {}
}

RestaurantOperationDetailUI = Base:Extend("RestaurantOperationDetailUI", "IQIGame.Onigao.UI.RestaurantOperationDetailUI", RestaurantOperationDetailUI)

require("IQIGame.UIExternalApi.RestaurantOperationDetailUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local RODetailAttributeRender = require("IQIGame.UI.ExploreHall.RestaurantOperation.RestaurantOperationDetail.RODetailAttributeRender")
local RODetailStoryView = require("IQIGame.UI.ExploreHall.RestaurantOperation.RestaurantOperationDetail.RODetailStoryView")
local RODetailEventView = require("IQIGame.UI.ExploreHall.RestaurantOperation.RestaurantOperationDetail.RODetailEventView")
local RODetailLevelUpNeedAttrRender = require("IQIGame.UI.ExploreHall.RestaurantOperation.RestaurantOperationDetail.RODetailLevelUpNeedAttrRender")
local RODetailIncomeRender = require("IQIGame.UI.ExploreHall.RestaurantOperation.RestaurantOperationDetail.RODetailIncomeRender")

function RestaurantOperationDetailUI:OnInit()
	function self.DelegateOnClickBtnGuide()
		self:OnClickBtnGuide()
	end

	function self.DelegateOnClickBtnBack()
		self:OnClickBtnBack()
	end

	function self.DelegateBtnUpGrade()
		self:OnBtnUpGrade()
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

	function self.DelegateOnUpdateWork()
		self:OnUpdateWork()
	end

	self.roDetailStoryView = RODetailStoryView.New(self.StoryView)
	self.roDetailEventView = RODetailEventView.New(self.EventView)

	self.roDetailStoryView:Close()
	self.roDetailEventView:Close()
	self.AttributeModel:SetActive(false)

	self.roAttributeRenderPool = UIObjectPool.New(10, function()
		return RODetailAttributeRender.New(UnityEngine.Object.Instantiate(self.AttributeModel))
	end, function(cell)
		cell:Dispose()
	end)

	self.ConditionModel:SetActive(false)

	self.roLevelUpNeedAttrRenderPool = UIObjectPool.New(10, function()
		return RODetailLevelUpNeedAttrRender.New(UnityEngine.Object.Instantiate(self.ConditionModel))
	end, function(cell)
		cell:Dispose()
	end)

	self.IncomeMould:SetActive(false)

	self.roIncomeRenderPool = UIObjectPool.New(10, function()
		return RODetailIncomeRender.New(UnityEngine.Object.Instantiate(self.IncomeMould))
	end, function(cell)
		cell:Dispose()
	end)
end

function RestaurantOperationDetailUI:GetPreloadAssetPaths()
	return nil
end

function RestaurantOperationDetailUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RestaurantOperationDetailUI:IsManualShowOnOpen(userData)
	return false
end

function RestaurantOperationDetailUI:GetBGM(userData)
	return nil
end

function RestaurantOperationDetailUI:OnOpen(userData)
	self:UpdateView()
end

function RestaurantOperationDetailUI:OnClose(userData)
	self.roDetailStoryView:Close()
	self.roDetailEventView:Close()
end

function RestaurantOperationDetailUI:OnAddListeners()
	self.BtnGuide:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnGuide)
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnBack)
	self.BtnUpGrade:GetComponent("Button").onClick:AddListener(self.DelegateBtnUpGrade)
	self.BtnPlot:GetComponent("Button").onClick:AddListener(self.DelegateBtnPlot)
	self.BtnEventRecord:GetComponent("Button").onClick:AddListener(self.DelegateBtnEventRecord)
	self.BtnReward:GetComponent("Button").onClick:AddListener(self.DelegateBtnReward)
	EventDispatcher.AddEventListener(EventID.ROBuildLevelUpEvent, self.DelegateBuildLevelUp)
	EventDispatcher.AddEventListener(EventID.ROReceiveIncomeEvent, self.DelegateReceiveIncome)
	EventDispatcher.AddEventListener(EventID.ROUpdateEvent, self.DelegateUpdateEvent)
	EventDispatcher.AddEventListener(EventID.UpdateROWorkerEvent, self.DelegateOnUpdateWork)
end

function RestaurantOperationDetailUI:OnRemoveListeners()
	self.BtnGuide:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnGuide)
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnBack)
	self.BtnUpGrade:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnUpGrade)
	self.BtnPlot:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnPlot)
	self.BtnEventRecord:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnEventRecord)
	self.BtnReward:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnReward)
	EventDispatcher.RemoveEventListener(EventID.ROBuildLevelUpEvent, self.DelegateBuildLevelUp)
	EventDispatcher.RemoveEventListener(EventID.ROReceiveIncomeEvent, self.DelegateReceiveIncome)
	EventDispatcher.RemoveEventListener(EventID.ROUpdateEvent, self.DelegateUpdateEvent)
	EventDispatcher.RemoveEventListener(EventID.UpdateROWorkerEvent, self.DelegateOnUpdateWork)
end

function RestaurantOperationDetailUI:OnPause()
	return
end

function RestaurantOperationDetailUI:OnResume()
	return
end

function RestaurantOperationDetailUI:OnCover()
	return
end

function RestaurantOperationDetailUI:OnReveal()
	return
end

function RestaurantOperationDetailUI:OnRefocus(userData)
	return
end

function RestaurantOperationDetailUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RestaurantOperationDetailUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RestaurantOperationDetailUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RestaurantOperationDetailUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RestaurantOperationDetailUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.roDetailEventView:Dispose()

	self.roDetailEventView = nil

	self.roDetailStoryView:Dispose()

	self.roDetailStoryView = nil

	for i, v in pairs(self.roAttributeRenders) do
		self.roAttributeRenderPool:Release(v)
	end

	self.roAttributeRenders = {}

	self.roAttributeRenderPool:Dispose()

	for i, v in pairs(self.roLevelUpNeedAttrRenders) do
		self.roLevelUpNeedAttrRenderPool:Release(v)
	end

	self.roLevelUpNeedAttrRenders = {}

	self.roLevelUpNeedAttrRenderPool:Dispose()

	for i, v in pairs(self.roIncomeRenders) do
		self.roIncomeRenderPool:Release(v)
	end

	self.roIncomeRenders = {}

	self.roIncomeRenderPool:Dispose()
end

function RestaurantOperationDetailUI:OnBuildLevelUp()
	self:UpdateView()
end

function RestaurantOperationDetailUI:OnReceiveIncome()
	self:UpdateView()
end

function RestaurantOperationDetailUI:OnUpdateWork()
	self:UpdateView()
end

function RestaurantOperationDetailUI:OnUpdateEvent()
	self.roDetailEventView:UpdateView()
	self:RefreshRedPoint()
end

function RestaurantOperationDetailUI:UpdateView()
	local cfgBuildingData = RestaurantOperationModule.GetBuildingData()
	local cfgMaxLvBuilding = RestaurantOperationModule.GetCfgMaxLvBuildingData()

	self.TextMaxLv:SetActive(cfgBuildingData.Level >= cfgMaxLvBuilding.Level)
	self.BtnUpGrade:SetActive(cfgBuildingData.Level < cfgMaxLvBuilding.Level)

	self.roPostControl = RestaurantOperationModule.ROPostControl

	local mainAttr = {}

	table.sort(self.roPostControl, function(a, b)
		return a:GetCfgData().Type < b:GetCfgData().Type
	end)

	for i, v in pairs(self.roAttributeRenders) do
		self.roAttributeRenderPool:Release(v)
		v.View:SetActive(false)
		v.View.transform:SetParent(self.UIController.transform, false)
	end

	self.roAttributeRenders = {}

	for i = 1, #self.roPostControl do
		local data = self.roPostControl[i]
		local render = self.roAttributeRenderPool:Obtain()

		render.View:SetActive(true)
		render.View.transform:SetParent(self.AttributeNode.transform, false)
		render:SetData(data)
		table.insert(self.roAttributeRenders, render)

		local attr = data.postPOD.value + data.postPOD.restaurantMarkUp

		mainAttr[data:GetCfgMainAttributeData().Id] = attr
	end

	UGUIUtil.SetText(self.TextLv, RestaurantOperationDetailUIApi:GetString("TextLv", cfgBuildingData.Level))

	local workNum, unlockNum = RestaurantOperationModule.GetWorksNum()

	UGUIUtil.SetText(self.TextWorkerNum, RestaurantOperationDetailUIApi:GetString("TextWorkerNum", unlockNum))

	local totalAttr = RestaurantOperationModule.ROAttributePOD.allAtt

	UGUIUtil.SetText(self.TextTotalAttribute, RestaurantOperationDetailUIApi:GetString("TextTotalAttribute", totalAttr))
	UGUIUtil.SetText(self.TextLevelDes, RestaurantOperationDetailUIApi:GetString("TextLevelDes", cfgBuildingData.RestaurantAttNum[1]))

	local conditionRest = true
	local conditionAttr = true
	local conditionCost = true

	self.TextCondition:SetActive(cfgBuildingData.LevelUpCondition > 0)

	if cfgBuildingData.LevelUpCondition > 0 then
		UGUIUtil.SetText(self.TextCondition, CfgConditionTable[cfgBuildingData.LevelUpCondition].Name)

		conditionRest = RestaurantOperationModule.CheckConditions({
			cfgBuildingData.LevelUpCondition
		})
	end

	if #cfgBuildingData.LevelUpCost > 0 then
		local needItem = cfgBuildingData.LevelUpCost[1]
		local needNum = cfgBuildingData.LevelUpCost[2]
		local haveNum = WarehouseModule.GetItemNumByCfgID(needItem)

		conditionCost = needNum <= haveNum

		local path = UIGlobalApi.GetIconPath(CfgItemTable[needItem].Icon)

		AssetUtil.LoadImage(self, path, self.ImgCost:GetComponent("Image"))
		UGUIUtil.SetText(self.TextCost, RestaurantOperationDetailUIApi:GetString("TextUpGradeValue", needNum, haveNum))
	end

	for i, v in pairs(self.roLevelUpNeedAttrRenders) do
		self.roLevelUpNeedAttrRenderPool:Release(v)
		v.View:SetActive(false)
		v.View.transform:SetParent(self.UIController.transform, false)
	end

	self.roLevelUpNeedAttrRenders = {}

	for i = 1, #cfgBuildingData.LevelUpNeedAttType do
		local attrID = cfgBuildingData.LevelUpNeedAttType[i]
		local needValue = cfgBuildingData.LevelUpNeedAttNum[i]
		local haveNum = mainAttr[attrID] or 0
		local render = self.roLevelUpNeedAttrRenderPool:Obtain()

		render.View:SetActive(true)
		render.View.transform:SetParent(self.ConditionNode.transform, false)
		render:SetData(attrID, needValue, haveNum)
		table.insert(self.roLevelUpNeedAttrRenders, render)

		conditionAttr = conditionAttr and needValue <= haveNum
	end

	self.canLevelUp = conditionRest and conditionAttr and conditionCost

	self:RefreshIncome()
	self.roDetailEventView:UpdateView()
	self:RefreshRedPoint()
end

function RestaurantOperationDetailUI:RefreshIncome()
	for i, v in pairs(self.roIncomeRenders) do
		self.roIncomeRenderPool:Release(v)
		v.View:SetActive(false)
		v.View.transform:SetParent(self.UIController.transform, false)
	end

	self.roIncomeRenders = {}

	local tab = RestaurantOperationModule.ROAttributePOD.income

	for i, v in pairs(tab) do
		local render = self.roIncomeRenderPool:Obtain()

		render.View:SetActive(true)
		render.View.transform:SetParent(self.IncomeNode.transform, false)
		render:SetData(i, v)
		table.insert(self.roIncomeRenders, render)
	end

	local count = RestaurantOperationModule.DailyDupPOD.restaurantOperationPOD.numberOfReturns

	count = count or 0

	local cfgRestaurantOperationControlData = CfgRestaurantOperationControlTable[RestaurantOperationModule.GlobalCid]
	local totalCount = cfgRestaurantOperationControlData.MaxTimes

	count = totalCount < count and totalCount or count
	self.ImgPer:GetComponent("Image").fillAmount = count / totalCount

	UGUIUtil.SetText(self.TextPer, RestaurantOperationDetailUIApi:GetString("TextPer", count, totalCount))

	local isShow, num, maxNum = RestaurantOperationModule.CanGetReceiveIncome()

	self.BtnReward:SetActive(num > 0)
end

function RestaurantOperationDetailUI:RefreshRedPoint()
	self.RedPointLevelUp:SetActive(self.canLevelUp)

	local result = RestaurantOperationModule.CheckEventRed()

	self.RedPointEvent:SetActive(result)
end

function RestaurantOperationDetailUI:OnClickBtnGuide()
	return
end

function RestaurantOperationDetailUI:OnClickBtnBack()
	UIModule.CloseSelf(self)
end

function RestaurantOperationDetailUI:OnBtnUpGrade()
	if not self.canLevelUp then
		NoticeModule.ShowNotice(21045091)

		return
	end

	RestaurantOperationModule.LevelUp()
end

function RestaurantOperationDetailUI:OnBtnPlot()
	self.roDetailStoryView:Open()
end

function RestaurantOperationDetailUI:OnBtnEventRecord()
	RestaurantOperationModule.ReadBurst()
	self.roDetailEventView:Open()
end

function RestaurantOperationDetailUI:OnBtnGetReward()
	RestaurantOperationModule.ReceiveIncome()
end

return RestaurantOperationDetailUI
