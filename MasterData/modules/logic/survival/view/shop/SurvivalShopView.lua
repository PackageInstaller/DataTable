-- chunkname: @modules/logic/survival/view/shop/SurvivalShopView.lua

module("modules.logic.survival.view.shop.SurvivalShopView", package.seeall)

local SurvivalShopView = class("SurvivalShopView", BaseView)

function SurvivalShopView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_close")
	self._btnenter = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_enter")
	self._goinfoview = gohelper.findChild(self.viewGO, "Center/#go_info")
	self._goempty = gohelper.findChild(self.viewGO, "Center/#go_empty")
	self._txttitle = gohelper.findChildTextMesh(self.viewGO, "Center/Title/#txt_title")
	self._txtLeftTitle = gohelper.findChildTextMesh(self.viewGO, "Left/#txt_bag")
	self._goleftscroll = gohelper.findChild(self.viewGO, "Left/#go_list/scroll_collection")
	self._goleftitem = gohelper.findChild(self.viewGO, "Left/#go_list/scroll_collection/Viewport/Content/go_bagitem")
	self._goleftempty = gohelper.findChild(self.viewGO, "Left/#go_list/#go_empty")
	self._goheavy = gohelper.findChild(self.viewGO, "Left/#go_heavy")
	self._gosort = gohelper.findChild(self.viewGO, "Left/#go_sort")
	self._gotag1 = gohelper.findChild(self.viewGO, "Left/#go_tag/tag1")
	self._gotag2 = gohelper.findChild(self.viewGO, "Left/#go_tag/tag2")
	self._gotag3 = gohelper.findChild(self.viewGO, "Left/#go_tag/tag3")
	self._txttag1 = gohelper.findChildTextMesh(self.viewGO, "Left/#go_tag/tag1/#txt_tag1")
	self._txttag2 = gohelper.findChildTextMesh(self.viewGO, "Left/#go_tag/tag2/#txt_tag2")
	self._txttag3 = gohelper.findChildTextMesh(self.viewGO, "Left/#go_tag/tag3/#txt_tag3")
	self._btntag1 = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_tag/tag1")
	self._btntag2 = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_tag/tag2")
	self._btntag3 = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_tag/tag3")
	self._gorightscroll_normal = gohelper.findChild(self.viewGO, "Right/#go_list/scroll_collection")
	self._gorightitem_normal = gohelper.findChild(self.viewGO, "Right/#go_list/scroll_collection/Viewport/Content/go_bagitem")
	self._gorightempty = gohelper.findChild(self.viewGO, "Right/#go_list/#go_empty")
	self._gorightTag = gohelper.findChild(self.viewGO, "Right/#go_tag")
	self._golefttaganim = gohelper.findChild(self.viewGO, "Left/#go_tag"):GetComponent(typeof(UnityEngine.Animation))
	self._txtRightTitle = gohelper.findChildTextMesh(self.viewGO, "Right/#txt_shop")
	self._gorightscroll_preexploreshop = gohelper.findChild(self.viewGO, "Right/#go_list/scroll_collection_preexploreshop")
	self._gorightitem_preexploreshop = gohelper.findChild(self.viewGO, "Right/#go_list/scroll_collection_preexploreshop/Viewport/Content/go_bagitem")
	self.ShopTabScroll = gohelper.findChild(self.viewGO, "Right/tab")
	self.ShopTab = gohelper.findChild(self.viewGO, "Right/tab/Viewport/Content/ShopTab")

	self:createTabListComp()

	self._golefttab = gohelper.findChild(self.viewGO, "Left/tab/Viewport/Content")

	local scrollParam = SimpleListParam.New()

	scrollParam.cellClass = SurvivalShopLeftTab
	self.leftTabListComp = GameFacade.createSimpleListComp(self._golefttab, scrollParam, nil, self.viewContainer)

	self.leftTabListComp:addCustomItem(gohelper.findChild(self._golefttab, "SurvivalShopLeftTab1"))
	self.leftTabListComp:addCustomItem(gohelper.findChild(self._golefttab, "SurvivalShopLeftTab2"))
	self.leftTabListComp:setOnClickItem(self.onClickLeftTab, self)
	self.leftTabListComp:setOnSelectChange(self.onSelectLeftTabCallBack, self)
