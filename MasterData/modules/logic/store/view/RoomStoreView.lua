-- chunkname: @modules/logic/store/view/RoomStoreView.lua

module("modules.logic.store.view.RoomStoreView", package.seeall)

local RoomStoreView = class("RoomStoreView", BaseView)

function RoomStoreView:onInitView()
	self._goempty = gohelper.findChild(self.viewGO, "#go_empty")
	self._scrollprop = gohelper.findChildScrollRect(self.viewGO, "#scroll_prop")
	self._gocritter = gohelper.findChild(self.viewGO, "#go_critter")
	self._trsviewport = gohelper.findChild(self.viewGO, "#scroll_prop/viewport").transform
	self._trscontent = gohelper.findChild(self.viewGO, "#scroll_prop/viewport/content").transform
	self._golock = gohelper.findChild(self.viewGO, "#scroll_prop/#go_lock")
	self._simagelockbg = gohelper.findChildSingleImage(self.viewGO, "#scroll_prop/#go_lock/#simage_lockbg")
	self._gostorecategoryitem = gohelper.findChild(self.viewGO, "top/scroll_category/viewport/categorycontent/#go_storecategoryitem")
	self._gotabreddot1 = gohelper.findChild(self.viewGO, "top/scroll_category/viewport/categorycontent/#go_storecategoryitem/#go_tabreddot1")
	self._txtrefreshTime = gohelper.findChildText(self.viewGO, "#txt_refreshTime")
	self._lineGo = gohelper.findChild(self.viewGO, "line")

	if self._editableInitView then
		self:_editableInitView()
	end

	self.openduration = 0.6
	self.closeduration = 0.3
	self.moveduration = 0.3
	self.rootHeight = 397
	self._csPixel = nil
	self._categoryItemContainer = {}
end

function RoomStoreView:addEvents()
	return
end

function RoomStoreView:removeEvents()
	return
end

function RoomStoreView:_editableInitView()
	return
end

function RoomStoreView:onUpdateParam(param)
	return
end

function RoomStoreView:onOpen()
	self._selectFirstTabId = self.viewContainer:getSelectFirstTabId()

	local jumpTabId = self.viewContainer:getJumpTabId()

	self.jumpGoodsId = self.viewContainer:getJumpGoodsId()
	self._csView = self.viewContainer._ScrollViewRoomStore
	self._csScroll = self._csView:getCsScroll()

	self:_refreshTabs(jumpTabId, true)
	self.addEventCb(self, StoreController.instance, StoreEvent.GoodsModelChanged, self._updateInfo, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.SaveVerticalScrollPixel, self._savecsPixel, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.StoreInfoChanged, self._updateInfo, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.OpenRoomStoreNode, self.changeContentPosY, self)

	self._scrollprop.verticalNormalizedPosition = 1
end

function RoomStoreView:onClose()
	if self.delaycallBack then
		TaskDispatcher.cancelTask(self.delaycallBack, self)
	end

	TaskDispatcher.cancelTask(self.jumpClickChildGoods, self, self.openduration)
	self.removeEventCb(self, StoreController.instance, StoreEvent.SaveVerticalScrollPixel, self._savecsPixel, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.OpenRoomStoreNode, self.changeContentPosY, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.GoodsModelChanged, self._updateInfo, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.StoreInfoChanged, self._updateInfo, self)
end

function RoomStoreView:onDestroyView()
	if self._categoryItemContainer and #self._categoryItemContainer > 0 then
		for i = 1, #self._categoryItemContainer do
			local categotyItem = self._categoryItemContainer[i]

			categotyItem.btn:RemoveClickListener()
		end
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.ResumeAtmosphereEffect)
end

function RoomStoreView:_savecsPixel()
	if self._csScroll then
		self._csPixel = self._csScroll.VerticalScrollPixel
	end
end

