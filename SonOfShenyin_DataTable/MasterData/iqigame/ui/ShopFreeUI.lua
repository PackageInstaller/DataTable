-- chunkname: @IQIGame\\UI\\ShopFreeUI.lua

local ShopFreeUI = {}

ShopFreeUI = Base:Extend("ShopFreeUI", "IQIGame.Onigao.UI.ShopFreeUI", ShopFreeUI)

local SoulStoneShopCell = require("IQIGame.UI.Shop.SoulStoneShopCell")
local GiftBagShopCell = require("IQIGame.UI.Shop.GiftBagShopCell")
local SecondaryTapItem = require("IQIGame.UI.Shop.SecondaryTapItem")
local FirstTapItem = require("IQIGame.UI.Shop.FirstTapItem")
local rolePerformanceShopCell = require("IQIGame.UI.Shop.RolePerformanceShopCell")
local rechargeGiftItem = require("IQIGame.UI.Shop.RechargeGiftItemCell")

function ShopFreeUI:OnInit()
	self:InitComponent()
	self:InitDelegate()
	self:InitAllTags()
	self:InitMembers()
	self:InitScrollData()
end

function ShopFreeUI:InitAllTags()
	self.firstTapItemList = {}
	self.secondaryTapItemList = {}
end

function ShopFreeUI:InitMembers()
	self.soulStoneCellList = {}
	self.giftCellList = {}
	self.rolePerformanceCellList = {}
	self.rechargeGiftCellList = {}
end

function ShopFreeUI:InitScrollData()
	self.CellScroll = {}
	self.CellScroll = {
		[Constant.ShopScrollType.GiftScroll] = {
			Parent = self.RechargeGiftScrollRoot,
			Scroll = self.RechargeGiftScroll
		},
		[Constant.ShopScrollType.Resource] = {
			Parent = self.GiftBagScrollRoot,
			Scroll = self.GiftBagScroll
		},
		[Constant.ShopScrollType.Skin] = {
			Parent = self.rolePerformanceScrollRoot,
			Scroll = self.rolePerformanceScroll
		},
		[Constant.ShopScrollType.Recharge] = {
			Parent = self.SoulStoneScrollRoot,
			Scroll = self.SoulStoneScroll
		}
	}
end

function ShopFreeUI:InitComponent()
	local soulStoneContentScroll = self.SoulStoneScroll:GetComponent("ScrollAreaList")

	function soulStoneContentScroll.onRenderCell(gridCell)
		self:OnSoulStoneRenderGridCell(gridCell)
	end

	local giftBagContentScroll = self.GiftBagScroll:GetComponent("ScrollAreaList")

	function giftBagContentScroll.onRenderCell(gridCell)
		self:OnGiftBagRenderGridCell(gridCell)
	end

	local RolePerformanceShopCell = self.rolePerformanceScroll:GetComponent("ScrollAreaList")

	function RolePerformanceShopCell.onRenderCell(gridCell)
		self:OnRolePerformanceGridCell(gridCell)
	end

	local rechargeGiftScroll = self.RechargeGiftScroll:GetComponent("ScrollAreaList")

	function rechargeGiftScroll.onRenderCell(gridCell)
		self:OnRechargeGiftRenderGridCell(gridCell)
	end

	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
	self.moneyCell = CurrencyCell.New(self.topCurrencyRoot)
	self.commonNpcTalk = CommonNpcTalkView.New(self.CommonTalk)
end

function ShopFreeUI:InitDelegate()
	function self.OnNotifyChangeShopItemsSucceedDelegate()
		self:OnNotifyChangeShopItems()
	end

	function self.firstTagClickDelegate(firstTapItem)
		self:OnFirstTagClick(firstTapItem)
	end

	function self.secondaryTagClickDelegate(secondaryTapItem)
		self:OnSecondaryTagClick(secondaryTapItem)
	end

	function self.recommendSecondaryTagClickDelegate(secondaryTapItem)
		self:OnRecommendSecondaryTagClick(secondaryTapItem)
	end
end

