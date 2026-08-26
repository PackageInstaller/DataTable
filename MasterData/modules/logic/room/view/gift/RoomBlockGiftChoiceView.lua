-- chunkname: @modules/logic/room/view/gift/RoomBlockGiftChoiceView.lua

module("modules.logic.room.view.gift.RoomBlockGiftChoiceView", package.seeall)

local RoomBlockGiftChoiceView = class("RoomBlockGiftChoiceView", BaseView)

function RoomBlockGiftChoiceView:onInitView()
	self._btnnumber = gohelper.findChildButtonWithAudio(self.viewGO, "top/right/#btn_number")
	self._btnrare = gohelper.findChildButtonWithAudio(self.viewGO, "top/right/#btn_rare")
	self._btntheme = gohelper.findChildButtonWithAudio(self.viewGO, "top/right/#btn_theme")
	self._goswitch = gohelper.findChild(self.viewGO, "#go_switch")
	self._btnblock = gohelper.findChildButtonWithAudio(self.viewGO, "#go_switch/#btn_block")
	self._btnbuilding = gohelper.findChildButtonWithAudio(self.viewGO, "#go_switch/#btn_building")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirm")
	self._goconfirm = gohelper.findChild(self.viewGO, "#btn_confirm/#go_confirm")
	self._gonoconfirm = gohelper.findChild(self.viewGO, "#btn_confirm/#go_noconfirm")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_cancel")
	self._scrollblock = gohelper.findChildScrollRect(self.viewGO, "#scroll_block")
	self._scrollbuilding = gohelper.findChildScrollRect(self.viewGO, "#scroll_building")
	self._scrolltheme = gohelper.findChildScrollRect(self.viewGO, "#scroll_theme")
	self._gothemeitem = gohelper.findChild(self.viewGO, "#scroll_theme/Viewport/Content/#go_themeitem")
	self._gostyleName = gohelper.findChild(self.viewGO, "#go_styleName")
	self._goblockItem = gohelper.findChild(self.viewGO, "#go_blockItem")
	self._gobuildingItem = gohelper.findChild(self.viewGO, "#go_buildingItem")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_Tips/#txt_num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomBlockGiftChoiceView:addEvents()
	self._btnnumber:AddClickListener(self._btnnumberOnClick, self)
	self._btnrare:AddClickListener(self._btnrareOnClick, self)
	self._btntheme:AddClickListener(self._btnthemeOnClick, self)
	self._btnblock:AddClickListener(self._btnblockOnClick, self)
	self._btnbuilding:AddClickListener(self._btnbuildingOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.UIRoomThemeFilterChanged, self._onThemeFilterChanged, self)
	self.addEventCb(self, RoomBlockGiftController.instance, RoomBlockGiftEvent.OnSelect, self._onRefreshSelect, self)
	self.addEventCb(self, RoomBlockGiftController.instance, RoomBlockGiftEvent.OnSortTheme, self._onRefreshTheme, self)
	self.addEventCb(self, RoomBlockGiftController.instance, RoomBlockGiftEvent.OnStartDragItem, self._onStartDragItem, self)
	self.addEventCb(self, RoomBlockGiftController.instance, RoomBlockGiftEvent.OnDragingItem, self._onDragingItem, self)
	self.addEventCb(self, RoomBlockGiftController.instance, RoomBlockGiftEvent.OnEndDragItem, self._onEndDragItem, self)
end

function RoomBlockGiftChoiceView:removeEvents()
	self._btnnumber:RemoveClickListener()
	self._btnrare:RemoveClickListener()
	self._btntheme:RemoveClickListener()
	self._btnblock:RemoveClickListener()
	self._btnbuilding:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
	self._btncancel:RemoveClickListener()
	self.removeEventCb(self, RoomMapController.instance, RoomEvent.UIRoomThemeFilterChanged, self._onThemeFilterChanged, self)
	self.removeEventCb(self, RoomBlockGiftController.instance, RoomBlockGiftEvent.OnSelect, self._onRefreshSelect, self)
	self.removeEventCb(self, RoomBlockGiftController.instance, RoomBlockGiftEvent.OnSortTheme, self._onRefreshTheme, self)
	self.removeEventCb(self, RoomBlockGiftController.instance, RoomBlockGiftEvent.OnStartDragItem, self._onStartDragItem, self)
	self.removeEventCb(self, RoomBlockGiftController.instance, RoomBlockGiftEvent.OnDragingItem, self._onDragingItem, self)
	self.removeEventCb(self, RoomBlockGiftController.instance, RoomBlockGiftEvent.OnEndDragItem, self._onEndDragItem, self)
