-- chunkname: @modules/logic/room/view/building/RoomFormulaView.lua

module("modules.logic.room.view.building.RoomFormulaView", package.seeall)

local RoomFormulaView = class("RoomFormulaView", BaseView)
local BTN_LIST_HIGHLIGHT_COLOR = "#FF7C40"
local BTN_LIST_DISABLE_COLOR = "#787878"

function RoomFormulaView:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "view/bg/#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "view/bg/#simage_bg2")
	self._scrollcategory = gohelper.findChildScrollRect(self.viewGO, "view/#scroll_category")
	self._goshowtypeitem = gohelper.findChild(self.viewGO, "view/#scroll_category/viewport/content/#go_showtypeitem")
	self._scrollformula = gohelper.findChildScrollRect(self.viewGO, "view/#scroll_formula")
	self._scrollRectFormula = self._scrollformula:GetComponent(typeof(ZProj.LimitedScrollRect))
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "view/#btn_close")
	self._btnquality = gohelper.findChildButtonWithAudio(self.viewGO, "view/sortBtn/#btn_quality")
	self._btnconsumetime = gohelper.findChildButtonWithAudio(self.viewGO, "view/sortBtn/#btn_consumetime")
	self._btnorder = gohelper.findChildButtonWithAudio(self.viewGO, "view/sortBtn/#btn_order")
	self._btnList = gohelper.findChildButtonWithAudio(self.viewGO, "view/ListBtn")
	self._imageBtnList = gohelper.findChildImage(self.viewGO, "view/ListBtn/image_ListBtn")
	self._goNeed = gohelper.findChild(self.viewGO, "view/#go_NeedProp")
	self._txtNeed = gohelper.findChildText(self.viewGO, "view/#go_NeedProp/#txt_NeedProp")
	self._btnNeedClick = gohelper.findChildButtonWithAudio(self.viewGO, "view/#go_NeedProp/btnClick")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomFormulaView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnquality:AddClickListener(self._btnqualityOnClick, self)
	self._btnconsumetime:AddClickListener(self._btnconsumetimeOnClick, self)
	self._btnorder:AddClickListener(self._btnorderOnClick, self)
	self._btnList:AddClickListener(self._btnListOnClick, self)
	self._btnNeedClick:AddClickListener(self._btnNeedOnClick, self)
	self.addEventCb(self, RoomBuildingController.instance, RoomEvent.NewFormulaPush, self._newFormulaPush, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, RoomController.instance, RoomEvent.ProduceLineLevelUp, self._onProduceLineLevelUp, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.SelectFormulaIdChanged, self._onSelectFormulaIdChanged, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.RefreshNeedFormula, self._onNeedFormulaRefresh, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._refreshNeedText, self)
	gohelper.addUIClickAudio(self._btnList.gameObject, AudioEnum.UI.play_ui_screenplay_photo_click)
end

function RoomFormulaView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnquality:RemoveClickListener()
	self._btnconsumetime:RemoveClickListener()
	self._btnorder:RemoveClickListener()
	self._btnList:RemoveClickListener()
	self._btnNeedClick:RemoveClickListener()
	self.removeEventCb(self, RoomBuildingController.instance, RoomEvent.NewFormulaPush, self._newFormulaPush, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.removeEventCb(self, RoomController.instance, RoomEvent.ProduceLineLevelUp, self._onProduceLineLevelUp, self)
	self.removeEventCb(self, RoomMapController.instance, RoomEvent.SelectFormulaIdChanged, self._onSelectFormulaIdChanged, self)
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._refreshNeedText, self)
end

function RoomFormulaView:_btncloseOnClick()
	self:closeThis()
	RoomFormulaListModel.instance:changeSelectFormulaToTopLevel()
	RoomMapController.instance:dispatchEvent(RoomEvent.ShowInitBuildingChangeTitle)
end

function RoomFormulaView:_btnqualityOnClick()
	local order = RoomFormulaListModel.instance:getOrder()

	if order == RoomBuildingEnum.FormulaOrderType.RareDown then
		RoomFormulaListModel.instance:setOrder(RoomBuildingEnum.FormulaOrderType.RareUp)
	else
		RoomFormulaListModel.instance:setOrder(RoomBuildingEnum.FormulaOrderType.RareDown)
	end

	RoomFormulaListModel.instance:changeSelectFormulaToTopLevel()
	RoomFormulaListModel.instance:setFormulaList(self._lineMO.level)
	self:_refreshOrderSelect()
