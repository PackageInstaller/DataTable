-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/buffs/effects/LimitHpEffect.lua

LimitHpEffect = class("LimitHpEffect", BuffEffect, _M)

function LimitHpEffect:initialize(config)
	super.initialize(self, config)
end

function LimitHpEffect:takeEffect(target, buffObject)
	super.takeEffect(self, target, buffObject)

	local healthComp = target:getComponent("Health")

	if healthComp == nil then
		return nil
	end

	local source = {
		buffObj = buffObject,
		eft = self
	}

	buffObject:setEffectValue(self, "source", source)

	local limitHp = healthComp:addHpUpLimit(self._buffValue, source)

	return true, {
		evt = "limitHp",
		limitHp = limitHp
	}
end

function LimitHpEffect:cancelEffect(target, buffObject)
	local _target = buffObject:getEffectValue(self, "target")

	if _target == nil or _target ~= target then
		return false
	end

	local healthComp = target:getComponent("Health")

	if healthComp == nil then
		return nil
	end

	local source = buffObject:getEffectValue(self, "source")
	local limitHp = healthComp:cancelHpUpLimit(source)

	super.cancelEffect(self, target, buffObject)

	return true, {
		evt = "limitHpCancel",
		limitHp = limitHp
	}
end