end

function RoomBlockGiftChoiceView:_btnnumberOnClick()
	RoomBlockBuildingGiftModel.instance:clickSortBlockNum()
	self:_refreshSortBtn()
	RoomBlockBuildingGiftModel.instance:onSort()
end

function RoomBlockGiftChoiceView:_btnrareOnClick()
	RoomBlockBuildingGiftModel.instance:clickSortBlockRare()
	self:_refreshSortBtn()
	RoomBlockBuildingGiftModel.instance:onSort()
end

function RoomBlockGiftChoiceView:_btnthemeOnClick()
	ViewMgr.instance:openView(ViewName.RoomThemeFilterView, {
		isGift = true
	})
end

function RoomBlockGiftChoiceView:_btnblockOnClick()
	self:_onClickSubTypeBtn(MaterialEnum.MaterialType.BlockPackage)
end

function RoomBlockGiftChoiceView:_btnbuildingOnClick()
	self:_onClickSubTypeBtn(MaterialEnum.MaterialType.Building)
end

function RoomBlockGiftChoiceView:_btnconfirmOnClick()
	local function callBack()
		self:closeThis()
		RoomBlockGiftController.instance:useItemCallback()
		RoomBlockBuildingGiftModel.instance:clear()
	end

	local count = RoomBlockBuildingGiftModel.instance:getSelectCount()

	if count == 0 then
		GameFacade.showToast(ToastEnum.RoomBlockNotSelect)

		return
	end

	local selectGoods = RoomBlockBuildingGiftModel.instance:getSelectGoodsData(self.itemId)

	if selectGoods then
		ItemRpc.instance:sendUseItemRequest(selectGoods.data, selectGoods.goodsId, callBack, self)
	end
end

function RoomBlockGiftChoiceView:_btncancelOnClick()
	self:closeThis()
end

function RoomBlockGiftChoiceView:_onThemeFilterChanged()
	self:_refreshThemeBtn()
	self:_refreshTheme()
end

function RoomBlockGiftChoiceView:_editableInitView()
	self._goblockselect = gohelper.findChild(self.viewGO, "#go_switch/#btn_block/go_select")
	self._goblocknormal = gohelper.findChild(self.viewGO, "#go_switch/#btn_block/go_normal")
	self._gobuildingselect = gohelper.findChild(self.viewGO, "#go_switch/#btn_building/go_select")
	self._gobuildingnormal = gohelper.findChild(self.viewGO, "#go_switch/#btn_building/go_normal")
	self._gonumselect = gohelper.findChild(self.viewGO, "top/right/#btn_number/go_select")
	self._gonumnormal = gohelper.findChild(self.viewGO, "top/right/#btn_number/go_normal")
	self._gonumselectarrow = gohelper.findChild(self.viewGO, "top/right/#btn_number/go_select/txt/go_arrow")
	self._gonumselectarrow2 = gohelper.findChild(self.viewGO, "top/right/#btn_number/go_select/txt/go_arrow2")
	self._gorareselect = gohelper.findChild(self.viewGO, "top/right/#btn_rare/go_select")
	self._gorarenormal = gohelper.findChild(self.viewGO, "top/right/#btn_rare/go_normal")
	self._gorareselectarrow = gohelper.findChild(self.viewGO, "top/right/#btn_rare/go_select/txt/go_arrow")
	self._gorareselectarrow2 = gohelper.findChild(self.viewGO, "top/right/#btn_rare/go_select/txt/go_arrow2")
	self._gothemeselect = gohelper.findChild(self.viewGO, "top/right/#btn_theme/go_select")
	self._gothemenormal = gohelper.findChild(self.viewGO, "top/right/#btn_theme/go_unselect")
	self._txtnumselect = gohelper.findChildText(self.viewGO, "top/right/#btn_number/go_select/txt")
	self._txtnumnormal = gohelper.findChildText(self.viewGO, "top/right/#btn_number/go_normal/txt")
	self._buildingScrollView = self._scrollbuilding.gameObject:GetComponent(gohelper.Type_ScrollRect)

	local buildingContentHeight = recthelper.getHeight(self._buildingScrollView.transform)

	self._dragBuildingMinY = -buildingContentHeight * 0.5 + 1
	self._dragBuildingMaxY = buildingContentHeight * 0.5 - 1
	self._themeScrollView = self._scrolltheme.gameObject:GetComponent(gohelper.Type_ScrollRect)

	local themeContentHeight = recthelper.getHeight(self._scrolltheme.transform)

	self._dragThemeMinY = -themeContentHeight * 0.5 + 1
	self._dragThemeMinMaxY = themeContentHeight * 0.5 - 1