function ShopFreeUI:OnAddListeners()
	EventDispatcher.AddEventListener(EventID.NotifyChangeShopItems, self.OnNotifyChangeShopItemsSucceedDelegate)
	EventDispatcher.AddEventListener(EventID.ShopUIFirstTagClickEvent, self.firstTagClickDelegate)
	EventDispatcher.AddEventListener(EventID.ShopUISecondaryTagClickEvent, self.secondaryTagClickDelegate)
	EventDispatcher.AddEventListener(EventID.ShopUIRecommendSecondaryTagClickEvent, self.recommendSecondaryTagClickDelegate)
end

function ShopFreeUI:OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.NotifyChangeShopItems, self.OnNotifyChangeShopItemsSucceedDelegate)
	EventDispatcher.RemoveEventListener(EventID.ShopUIFirstTagClickEvent, self.firstTagClickDelegate)
	EventDispatcher.RemoveEventListener(EventID.ShopUISecondaryTagClickEvent, self.secondaryTagClickDelegate)
	EventDispatcher.RemoveEventListener(EventID.ShopUIRecommendSecondaryTagClickEvent, self.recommendSecondaryTagClickDelegate)
end

function ShopFreeUI:GetPreloadAssetPaths()
	return nil
end

function ShopFreeUI:GetOpenPreloadAssetPaths(userData)
	return
end

function ShopFreeUI:IsManualShowOnOpen(userData)
	return false
end

function ShopFreeUI:GetBGM(userData)
	return 11000071
end

function ShopFreeUI:OnOpen(userData)
	self.shopEnterType = userData.enterType and userData.enterType or Constant.ShopEnterType.Normal

	ShopModule.SetCurShopDataData(self.curChooseTypeId)
	self:RefreshFirstTags()
	ShopModule.RefreshShop()
	LuaUtility.SetGameObjectShow(self.EmptyParent, false)
	self:RefreshRedDot()

	if self.moneyCell then
		self.moneyCell:RefreshItem(Constant.TopMoneyType.ShopUIRecommend)
	else
		self.moneyCell = CurrencyCell.New(self.topCurrencyRoot)

		self.moneyCell:RefreshItem(Constant.TopMoneyType.ShopUIRecommend)
	end

	self:JumpShop(userData)
end

function ShopFreeUI:OnClose(userData)
	if self.currentFirstTap then
		self.currentFirstTap:SetSelect(false)

		self.currentFirstTap = nil
	end

	if self.currentSecondaryTag then
		self.currentSecondaryTag:SetSelect(false)

		self.currentSecondaryTag = nil
	end

	self.commonNpcTalk:Hide()
end

function ShopFreeUI:OnPause()
	return
end

function ShopFreeUI:OnResume()
	return
end

function ShopFreeUI:OnCover()
	return
end

function ShopFreeUI:OnReveal()
	return
end

function ShopFreeUI:OnRefocus(userData)
	return
end

function ShopFreeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.commonNpcTalk:Update(elapseSeconds, realElapseSeconds)
end

function ShopFreeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ShopFreeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ShopFreeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ShopFreeUI:OnDestroy()
	for _, v in pairs(self.soulStoneCellList) do
		v:Dispose()
	end

	for _, v in pairs(self.giftCellList) do
		v:Dispose()
	end

	for _, v in pairs(self.rolePerformanceCellList) do
		v:Dispose()
	end

	for _, v in pairs(self.rechargeGiftCellList) do
		v:Dispose()
	end

	for _, v in pairs(self.firstTapItemList) do
		v.tapItem:Dispose()
	end

	self.firstTapItemList = {}

	for _, v in pairs(self.secondaryTapItemList) do
		v:Dispose()
	end

	self.moneyCell:Dispose()
	self.commonReturnBtn:Dispose()

	self.CellScroll = {}

	self.commonNpcTalk:Dispose()
	AssetUtil.UnloadAsset(self)
end

