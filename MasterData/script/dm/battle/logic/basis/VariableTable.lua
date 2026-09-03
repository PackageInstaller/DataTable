-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/basis/VariableTable.lua

VariableTable = class("VariableTable")

function VariableTable:initialize(parent)
	super.initialize(self)

	self._meta = {}

	self:clear()
	self:setParent(parent)
end

function VariableTable:getMeta()
	return self._meta
end

function VariableTable:getStorage()
	return self._namedValues
end

function VariableTable:write(name, value)
	self._namedValues[name] = value
end

function VariableTable:rawread(name)
	return rawget(self._namedValues, name)
end

function VariableTable:read(name)
	return self._namedValues[name]
end

function VariableTable:clear()
	if self._namedValues ~= nil and next(self._namedValues) == nil then
		return
	end

	local parent = self._parent

	self._namedValues = setmetatable({}, parent and parent:getMeta() or nil)
	self._meta.__index = self._namedValues
end

function VariableTable:setParent(parent)
	if self._parent == parent then
		return
	end

	self._parent = parent

	setmetatable(self._namedValues, parent and parent:getMeta() or nil)
end

function VariableTable:snapshot(selfOnly)
	local values = not selfOnly and self._parent ~= nil and self._parent:snapshot(false) or {}

	for k, v in pairs(self._namedValues) do
		values[k] = v
	end

	return values
end
