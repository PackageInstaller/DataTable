-- chunkname: @IQIGame\\UI\\ActivityShopUI.lua

local ActivityShopUI = {}

ActivityShopUI = Base:Extend("ActivityShopUI", "IQIGame.Onigao.UI.ActivityShopUI", ActivityShopUI)

local GiftBagShopCell = require("IQIGame.UI.Shop.GiftBagShopCell")
local tabItemClass = require("IQIGame/UI/SummerActivity/ActivityShopUI_tabItem")
local ItemBuyPanel = require("IQIGame.UI.Shop.ItemBuyPanel")
local dataName_theme = "theme"
local stateName_summer = "summer"
local stateName_ghost = "ghost"

function ActivityShopUI:OnInit()
	self:InitMembers()
	self:InitComponent()
	self:InitDelegate()
end

function ActivityShopUI:InitMembers()
	self.shopItemCellList = {}
	self.tabDataArray = {}
	self.tabCellList = {}
end

function ActivityShopUI:InitComponent()
	self.buttonReturn = CommonReturnBtn.New(self.Com_ReturnBtn, self)

	local shopItemScroll = self.shopItemScroll:GetComponent("ScrollAreaList")

	function shopItemScroll.onRenderCell(gridCell)
		self:OnShopItemRenderGridCell(gridCell)
	end

	self.tabScroll = self.tabScroll:GetComponent("OptimizedScrollRect")

	self.tabScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateTabScroll(OptimizedParams, OptimizedViewsHolder)
	end)

	self.resItemBuyPanel = ItemBuyPanel.New(self.BuyResItemPanel, self)

	self.resItemBuyPanel:HidePanel()

	self.moneyCell = CurrencyCell.New(self.currencyRoot)
end

function ActivityShopUI:InitDelegate()
	function self.buyItemResultEvent()
		self:Refresh()
		self:RefreshShopItemScroll(true)
	end

	function self.notifyChangeShopItemsEvent()
		self:Refresh()
		self:RefreshShopItemScroll(true)
	end

	function self.delegateOnClickTipsBtn()
		self:OnClickTipsBtn()
	end
end

function ActivityShopUI:OnAddListeners()
	self.TipsBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickTipsBtn)
	EventDispatcher.AddEventListener(EventID.BuyItemResult, self.buyItemResultEvent)
	EventDispatcher.AddEventListener(EventID.NotifyChangeShopItems, self.notifyChangeShopItemsEvent)
end

function ActivityShopUI:OnRemoveListeners()
	self.TipsBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickTipsBtn)
	EventDispatcher.RemoveEventListener(EventID.BuyItemResult, self.buyItemResultEvent)
	EventDispatcher.RemoveEventListener(EventID.NotifyChangeShopItems, self.notifyChangeShopItemsEvent)
end

function ActivityShopUI:OnClickTipsBtn()
	UIModule.Open(Constant.UIControllerName.SummerActivityTipsUI, Constant.UILayer.UI)
end

function ActivityShopUI:UpdateTabScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.tabDataArray[index + 1]

	if not self.tabCellList[instanceID] then
		self.tabCellList[instanceID] = tabItemClass.New(viewGameObject, self)
	end

	self.tabCellList[instanceID]:Refresh(data, index)
end

function ActivityShopUI:OnShopItemRenderGridCell(gridCellData)
	local data = ShopModule.shopDataSortList[self.currentTabId][gridCellData.index + 1]
	local insID = gridCellData.gameObject:GetInstanceID()
	local cell = self.shopItemCellList[insID]

	if cell == nil then
		cell = GiftBagShopCell.New(gridCellData.gameObject, self)
		self.shopItemCellList[insID] = cell
	end

	data.insID = insID

	cell:Refresh(data)

	gridCellData.gameObject.name = data.cid
end

function ActivityShopUI:OnOpen(userData)
	self.activityPod = userData.activityPod

	self:Refresh()
	self:SelectFirstTab()
end

function ActivityShopUI:OnClose(userData)
	return
end

function ActivityShopUI:GetPreloadAssetPaths()
	return nil
end

function ActivityShopUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ActivityShopUI:IsManualShowOnOpen(userData)
	return false
end

function ActivityShopUI:GetBGM(userData)
	return nil
end

function ActivityShopUI:OnPause()
	return
end

function ActivityShopUI:OnResume()
	return
end

function ActivityShopUI:OnCover()
	return
end

function ActivityShopUI:OnReveal()
	return
end

function ActivityShopUI:OnRefocus(userData)
	return
end

function ActivityShopUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ActivityShopUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ActivityShopUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ActivityShopUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ActivityShopUI:Refresh()
	local cfgActivity = CfgUtil.GetCfgActivityDataWithID(self.activityPod.cid)
	local shopType = cfgActivity.ExtraParam[1]

	self.tabDataArray = ShopModule.GetShopFirstTabDataWithTypes({
		shopType
	})

	self.tabScroll:RefreshByItemCount(#self.tabDataArray)

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self.endTime = ActivityModule.GetActivityStageOpenTime(self.activityPod.cid, #cfgActivity.Duration)
	self.timer = Timer.New(function()
		self:RefreshTime()
	end, 1, -1)

	self.timer:Start()
	self:RefreshTime()

	local TopMoneyType = Constant.TopMoneyType.ActivityShop

	if shopType == Constant.ShopType.SummerShop.Type then
		LuaUtility.SetStateController(self.gameObject, dataName_theme, stateName_summer)

		TopMoneyType = Constant.TopMoneyType.ActivityShop
	elseif shopType == Constant.ShopType.GhostShop.Type then
		LuaUtility.SetStateController(self.gameObject, dataName_theme, stateName_ghost)
	end

	self.moneyCell:RefreshItem(TopMoneyType)
end

function ActivityShopUI:RefreshTime()
	local serverTime = tonumber(PlayerModule.GetServerTime())
	local t = math.floor(tonumber(self.endTime) / 1000 - serverTime)

	t = math.max(0, t)

	LuaUtility.SetText(self.textTime, DateStandardFormation(t))
end

function ActivityShopUI:OnTabSelected(tabItem)
	if self.currentTabItem then
		self.currentTabItem:UnSelected()

		self.currentTabItem = nil
	end

	self.currentTabItem = tabItem

	self.currentTabItem:Selected()

	self.currentTabId = self.currentTabItem.data.Id

	self:RefreshShopItemScroll()
end

function ActivityShopUI:RefreshShopItemScroll(isDynamic)
	if not self.currentTabId then
		return
	end

	local shopItemScroll = self.shopItemScroll:GetComponent("ScrollAreaList")
	local cfgData = ShopModule.GetSortForTypeDataList(self.currentTabId)

	if isDynamic then
		shopItemScroll:RenderCellsDynamic(#cfgData)
	else
		shopItemScroll:Refresh(#cfgData)
	end
end

function ActivityShopUI:SelectFirstTab()
	local viewsHolder = self.tabScroll:GetItemViewsHolder(0)

	if viewsHolder then
		local instanceID = viewsHolder.instanceID

		self.tabCellList[instanceID]:OnClickButtonClick()
	end
end

function ActivityShopUI:OnDestroy()
	self.moneyCell:Dispose()

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	for _, v in pairs(self.tabCellList) do
		v:OnDestroy()
	end

	self.tabCellList = {}

	for _, v in pairs(self.shopItemCellList) do
		v:Dispose()
	end

	self.resItemBuyPanel:Dispose()
	self.buttonReturn:Dispose()
	AssetUtil.UnloadAsset(self)
end

return ActivityShopUI