end

function RoomFormulaView:_btnconsumetimeOnClick()
	local order = RoomFormulaListModel.instance:getOrder()

	if order == RoomBuildingEnum.FormulaOrderType.CostTimeDown then
		RoomFormulaListModel.instance:setOrder(RoomBuildingEnum.FormulaOrderType.CostTimeUp)
	else
		RoomFormulaListModel.instance:setOrder(RoomBuildingEnum.FormulaOrderType.CostTimeDown)
	end

	RoomFormulaListModel.instance:changeSelectFormulaToTopLevel()
	RoomFormulaListModel.instance:setFormulaList(self._lineMO.level)
	self:_refreshOrderSelect()
end

function RoomFormulaView:_btnorderOnClick()
	local order = RoomFormulaListModel.instance:getOrder()

	if order == RoomBuildingEnum.FormulaOrderType.OrderDown then
		RoomFormulaListModel.instance:setOrder(RoomBuildingEnum.FormulaOrderType.OrderUp)
	else
		RoomFormulaListModel.instance:setOrder(RoomBuildingEnum.FormulaOrderType.OrderDown)
	end

	RoomFormulaListModel.instance:changeSelectFormulaToTopLevel()
	RoomFormulaListModel.instance:setFormulaList(self._lineMO.level)
	self:_refreshOrderSelect()
end

function RoomFormulaView:_btnclickOnClick(index)
	if self._selectIndex == index then
		return
	end

	local showTypeItem = self._showTypeItemList[index]

	if not showTypeItem then
		return
	end

	if showTypeItem.unlockLevel > self._lineMO.level then
		GameFacade.showToast(ToastEnum.MaterialItemLockOnClick, self._lineMO.config.name, showTypeItem.unlockLevel)

		return
	end

	self._selectIndex = index

	AudioMgr.instance:trigger(AudioEnum.UI.UI_vertical_first_tabs_click)
	RoomFormulaListModel.instance:changeSelectFormulaToTopLevel()
	self:_refreshShowTypeSelect()
	self:focusPos()
end

function RoomFormulaView:_btnListOnClick()
	local newIsInList = not RoomFormulaListModel.instance:getIsInList()

	RoomFormulaListModel.instance:setIsInList(newIsInList)

	self._imageBtnList.color = newIsInList and GameUtil.parseColor(BTN_LIST_HIGHLIGHT_COLOR) or GameUtil.parseColor(BTN_LIST_DISABLE_COLOR)

	RoomFormulaListModel.instance:changeSelectFormulaToTopLevel()
	RoomFormulaListModel.instance:setFormulaList(self._lineMO.level)
	self:focusPos()
end

function RoomFormulaView:_btnNeedOnClick()
	if self._needFormulaShowType then
		for _, showTypeItem in ipairs(self._showTypeItemList) do
			local isUnlock = showTypeItem.unlockLevel <= self._lineMO.level

			if isUnlock and showTypeItem.formulaShowType == self._needFormulaShowType and self._selectIndex ~= showTypeItem.index then
				self._selectIndex = showTypeItem.index

				RoomFormulaListModel.instance:changeSelectFormulaToTopLevel()
				self:_refreshShowTypeSelect()
			end
		end
	end

	self._scrollRectFormula.velocity = Vector2(0, 0)

	if self._needFormulaStrId then
		local selectFormulaStrId = RoomFormulaListModel.instance:getSelectFormulaStrId()

		if self._needFormulaStrId ~= selectFormulaStrId then
			RoomBuildingFormulaController.instance:setSelectFormulaStrId(self._needFormulaStrId)
		end

		self:focusPos()
	end
end

function RoomFormulaView:_onEscapeBtnClick()
	if self.viewParam and self.viewParam.openInOutside then
		ViewMgr.instance:closeView(ViewName.RoomInitBuildingView, true)
	else
		self:_btncloseOnClick()
	end
end

function RoomFormulaView:_onCloseView(viewName)
	if viewName == ViewName.RoomInitBuildingView then
		ViewMgr.instance:closeView(self.viewName, true, true)
	end
end

