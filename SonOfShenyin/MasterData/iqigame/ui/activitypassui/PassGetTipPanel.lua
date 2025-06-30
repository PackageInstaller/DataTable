-- chunkname: @IQIGame\\UI\\ActivityPassUI\\PassGetTipPanel.lua

local PassGetTipPanel = {
	highRewardScrollViewCell = {},
	superRewardScrollViewCell = {}
}
local highRewardScrollItem = require("IQIGame.UI.ActivityPassUI.highRewardScrollItem")
local superRewardScrollItem = require("IQIGame.UI.ActivityPassUI.superRewardScrollItem")

function PassGetTipPanel.New(go, mainView)
	local o = Clone(PassGetTipPanel)

	o:Initialize(go, mainView)

	return o
end

function PassGetTipPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.passTableIndex = {
		High = 2,
		Difference = 1,
		Super = 3
	}

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function PassGetTipPanel:InitComponent()
	local highRewardScroll = self.highRewardScroll:GetComponent("ScrollAreaList")

	function highRewardScroll.onRenderCell(gridCell)
		self:OnHighRewardScrollRenderGridCell(gridCell)
	end

	local superRewardScroll = self.superRewardScroll:GetComponent("ScrollAreaList")

	function superRewardScroll.onRenderCell(gridCell)
		self:OnSuperRewardScrollRenderGridCell(gridCell)
	end
end

function PassGetTipPanel:InitDelegate()
	function self.btnMaskDelegate()
		self:Show(false)
	end

	function self.btnHighPriceDelegate()
		self:OnBtnHighPriceClick()
	end

	function self.PlayBuyPassAnimationDelegate()
		self:PassBuyAnimation()
	end

	function self.btnSuperPriceDelegate()
		self:OnBtnSuperPriceClick()
	end
end

function PassGetTipPanel:AddListener()
	self.btnMask:GetComponent("Button").onClick:AddListener(self.btnMaskDelegate)
	self.btnHighPrice:GetComponent("Button").onClick:AddListener(self.btnHighPriceDelegate)
	self.btnSuperPrice:GetComponent("Button").onClick:AddListener(self.btnSuperPriceDelegate)
end

function PassGetTipPanel:RemoveListener()
	self.btnMask:GetComponent("Button").onClick:RemoveListener(self.btnMaskDelegate)
	self.btnHighPrice:GetComponent("Button").onClick:RemoveListener(self.btnHighPriceDelegate)
	self.btnSuperPrice:GetComponent("Button").onClick:RemoveListener(self.btnSuperPriceDelegate)
end

function PassGetTipPanel:PassBuyAnimation()
	EventDispatcher.RemoveEventListener(EventID.BuyPassAnimationEvent, self.PlayBuyPassAnimationDelegate)
end

function PassGetTipPanel:OnBtnHighPriceClick()
	ShopModule.BuyItem(self.normalCommodityData, 1)
	EventDispatcher.AddEventListener(EventID.BuyPassAnimationEvent, self.PlayBuyPassAnimationDelegate)
	self:Show(false)
end

function PassGetTipPanel:OnBtnSuperPriceClick()
	local commodityData

	if self.buyHigh == true and self.buySuper == false then
		commodityData = self.priceDifferenceCommodityData
	else
		commodityData = self.highCommodityData
	end

	ShopModule.BuyItem(commodityData, 1)
	EventDispatcher.AddEventListener(EventID.BuyPassAnimationEvent, self.PlayBuyPassAnimationDelegate)
	self:Show(false)
end

function PassGetTipPanel:OnHighRewardScrollRenderGridCell(gridCell)
	local index = gridCell.index + 1
	local insID = gridCell.gameObject:GetInstanceID()
	local data = self.highAwardList[index]

	if self.highRewardScrollViewCell[insID] == nil then
		local highItem = highRewardScrollItem.New(gridCell.gameObject)

		self.highRewardScrollViewCell[insID] = highItem
	end

	self.highRewardScrollViewCell[insID]:Refresh(data)

	gridCell.transform.parent.gameObject.name = index
end

function PassGetTipPanel:OnSuperRewardScrollRenderGridCell(gridCell)
	local index = gridCell.index + 1
	local insID = gridCell.gameObject:GetInstanceID()
	local data = self.superAwardList[index]

	if self.superRewardScrollViewCell[insID] == nil then
		local superItem = superRewardScrollItem.New(gridCell.gameObject)

		self.superRewardScrollViewCell[insID] = superItem
	end

	self.superRewardScrollViewCell[insID]:Refresh(data)

	gridCell.transform.parent.gameObject.name = index
