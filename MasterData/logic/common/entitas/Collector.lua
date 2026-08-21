-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/Collector.lua

module("logic.common.entitas.Collector", package.seeall)

local set = Set
local set_insert = set.insert
local set_remove = set.remove
local M = {}

M.__index = M

function M.New(groups)
	local tb = {}

	tb.entities = set.New(true)
	tb._groups = groups

	function tb.add_entity(...)
		return tb._add_entity(tb, ...)
	end

	function tb.remove_entity(...)
		return tb._remove_entity(tb, ...)
	end

	tb = setmetatable(tb, M)

	tb.activate(tb)

	return tb
end

function M:activate()
	for group, group_event in pairs(self._groups) do
		if BitUtil.BitAND(group_event, GroupEvent.ADDED) ~= 0 and not group.on_entity_added:has(self.add_entity) then
			group.on_entity_added:add(self.add_entity)
		end

		if BitUtil.BitAND(group_event, GroupEvent.REMOVED) ~= 0 and not group.on_entity_removed:has(self.remove_entity) then
			group.on_entity_removed:add(self.remove_entity)
		end

		if BitUtil.BitAND(group_event, GroupEvent.UPDATE) ~= 0 and not group.on_entity_updated:has(self.add_entity) then
			group.on_entity_updated:add(self.add_entity)
		end
	end
end

function M:deactivate()
	for group, _ in pairs(self._groups) do
		group.on_entity_added:remove(self.add_entity)
		group.on_entity_removed:remove(self.remove_entity)
		group.on_entity_updated:remove(self.add_entity)
	end

	self:clear_entities()
end

function M:clear_entities()
	self.entities:clear()
end

function M:_add_entity(entity)
	for group, group_event in pairs(self._groups) do
		if BitUtil.BitAND(group_event, GroupEvent.ADDED) ~= 0 or BitUtil.BitAND(group_event, GroupEvent.UPDATE) ~= 0 then
			set_insert(self.entities, entity)
		end
	end
end

function M:_remove_entity(entity)
	for group, group_event in pairs(self._groups) do
		if BitUtil.BitAND(group_event, GroupEvent.REMOVED) ~= 0 then
			set_insert(self.entities, entity)
		else
			set_remove(self.entities, entity)
		end
	end
end

return M