function RoomFormulaView:_onProduceLineLevelUp()
	self:_refreshUI()
end

function RoomFormulaView:_newFormulaPush()
	RoomFormulaListModel.instance:setFormulaList(self._lineMO.level)

	self._scrollformula.verticalNormalizedPosition = 1
end

function RoomFormulaView:_onSelectFormulaIdChanged(preFormulaStrId, isCollapse)
	local selectFormulaStrId = RoomFormulaListModel.instance:getSelectFormulaStrId()
	local isInList = RoomFormulaListModel.instance:getIsInList()

	if not isInList then
		return
	end

	local isFocus = false

	if not string.nilorempty(selectFormulaStrId) then
		if preFormulaStrId then
			local selectFormulaMo = RoomFormulaListModel.instance:getSelectFormulaMo()

			if selectFormulaMo then
				local selectFormulaTreeLevel = selectFormulaMo:getFormulaTreeLevel()
				local selectFormulaIsExpand = selectFormulaMo:getIsExpandTree()

				isFocus = selectFormulaTreeLevel == RoomFormulaModel.DEFAULT_TREE_LEVEL and not selectFormulaIsExpand
			end
		else
			isFocus = true
		end
	end

	local isDelay = RoomFormulaListModel.instance:expandOrHideTreeFormulaList(preFormulaStrId, isCollapse)

	if isFocus then
		if isDelay then
			TaskDispatcher.runDelay(self.focusPos, self, RoomFormulaListModel.ANIMATION_WAIT_TIME)
		else
			self:focusPos()
		end
	end
end

function RoomFormulaView:_onNeedFormulaRefresh()
	self._needFormulaShowType, self._needFormulaStrId = RoomProductionHelper.getNeedFormulaShowTypeAndFormulaStrId(self._lineMO)

	self:_refreshNeedText()
	self:_btnNeedOnClick()
end

function RoomFormulaView:focusPos()
	if not self.viewportHeight or not self.viewportCapacity or not self.viewContainer or gohelper.isNil(self._scrollcontent) then
		return
	end

	local index = RoomFormulaListModel.instance:getSelectFormulaStrIdIndex()
	local totalCount = RoomFormulaListModel.instance:getCount()

	if index > 0 and totalCount > self.viewportCapacity then
		local padding = 0

		if totalCount - index < self.viewportCapacity - 1 then
			padding = self.viewportCapacity * self.viewContainer.cellHeightSize - self.viewportHeight
			index = totalCount - self.viewportCapacity + 1
		end

		local posY = (index - 1) * self.viewContainer.cellHeightSize + padding

		recthelper.setAnchorY(self._scrollcontent.transform, posY)

		local csListView = self.viewContainer:getCsListScroll()

		csListView:UpdateCells(false)
	end
end

function RoomFormulaView:_editableInitView()
	self._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_2"))

	self._scrollcontent = gohelper.findChild(self._scrollformula.gameObject, "viewport/content")
	self._scrollViewport = gohelper.findChild(self._scrollformula.gameObject, "viewport")
	self._scrollHeight = recthelper.getHeight(self._scrollformula.transform)
	self._goNeedHeight = recthelper.getHeight(self._goNeed.transform)

	gohelper.setActive(self._btnconsumetime.gameObject, false)

	self._showTypeItemList = {}

	gohelper.setActive(self._goshowtypeitem, false)

	self._rareItem = self:getUserDataTb_()
	self._costTimeItem = self:getUserDataTb_()
	self._orderItem = self:getUserDataTb_()
	self._rareItem.go = self._btnquality.gameObject
	self._costTimeItem.go = self._btnconsumetime.gameObject
	self._orderItem.go = self._btnorder.gameObject

	self:_initSortItem(self._rareItem)
	self:_initSortItem(self._costTimeItem)
	self:_initSortItem(self._orderItem)
	RoomFormulaListModel.instance:resetIsInList()
	gohelper.addUIClickAudio(self._btnquality.gameObject, AudioEnum.UI.UI_vertical_second_tabs_click)
	gohelper.addUIClickAudio(self._btnconsumetime.gameObject, AudioEnum.UI.UI_vertical_second_tabs_click)
	gohelper.addUIClickAudio(self._btnorder.gameObject, AudioEnum.UI.UI_vertical_second_tabs_click)
	gohelper.removeUIClickAudio(self._btnclose.gameObject)