function ShopFreeUI:OnSoulStoneRenderGridCell(gridCellData)
	local data = ShopModule.shopDataSortList[self.curChooseTypeId][gridCellData.index + 1]
	local insID = gridCellData.gameObject:GetInstanceID()
	local cell = self.soulStoneCellList[insID]

	if cell == nil then
		cell = SoulStoneShopCell.New(gridCellData.gameObject, self)
		self.soulStoneCellList[insID] = cell
	end

	data.insID = insID

	cell:Refresh(data)

	gridCellData.gameObject.name = data.cid
end

function ShopFreeUI:OnGiftBagRenderGridCell(gridCellData)
	local data = ShopModule.shopDataSortList[self.curChooseTypeId][gridCellData.index + 1]
	local insID = gridCellData.gameObject:GetInstanceID()
	local cell = self.giftCellList[insID]

	if cell == nil then
		cell = GiftBagShopCell.New(gridCellData.gameObject, self)
		self.giftCellList[insID] = cell
	end

	data.insID = insID

	cell:Refresh(data)

	gridCellData.gameObject.name = data.cid
end

function ShopFreeUI:OnRolePerformanceGridCell(gridCellData)
	local data = ShopModule.shopDataSortList[self.curChooseTypeId][gridCellData.index + 1]
	local insID = gridCellData.gameObject:GetInstanceID()
	local cell = self.rolePerformanceCellList[insID]

	if cell == nil then
		cell = rolePerformanceShopCell.New(gridCellData.gameObject, self)
		self.rolePerformanceCellList[insID] = cell
	end

	data.insID = insID

	cell:Refresh(data, ShopModule.shopDataSortList[self.curChooseTypeId])

	gridCellData.gameObject.name = data.cid
end

function ShopFreeUI:OnRechargeGiftRenderGridCell(gridCellData)
	local data = ShopModule.shopDataSortList[self.curChooseTypeId][gridCellData.index + 1]
	local insID = gridCellData.gameObject:GetInstanceID()
	local cell = self.rechargeGiftCellList[insID]

	if cell == nil then
		cell = rechargeGiftItem.New(gridCellData.gameObject, self)
		self.rechargeGiftCellList[insID] = cell
	end

	data.insID = insID

	cell:Refresh(data)

	gridCellData.gameObject.name = data.cid
end

function ShopFreeUI:RefreshFirstTags()
	local len = #self.firstTapItemList

	for i = 1, len do
		self.firstTapItemList[i].tapItem:Show(false)
	end

	local normalShow = self.shopEnterType == Constant.ShopEnterType.Normal

	LuaUtility.SetGameObjectShow(self.recommendTagRoot, normalShow)
	LuaUtility.SetGameObjectShow(self.longTimeTagRoot, normalShow)

	local firstTapData = ShopModule.GetShopFirstTapData(self.shopEnterType, Constant.ShopOpenType.FreeShop)

	for i = 1, #firstTapData do
		if i > #self.firstTapItemList then
			local firstTapObject = UnityEngine.Object.Instantiate(self.firstShopTag)

			firstTapObject.transform:SetParent(self.LeftTabContent.transform, false)

			local firstTapItem = {
				tapItem = FirstTapItem.New(firstTapObject.gameObject)
			}

			firstTapItem.tapItem:Show(false)
			table.insert(self.firstTapItemList, firstTapItem)
		end

		local tapItem = self.firstTapItemList[i].tapItem

		tapItem:Refresh(firstTapData[i])
		tapItem:Show(true)
		tapItem:SetGameObjectName(i)
		tapItem:SetIndex(i + 2)

		self.firstTapItemList[i].type = firstTapData[i].Type
	end
end