end

function SurvivalShopView:addEvents()
	self._btnclose:AddClickListener(self.onClickModalMask, self)
	self._btnenter:AddClickListener(self.onClickBtnEnter, self)
	self._btntag1:AddClickListener(self._openCurrencyTips, self, {
		id = 1,
		btn = self._btntag1
	})
	self._btntag2:AddClickListener(self._openCurrencyTips, self, {
		id = 2,
		btn = self._btntag2
	})
	self._btntag3:AddClickListener(self._openCurrencyTips, self, {
		id = 3,
		btn = self._btntag3
	})
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapBagUpdate, self._refreshBagByServer, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnShelterBagUpdate, self._refreshBagByServer, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnShopItemUpdate, self._onShopItemUpdate, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnClickTipsBtn, self._onClickInfo, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnReceiveSurvivalShopBuyReply, self.onReceiveSurvivalShopBuyReply, self)
end

function SurvivalShopView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnenter:RemoveClickListener()
	self._btntag1:RemoveClickListener()
	self._btntag2:RemoveClickListener()
	self._btntag3:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapBagUpdate, self._refreshBagByServer, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnShelterBagUpdate, self._refreshBagByServer, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnShopItemUpdate, self._onShopItemUpdate, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnClickTipsBtn, self._onClickInfo, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnReceiveSurvivalShopBuyReply, self.onReceiveSurvivalShopBuyReply, self)
end

function SurvivalShopView:onOpen()
	self.viewParam = self.viewParam or {}

	if self.viewParam.shopMo then
		self._shopMo = self.viewParam.shopMo
	else
		self._shopMo, self._panelUid = SurvivalMapHelper.instance:getShopPanel()
	end

	self.mapId = self.viewParam.mapId
	self.dayMode = self.viewParam.dayMode
	self.shopType = self._shopMo.shopType

	SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideShopOpen, self.shopType)

	self.isShowLeftTab = self._shopMo:isPreExploreShop()

	gohelper.setActive(self._golefttab, self.isShowLeftTab)
	self:refreshTitle()
	gohelper.setActive(self._btnenter, self._shopMo:isPreExploreShop())

	self.isBuyItem = nil

	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_mail_open)

	local infoViewRes = self.viewContainer._viewSetting.otherRes.infoView
	local infoGo = self:getResInst(infoViewRes, self._goinfoview)

	self._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(infoGo, SurvivalBagInfoPart)

	self._infoPanel:setShopData(self._shopMo.id, self._shopMo.shopType)
	self._infoPanel:setCloseShow(true, self._onClickInfo, self)
	self._infoPanel:updateMo()

	local t = {
		[SurvivalEnum.ItemSource.Shelter] = SurvivalEnum.ItemSource.ShopBag,
		[SurvivalEnum.ItemSource.Map] = SurvivalEnum.ItemSource.ShopBag
	}

	self._infoPanel:setChangeSource(t)
	gohelper.setActive(self._goempty, true)

	self._curSelectUid = nil
	self._isSelectLeft = false

	gohelper.setActive(self._gorightTag, not self:isShelterShop() and not self._panelUid)

	self._simpleLeftList = MonoHelper.addNoUpdateLuaComOnceToGo(self._goleftscroll, SurvivalSimpleListPart)

	self._simpleLeftList:setCellUpdateCallBack(self._createLeftItem, self, nil, self._goleftitem)
	gohelper.setActive(self._gorightscroll_preexploreshop, self:isShowPrice())
	gohelper.setActive(self._gorightscroll_normal, not self:isShowPrice())

	if self:isShowPrice() then
		self._gorightscroll = self._gorightscroll_preexploreshop or self._gorightscroll_normal
	end

	if not self:isShowPrice() then
		self._gorightitem = self._gorightitem_preexploreshop or self._gorightitem_normal
	end

	self._simpleRightList = MonoHelper.addNoUpdateLuaComOnceToGo(self._gorightscroll, SurvivalSimpleListPart)

	self._simpleRightList:setCellUpdateCallBack(self._createRightItem, self, nil, self._gorightitem)
	self:initWeightAndSort()
	self:refreshTabListComp()
	self.tabListComp:setSelect(1)

	if self.isShowLeftTab then
		self.leftTabListComp:setData({
			SurvivalEnum.ItemSource.Map,
			SurvivalEnum.ItemSource.Shelter
		})
		self.leftTabListComp:setSelect(1)
	else
		self:_refreshBag()
	end