end

function RoomFormulaView:_initSortItem(sortItem)
	sortItem.gounselect = gohelper.findChild(sortItem.go, "btn1")
	sortItem.goselect = gohelper.findChild(sortItem.go, "btn2")
	sortItem.selectArrow = gohelper.findChild(sortItem.go, "btn2/txt/arrow")
	sortItem.unselectArrow = gohelper.findChild(sortItem.go, "btn1/txt/arrow")
end

function RoomFormulaView:onOpen()
	self._lineMO = self.viewParam.lineMO
	self._buildingType = self.viewParam.buildingType
	self._needFormulaShowType = nil
	self._needFormulaStrId = nil
	self._needFormulaShowType, self._needFormulaStrId = RoomProductionHelper.getNeedFormulaShowTypeAndFormulaStrId(self._lineMO)

	if self.viewParam.openInOutside then
		gohelper.setActive(self._btnclose.gameObject, false)
		PostProcessingMgr.instance:setViewBlur(self.viewName, 1)
	else
		PostProcessingMgr.instance:setViewBlur(self.viewName, 2)
		gohelper.setActive(self._btnclose.gameObject, true)
	end

	NavigateMgr.instance:addEscape(ViewName.RoomFormulaView, self._onEscapeBtnClick, self)
	RoomFormulaListModel.instance:setOrder(RoomBuildingEnum.FormulaOrderType.RareDown)
	self:_refreshUI()
end

function RoomFormulaView:onUpdateParam()
	self._lineMO = self.viewParam.lineMO
	self._buildingType = self.viewParam.buildingType

	RoomFormulaListModel.instance:setOrder(RoomBuildingEnum.FormulaOrderType.RareDown)
	self:_refreshUI()
end

function RoomFormulaView:_refreshUI()
	self:_refreshShowType()
	self:_refreshOrderSelect()
	self:_refreshNeedText()
	TaskDispatcher.runDelay(self._refreshScrollContent, self, 0.01)

	if self._needFormulaStrId then
		RoomBuildingFormulaController.instance:setSelectFormulaStrId(self._needFormulaStrId, true)
		self:focusPos()
	end
end

function RoomFormulaView:_refreshShowType()
	self._selectIndex = nil

	local showTypeList = {}

	for _, showTypeConfig in ipairs(lua_formula_showtype.configList) do
		if showTypeConfig.buildingType == self._buildingType then
			table.insert(showTypeList, showTypeConfig)
		end
	end

	table.sort(showTypeList, function(x, y)
		local xUnlock = RoomFormulaModel.instance:getTopTreeLevelFormulaCount(x.id) > 0
		local yUnlock = RoomFormulaModel.instance:getTopTreeLevelFormulaCount(y.id) > 0

		if xUnlock and not yUnlock then
			return true
		elseif yUnlock and not xUnlock then
			return false
		else
			return x.id < y.id
		end
	end)

	for i, showTypeConfig in ipairs(showTypeList) do
		local showTypeItem = self._showTypeItemList[i]

		if not showTypeItem then
			showTypeItem = self:getUserDataTb_()
			showTypeItem.index = i
			showTypeItem.go = gohelper.cloneInPlace(self._goshowtypeitem, "showtypeitem" .. i)
			showTypeItem.goselect = gohelper.findChild(showTypeItem.go, "go_select")
			showTypeItem.goitem = gohelper.findChild(showTypeItem.go, "go_item")
			showTypeItem.goline = gohelper.findChild(showTypeItem.go, "go_item/go_line")
			showTypeItem.gofirstline = gohelper.findChild(showTypeItem.go, "go_item/go_firstline")
			showTypeItem.golock = gohelper.findChild(showTypeItem.go, "go_lock")
			showTypeItem.imageicon = gohelper.findChildImage(showTypeItem.go, "go_item/image_recipe")
			showTypeItem.txtname = gohelper.findChildText(showTypeItem.go, "go_item/txt_recipeName")
			showTypeItem.txtnameEn = gohelper.findChildText(showTypeItem.go, "go_item/txt_recipeName/txt_recipeNameEn")
			showTypeItem.btnclick = gohelper.findChildButton(showTypeItem.go, "btn_click")

			showTypeItem.btnclick:AddClickListener(self._btnclickOnClick, self, showTypeItem.index)
			table.insert(self._showTypeItemList, showTypeItem)
		end

		showTypeItem.formulaShowType = showTypeConfig.id
		showTypeItem.unlockLevel = RoomProductionHelper.isFormulaShowTypeUnlock(showTypeItem.formulaShowType)

		local isUnlock = showTypeItem.unlockLevel <= self._lineMO.level

		if isUnlock and (not self._selectIndex or (self._needFormulaShowType or nil) and showTypeItem.formulaShowType == self._needFormulaShowType) then
			self._selectIndex = showTypeItem.index
		end

		showTypeItem.goitem:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = showTypeItem.unlockLevel <= self._lineMO.level and 1 or 0.3

		gohelper.setActive(showTypeItem.golock, showTypeItem.unlockLevel > self._lineMO.level)
		ZProj.UGUIHelper.SetColorAlpha(showTypeItem.imageicon, showTypeItem.unlockLevel > self._lineMO.level and 0.5 or 1)
		ZProj.UGUIHelper.SetColorAlpha(showTypeItem.txtname, showTypeItem.unlockLevel > self._lineMO.level and 0.5 or 1)

		showTypeItem.txtname.text = showTypeConfig.name
		showTypeItem.txtnameEn.text = showTypeConfig.nameEn

		UISpriteSetMgr.instance:setRoomSprite(showTypeItem.imageicon, "formulate_" .. showTypeConfig.icon)
		gohelper.setActive(showTypeItem.go, true)
	end

	for i = #showTypeList + 1, #self._showTypeItemList do
		local showTypeItem = self._showTypeItemList[i]

		gohelper.setActive(showTypeItem.go, false)
	end

	self._scrollcategory.verticalNormalizedPosition = 1

	self:_refreshShowTypeSelect()