function ShopFreeUI:RefreshSecondaryTags(shopType)
	for i = 1, #self.secondaryTapItemList do
		self.secondaryTapItemList[i]:Show(false)
	end

	if not shopType then
		self:CheckSecondaryTagWithShopShowType(nil)

		return
	end

	self:CheckSecondaryTagWithShopShowType(Constant.ShopShowType.Normal)

	local SecondaryTagData = ShopModule.GetSecondaryTagDataWithType(shopType)

	for i = 1, #SecondaryTagData do
		if i > #self.secondaryTapItemList then
			local secondaryTapObject = UnityEngine.Object.Instantiate(self.secondaryTag)

			secondaryTapObject.transform:SetParent(self.secondaryTapContent.transform, false)

			local secondaryTapItem = SecondaryTapItem.New(secondaryTapObject.gameObject)

			table.insert(self.secondaryTapItemList, secondaryTapItem)
		end

		self.secondaryTapItemList[i]:Refresh(SecondaryTagData[i])
		self.secondaryTapItemList[i]:Show(true)

		if i == 1 then
			self.secondaryTapItemList[i]:OnButtonClick()
		end
	end
end

function ShopFreeUI:OnFirstTagClick(firstTapItem)
	if self.currentFirstTap then
		if self.currentFirstTap == firstTapItem then
			return
		end

		self.currentFirstTap:SetSelect(false)
	end

	self.currentFirstTap = firstTapItem

	if self.currentSecondaryTag then
		self.currentSecondaryTag:SetSelect(false)

		self.currentSecondaryTag = nil
	end

	self.currentScroll = self.CellScroll[firstTapItem.Data.ScrollType].Scroll

	self.moneyCell:RefreshItem(firstTapItem.Data.MoneyType)

	self.curChooseType = firstTapItem.Data.Type

	local secondaryData = ShopModule.GetSecondaryTagDataWithType(self.curChooseType)

	if secondaryData then
		self:RefreshSecondaryTags(self.curChooseType)

		return
	else
		self.curChooseTypeId = ShopModule.GetShopTypeIDWithShopType(self.curChooseType)

		self:RefreshSecondaryTags(nil)
		self.commonNpcTalk:Refresh(firstTapItem.Data.NpcActionGroupid, Constant.NPCTriggerType.OpenUI, getHourText(PlayerModule.GetServerTime()))
	end

	if not self.curChooseTypeId then
		logError("商城类型数据不存在，商城 type == " .. self.curChooseType)

		return
	end

	self:ScrollChange(firstTapItem.Data)
	self:RefreshShopForType()
end

function ShopFreeUI:OnSecondaryTagClick(secondaryTapItem)
	if self.currentSecondaryTag then
		if self.currentSecondaryTag == secondaryTapItem then
			return
		end

		self.currentSecondaryTag:SetSelect(false)
	end

	self.commonNpcTalk:Refresh(CfgShopTable[secondaryTapItem.Data].NpcActionGroupid, Constant.NPCTriggerType.OpenUI, getHourText(PlayerModule.GetServerTime()))

	self.currentScroll = self.CellScroll[CfgShopTable[secondaryTapItem.Data].ScrollType].Scroll

	secondaryTapItem:SetSelect(true)

	self.currentSecondaryTag = secondaryTapItem
	self.curChooseTypeId = secondaryTapItem.Data

	ShopModule.SetCurShopDataData(secondaryTapItem.Data)
	self:ScrollChange(CfgShopTable[secondaryTapItem.Data])
	self:RefreshShopForType()
end

function ShopFreeUI:OnRecommendSecondaryTagClick(secondaryTapItem)
	if self.currentSecondaryTag then
		self.currentSecondaryTag:SetSelect(false)
	end

	secondaryTapItem:SetSelect(true)

	self.currentSecondaryTag = secondaryTapItem
end