end

function SurvivalShopView:getBagMo()
	if self._shopMo:isPreExploreShop() then
		local item = self.leftTabListComp:getCurSelectItem()

		return item.bag
	else
		return SurvivalMapHelper.instance:getBagMo()
	end
end

function SurvivalShopView:isShowPrice()
	return self:isShelterShop() or self:isSurvivalShop()
end

function SurvivalShopView:isShelterShop()
	local weekMo = SurvivalShelterModel.instance:getWeekInfo()

	return not weekMo.inSurvival
end

function SurvivalShopView:isSurvivalShop()
	local weekMo = SurvivalShelterModel.instance:getWeekInfo()

	return weekMo.inSurvival
end

function SurvivalShopView:initWeightAndSort()
	if self._panelUid or self._shopMo:isPreExploreShop() then
		MonoHelper.addNoUpdateLuaComOnceToGo(self._goheavy, SurvivalWeightPart)
	else
		gohelper.setActive(self._goheavy, false)
	end

	local sortComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._gosort, SurvivalSortAndFilterPart)
	local sortOptions = {}

	sortOptions[1] = {
		desc = luaLang("survival_sort_time"),
		type = SurvivalEnum.ItemSortType.Time
	}
	sortOptions[2] = {
		desc = luaLang("survival_sort_mass"),
		type = SurvivalEnum.ItemSortType.Mass
	}
	sortOptions[3] = {
		desc = luaLang("survival_sort_worth"),
		type = SurvivalEnum.ItemSortType.Worth
	}
	sortOptions[4] = {
		desc = luaLang("survival_sort_type"),
		type = SurvivalEnum.ItemSortType.Type
	}

	local filterOptions = {}

	filterOptions[1] = {
		desc = luaLang("survival_filter_material"),
		type = SurvivalEnum.ItemFilterType.Material
	}
	filterOptions[2] = {
		desc = luaLang("survival_filter_equip"),
		type = SurvivalEnum.ItemFilterType.Equip
	}
	filterOptions[3] = {
		desc = luaLang("survival_filter_consume"),
		type = SurvivalEnum.ItemFilterType.Consume
	}
	self._curSort = sortOptions[1]
	self._isDec = true
	self._filterList = {}

	sortComp:setOptions(sortOptions, filterOptions, self._curSort, self._isDec)
	sortComp:setOptionChangeCallback(self._onSortChange, self)
end

function SurvivalShopView:onReceiveSurvivalShopBuyReply()
	self.isBuyItem = true
end

function SurvivalShopView:_onClickInfo()
	self:cancelSelect()
end

function SurvivalShopView:cancelSelect()
	if self._curSelectUid then
		gohelper.setActive(self._goempty, true)
		self._infoPanel:updateMo()

		self._curSelectUid = nil

		self:updateItemSelect()
	end
end

function SurvivalShopView:onClickModalMask()
	if self._panelUid then
		SurvivalWeekRpc.instance:sendSurvivalClosePanelRequest(self._panelUid, self.closeThis, self)
	else
		self:closeThis()
	end
end

