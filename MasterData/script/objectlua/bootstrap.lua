-- chunkname: @/tmp/or_script/lua_compile/objectlua/bootstrap.lua

local _G = _G

module(...)

_G.objectlua = {}

local function delegated(t, prototype)
	if _G.rawget(prototype, "__index") == nil then
		_G.rawset(prototype, "__index", prototype)
		_G.rawset(prototype, "__metatable", "private")
	end

	return _G.setmetatable(t, prototype)
end

local function addSuper(superclass, symbol, method)
	local fenv = _G.getfenv(method)

	return _G.setfenv(method, _G.setmetatable({
		super = superclass.__prototype__
	}, {
		__index = fenv,
		__newindex = fenv
	}))
end

local function redirectAssignmentToPrototype(t, k, v)
	local superclass = t.superclass

	if superclass ~= nil and _G.type(v) == "function" then
		v = addSuper(superclass, k, v)
	end

	local prototype = t.__prototype__

	_G.assert(prototype ~= nil)
	_G.rawset(prototype, k, v)
end

local function redirectAssignmentToInterfacePrototype(t, k, v)
	if v == nil or _G.type(v) == "function" then
		local prototype = t.__prototype__

		_G.assert(prototype ~= nil)
		_G.rawset(prototype, k, v)
	else
		_G.assert(false, "Only functions can be defined in a interface.")
	end
end

local function basicNew(self, instance)
	_G.assert(self.__prototype__ ~= nil)

	instance = instance or {}

	delegated(instance, self.__prototype__)
	_G.rawset(instance, "class", self)

	return instance
end

local function setSuperclass(self, class)
	_G.assert(class.__prototype__ ~= nil)
	_G.rawset(self, "superclass", class)
	_G.rawset(self, "__prototype__", delegated({}, class.__prototype__))
end

local function setAsMetaclass(self)
	_G.rawset(self.__prototype__, "__newindex", redirectAssignmentToPrototype)
end

local objectPrototype = {}
local Class = {
	__prototype__ = delegated({}, objectPrototype)
}

Class.__prototype__.basicNew = basicNew
Class.__prototype__.setSuperclass = setSuperclass
Class.__prototype__.setAsMetaclass = setAsMetaclass

local ObjectMetaclass = basicNew(Class)

ObjectMetaclass:setSuperclass(Class)

local Object = ObjectMetaclass:basicNew({
	__prototype__ = objectPrototype
})

_G.rawset(Class, "superclass", Object)

local ClassMetaclass = basicNew(Class)

ClassMetaclass:setSuperclass(ObjectMetaclass)

ClassMetaclass.__prototype__.__index = ClassMetaclass.__prototype__

_G.setmetatable(Class, ClassMetaclass.__prototype__)
_G.rawset(Class, "class", ClassMetaclass)

local Interface = {
	__prototype__ = delegated({}, objectPrototype)
}

_G.rawset(Interface, "superclass", Object)

local InterfaceMetaclass = basicNew(Class)

InterfaceMetaclass:setSuperclass(ObjectMetaclass)

InterfaceMetaclass.__prototype__.__index = InterfaceMetaclass.__prototype__

_G.setmetatable(Interface, InterfaceMetaclass.__prototype__)
_G.rawset(Interface, "class", InterfaceMetaclass)
Class:setAsMetaclass()
ObjectMetaclass:setAsMetaclass()
ClassMetaclass:setAsMetaclass()
InterfaceMetaclass:setAsMetaclass()

Interface.__prototype__.__newindex = redirectAssignmentToInterfacePrototype
_G.objectlua.Object = Object
_G.objectlua["Object Metaclass"] = ObjectMetaclass
_G.objectlua.Class = Class
_G.objectlua["Class Metaclass"] = ClassMetaclass
_G.objectlua.Interface = Interface
_G.objectlua["Interface Metaclass"] = InterfaceMetaclass
_G.objectlua.enableInterfaceChecking = true
