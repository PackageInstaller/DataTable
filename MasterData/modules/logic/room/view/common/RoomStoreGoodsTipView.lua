-- chunkname: @modules/logic/room/view/common/RoomStoreGoodsTipView.lua

module("modules.logic.room.view.common.RoomStoreGoodsTipView", package.seeall)

local RoomStoreGoodsTipView = class("RoomStoreGoodsTipView", BaseView)

function RoomStoreGoodsTipView:onInitView()
	self._simageblur = gohelper.findChildSingleImage(self.viewGO, "#simage_blur")
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg2")
	self._btntheme = gohelper.findChildButtonWithAudio(self.viewGO, "left/#btn_theme")
	self._txttheme = gohelper.findChildText(self.viewGO, "left/#btn_theme/txt")
	self._gocobrand = gohelper.findChild(self.viewGO, "left/#go_cobrand")
	self._gobuyContent = gohelper.findChild(self.viewGO, "right/#go_buyContent")
	self._goblockInfoItem = gohelper.findChild(self.viewGO, "right/#go_buyContent/#go_blockInfoItem")
	self._gochange = gohelper.findChild(self.viewGO, "right/#go_buyContent/#go_change")
	self._txtchange = gohelper.findChildText(self.viewGO, "right/#go_buyContent/#go_change/#txt_desc")
	self._imagechangeicon = gohelper.findChildImage(self.viewGO, "right/#go_buyContent/#go_change/#txt_desc/simage_icon")
	self._gopaynoraml = gohelper.findChild(self.viewGO, "right/#go_buyContent/#go_change/go_normalbg")
	self._gopayselect = gohelper.findChild(self.viewGO, "right/#go_buyContent/#go_change/go_selectbg")
	self._btnticket = gohelper.findChildButtonWithAudio(self.viewGO, "right/#go_buyContent/#go_change/btn_pay")
	self._gopay = gohelper.findChild(self.viewGO, "right/#go_buyContent/#go_pay")
	self._gopayitem = gohelper.findChild(self.viewGO, "right/#go_buyContent/#go_pay/#go_payitem")
	self._btninsight = gohelper.findChildButtonWithAudio(self.viewGO, "right/#go_buyContent/buy/#btn_insight")
	self._txtcostnum = gohelper.findChildText(self.viewGO, "right/#go_buyContent/buy/#txt_costnum")
	self._imagecosticon = gohelper.findChildImage(self.viewGO, "right/#go_buyContent/buy/#txt_costnum/#simage_costicon")
	self._gosource = gohelper.findChild(self.viewGO, "right/#go_source")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomStoreGoodsTipView:addEvents()
	self._btntheme:AddClickListener(self._btnthemeOnClick, self)
	self._btninsight:AddClickListener(self._btninsightOnClick, self)
	self._btnticket:AddClickListener(self._btnClickUseTicket, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function RoomStoreGoodsTipView:removeEvents()
	self._btntheme:RemoveClickListener()
	self._btninsight:RemoveClickListener()
	self._btnticket:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function RoomStoreGoodsTipView:_btnthemeOnClick()
	local mo = RoomStoreItemListModel.instance:getRoomStoreItemMOHasTheme()

	if mo then
		ViewMgr.instance:openView(ViewName.RoomThemeTipView, {
			type = mo.materialType,
			id = mo.id
		})
	end
end

function RoomStoreGoodsTipView:_btninsightOnClick()
	StoreController.instance:dispatchEvent(StoreEvent.SaveVerticalScrollPixel)

	local mo = RoomStoreItemListModel.instance:getRoomStoreItemMOHasTheme()
	local showUseTicket = mo:checkShowTicket()
	local costNum = RoomStoreItemListModel.instance:getTotalPriceByCostId()
	local selectCost = self:_getSelectCostId()
	local cost1, cost2 = self.viewParam.storeGoodsMO:getAllCostInfo()
	local costInfos = {
		cost1,
		cost2
	}
	local curCostInfo = costInfos[selectCost][1]
	local costType = curCostInfo[1]
	local costId = curCostInfo[2]
	local quantity = ItemModel.instance:getItemQuantity(curCostInfo[1], curCostInfo[2])

	if showUseTicket and not RoomStoreItemListModel.instance:getIsSelectCurrency() then
		local costId = mo:getTicketId()
		local costName = ItemConfig.instance:getItemCo(costId).name
		local name

		if mo.materialType == MaterialEnum.MaterialType.BlockPackage then
			name = RoomConfig.instance:getBlockPackageConfig(mo.id).name
		elseif mo.materialType == MaterialEnum.MaterialType.Building then
			name = RoomConfig.instance:getBuildingConfig(mo.id).name
		end

		GameFacade.showMessageBox(MessageBoxIdDefine.RoomTicketCost, MsgBoxEnum.BoxType.Yes_No, self._useTicket, nil, nil, self, nil, nil, costName, name)
	elseif costType == MaterialEnum.MaterialType.Currency and costId == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
		if CurrencyController.instance:checkFreeDiamondEnough(costNum, CurrencyEnum.PayDiamondExchangeSource.Store, nil, self._buyGoods, self) then
			self:_buyGoods()
		end
	elseif quantity and costNum <= quantity then
		self:_buyGoods()
	else
		local config, icon = ItemModel.instance:getItemConfigAndIcon(costType, costId)

		if config then
			GameFacade.showToast(ToastEnum.ClickRoomStoreInsight, config.name)
		end
	end
end

function RoomStoreGoodsTipView:_btnClickUseTicket()
	local mo = RoomStoreItemListModel.instance:getRoomStoreItemMOHasTheme()

	if RoomStoreItemListModel.instance:getIsSelectCurrency() then
		RoomStoreItemListModel.instance:setIsSelectCurrency(false)
	end

	RoomStoreItemListModel.instance:onModelUpdate()
	self:_selectTicketBg(true)
	self:_refreshUI()
end

function RoomStoreGoodsTipView:_useTicket()
	local mo = RoomStoreItemListModel.instance:getRoomStoreItemMOHasTheme()

	if not mo then
		return
	end

	local data = {}
	local o = {}

	o.materialId = mo:getTicketId()
	o.quantity = 1

	table.insert(data, o)

	local goodsMo = mo:getStoreGoodsMO()

	ItemRpc.instance:sendUseItemRequest(data, goodsMo.goodsId)
	self:closeThis()
end

function RoomStoreGoodsTipView:_buyGoods()
	local stroeItemMO = RoomStoreItemListModel.instance:getRoomStoreItemMOHasTheme()
	local storeList = RoomStoreItemListModel.instance:getList()

	if stroeItemMO and #storeList > 1 then
		RoomStoreOrderModel.instance:addByStoreItemMOList(storeList, self.viewParam.storeGoodsMO.goodsId, stroeItemMO.themeId)
	end

	local selectCost = self:_getSelectCostId()
	local costNum = RoomStoreItemListModel.instance:getTotalPriceByCostId()

	StoreController.instance:recordRoomStoreCurrentCanBuyGoods(self.viewParam.storeGoodsMO.goodsId, selectCost, costNum)
	StoreController.instance:buyGoods(self.viewParam.storeGoodsMO, 1, self._onBuyCallback, self, selectCost)
end

function RoomStoreGoodsTipView:_btncloseOnClick()
	self:closeThis()
end

function RoomStoreGoodsTipView:_editableInitView()
	self._payItemTbList = {}

	gohelper.setActive(self._goblockInfoItem, false)
	gohelper.setActive(self._gojumpItem, false)
	gohelper.setActive(self._gobuyContent, true)
	gohelper.setActive(self._gosource, false)
	self:_createPayItemUserDataTb_(self._gopayitem)
	self._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_2"))

	self.cobrandLogoItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._gocobrand, RoomSourcesCobrandLogoItem, self)

	gohelper.removeUIClickAudio(self._btnclose.gameObject)
	gohelper.addUIClickAudio(self._btninsight.gameObject, AudioEnum.HeroGroupUI.Play_UI_Action_Mainstart)
	RoomStoreItemListModel.instance:setIsSelectCurrency(false)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
