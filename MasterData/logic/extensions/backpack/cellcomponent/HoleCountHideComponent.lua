-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/HoleCountHideComponent.lua

module("logic.extensions.backpack.cellcomponent.HoleCountHideComponent", package.seeall)

local M = class("HoleCountHideComponent", BackpackHideComponent)

function M:onInit()
	M.super.setHideGo(self, "backpack_item_633745008")
end

return M
