-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/buffs/effects/HPRecoverRatioEffect.lua

HPRecoverRatioEffect = class("HPRecoverRatioEffect", BuffEffect, _M)

function HPRecoverRatioEffect:initialize(config)
	super.initialize(self, config)

	self._ratio = config.ratio
end

function HPRecoverRatioEffect:takeEffect(target, buffObject)
	local healthComp = target:getComponent("Health")

	if healthComp == nil then
		return nil
	end

	super.takeEffect(self, target, buffObject)
	buffObject:setEffectValue(self, "ratio", self._ratio)
	healthComp:addHpRecoverRatio(self._ratio)

	return true
end

function HPRecoverRatioEffect:cancelEffect(target, buffObject)
	local _target = buffObject:getEffectValue(self, "target")

	if _target == nil or _target ~= target then
		return false
	end

	local healthComp = target:getComponent("Health")

	if healthComp == nil then
		return nil
	end

	local source = buffObject:getEffectValue(self, "ratio")

	healthComp:addHpRecoverRatio(0 - source)
	super.cancelEffect(self, target, buffObject)

	return true
end
