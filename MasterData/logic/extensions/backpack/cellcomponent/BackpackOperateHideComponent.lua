-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/BackpackOperateHideComponent.lua

module("logic.extensions.backpack.cellcomponent.BackpackOperateHideComponent", package.seeall)

local M = class("BackpackOperateHideComponent", BackpackHideComponent)

function M:onInit()
	M.super.setHideGo(self, "backpack_item_-797852549")
end

return M
