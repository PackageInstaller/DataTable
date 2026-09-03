-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/buffs/effects/DamageTransferEffect.lua

DamageTransferEffect = class("DamageTransferEffect", BuffEffect, _M)

function DamageTransferEffect:initialize(config)
	super.initialize(self, config)

	self._trasforUnit = config.trasforUnit or {}
	self._radio = config.radio or 1
end

function DamageTransferEffect:takeEffect(target, buffObject)
	local HealthComp = target and target:getComponent("Health")

	if HealthComp == nil then
		return nil
	end

	super.takeEffect(self, target, buffObject)

	if self._trasforUnit then
		local targetHealthComp = self._trasforUnit:getComponent("Health")

		if self._trasforUnit then
			HealthComp:setTrasforHpComp(self._trasforUnit, self._radio)
		end

		return true
	end
end

function DamageTransferEffect:cancelEffect(target, buffObject)
	local _target = buffObject:getEffectValue(self, "target")

	if _target == nil or _target ~= target then
		return false
	end

	local HealthComp = target and target:getComponent("Health")

	if HealthComp == nil then
		return nil
	end

	HealthComp:removeTrasforHpComp()
	super.cancelEffect(self, target, buffObject)

	return true
end
