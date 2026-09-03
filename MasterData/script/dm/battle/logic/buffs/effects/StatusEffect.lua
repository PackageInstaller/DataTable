-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/buffs/effects/StatusEffect.lua

StatusEffect = class("StatusEffect", BuffEffect, _M)

function StatusEffect:initialize(config)
	super.initialize(self, config)

	self._targetStatus = config.status
end

function StatusEffect:takeEffect(target, buffObject)
	local flagComp = target and target:getComponent("Flag")

	if flagComp == nil then
		return nil
	end

	local counter = flagComp:addStatus(self._targetStatus)

	super.takeEffect(self, target, buffObject)

	return true, {
		evt = "Status",
		name = self._targetStatus,
		counter = counter
	}
end

function StatusEffect:cancelEffect(target, buffObject)
	local _target = buffObject:getEffectValue(self, "target")

	if _target == nil or _target ~= target then
		return false
	end

	local flagComp = target and target:getComponent("Flag")
	local counter = flagComp:removeStatus(self._targetStatus)

	super.cancelEffect(self, target, buffObject)

	return true, {
		evt = "Status",
		name = self._targetStatus,
		counter = counter
	}
end
