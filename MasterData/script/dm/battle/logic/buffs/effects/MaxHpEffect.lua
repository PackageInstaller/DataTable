-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/buffs/effects/MaxHpEffect.lua

MaxHpEffect = class("MaxHpEffect", BuffEffect, _M)

function MaxHpEffect:initialize(config)
	super.initialize(self, config)
end

function MaxHpEffect:takeEffect(target, buffObject)
	super.takeEffect(self, target, buffObject)

	local healthComp = target:getComponent("Health")

	if healthComp == nil then
		return nil
	end

	local hp, maxHp = healthComp:modifyMaxHp(self._buffValue)

	return true, {
		evt = "modifyMaxHp",
		maxHp = maxHp,
		hp = hp
	}
end

function MaxHpEffect:stack(buff, buffObject)
	super.stack(self, buff, buffObject)

	local target = buffObject:getEffectValue(self, "target")
	local healthComp = target:getComponent("Health")

	if healthComp == nil then
		return nil
	end

	local hp, maxHp = healthComp:modifyMaxHp(buff:getBuffValue())

	return true, {
		evt = "modifyMaxHp",
		maxHp = maxHp,
		hp = hp
	}
end

function MaxHpEffect:remove(buff, buffObject)
	super.remove(self, buff, buffObject)

	local target = buffObject:getEffectValue(self, "target")
	local healthComp = target:getComponent("Health")

	if healthComp == nil then
		return nil
	end

	local hp, maxHp = healthComp:modifyMaxHp(-buff:getBuffValue())

	return true, {
		evt = "modifyMaxHp",
		maxHp = maxHp,
		hp = hp
	}
end

function MaxHpEffect:cancelEffect(target, buffObject)
	local _target = buffObject:getEffectValue(self, "target")

	if _target == nil or _target ~= target then
		return false
	end

	local buffValue = buffObject:getEffectValue(self, "buffValue") or self._buffValue
	local healthComp = target:getComponent("Health")

	if healthComp == nil then
		return nil
	end

	local hp, maxHp = healthComp:modifyMaxHp(-buffValue)

	super.cancelEffect(self, target, buffObject)

	return true, {
		evt = "modifyMaxHp",
		maxHp = maxHp,
		hp = hp
	}
end
