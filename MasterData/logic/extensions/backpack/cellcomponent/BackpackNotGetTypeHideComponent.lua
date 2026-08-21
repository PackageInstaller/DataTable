-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/BackpackNotGetTypeHideComponent.lua

module("logic.extensions.backpack.cellcomponent.BackpackNotGetTypeHideComponent", package.seeall)

local M = class("BackpackNotGetTypeHideComponent", BackpackHideComponent)

function M:onInit()
	M.super.setHideGo(self, "backpack_item_1556523902")
end

return M
