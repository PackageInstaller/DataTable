-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/PresetComponent.lua

module("logic.extensions.backpack.cellcomponent.PresetComponent", package.seeall)

local M = class("PresetComponent", CellBaseComponent)

function M:onInit()
	local registry = self._cell:getViewElementsRegistry()

	self._goPreset = registry:findUIElement("backpack_item_-834925379")
end

function M:setVisible(visible)
	goutil.setActive(self._goPreset, visible)
end

function M:onDestroy()
	M.super.onDestroy(self)
end

return M
