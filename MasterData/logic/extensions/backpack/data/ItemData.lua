-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/data/ItemData.lua

module("logic.extensions.backpack.data.ItemData", package.seeall)

local M = class("ItemData", ItemBaseData)

function M:ctor(params)
	M.super.ctor(self, params)
end

return M
