-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/DiscardHideComponent.lua

module("logic.extensions.backpack.cellcomponent.DiscardHideComponent", package.seeall)

local M = class("DiscardHideComponent", BackpackHideComponent)

function M:onInit()
	M.super.setHideGo(self, "backpack_item_2012755664")
end

return M
