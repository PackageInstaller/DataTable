-- chunkname: @IQIGame\\UI\\Maze\\MazeActivityShopView.lua

local MazeActivityShopView = {}
local shopItemClass = require("IQIGame/UI/Maze/MazeActivityShopItemView")

function MazeActivityShopView.New(go, mainView)
	local o = Clone(MazeActivityShopView)

	o:Initialize(go, mainView)

	return o
end

function MazeActivityShopView:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.itemCellList = {}

	self:InitComponent()
	self:InitDelegate()
end

function MazeActivityShopView:InitComponent()
	self.shopScroll = self.shopScroll:GetComponent("OptimizedGridRect")

	self.shopScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:OnItemScrollRefresh(OptimizedParams, OptimizedViewsHolder)
	end)

	self.toggleBuy = self.toggleBuy:GetComponent("Toggle")
	self.toggleUp = self.toggleUp:GetComponent("Toggle")
end

function MazeActivityShopView:InitDelegate()
	function self.delegateOnClickButtonClose()
		self:Hide()
	end

	function self.onToggleBuyValueChangeDelegate(isOn)
		self:OnToggleBuyValueChange(isOn)
	end

	function self.onToggleUpValueChangeDelegate(isOn)
		self:OnToggleUpValueChange(isOn)
	end

	function self.delegateOnClickButtonUpLevel()
		self:OnClickButtonUpLevel()
	end

	function self.shopUpgradeEvent()
		self:OnUpgradeSuccess()
	end
end

function MazeActivityShopView:AddListener()
	self.buttonClose:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClose)
	self.toggleBuy.onValueChanged:AddListener(self.onToggleBuyValueChangeDelegate)
	self.toggleUp.onValueChanged:AddListener(self.onToggleUpValueChangeDelegate)
	self.buttonUpLevel:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonUpLevel)
	EventDispatcher.AddEventListener(EventID.ShopUpgradeEvent, self.shopUpgradeEvent)
	EventDispatcher.AddEventListener(EventID.BuyItemResult, self.shopUpgradeEvent)
	EventDispatcher.AddEventListener(EventID.NotifyChangeShopItems, self.shopUpgradeEvent)
end

function MazeActivityShopView:RemoveListener()
	self.buttonClose:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClose)
	self.toggleBuy.onValueChanged:RemoveListener(self.onToggleBuyValueChangeDelegate)
	self.toggleUp.onValueChanged:RemoveListener(self.onToggleUpValueChangeDelegate)
	self.buttonUpLevel:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonUpLevel)
	EventDispatcher.RemoveEventListener(EventID.ShopUpgradeEvent, self.shopUpgradeEvent)
	EventDispatcher.RemoveEventListener(EventID.BuyItemResult, self.shopUpgradeEvent)
	EventDispatcher.RemoveEventListener(EventID.NotifyChangeShopItems, self.shopUpgradeEvent)
end

function MazeActivityShopView:OnUpgradeSuccess()
	if self.itemRoot.activeSelf then
		self:RefreshItemScroll()
	elseif self.upRoot.activeSelf then
		self:RefreshLevelPanel()
	end
end

function MazeActivityShopView:OnClickButtonUpLevel()
	if ShopModule.GetMazeShopLevel() + 1 > ShopModule.GetMazeShopMaxLevel() then
		NoticeModule.ShowNoticeByType(Constant.NoticeType.FloatTips, "\xB5ȼ\xB6\xB4ﵽ\xC9\xCF\xCF\xDE")

		return
	end

	net_shop.upgradShop(Constant.ShopType.MazeShop)
end

function MazeActivityShopView:OnToggleBuyValueChange(isOn)
	LuaUtility.SetGameObjectShow(self.itemRoot, isOn)

	if isOn then
		self:RefreshItemScroll()
	end
end

function MazeActivityShopView:OnToggleUpValueChange(isOn)
	LuaUtility.SetGameObjectShow(self.upRoot, isOn)

	if isOn then
		self:RefreshLevelPanel()
	end
end

function MazeActivityShopView:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
	self:AddListener()
end

function MazeActivityShopView:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
	self:RemoveListener()
end

function MazeActivityShopView:OnItemScrollRefresh(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.rootGameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.itemDataList[index + 1]

	if not self.itemCellList[instanceID] then
		self.itemCellList[instanceID] = shopItemClass.New(viewGameObject, self)
	end

	self.itemCellList[instanceID]:Refresh(data)
end

function MazeActivityShopView:Refresh()
	self.toggleBuy.isOn = true

	self:OnToggleBuyValueChange(true)
	self:OnToggleUpValueChange(false)
end

function MazeActivityShopView:RefreshItemScroll()
	self.itemDataList = ShopModule.GetMazeShopItemList()

	if not self.itemDataList then
		logError("not mazeShopData")

		return
	end

	self.shopScroll:RefreshByItemCount(#self.itemDataList)
end

function MazeActivityShopView:RefreshLevelPanel()
	local shopData = ShopModule.GetShopDataWithShopID(Constant.ShopType.MazeShop)
	local cfgMazeShopData = CfgUtil.GetCfgMazeShopDataByLevel(shopData.level)

	if shopData.level + 1 > ShopModule.GetMazeShopMaxLevel() then
		LuaUtility.SetText(self.textLevel, "Max")
	else
		LuaUtility.SetText(self.textLevel, shopData.level + 1)
	end

	if cfgMazeShopData.UpgradeCost and #cfgMazeShopData.UpgradeCost > 0 then
		LuaUtility.SetText(self.textCost, cfgMazeShopData.UpgradeCost[2])
	else
		LuaUtility.SetText(self.textCost, 0)
	end
end

function MazeActivityShopView:OnDestroy()
	return
end

return MazeActivityShopView