function SurvivalShopView:onClickBtnEnter()
	if self.isBuyItem then
		SurvivalController.instance:enterSurvivalMap(SurvivalMapModel.instance:getInitGroup(), self.dayMode)
	else
		GameFacade.showOptionMessageBox(MessageBoxIdDefine.Sign_SurvivalShopView_Buy, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, self.onYesClick, nil, nil, self)
	end
end

function SurvivalShopView:onYesClick()
	SurvivalController.instance:enterSurvivalMap(SurvivalMapModel.instance:getInitGroup(), self.dayMode)
end

function SurvivalShopView:_onSortChange(sortData, isDec, filterList)
	self._curSort = sortData
	self._isDec = isDec
	self._filterList = filterList

	self:_refreshBag()
end

function SurvivalShopView:_refreshBagByServer(msg)
	for i = 1, #self.currencyShow do
		if tabletool.indexOf(self.currencyShow, i) then
			local preVal = tonumber(self["_txttag" .. i].text) or 0
			local nowVal = self:getBagMo():getCurrencyNum(i)

			if preVal < nowVal then
				self._golefttaganim:Play()

				break
			end
		end
	end

	local deleteUids = {}

	for i, v in ipairs(msg.delItemUids) do
		deleteUids[v] = true
	end

	local isPlayAnim = false

	if next(deleteUids) then
		for go in pairs(self._simpleLeftList:getAllGos()) do
			local instGo = gohelper.findChild(go, "inst")
			local bagItem = MonoHelper.getLuaComFromGo(instGo, SurvivalBagItem)

			if bagItem and not bagItem._mo:isEmpty() and deleteUids[bagItem._mo.uid] then
				bagItem:playCloseAnim()

				isPlayAnim = true
			end
		end
	end

	if not isPlayAnim then
		self:_refreshBag()
	else
		UIBlockHelper.instance:startBlock("SurvivalShopView._refreshBag", 0.2)
		TaskDispatcher.runDelay(self._refreshBag, self, 0.2)
	end

	if self.itemsData then
		for go in pairs(self._simpleRightList:getAllGos()) do
			local instGo = gohelper.findChild(go, "inst")
			local item = MonoHelper.getLuaComFromGo(instGo, SurvivalBagItem)
			local shopStyleParam = item.shopStyleParam

			shopStyleParam.currencyNum = self:getBagMo():getCurrencyNum(1)

			item:setShopStyle(shopStyleParam)
		end
	end
end

function SurvivalShopView:refreshTitle()
	self._txttitle.text = SurvivalConfig.instance:getShopName(self._shopMo.id)

	if self._shopMo:isPreExploreShop() then
		local select = self.leftTabListComp:getSelect()

		self._txtLeftTitle.text = select == 1 and luaLang("p_survivalcommititemview_txt_bag") or luaLang("SurvivalShopView_1")
	else
		self._txtLeftTitle.text = self._shopMo.shopType == SurvivalEnum.ShopType.GeneralShop and luaLang("SurvivalShopView_1") or luaLang("p_survivalcommititemview_txt_bag")
	end
end

function SurvivalShopView:refreshRightTitle()
	self._txtRightTitle.text = self.haveTab and self.datas[self.tabListComp:getSelect()].cfg.name or luaLang("p_survivalshopview_txt_shop")
end

