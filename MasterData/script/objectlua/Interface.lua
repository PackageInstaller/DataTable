-- chunkname: @/tmp/or_script/lua_compile/objectlua/Interface.lua

require("objectlua.bootstrap")

local _G = _G
local interfaces = {}

module(...)

local function register(self, name)
	_G.assert(_G.type(name) == "string")

	interfaces[name] = self

	_G.rawset(self, "_M", self)
	_G.rawset(self, "_NAME", name)
	_G.rawset(self, "_PACKAGE", name:gsub("[^\\/%.]+$", ""))
	_G.rawset(self:package(), self:shortName(), self)
end

local function find(self, name)
	return interfaces[name]
end

function class:new(interfaceName, superInterface)
	local instance = self:basicNew()

	if superInterface ~= nil then
		_G.rawset(instance, "superinterf", superInterface)
	end

	_G.rawset(instance, "__prototype__", {})

	if _G.type(interfaceName) == "string" then
		_G.assert(find(self, interfaceName) == nil, _G.string.format("Interface redefinition. Interface named '%s' already exists.", _G.tostring(interfaceName)))
		register(instance, interfaceName)
	end

	return instance
end

function class:all()
	local t = {}

	for k, v in _G.pairs(interfaces) do
		t[k] = v
	end

	return t
end

class.find = find

function name(self)
	return self._NAME
end

function shortName(self)
	return (self._NAME:gsub(self._PACKAGE, ""))
end

function package(self)
	local name = self:name()
	local package = _G

	for packageName in name:gmatch("([^%.]*)%.") do
		if package[packageName] == nil then
			_G.rawset(package, packageName, {})
		end

		package = package[packageName]
	end

	return package
end

function inheritsFrom(self, interface)
	if self == nil or interface == nil then
		return nil
	end
end

function unregister(self)
	if not self._NAME then
		return
	end

	_G.rawset(self:package(), self:shortName(), nil)

	if _G.package.loaded[self._NAME] == self then
		_G.package.loaded[self._NAME] = nil
	end

	interfaces[self._NAME] = nil
end

function hasMethod(self, name)
	return self.__prototype__[name] ~= nil or self.superinterf ~= nil and self.superinterf:hasMethod(name)
end

function allMethods(self)
	return
end

function isImplementedBy(self, instance)
	for k, v in _G.pairs(self.__prototype__) do
		if _G.type(instance[k]) ~= "function" then
			return false, k
		end
	end

	if self.superinterf == nil then
		return true
	end

	return self.superinterf:isImplementedBy(instance)
end
