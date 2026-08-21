-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housebackpack/model/RoomDrawingFilterCfg.lua

module("logic.extensions.housebackpack.model.RoomDrawingFilterCfg", package.seeall)

local M = class("RoomDrawingFilterCfg", BackpackBaseFilterCfg)

function M:ctor()
	M.super.ctor(self)

	self._filterType = nil
end

function M:reset()
	self._filterType = CommEnum.RoomDrawingFilterType.All
end

function M:setFilterType(filterType)
	self._filterType = filterType
end

function M:getFilterType()
	return self._filterType
end

function M:updateCfg(cfg)
	self:setFilterType(cfg:getFilterType())
end

function M:doFilter(list)
	local filterType = self:getFilterType()
	local res = {}
	local All = CommEnum.RoomDrawingFilterType.All
	local NotOwned = CommEnum.RoomDrawingFilterType.NotOwned
	local Owned = CommEnum.RoomDrawingFilterType.Owned

	for _, itemData in ipairs(list) do
		if filterType == All or filterType == NotOwned and itemData:getCount() == 0 or filterType == Owned and itemData:getCount() > 0 then
			table.insert(res, itemData)
		end
	end

	return res
end

function M:filterOneItem(itemData)
	local filterType = filterCfg:getFilterType()
	local All = CommEnum.RoomDrawingFilterType.All
	local NotOwned = CommEnum.RoomDrawingFilterType.NotOwned
	local Owned = CommEnum.RoomDrawingFilterType.Owned

	return filterType == All or filterType == NotOwned and itemData:getCount() == 0 or filterType == Owned and itemData:getCount() > 0
end

return M
