-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/BackpackD6FilterView.lua

module("logic.extensions.backpack.view.BackpackD6FilterView", package.seeall)

local M = class("BackpackD6FilterView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._showType = CommEnum.MainBackpackShowType.D6ShowType
end

function M:buildUI()
	local filterToggleGroupGo = self:getGo("backpack_filter_tips_2_1624925688")

	goutil.destroy(filterToggleGroupGo)

	local baseFilterPanelGo = self:getGo("backpack_filter_tips_2_1692466750")

	goutil.destroy(baseFilterPanelGo)

	self._btnFilterGo = self:getGo("backpack_filter_tips_2_-373096839")
	self._btnFilter = self:getBtn("backpack_filter_tips_2_-373096839")
	self._toggleFilter = self:getUIComponent("backpack_filter_tips_2_-373096839", UIComponentType.SpaceXToggle)

	local d6FilterPanelGo = self:getGo("backpack_filter_tips_2_1047256366")

	d6FilterPanelGo:SetActive(true)

	local filterScroll1Go = self:getGo("backpack_filter_tips_2_-855571380")

	self._simpleFilterView = Astral.LuaComponentContainer.Add(filterScroll1Go, BackpackEquipD6SimpleFilter)

	self._simpleFilterView:setRegistry(self._viewPresentor._viewElementsRegistry)
	self._simpleFilterView:setShowType(self._showType)
	self._simpleFilterView:buildUI()

	self._btnClose = self:getBtn("40&middle_tips_common_bg_-1205189576")
	self._btnReset = self:getBtn("backpack_filter_tips_2_866352753")
	self._btnEnsure = self:getBtn("backpack_filter_tips_2_-1091144780")
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnFilter:AddClickListener(self._onClickFilter, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnReset:AddClickListener(self._onClickReset, self)
	self._btnEnsure:AddClickListener(self._onClickEnsure, self)
	self._simpleFilterView:bindEvents()
end

function M:unbindEvents()
	self._btnFilter:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._btnEnsure:RemoveClickListener()
	self._simpleFilterView:unbindEvents()
end

function M:onEnter()
	local firstParam = self:getFirstParam()

	self._closeCallback = firstParam.closeCallback
	self._filterCfg = firstParam.filterCfg
	self._filterEvent = firstParam.filterEvent

	if firstParam.hidePartFilter then
		self._simpleFilterView:setPartFilterVisible(false)
	end

	self._simpleFilterView:setFilterCfg(self._filterCfg)
	self._simpleFilterView:onEnter()
	goutil.setActive(self._btnFilterGo, false)
end

function M:onExit()
	if self._closeCallback then
		self._closeCallback()
	end

	self._simpleFilterView:onExit()
end

function M:_onClickFilter()
	local isSeniorMode = self._toggleFilter.IsOn

	self._filterCfg:setIsSeniorMode(isSeniorMode)
	self._simpleFilterView:setEnabled(not isSeniorMode)
end

function M:_onClickClose()
	self._simpleFilterView:backToLast()
	self:back()
end

function M:_onClickReset()
	self._filterCfg:resetFilterViewData()
	self._simpleFilterView:doReset()
end

function M:_onClickEnsure()
	GlobalDispatcher:dispatchEvent(self._filterEvent, self._filterCfg)
	self:_onClickClose()
end

return M