function RoomStoreView:_updateInfo(goodsId)
	self:_refreshGoods(false, goodsId)
	self:_refreshRightTop()

	local firstitem = self._csScroll:GetRenderCellRect(1, -1)

	if firstitem then
		local itemHeight = recthelper.getHeight(firstitem)

		self.firstItemOffsetY = self:calculateFirstItemOffsetY(itemHeight)
	else
		return
	end

	if not goodsId then
		if not self.jumpGoodsId then
			local param = {
				index = 1,
				isFirstOpen = true,
				state = true,
				delay = true,
				itemHeight = self.rootHeight
			}

			self:changeContentPosY(param)
		else
			local index = self:_getRootIndexById(self.jumpGoodsId)
			local param = {
				isFirstOpen = false,
				state = true,
				delay = true,
				index = index,
				itemHeight = self.rootHeight
			}

			self:changeContentPosY(param)

			self.jumpGoodsId = nil
		end
	end
end

function RoomStoreView:_refreshSecondTabs(index, secondTabConfig)
	local categoryItemTable = self._categoryItemContainer[index]

	categoryItemTable = categoryItemTable or self:initCategoryItemTable(index)
	categoryItemTable.tabId = secondTabConfig.id
	categoryItemTable.txt_itemcn1.text = secondTabConfig.name
	categoryItemTable.txt_itemcn2.text = secondTabConfig.name
	categoryItemTable.txt_itemen1.text = secondTabConfig.nameEn
	categoryItemTable.txt_itemen2.text = secondTabConfig.nameEn

	local select = self._selectSecondTabId == secondTabConfig.id

	gohelper.setActive(self._categoryItemContainer[index].go_line, true)

	if select and self._categoryItemContainer[index - 1] then
		gohelper.setActive(self._categoryItemContainer[index - 1].go_line, false)
	end

	gohelper.setActive(categoryItemTable.go_unselected, not select)
	gohelper.setActive(categoryItemTable.go_selected, select)
end

function RoomStoreView:initCategoryItemTable(index)
	local categoryItemTable = self:getUserDataTb_()

	categoryItemTable.go = gohelper.cloneInPlace(self._gostorecategoryitem, "item" .. index)
	categoryItemTable.go_unselected = gohelper.findChild(categoryItemTable.go, "go_unselected")
	categoryItemTable.go_selected = gohelper.findChild(categoryItemTable.go, "go_selected")
	categoryItemTable.go_reddot = gohelper.findChild(categoryItemTable.go, "#go_tabreddot1")
	categoryItemTable.go_reddotNormalType = gohelper.findChild(categoryItemTable.go, "#go_tabreddot1/type1")
	categoryItemTable.go_reddotNewType = gohelper.findChild(categoryItemTable.go, "#go_tabreddot1/type5")
	categoryItemTable.go_reddotActType = gohelper.findChild(categoryItemTable.go, "#go_tabreddot1/type9")
	categoryItemTable.txt_itemcn1 = gohelper.findChildText(categoryItemTable.go, "go_unselected/txt_itemcn1")
	categoryItemTable.txt_itemen1 = gohelper.findChildText(categoryItemTable.go, "go_unselected/txt_itemen1")
	categoryItemTable.txt_itemcn2 = gohelper.findChildText(categoryItemTable.go, "go_selected/txt_itemcn2")
	categoryItemTable.txt_itemen2 = gohelper.findChildText(categoryItemTable.go, "go_selected/txt_itemen2")
	categoryItemTable.go_line = gohelper.findChild(categoryItemTable.go, "#go_line")
	categoryItemTable.btn = gohelper.getClickWithAudio(categoryItemTable.go, AudioEnum.UI.play_ui_bank_open)
	categoryItemTable.tabId = 0

	categoryItemTable.btn:AddClickListener(function(categoryItemTable)
		local jumpTab = categoryItemTable.tabId

		if categoryItemTable.tabId == StoreEnum.StoreId.OldRoomStore then
			StoreModel.instance:setNewRedDotKey(categoryItemTable.tabId)
		end

		self:_refreshTabs(jumpTab)

		self.viewContainer.notPlayAnimation = true

		StoreController.instance:onSwitchTab(jumpTab)
	end, categoryItemTable)
	table.insert(self._categoryItemContainer, categoryItemTable)
	gohelper.setActive(categoryItemTable.go_childItem, false)

	return categoryItemTable
