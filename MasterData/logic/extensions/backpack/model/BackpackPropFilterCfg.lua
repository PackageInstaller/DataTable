-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/model/BackpackPropFilterCfg.lua

module("logic.extensions.backpack.model.BackpackPropFilterCfg", package.seeall)

local M = class("BackpackPropFilterCfg", BackpackBaseFilterCfg)

function M:ctor()
	M.super.ctor(self)

	self._filterType = nil
end

function M:reset()
	self._filterType = CommEnum.PropFilterType.AllFilterType
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
	if self._filterType == CommEnum.PropFilterType.AllFilterType then
		return list
	end

	local res = {}

	for _, itemData in ipairs(list) do
		if self:filterOneItem(itemData) then
			table.insert(res, itemData)
		end
	end

	return res
end

function M:filterOneItem(itemData)
	return self._filterType == itemData:getFilterType()
end

return M
