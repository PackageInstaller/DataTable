-- chunkname: @IQIGame\\UI\\Maze\\MazeBusinessmanShopElement.lua

local ItemDetailElement = require("IQIGame.UI.Maze.MazeBusinessmanShopElement_ItemDetails")
local BuffGroupTitleItemView = require("IQIGame.UI.Maze.ItemCell.BuffGroupTitleItemView")
local ShopItemCell = {}

function ShopItemCell.New(view, buyFunc, clickItemFunc)
	local obj = Clone(ShopItemCell)

	obj:__Init(view, buyFunc, clickItemFunc)

	return obj
end

function ShopItemCell:__Init(view, buyFunc, clickItemFunc)
	self.gameObject = view
	self.buyItemHandler = buyFunc
	self.clickItemFunc = clickItemFunc

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.__delegateOnBuyButtonClick()
		self:__OnBuyButtonClick()
	end

	function self.__delegateOnClickItemDetailsBtn()
		self:__OnClickItemDetailsBtn()
	end

	self.buffGroupTitleItemView = BuffGroupTitleItemView.New(self.buffGroupTitle)
	self.buyBtnGrayCom = self.buyBtn:GetComponent("GrayComponent")

	self.buyBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnBuyButtonClick)
	self.gameObject:GetComponent("Button").onClick:AddListener(self.__delegateOnClickItemDetailsBtn)
end

function ShopItemCell:Show(itemData)
	self.gameObject:SetActive(true)

	self.shopItemData = itemData

	local itemCfg = CfgItemTable[self.shopItemData.itemCid]
	local itemIconPath = UIGlobalApi.GetIconPath(itemCfg.Icon)

	AssetUtil.LoadImage(self, itemIconPath, self.itemIcon:GetComponent("Image"))

	local qualityPath = CommonSlotUIApi:GetItemFrame(Constant.ItemType.Item, itemCfg.Quality)

	AssetUtil.LoadImage(self, qualityPath, self.qualityBg:GetComponent("Image"))

	local canBuyItem = itemData.limitNum > 0 and not MazeModule.GetHasBuffByCid(itemData.itemCid)

	self.buyBtnGrayCom:SetGray(not canBuyItem)
	LuaUtility.SetGameObjectShow(self.buyLimitParent, not canBuyItem)
	UGUIUtil.SetText(self.itemName, itemCfg.Name)
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[self.shopItemData.costCid].Icon), self.costImg:GetComponent("Image"))

	local discountTalenData = MazeModule.GetSenroDataByEffectType(Constant.MazeSenroEffectType.ShopDiscount)
	local costNum = self.shopItemData.costNum

	if discountTalenData ~= nil then
		local discount = CfgLabyrinthSenrotalentTable[discountTalenData.id].TalentParams[discountTalenData.level][1]

		costNum = self:GetDiscountPrice(discount, tonumber(self.shopItemData.costNum))
	end

	UGUIUtil.SetText(self.costText, costNum)

	local partDiscountTalenData = MazeModule.GetSenroDataByEffectType(Constant.MazeSenroEffectType.ShopPartDiscount)

	if partDiscountTalenData ~= nil and MazeModule.GetGoodsIsDiscount(itemData.Id) then
		LuaUtility.SetGameObjectShow(self.discountPriceText, true)

		local discount = CfgLabyrinthSenrotalentTable[partDiscountTalenData.id].TalentParams[partDiscountTalenData.level][2]
		local discountNum = self:GetDiscountPrice(discount, costNum)

		UGUIUtil.SetText(self.discountPriceText, costNum)
		UGUIUtil.SetText(self.costText, discountNum)
	else
		LuaUtility.SetGameObjectShow(self.discountPriceText, false)
	end

	UGUIUtil.SetText(self.limitNumText, itemData.limitNum)
	UGUIUtil.SetText(self.buffDescText, itemCfg.ItemTips)
	self.buffGroupTitleItemView:SetData(itemData.Id)

	self.descScrollView:GetComponent("ScrollRect").verticalNormalizedPosition = 1
end

function ShopItemCell:GetDiscountPrice(discount, price)
	local discountResult = math.floor((1 - discount / 100) * tonumber(price))

	return discountResult < 1 and 1 or discountResult
end

function ShopItemCell:Select()
	LuaUtility.SetGameObjectShow(self.selectImage, true)
