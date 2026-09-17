local var_0_0 = {}
local total_skill_data = require("data.total_skill_data")
local skill_data = require("data.skill_data")

function var_0_0:init(arg_1_1)
	self.ref.character = arg_1_1
	self.aicfg = require(arg_1_1.model.cfg)
	self.skillcfg = require(arg_1_1.model.spinecfg)
	self.co = nil
end

function var_0_0:resetCfg()
	self.aicfg = require(self.ref.character.model.cfg)
	self.skillcfg = require(self.ref.character.model.spinecfg)
end

function var_0_0:runFight()
	if self.co ~= nil then
		return
	end

	self.co = coroutine.create(function()
		repeat
			if self._finish then
				break
			end

			local var_4_0 = self.ref.character

			if not self.ref.character:canCharacterFight() then
				self:yieldFight()
			elseif self.usexp then
				self.usexp = nil

				self:useSkill(self.usexp)
			else
				self:doMaintree()
			end

			self._reset = false
			var_4_0.target = nil
			var_4_0._locktargetpool = nil
			var_4_0._lockdistance = nil
			var_4_0._lockturnbacklimit = nil
		until not true
	end)
	self._fighting = true
	self._yielding = false
	self._reset = false
	self._finish = false

	local var_3_0, var_3_1 = coroutine.resume(self.co)

	assert(var_3_0, var_3_1)
end

function var_0_0:finishFight()
	self._finish = true

	self:updateFight("finishFight")

	self._fighting = false
	self.co = nil
end

function var_0_0:reset()
	self._reset = true

	self:updateFight("reset")
end

function var_0_0:updateFight(arg_7_1)
	if self._fighting and self._yielding then
		self._yielding = false

		local var_7_0, var_7_1 = coroutine.resume(self.co)

		assert(var_7_0, var_7_1)

		return true
	else
		return false
	end
end

function var_0_0:yieldFight()
	if coroutine.running() == self.co then
		self._yielding = true

		coroutine.yield()
	end
end

function var_0_0:resetToXP()
	self.usexp = "xp"

	self:reset()
end

function var_0_0:resetToSkill(arg_10_1)
	self.usexp = arg_10_1

	self:reset()
end

function var_0_0:useXP()
	local var_11_0 = self.aicfg[self.ref.character:getSkillAIName("xp") .. "_manual"]
	local var_11_1 = false

	repeat
		if self:doTree(var_11_0) then
			var_11_1 = true

			break
		end

		if self:doWait() then
			var_11_1 = true

			self:yieldFight()
		end

		break
	until true

	return var_11_1
end

function var_0_0:useSkill(arg_12_1)
	if arg_12_1 == "xp" then
		return self:useXP()
	end

	local var_12_0 = self.aicfg[self.ref.character:getSkillAIName(arg_12_1) .. "_manual"]
	local var_12_1 = false

	repeat
		if self:doTree(var_12_0) then
			var_12_1 = true

			break
		end

		if self:doWait() then
			var_12_1 = true

			self:yieldFight()
		end

		break
	until true

	return var_12_1
end

function var_0_0:doMaintree()
	local var_13_0 = false

	repeat
		if self:checkFightWorldMapBound() then
			var_13_0 = true

			break
		end

		if self:doXP() then
			var_13_0 = true

			break
		end

		if self:doSkill() then
			var_13_0 = true

			break
		end

		if self:doAttack() then
			var_13_0 = true

			break
		end

		if self:doWait() then
			var_13_0 = true

			self:yieldFight()
		end

		break
	until true

	return var_13_0
end

function var_0_0:checkFightWorldMapBound()
	if not FightManager.isWorldMapExist() then
		return false
	end

	local var_14_0 = self.ref.character
	local var_14_1 = self.ref.character:getStandardPosition()

	if FightManager.isOutOfWorldMapRightBound(var_14_1) then
		var_14_0:switchDirection(-1)
		var_14_0:move_forward()
		self:yieldFight()

		return true
	elseif FightManager.isOutOfWorldMapLeftBound(var_14_1) then
		var_14_0:switchDirection(1)
		var_14_0:move_forward()
		self:yieldFight()

		return true
	else
		return false
	end
end

function var_0_0:doXP()
	local var_15_0 = self.ref.character:getSkillAIName("xp")

	if not var_15_0 then
		return false
	end

	local var_15_1 = self.aicfg[var_15_0]

	if not self.aicfg[var_15_0] then
		return false
	end

	return self:doTree(var_15_1)
end

