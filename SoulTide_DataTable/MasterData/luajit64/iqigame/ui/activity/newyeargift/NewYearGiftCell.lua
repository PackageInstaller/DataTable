-- chunkname: @IQIGame\\UI\\Activity\\NewYearGift\\NewYearGiftCell.lua

local m = {
	newYearItemCells = {},
	newYearRewardCells = {}
}
local NewYearItemCell = require("IQIGame.UI.Activity.NewYearGift.NewYearItemCell")
local NewYearRewardCell = require("IQIGame.UI.Activity.NewYearGift.NewYearRewardCell")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")

function m.New(view, root)
	local obj = Clone(m)

	obj:Init(view, root)

	return obj
end

function m:Init(view, root)
	self.View = view
	self.rootUI = root

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.BtnExchangeLabel, ActivityUIApi:GetString("NewYearBtnExchangeLabel"))
	UGUIUtil.SetText(self.BtnCollectingLabel, ActivityUIApi:GetString("NewYearBtnCollectingLabel"))
	UGUIUtil.SetText(self.BtnCollectedLabel, ActivityUIApi:GetString("NewYearBtnCollectedLabel"))
	self.ItemModule:SetActive(false)

	self.newYearItemPool = UIObjectPool.New(5, function()
		local cell = NewYearItemCell.New(UnityEngine.Object.Instantiate(self.ItemModule))

		return cell
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)

	self.RewardModule:SetActive(false)

	self.newYearRewardPool = UIObjectPool.New(5, function()
		local cell = NewYearRewardCell.New(UnityEngine.Object.Instantiate(self.RewardModule))

		return cell
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)

	function self.delegateBtnExchange()
		self:OnBtnExchange()
	end

	function self.delegateOnUpdateItem()
		self:OnUpdateItem()
	end

	self:AddListener()
end

function m:AddListener()
	self.BtnExchange:GetComponent("Button").onClick:AddListener(self.delegateBtnExchange)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.delegateOnUpdateItem)
end

function m:RemoveListener()
	self.BtnExchange:GetComponent("Button").onClick:RemoveListener(self.delegateBtnExchange)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.delegateOnUpdateItem)
end

function m:SetData(data, operateEventID)
	self.cfgNewYearGiftListData = data
	self.operateEventID = operateEventID

	self:UpdateView()
end

function m:OnUpdateItem()
	if self.cfgNewYearGiftListData and self.operateEventID then
		self:UpdateView()
	end
end

function m:UpdateView()
	if self.cfgNewYearGiftListData then
		for i, v in pairs(self.newYearItemCells) do
			v.View.transform:SetParent(self.rootUI.UIController.transform, false)
			v.View:SetActive(false)
			self.newYearItemPool:Release(v)
		end

		self.newYearItemCells = {}

		for i = 1, #self.cfgNewYearGiftListData.NeedItem, 2 do
			local Id = self.cfgNewYearGiftListData.NeedItem[i]
			local Num = self.cfgNewYearGiftListData.NeedItem[i + 1]
			local haveNum = WarehouseModule.GetItemNumByCfgID(Id)
			local cell = self.newYearItemPool:Obtain()

			cell.View:SetActive(true)
			cell.View.transform:SetParent(self.ItemRoot.transform, false)
			cell:SetData(Id, haveNum, Num)
			table.insert(self.newYearItemCells, cell)
		end

		for i, v in pairs(self.newYearRewardCells) do
			v.View.transform:SetParent(self.rootUI.UIController.transform, false)
			v.View:SetActive(false)
			self.newYearRewardPool:Release(v)
		end

		self.newYearRewardCells = {}

		for i = 1, #self.cfgNewYearGiftListData.Reward, 2 do
			local Id = self.cfgNewYearGiftListData.Reward[i]
			local Num = self.cfgNewYearGiftListData.Reward[i + 1]
			local cell = self.newYearRewardPool:Obtain()

			cell.View:SetActive(true)
			cell.View.transform:SetParent(self.RewardRoot.transform, false)
			cell:SetData(Id, Num)
			table.insert(self.newYearRewardCells, cell)
		end

		local exchangeNum, maxNum = ActiveNewYearGiftModule.GetNewYearGiftExchangeCount(self.operateEventID, self.cfgNewYearGiftListData.Id)

		UGUIUtil.SetText(self.TextRemainingTimes, ActivityUIApi:GetString("NewYearTextRemainingTimes", maxNum - exchangeNum))

		local state = ActiveNewYearGiftModule.GetNewYearGiftState(self.operateEventID, self.cfgNewYearGiftListData.Id)

		self.BtnExchange:SetActive(state == 1)
		self.BtnCollecting:SetActive(state == 2)
		self.BtnCollected:SetActive(state == 3)
	end
end

function m:OnBtnExchange()
	ActiveNewYearGiftModule.ExchangeTreasureGift(self.operateEventID, self.cfgNewYearGiftListData.Id)
end

function m:Dispose()
	self:RemoveListener()

	for i, v in pairs(self.newYearItemCells) do
		self.newYearItemPool:Release(v)
	end

	self.newYearItemCells = {}

	self.newYearItemPool:Dispose()

	for i, v in pairs(self.newYearRewardCells) do
		self.newYearRewardPool:Release(v)
	end

	self.newYearRewardCells = {}

	self.newYearRewardPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
