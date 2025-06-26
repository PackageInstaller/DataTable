-- chunkname: @IQIGame\\UI\\Maze\\MazeUIShopElement.lua

local MazeUIShopLevelUpElement = require("IQIGame/UI/Maze/MazeUIShopLevelUpElement")
local GiftBagShopCell = require("IQIGame.UI.Shop.GiftBagShopCell")
local ItemCell = {}

function ItemCell.New(view)
	local obj = Clone(ItemCell)

	obj:__Init(view)

	return obj
end

function ItemCell:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.__delegateOnItemCellClick()
		self:__OnItemCellClick()
	end

	self.gameObject:GetComponent("Button").onClick:AddListener(self.__delegateOnItemCellClick)
end

function ItemCell:__OnItemCellClick()
	if not self.canBuy then
		return
	end

	ShopModule.BuyItemRequest(self.shopCommodityData.cid, 1)
end

function ItemCell:Show(shopCommodityData)
	self.gameObject:SetActive(true)
	self:__RefreshShow(shopCommodityData)
end

function ItemCell:__RefreshShow(shopCommodityData)
	self.shopCommodityData = shopCommodityData

	local itemCid = shopCommodityData.config.ItemId
	local itemCfg = CfgItemTable[itemCid]
	local itemIconPath = UIGlobalApi.GetIconPath(itemCfg.Icon)

	AssetUtil.LoadImage(self, itemIconPath, self.itemIcon:GetComponent("Image"))

	local qualityPath = CommonSlotUIApi:GetItemFrame(Constant.ItemType.Item, itemCfg.Quality)

	AssetUtil.LoadImage(self, qualityPath, self.qualityBg:GetComponent("Image"))

	self.nameText:GetComponent("Text").text = itemCfg.Name
	self.canBuy = shopCommodityData.buyLimit > shopCommodityData.buyNum

	if self.canBuy then
		self.emptyTag.gameObject:SetActive(false)
	else
		self.emptyTag.gameObject:SetActive(true)
	end
end

function ItemCell:Hide()
	self.gameObject:SetActive(false)
end

function ItemCell:Dispose()
	self.gameObject:GetComponent("Button").onClick:RemoveListener(self.__delegateOnItemCellClick)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local Element = {
	itemCellList = {},
	itemDataList = {}
}

function Element.New(view)
	local obj = Clone(Element)

	obj:__Init(view)

	return obj
end

function Element:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.levelUpElement = MazeUIShopLevelUpElement.New(self.levelUpRoot)
	self.scrollAreaList = self.scrollAreaListRoot:GetComponent("ScrollAreaList")

	function self.scrollAreaList.onRenderCell(cell)
		self:__OnRenderItemCell(cell)
	end

	function self.__delegateOnShopItemChange()
		self:__OnShopItemChange()
	end

	self.commonReturnBtn = CommonReturnBtn.New(self.commonReturnBtn, self)

	self.commonReturnBtn:RegisterReturnEvent(function()
		self:Hide()
	end)

	self.moneyCell = CurrencyCell.New(self.moneyTopRoot)
end

function Element:__OnRenderItemCell(cell)
	local dataIndex = cell.index + 1
	local data = self.itemDataList[dataIndex]
	local insID = cell.gameObject:GetInstanceID()
	local itemCell = self.itemCellList[insID]

	if itemCell == nil then
		itemCell = GiftBagShopCell.New(cell.gameObject)
		self.itemCellList[insID] = itemCell
	end

	data.insID = insID

	itemCell:Refresh(data)

	cell.gameObject.name = data.cid
end

function Element:Show()
	self.gameObject:SetActive(true)
	self.moneyCell:RefreshItem(Constant.TopMoneyType.MazeShopUI)
	self.levelUpElement:Hide()
	self:__AddEnableEventListener()
	self:__ShowShop()
	self:__RefreshItemsShow()
	self:__DisposeDelayTimer()
	LuaUtility.SetGameObjectShow(self.lvUpButton, false)
	LuaUtility.SetGameObjectShow(self.levelNumEn, false)
	LuaUtility.SetGameObjectShow(self.levelNumCn, false)
end

function Element:__DisposeDelayTimer()
	if self.__delayTimer == nil then
		return
	end

	self.__delayTimer:Stop()

	self.__delayTimer = nil
end

function Element:__ShowShop()
	EventDispatcher.AddEventListener(EventID.NotifyChangeShopItems, self.__delegateOnShopItemChange)
end

function Element:__HideShop()
	EventDispatcher.RemoveEventListener(EventID.NotifyChangeShopItems, self.__delegateOnShopItemChange)
end

function Element:__RefreshItemsShow()
	self.itemDataList = ShopModule.GetMazeShopItemList()

	self.scrollAreaList:Refresh(#self.itemDataList)
	self.moneyCell:RefreshItem(Constant.TopMoneyType.MazeShopUI)
	self:__RefreshLvInfo()
end

function Element:__RefreshLvInfo()
	return
end

function Element:__OnShopItemChange()
	self:__RefreshItemsShow()
end

function Element:__OnMazeShopLevelChange()
	self:__RefreshItemsShow()
	self.levelUpElement:Hide()
end

function Element:Hide()
	self:__DisposeDelayTimer()
	self:__HideShop()
	self:__RemoveEnableListener()
	self.gameObject:SetActive(false)
end

function Element:__OnClicklvUpButton()
	self.levelUpElement:Show()
end

function Element:__AddEventListener()
	self.lvUpButton:GetComponent("Button").onClick:AddListener(self.__delegateOnClicklvUpButton)
end

function Element:__RemoveListener()
	self.lvUpButton:GetComponent("Button").onClick:RemoveListener(self.__delegateOnClicklvUpButton)
end

function Element:__AddEnableEventListener()
	EventDispatcher.AddEventListener(EventID.NotifyChangeShopItems, self.__delegateOnShopItemChange)
end

function Element:__RemoveEnableListener()
	EventDispatcher.RemoveEventListener(EventID.NotifyChangeShopItems, self.__delegateOnShopItemChange)
end

function Element:Dispose()
	self:Hide()
	self:__RemoveListener()
	self.levelUpElement:Dispose()

	self.scrollAreaList.onRenderCell = nil
	self.scrollAreaList = nil

	self.commonReturnBtn:Dispose()

	for k, v in pairs(self.itemCellList) do
		v:Dispose()
	end

	self.moneyCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return Element
