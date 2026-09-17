local FightBear = class("FightBear")
local var_0_1 = {
	ani = "xp",
	offsetZ = 1,
	offsetY = 0,
	offsetX = 0,
	filename = "203920_effect"
}

function FightBear:ctor(arg_1_1, arg_1_2)
	self._contracter = arg_1_1
	self._percent = arg_1_2
end

function FightBear:transferDamage(arg_2_1)
	local var_2_0 = FightManager.getCharacter(self._contracter)

	if not var_2_0 then
		return false
	end

	if var_2_0:getState() == STATUS_DIED or var_2_0:getState() == STATUS_REVIVAL then
		return false
	end

	arg_2_1.damage = CalculateExtraDamage(arg_2_1.damagetype, arg_2_1.damage, FightManager.getCharacter(arg_2_1.sourceindex), var_2_0)

	var_2_0:beHitted({
		damage = arg_2_1.damage * self._percent,
		damagetype = arg_2_1.damagetype,
		info = {},
		sourceindex = arg_2_1.sourceindex
	}, true)

	return true
end

function FightBear:getIndex()
	return self._contracter
end

function FightBear:getEffect()
	return var_0_1
end

function FightBear:getPercent()
	return self._percent
end

return FightBear