end

function ShopItemCell:UnSelect()
	LuaUtility.SetGameObjectShow(self.selectImage, false)
end

function ShopItemCell:__OnBuyButtonClick()
	if self.buyItemHandler == nil then
		return
	end

	self.buyItemHandler(self.shopItemData)
end

function ShopItemCell:__OnClickItemDetailsBtn()
	if self.clickItemFunc == nil then
		return
	end

	self.clickItemFunc(self.shopItemData)
	self:Select()
end

function ShopItemCell:Hide()
	self.gameObject:SetActive(false)
end

function ShopItemCell:Dispose()
	self.buyBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnBuyButtonClick)
	self.gameObject:GetComponent("Button").onClick:RemoveListener(self.__delegateOnClickItemDetailsBtn)
	self.buffGroupTitleItemView:Dispose()

	self.buyBtnGrayCom = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local Element = {
	merchantId = 0,
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

	self.scrollAreaList = self.scrollAreaListRoot:GetComponent("ScrollAreaList")

	function self.scrollAreaList.onRenderCell(cell)
		self:__OnRenderItemCell(cell)
	end

	function self.__delegateOnCloseBtnClick()
		self:__OnCloseBtnClick()
	end

	function self.__delegateOnMazeRefreshEvent()
		self:OnMazeRefreshEvent()
	end

	function self.__delegateOnRefreshBtnClick()
		self:__OnRefreshBtnClick()
	end

	function self.__delegateOnUpdateStageEventLinkResult()
		self:__OnUpdateStageEventLinkResult()
	end

	self.moneyCell = CurrencyCell.New(self.moneyTopRoot)
	self.itemDetailsView = ItemDetailElement.New(self.itemDetailsView, function()
		self:__OnDetailsViewCloseCallback()
	end)

	self.closeBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnCloseBtnClick)
	self.refreshBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnRefreshBtnClick)
end

function Element:__OnRenderItemCell(cell)
	local insID = cell.gameObject:GetInstanceID()
	local itemCell = self.itemCellList[insID]

	if itemCell == nil then
		itemCell = ShopItemCell.New(cell.gameObject, function(_itemData)
			self:__BuyItem(_itemData)
		end, function(_itemData)
			self:__OpenItemDetailsView(_itemData)
		end)
		self.itemCellList[insID] = itemCell
	end

	local dataIndex = cell.index + 1

	itemCell:Show(self.itemDataList[dataIndex])
	itemCell:UnSelect()
end

