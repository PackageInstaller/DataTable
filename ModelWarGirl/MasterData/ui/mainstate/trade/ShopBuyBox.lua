-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\ShopBuyBox.lua

local ResColor = require("ClientData/ResColor")
local ShopCellMixin = require("UI/MainState/Trade/ShopCellMixin")
local RearHouseShopCellMixin = require("UI/RearHouse/RearHouseShopCellMixin")
local EventConst = require("EventConst")
local PanelSingleFurnitrue = require("UI/MainState/Trade/PanelSingleFurnitrue")
local PanelSuitFurniture = require("UI/MainState/Trade/PanelSuitFurniture")
local ResRandClient = require("ClientData/ResRandClient")
local ConsumeTips = require("System/ConsumeTips")
local ResItemConvert = require("ClientData/ResItemConvert")
local MAX_BUY_COUNT = 9999
local LayoutElementType = typeof(UnityEngine.UI.LayoutElement)
local ShopCellChild = Class("ShopCellChild", UIControls.Child)

MixinClass(ShopCellChild, ShopCellMixin, true)

function ShopCellChild:ctor()
	self:ctorMixin(false)
end

local RearHouseShopCellChild = Class("RearHouseShopCellChild", UIControls.Child)

MixinClass(RearHouseShopCellChild, RearHouseShopCellMixin, true)

function RearHouseShopCellChild:ctor()
	self:ctorMixin(false)
end

local strClassName = "ShopBuyBox"
local ShopBuyBox = Class(strClassName, UIControls.Window)

function ShopBuyBox:ctor()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBoxClose)

	self.btnBuy = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnBuy:addEventClick(self.onItemBuy)

	self.btnNumBuy = UIControls.Button(self, "BgPanel/NumPanel/InputNum", "Text")

	self.btnNumBuy:addEventClick(self.onBuyNumClick)

	self.btnNumAdd = UIControls.Button(self, "BgPanel/NumPanel/BtnNumAdd")

	self.btnNumAdd:addEventClick(self.onNumAdd)

	self.btnNumDel = UIControls.Button(self, "BgPanel/NumPanel/BtnNumDel")

	self.btnNumDel:addEventClick(self.onNumDel)

	self.btnNumMax = UIControls.Button(self, "BgPanel/NumPanel/BtnNumMax")

	self.btnNumMax:addEventClick(self.onNumMax)

	self.btnNumMin = UIControls.Button(self, "BgPanel/NumPanel/BtnNumMin")

	self.btnNumMin:addEventClick(self.onNumMin)

	self.txtOwn = UIControls.Label(self, "BgPanel/TextHaveTitle")
	self.txtOwnNum = UIControls.Label(self, "BgPanel/TextHaveTitle/TextHaveNum")
	self.imgMoney = UIControls.Image(self, "BgPanel/PricePanel/Icon")
	self.txtMoney = UIControls.ShortNumLabel(self, "BgPanel/PricePanel/TextNum")
	self.keyboard = UIControls.NumKeyboard(self, "BgPanel/NumPanel/KeyboardPanel")
	self.panelEmpty = UIControls.Panel(self, "BgPanel/EmptyPanel")
	self.panelContent = UIControls.Panel(self, "BgPanel/ContentPanel")
	self.labelTitle = UIControls.Label(self, "BgPanel/ContentPanel/TextTitle")
	self.labelContent = UIControls.Label(self, "BgPanel/ContentPanel/TextContent")
	self.panelAwardPreview = UIControls.Panel(self, "BgPanel/ContentPanel/AwardPanel")
	self.layoutAwardPreview = self.panelAwardPreview:getComObj().transform:GetComponent(LayoutElementType)
	self._buyCount = 1
	self._slot4NumInput = Slot(self.onNumInput, self)
	self.timeOver = false
	self._slot4NewDay = Slot(self.onNewDay, self)
	self.panelNum = UIControls.Panel(self, "BgPanel/BackpackNumPanel")
	self.textHasNum = UIControls.Label(self, "BgPanel/BackpackNumPanel/NumText")
	self.checkNeedConvertObject = UIControls.checkControlFunc(self, "BgPanel/IconChange")

	if self.checkNeedConvertObject then
		self.panelIconChange = UIControls.Panel(self, "BgPanel/IconChange")
		self.textChange = UIControls.Label(self, "BgPanel/ContentPanel/TextChange")
	end
