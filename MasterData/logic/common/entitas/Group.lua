-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/Group.lua

module("logic.common.entitas.Group", package.seeall)

local set = Set
local set_insert = set.insert
local set_remove = set.remove
local set_size = set.size
local table_insert = table.insert
local M = {}

M.__index = M

function M.__tostring(t)
	return string.format("<Group [{%s}]>", tostring(t._matcher))
end

function M.New(matcher)
	local tb = {}

	tb.on_entity_added = Delegate.New()
	tb.on_entity_removed = Delegate.New()
	tb.on_entity_updated = Delegate.New()
	tb._matcher = matcher
	tb.entities = set.New(true)

	return setmetatable(tb, M)
end

function M:single_entity()
	local count = set.size(self.entities)

	if count == 1 then
		return self.entities:at(1)
	end

	if count == 0 then
		return nil
	end

	error(string.format("Cannot get a single entity from a group containing %d entities", count))
end

function M:entity_size()
	return set_size(self.entities)
end

function M:get_entity_buffer()
	local ret = {}
	local entities = self.entities._data

	for entity, _ in pairs(entities) do
		table_insert(ret, entity)
	end

	return ret
end

function M:handle_entity_silently(entity)
	assert(entity)

	if self._matcher:match_entity(entity) then
		return self:_add_entity_silently(entity)
	else
		return self:_remove_entity_silently(entity)
	end
end

function M:handle_entity(entity)
	if not self._matcher:match_entity(entity) then
		if not self:_remove_entity_silently(entity) then
			return
		end

		return self.on_entity_removed
	end

	if not self:_add_entity_silently(entity) then
		return
	end

	return self.on_entity_added
end

function M:update_entity(entity, comp_value)
	if set.has(self.entities, entity) then
		self.on_entity_removed(entity, comp_value)
		self.on_entity_added(entity, comp_value)
		self.on_entity_updated(entity, comp_value)
	end
end

function M:_add_entity_silently(entity)
	return set_insert(self.entities, entity)
end

function M:_add_entity(entity, comp_value)
	local entity_added = self:_add_entity_silently(entity)

	if entity_added then
		self.on_entity_added(entity, comp_value)
	end
end

function M:_remove_entity_silently(entity)
	return set_remove(self.entities, entity)
end

function M:_remove_entity(entity, comp_value)
	local entity_removed = self:_remove_entity_silently(entity)

	if entity_removed then
		self.on_entity_removed(entity, comp_value)
	end
end

return M