end

function RoomStoreGoodsTipView:_onBuyCallback(cmd, resultCode, msg)
	if resultCode == 0 then
		if self:_checkRoomBuildingRare(msg.goodsId) then
			self:closeThis()
		end

		TaskDispatcher.runDelay(self._closeTipView, self, 5)
	end
end

function RoomStoreGoodsTipView:_checkRoomBuildingRare(storeId)
	local itemConfig = StoreConfig.instance:getGoodsConfig(storeId)
	local product = string.split(itemConfig.product, "#")
	local roomtype = tonumber(product[1])
	local roomid = tonumber(product[2])

	if roomtype == MaterialEnum.MaterialType.Building then
		local config = RoomConfig.instance:getBuildingConfig(roomid)

		if config.rare == 1 then
			return true
		end
	end

	return false
end

function RoomStoreGoodsTipView:_closeTipView()
	self:closeThis()
end

function RoomStoreGoodsTipView:_onOpenViewFinish(viewName)
	if viewName == ViewName.RoomBlockPackageGetView then
		self:_closeTipView()
	end
end

function RoomStoreGoodsTipView:_createPayItemUserDataTb_(goItem)
	local tb = self:getUserDataTb_()

	tb._go = goItem
	tb._gonormalbg = gohelper.findChild(goItem, "go_normalbg")
	tb._goselectbg = gohelper.findChild(goItem, "go_selectbg")
	tb._imageicon = gohelper.findChildImage(goItem, "txt_desc/simage_icon")
	tb._txtdesc = gohelper.findChildText(goItem, "txt_desc")
	tb._btnpay = gohelper.findChildButtonWithAudio(goItem, "btn_pay")

	tb._btnpay:AddClickListener(function(param)
		param.self:_setSelectCostId(param.item.costId)
	end, {
		self = self,
		item = tb
	})
	table.insert(self._payItemTbList, tb)

	return tb
