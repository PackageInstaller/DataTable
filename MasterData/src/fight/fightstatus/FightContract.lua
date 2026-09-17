local FightContract = class("FightContract")
local var_0_1 = {
	ani = "xp",
	offsetZ = 1,
	offsetY = 0,
	offsetX = 0,
	filename = "203920_effect"
}

function FightContract:ctor(arg_1_1, arg_1_2, arg_1_3)
	self._contracter = arg_1_1
	self._cd = arg_1_2
	self._curcd = 0
	self._duration = arg_1_3
	self._curduration = 0
end

function FightContract:trigger(arg_2_1)
	if self._curcd > 0 then
		return false
	end

	local var_2_0 = FightManager.getCharacter(self._contracter)

	if not var_2_0 then
		return false
	end

	if var_2_0:getState() == STATUS_DIED or var_2_0:getState() == STATUS_REVIVAL then
		return false
	end

	arg_2_1.damage = CalculateExtraDamage(arg_2_1.damagetype, arg_2_1.damage, FightManager.getCharacter(arg_2_1.sourceindex), var_2_0)

	var_2_0:beHitted({
		damage = arg_2_1.damage,
		damagetype = arg_2_1.damagetype,
		info = {},
		sourceindex = arg_2_1.sourceindex
	}, true)

	if self._curduration <= 0 then
		self._curduration = self._duration
	end

	return true
end

function FightContract:getIndex()
	return self._contracter
end

function FightContract:getEffect()
	return var_0_1
end

function FightContract:update(arg_5_1)
	if self._curduration > 0 then
		self._curduration = self._curduration - arg_5_1

		if self._curduration <= 0 then
			self._curcd = self._cd or 0
		end
	elseif self._curcd > 0 then
		self._curcd = self._curcd - arg_5_1
	end
end

return FightContract