function Element:__RefreshShopData(isDynamic)
	local stageMapPOD = MazeModule.GetRoomStageMapData(self.curRoomCid)

	self.stageEventLinkPod = stageMapPOD.eventLinkPod
	self.itemDataList = MazeModule.GetSortedGoodsData(self.stageEventLinkPod.buyGoodsNum)

	if isDynamic then
		self.scrollAreaList:RenderCellsDynamic(#self.itemDataList)
	else
		self.scrollAreaList:Refresh(#self.itemDataList)
	end
end

function Element:__ShowRefreshInfo()
	self.maxRefreshCount = 0

	local openRefreshTalenData = MazeModule.GetSenroDataByEffectType(Constant.MazeSenroEffectType.OpenShopRefresh)

	if openRefreshTalenData == nil then
		LuaUtility.SetGameObjectShow(self.refreshParent, false)

		return
	end

	LuaUtility.SetGameObjectShow(self.refreshParent, true)

	local openRefreshTalenCfg = CfgLabyrinthSenrotalentTable[openRefreshTalenData.id]

	self.maxRefreshCount = openRefreshTalenCfg.TalentParams[openRefreshTalenData.level][1]

	local freeRefreshTalentData = MazeModule.GetSenroDataByEffectType(Constant.MazeSenroEffectType.FreeRefresh)
	local serverFreeFreshTime = self.stageEventLinkPod.freeFreshTime

	if freeRefreshTalentData ~= nil and serverFreeFreshTime < CfgLabyrinthSenrotalentTable[freeRefreshTalentData.id].TalentParams[freeRefreshTalentData.level][1] then
		local freeRefreshTalentCfg = CfgLabyrinthSenrotalentTable[freeRefreshTalentData.id]

		LuaUtility.SetGameObjectShow(self.freeRefreshParent, true)
		LuaUtility.SetGameObjectShow(self.refreshCountParent, false)
		LuaUtility.SetGameObjectShow(self.costParent, false)
		UGUIUtil.SetText(self.freeRefreshCountText, string.format("(%s/%s)", freeRefreshTalentCfg.TalentParams[freeRefreshTalentData.level][1] - serverFreeFreshTime, freeRefreshTalentCfg.TalentParams[freeRefreshTalentData.level][1]))
	else
		LuaUtility.SetGameObjectShow(self.freeRefreshParent, false)
		LuaUtility.SetGameObjectShow(self.refreshCountParent, true)
		LuaUtility.SetGameObjectShow(self.costParent, true)
		UGUIUtil.SetText(self.refreshCountText, string.format("(%s/%s)", self.maxRefreshCount - self.stageEventLinkPod.freshTime, self.maxRefreshCount))

		local labyrinthEventTable = CfgLabyrinthEventTable[self.stageEventLinkPod.curEventId]
		local LabyrinthEventTraderCfg = CfgLabyrinthEventTraderTable[labyrinthEventTable.SubTypeID]
		local itemCfg = CfgItemTable[LabyrinthEventTraderCfg.RefreshCost[1]]

		UGUIUtil.SetText(self.refreshCost, LabyrinthEventTraderCfg.RefreshCost[2])
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(itemCfg.SmallIcon), self.refreshCostIconImg:GetComponent("Image"))
	end
end

function Element:__BuyItem(itemData)
	if itemData.limitNum <= 0 or MazeModule.GetHasBuffByCid(itemData.itemCid) then
		NoticeModule.ShowNotice(12016)

		return
	end

	MazeModule.OnSubmitEvent(self.stageEventLinkPod.curEventId, 0, itemData.Id, 1)
end

function Element:__OpenItemDetailsView(itemData)
	self:__UnSelecAll()

	if itemData == nil then
		self.itemDetailsView:Hide()
	else
		self.itemDetailsView:SetData(self.stageEventLinkPod, itemData)
		self.itemDetailsView:Show()
	end
end

function Element:Show(_curRoomCid)
	self.itemDetailsView:Hide()
	EventDispatcher.AddEventListener(EventID.MazeRefreshEvent, self.__delegateOnMazeRefreshEvent)
	EventDispatcher.AddEventListener(EventID.OnUpdateStageEventLinkResult, self.__delegateOnUpdateStageEventLinkResult)
	self.moneyCell:RefreshItem(Constant.TopMoneyType.MazeBattleUI)
	self.gameObject:SetActive(true)

	self.curRoomCid = _curRoomCid

	self:__RefreshShopData(false)
	self:__ShowRefreshInfo()
	self:__SetRefreshBtnState()
end

function Element:__OnCloseBtnClick()
	MazeModule.OnSubmitEvent(self.stageEventLinkPod.curEventId)
	self:Hide()
end

function Element:__SetRefreshBtnState()
	self.refreshBtn:GetComponent("Button").interactable = self.maxRefreshCount - self.stageEventLinkPod.freshTime > 0
end

function Element:__OnRefreshBtnClick()
	if self.maxRefreshCount - self.stageEventLinkPod.freshTime <= 0 then
		return
	end

	MazeModule.OnRefreshEvent()
end

function Element:__OnUpdateStageEventLinkResult()
	self:__RefreshShopData(true)
	self.itemDetailsView:Hide()
end

function Element:__OnDetailsViewCloseCallback()
	self:__UnSelecAll()
end

function Element:__UnSelecAll()
	for k, v in pairs(self.itemCellList) do
		v:UnSelect()
	end
end

function Element:OnMazeRefreshEvent()
	self:__RefreshShopData(false)
	self:__ShowRefreshInfo()
	self:__SetRefreshBtnState()
end

function Element:Hide()
	EventDispatcher.RemoveEventListener(EventID.MazeRefreshEvent, self.__delegateOnMazeRefreshEvent)
	EventDispatcher.RemoveEventListener(EventID.OnUpdateStageEventLinkResult, self.__delegateOnUpdateStageEventLinkResult)
	self.gameObject:SetActive(false)
end

function Element:Dispose()
	self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnCloseBtnClick)
	self.refreshBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnRefreshBtnClick)
	self.moneyCell:Dispose()
	self.itemDetailsView:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return Element