end

function RoomStoreGoodsTipView:_refreshPayItemUI(itemUserDataTb, costId, itemType, itemId)
	local tb = itemUserDataTb

	tb.costId = costId

	local str = string.format("%s_1", string.len(itemId) == 1 and itemType .. "0" .. itemId or itemType .. itemId)

	UISpriteSetMgr.instance:setCurrencyItemSprite(tb._imageicon, str)

	local itemCfg, iconPath = ItemModel.instance:getItemConfigAndIcon(itemType, itemId, true)

	if itemCfg then
		tb._txtdesc.text = itemCfg.name or nil
	end
end

function RoomStoreGoodsTipView:_onSelectPayItemUI(itemUserDataTb, isSelect)
	local tb = itemUserDataTb

	gohelper.setActive(tb._goselectbg, isSelect)
	gohelper.setActive(tb._gonormalbg, not isSelect)
	SLFramework.UGUI.GuiHelper.SetColor(tb._txtdesc, isSelect and "#FFFFFF" or "#4C4341")
end

function RoomStoreGoodsTipView:_setSelectCostId(costId)
	local selectId = self:_getSelectCostId()
	local mo = RoomStoreItemListModel.instance:getRoomStoreItemMOHasTheme()

	RoomStoreItemListModel.instance:setIsSelectCurrency(true)
	RoomStoreItemListModel.instance:setCostId(costId)

	if mo:checkShowTicket() then
		self:_refreshUI()
		self:_selectTicketBg(false)
	elseif selectId ~= self:_getSelectCostId() then
		self:_refreshUI()
	end
end