function var_0_0:doSkill()
	local var_16_0 = self.ref.character:getNormalSkillList()

	for iter_16_0 = 1, #var_16_0 do
		if self.aicfg[total_skill_data[var_16_0[iter_16_0]].ainame or "xp"] and self:doTree(self.aicfg[total_skill_data[var_16_0[iter_16_0]].ainame or "xp"]) then
			return true
		end
	end

	return false
end

function var_0_0:doAttack()
	return self:doTree(self.aicfg.attack)
end

function var_0_0:doWait()
	if self._reset or self._finish then
		return false
	end

	self.ref.character:doBehavior("wait", 0.1)

	return true
end

function var_0_0:doTree(arg_19_1)
	local var_19_0 = arg_19_1.type or "sequence"

	if var_19_0 == "sequence" then
		return self:doSequence(arg_19_1)
	elseif var_19_0 == "selector" then
		return self:doSelector(arg_19_1)
	elseif var_19_0 == "circle" then
		return self:doCircle(arg_19_1)
	end
end

local function var_0_3(arg_20_0, arg_20_1)
	return arg_20_0 == "useSkill" and arg_20_1 ~= "xp"
end

function var_0_0:doSequence(arg_21_1)
	for iter_21_0 = 1, #arg_21_1 do
		local var_21_0
		local var_21_1

		if arg_21_1[iter_21_0].method then
			if var_0_3(arg_21_1[iter_21_0].method, arg_21_1[iter_21_0].param) and self.ref.character:needWaitForAttack() then
				self.ref.character:doBehavior("wait", self.ref.character._attackwait)
				self.ref.character:setWaitAttackTimer()
				self:yieldFight()

				if self._reset or self._finish then
					return false
				end
			end

			var_21_0, var_21_1 = self.ref.character:doBehavior(arg_21_1[iter_21_0].method, arg_21_1[iter_21_0].param, arg_21_1[iter_21_0].operator, nil)

			if var_21_0 and arg_21_1[iter_21_0].yield then
				self:yieldFight()
			end
		else
			var_21_0 = self:doTree(arg_21_1[iter_21_0])
		end

		if self._reset or self._finish then
			return false
		end

		if not var_21_0 then
			return false
		end
	end

	return true
end

function var_0_0:doSelector(arg_22_1)
	for iter_22_0 = 1, #arg_22_1 do
		local var_22_0
		local var_22_1

		if arg_22_1[iter_22_0].method then
			if var_0_3(arg_22_1[iter_22_0].method, arg_22_1[iter_22_0].param) and self.ref.character:needWaitForAttack() then
				self.ref.character:doBehavior("wait", self.ref.character._attackwait)
				self.ref.character:setWaitAttackTimer()
				self:yieldFight()

				if self._reset or self._finish then
					return false
				end
			end

			var_22_0, var_22_1 = self.ref.character:doBehavior(arg_22_1[iter_22_0].method, arg_22_1[iter_22_0].param, arg_22_1[iter_22_0].operator, nil)

			if var_22_0 and arg_22_1[iter_22_0].yield then
				self:yieldFight()
			end
		else
			var_22_0 = self:doTree(arg_22_1[iter_22_0])
		end

		if self._reset or self._finish then
			return false
		end

		if var_22_0 then
			return true
		end
	end

	return false
end

function var_0_0:doCircle(arg_23_1)
	local var_23_0 = 0
	local var_23_1 = {}

	for iter_23_0 = 1, arg_23_1.maxround do
		for iter_23_1 = 1, #arg_23_1 do
			local var_23_2
			local var_23_3

			if arg_23_1[iter_23_1].method then
				var_23_2, var_23_3 = self.character:doBehavior(arg_23_1[iter_23_1].method, arg_23_1[iter_23_1].param, arg_23_1[iter_23_1].operator, nil, var_23_1)

				if var_23_2 and arg_23_1[iter_23_1].yield then
					self:yieldFight()
				end
			else
				var_23_2 = self:doTree(arg_23_1[iter_23_1])
			end

			if self._reset or self._finish then
				return false
			end

			if not var_23_2 then
				break
			end
		end

		var_23_0 = var_23_0 + 1
	end

	return var_23_0 > 0
end

local var_0_4 = {
	__index = var_0_0
}

function var_0_0.new(arg_24_0)
	local var_24_0 = setmetatable({}, var_0_4)

	var_24_0.ref = setmetatable({}, {
		__mode = "kv"
	})

	var_24_0:init(arg_24_0)

	return var_24_0
end

return var_0_0
