-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/data/D6FiltePartItemData.lua

module("logic.extensions.backpack.data.D6FiltePartItemData", package.seeall)

local M = class("D6FiltePartItemData")

function M:ctor(D6FilterType, value)
	self.filterType = D6FilterType
	self.value = value
end

return M
