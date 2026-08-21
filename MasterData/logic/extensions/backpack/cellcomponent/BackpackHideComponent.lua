-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/BackpackHideComponent.lua

module("logic.extensions.backpack.cellcomponent.BackpackHideComponent", package.seeall)

local M = class("BackpackHideComponent", CellBaseComponent)

function M:ctor(cell)
	M.super.ctor(self, cell)
end

function M:onInit()
	return
end

function M:setHideGo(key)
	local registry = self._cell:getViewElementsRegistry()

	self._hideGo = registry:findUIElement(key)
end

function M:updateData(equipItemData)
	goutil.setActive(self._hideGo, false)
end

return M