function SurvivalShopView:_refreshBag()
	self.currencyShow = {
		1
	}

	for i = 1, 3 do
		if tabletool.indexOf(self.currencyShow, i) then
			gohelper.setActive(self["_gotag" .. i], true)

			self["_txttag" .. i].text = self:getBagMo():getCurrencyNum(i)
		else
			gohelper.setActive(self["_gotag" .. i], false)
		end
	end

	local showItems = {}

	for _, itemMo in ipairs(self:getBagMo().items) do
		if self:isShowItem(itemMo) and SurvivalBagSortHelper.filterItemMo(self._filterList, itemMo) then
			table.insert(showItems, itemMo)
		end
	end

	if self:isSurvivalShop() then
		SurvivalBagSortHelper.sortItems(showItems, self._curSort.type, self._isDec, {
			isCheckNPCItem = true
		})
	else
		SurvivalBagSortHelper.sortItems(showItems, self._curSort.type, self._isDec)
	end

	SurvivalHelper.instance:makeArrFull(showItems, SurvivalBagItemMo.Empty, 3, 5)
	self._simpleLeftList:setList(showItems)

	self._showItems = showItems

	gohelper.setActive(self._goleftscroll, #showItems > 0)
	gohelper.setActive(self._goleftempty, #showItems == 0)
end

function SurvivalShopView:isShowItem(itemMo)
	if not itemMo or not itemMo.co then
		return false
	end

	if itemMo.sellPrice > 0 then
		return true
	end

	if self._shopMo:isPreExploreShop() and itemMo.co.type == SurvivalEnum.ItemType.Material and itemMo.co.subType == SurvivalEnum.ItemSubType.Material_VehicleItem then
		return true
	end

	return false
end

function SurvivalShopView:getShopItems()
	if self.haveTab then
		local tabIndex = self.tabListComp:getSelect()
		local tabData = self.datas[tabIndex]
		local tabId = tabData.cfg.id

		return self._shopMo:getItemsByTabId(tabId)
	else
		return self._shopMo.items
	end
end

function SurvivalShopView:_refreshShopItems()
	self.itemsData = self:getShopItems()

	self._simpleRightList:setList(self.itemsData)
	gohelper.setActive(self._gorightscroll, #self.itemsData > 0)
	gohelper.setActive(self._gorightempty, #self.itemsData == 0)
end

function SurvivalShopView:_onShopItemUpdate(index, itemMo, uid)
	for item, k in pairs(self._simpleRightList:getAllGos()) do
		local obj = gohelper.findChild(item, "inst")

		if obj then
			local survivalBagItem = MonoHelper.getLuaComFromGo(obj, SurvivalBagItem)

			if survivalBagItem._preUid == uid then
				if itemMo:isEmpty() then
					UIBlockHelper.instance:startBlock("SurvivalShopView.onShopUpdate", 1)
					survivalBagItem:playCloseAnim()
					survivalBagItem:playSearch()
					TaskDispatcher.runDelay(self._refreshShopItems, self, 1)

					break
				end

				do
					local items = self:getShopItems()

					self._simpleRightList:setList(items)
				end

				break
			end
		end
	end
end

function SurvivalShopView:_createLeftItem(obj, data, index)
	local itemRes = self.viewContainer._viewSetting.otherRes.itemRes
	local go = gohelper.findChild(obj, "inst")

	go = go or self:getResInst(itemRes, obj, "inst")

	local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalBagItem)

	item:updateMo(data)
	item:setClickCallback(self._onLeftItemClick, self)
	item:setIsSelect(self._curSelectUid and data.uid == self._curSelectUid and self._isSelectLeft)

	local isSetRecommend = self:isShelterShop() and data:isDisasterRecommendItem(self.mapId)

	item:setRecommend(isSetRecommend)
end

function SurvivalShopView:_createRightItem(obj, data, index)
	local itemRes = self.viewContainer._viewSetting.otherRes.itemRes
	local go = gohelper.findChild(obj, "inst")

	go = go or self:getResInst(itemRes, obj, "inst")

	local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalBagItem)

	item:updateMo(data)
	item:setClickCallback(self._onRightItemClick, self)
	item:setIsSelect(self._curSelectUid and data.uid == self._curSelectUid and not self._isSelectLeft)

	if self:isShowPrice() then
		local currencyNum = self:getBagMo():getCurrencyNum(1)

		item:setShopStyle({
			isShow = not data:isEmpty(),
			price = data:getBuyPrice(),
			currencyNum = currencyNum
		})
	end

	local isSetRecommend = self:isShelterShop() and data:isDisasterRecommendItem(self.mapId)

	item:setRecommend(isSetRecommend)
end

function SurvivalShopView:_onLeftItemClick(item)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_checkpoint_resources_Click)
	self._infoPanel:updateMo(item._mo, {
		mapId = self.mapId
	})
	gohelper.setActive(self._goempty, false)

	self._curSelectUid = item._mo.uid
	self._isSelectLeft = true

	self:updateItemSelect()
end

function SurvivalShopView:_onRightItemClick(item)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_checkpoint_resources_Click)
	self._infoPanel:updateMo(item._mo, {
		mapId = self.mapId
	})
	gohelper.setActive(self._goempty, false)

	self._curSelectUid = item._mo.uid
	self._isSelectLeft = false

	self:updateItemSelect()