function ShopFreeUI:RefreshShopForType(isDynamic)
	local contentScroll = self.currentScroll:GetComponent("ScrollAreaList")
	local cfgData = ShopModule.GetSortForTypeDataList(self.curChooseTypeId)

	if isDynamic then
		contentScroll:RenderCellsDynamic(#cfgData)
	else
		contentScroll:Refresh(#cfgData)
	end

	self.moneyCell:RefreshItem(ShopModule.GetShopDataWithShopID(self.curChooseTypeId).shopCfgData.MoneyType)
	LuaUtility.SetGameObjectShow(self.EmptyParent, #cfgData == 0)
end

function ShopFreeUI:ShowRecommondScroll()
	self:HideAllScroll()
	LuaUtility.SetGameObjectShow(self.recommendRoot, true)
end

function ShopFreeUI:ShowLongTermScroll()
	self:HideAllScroll()
	LuaUtility.SetGameObjectShow(self.longTermRoot, true)
end

function ShopFreeUI:HideAllScroll()
	LuaUtility.SetGameObjectShow(self.SoulStoneScrollRoot, false)
	LuaUtility.SetGameObjectShow(self.GiftBagScrollRoot, false)
	LuaUtility.SetGameObjectShow(self.RechargeGiftScrollRoot, false)
	LuaUtility.SetGameObjectShow(self.rolePerformanceScrollRoot, false)
	LuaUtility.SetGameObjectShow(self.recommendRoot, false)
	LuaUtility.SetGameObjectShow(self.longTermRoot, false)
end

function ShopFreeUI:ScrollChange(shopCfg)
	self:HideAllScroll()

	for k, v in pairs(self.CellScroll) do
		if k == shopCfg.ScrollType then
			LuaUtility.SetGameObjectShow(v.Parent, true)
		else
			LuaUtility.SetGameObjectShow(v.Parent, false)
		end
	end
end

function ShopFreeUI:CheckSecondaryTagWithShopShowType(showType)
	LuaUtility.SetGameObjectShow(self.secondaryTagScrollRoot, showType == Constant.ShopShowType.Normal)
end

function ShopFreeUI:OnNotifyChangeShopItems()
	self:RefreshShopForType(true)
	self:RefreshRedDot()
	self.commonNpcTalk:Refresh(Constant.NPCTalkGroupType.FreeShop, Constant.NPCTriggerType.BuyOnShop, 0)
end

function ShopFreeUI:JumpShop(args)
	local needClickTargetTag, targetFirstTapItem, secondTabIndex = self:CheckInitializationTap(args)

	if needClickTargetTag then
		targetFirstTapItem:OnButtonClick()

		if secondTabIndex then
			for k, v in pairs(self.secondaryTapItemList) do
				if CfgShopTable[v.Data].Branch == secondTabIndex then
					v:OnButtonClick()

					break
				end
			end
		end

		self.timer = FrameTimer.New(function()
			local pos = 1 / targetFirstTapItem.Index

			pos = math.max(0, pos)
			pos = math.min(1, pos)
			self.tabScrollView:GetComponent("ScrollRect").verticalNormalizedPosition = pos

			if self.timer then
				self.timer:Stop()

				self.timer = nil
			end
		end, 2, 1):Start()
	else
		local item = self.firstTapItemList[1]

		if item then
			item.tapItem:OnButtonClick()
		end
	end
end

function ShopFreeUI:CheckInitializationTap(userData)
	if userData == nil then
		return false, nil
	end

	local shopType, secondTabIndex

	if type(userData) == "number" or type(userData) == "string" then
		shopType = tonumber(userData)
	elseif type(userData) == "table" then
		shopType = tonumber(userData[1])

		if userData[2] ~= nil then
			secondTabIndex = tonumber(userData[2])
		end
	end

	if shopType ~= nil then
		local firstTapItem = self:GetFirstTabItemBy(shopType)

		if firstTapItem ~= nil then
			return true, firstTapItem, secondTabIndex
		end
	end

	return false, nil
end

function ShopFreeUI:GetFirstTabItemBy(shopType)
	if self.firstTapItemList ~= nil then
		for _, firstTapItem in pairs(self.firstTapItemList) do
			if firstTapItem.tapItem ~= nil and firstTapItem.tapItem.Data.Type == shopType then
				return firstTapItem.tapItem
			end
		end
	end

	return nil
end

function ShopFreeUI:RefreshRedDot()
	for k, v in pairs(self.firstTapItemList) do
		local commodityDatas = ShopModule.GetAllItemsWithShopType(v.type)

		v.tapItem:SetRedDotState(ShopModule.GetHasFreeCommodity(commodityDatas))
	end
end

return ShopFreeUI
