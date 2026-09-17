local var_0_0 = math
local var_0_2 = table
local var_0_3 = math.floor

function FightCharacter:initImpactPos()
	self._size = {
		width = var_0_3(self:getAttribute("model_weight") * STANDARD_SCALE * self:getAttribute("model_scale")),
		height = var_0_3(self:getAttribute("model_height") * STANDARD_SCALE * self:getAttribute("model_scale"))
	}
end

function FightCharacter:setImpactSize(arg_2_1, arg_2_2)
	self._size.width = arg_2_1
	self._size.height = arg_2_2
end

function FightCharacter:getRootOffsetX()
	return self.skeleton:getRootPosition().x
end

function FightCharacter:getRootOffsetY()
	return self.skeleton:getRootPosition().y
end

function FightCharacter:getStandardPosition()
	local var_5_0, var_5_1 = self:getPosition()

	return var_0_3(var_5_0 + self.skeleton:getRootPosition().x * STANDARD_SCALE * self:getAttribute("model_scale") * self._direction - (self._defaulty - STANDARD_POSY) / MAP_OFFSET_SIN * MAP_OFFSET_COS)
end

function FightCharacter:get2DPosition()
	local var_6_0, var_6_1 = self:getPosition()
	local var_6_2 = self.skeleton:getRootPosition()

	return var_0_3(var_6_0 + var_6_2.x * STANDARD_SCALE * self:getAttribute("model_scale") * self._direction), var_0_3(var_6_1 + var_6_2.y * STANDARD_SCALE * self:getAttribute("model_scale"))
end

function FightCharacter:getRectPosition()
	return self:getStandardPosition(), self._size.width
end

function FightCharacter:get2dRectPosition()
	local var_8_0, var_8_1 = self:get2DPosition()

	return var_8_0, var_8_1, self._size.width
end

function FightCharacter.getOffsetPosition(arg_9_0, arg_9_1, arg_9_2)
	return
end

function FightCharacter:getCrashRect(arg_10_1)
	local var_10_0 = self:getStandardPosition()
	local var_10_1 = var_10_0 - self._size.width / 2
	local var_10_2 = var_10_0 + self._size.width / 2

	if arg_10_1 then
		if self:getDirection() == 1 then
			var_10_2 = var_10_2 + arg_10_1
		else
			var_10_1 = var_10_1 - arg_10_1
		end
	end

	return {
		left = var_10_1,
		right = var_10_2
	}
end

function FightCharacter:getRect()
	local var_11_0, var_11_1 = self:get2DPosition()

	return {
		x = var_11_0 - self._size.width / 2,
		y = var_11_1,
		width = self._size.width,
		height = self._size.height
	}
end

function FightCharacter:getModelWidth()
	return self._size.width
end

function FightCharacter:getModelHeight()
	return self._size.height
end

function FightCharacter:getModelSize()
	return self._size
end

function FightCharacter:getForwardBound()
	local var_15_0, var_15_1 = self:get2DPosition()

	return var_0_3(var_15_0 + (self._size.width + self:getAttribute("range")) * self._direction / 2)
end

function FightCharacter:getFocusForwardBound()
	local var_16_0, var_16_1 = self:get2DPosition()

	return var_0_3(var_16_0 + self._direction * var_0_0.pow(self._size.width + self:getAttribute("range"), 0.8))
end

