-- chunkname: @IQIGame\\UI\\EndlessMazeRune\\EndlessMazeRuneShopItem.lua

local m = {
	Index = 0,
	IsSoldOut = false,
	FinalPrice = 0
}
local EndlessMazeRuneCell = require("IQIGame.UI.EndlessMazeRune.EndlessMazeRuneCell")

function m.New(view, costItemSprite)
	local obj = Clone(m)

	obj:Init(view, costItemSprite)

	return obj
end

function m:Init(view, costItemSprite)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickBuyBtn()
		self:OnClickBuyBtn()
	end

	function self.DelegateOnUpdateNumAttr()
		self:OnUpdateNumAttr()
	end

	self.RuneCell = EndlessMazeRuneCell.New(self.RuneSlotUI, false)

	UGUIUtil.SetText(self.SoldOutText, EndlessMazeRuneShopUIApi:GetString("SoldOutText"))

	self.CostItemIcon:GetComponent("Image").sprite = costItemSprite

	self:AddEventListeners()
end

function m:AddEventListeners()
	self.BuyBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBuyBtn)
	EventDispatcher.AddEventListener(EventID.MazeUpdateNumAttr, self.DelegateOnUpdateNumAttr)
end

function m:RemoveEventListeners()
	self.BuyBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBuyBtn)
	EventDispatcher.RemoveEventListener(EventID.MazeUpdateNumAttr, self.DelegateOnUpdateNumAttr)
end

function m:SetData(runeCid, itemDiscount, isSoldOut, shopPriceIncreaseRatio, index)
	self.IsSoldOut = isSoldOut
	self.Index = index

	local cfgRuneData = CfgRuneTable[runeCid]

	self.RuneCell:SetDataByCfgData(cfgRuneData)
	UGUIUtil.SetText(self.DiscountText, EndlessMazeRuneShopUIApi:GetString("RuneDiscountText", itemDiscount / 10))
	UGUIUtil.SetText(self.NameText, cfgRuneData.Name)
	self.SoldOutNode:SetActive(isSoldOut)
	self.BuyBtn:SetActive(not isSoldOut)

	self.FinalPrice = math.floor(cfgRuneData.Price * (itemDiscount / 100) * (1 + shopPriceIncreaseRatio / 100))

	if self.FinalPrice <= 0 then
		self.FinalPrice = 1
	end

	UGUIUtil.SetText(self.CostItemNumText, EndlessMazeRuneShopUIApi:GetString("RunePriceText", self.FinalPrice, MazeDataModule.GetItemNumByCfgID(Constant.ItemID.CRYSTAL) >= self.FinalPrice))
	self.DiscountTag:SetActive(itemDiscount ~= 100)
end

function m:OnClickBuyBtn()
	if self.IsSoldOut then
		return
	end

	if MazeDataModule.GetItemNumByCfgID(Constant.ItemID.CRYSTAL) < self.FinalPrice then
		NoticeModule.ShowNotice(21050003)

		return
	end

	MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_RUNE_SHOP_BUY, {
		Index = self.Index
	})
	self.SoldOutNode:SetActive(true)
	self.BuyBtn:SetActive(false)
end

function m:OnUpdateNumAttr()
	UGUIUtil.SetText(self.CostItemNumText, EndlessMazeRuneShopUIApi:GetString("RunePriceText", self.FinalPrice, MazeDataModule.GetItemNumByCfgID(Constant.ItemID.CRYSTAL) >= self.FinalPrice))
end

function m:Dispose()
	self:RemoveEventListeners()
	self.RuneCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
