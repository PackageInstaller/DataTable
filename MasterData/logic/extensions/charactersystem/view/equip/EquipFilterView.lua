-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipFilterView.lua

module("logic.extensions.charactersystem.view.equip.EquipFilterView", package.seeall)

local M = class("EquipFilterView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self.defaultSortType = CommEnum.MainBackpackSortType.Level
end

function M:buildUI()
	self._filterRoot = self:getGo("4&common_filter_-55329758")
	self._btnMask = Astral.ButtonAdapter.Get(goutil.findChild(self._filterRoot, "click"))

	goutil.setActive(self._btnMask.gameObject, false)

	self._btnFilter = self:getBtn("18&com_btn_2_-31477526")
	self._suitCanvas = self._btnFilter.gameObject:GetComponent(ComponentType.CanvasGroup)
	self._goFilterView = self:getGo("d6_filter_tips_470721785")
	self._equipFilterComponent = Astral.LuaComponentContainer.Add(self._goFilterView, EquipFilterComponent)
	self._txtFilter = goutil.findChildTextComponent(self._btnFilter.gameObject, "Text")
	self._btnSort = self:getBtn("4&common_filter_-1115847681")
	self._sortCanvas = self._btnSort.gameObject:GetComponent(ComponentType.CanvasGroup)
	self._sortText = self:getText("4&common_filter_-250765097")
	self._sortItemsParent = goutil.findChild(self._btnSort.gameObject, "Template")
	self._sortUpGo = goutil.findChild(self._btnSort.gameObject, "content/up")
	self._sortDownGo = goutil.findChild(self._btnSort.gameObject, "content/down")
	self._sortItems = {}
	self._sortItemTemp = goutil.findChild(self._sortItemsParent, "Content/Item1")

	goutil.setActive(self._sortItemTemp, false)

	local itemsParent = goutil.findChild(self._sortItemsParent, "Content")

	for i = 1, 3 do
		local sortItem = goutil.clone(self._sortItemTemp)

		goutil.setActive(sortItem, true)
		goutil.addChildToParent(sortItem, itemsParent)

		local itemView = Astral.LuaComponentContainer.Add(sortItem, BackpackSortItemNew)

		itemView:setData(BackpackItemSortData.New(i, false))
		itemView:setEvent(EventType.EQUIP_WEARING_SORT_ITEM_CLICK)
		table.insert(self._sortItems, itemView)

		if i == self.defaultSortType then
			itemView:setSelect(true)

			self._sortMo = itemView:getData()
		else
			itemView:setSelect(false)
		end
	end

	goutil.setActive(self._sortItemsParent, false)
end

function M:bindEvents()
	self._btnFilter:AddClickListener(self._onClickFilterBtn, self)
	self._btnSort:AddClickListener(self._onClickSortBtn, self)
	self._btnMask:AddClickListener(self._onClickMaskBtn, self)
	self._equipFilterComponent:bindEvents()
	GlobalDispatcher:addEventListener(EventType.EQUIP_REFREH_FILTER_EMPTY, self._handleRefreshEmpty, self)
end

function M:unbindEvents()
	self._btnFilter:RemoveClickListener()
	self._btnSort:RemoveClickListener()
	self._btnMask:RemoveClickListener()
	self._equipFilterComponent:unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.EQUIP_REFREH_FILTER_EMPTY, self._handleRefreshEmpty, self)
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.EQUIP_WEARING_SORT_ITEM_CLICK, self._onClickSortItem, self)
		GlobalDispatcher:addEventListener(EventType.EQUIP_WEARING_FILTER_CLICK_EVENT, self._handleEquipFilter, self)
	else
		GlobalDispatcher:removeEventListener(EventType.EQUIP_WEARING_SORT_ITEM_CLICK, self._onClickSortItem, self)
		GlobalDispatcher:removeEventListener(EventType.EQUIP_WEARING_FILTER_CLICK_EVENT, self._handleEquipFilter, self)
	end
end

function M:onEnter()
	self:_setEvent(true)
	self._equipFilterComponent:onEnter()
	self:_refreshSort()
	self:_updateFilterText()
end

function M:onExit()
	self:_setEvent(false)
	self._equipFilterComponent:onExit()

	self._filterEquipSuitData = nil
	self._filterEquipDices = {}
end

function M:destroyUI()
	return
end

function M:getSortMo()
	return self._sortMo
end

function M:_onClickSortBtn()
	if self._isEmpty then
		return
	end

	local suitActive = self._goFilterView.activeSelf

	if suitActive then
		goutil.setActive(self._goFilterView, false)
		goutil.setActive(self._btnMask.gameObject, false)

		return
	end

	local active = not self._sortItemsParent.activeSelf

	goutil.setActive(self._sortItemsParent, active)
	goutil.setActive(self._btnMask.gameObject, active)
end

function M:_onClickMaskBtn()
	goutil.setActive(self._btnMask.gameObject, false)
	goutil.setActive(self._goFilterView, false)
	goutil.setActive(self._sortItemsParent, false)
end

function M:_onClickFilterBtn()
	if self._isEmpty then
		return
	end

	local sortActive = self._sortItemsParent.activeSelf

	if sortActive then
		goutil.setActive(self._sortItemsParent, false)
		goutil.setActive(self._btnMask.gameObject, false)

		return
	end

	local active = not self._isEmpty and not self._goFilterView.activeSelf

	if active then
		EquipSuitModel.instance:updateSuitNum()

		local suitListData = EquipController.instance:getAllSuitList()
		local diceListData = EquipController.instance:getDiceList()

		self._equipFilterComponent:setData(suitListData, diceListData, 0, self._filterEquipSuitData, self._filterEquipDices)
	end

	goutil.setActive(self._btnMask.gameObject, active)
	goutil.setActive(self._goFilterView, active)
end

function M:_refreshSort()
	if self._sortMo then
		self._sortText.text = self._sortMo:getName()

		local isUp = self._sortMo.isUp

		goutil.setActive(self._sortUpGo, isUp)
		goutil.setActive(self._sortDownGo, not isUp)

		for key, item in ipairs(self._sortItems) do
			local sortType = item:getData().sortType

			item:setSelect(sortType == self._sortMo.sortType)
		end
	end
end

function M:_onClickSortItem(e, BackpackItemSortData)
	if not BackpackItemSortData then
		printError("排序数据为空，请检查")

		return
	end

	self._sortMo = BackpackItemSortData

	self:_refreshSort()
end

function M:_handleRefreshEmpty(e, isEmpty)
	self._isEmpty = false

	if self._suitCanvas then
		self._suitCanvas.alpha = isEmpty and 0.2 or 1
	end

	if self._sortCanvas then
		self._sortCanvas.alpha = isEmpty and 0.2 or 1
	end
end

function M:_handleEquipFilter(e, equipSuitData, dices)
	self._filterEquipSuitData = equipSuitData
	self._filterEquipDices = dices or {}

	self:_updateFilterText()
end

function M:_updateFilterText()
	if self._filterEquipSuitData or TableUtil.getLen(self._filterEquipDices) > 0 then
		self._txtFilter.text = lang("tip_filter_btn_name_filter")
	else
		self._txtFilter.text = lang("tip_filter_btn_name_unfilter")
	end
end

return M
