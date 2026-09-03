-- chunkname: @/tmp/or_script/lua_compile/objectlua/Enumeration.lua

local _G = _G
local enumerations = {}

module(...)

local function package(name)
	local package = _G

	for packageName in name:gmatch("([^%.]*)%.") do
		if package[packageName] == nil then
			_G.rawset(package, packageName, {})
		end

		package = package[packageName]
	end

	return package
end

local function register(self, name)
	_G.assert(_G.type(name) == "string")

	enumerations[name] = self

	local mt = _G.getmetatable(self)

	mt._NAME = name
	mt._PACKAGE = name:gsub("[^\\/%.]+$", "")
	mt._SHORTNAME = name:gsub(mt._PACKAGE, "")

	_G.rawset(package(name), mt._SHORTNAME, self)
end

local function unregister(self)
	local mt = _G.getmetatable(self)
	local name, shortName = mt._NAME, mt._SHORTNAME

	if name ~= nil then
		enumerations[name] = nil

		_G.rawset(package(name), shortName, nil)
	end
end

local function find(self, name)
	return enumerations[name]
end

local function extend(values, constants)
	for name, value in _G.pairs(constants) do
		_G.rawset(values, name, value)
	end
end

local function allValues(values)
	local result = {}

	while values ~= nil do
		for name, value in _G.pairs(values) do
			if result[name] == nil then
				result[name] = value
			end
		end

		local mt = _G.getmetatable(values)

		values = mt and mt.__index
	end

	return result
end

local function createEnumeration(superEnumeration)
	local mt = {}
	local values

	if superEnumeration ~= nil then
		local smt = _G.getmetatable(superEnumeration)

		_G.assert(smt ~= nil and smt.__index ~= nil)

		local valuemt = {
			__index = smt.__index
		}

		valuemt.__metatable = valuemt
		values = _G.setmetatable({}, valuemt)
	else
		local valuemt = {}

		valuemt.__metatable = valuemt
		values = _G.setmetatable({}, valuemt)
	end

	mt.__index = values

	function mt.__newindex(t, k, v)
		_G.error("Trying to modify read-only enumeration.", 2)
	end

	mt.__metatable = mt

	function mt.__call(t, ...)
		local cmd, arg = ...

		if _G.type(cmd) == "table" then
			cmd = "extend"
			arg = cmd
		end

		if cmd == "extend" then
			_G.assert(_G.type(arg) == "table")
			extend(values, arg)
		elseif cmd == "unregister" then
			unregister(t)
		elseif cmd == "values" then
			return allValues(values)
		end

		return t
	end

	return _G.setmetatable({}, mt)
end

function all(self)
	local t = {}

	for k, v in _G.pairs(enumerations) do
		t[k] = v
	end

	return t
end

function new(self, enumName, superEnumeration)
	local enumeration = createEnumeration(superEnumeration)

	if _G.type(enumName) == "string" then
		_G.assert(find(self, enumName) == nil, _G.string.format("Enumeration redefinition. Enumeration named '%s' already exists.", _G.tostring(enumName)))
		register(enumeration, enumName)
	end

	return enumeration
end
