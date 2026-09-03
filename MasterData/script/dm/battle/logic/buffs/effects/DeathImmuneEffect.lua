-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/buffs/effects/DeathImmuneEffect.lua

DeathImmuneEffect = class("DeathImmuneEffect", BuffEffect, _M)

function DeathImmuneEffect:initialize(config)
	super.initialize(self, config)

	self._buffValue = self._buffValue or 1
	self._brokeCallback = config.brokeCallback
	self._hpRecoverRatio = config.hpRecoverRatio
end

function DeathImmuneEffect:takeEffect(target, buffObject)
	local healthComp = target:getComponent("Health")

	if healthComp == nil then
		return nil
	end

	super.takeEffect(self, target, buffObject)

	local source = {
		buffObj = buffObject,
		eft = self
	}

	buffObject:setEffectValue(self, "source", source)

	local times = healthComp:addExtraLife(self._buffValue, source)

	return true, {
		evt = "addDeathImmune",
		times = times
	}
end

function DeathImmuneEffect:cancelEffect(target, buffObject, isBroke)
	local _target = buffObject:getEffectValue(self, "target")

	if _target == nil or _target ~= target then
		return false
	end

	local healthComp = target:getComponent("Health")

	if healthComp == nil then
		return nil
	end

	local source = buffObject:getEffectValue(self, "source")
	local times = healthComp:removeExtraLife(source)

	super.cancelEffect(self, target, buffObject, isBroke)

	if isBroke and self._brokeCallback then
		self._brokeCallback(battleContext, target, healthComp:getMaxHp() * self._hpRecoverRatio)
	end

	return true, {
		evt = "cancelDeathImmune",
		times = times
	}
end

function DeathImmuneEffect:stack(buff, buffObject)
	super.stack(self, buff, buffObject)

	local target = buffObject:getEffectValue(self, "target")
	local healthComp = target:getComponent("Health")

	if healthComp == nil then
		return nil
	end

	times = healthComp:addExtraLife(buff:getBuffValue(), nil)

	return true, {
		evt = "addDeathImmune",
		times = times
	}
end

function DeathImmuneEffect:remove(buff, buffObject)
	super.remove(self, buff, buffObject)

	local target = buffObject:getEffectValue(self, "target")
	local healthComp = target:getComponent("Health")

	if healthComp == nil then
		return nil
	end

	local source = buffObject:getEffectValue(self, "source")
	local times = healthComp:consumeExtraLife(source)
end
