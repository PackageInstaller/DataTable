-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/buffs/effects/ProvokeEffect.lua

ProvokeEffect = class("ProvokeEffect", BuffEffect, _M)

function ProvokeEffect:initialize(config)
	super.initialize(self, config)

	self._targetStatus = kBEProvoked
	self._provokeUnit = config.target
end

function ProvokeEffect:takeEffect(target, buffObject)
	local flagComp = target and target:getComponent("Flag")

	if flagComp == nil then
		return nil
	end

	local counter = flagComp:addStatus(self._targetStatus)

	super.takeEffect(self, target, buffObject)
	target:setProvokeTarget(self._provokeUnit)

	return true
end

function ProvokeEffect:cancelEffect(target, buffObject)
	local _target = buffObject:getEffectValue(self, "target")

	if _target == nil or _target ~= target then
		return false
	end

	local flagComp = target and target:getComponent("Flag")
	local counter = flagComp:removeStatus(self._targetStatus)

	target:cancelProvokeTarget(self._provokeUnit)
	super.cancelEffect(self, target, buffObject)

	return true
end