end

function RoomFormulaView:_refreshShowTypeSelect()
	for i, showTypeItem in ipairs(self._showTypeItemList) do
		gohelper.setActive(showTypeItem.goselect, showTypeItem.index == self._selectIndex)
		gohelper.setActive(showTypeItem.gofirstline, showTypeItem.index ~= self._selectIndex and i == 1)
		gohelper.setActive(self._showTypeItemList[self._selectIndex].goline, showTypeItem.index ~= self._selectIndex)

		if self._selectIndex > 1 then
			gohelper.setActive(self._showTypeItemList[self._selectIndex - 1].goline, showTypeItem.index ~= self._selectIndex)
		end

		SLFramework.UGUI.GuiHelper.SetColor(showTypeItem.txtname, showTypeItem.index == self._selectIndex and "E99B56" or "#CAC8C5")
		SLFramework.UGUI.GuiHelper.SetColor(showTypeItem.txtnameEn, showTypeItem.index == self._selectIndex and "E99B56" or "#CAC8C5")
	end

	if self._selectIndex then
		local showTypeItem = self._showTypeItemList[self._selectIndex]

		if showTypeItem and showTypeItem.unlockLevel <= self._lineMO.level then
			RoomFormulaListModel.instance:setFormulaShowType(showTypeItem.formulaShowType)
		else
			RoomFormulaListModel.instance:setFormulaShowType(nil)
		end
	else
		RoomFormulaListModel.instance:setFormulaShowType(nil)
	end

	RoomFormulaListModel.instance:setFormulaList(self._lineMO.level)

	self._scrollformula.verticalNormalizedPosition = 1

	self:_refreshScrollContent()
end

function RoomFormulaView:_refreshOrderSelect()
	local order = RoomFormulaListModel.instance:getOrder()

	if order == RoomBuildingEnum.FormulaOrderType.RareUp then
		self:_setSortItemUp(self._rareItem)
	elseif order == RoomBuildingEnum.FormulaOrderType.RareDown then
		self:_setSortItemDown(self._rareItem)
	else
		self:_setSortItemDefault(self._rareItem)
	end

	if order == RoomBuildingEnum.FormulaOrderType.CostTimeUp then
		self:_setSortItemUp(self._costTimeItem)
	elseif order == RoomBuildingEnum.FormulaOrderType.CostTimeDown then
		self:_setSortItemDown(self._costTimeItem)
	else
		self:_setSortItemDefault(self._costTimeItem)
	end

	if order == RoomBuildingEnum.FormulaOrderType.OrderUp then
		self:_setSortItemUp(self._orderItem)
	elseif order == RoomBuildingEnum.FormulaOrderType.OrderDown then
		self:_setSortItemDown(self._orderItem)
	else
		self:_setSortItemDefault(self._orderItem)
	end
