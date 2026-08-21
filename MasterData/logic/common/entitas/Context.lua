-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/Context.lua

module("logic.common.entitas.Context", package.seeall)

local table_insert = table.insert
local table_remove = table.remove
local Matcher = require("Matcher")
local M = class("Context")

function M:ctor(entity_class)
	local tb = {}

	self.entities = {}
	self._entities_pool = {}
	self._entity_class = entity_class
	self._uuid = 1
	self._size = 0
	self._groups = {}
	self._entity_indices = {}

	function self.comp_added(...)
		return self:_comp_added(...)
	end

	function self.comp_removed(...)
		return self:_comp_removed(...)
	end

	function self.comp_replaced(...)
		return self:_comp_replaced(...)
	end
end

function M:has_entity(entity)
	return self.entities[entity._uid]
end

function M:create_entity()
	local entity = table_remove(self._entities_pool)

	if not entity then
		entity = self:_create_entity()

		entity.on_component_added:add(self.comp_added)
		entity.on_component_removed:add(self.comp_removed)
		entity.on_component_replaced:add(self.comp_replaced)
	end

	entity:_activate(self._uuid)

	self._uuid = self._uuid + 1
	self.entities[entity._uid] = entity
	self._size = self._size + 1

	return entity
end

function M:_create_entity()
	assert(false)
end

function M:destroy_entity(entity)
	if not self:has_entity(entity) then
		error("The context does not contain this entity:" .. tostring(entity))
	end

	entity:_destroy()

	self.entities[entity._uid] = nil

	table_insert(self._entities_pool, entity)

	self._size = self._size - 1
end

function M:entity_size()
	return self._size
end

function M:get_group(matcher)
	local group = self._groups[matcher]

	if group then
		return group
	end

	group = Group.New(matcher)

	for _, e in pairs(self.entities) do
		group:handle_entity_silently(e)
	end

	self._groups[matcher] = group

	return group
end

function M:set_unique_component(name, comp_type, ...)
	local entity = self:create_entity()
	local new_comp = comp_type.New(...)

	self[name .. "Entity"] = entity
	self[name] = new_comp

	local comp = entity:add_with_component(comp_type, new_comp)

	return comp, entity
end

function M:get_unique_component(comp_type)
	local group = self:get_group(Matcher({
		comp_type
	}))
	local entity = group:single_entity()

	return entity:get(comp_type)
end

function M:has_unique_component(comp_type)
	local group = self:get_group(Matcher({
		comp_type
	}))
	local entity = group:single_entity()

	if entity == nil then
		return false
	end

	return entity:get(comp_type) ~= nil
end

function M:remove_unique_component(name)
	local old = self[name .. "Entity"]

	self[name .. "Entity"] = nil
	self[name] = nil

	self:destroy_entity(old)
end

function M:add_entity_index(entity_index)
	self._entity_indices[entity_index.comp_type] = entity_index
end

function M:get_entity_index(comp_type)
	return self._entity_indices[comp_type]
end

function M:_comp_added(entity, comp_value)
	for _, group in pairs(self._groups) do
		local ret = group:handle_entity(entity)

		if ret then
			ret(entity, comp_value)
		end
	end
end

function M:_comp_removed(entity, comp_value)
	for _, group in pairs(self._groups) do
		local ret = group:handle_entity(entity)

		if ret then
			ret(entity, comp_value)
		end
	end
end

function M:_comp_replaced(entity, comp_value)
	for _, group in pairs(self._groups) do
		if group._matcher:match_one(comp_value) then
			group:update_entity(entity, comp_value)
		end
	end
end

return M
