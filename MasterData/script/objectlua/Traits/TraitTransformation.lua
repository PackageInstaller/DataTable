-- chunkname: @/tmp/or_script/lua_compile/objectlua/Traits/TraitTransformation.lua

local TraitComponent = require("objectlua.Traits.TraitComponent")

module(...)

TraitTransformation = TraitComponent:subclass()

function TraitTransformation:initialize(component)
	self._component = component
end

function TraitTransformation:methods()
	self:requiredMethod()
end

function TraitTransformation:methodFor(key)
	self:requiredMethod()
end

function TraitTransformation:isOrContains(component)
	return self._component:isOrContains(component)
end

return TraitTransformation
