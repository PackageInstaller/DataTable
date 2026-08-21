-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/manufacture/view/ManufactureSchemeView.lua

module("logic.extensions.manufacture.view.ManufactureSchemeView", package.seeall)

local M = class("ManufactureSchemeView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._loopListHelper = LoopGridViewHelper.New(self:getGo("facility_holding_change_view_-837437632"))

	self._loopListHelper:InitGridView(0, self._onCellUpdate, self)

	self._toggleSchemeType1 = self:getUIComponent("facility_holding_change_view_-857990247", UIComponentType.SpaceXToggle)
	self._toggleSchemeType2 = self:getUIComponent("facility_yield_plan_view_-1474992167", UIComponentType.SpaceXToggle)
	self._toggleSchemeType3 = self:getUIComponent("facility_yield_plan_view_-1167311528", UIComponentType.SpaceXToggle)
	self._toggleSortType1 = self:getUIComponent("facility_yield_plan_view_1681379702", UIComponentType.SpaceXToggle)
	self._toggleSortType2 = self:getUIComponent("facility_yield_plan_view_1741686702", UIComponentType.SpaceXToggle)
	self._toggleSortOrder = self:getUIComponent("facility_yield_plan_view_412622297", UIComponentType.SpaceXToggle)
end

function M:destroyUI()
	self._loopListHelper:Dispose()

	self._loopListHelper = nil
end

function M:bindEvents()
	self._toggleSchemeType1:AddListener(self._onToggleSchemeType1, self)
	self._toggleSchemeType2:AddListener(self._onToggleSchemeType2, self)
	self._toggleSchemeType3:AddListener(self._onToggleSchemeType3, self)
	self._toggleSortType1:AddListener(self._onToggleSortType1, self)
	self._toggleSortType2:AddListener(self._onToggleSortType2, self)
	self._toggleSortOrder:AddListener(self._onToggleSortOrder, self)
end

function M:unbindEvents()
	self._toggleSchemeType1:RemoveListener()
	self._toggleSchemeType2:RemoveListener()
	self._toggleSchemeType3:RemoveListener()
	self._toggleSortType1:RemoveListener()
	self._toggleSortType2:RemoveListener()
	self._toggleSortOrder:RemoveListener()
end

function M:_setEvents(isOn)
	if isOn then
		GlobalDispatcher:addEventListener(EventType.MANUFACTURE_INFO_REPLY, self._onManufactureInfoReply, self)
		GlobalDispatcher:addEventListener(EventType.MANUFACTURE_PLANT_INFO_CHANGE, self._onManufactureInfoChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.MANUFACTURE_INFO_REPLY, self._onManufactureInfoReply, self)
		GlobalDispatcher:removeEventListener(EventType.MANUFACTURE_PLANT_INFO_CHANGE, self._onManufactureInfoChange, self)
	end
end

function M:onEnter()
	local plantId = self:getFirstParam()

	self._plantMO = ManufactureModel.instance:getPlantById(plantId)
	self._selectedSchemeType = 1
	self._selectedSortType = 1
	self._isSortUp = false

	self:_refreshLoopViewByType()

	self._toggleSchemeType1.IsOn = true
	self._toggleSortType1.IsOn = true
	self._toggleSortOrder.IsOn = self._isSortUp

	self:_setEvents(true)
end

function M:onExit()
	self._loopListHelper:ClearCells()
	self:_setEvents(false)
end

function M:_refreshLoopViewByType()
	self._schemeList = ManufactureConfig.instance:getSchemeList(self._selectedSchemeType, self._selectedSortType, self._isSortUp)

	self._loopListHelper:SetListItemCount(#self._schemeList, true)
	self:_refreshLoopView()
end

function M:_refreshLoopView()
	self._loopListHelper:RefreshAllShownItem()
	self._loopListHelper:MoveToItemIndex(0)
end

function M:_onCellUpdate(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local schemeCO = self._schemeList[curIndex]
	local item = self._loopListHelper:NewListViewItem("facility_yield_plan_item")
	local behavior = Astral.LuaComponentContainer.Add(item.gameObject, ManufactureSchemeItem)

	behavior:updateData(schemeCO, self._plantMO)

	return item
end

function M:_onToggleSchemeType1(toggle, isOn)
	if isOn then
		self._selectedSchemeType = 1

		self:_refreshLoopViewByType()
	end
end

function M:_onToggleSchemeType2(toggle, isOn)
	if isOn then
		self._selectedSchemeType = 2

		self:_refreshLoopViewByType()
	end
end

function M:_onToggleSchemeType3(toggle, isOn)
	if isOn then
		self._selectedSchemeType = 3

		self:_refreshLoopViewByType()
	end
end

function M:_onToggleSortType1(toggle, isOn)
	if isOn then
		self._selectedSortType = 1

		self:_refreshLoopViewByType()
	end
end

function M:_onToggleSortType2(toggle, isOn)
	if isOn then
		self._selectedSortType = 2

		self:_refreshLoopViewByType()
	end
end

function M:_onToggleSortOrder(toggle, isOn)
	self._isSortUp = isOn

	self:_refreshLoopViewByType()
end

function M:_onManufactureInfoReply()
	self._loopListHelper:RefreshAllShownItem()
end

function M:_onManufactureInfoChange()
	self._loopListHelper:RefreshAllShownItem()
end

return M
