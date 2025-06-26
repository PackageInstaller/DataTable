-- chunkname: @IQIGame\\UI\\EndlessMazeRuneShopUI.lua

local EndlessMazeRuneShopUI = {
	RefreshPrice = 0,
	ShopTotalDiscount = 0,
	Refreshing = false,
	ShopCid = 0,
	ShopItems = {},
	SuitItems = {}
}

EndlessMazeRuneShopUI = Base:Extend("EndlessMazeRuneShopUI", "IQIGame.Onigao.UI.EndlessMazeRuneShopUI", EndlessMazeRuneShopUI)

local EndlessMazeRuneShopItem = require("IQIGame.UI.EndlessMazeRune.EndlessMazeRuneShopItem")
local EndlessMazeRuneTipController = require("IQIGame.UI.EndlessMazeRune.EndlessMazeRuneTipController")
local EndlessMazeRuneSuitItem = require("IQIGame.UI.EndlessMazeRune.EndlessMazeRuneSuitItem")

function EndlessMazeRuneShopUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnUpdateRune()
		self:OnUpdateRune()
	end

	function self.DelegateOnRefreshShop(shopData)
		self:OnRefreshShop(shopData)
	end

	function self.DelegateOnClickRefreshBtn()
		self:OnClickRefreshBtn()
	end

	self.CurrencyCell = MazeCurrencyCell.New(self.MoneyCell, Constant.ItemID.CRYSTAL)
	self.RuneTipController = EndlessMazeRuneTipController.New(self.TipView)

	local suitItemScrollList = self.SuitItemGrid:GetComponent("ScrollAreaList")

	function suitItemScrollList.onRenderCell(cell)
		self:OnRenderSuitCell(cell)
	end

	function suitItemScrollList.onSelectedCell(cell)
		self:OnSelectedSuitCell(cell)
	end

	local shopItemScrollList = self.GoodsGrid:GetComponent("ScrollAreaList")

	shopItemScrollList.defaultSelectedToggle = -1

	function shopItemScrollList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function shopItemScrollList.onSelectedCell(cell)
		self:OnSelectedCell(cell)
	end

	UGUIUtil.SetText(self.TitleText, EndlessMazeRuneShopUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.RuneSuitLabel, EndlessMazeRuneShopUIApi:GetString("RuneSuitLabel"))
	UGUIUtil.SetText(self.GoodsLabel, EndlessMazeRuneShopUIApi:GetString("GoodsLabel"))
	UGUIUtil.SetTextInChildren(self.RefreshBtn, EndlessMazeRuneShopUIApi:GetString("RefreshBtnText"))
end

function EndlessMazeRuneShopUI:GetPreloadAssetPaths()
	local cfgItemData = CfgItemTable[Constant.ItemID.CRYSTAL]
	local costItemIconPath = UIGlobalApi.GetIconPath(cfgItemData.Icon)

	return {
		costItemIconPath
	}
end

function EndlessMazeRuneShopUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EndlessMazeRuneShopUI:OnOpen(userData)
	self.RuneTipController:Hide()
	self:UpdateView(userData.shopData)
end

function EndlessMazeRuneShopUI:OnClose(userData)
	return
end

function EndlessMazeRuneShopUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.RefreshBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickRefreshBtn)
	EventDispatcher.AddEventListener(EventID.MazeUpdateRune, self.DelegateOnUpdateRune)
	EventDispatcher.AddEventListener(EventID.MazeRuneRefreshShop, self.DelegateOnRefreshShop)
end

function EndlessMazeRuneShopUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.RefreshBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickRefreshBtn)
	EventDispatcher.RemoveEventListener(EventID.MazeUpdateRune, self.DelegateOnUpdateRune)
	EventDispatcher.RemoveEventListener(EventID.MazeRuneRefreshShop, self.DelegateOnRefreshShop)
end

function EndlessMazeRuneShopUI:OnPause()
	return
end

function EndlessMazeRuneShopUI:OnResume()
	return
end

function EndlessMazeRuneShopUI:OnCover()
	return
end

function EndlessMazeRuneShopUI:OnReveal()
	return
end

function EndlessMazeRuneShopUI:OnRefocus(userData)
	return
end

function EndlessMazeRuneShopUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EndlessMazeRuneShopUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EndlessMazeRuneShopUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EndlessMazeRuneShopUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EndlessMazeRuneShopUI:OnDestroy()
	self.CurrencyCell:Dispose()
	self.RuneTipController:Dispose()

	for gameObject, shopItem in pairs(self.ShopItems) do
		shopItem:Dispose()
	end

	self.ShopItems = nil

	for gameObject, suiItem in pairs(self.SuitItems) do
		suiItem:Dispose()
	end

	self.SuitItems = nil
end

function EndlessMazeRuneShopUI:OnClickCloseBtn()
	UIModule.Close(Constant.UIControllerName.EndlessMazeRuneShopUI)
	MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_CLOSE_RUNE_SHOP)
