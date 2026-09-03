-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/buffs/effects/HolyHideEffect.lua

HolyHideEffect = class("HolyHideEffect", BuffEffect, _M)

function HolyHideEffect:initialize(config)
	super.initialize(self, config)

	self._targetStatus = config.status
	self._alpha = config.alpha
end

function HolyHideEffect:takeEffect(target, buffObject)
	local flagComp = target and target:getComponent("Flag")

	if flagComp == nil then
		return nil
	end

	local counter = flagComp:addStatus(self._targetStatus)

	super.takeEffect(self, target, buffObject)

	if flagComp:hasStatus(self._targetStatus) then
		return true, {
			specialevt = "HolyHide",
			evt = "Status",
			name = self._targetStatus,
			counter = counter,
			alpha = self._alpha
		}
	end

	return true, {
		evt = "Status",
		name = self._targetStatus,
		counter = counter
	}
end

function HolyHideEffect:cancelEffect(target, buffObject)
	local _target = buffObject:getEffectValue(self, "target")

	if _target == nil or _target ~= target then
		return false
	end

	local flagComp = target and target:getComponent("Flag")
	local counter = flagComp:removeStatus(self._targetStatus)

	super.cancelEffect(self, target, buffObject)

	if not flagComp:hasStatus(self._targetStatus) then
		return true, {
			specialevt = "HolyHide",
			alpha = 1,
			evt = "Status",
			name = self._targetStatus,
			counter = counter
		}
	end

	return true, {
		evt = "Status",
		name = self._targetStatus,
		counter = counter
	}
end
