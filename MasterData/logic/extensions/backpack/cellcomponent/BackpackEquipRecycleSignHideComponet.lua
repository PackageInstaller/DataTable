-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/BackpackEquipRecycleSignHideComponet.lua

module("logic.extensions.backpack.cellcomponent.BackpackEquipRecycleSignHideComponet", package.seeall)

local M = class("BackpackEquipRecycleSignHideComponet", BackpackHideComponent)

function M:onInit()
	local go = goutil.findChild(self._cell._go, "equip_hole_item_copy")

	self._hideGo = go
end

return M
