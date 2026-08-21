-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housebackpack/view/RoomBackpackBaseFragmentView.lua

module("logic.extensions.housebackpack.view.RoomBackpackBaseFragmentView", package.seeall)

local M = class("RoomBackpackBaseFragmentView", DynamicFragmentView)

function M:ctor()
	M.super.ctor(self)

	self._showType = nil
end

function M:buildUI()
	return
end

function M:destroyUI()
	return
end

function M:bindEvents()
	GlobalDispatcher:addEventListener(EventType.ROOM_BACKPACK_PAGE_DATA_CHANGED, self._onPageDataChanged, self)
end

function M:unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.ROOM_BACKPACK_PAGE_DATA_CHANGED, self._onPageDataChanged, self)
end

function M:onEnter()
	local showType = RoomBackpackModel.instance:getCurShowType()

	if not showType or showType ~= self._showType then
		return
	end

	self:showSelecItemInfo()
end

function M:onExit()
	return
end

function M:_onPageDataChanged(e)
	local showType = RoomBackpackModel.instance:getCurShowType()

	if not showType or showType ~= self._showType then
		return
	end

	self:showSelecItemInfo()
end

function M:showSelecItemInfo()
	local itemData = RoomBackpackModel.instance:getCurSelecedItem()

	if itemData and self._detailView then
		self._detailView:setItemData(itemData)
	end
end

return M
