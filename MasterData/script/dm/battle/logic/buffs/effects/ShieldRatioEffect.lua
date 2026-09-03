-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/buffs/effects/ShieldRatioEffect.lua

ShieldRatioEffect = class("ShieldRatioEffect", BuffEffect, _M)

function ShieldRatioEffect:initialize(config)
	super.initialize(self, config)

	self._ratio = config.ratio
end

function ShieldRatioEffect:takeEffect(target, buffObject)
	local healthComp = target:getComponent("Health")

	if healthComp == nil then
		return nil
	end

	super.takeEffect(self, target, buffObject)
	buffObject:setEffectValue(self, "ratio", self._ratio)
	healthComp:addShieldRatio(self._ratio)

	return true
end

function ShieldRatioEffect:cancelEffect(target, buffObject)
	local _target = buffObject:getEffectValue(self, "target")

	if _target == nil or _target ~= target then
		return false
	end

	local healthComp = target:getComponent("Health")

	if healthComp == nil then
		return nil
	end

	local source = buffObject:getEffectValue(self, "ratio")

	healthComp:addShieldRatio(0 - source)
	super.cancelEffect(self, target, buffObject)

	return true
end