end

function RoomFormulaView:_setSortItemDefault(sortItem)
	gohelper.setActive(sortItem.gounselect, true)
	gohelper.setActive(sortItem.goselect, false)
end

function RoomFormulaView:_setSortItemDown(sortItem)
	gohelper.setActive(sortItem.gounselect, false)
	gohelper.setActive(sortItem.goselect, true)

	local scaleX, scaleY, scaleZ = transformhelper.getLocalScale(sortItem.selectArrow.transform)

	transformhelper.setLocalScale(sortItem.selectArrow.transform, scaleX, math.abs(scaleY), scaleZ)
	transformhelper.setLocalScale(sortItem.unselectArrow.transform, scaleX, math.abs(scaleY), scaleZ)
end

function RoomFormulaView:_setSortItemUp(sortItem)
	gohelper.setActive(sortItem.gounselect, false)
	gohelper.setActive(sortItem.goselect, true)

	local scaleX, scaleY, scaleZ = transformhelper.getLocalScale(sortItem.selectArrow.transform)

	transformhelper.setLocalScale(sortItem.selectArrow.transform, scaleX, -math.abs(scaleY), scaleZ)
	transformhelper.setLocalScale(sortItem.unselectArrow.transform, scaleX, -math.abs(scaleY), scaleZ)
end

function RoomFormulaView:_refreshNeedText()
	local isShowNeed = false
	local recordFarmItem = JumpModel.instance:getRecordFarmItem()

	if recordFarmItem then
		isShowNeed = true

		local config = ItemModel.instance:getItemConfig(recordFarmItem.type, recordFarmItem.id)
		local quantity = ItemModel.instance:getItemQuantity(recordFarmItem.type, recordFarmItem.id)
		local strShowQuantity = ""

		if recordFarmItem.quantity and recordFarmItem.quantity ~= 0 then
			local strQuantity = GameUtil.numberDisplay(quantity)
			local strRecordFarmItemQuantity = GameUtil.numberDisplay(recordFarmItem.quantity)

			strShowQuantity = string.format("<color=%s>%s</color>/%s", (quantity >= recordFarmItem.quantity or nil) and "#81ce83", strQuantity, strRecordFarmItemQuantity)
		end

		local tag = {
			config.name,
			strShowQuantity
		}

		self._txtNeed.text = GameUtil.getSubPlaceholderLuaLang(luaLang("room_formula_need_desc"), tag)

		local preferredWidth = self._txtNeed.preferredWidth

		recthelper.setWidth(self._btnNeedClick.transform, preferredWidth)
	end

	recthelper.setHeight(self._scrollformula.transform, (isShowNeed or nil) and self._scrollHeight - self._goNeedHeight)
	gohelper.setActive(self._goNeed, isShowNeed)

	self.viewportHeight = recthelper.getHeight(self._scrollViewport.transform)
	self.viewportCapacity = math.ceil(self.viewportHeight / self.viewContainer.cellHeightSize)
end

function RoomFormulaView:_refreshScrollContent()
	if not self._scrollHeight or gohelper.isNil(self._scrollcontent) then
		return
	end

	ZProj.UGUIHelper.RebuildLayout(self._scrollcontent.transform)

	local contentHeight = recthelper.getHeight(self._scrollcontent.transform)

	self._couldScroll = contentHeight > self._scrollHeight
end

function RoomFormulaView:onClose()
	TaskDispatcher.cancelTask(self.focusPos, self)
	TaskDispatcher.cancelTask(self._refreshScrollContent, self)

	if self.viewContainer:isManualClose() then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	end
end

function RoomFormulaView:onDestroyView()
	self._simagebg1:UnLoadImage()
	self._simagebg2:UnLoadImage()

	for i, showTypeItem in ipairs(self._showTypeItemList) do
		showTypeItem.btnclick:RemoveClickListener()
	end

	RoomFormulaListModel.instance:resetIsInList()
end

return RoomFormulaView
