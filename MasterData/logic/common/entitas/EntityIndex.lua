-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/EntityIndex.lua

module("logic.common.entitas.EntityIndex", package.seeall)

local set = Set
local set_insert = set.insert
local set_remove = set.remove
local M = class("EntityIndex")

function c:ctor(comp_type, group, ...)
	M.super.ctor(self, comp_type, group, ...)
end

function M:get_entities(key)
	if not self._indexes[key] then
		self._indexes[key] = set.New(true)
	end

	return self._indexes[key]
end

function M:_add_entity(key, entity)
	local t = self:get_entities(key)

	set_insert(t, entity)
end

function M:_remove_entity(key, entity)
	local t = self:get_entities(key)

	set_remove(t, entity)
end

return M
