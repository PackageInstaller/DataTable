-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/Entity.lua

module("logic.common.entitas.Entity", package.seeall)

local M = class("Entity")

function M.__tostring(t)
	local str = ""

	for _, v in pairs(t._components) do
		if #str > 0 then
			str = str .. ",\n"
		end

		if v then
			str = str .. tostring(v)
		end
	end

	return string.format("\n<Entity_%d\n %s\n>", t._uid, str)
end

function M:ctor()
	self.on_component_added = Delegate.New()
	self.on_component_removed = Delegate.New()
	self.on_component_replaced = Delegate.New()
	self._components = {}
	self._uid = 0
	self._is_enabled = false
end

function M:_activate(uid)
	self._uid = uid
	self._is_enabled = true
end

function M:add(comp_type, ...)
	if not self._is_enabled then
		error("Cannot add component entity is not enabled.")
	end

	if self:has(comp_type) then
		error("Cannot add another component")
	end

	local new_comp = comp_type.New(...)

	self._components[comp_type] = new_comp
	self[comp_type._name] = new_comp

	self.on_component_added(self, new_comp)

	return new_comp
end

function M:add_with_component(comp_type, new_comp)
	if not self._is_enabled then
		error("Cannot add component entity is not enabled.")
	end

	if self:has(comp_type) then
		error("Cannot add another component")
	end

	self._components[comp_type] = new_comp
	self[comp_type._name] = new_comp

	self.on_component_added(self, new_comp)

	return new_comp
end

function M:remove(comp_type)
	if not self._is_enabled then
		error("Cannot add component entity is not enabled.")
	end

	if not self:has(comp_type) then
		error(string.format("Cannot remove unexisting component %s", tostring(comp_type)))
	end

	self:_replace(comp_type, nil)
end

function M:replace(comp_type, ...)
	if not self._is_enabled then
		error("Cannot add component entity is not enabled.")
	end

	if self:has(comp_type) then
		return self:_replace(comp_type, ...)
	else
		return self:add(comp_type, ...)
	end
end

function M:_replace(comp_type, ...)
	local comp_name = comp_type._name
	local old_comp_value = self[comp_name]
	local new_comp

	if not ... then
		self._components[comp_type] = nil
		self[comp_name] = nil

		old_comp_value.release(old_comp_value)
		self.on_component_removed(self, old_comp_value)
	else
		new_comp = comp_type.New(...)
		self._components[comp_type] = new_comp
		self[comp_name] = new_comp

		self.on_component_replaced(self, old_comp_value, new_comp)
		old_comp_value:release(old_comp_value)
	end

	return new_comp
end

function M:get(comp_type)
	if not self:has(comp_type) then
		error(string.format("entity has not component '%s'", tostring(comp_type)))
	end

	return self[comp_type._name]
end

function M:has(comp_type)
	return self._components[comp_type]
end

function M:_has_all(comp_types)
	if not comp_types or #comp_types == 0 then
		return false
	end

	for _, v in pairs(comp_types) do
		if not self._components[v] then
			return false
		end
	end

	return true
end

function M:_has_any(comp_types)
	if not comp_types or #comp_types == 0 then
		return false
	end

	for _, v in pairs(comp_types) do
		if self._components[v] then
			return true
		end
	end

	return false
end

function M:_remove_all()
	for k, v in pairs(self._components) do
		if v then
			self:_replace(k, nil)
		end
	end
end

function M:_destroy()
	self._is_enabled = false

	self:_remove_all()
end

return M
