-- chunkname: @/tmp/or_script/lua_compile/dragon/legs/injector/ObjectLuaPatchesForInjector.lua

local _G = _G
local Object = _G.objectlua.Object
local Class = _G.objectlua.Class

module(...)

local function registPropInjection(targetClass, symbol, clazz, named)
	local injectPoints = _G.rawget(targetClass, "__INJECTPOINTS__")

	if injectPoints == nil then
		injectPoints = {}

		_G.rawset(targetClass, "__INJECTPOINTS__", injectPoints)
	end

	injectPoints[symbol] = {
		askForClazz = clazz,
		named = named
	}
end

local function collectInjectPoints(class, points)
	if class == nil then
		return nil
	end

	local result = points

	if class.superclass ~= nil then
		result = collectInjectPoints(class.superclass, result)
	end

	local injectPoints = class.__INJECTPOINTS__

	if injectPoints ~= nil then
		if result == nil then
			result = {}
		end

		for k, v in _G.pairs(injectPoints) do
			result[k] = v
		end
	end

	return result
end

local function retriveSeterFunction(instance, symbol)
	local class = instance.class

	while class ~= nil and class ~= Object do
		local __proterties__ = _G.rawget(class, "__proterties__")
		local prop = __proterties__ and __proterties__[symbol]
		local seterSymbol = prop and prop.seterSymbol
		local seter = seterSymbol and instance[seterSymbol]

		if seter ~= nil then
			return seter
		end

		class = class.superclass
	end

	return nil
end

local function injectProperty(instance, symbol, value)
	local seter = retriveSeterFunction(instance, symbol)

	if seter then
		seter(instance, value)
	else
		instance[symbol] = value
	end
end

local classPrototype = Class.__prototype__

if classPrototype._has == nil then
	_G.rawset(classPrototype, "_has", Class.has)
end

Class.registPropInjection = registPropInjection

function Class:has(symbol, options)
	local prop = self:_has(symbol, options)
	local __proterties__ = _G.rawget(self, "__proterties__")

	if __proterties__ == nil then
		__proterties__ = {}

		_G.rawset(self, "__proterties__", __proterties__)
	end

	__proterties__[symbol] = prop

	return {
		class = self,
		memberSymbol = symbol,
		geterSymbol = prop and prop.geterSymbol,
		seterSymbol = prop and prop.seterSymbol,
		injectWith = function(_, askForClazz, named)
			return registPropInjection(self, symbol, askForClazz, named)
		end
	}
end

function Object:getInjector()
	return self._injector
end

function Object:sysInject(injector)
	self._injector = injector

	local injectPoints = collectInjectPoints(self.class)

	if injectPoints ~= nil then
		for symbol, p in _G.pairs(injectPoints) do
			local obj = injector:getInstance(p.askForClazz, p.named)

			injectProperty(self, symbol, obj)
		end
	end
end