end

function ShopBuyBox:onOpen()
	ShopBuyBox.super.onOpen(self)
	EventCenter.addEventListener(EventConst.NEW_DAY, self._slot4NewDay)
end

function ShopBuyBox:onNewDay()
	if self.timeOver ~= nil then
		self.timeOver = true
	end
end

function ShopBuyBox:_initShopCell(cellClass, cellPrefab)
	if cellClass then
		self.cellShop = cellClass(self, "BgPanel/ItemPanel", cellPrefab, 0, 0, true)
	elseif self._curItem:isRearHouseType() == true then
		self.cellShop = RearHouseShopCellChild(self, "BgPanel/ItemPanel", "System/Common/Grid/GridBackyardStoreItem", 0, 0, true)
	else
		local cellPrefab = "System/Common/Grid/GridStoreItem"

		if self.orderUI and self.orderUI.subCellPrefab and self.orderUI.subCellPrefab == "System/Common/Grid/GridPetStoreItem" then
			cellPrefab = "System/Common/Grid/GridPetStoreItem"
		end

		self.cellShop = ShopCellChild(self, "BgPanel/ItemPanel", cellPrefab, 0, 0, true)
	end
end

function ShopBuyBox:showShopItem(item, orderUI, buyCB, cellClass, cellPrefab)
	self.buyCB = buyCB
	self._curItem = item
	self.orderUI = orderUI

	self:_initShopCell(cellClass, cellPrefab)
	self.cellShop:setData(item)
	self:_updateItem()
	self:_updateBuyNum(1)
	self:checkFurniture()
	self:refreshConvertObject()

	if self._curItem then
		self.windowKeyInfo = self._curItem.shopID
	end

	if orderUI and orderUI.mWindow then
		self:setOrder(orderUI.mWindow:getOrder() + 5)
	end

	self:setVisible(true)
end

