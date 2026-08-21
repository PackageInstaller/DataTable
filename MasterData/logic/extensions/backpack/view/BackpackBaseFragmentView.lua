-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/BackpackBaseFragmentView.lua

module("logic.extensions.backpack.view.BackpackBaseFragmentView", package.seeall)

local M = class("BackpackBaseFragmentView", DynamicFragmentView)

function M:ctor()
	M.super.ctor(self)

	self._showType = nil
end

function M:onEnter()
	local showType = MainBackpackModel.instance:getCurShowType()

	if not showType or showType ~= self._showType then
		return
	end

	self:showSelecItemInfo()
end

function M:buildUI()
	return
end

function M:destroyUI()
	return
end

function M:bindEvents()
	GlobalDispatcher:addEventListener(EventType.BACKPACK_PAGE_DATA_CHANGED, self._refreshSelectItemDetail, self)
end

function M:unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.BACKPACK_PAGE_DATA_CHANGED, self._refreshSelectItemDetail, self)
end

function M:onExit()
	return
end

function M:_refreshSelectItemDetail(e)
	local showType = MainBackpackModel.instance:getCurShowType()

	if not showType or showType ~= self._showType then
		return
	end

	self:showSelecItemInfo()
end

function M:showSelecItemInfo()
	return
end

return M