end

function PassGetTipPanel:Show(show)
	if self.gameObject.activeSelf == show then
		return
	end

	LuaUtility.SetGameObjectShow(self.gameObject, show)

	if not show then
		self:OnClose()
	end
end

function PassGetTipPanel:OnClose()
	LuaUtility.SetGameObjectShow(self.mainView.MainPanel, true)
end

function PassGetTipPanel:GetPanelIsShow()
	return self.gameObject.activeSelf
end

function PassGetTipPanel:RefreshHighScroll()
	self.highAwardList = {}

	self:GetAwardList(Constant.DiscreteData.PassActivityHighAward, self.highAwardList)

	local highRewardScroll = self.highRewardScroll:GetComponent("ScrollAreaList")

	highRewardScroll:Refresh(#self.highAwardList)
end

function PassGetTipPanel:RefreshSuperScroll()
	self.superAwardList = {}

	if self.buyHigh and not self.buySuper then
		self:GetAwardList(Constant.DiscreteData.PassActivityPriceDifferenceAward, self.superAwardList)
	else
		self:GetAwardList(Constant.DiscreteData.PassActivitySuperAward, self.superAwardList)
	end

	local superRewardScroll = self.superRewardScroll:GetComponent("ScrollAreaList")

	superRewardScroll:Refresh(#self.superAwardList)
end

function PassGetTipPanel:GetAwardList(discreteID, awardListTable)
	local awardList = CfgDiscreteDataTable[discreteID].Data

	for i = 1, #awardList, 3 do
		local awardData = {
			cid = awardList[i],
			num = awardList[i + 1],
			subscriptShow = awardList[i + 2] == 1
		}

		table.insert(awardListTable, awardData)
	end
end

function PassGetTipPanel:RefreshShow()
	self.normalCommodityData = ActivityPassModule.GetActivityPassCommodityData(CfgDiscreteDataTable[Constant.DiscreteData.ActivityPassBuyCommodityID].Data[1])
	self.highCommodityData = ActivityPassModule.GetActivityPassCommodityData(CfgDiscreteDataTable[Constant.DiscreteData.ActivityPassBuyCommodityID].Data[2])
	self.priceDifferenceCommodityData = ActivityPassModule.GetActivityPassCommodityData(CfgDiscreteDataTable[Constant.DiscreteData.ActivityPassBuyCommodityID].Data[3])
	self.buyHigh, self.buySuper = ActivityPassModule.GetHadBuyPassTypes_MultipleReturn()

	LuaUtility.SetGameObjectShow(self.normalCostItemImg, false)
	LuaUtility.SetGameObjectShow(self.highPurchased, self.buyHigh or self.buySuper)
	LuaUtility.SetGameObjectShow(self.btnHighPrice, not self.buyHigh and not self.buySuper)

	if not self.buyHigh and not self.buySuper then
		LuaUtility.SetGameObjectShow(self.normalCostItemImg, true)
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[self.normalCommodityData.config.Price[1][1]].Icon), self.normalCostItemImg:GetComponent("Image"))
		LuaUtility.SetText(self.textHighMoney, self.normalCommodityData:GetPrice())
	end

	LuaUtility.SetGameObjectShow(self.superCostItemImg, false)
	LuaUtility.SetGameObjectShow(self.superPurchased, self.buySuper)
	LuaUtility.SetGameObjectShow(self.btnSuperPrice, not self.buySuper)

	if not self.buySuper then
		local commodityData

		LuaUtility.SetGameObjectShow(self.superCostItemImg, true)

		if self.buyHigh == true and self.buySuper == false then
			commodityData = self.priceDifferenceCommodityData
		else
			commodityData = self.highCommodityData
		end

		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[commodityData.config.Price[1][1]].Icon), self.superCostItemImg:GetComponent("Image"))
		LuaUtility.SetText(self.textSuperMoney, commodityData:GetPrice())
	end

	self:RefreshHighScroll()
	self:RefreshSuperScroll()
end

function PassGetTipPanel:Dispose()
	for _, v in pairs(self.highRewardScrollViewCell) do
		v:Dispose()
	end

	for _, v in pairs(self.superRewardScrollViewCell) do
		v:Dispose()
	end

	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return PassGetTipPanel
