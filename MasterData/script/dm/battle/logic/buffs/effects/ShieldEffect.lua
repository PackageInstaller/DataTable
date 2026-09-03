-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/buffs/effects/ShieldEffect.lua

ShieldEffect = class("ShieldEffect", BuffEffect, _M)

function ShieldEffect:initialize(config)
	super.initialize(self, config)

	self._targetStatus = kBEShield
	self._upLimit = config.upLimit
end

function ShieldEffect:takeEffect(target, buffObject)
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

	local shield = healthComp:addShield(self._buffValue, self._upLimit, source)

	return true, {
		evt = "addShield",
		name = self._targetStatus,
		shield = healthComp:getShield()
	}
end

function ShieldEffect:cancelEffect(target, buffObject)
	local _target = buffObject:getEffectValue(self, "target")

	if _target == nil or _target ~= target then
		return false
	end

	local healthComp = target:getComponent("Health")

	if healthComp == nil then
		return nil
	end

	local source = buffObject:getEffectValue(self, "source")
	local shield = healthComp:cancelShield(source)

	super.cancelEffect(self, target, buffObject)

	return true, {
		evt = "cancelShield",
		name = self._targetStatus,
		shield = shield
	}
end

function ShieldEffect:stack(buff, buffObject)
	super.stack(self, buff, buffObject)

	local target = buffObject:getEffectValue(self, "target")
	local healthComp = target:getComponent("Health")

	if healthComp == nil then
		return nil
	end

	healthComp:addShield(buff:getBuffValue(), buff._upLimit, source)

	return true, {
		evt = "addShield",
		name = self._targetStatus,
		shield = healthComp:getShield()
	}
end
