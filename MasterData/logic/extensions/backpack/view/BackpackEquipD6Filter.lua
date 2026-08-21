-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/BackpackEquipD6Filter.lua

module("logic.extensions.backpack.view.BackpackEquipD6Filter", package.seeall)

local M = class("BackpackEquipD6Filter")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self._mainGo:SetActive(false)

	self._registry = nil
end

function M:setRegistry(registry)
	self._registry = registry
end

function M:setFilterCfg(filterCfg)
	self._filterCfg = filterCfg
end

function M:setShowType(showType)
	self._showType = showType
end

function M:buildUI()
	return
end

function M:_bindEvents()
	GlobalDispatcher:addEventListener(EventType.BACKPACK_FILTER_UPDATE, self._dealFilterUpdate, self)
end

function M:_unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.BACKPACK_FILTER_UPDATE, self._dealFilterUpdate, self)
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:setEnabled(enabled)
	self._mainGo:SetActive(enabled)

	if enabled then
		self:_updateTabViewStatus()
	end
end

function M:_updateTabViewStatus()
	return
end

function M:_dealFilterUpdate(e, showType, listModel)
	if showType ~= self._showType then
		return
	end

	self:_updateTabViewStatus()
end

return M
