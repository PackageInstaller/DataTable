-- chunkname: @IQIGame\\UI\\Activity\\GroupBuy\\ActiveGroupBuyRenderCell.lua

local m = {
	ItemCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")

function m.New(view, rootUI)
	local obj = Clone(m)

	obj:Init(view, rootUI)

	return obj
end

function m:Init(view, rootUI)
	self.View = view
	self.Root = rootUI

	LuaCodeInterface.BindOutlet(self.View, self)
	self.ItemMould:SetActive(false)
	UGUIUtil.SetText(self.TextBuyService, ActivityUIApi:GetString("TextBuyService"))
	UGUIUtil.SetText(self.TextCurrent, ActivityUIApi:GetString("TextCurrent"))
	UGUIUtil.SetText(self.TextBuyOver, ActivityUIApi:GetString("TextBuyOver"))

	function self.delegateBtnBuy()
		self:OnBtnBuy()
	end

	self.ItemCellPool = UIObjectPool.New(3, function()
		return ItemCell.New(UnityEngine.Object.Instantiate(self.ItemMould))
	end, function(cell)
		local view = cell.ViewGo

		cell:Dispose()
		UnityEngine.Object.Destroy(view)
	end)

	self:AddListener()
end

function m:AddListener()
	self.BtnBuy:GetComponent("Button").onClick:AddListener(self.delegateBtnBuy)
end

function m:RemoveListener()
	self.BtnBuy:GetComponent("Button").onClick:RemoveListener(self.delegateBtnBuy)
end

function m:OnBtnBuy()
	UIModule.Open(Constant.UIControllerName.BuySellGiftUI, Constant.UILayer.UI, {
		self.cfgGroupBuyPack,
		self.groupBuyID
	})
end

function m:SetData(data, groupBuyID)
	self.data = data
	self.groupBuyID = groupBuyID
	self.cfgGroupBuyPack = CfgGroupBuyPackTable[data]

	UGUIUtil.SetText(self.TextName, self.cfgGroupBuyPack.Name)

	for i, v in pairs(self.ItemCells) do
		v.ViewGo:SetActive(false)
		v.ViewGo.transform:SetParent(self.Root.UIController.transform, false)
		self.ItemCellPool:Release(v)
	end

	self.ItemCells = {}

	for i = 1, #self.cfgGroupBuyPack.Reward, 2 do
		local itemId = self.cfgGroupBuyPack.Reward[i]
		local itemNum = self.cfgGroupBuyPack.Reward[i + 1]
		local itemCell = self.ItemCellPool:Obtain()

		itemCell.ViewGo:SetActive(true)
		itemCell.ViewGo.transform:SetParent(self.ItemGrid.transform, false)
		itemCell:SetItemByCID(itemId, itemNum)
		table.insert(self.ItemCells, itemCell)
	end

	local buyCount, totalCount = ActiveGroupBuyModule.GetServerBuyCount(self.cfgGroupBuyPack.Id, self.groupBuyID)
	local cfgMaxCount = self.cfgGroupBuyPack.Discount[#self.cfgGroupBuyPack.Discount][2]

	UGUIUtil.SetText(self.TextBuyServiceValue, ActivityUIApi:GetString("TextBuyServiceValue", totalCount, cfgMaxCount))

	local haveBuyCount = self.cfgGroupBuyPack.TimesLimit - buyCount
	local canBuy = haveBuyCount > 0

	self.CanBuy:SetActive(canBuy)
	self.BuyOver:SetActive(not canBuy)
	UGUIUtil.SetText(self.TextHaveNum, ActivityUIApi:GetString("TextHaveNum", haveBuyCount, self.cfgGroupBuyPack.TimesLimit))
	UGUIUtil.SetText(self.TextOverValue, ActivityUIApi:GetString("TextOverValue", haveBuyCount, self.cfgGroupBuyPack.TimesLimit))

	local spendID = 0
	local spendNum = 0

	if self.cfgGroupBuyPack.payPoint > 0 then
		spendID = Constant.ItemID.ID_PAYPOINT_SHOW
		spendNum = self.cfgGroupBuyPack.payPoint
	elseif #self.cfgGroupBuyPack.Price > 0 then
		spendID = self.cfgGroupBuyPack.Price[1]
		spendNum = self.cfgGroupBuyPack.Price[2]
	end

	if spendID > 0 then
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[spendID].Icon), self.ImgSpend:GetComponent("Image"))
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[spendID].Icon), self.ImgMoney:GetComponent("Image"))
	end

	UGUIUtil.SetText(self.TextSpendValue, tostring(spendNum))

	local currentData, nextData = ActiveGroupBuyModule.GetDiscountData(self.cfgGroupBuyPack.Id, self.groupBuyID)

	UGUIUtil.SetText(self.TextNext, ActivityUIApi:GetString("TextNext", nextData[2] - totalCount))

	local isShow = currentData ~= nil

	self.DiscountView:SetActive(isShow)

	if currentData then
		UGUIUtil.SetText(self.TextCurrentValue, ActivityUIApi:GetString("TextCurrentValue", currentData[1] * 100))
		UGUIUtil.SetText(self.TextMoney, math.floor(spendNum * buyCount * currentData[1]))
	end

	self:UpdatePerCent()
end

function m:UpdatePerCent()
	local buyCount, totalCount = ActiveGroupBuyModule.GetServerBuyCount(self.cfgGroupBuyPack.Id, self.groupBuyID)
	local currentData, nextData, index = ActiveGroupBuyModule.GetDiscountData(self.cfgGroupBuyPack.Id, self.groupBuyID)
	local per = 0

	if totalCount > 0 then
		if currentData == nil then
			per = totalCount / nextData[2] * 0.2 + index * 0.2
		else
			per = totalCount >= nextData[2] and 1 or (totalCount - currentData[2]) / (nextData[2] - currentData[2]) * 0.2 + index * 0.2
		end
	end

	local index = math.floor(per * 100 / 20) + 1

	self.ImgProgress:GetComponent("Image").fillAmount = per

	for i = 1, 6 do
		if i <= index then
			self["PointMould" .. i]:SetActive(true)

			local isCurrent = i == index

			self["PointMould" .. i].transform:Find("Image_01").gameObject:SetActive(not isCurrent)
			self["PointMould" .. i].transform:Find("Image_02").gameObject:SetActive(isCurrent)
		else
			self["PointMould" .. i]:SetActive(false)
		end
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	for i, v in pairs(self.ItemCells) do
		self.ItemCellPool:Release(v)
	end

	self.ItemCells = {}

	self.ItemCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
