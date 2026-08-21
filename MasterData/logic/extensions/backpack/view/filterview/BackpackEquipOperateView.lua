-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/filterview/BackpackEquipOperateView.lua

module("logic.extensions.backpack.view.filterview.BackpackEquipOperateView", package.seeall)

local M = class("BackpackEquipOperateView", EquipFilterView)

function M:buildUI()
	self._rootGo = self:getGo("backpack_view_copy_-1685166899")
	self._btnMask = self:getBtn("backpack_view_copy_-861743299")

	goutil.setActive(self._btnMask.gameObject, false)

	self._btnFilter = self:getBtn("backpack_view_copy_-519157028")
	self._suitCanvas = self._btnFilter.gameObject:GetComponent(ComponentType.CanvasGroup)
	self._goFilterView = self:getGo("10&d6_filter_tips_470721785")
	self._equipFilterComponent = Astral.LuaComponentContainer.Add(self._goFilterView, EquipFilterComponent)
	self._txtFilter = goutil.findChildTextComponent(self._btnFilter.gameObject, "Label")
	self._btnSort = self:getBtn("backpack_view_copy_-1967500451")
	self._sortCanvas = self._btnSort.gameObject:GetComponent(ComponentType.CanvasGroup)
	self._sortText = goutil.findChildComponent(self._btnSort.gameObject, "content/Label", UIComponentType.Text)
	self._sortItemsParent = goutil.findChild(self._btnSort.gameObject, "Template")
	self._sortUpGo = goutil.findChild(self._btnSort.gameObject, "content/up")
	self._sortDownGo = goutil.findChild(self._btnSort.gameObject, "content/down")
	self._sortItems = {}
	self._sortItemTemp = goutil.findChild(self._sortItemsParent, "Content/Item1")

	goutil.setActive(self._sortItemTemp, false)

	local itemsParent = goutil.findChild(self._sortItemsParent, "Content")

	self._goFilterSelected = self:getGo("backpack_view_242107257")
	self._txtFilterName = self:getText("backpack_view_-104211747")
	self._goSelectDiceList = self:getGo("backpack_view_1508224637")
	self._goDiceItem = goutil.findChild(self._goSelectDiceList, "diceItem")

	goutil.setActive(self._goDiceItem, false)
	goutil.setActive(self._goFilterSelected, false)

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
	M.super.bindEvents(self)
	GlobalDispatcher:addEventListener(EventType.BACKPACK_PAGE_DATA_CHANGED, self._onBackpackPageDataChanged, self)
	GlobalDispatcher:addEventListener(EventType.BACKPACK_TO_SWITCH_SHOW_TYPE, self._onSwitchShowType, self)
end

function M:unbindEvents()
	M.super.unbindEvents(self)
	GlobalDispatcher:removeEventListener(EventType.BACKPACK_PAGE_DATA_CHANGED, self._onBackpackPageDataChanged, self)
	GlobalDispatcher:removeEventListener(EventType.BACKPACK_TO_SWITCH_SHOW_TYPE, self._onSwitchShowType, self)
end

function M:_handleEquipFilter(e, equipSuitData, dices)
	M.super._handleEquipFilter(self, e, equipSuitData, dices)
	self:_refreshSuit()
	GlobalDispatcher:dispatchEvent(EventType.BACKPACK_EQUIP_SUIT_ITEM_CLICK, self._filterEquipSuitData, self._filterEquipDices)
end

function M:_onClickRecycleBtn()
	self:_hideMaskGo()
	GlobalDispatcher:dispatchEvent(EventType.BACKPACK_PAGE_ENTER_RECYCLE)
end

function M:_hideMaskGo()
	goutil.setActive(self._btnMask.gameObject, false)
	goutil.setActive(self._goFilterView, false)
	goutil.setActive(self._sortItemsParent, false)
end

function M:_onSwitchShowType(e, showType)
	local isShow = showType == CommEnum.MainBackpackShowType.EquipShowType

	goutil.setActive(self._rootGo, isShow)

	if isShow then
		self._btnMask:RemoveClickListener()
		self._btnMask:AddClickListener(self._onClickMaskBtn, self)
		self:_refreshSuit()
	else
		goutil.setActive(self._goFilterSelected, false)
	end
end

function M:_onBackpackPageDataChanged(e, changeType)
	local curShowType = MainBackpackModel.instance:getCurShowType()
	local isShow = curShowType == CommEnum.MainBackpackShowType.EquipShowType and not MainBackpackModel.instance:isEmpty()

	goutil.setActive(self._rootGo, isShow)
end

function M:_onClickFilterBtn()
	local active = not self._isEmpty and not self._goFilterView.activeSelf

	goutil.setActive(self._goFilterSelected, not active)
	M.super._onClickFilterBtn(self)
end

function M:_onClickMaskBtn()
	goutil.setActive(self._btnMask.gameObject, false)
	goutil.setActive(self._goFilterView, false)
	goutil.setActive(self._sortItemsParent, false)
end

function M:_onClickSortItem(e, BackpackItemSortData)
	M.super._onClickSortItem(self, e, BackpackItemSortData)
	GlobalDispatcher:dispatchEvent(EventType.BACKPACK_SORT_ITEM_CLICK, self._sortMo)
end

function M:_refreshSuit()
	self._filterEquipDices = self._filterEquipDices or {}

	local lenght = TableUtil.getLen(self._filterEquipDices)

	goutil.setActive(self._goFilterView, false)

	local show = false

	if self._filterEquipSuitData or lenght > 0 then
		show = true
	end

	goutil.setActive(self._goFilterSelected, show)

	if show then
		self._txtFilterName.text = self._filterEquipSuitData and self._filterEquipSuitData:getName() or ""

		if self._filterEquipSuitData and lenght > 0 then
			self._txtFilterName.text = self._txtFilterName.text .. ","
		end

		RectTransformUtils.ForceRebuildLayoutImmediate(self._txtFilterName.gameObject.transform)
		self:_updataSelectDiceItems()
	end
end

function M:_updataSelectDiceItems()
	if not self._filterDiceItems then
		self._filterDiceItems = {}
	end

	local i = 1

	for k, v in pairs(self._filterEquipDices) do
		if i > 9 then
			break
		end

		if not self._filterDiceItems[i] then
			local go = goutil.clone(self._goDiceItem)

			goutil.addChildToParent(go, self._goSelectDiceList)

			local item = Astral.LuaComponentContainer.Add(go, EquipDiceIconSimplifyItem)

			self._filterDiceItems[i] = item
		end

		self._filterDiceItems[i]:updateIcon(v)
		self._filterDiceItems[i]:setActive(true)

		i = i + 1
	end

	for j = i, #self._filterDiceItems do
		self._filterDiceItems[j]:setActive(false)
	end
end

return M
