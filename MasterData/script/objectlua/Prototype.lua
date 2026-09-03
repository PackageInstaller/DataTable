-- chunkname: @/tmp/or_script/lua_compile/objectlua/Prototype.lua

module(..., package.seeall)

local function __getSuper__(parent, symbol)
	return function(...)
		return parent[symbol](...)
	end
end

local function __addSuper__(parent, symbol, method)
	local fenv = getfenv(method)

	setfenv(method, setmetatable({
		super = __getSuper__(parent, symbol)
	}, {
		__index = fenv,
		__newindex = fenv
	}))

	return method
end

local function __newindex__(table, key, value)
	local proto = table.__prototype__

	if proto ~= nil and type(value) == "function" then
		value = __addSuper__(proto, key, value)
	end

	rawset(table, key, value)
end

local function __delegated__(self)
	local t = setmetatable({}, self)

	rawset(t, "__prototype__", self)
	rawset(t, "__index", t)
	rawset(t, "__newindex", __newindex__)

	return t
end

Prototype = __delegated__()
Prototype.delegated = __delegated__

function Prototype:initialize()
	return
end

function Prototype:prototype()
	return self.__prototype__
end

function Prototype:spawn(...)
	local t = self:delegated()

	t:initialize(...)

	return t
end

function Prototype:delegatesTo(object)
	if self.__prototype__ == object then
		return true
	end

	if self.__prototype__ == nil or object == nil then
		return false
	end

	return self.__prototype__:delegatesTo(object)
end

function Prototype:clone()
	local t = self:delegated()

	for k, v in pairs(self) do
		t[k] = v
	end

	return t
end

return Prototype