function RoomStoreGoodsTipView:_refreshUI()
	local mo = RoomStoreItemListModel.instance:getRoomStoreItemMOHasTheme()
	local showUseTicket = mo and mo:checkShowTicket()

	gohelper.setActive(self._gochange.gameObject, showUseTicket)

	local costId = mo and mo:getTicketId()

	if costId then
		self._txtchange.text = ItemConfig.instance:getItemCo(costId).name
	end

	if showUseTicket then
		local str = string.format("%s_1", mo:getTicketId())

		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagechangeicon, str)
	end

	local sourceType

	if mo then
		local themeId = RoomConfig.instance:getThemeIdByItem(mo.id, mo.materialType)
		local themeCO = themeId and lua_room_theme.configDict[themeId]

		if themeCO then
			self._txttheme.text = themeCO.name or ""
		end

		sourceType = themeCO.sourcesType
	end

	if RoomStoreItemListModel.instance:getCount() == 1 then
		local firstMO = RoomStoreItemListModel.instance:getByIndex(1)
		local firstConfig = firstMO and firstMO:getItemConfig()

		sourceType = firstConfig and firstConfig.sourcesType or nil
	end

	self.cobrandLogoItem:setSourcesTypeStr(sourceType)
	gohelper.setActive(self._btntheme, mo ~= nil and not self.cobrandLogoItem:getIsShow())

	local costNum = RoomStoreItemListModel.instance:getTotalPriceByCostId()
	local curCostId = self:_getSelectCostId()
	local cost1, cost2 = self.viewParam.storeGoodsMO:getAllCostInfo()
	local costInfos = {
		cost1,
		cost2
	}
	local curCostInfo = costInfos[curCostId][1]
	local costType = curCostInfo[1]
	local costId = curCostInfo[2]
	local costConfig, costIcon = ItemModel.instance:getItemConfigAndIcon(costType, costId)
	local isSelectTicket = not RoomStoreItemListModel.instance:getIsSelectCurrency() and showUseTicket
	local id = isSelectTicket and mo:getTicketId() or costConfig.icon
	local str = string.format("%s_1", id)

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagecosticon, str)

	local itemCfg, iconPath = ItemModel.instance:getItemConfigAndIcon(curCostInfo[1], curCostInfo[2], true)
	local quantity = ItemModel.instance:getItemQuantity(curCostInfo[1], curCostInfo[2])

	self._txtcostnum.text = isSelectTicket and 1 or costNum

	if isSelectTicket then
		SLFramework.UGUI.GuiHelper.SetColor(self._txtcostnum, "#595959")
	else
		SLFramework.UGUI.GuiHelper.SetColor(self._txtcostnum, quantity and costNum <= quantity and "#595959" or "#BF2E11")
	end

	local index = 0

	for costId = 1, #costInfos do
		local costInfo = costInfos[costId]

		if costInfo then
			costInfo = costInfo[1]
			index = index + 1

			local tb = self._payItemTbList[index]

			if not tb then
				local goItem = gohelper.cloneInPlace(self._gopayitem, "go_payitem" .. index)

				tb = self:_createPayItemUserDataTb_(goItem)
			end

			gohelper.setActive(tb._go, true)
			self:_refreshPayItemUI(tb, costId, costInfo[1], costInfo[2])

			if showUseTicket and not RoomStoreItemListModel.instance:getIsSelectCurrency() then
				self:_onSelectPayItemUI(tb, false)
			else
				self:_onSelectPayItemUI(tb, costId == curCostId)
			end
		end
	end

	for i = index + 1, #self._payItemTbList do
		gohelper.setActive(self._payItemTbList[i], false)
	end
end

function RoomStoreGoodsTipView:onUpdateParam()
	RoomStoreItemListModel.instance:setStoreGoodsMO(self.viewParam.storeGoodsMO)
	self:_refreshUI()
end

function RoomStoreGoodsTipView:onOpen()
	local storeGoodsMO = self.viewParam.storeGoodsMO
	local goodsConfig = StoreConfig.instance:getGoodsConfig(storeGoodsMO.goodsId)

	StoreController.instance:statOpenGoods(storeGoodsMO.belongStoreId, goodsConfig)
	RoomStoreItemListModel.instance:setStoreGoodsMO(self.viewParam.storeGoodsMO)

	local initCostId = self:_findInitCostId(self.viewParam.storeGoodsMO)

	RoomStoreItemListModel.instance:setCostId(initCostId)
	self:_refreshUI()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_open2)
end

function RoomStoreGoodsTipView:_findInitCostId(storeGoodsMO)
	local cost1, cost2 = storeGoodsMO:getAllCostInfo()
	local costInfos = {
		cost1,
		cost2
	}

	for costId, costInfo in ipairs(costInfos) do
		if costInfo then
			local costParam = costInfo[1]
			local quantity = ItemModel.instance:getItemQuantity(costParam[1], costParam[2])
			local needNum = RoomStoreItemListModel.instance:getTotalPriceByCostId(costId)

			return costId
		end
	end

	return 1
end

function RoomStoreGoodsTipView:_selectTicketBg(isSelect)
	SLFramework.UGUI.GuiHelper.SetColor(self._txtchange, isSelect and "#FFFFFF" or "#4C4341")
	gohelper.setActive(self._gopaynoraml, not isSelect)
	gohelper.setActive(self._gopayselect, isSelect)
end

function RoomStoreGoodsTipView:_getSelectCostId()
	return RoomStoreItemListModel.instance:getCostId()
end

function RoomStoreGoodsTipView:onClose()
	for i = 1, #self._payItemTbList do
		local tb = self._payItemTbList[i]

		tb._btnpay:RemoveClickListener()
	end

	if self.viewContainer:isManualClose() then
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_close)
	end

	TaskDispatcher.cancelTask(self._closeTipView, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
end

function RoomStoreGoodsTipView:onDestroyView()
	self._simagebg1:UnLoadImage()
	self._simagebg2:UnLoadImage()
	self.cobrandLogoItem:onDestroy()
end

return RoomStoreGoodsTipView