end

function RoomBlockGiftChoiceView:onUpdateParam()
	return
end

function RoomBlockGiftChoiceView:onOpen()
	self.rare = self.viewParam.rare
	self.itemId = self.viewParam.id

	RoomBlockBuildingGiftModel.instance:onOpenView(self.rare)
	self:_refreshView()
	self:_onRefreshSelect()
end

function RoomBlockGiftChoiceView:onClickModalMask()
	self:closeThis()
end

function RoomBlockGiftChoiceView:_refreshView()
	local subType = RoomBlockBuildingGiftModel.instance:getSelectSubType()

	self:_refreshBlockBuildingBtn(subType)
	self:_refreshSortBtn()
	self:_refreshThemeBtn()
	self:_refreshTheme()
end

function RoomBlockGiftChoiceView:_refreshBlockBuildingBtn(subType)
	local isBuilding = subType == MaterialEnum.MaterialType.Building

	gohelper.setActive(self._goblockselect.gameObject, not isBuilding)
	gohelper.setActive(self._goblocknormal.gameObject, isBuilding)
	gohelper.setActive(self._gobuildingselect.gameObject, isBuilding)
	gohelper.setActive(self._gobuildingnormal.gameObject, not isBuilding)

	local isFilter = self:_isThemeFilter()

	self:_refreshModeView(isFilter, subType)

	local sortNumTxt = RoomBlockGiftEnum.SubTypeInfo[subType].NumSortTxt

	self._txtnumselect.text = luaLang(sortNumTxt)
	self._txtnumnormal.text = luaLang(sortNumTxt)
end

function RoomBlockGiftChoiceView:_refreshModeView(isFilter, subType)
	local isShowBlock = not isFilter and subType == MaterialEnum.MaterialType.BlockPackage
	local isShowBuilding = not isFilter and subType == MaterialEnum.MaterialType.Building

	gohelper.setActive(self._scrollblock.gameObject, isShowBlock)
	gohelper.setActive(self._scrollbuilding.gameObject, isShowBuilding)
	gohelper.setActive(self._scrolltheme.gameObject, isFilter)
end

function RoomBlockGiftChoiceView:_refreshSortBtn()
	local sortNumType = RoomBlockBuildingGiftModel.instance:getSortBlockNum()
	local sortRareType = RoomBlockBuildingGiftModel.instance:getSortBlockRare()

	gohelper.setActive(self._gonumselect.gameObject, sortNumType ~= RoomBlockGiftEnum.SortType.None)
	gohelper.setActive(self._gonumnormal.gameObject, sortNumType == RoomBlockGiftEnum.SortType.None)
	gohelper.setActive(self._gonumselectarrow.gameObject, sortNumType == RoomBlockGiftEnum.SortType.Order)
	gohelper.setActive(self._gonumselectarrow2.gameObject, sortNumType == RoomBlockGiftEnum.SortType.Reverse)
	gohelper.setActive(self._gorareselect.gameObject, sortRareType ~= RoomBlockGiftEnum.SortType.None)
	gohelper.setActive(self._gorarenormal.gameObject, sortRareType == RoomBlockGiftEnum.SortType.None)
	gohelper.setActive(self._gorareselectarrow.gameObject, sortRareType == RoomBlockGiftEnum.SortType.Order)
	gohelper.setActive(self._gorareselectarrow2.gameObject, sortRareType == RoomBlockGiftEnum.SortType.Reverse)
end

function RoomBlockGiftChoiceView:_refreshThemeBtn()
	local isFilter = self:_isThemeFilter()

	gohelper.setActive(self._gothemeselect.gameObject, isFilter)
	gohelper.setActive(self._gothemenormal.gameObject, not isFilter)
end

function RoomBlockGiftChoiceView:_isThemeFilter()
	return RoomThemeFilterListModel.instance:getSelectCount() > 0
end

function RoomBlockGiftChoiceView:_onClickSubTypeBtn(subType)
	if RoomBlockBuildingGiftModel.instance:getSelectSubType() == subType then
		return
	end

	RoomBlockBuildingGiftModel.instance:openSubType(subType)
	self:_refreshTheme()
	RoomBlockBuildingGiftModel.instance:setThemeList()
	self:_refreshBlockBuildingBtn(subType)
