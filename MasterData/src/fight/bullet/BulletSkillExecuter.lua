function BulletSprite:catapult_next_target(arg_1_1)
	local var_1_0 = arg_1_1.condition
	local var_1_1 = self.fightmsg

	if arg_1_1.maxcatapult <= self.fightmsg.catapult then
		return false
	end

	if self.target then
		var_1_1.hitted[self.target] = true
	end

	local var_1_2, var_1_3 = self.target:match("([^@]+)@(.+)")
	local var_1_4 = {}

	if self.charactertype == "player" then
		if var_1_2 == "players" then
			var_1_4 = self.character:getAreaTeammate(self:getStandardPosition(), arg_1_1.area, arg_1_1.area)
		elseif var_1_2 == "enemies" then
			var_1_4 = self.character:getAreaOponent(self:getStandardPosition(), arg_1_1.area, arg_1_1.area)
		end
	elseif self.charactertype == "enemy" then
		if var_1_2 == "players" then
			var_1_4 = self.character:getAreaOponent(self:getStandardPosition(), arg_1_1.area, arg_1_1.area)
		elseif var_1_2 == "enemies" then
			var_1_4 = self.character:getAreaTeammate(self:getStandardPosition(), arg_1_1.area, arg_1_1.area)
		end
	end

	if #var_1_4 <= 0 then
		return false
	end

	local var_1_5 = self._unitorder

	if self:is_locking_teammate(var_1_2) then
		var_1_5 = 999
	end

	if var_1_0 == "nearest" then
		local var_1_6 = {}
		local var_1_7 = self:getStandardPosition()

		for iter_1_0, iter_1_1 in pairs(var_1_4) do
			if iter_1_1:canBeLocked(var_1_5) and iter_1_1.index ~= self.target then
				var_1_6[#var_1_6 + 1] = {
					id = iter_1_0,
					index = iter_1_1.index,
					distance = math.abs(iter_1_1:getPosition() - var_1_7)
				}
			end
		end

		if #var_1_6 <= 0 then
			return false
		end

		table.sort(var_1_6, function(arg_2_0, arg_2_1)
			if arg_2_0.distance == arg_2_1.distance then
				return arg_2_0.id < arg_2_1.id
			else
				return arg_2_0.distance < arg_2_1.distance
			end
		end)

		self.target = var_1_6[1].index
	elseif var_1_0 == "next" then
		local var_1_8

		for iter_1_2, iter_1_3 in pairs(var_1_4) do
			if iter_1_3:canBeLocked(var_1_5) and not var_1_1.hitted[iter_1_3.index] then
				var_1_8 = iter_1_3.index

				break
			end
		end

		if not var_1_8 then
			return false
		end

		self.target = var_1_8
	elseif var_1_0 == "random" then
		local var_1_10 = {}

		for iter_1_4, iter_1_5 in pairs(var_1_4) do
			if iter_1_5:canBeLocked(var_1_5) then
				table.insert(var_1_10, iter_1_5.index)
			end
		end

		if #var_1_10 <= 0 then
			return false
		end

		self.target = #var_1_10 == 1 and var_1_10[1] or var_1_10[math.random(#var_1_10)]
	elseif var_1_0 == "normal" then
		local var_1_12 = {}

		for iter_1_6, iter_1_7 in pairs(var_1_4) do
			if iter_1_7:canBeLocked(var_1_5) and iter_1_7.index ~= self.target then
				table.insert(var_1_12, iter_1_7.index)
			end
		end

		if #var_1_12 <= 0 then
			return false
		end

		self.target = #var_1_12 == 1 and var_1_12[1] or var_1_12[math.random(#var_1_12)]
	end

	var_1_1.catapult = var_1_1.catapult + 1

	return true
end
