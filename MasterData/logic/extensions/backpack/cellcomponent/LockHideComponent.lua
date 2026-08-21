-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/LockHideComponent.lua

module("logic.extensions.backpack.cellcomponent.LockHideComponent", package.seeall)

local M = class("LockHideComponent", BackpackHideComponent)

function M:onInit()
	M.super.setHideGo(self, "backpack_item_962705275")
end

return M
