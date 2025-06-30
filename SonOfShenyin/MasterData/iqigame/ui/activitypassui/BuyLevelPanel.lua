-- chunkname: @IQIGame\\UI\\ActivityPassUI\\BuyLevelPanel.lua

local BuyLevelPanel = {
	textLevel = 0,
	showLevel = 1,
	levelRewardScrollViewCell = {}
}
local levelRewardScrollItem = require("IQIGame.UI.ActivityPassUI.levelRewardScrollItem")

function BuyLevelPanel.New(go, mainView)
	local o = Clone(BuyLevelPanel)

	o:Initialize(go, mainView)

	return o
end

function BuyLevelPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function BuyLevelPanel:InitComponent()
	local levelRewardScroll = self.levelRewardScroll:GetComponent("ScrollAreaList")

	function levelRewardScroll.onRenderCell(gridCell)
		self:OnLevelRewardScrollRenderGridCell(gridCell)
	end

	self.btnCancel = self.btnCancel:GetComponent("Button")
	self.btnAdd = self.btnAdd:GetComponent("Button")
	self.btnDev = self.btnDev:GetComponent("Button")
	self.btnBuy = self.btnBuy:GetComponent("Button")
	self.levelRewardCfgList = {}
end

function BuyLevelPanel:InitDelegate()
	function self.btnCancelDelegate()
		self:Show(false)
		self.mainView:OnButtonPassClick()
	end

	function self.btnAddDelegate()
		self:OnBtnAddClick()
	end

	function self.btnDevDelegate()
		self:OnBtnDevClick()
	end

	function self.btnBuyDelegate()
		self:OnBtnBuyClick()
	end
end

function BuyLevelPanel:AddListener()
	self.btnCancel.onClick:AddListener(self.btnCancelDelegate)
	self.btnAdd.onClick:AddListener(self.btnAddDelegate)
	self.btnDev.onClick:AddListener(self.btnDevDelegate)
	self.btnBuy.onClick:AddListener(self.btnBuyDelegate)
end

function BuyLevelPanel:RemoveListener()
	self.btnCancel.onClick:RemoveListener(self.btnCancelDelegate)
	self.btnAdd.onClick:RemoveListener(self.btnAddDelegate)
	self.btnDev.onClick:RemoveListener(self.btnDevDelegate)
	self.btnBuy.onClick:RemoveListener(self.btnBuyDelegate)
end

function BuyLevelPanel:OnBtnAddClick()
	if self.textLevel + ActivityPassModule.passLevel >= ActivityPassModule.GetPassMaxLevel() then
		return
	end

	local tempTextLevel = self.textLevel + 1
	local tempShowLevel = self.showLevel + 1

	if not ActivityModule.GetActivityPassCommodityCanBuy(CfgDiscreteDataTable[Constant.DiscreteData.ActivityPassBuyCommodityID].Data[4], tempTextLevel + ActivityPassModule.passLevel) then
		NoticeModule.ShowNotice(12026)

		return
	end

	local needNum, allNum = self:GetNeedNumBuyLv(tempTextLevel)

	if allNum < needNum then
		NoticeModule.ShowNotice(11011)

		return
	end

	self.textLevel = tempTextLevel
	self.showLevel = tempShowLevel

	self:RefreshShow()
end

function BuyLevelPanel:OnBtnDevClick()
	if self.textLevel <= 1 then
		return
	end

	self.textLevel = self.textLevel - 1
	self.showLevel = self.showLevel - 1

	self:RefreshShow()
end

function BuyLevelPanel:OnBtnBuyClick()
	if not WarehouseModule.GetUseMoneyIsEnough(self.commodityData:GetPriceIconId(), self.MoneySum) then
		NoticeModule.ShowCurrencyNotEnoughTips(self.commodityData:GetPriceIconId())

		return
	end

	if self.MoneySum == 0 then
		return
	end

	ShopModule.BuyItemRequest(self.commodityData.cid, self.MoneySum)
	self.mainView:OnButtonPassClick()