end

function EndlessMazeRuneShopUI:UpdateView(shopData)
	self.ShopCid = shopData.CID
	self.Runes = shopData.Runes
	self.ItemDiscounts = {}

	for i = 1, #shopData.Discounts do
		self.ItemDiscounts[i] = math.round(shopData.Discounts[i] * 10) / 10
	end

	self.SoldOutItemIndexList = shopData.BuyRuneList
	self.ShopTotalDiscount = shopData.PriceChange
	self.RefreshPrice = shopData.RefreshPrice

	local shopItemScrollList = self.GoodsGrid:GetComponent("ScrollAreaList")

	shopItemScrollList:Refresh(#self.Runes)

	self.RefreshBtn:GetComponent("Button").interactable = MazeDataModule.GetItemNumByCfgID(Constant.ItemID.CRYSTAL) >= self.RefreshPrice

	UGUIUtil.SetText(self.RefreshCostText, self.RefreshPrice)
	self:RefreshSuit()
end

function EndlessMazeRuneShopUI:OnRefreshShop(shopData)
	self.Refreshing = false

	self:UpdateView(shopData)
end

function EndlessMazeRuneShopUI:RefreshSuit()
	self.SuitDataList = {}

	local cidList, numList = MazeModule.GetEndlessMazeRuneSuitData()
	local legendCidList = MazeModule.GetEndlessMazeLegendRuneSuitData(cidList, numList)

	if #legendCidList > 0 then
		table.insert(self.SuitDataList, {
			type = 2,
			list = legendCidList
		})
	end

	for i = 1, #cidList do
		table.insert(self.SuitDataList, {
			type = 1,
			cid = cidList[i],
			num = numList[i]
		})
	end

	local suitItemScrollList = self.SuitItemGrid:GetComponent("ScrollAreaList")

	suitItemScrollList:Refresh(#self.SuitDataList)
end

function EndlessMazeRuneShopUI:OnRenderSuitCell(cell)
	local suitItem = self.SuitItems[cell.gameObject]

	if suitItem == nil then
		suitItem = EndlessMazeRuneSuitItem.New(cell.gameObject)
		self.SuitItems[cell.gameObject] = suitItem
	end

	local data = self.SuitDataList[cell.index + 1]

	if data ~= nil then
		local num

		if data.type == 1 then
			num = data.num
		else
			num = #data.list
		end

		suitItem:SetData(data.type, data.cid, num)
	end
end

function EndlessMazeRuneShopUI:OnSelectedSuitCell(cell)
	local data = self.SuitDataList[cell.index + 1]

	if data.type == 1 then
		UIModule.Open(Constant.UIControllerName.EndlessMazeRuneSuitTipUI, Constant.UILayer.Tooltip, {
			suitCid = data.cid,
			partNum = data.num,
			srcTrans = cell.gameObject.transform,
			srcSide = UGUISide.TopRight,
			tipSide = UGUISide.BottomLeft
		})
	else
		UIModule.Open(Constant.UIControllerName.EndlessMazeRuneLegendSuitTipUI, Constant.UILayer.Tooltip, {
			list = data.list,
			srcTrans = cell.gameObject.transform,
			srcSide = UGUISide.TopRight,
			tipSide = UGUISide.BottomLeft
		})
	end
end

function EndlessMazeRuneShopUI:OnRenderCell(cell)
	local runeCid = self.Runes[cell.index + 1]
	local shopItem = self.ShopItems[cell.gameObject]

	if shopItem == nil then
		local cfgItemData = CfgItemTable[Constant.ItemID.CRYSTAL]
		local costItemIconPath = UIGlobalApi.GetIconPath(cfgItemData.Icon)
		local costItemIconSprite = LuaCodeInterface.ToSprite(self.UIController:GetPreloadedAsset(costItemIconPath))

		shopItem = EndlessMazeRuneShopItem.New(cell.gameObject, costItemIconSprite)
		self.ShopItems[cell.gameObject] = shopItem
	end

	local isSoldOut = table.indexOf(self.SoldOutItemIndexList, cell.index + 1) ~= -1

	shopItem:SetData(runeCid, self.ItemDiscounts[cell.index + 1], isSoldOut, self.ShopTotalDiscount, cell.index + 1)
end

function EndlessMazeRuneShopUI:OnSelectedCell(cell)
	local shopItem = self.ShopItems[cell.gameObject]

	self.RuneTipController:ShowByCfg(shopItem.RuneCell.CfgRuneData)
end

function EndlessMazeRuneShopUI:OnUpdateRune()
	self:RefreshSuit()
end

function EndlessMazeRuneShopUI:OnClickRefreshBtn()
	if self.Refreshing then
		return
	end

	self.Refreshing = true

	MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_RUNE_SHOP_REFRESH)
end

return EndlessMazeRuneShopUI