end

function RoomBlockGiftChoiceView:_getThemeItem(index)
	self._themeItems = self._themeItems or self:getUserDataTb_()

	local item = self._themeItems[index]

	if not item then
		local go = gohelper.cloneInPlace(self._gothemeitem)
		local clonneGos = {
			gotitle = self._gostyleName,
			goBlockItem = self._goblockItem,
			goBuildingItem = self._gobuildingItem
		}

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoomBlockGiftThemeItem, clonneGos)
		self._themeItems[index] = item
	end

	return item
end

function RoomBlockGiftChoiceView:_onRefreshSelect()
	local count = RoomBlockBuildingGiftModel.instance:getSelectCount()
	local total = RoomBlockBuildingGiftModel.instance:getMaxSelectCount()
	local format = count == total and "roomblockgift_colloctcount2" or "roomblockgift_colloctcount1"
	local countStr = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang(format), count, total)

	self._txtnum.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("roomblockgift_select"), countStr)

	gohelper.setActive(self._goconfirm.gameObject, count > 0)
	gohelper.setActive(self._gonoconfirm.gameObject, count == 0)
end

function RoomBlockGiftChoiceView:_refreshTheme()
	local isFilter = self:_isThemeFilter()
	local subType = RoomBlockBuildingGiftModel.instance:getSelectSubType()

	if isFilter then
		local modelInst = RoomBlockBuildingGiftModel.instance:getSubTypeListModelInstance(subType)

		modelInst:setThemeMoList()
		self:_onRefreshTheme()
	end

	self:_refreshThemeBtn()
	self:_refreshModeView(isFilter, subType)
end

function RoomBlockGiftChoiceView:_onRefreshTheme()
	local subType = RoomBlockBuildingGiftModel.instance:getSelectSubType()
	local modelInst = RoomBlockBuildingGiftModel.instance:getSubTypeListModelInstance(subType)
	local moList = modelInst:getThemeMoList()

	if not moList or not self:_isThemeFilter() then
		return
	end

	local count = 0

	for i, mo in ipairs(moList) do
		local item = self:_getThemeItem(i)

		item:onUpdateMO(mo, subType)

		count = count + 1
	end

	for i = 1, #self._themeItems do
		local item = self._themeItems[i]

		item:setActive(i <= count)
	end
end

function RoomBlockGiftChoiceView:_onStartDragItem(pointerEventData)
	local subType = RoomBlockBuildingGiftModel.instance:getSelectSubType()

	if not subType then
		return
	end

	self._canDrag = true

	local isFilter = self:_isThemeFilter()

	if isFilter then
		self._themeScrollView:OnBeginDrag(pointerEventData)
	else
		self._buildingScrollView:OnBeginDrag(pointerEventData)
	end
end

function RoomBlockGiftChoiceView:_onDragingItem(pointerEventData)
	if not self._canDrag then
		return
	end

	local subType = RoomBlockBuildingGiftModel.instance:getSelectSubType()

	if not subType then
		return
	end

	local isFilter = self:_isThemeFilter()

	if isFilter then
		local anchorPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self._themeScrollView.transform)
		local posY = anchorPos.y

		if posY > self._dragThemeMinY and posY < self._dragThemeMinMaxY then
			self._themeScrollView:OnDrag(pointerEventData)
		end
	else
		local anchorPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self._buildingScrollView.transform)
		local posY = anchorPos.y

		if posY > self._dragBuildingMinY and posY < self._dragBuildingMaxY then
			self._buildingScrollView:OnDrag(pointerEventData)
		end
	end
end

function RoomBlockGiftChoiceView:_onEndDragItem(pointerEventData)
	local subType = RoomBlockBuildingGiftModel.instance:getSelectSubType()

	self._canDrag = false

	if not subType then
		return
	end

	local isFilter = self:_isThemeFilter()

	if isFilter then
		self._themeScrollView:OnEndDrag(pointerEventData)
	else
		self._buildingScrollView:OnEndDrag(pointerEventData)
	end
end

function RoomBlockGiftChoiceView:onClose()
	RoomBlockBuildingGiftModel.instance:onCloseView()

	self._canDrag = false
end

function RoomBlockGiftChoiceView:onDestroyView()
	return
end

return RoomBlockGiftChoiceView