function FightCharacter:getTarget()
	if not self.target then
		return nil
	end

	if type(self.target) == "string" then
		return FightManager.getCharacter(self.target)
	elseif type(self.target) == "table" then
		if #self.target == 0 then
			return nil
		end

		local var_17_0 = {}

		for iter_17_0, iter_17_1 in pairs(self.target) do
			var_17_0[#var_17_0 + 1] = FightManager.getCharacter(iter_17_1)
		end

		return var_17_0, true
	end
end

function FightCharacter:getAllOponent()
	local var_18_1 = {}

	for iter_18_0, iter_18_1 in pairs(FightManager[self.charactertype == "player" and (self.statuspool:checkStatus("addict") and "players" or "enemies") or self.statuspool:checkStatus("addict") and "enemies" or "players"]) do
		if (iter_18_1.index ~= self.index or not self.statuspool:checkStatus("addict")) and iter_18_1:canBeLocked(self:getAttackUnitOrder()) then
			var_18_1[#var_18_1 + 1] = iter_18_1
		end
	end

	return var_18_1
end

function FightCharacter:getAllTeammate()
	local var_19_1 = {}

	for iter_19_0, iter_19_1 in pairs(FightManager[self.charactertype == "player" and (self.statuspool:checkStatus("addict") and "enemies" or "players") or self.statuspool:checkStatus("addict") and "players" or "enemies"]) do
		if (iter_19_1.index ~= self.index or not self.statuspool:checkStatus("addict")) and iter_19_1:canBeLocked(999) then
			var_19_1[#var_19_1 + 1] = iter_19_1
		end
	end

	return var_19_1
end

function FightCharacter:getAreaOponent(arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	local var_20_1 = {}

	if self._direction == 1 then
		var_20_1.left = arg_20_1 - arg_20_2
		var_20_1.right = arg_20_1 + arg_20_3
	else
		var_20_1.left = arg_20_1 - arg_20_3
		var_20_1.right = arg_20_1 + arg_20_2
	end

	local var_20_2 = {}

	for iter_20_0, iter_20_1 in pairs(FightManager[self.charactertype == "player" and (self.statuspool:checkStatus("addict") and "players" or "enemies") or self.statuspool:checkStatus("addict") and "enemies" or "players"]) do
		if (iter_20_1.index ~= self.index or not self.statuspool:checkStatus("addict")) and iter_20_1:canBeLocked(arg_20_4 or self:getAttackUnitOrder()) and FightManager.fightSpriteCrash(var_20_1, iter_20_1:getCrashRect()) then
			var_20_2[#var_20_2 + 1] = iter_20_1
		end
	end

	return var_20_2
end

function FightCharacter:getAreaTeammate(arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	local var_21_1 = {}

	if self._direction == 1 then
		var_21_1.left = arg_21_1 - arg_21_2
		var_21_1.right = arg_21_1 + arg_21_3
	else
		var_21_1.left = arg_21_1 - arg_21_3
		var_21_1.right = arg_21_1 + arg_21_2
	end

	local var_21_2 = {}

	for iter_21_0, iter_21_1 in pairs(FightManager[self.charactertype == "player" and (self.statuspool:checkStatus("addict") and "enemies" or "players") or self.statuspool:checkStatus("addict") and "players" or "enemies"]) do
		if (iter_21_1.index ~= self.index or not self.statuspool:checkStatus("addict")) and iter_21_1:canBeLocked(999) and FightManager.fightSpriteCrash(var_21_1, iter_21_1:getCrashRect()) then
			var_21_2[#var_21_2 + 1] = iter_21_1
		end
	end

	return var_21_2
end

function FightCharacter:getNearestOponent()
	local var_22_0 = self:getStandardPosition()
	local var_22_1
	local var_22_2

	for iter_22_0, iter_22_1 in pairs(FightManager[self.charactertype == "player" and "enemies" or "players"]) do
		if iter_22_1:canBeLocked(self:getAttackUnitOrder()) then
			local var_22_3

			if not var_22_1 then
				var_22_1 = iter_22_1:getStandardPosition()
				var_22_2 = var_0_0.abs(var_22_1 - var_22_0)
				var_22_3 = iter_22_1
			elseif var_22_2 > var_0_0.abs(iter_22_1:getStandardPosition() - var_22_0) then
				var_22_1 = iter_22_1:getStandardPosition()
				var_22_2 = var_0_0.abs(var_22_1 - var_22_0)
				var_22_3 = iter_22_1
			end
		end
	end

	return nil
end

function FightCharacter:getNearestOponentPos()
	local var_23_0 = self:getStandardPosition()
	local var_23_1
	local var_23_2

	for iter_23_0, iter_23_1 in pairs(FightManager[self.charactertype == "player" and "enemies" or "players"]) do
		if iter_23_1:canBeLocked(self:getAttackUnitOrder()) then
			local var_23_3

			if not var_23_1 then
				var_23_1 = iter_23_1:getStandardPosition()
				var_23_2 = var_0_0.abs(var_23_1 - var_23_0)
				var_23_3 = iter_23_1:getModelWidth() / 2
			elseif var_23_2 > var_0_0.abs(iter_23_1:getStandardPosition() - var_23_0) then
				var_23_1 = iter_23_1:getStandardPosition()
				var_23_2 = var_0_0.abs(var_23_1 - var_23_0)
				var_23_3 = iter_23_1:getModelWidth() / 2
			end
		end
	end

	return var_23_1, nil
end

function FightCharacter:getCharacterHatred(arg_24_1)
	return self:getAttribute("hatred_" .. arg_24_1)
end

function FightCharacter:filter_target_in_area(arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	local var_25_0

	if self.charactertype == "player" then
		var_25_0 = arg_25_1 == "players" and 0 or 1
	elseif self.charactertype == "enemy" then
		var_25_0 = arg_25_1 == "enemies" and 0 or 1
	elseif self.charactertype == "slave" then
		var_25_0 = arg_25_1 == self.index:match("slave(.+)") and 0 or 1
	end

	if self.statuspool:checkStatus("addict") then
		var_25_0 = 1 - var_25_0
	end

	if var_25_0 == 0 then
		return self:getAreaTeammate(self:getStandardPosition(), arg_25_2, arg_25_3, arg_25_4)
	else
		return self:getAreaOponent(self:getStandardPosition(), arg_25_2, arg_25_3, arg_25_4)
	end
end

function FightCharacter:is_locking_teammate(arg_26_1)
	local var_26_0

	if self.charactertype == "player" then
		var_26_0 = arg_26_1 == "players" and 0 or 1
	elseif self.charactertype == "enemy" then
		var_26_0 = arg_26_1 == "enemies" and 0 or 1
	elseif self.charactertype == "slave" then
		var_26_0 = arg_26_1 == self.index:match("slave(.+)") and 0 or 1
	end

	if self.statuspool:checkStatus("addict") then
		var_26_0 = 1 - var_26_0
	end

	return var_26_0 == 0
end

function FightCharacter:is_target_teammate(arg_27_1)
	local var_27_0 = self.charactertype == "slave" and self.index:match("slave(.+)") or self.charactertype
	local var_27_1 = arg_27_1.charactertype == "slave" and arg_27_1.index:match("slave(.+)") or arg_27_1.charactertype

	return self.statuspool:checkStatus("addict") and var_27_0 ~= var_27_1 or var_27_0 == var_27_1
end

function FightCharacter:getTeammateByHP(arg_28_1, arg_28_2)
	local var_28_0 = {}

	for iter_28_0, iter_28_1 in pairs(FightManager[self.charactertype == "player" and "players" or "enemies"]) do
		if iter_28_1:canBeLocked(self:getUnitOrder()) then
			var_28_0[#var_28_0 + 1] = {
				id = iter_28_0,
				index = iter_28_1.index,
				hp = iter_28_1:getAttribute("curhp") + iter_28_1:getAttribute("singlehp") * (iter_28_1:getAttribute("curhpcount") - 1)
			}
		end
	end

	if #var_28_0 <= 0 then
		return nil
	end

	var_0_2.sort(var_28_0, function(arg_29_0, arg_29_1)
		if arg_29_0.hp == arg_29_1.hp then
			return arg_29_0.id < arg_29_1.id
		else
			return arg_29_0.hp < arg_29_1.hp
		end
	end)

	local var_28_1 = {}

	if arg_28_1 == "hp_lowest" then
		for iter_28_2 = 1, arg_28_2 do
			if not var_28_0[iter_28_2] then
				break
			end

			var_0_2.insert(var_28_1, var_28_0[iter_28_2].index)
		end
	elseif arg_28_1 == "hp_highest" then
		for iter_28_3 = 1, arg_28_2 do
			if not var_28_0[iter_28_3] then
				break
			end

			var_0_2.insert(var_28_1, var_28_0[#var_28_0 + 1 - iter_28_3].index)
		end
	end

	return var_28_1
end

function FightCharacter:getOponentByHp(arg_30_1, arg_30_2)
	local var_30_0 = {}

	for iter_30_0, iter_30_1 in pairs(FightManager[self.charactertype == "player" and "enemies" or "players"]) do
		if iter_30_1:canBeLocked(self:getUnitOrder()) and iter_30_1.index ~= self.index then
			var_30_0[#var_30_0 + 1] = {
				id = iter_30_0,
				index = iter_30_1.index,
				hp = iter_30_1:getAttribute("curhp") + iter_30_1:getAttribute("singlehp") * (iter_30_1:getAttribute("curhpcount") - 1)
			}
		end
	end

	if #var_30_0 <= 0 then
		return nil
	end

	var_0_2.sort(var_30_0, function(arg_31_0, arg_31_1)
		if arg_31_0.hp == arg_31_1.hp then
			return arg_31_0.id < arg_31_1.id
		else
			return arg_31_0.hp < arg_31_1.hp
		end
	end)

	local var_30_1 = {}

	if arg_30_1 == "hp_lowest" then
		for iter_30_2 = 1, arg_30_2 do
			if not var_30_0[iter_30_2] then
				break
			end

			var_0_2.insert(var_30_1, var_30_0[iter_30_2].index)
		end
	elseif arg_30_1 == "hp_highest" then
		for iter_30_3 = 1, arg_30_2 do
			if not var_30_0[iter_30_3] then
				break
			end

			var_0_2.insert(var_30_1, var_30_0[#var_30_0 + 1 - iter_30_3].index)
		end
	end

	return var_30_1
end

function FightCharacter:getTeammateByHpPercent(arg_32_1, arg_32_2)
	local var_32_0 = {}

	for iter_32_0, iter_32_1 in pairs(FightManager[self.charactertype == "player" and "players" or "enemies"]) do
		if iter_32_1:canBeLocked(self:getUnitOrder()) then
			var_32_0[#var_32_0 + 1] = {
				id = iter_32_0,
				index = iter_32_1.index,
				hp = (iter_32_1:getAttribute("curhp") + iter_32_1:getAttribute("singlehp") * (iter_32_1:getAttribute("curhpcount") - 1)) / iter_32_1:getAttribute("hp")
			}
		end
	end

	if #var_32_0 <= 0 then
		return nil
	end

	var_0_2.sort(var_32_0, function(arg_33_0, arg_33_1)
		if arg_33_0.hp == arg_33_1.hp then
			return arg_33_0.id < arg_33_1.id
		else
			return arg_33_0.hp < arg_33_1.hp
		end
	end)

	local var_32_1 = {}

	if arg_32_1 == "hp_percent_lowest" then
		for iter_32_2 = 1, arg_32_2 do
			if not var_32_0[iter_32_2] then
				break
			end

			var_0_2.insert(var_32_1, var_32_0[iter_32_2].index)
		end
	elseif arg_32_1 == "hp_percent_highest" then
		for iter_32_3 = 1, arg_32_2 do
			if not var_32_0[iter_32_3] then
				break
			end

			var_0_2.insert(var_32_1, var_32_0[#var_32_0 + 1 - iter_32_3].index)
		end
	end

	return var_32_1
end

function FightCharacter:getOponentByHpPercent(arg_34_1, arg_34_2)
	local var_34_0 = {}

	for iter_34_0, iter_34_1 in pairs(FightManager[self.charactertype == "player" and "enemies" or "players"]) do
		if iter_34_1:canBeLocked(self:getUnitOrder()) and iter_34_1.index ~= self.index then
			var_34_0[#var_34_0 + 1] = {
				id = iter_34_0,
				index = iter_34_1.index,
				hp = (iter_34_1:getAttribute("curhp") + iter_34_1:getAttribute("singlehp") * (iter_34_1:getAttribute("curhpcount") - 1)) / iter_34_1:getAttribute("hp")
			}
		end
	end

	if #var_34_0 <= 0 then
		return nil
	end

	var_0_2.sort(var_34_0, function(arg_35_0, arg_35_1)
		if arg_35_0.hp == arg_35_1.hp then
			return arg_35_0.id < arg_35_1.id
		else
			return arg_35_0.hp < arg_35_1.hp
		end
	end)

	local var_34_1 = {}

	if arg_34_1 == "hp_percent_lowest" then
		for iter_34_2 = 1, arg_34_2 do
			if not var_34_0[iter_34_2] then
				break
			end

			var_0_2.insert(var_34_1, var_34_0[iter_34_2].index)
		end
	elseif arg_34_1 == "hp_percent_highest" then
		for iter_34_3 = 1, arg_34_2 do
			if not var_34_0[iter_34_3] then
				break
			end

			var_0_2.insert(var_34_1, var_34_0[#var_34_0 + 1 - iter_34_3].index)
		end
	end

	return var_34_1
end

function FightCharacter:getOponentByDamage(arg_36_1, arg_36_2)
	local var_36_1 = {}

	for iter_36_0, iter_36_1 in pairs(FightManager[self.charactertype == "player" and (self.statuspool:checkStatus("addict") and "players" or "enemies") or self.statuspool:checkStatus("addict") and "enemies" or "players"]) do
		if (iter_36_1.index ~= self.index or not self.statuspool:checkStatus("addict")) and iter_36_1:canBeLocked(self:getAttackUnitOrder()) then
			var_36_1[#var_36_1 + 1] = {
				id = iter_36_0,
				index = iter_36_1.index,
				damage = iter_36_1:getAttribute("damage")
			}
		end
	end

	if #var_36_1 <= 0 then
		return nil
	end

	var_0_2.sort(var_36_1, function(arg_37_0, arg_37_1)
		return arg_37_0.damage < arg_37_1.damage
	end)

	local var_36_2 = {}

	if arg_36_1 == "damage_lowest" then
		for iter_36_2 = 1, arg_36_2 do
			if not var_36_1[iter_36_2] then
				break
			end

			var_0_2.insert(var_36_2, var_36_1[iter_36_2].index)
		end
	elseif arg_36_1 == "damage_highlest" then
		for iter_36_3 = 1, arg_36_2 do
			if not var_36_1[iter_36_3] then
				break
			end

			var_0_2.insert(var_36_2, var_36_1[#var_36_1 + 1 - iter_36_3].index)
		end
	end

	return var_36_2
end

function FightCharacter:getTeammateByDamage(arg_38_1, arg_38_2)
	local var_38_1 = {}

	for iter_38_0, iter_38_1 in pairs(FightManager[self.charactertype == "player" and (self.statuspool:checkStatus("addict") and "enemies" or "players") or self.statuspool:checkStatus("addict") and "players" or "enemies"]) do
		if iter_38_1:canBeLocked(self:getUnitOrder()) and iter_38_1.index ~= self.index then
			var_38_1[#var_38_1 + 1] = {
				id = iter_38_0,
				index = iter_38_1.index,
				damage = iter_38_1:getAttribute("damage")
			}
		end
	end

	if #var_38_1 <= 0 then
		return nil
	end

	var_0_2.sort(var_38_1, function(arg_39_0, arg_39_1)
		if arg_39_0.damage == arg_39_1.damage then
			return arg_39_0.id < arg_39_1.id
		else
			return arg_39_0.damage < arg_39_1.damage
		end
	end)

	local var_38_2 = {}

	if arg_38_1 == "damage_lowest" then
		for iter_38_2 = 1, arg_38_2 do
			if not var_38_1[iter_38_2] then
				break
			end

			var_0_2.insert(var_38_2, var_38_1[iter_38_2].index)
		end
	elseif arg_38_1 == "damage_highest" then
		for iter_38_3 = 1, arg_38_2 do
			if not var_38_1[iter_38_3] then
				break
			end

			var_0_2.insert(var_38_2, var_38_1[#var_38_1 + 1 - iter_38_3].index)
		end
	end

	return var_38_2
end

local function var_0_4(arg_40_0)
	for iter_40_0 = #arg_40_0, 2, -1 do
		local var_40_0 = var_0_0.random(iter_40_0)

		arg_40_0[iter_40_0], arg_40_0[var_40_0] = arg_40_0[var_40_0], arg_40_0[iter_40_0]
	end

	return arg_40_0
end

function FightCharacter:getOponentRandomFromAll(arg_41_1)
	local var_41_1 = {}

	for iter_41_0, iter_41_1 in pairs(FightManager[self.charactertype == "player" and (self.statuspool:checkStatus("addict") and "players" or "enemies") or self.statuspool:checkStatus("addict") and "enemies" or "players"]) do
		if iter_41_1:canBeLocked(self:getUnitOrder()) and iter_41_1.index ~= self.index then
			var_41_1[#var_41_1 + 1] = iter_41_1.index
		end
	end

	if #var_41_1 <= 0 then
		return nil
	end

	if arg_41_1 >= #var_41_1 then
		return var_41_1
	else
		local var_41_2 = {}
		local var_41_3 = var_0_4(var_41_1)

		for iter_41_2 = 1, arg_41_1 do
			var_41_2[iter_41_2] = var_41_3[iter_41_2]
		end

		return var_41_2
	end
end

function FightCharacter:getTeammateRandomFromAll(arg_42_1)
	local var_42_1 = {}

	for iter_42_0, iter_42_1 in pairs(FightManager[self.charactertype == "player" and (self.statuspool:checkStatus("addict") and "enemies" or "players") or self.statuspool:checkStatus("addict") and "players" or "enemies"]) do
		if iter_42_1:canBeLocked(self:getUnitOrder()) and iter_42_1.index ~= self.index then
			var_42_1[#var_42_1 + 1] = iter_42_1.index
		end
	end

	if #var_42_1 <= 0 then
		return nil
	end

	if arg_42_1 >= #var_42_1 then
		return var_42_1
	else
		local var_42_2 = {}
		local var_42_3 = var_0_4(var_42_1)

		for iter_42_2 = 1, arg_42_1 do
			var_42_2[iter_42_2] = var_42_3[iter_42_2]
		end

		return var_42_2
	end
end