end

function BuyLevelPanel:OnLevelRewardScrollRenderGridCell(gridCell)
	local index = gridCell.index + 1
	local insID = gridCell.gameObject:GetInstanceID()
	local data = self.levelRewardCfgList[index]

	if self.levelRewardScrollViewCell[insID] == nil then
		local highItem = levelRewardScrollItem.New(gridCell.gameObject)

		self.levelRewardScrollViewCell[insID] = highItem
	end

	self.levelRewardScrollViewCell[insID]:Refresh(data)

	gridCell.transform.parent.gameObject.name = index
end

function BuyLevelPanel:IsShow()
	return self.gameObject.activeSelf
end

function BuyLevelPanel:Show(show)
	LuaUtility.SetGameObjectShow(self.gameObject, show)

	if show then
		self:OnOpen()
	end
end

function BuyLevelPanel:OnOpen()
	local checkResult, _ = ActivityModule.GetActivityPassCommodityCanBuy(CfgDiscreteDataTable[Constant.DiscreteData.ActivityPassBuyCommodityID].Data[4], ActivityPassModule.passLevel)

	if checkResult then
		self.textLevel = 1
	else
		self.textLevel = 0
	end

	self.showLevel = self.textLevel

	self:RefreshShow()
end

function BuyLevelPanel:RefreshLevelScroll()
	self.levelRewardCfgList = ActivityPassModule.GetPassRewardWithLvRange(ActivityPassModule.passLevel + 1, ActivityPassModule.passLevel + self.textLevel)

	local levelScroll = self.levelRewardScroll:GetComponent("ScrollAreaList")

	levelScroll:Refresh(#self.levelRewardCfgList)
end

function BuyLevelPanel:RefreshMoney()
	local needNum, allNum, commoditySum, expCount = self:GetNeedNumBuyLv(self.textLevel)

	if allNum < needNum then
		UGUIUtil.SetText(self.textNeedNum, string.format(ColorCfg.ActivityPassUI.Red, needNum))
	else
		UGUIUtil.SetText(self.textNeedNum, string.format(ColorCfg.ActivityPassUI.White, needNum))
	end

	UGUIUtil.SetText(self.expNumText, expCount)
	UGUIUtil.SetText(self.allNumText, allNum)

	self.MoneySum = commoditySum
end

function BuyLevelPanel:RefreshShow()
	UGUIUtil.SetText(self.presentLevelText, tostring(ActivityPassModule.passLevel))
	UGUIUtil.SetText(self.promoteLevelText, tostring(ActivityPassModule.passLevel + self.textLevel))
	UGUIUtil.SetText(self.textLevelNum, self.showLevel)

	self.commodityData = ActivityPassModule.GetActivityPassCommodityData(CfgDiscreteDataTable[Constant.DiscreteData.ActivityPassBuyCommodityID].Data[4])

	AssetUtil.LoadImage(self, ShopUIApi:GetShopBuyIconPath(self.commodityData:GetPriceIconId()), self.imgMoney:GetComponent("Image"))
	self:RefreshLevelScroll()
	self:RefreshMoney()
end

function BuyLevelPanel:GetNeedNumBuyLv(lv)
	local commoditySum = 0
	local expCount = 0

	for i = 1, lv do
		local exp = ActivityPassModule.GetLvExp(ActivityPassModule.passLevel - 1 + i)

		commoditySum = commoditySum + exp / self.commodityData.config.Number
		expCount = expCount + self.commodityData.config.Number
	end

	local allNum = WarehouseModule.GetItemNumByCfgID(Constant.ItemCid.NORMAL_MONEY)
	local needNum = tostring(commoditySum) * self.commodityData:GetPrice()

	return needNum, allNum, commoditySum, expCount
end

function BuyLevelPanel:Dispose()
	for _, v in pairs(self.levelRewardScrollViewCell) do
		v:Dispose()
	end

	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return BuyLevelPanel
