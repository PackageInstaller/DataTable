-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/buffs/effects/EnergyEffect.lua

EnergyEffect = class("EnergyEffect", BuffEffect, _M)

function EnergyEffect:initialize(config)
	super.initialize(self, config)

	self._targetStatus = config.status
end

function EnergyEffect:takeEffect(target, buffObject)
	local player = target and target:getOwner()

	if player == nil then
		return false
	end

	super.takeEffect(self, target, buffObject)

	local source = {
		buffObj = buffObject,
		eft = self
	}

	buffObject:setEffectValue(self, "source", source)

	local value = player:modifyEnergySpeedEffect(self._buffValue, source)

	return true, {
		evt = "modEnergy",
		speed = value
	}
end

function EnergyEffect:cancelEffect(target, buffObject)
	local _target = buffObject:getEffectValue(self, "target")

	if _target == nil or _target ~= target then
		return false
	end

	super.cancelEffect(self, target, buffObject)

	local player = target and target:getOwner()

	if player == nil then
		return false
	end

	local source = buffObject:getEffectValue(self, "source")
	local value = player:cancelEnergySpeedEffect(source)

	return true, {
		evt = "cancelEnergy",
		speed = value
	}
end
