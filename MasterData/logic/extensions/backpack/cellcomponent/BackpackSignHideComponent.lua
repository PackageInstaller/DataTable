-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/BackpackSignHideComponent.lua

module("logic.extensions.backpack.cellcomponent.BackpackSignHideComponent", package.seeall)

local M = class("BackpackSignHideComponent", BackpackHideComponent)

function M:onInit()
	M.super.setHideGo(self, "backpack_item_549918192")
end

return M
