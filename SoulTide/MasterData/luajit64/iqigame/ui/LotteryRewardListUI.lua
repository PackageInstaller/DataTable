-- chunkname: @IQIGame\\UI\\LotteryRewardListUI.lua

local LotteryRewardListData = {}
local LotteryRewardListUI = {
	NavigationBtns = {}
}

LotteryRewardListUI = Base:Extend("LotteryRewardListUI", "IQIGame.Onigao.UI.LotteryRewardListUI", LotteryRewardListUI)

local LotteryRewardCell = require("IQIGame.UI.Lottery.LotteryRewardCell")
local LotteryRewardListNavigationBtn = require("IQIGame.UI.Lottery.LotteryRewardListNavigationBtn")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")

function LotteryRewardListUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.ScrollList = self.RewardGrid:GetComponent("ScrollAreaListGroup")

	function self.ScrollList.onRenderGroupPage(renderPage, groupIndex)
		self:UpdateTitles(renderPage, groupIndex)
	end

	function self.ScrollList.onRenderGroupCell(renderCell, groupIndex, cellIndex)
		self:UpdateRewards(renderCell, groupIndex, cellIndex)
	end

	self.NavigationBtnPool = UIObjectPool.New(5, function()
		return LotteryRewardListNavigationBtn.New(UnityEngine.Object.Instantiate(self.NavigationButtonPrefab), function(index)
			self:RefreshList(index)
		end)
	end, function(btn)
		local v = btn.View

		btn:Dispose()
		UnityEngine.Object.Destroy(v)
	end)

	UGUIUtil.SetText(self.WindowTitleText, LotteryRewardListUIApi:GetString("WindowTitleText"))
	UGUIUtil.SetText(self.TipText, LotteryRewardListUIApi:GetString("TipText"))
end

function LotteryRewardListUI:GetPreloadAssetPaths()
	return nil
end

function LotteryRewardListUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LotteryRewardListUI:OnOpen(userData)
	self:UpdateView(userData)
end

function LotteryRewardListUI:OnClose(userData)
	return
end

function LotteryRewardListUI:OnPause()
	return
end

function LotteryRewardListUI:OnResume()
	return
end

function LotteryRewardListUI:OnCover()
	return
end

function LotteryRewardListUI:OnReveal()
	return
end

function LotteryRewardListUI:OnRefocus(userData)
	return
end

function LotteryRewardListUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LotteryRewardListUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LotteryRewardListUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LotteryRewardListUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LotteryRewardListUI:OnDestroy()
	LotteryRewardCell.DisposeIn(self)
	self:ClearNavigationBtns(true)
	self.NavigationBtnPool:Dispose()
end

function LotteryRewardListUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn1:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function LotteryRewardListUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn1:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function LotteryRewardListUI:UpdateView(cfgLotteryShowData)
	local selectedPickUps = LotteryModule.GetSelectedPickUps(cfgLotteryShowData)

	if #selectedPickUps > 0 then
		self.LotteryRewardListData = selectedPickUps[1]

		if cfgLotteryShowData.ChoiceNum == 1 then
			self.List = self.LotteryRewardListData.List
			self.Condition = self.LotteryRewardListData.Condition
			self.ItemProbability = self.LotteryRewardListData.ItemProbability
		else
			local ssrList = {}
			local ssrConditions = {}
			local ssrProbabilities = {}

			for i = 1, #selectedPickUps do
				local cfgLotteryPackUpData = selectedPickUps[i]

				table.addAll(ssrList, cfgLotteryPackUpData.List[1])
				table.addAll(ssrConditions, cfgLotteryPackUpData.Condition[1])
				table.addAll(ssrProbabilities, cfgLotteryPackUpData.ItemProbability[1])
			end

			self.List = {}
			self.Condition = {}
			self.ItemProbability = {}
			self.List[1] = ssrList
			self.Condition[1] = ssrConditions
			self.ItemProbability[1] = ssrProbabilities

			for i = 2, #self.LotteryRewardListData.ItemProbability do
				self.List[i] = self.LotteryRewardListData.List[i]
				self.Condition[i] = self.LotteryRewardListData.Condition[i]
				self.ItemProbability[i] = self.LotteryRewardListData.ItemProbability[i]
			end
		end
	else
		self.LotteryRewardListData = cfgLotteryShowData
		self.List = self.LotteryRewardListData.List
		self.Condition = self.LotteryRewardListData.Condition
		self.ItemProbability = self.LotteryRewardListData.ItemProbability
	end

	self:RefreshList(1)
	self:ClearNavigationBtns()

	for i = 1, #self.LotteryRewardListData.OrderTitle do
		local btn = self.NavigationBtnPool:Obtain()

		btn.View:SetActive(true)
		btn.View.transform:SetParent(self.NavigationButtonGrid.transform, false)

		local itemProbabilities = self.ItemProbability[i]
		local totalPossibility = 0

		for j = 1, #itemProbabilities do
			local possibilityStr = itemProbabilities[j]
			local possibility = tonumber(string.sub(possibilityStr, 1, #possibilityStr - 1))

			totalPossibility = totalPossibility + possibility
		end

		btn:SetData(self.LotteryRewardListData.OrderTitle[i], totalPossibility, i)
		table.insert(self.NavigationBtns, btn)
	end
end

function LotteryRewardListUI:RefreshList(toTypeIndex)
	local rewards = self.List
	local lengths = {}
	local toIndex = 0

	for i = 1, #rewards do
		table.insert(lengths, #rewards[i])

		if i < toTypeIndex then
			toIndex = toIndex + #rewards[i]
		end
	end

	self.ScrollList.startIndex = toIndex

	self.ScrollList:RefreshOnLua(lengths)
end

function LotteryRewardListUI:ClearNavigationBtns(isDestroy)
	for i = 1, #self.NavigationBtns do
		local btn = self.NavigationBtns[i]

		btn.View:SetActive(false)

		if not isDestroy then
			btn.View.transform:SetParent(self.UIController.transform, false)
		end

		self.NavigationBtnPool:Release(btn)
	end

	self.NavigationBtns = {}
end

function LotteryRewardListUI:OnClickCloseBtn()
	UIModule.Close(Constant.UIControllerName.LotteryRewardListUI)
end

function LotteryRewardListUI:UpdateTitles(renderPage, groupIndex)
	local typeDatas = self.List[groupIndex + 1]

	if #typeDatas == 0 then
		return
	end

	local canShowNum = 0
	local totalNum = 0

	for i = 1, #typeDatas do
		totalNum = totalNum + 1

		if ConditionModule.Check(self.Condition[groupIndex + 1][i]) then
			canShowNum = canShowNum + 1
		end
	end

	renderPage.prefabPage:GetComponentInChildren(typeof(UnityEngine.UI.Text)).text = LotteryRewardListUIApi:GetString("RewardTitleText", self.LotteryRewardListData.OrderTitle[groupIndex + 1], canShowNum, totalNum)
end

function LotteryRewardListUI:UpdateRewards(renderCell, groupIndex, cellIndex)
	local typeDatas = self.List[groupIndex + 1]

	if typeDatas == nil or typeDatas[cellIndex + 1] == nil then
		renderCell.gameObject:SetActive(false)

		return
	end

	local rewardCell = LotteryRewardCell.PackageOrReuseView(self, renderCell.gameObject)
	local rewardType = self.LotteryRewardListData.OrderType[groupIndex + 1]
	local unlockConditions = self.Condition[groupIndex + 1]
	local probabilityTexts = self.ItemProbability[groupIndex + 1]
	local upItems

	if groupIndex == 0 then
		upItems = self.LotteryRewardListData.Order1UpItem
	end

	rewardCell:SetData(rewardType, typeDatas[cellIndex + 1], unlockConditions[cellIndex + 1], probabilityTexts[cellIndex + 1], upItems)
end

return LotteryRewardListUI
