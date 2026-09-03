-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/buffs/effects/ImmuneEffect.lua

ImmuneEffect = class("ImmuneEffect", BuffEffect, _M)

function ImmuneEffect:initialize(config)
	super.initialize(self, config)

	self._targetStatus = kBEImmune
end

function ImmuneEffect:takeEffect(target, buffObject)
	local flagComp = target and target:getComponent("Flag")

	if flagComp == nil then
		return nil
	end

	local counter = flagComp:addStatus(self._targetStatus)

	super.takeEffect(self, target, buffObject)

	local healthComp = target:getComponent("Health")

	if healthComp == nil then
		return nil
	end

	healthComp:addImmune()

	return true
end

function ImmuneEffect:cancelEffect(target, buffObject)
	local _target = buffObject:getEffectValue(self, "target")

	if _target == nil or _target ~= target then
		return false
	end

	local flagComp = target and target:getComponent("Flag")
	local counter = flagComp:removeStatus(self._targetStatus)
	local healthComp = target:getComponent("Health")

	if healthComp == nil then
		return nil
	end

	healthComp:cancelImmune()
	super.cancelEffect(self, target, buffObject)

	return true
end