function ShopBuyBox:_updateItem()
	if self._curItem == nil then
		return
	end

	local data = self._curItem.data
	local contentDesc = self._curItem.desc
	local descTitle = Lang.get(1681)
	local contentIsEmpty = contentDesc == nil

	self.panelEmpty:setVisible(contentIsEmpty)
	self.panelContent:setVisible(not contentIsEmpty)

	if contentDesc ~= nil then
		self.labelContent:setText(contentDesc)
	end

	self.labelTitle:setText(descTitle)

	local moneyInfo = data.use[1]
	local moneyPath = ClientUtils.getMoneyIcon(moneyInfo.ID)

	if moneyPath then
		self.imgMoney:setImage(moneyPath[1], moneyPath[2])
	end

	for index, grid in ipairs(self.previewGrids or {}) do
		grid:destroy()
	end

	self.previewGrids = {}

	local item = self._curItem.object

	if item.subType == Const.ITEM_STYPE_RAND_SELECT_GIFT_PKG and item.resData.extend_args3 then
		self.labelTitle:setText(Lang.get(30550))
		self.panelAwardPreview:setVisible(true)

		local chooseType = item.resData.extend_args1

		for i, random_id in ipairs(item.resData.extend_args3) do
			if ClientUtils.IsRandomValid(random_id) then
				local itemId = ResRandClient[random_id].show_ids[1]
				local itemNum = ResRandClient[random_id].show_nums[1]

				self:createShowPreiviewGrid(chooseType, itemId, itemNum)
			end
		end
	elseif item.subType == Const.ITEM_STYPE_RAND_LIMIT_SELECT then
		self.labelTitle:setText(Lang.get(30550))
		self.panelAwardPreview:setVisible(true)

		for i, artifactId in ipairs(item.resData.extend_args3) do
			local limitNum = item.resData.extend_args4[i]
			local num = 1

			if item.resData.extend_args5 then
				num = item.resData.extend_args5[i] or 1
			end

			local grid = self:createShowPreiviewGrid(nil, artifactId, num)

			if grid.object.itemType == Const.ITEM_TYPE_ARTIFACT then
				if limitNum and limitNum > 0 and CurAvatar:getIsHaveArtifactById(artifactId) then
					grid:setGot(true)
				end
			elseif grid.object.itemType == Const.ITEM_TYPE_SKIN then
				grid:refreshGet()
			end
		end
	elseif item.resData.drop_rand_id then
		self.labelTitle:setText(Lang.get(30550))
		self.panelAwardPreview:setVisible(true)
		ClientUtils.CreateBonusGrid(self, self.previewGrids, "BgPanel/ContentPanel/AwardPanel/GridAwardPanel", item.resData.drop_rand_id)
	else
		self.panelAwardPreview:setVisible(false)
	end

	self.layoutAwardPreview.preferredHeight = (math.floor((#self.previewGrids - 1) / 6) + 1) * 108

	local hasNum = self._curItem:getItemHasNum()

	if hasNum then
		self.panelNum:setVisible(true)
		self.textHasNum:setText(hasNum)

		if self.cellShop and self.cellShop.panelNum then
			self.cellShop.panelNum:setVisible(false)
		end
	else
		self.panelNum:setVisible(false)
	end
end

function ShopBuyBox:refreshConvertObject()
	if self._curItem == nil then
		return
	end

	local item = self._curItem.object

	if self.checkNeedConvertObject then
		local checkConvertObject = not self._curItem:isSoldOut() and BaseObject.checkConvertObject(item)

		self.panelIconChange:setVisible(checkConvertObject)
		self.textChange:setVisible(checkConvertObject)

		if checkConvertObject then
			local resItemConvert = ResItemConvert[item.id]

			self.textChange:setText(resItemConvert.des)
			self.txtOwn:setVisible(false)

			if self.cellShop and self.cellShop.txtHaveNum then
				self.cellShop.txtHaveNum:setVisible(false)
			end
		end
	end
end

function ShopBuyBox:createShowPreiviewGrid(chooseType, itemId, itemNum)
	if chooseType == Const.ITEM_CHOOSE_GIFT_EQUIP then
		local suitCell = UIConst.BtnChooseEquipSet(self, "BgPanel/ContentPanel/AwardPanel/GridAwardPanel", "System/Bag/BtnChooseEquipSet", 0, 0, true)

		suitCell:setSuitInfo(itemId)
		table.insert(self.previewGrids, suitCell)

		return suitCell
	else
		local item = BaseObject.GetObject(itemId, itemNum)
		local itemGrid = UIControls.getGridChild(item, self, "BgPanel/ContentPanel/AwardPanel/GridAwardPanel", true)

		itemGrid:setObj(item)
		itemGrid:setVisible(true)
		table.insert(self.previewGrids, itemGrid)

		return itemGrid
	end
end

function ShopBuyBox:_updateBuyNum(tgtCount)
	if self._curItem == nil then
		return
	end

	local moneyInfo = self._curItem.data.use[1]
	local curV = moneyInfo.discount
	local haveV = ClientUtils.getMoney(moneyInfo.ID)

	self._minCount = 0

	if ClientUtils.CheckExchange(moneyInfo.ID) then
		self._maxCount = MAX_BUY_COUNT
	else
		self._maxCount = math.max(1, math.min(MAX_BUY_COUNT, math.floor(haveV / curV)))
	end

	if self._curItem.canBuyCount ~= nil then
		self._maxCount = math.min(self._curItem.canBuyCount, self._maxCount)
		self._minCount = math.min(self._curItem.canBuyCount, self._minCount)

		if tgtCount == nil then
			tgtCount = self._minCount
		end
	elseif tgtCount == nil then
		tgtCount = self._minCount
	end

	if tgtCount > self._maxCount then
		tgtCount = self._maxCount

		MsgManager.clientNotice(147)
	elseif tgtCount < self._minCount then
		tgtCount = self._minCount

		MsgManager.notice(string.format(Lang.get(30549), self._minCount))
	end

	self.btnNumBuy:setText(tgtCount)

	self._buyCount = tgtCount
	self._totalMoney = curV * self._buyCount

	self.txtMoney:setNum(self._totalMoney)

	if haveV >= self._totalMoney then
		self.txtMoney:setFontColor(ResColor.BLACK)
	else
		self.txtMoney:setFontColor(ResColor.RED)
	end
end

function ShopBuyBox:_doBuy()
	local isSuccess = CurAvatar:checkItemsFull({
		self._curItem.object
	}, Slot(self.itemBuyCb, self), {
		self._buyCount
	})

	if not isSuccess then
		self:setVisible(false)
	end
end

function ShopBuyBox:onBoxClose(sender)
	self:setVisible(false)
	EventCenter.removeEventListener(EventConst.NEW_DAY, self._slot4NewDay)
end

function ShopBuyBox:onBuyNumClick()
	self.keyboard:show(self._slot4NumInput, self._buyCount, MAX_BUY_COUNT, 0)
end

function ShopBuyBox:onNumAdd(sender)
	self:_updateBuyNum(self._buyCount + 1)
end

function ShopBuyBox:onNumDel(sender)
	self:_updateBuyNum(self._buyCount - 1)
end

function ShopBuyBox:onNumMax(sender)
	self:_updateBuyNum(self._buyCount + 10)
end

function ShopBuyBox:onNumMin(sender)
	self:_updateBuyNum(self._buyCount - 10)
end

function ShopBuyBox:onNumInput(value)
	self:_updateBuyNum(value)
end

function ShopBuyBox:itemBuyCb()
	if self.buyCB then
		self.buyCB(self._curItem.id, self._buyCount)
	else
		RPC.shopExchange(self._curItem.shopID, self._curItem.id, self._buyCount, 0)
	end

	self:setVisible(false)
	EventCenter.removeEventListener(EventConst.NEW_DAY, self._slot4NewDay)
end

function ShopBuyBox:onItemBuy(sender)
	if self._buyCount <= 0 then
		MsgManager.clientNotice(145)

		return
	end

	if self.timeOver == true then
		MsgManager.notice(Lang.get(30540))
		self:setVisible(false)

		self.timeOver = false

		EventCenter.removeEventListener(EventConst.NEW_DAY, self._slot4NewDay)

		return
	end

	local moneyInfo = self._curItem.data.use[1]

	if moneyInfo.ID == Const.MONEY_ID_DIAMOND then
		if self.goRechargeCallBack then
			ClientUtils.checkMoneyChange(moneyInfo.ID, self._totalMoney, self._showBuyTips, self, true, self.goRechargeCallBack)
		else
			ClientUtils.checkMoneyChange(moneyInfo.ID, self._totalMoney, self._showBuyTips, self, true)
		end
	elseif self.goRechargeCallBack then
		ClientUtils.checkMoneyChange(moneyInfo.ID, self._totalMoney, self._doBuy, self, true, self.goRechargeCallBack)
	else
		ClientUtils.checkMoneyChange(moneyInfo.ID, self._totalMoney, self._doBuy, self, true)
	end
end

function ShopBuyBox:setGoRechargeCallBack(cb)
	self.goRechargeCallBack = cb
end

function ShopBuyBox:_showBuyTips(...)
	ConsumeTips.showTipsDiamond(self._totalMoney, Const.CONSUME_DIAMOND_SHOP_ITEM, self._buyCount, Slot(self._doBuy, self))
end

function ShopBuyBox:showOwnNum(...)
	self.txtOwn:setVisible(true)

	local num = CurAvatar:getItemNumById(self._curItem.object.id)

	self.txtOwnNum:setText(num)
end

function ShopBuyBox:checkFurniture(...)
	if self._curItem:isRearHouseType() == true then
		self:showOwnNum()

		local panel

		if self._curItem:isSingleFurniture() then
			panel = PanelSingleFurnitrue(self, "BgPanel/ContentPanel", "System/Store/FurnitureSinglePanel", 0, 0, true)
		elseif self._curItem:isSuitFurniture() then
			panel = PanelSuitFurniture(self, "BgPanel/ContentPanel", "System/Store/FurnitureSuitPanel", 0, 0, true)
		end

		if panel then
			panel:setData(self._curItem.object.id)
		end
	end
end

return ShopBuyBox