end

function SurvivalShopView:updateItemSelect()
	for go in pairs(self._simpleLeftList:getAllGos()) do
		local instGo = gohelper.findChild(go, "inst")
		local bagItem = MonoHelper.getLuaComFromGo(instGo, SurvivalBagItem)

		if bagItem and not bagItem._mo:isEmpty() then
			bagItem:setIsSelect(self._isSelectLeft and self._curSelectUid == bagItem._mo.uid)
		end
	end

	for go in pairs(self._simpleRightList:getAllGos()) do
		local instGo = gohelper.findChild(go, "inst")
		local bagItem = MonoHelper.getLuaComFromGo(instGo, SurvivalBagItem)

		if bagItem and not bagItem._mo:isEmpty() then
			bagItem:setIsSelect(not self._isSelectLeft and self._curSelectUid == bagItem._mo.uid)
		end
	end
end

function SurvivalShopView:_openCurrencyTips(param)
	local trans = param.btn.transform
	local scale = trans.lossyScale
	local pos = trans.position
	local width = recthelper.getWidth(trans)
	local height = recthelper.getHeight(trans)

	pos.x = pos.x - width / 2 * scale.x
	pos.y = pos.y - height / 2 * scale.y

	ViewMgr.instance:openView(ViewName.SurvivalCurrencyTipView, {
		arrow = "BR",
		id = param.id,
		pos = pos
	})
end

function SurvivalShopView:createTabListComp()
	local scrollParam = SimpleListParam.New()

	scrollParam.cellClass = SurvivalShopTab
	scrollParam.cellSpaceV = 10
	self.tabListComp = GameFacade.createSimpleListComp(self.ShopTabScroll, scrollParam, self.ShopTab, self.viewContainer)

	self.tabListComp:setOnClickItem(self.onClickTab, self)
	self.tabListComp:setOnSelectChange(self.onSelectCallBack, self)
end

function SurvivalShopView:refreshTabListComp()
	local cfgs = SurvivalConfig.instance:getShopTabConfigs()

	self.datas = {}
	self.haveTab = self._shopMo:haveTab()

	if self.haveTab then
		for i, v in ipairs(cfgs) do
			local cfg = cfgs[i]
			local tabId = cfg.id
			local items = self._shopMo:getItemsByTabId(tabId)

			if #items > 0 then
				local data = {
					cfg = cfgs[i],
					context = self
				}

				table.insert(self.datas, data)
			end
		end
	end

	self.tabListComp:setData(self.datas)
end

function SurvivalShopView:onClickTab(item)
	self.tabListComp:setSelect(item.itemIndex)
end

function SurvivalShopView:onSelectCallBack(item, selectIndex)
	if not self._isSelectLeft then
		self:cancelSelect()
	end

	self:_refreshShopItems()
	self:refreshRightTitle()
end

function SurvivalShopView:onClickLeftTab(item)
	self.leftTabListComp:setSelect(item.itemIndex)
end

function SurvivalShopView:onSelectLeftTabCallBack(item)
	self:_refreshBag()
	self:refreshTitle()
end

function SurvivalShopView:onClose()
	TaskDispatcher.cancelTask(self._refreshBag, self)
	TaskDispatcher.cancelTask(self._refreshShopItems, self)
end

return SurvivalShopView