end

function RoomStoreView:_refreshTabs(selectTabId, openUpdate)
	local preSelectSecondTabId = self._selectSecondTabId
	local preSelectThirdTabId = self._selectThirdTabId

	self._selectSecondTabId = 0
	self._selectThirdTabId = 0
	self.openUpdate = openUpdate
	self._scrollprop.verticalNormalizedPosition = 1

	if not StoreModel.instance:isTabOpen(selectTabId) then
		selectTabId = self.viewContainer:getSelectFirstTabId()
	end

	local _

	_, self._selectSecondTabId, self._selectThirdTabId = StoreModel.instance:jumpTabIdToSelectTabId(selectTabId)

	self:_refreshRightTop()

	local secondTabConfigs = StoreModel.instance:getSecondTabs(self._selectFirstTabId, true, true)

	if secondTabConfigs and #secondTabConfigs > 0 then
		for i = 1, #secondTabConfigs do
			self:_refreshSecondTabs(i, secondTabConfigs[i])
			gohelper.setActive(self._categoryItemContainer[i].go, true)
		end

		gohelper.setActive(self._categoryItemContainer[#secondTabConfigs].go_line, false)

		for i = #secondTabConfigs + 1, #self._categoryItemContainer do
			gohelper.setActive(self._categoryItemContainer[i].go, false)
		end

		gohelper.setActive(self._lineGo, true)
	else
		for i = 1, #self._categoryItemContainer do
			gohelper.setActive(self._categoryItemContainer[i].go, false)
		end

		gohelper.setActive(self._lineGo, false)
	end

	self:_onRefreshRedDot()

	if not openUpdate and preSelectSecondTabId == self._selectSecondTabId and preSelectThirdTabId == self._selectThirdTabId then
		return
	end

	local isCritterStore = self._selectSecondTabId == StoreEnum.StoreId.CritterStore

	gohelper.setActive(self._gocritter.gameObject, isCritterStore)
	gohelper.setActive(self._scrollprop.gameObject, not isCritterStore)

	if isCritterStore then
		self.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 5, 1)
	end

	self:_refreshGoods(true)
end

function RoomStoreView:_refreshRightTop()
	local thirdConfig = StoreConfig.instance:getTabConfig(self._selectThirdTabId)
	local secondConfig = StoreConfig.instance:getTabConfig(self._selectSecondTabId)
	local firstConfig = StoreConfig.instance:getTabConfig(self.viewContainer:getSelectFirstTabId())

	if thirdConfig and not string.nilorempty(thirdConfig.showCost) then
		self.viewContainer:setCurrencyByParams(self:packShowCostParam(thirdConfig.showCost))
	elseif secondConfig and not string.nilorempty(secondConfig.showCost) then
		self.viewContainer:setCurrencyByParams(self:packShowCostParam(secondConfig.showCost))
	elseif firstConfig and not string.nilorempty(firstConfig.showCost) then
		self.viewContainer:setCurrencyByParams(self:packShowCostParam(firstConfig.showCost))
	else
		self.viewContainer:setCurrencyByParams(nil)
	end
end

function RoomStoreView:_refreshGoods(update, goodsId)
	local hadItemId

	if goodsId then
		hadItemId = goodsId
	end

	self.storeId = 0

	local thirdConfig = StoreConfig.instance:getTabConfig(self._selectThirdTabId)

	if thirdConfig then
		self.storeId = thirdConfig.storeId or 0
	end

	if self.storeId == 0 then
		local secondConfig = StoreConfig.instance:getTabConfig(self._selectSecondTabId)

		if secondConfig then
			self.storeId = secondConfig.storeId or 0
		end
	end

	local isShowEmpty = true

	if self.storeId == 0 then
		StoreNormalGoodsItemListModel.instance:setMOList()
	elseif self.storeId == StoreEnum.StoreId.CritterStore then
		isShowEmpty = false

		if update then
			self.viewContainer:playCritterStoreAnimation()
		end
	else
		local storeMO = StoreModel.instance:getStoreMO(self.storeId)

		if storeMO then
			local storeGoodsMOList = storeMO:getGoodsList(true)

			self.rootGoodsList = {}

			local nodeGoodsList = {}

			for _, mo in pairs(storeGoodsMOList) do
				local offDic = {}

				if mo:getOffTab() then
					offDic = GameUtil.splitString2(mo:getOffTab())
					mo.goodscn = offDic[1][2]
					mo.goodsen = offDic[1][3]

					if self.jumpGoodsId then
						mo.isjump = true
					end
				end

				if not string.nilorempty(mo.config.nameEn) then
					mo.update = update

					table.insert(self.rootGoodsList, mo)
				elseif mo:checkJumpGoodCanOpen() then
					table.insert(nodeGoodsList, mo)
				end
			end

			for _, rootmo in pairs(self.rootGoodsList) do
				for _, nodemo in pairs(nodeGoodsList) do
					if nodemo.goodsen == rootmo.config.nameEn then
						if rootmo.children == nil then
							rootmo.children = {}

							table.insert(rootmo.children, nodemo)
						else
							if hadItemId and nodemo.goodsId == hadItemId then
								rootmo.isExpand = true
							end

							if not tabletool.indexOf(rootmo.children, nodemo) then
								table.insert(rootmo.children, nodemo)
							end
						end
					end
				end
			end

			for index, rootmo in ipairs(self.rootGoodsList) do
				if rootmo.children == nil then
					table.remove(self.rootGoodsList, index)
				end
			end

			if self.rootGoodsList and #self.rootGoodsList > 0 then
				isShowEmpty = false
			end

			StoreRoomGoodsItemListModel.instance:setMOList(self.rootGoodsList)

			if self._csPixel then
				self._csScroll.VerticalScrollPixel = self._csPixel
				self._csPixel = nil
			end
		end

		if update then
			StoreRpc.instance:sendGetStoreInfosRequest({
				self.storeId
			})
		end
	end

	gohelper.setActive(self._goempty, isShowEmpty)
end

function RoomStoreView:changeContentPosY(param)
	local rootindex = param.index
	local state = param.state
	local itemHeight = param.itemHeight
	local delay = param.delay
	local isFirstOpen = param.isFirstOpen

	if not rootindex then
		return
	end

	local rootcount = StoreRoomGoodsItemListModel.instance:getRootCount() - 1

	if self.storeId == StoreEnum.StoreId.NewRoomStore then
		if rootcount >= 2 and isFirstOpen then
			return
		end
	elseif self.storeId == StoreEnum.StoreId.OldRoomStore and isFirstOpen then
		return
	end

	local rootmo = StoreRoomGoodsItemListModel.instance:getByIndex(rootindex, 0)
	local childCount = #rootmo.children

	self.openduration = Mathf.Ceil(childCount / 4) * 0.2

	local delaytime = self.moveduration * rootindex

	function self.delaycallBack()
		if rootindex and self._csView then
			self._csView:expand(rootindex, nil, self.openduration)

			if self.jumpClickChildGoodsId then
				TaskDispatcher.runDelay(self.jumpClickChildGoods, self, self.openduration)
			end
		end
	end

	local callBack

	if state then
		local offssetY = self:calculateFirstItemOffsetY(itemHeight)

		callBack = delay and function()
			TaskDispatcher.runDelay(self.delaycallBack, self, delaytime)
		end or function()
			self._csView:expand(rootindex, nil, self.openduration)
		end

		if self.jumpGoodsId then
			TaskDispatcher.runDelay(self.delaycallBack, self, delaytime)
		else
			self:checkOtherItemIsExpand(callBack)
		end

		if rootindex == 1 then
			ZProj.TweenHelper.DOLocalMoveY(self._trscontent, 0, self.moveduration)

			return
		end

		if self.firstItemOffsetY == nil then
			self.firstItemOffsetY = self:calculateFirstItemOffsetY(self.rootHeight)
		end

		local moveY = self.firstItemOffsetY - offssetY
		local itemposY = itemHeight * (rootindex - 1)

		ZProj.TweenHelper.DOLocalMoveY(self._trscontent, itemposY + moveY, delay and delaytime or self.moveduration)
	else
		self._csView:shrink(rootindex, nil, self.closeduration)
	end
end

function RoomStoreView:jumpClickChildGoods()
	if not self.jumpClickChildGoodsId then
		return
	end

	StoreController.instance:dispatchEvent(StoreEvent.jumpClickRoomChildGoods, self.jumpClickChildGoodsId)

	self.jumpClickChildGoodsId = nil
end

function RoomStoreView:calculateFirstItemOffsetY(itemHeight)
	local rectmask2DTop = 25
	local viewPortHeight = recthelper.getHeight(self._trsviewport) + rectmask2DTop
	local itemHeight = itemHeight

	return (viewPortHeight - itemHeight) / 2
end

function RoomStoreView:checkOtherItemIsExpand(callBack)
	local list = StoreRoomGoodsItemListModel.instance:getInfoList()
	local isExpand = false

	for i = 1, #list do
		isExpand = self._csView:isExpand(i)

		if isExpand then
			self._csView:shrink(i, nil, 0.3, callBack, self)

			break
		end
	end

	if not isExpand then
		callBack()
	end
end

function RoomStoreView:_getRootIndexById(goodsId)
	if not self.rootGoodsList then
		return
	end

	local targetGoodsCfg = StoreConfig.instance:getGoodsConfig(goodsId)
	local targetProductArr = targetGoodsCfg and GameUtil.splitString2(targetGoodsCfg.product, true) or {}

	for i = 1, #self.rootGoodsList do
		local isThisIndex = false
		local rootGoodMo = self.rootGoodsList[i]
		local isRootGoods = rootGoodMo.goodsId == goodsId

		if isRootGoods then
			isThisIndex = true
		else
			local isChildGoods = rootGoodMo:hasProduct(targetProductArr[1][1], targetProductArr[1][2])

			if isChildGoods then
				isThisIndex = true
				self.jumpClickChildGoodsId = goodsId
			end
		end

		if isThisIndex then
			return i
		end
	end
end

function RoomStoreView:_onRefreshRedDot()
	for _, v in pairs(self._categoryItemContainer) do
		local isShow, isActRedDot = StoreModel.instance:isTabFirstRedDotShow(v.tabId)
		local isShowNewTag = false

		if v.tabId == StoreEnum.StoreId.OldRoomStore then
			isShowNewTag = StoreModel.instance:checkShowNewRedDot(v.tabId)
		end

		gohelper.setActive(v.go_reddot, (isShowNewTag or nil) and true)
		gohelper.setActive(v.go_reddotNewType, isShowNewTag)
		gohelper.setActive(v.go_reddotNormalType, not isShowNewTag and not isActRedDot)
		gohelper.setActive(v.go_reddotActType, not isShowNewTag and isActRedDot)
	end
end

function RoomStoreView:packShowCostParam(showCost)
	local currencyTypeParams = {}
	local costInfo = string.split(showCost, "#")

	for i = #costInfo, 1, -1 do
		local costId = tonumber(costInfo[i])

		if ItemModel.instance:getItemCount(costId) > 0 and not CurrencyModel.instance:getCurrency(costId) then
			table.insert(currencyTypeParams, {
				isCurrencySprite = true,
				id = costId,
				type = MaterialEnum.MaterialType.Item
			})
		elseif CurrencyModel.instance:getCurrency(costId) then
			table.insert(currencyTypeParams, costId)
		end
	end

	return currencyTypeParams
end

return RoomStoreView
