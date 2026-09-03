-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/effect/CompositeEffect.lua

require("dm.gameplay.develop.model.effect.Effect")

CompositeEffect = class("CompositeEffect", Effect, _M)

function CompositeEffect:initialize(subEffects)
	super.initialize(self, nil)
	assert(subEffects ~= nil and type(subEffects) == "table")

	self._subEffects = subEffects
end

function CompositeEffect:_getSubeffects()
	return self._subEffects
end

function CompositeEffect:takeEffect(target)
	local subEffects = self:_getSubeffects()

	if subEffects == nil then
		return
	end

	for _, effect in ipairs(subEffects) do
		effect:takeEffect(target)
	end
end

function CompositeEffect:cancelEffect(target)
	local subEffects = self:_getSubeffects()

	if subEffects == nil then
		return
	end

	for _, effect in ipairs(subEffects) do
		effect:cancelEffect(target)
	end
end
