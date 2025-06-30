-- chunkname: @slot.lua

local setmetatable = setmetatable
local _slot = {}

setmetatable(_slot, _slot)

function _slot:__call(...)
	if self.obj == nil then
		return self.func(...)
	else
		return self.func(self.obj, ...)
	end
end

function _slot.__eq(lhs, rhs)
	return lhs.func == rhs.func and lhs.obj == rhs.obj
end

function slot(func, obj)
	return setmetatable({
		func = func,
		obj = obj
	}, _slot)
end
