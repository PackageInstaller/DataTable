-- chunkname: @/tmp/or_script/lua_compile/objectlua/Traits/Trait.lua

local TraitComponent = require("objectlua.Traits.TraitComponent")
local TraitComposition = require("objectlua.Traits.TraitComposition")
local Class = require("objectlua.Class")

module(..., package.seeall)

local function uses(self, ...)
	rawset(self, "__traits__", self.__traits__ or TraitComposition:new())

	local traits = self.__traits__
	local mt = debug.getmetatable(self.__prototype__) or debug.getmetatable(self)

	if type(mt.__index) == "table" then
		local newMt = setmetatable({}, mt)

		rawset(newMt, "__index", function(t, key)
			local method = traits:methodFor(key)

			if method ~= nil then
				return method
			end

			return mt[key]
		end)
		debug.setmetatable(self.__prototype__, newMt)
	end

	traits:add(...)
end

local function doesUse(self, trait)
	return self.__traits__:doesUse(trait)
end

Class.uses = uses
Class.doesUse = doesUse

local function traitNewIndex(t, k, v)
	assert(not t:isUsed())
	assert(type(v) == "function")

	t._methods[k] = v
end

local function setAsTrait(trait)
	trait.__prototype__.__newindex = traitNewIndex
end

Trait = TraitComponent:subclass()

setAsTrait(Trait)

Trait.uses = uses
Trait.doesUse = doesUse

function Trait:initialize(name)
	rawset(self, "_name", name)
	rawset(self, "_methods", {})
end

function Trait.class:named(name)
	local env = getfenv(0)

	env[name] = self:new(name)
end

function Trait:markAsUsed()
	rawset(self, "__isUsed__", true)
end

function Trait:isUsed()
	return rawget(self, "__isUsed__")
end

function Trait:alias(aliases)
	error("Todo")
end

function Trait:methods()
	return self._methods
end

function Trait:methodFor(key)
	return self._methods[key]
end

function Trait:name()
	return self._name
end

function Trait:requirement()
	error("Error: Required method is missing.")
end

return Trait
