local var_0_0 = type
local var_0_2 = table
local var_0_3 = math.max
local var_0_4 = math.min
local var_0_5 = math.abs
local var_0_6 = math.pow
local var_0_7 = math.sqrt
local var_0_8 = {}
local var_0_9 = {}
local var_0_10 = {}
local var_0_11 = {}
local var_0_12 = {}

function FightCharacter:getDistance()
	return self._distance
end

function FightCharacter:addDistance(arg_2_1)
	self._distance = self._distance + arg_2_1
end

function FightCharacter:getDirection()
	return self._direction
end

function FightCharacter:switchDirection(arg_4_1)
	if self._direction ~= arg_4_1 then
		self._direction = arg_4_1

		self.skeleton:setScale(self._direction * STANDARD_SCALE * self:getAttribute("model_scale") * self:getAttribute("model_flip"), STANDARD_SCALE * self:getAttribute("model_scale"))
	end
end

function FightCharacter:getRelativeDir(arg_5_1)
	if not arg_5_1 then
		return self._direction
	end

	if var_0_0(arg_5_1) ~= "string" then
		return self._direction
	end

	local var_5_0 = FightManager.getCharacter(arg_5_1)

	if not var_5_0 then
		return self._direction
	end

	local var_5_1 = self:getStandardPosition()
	local var_5_2 = var_5_0:getStandardPosition()

	if var_5_1 == var_5_2 then
		return self._direction
	else
		return var_5_1 < var_5_2 and 1 or -1
	end
end

function FightCharacter:isRunning()
	return self._running
end

FightCharacter.checkRunningStatus = FightCharacter.isRunning

function FightCharacter:setRushForward(arg_7_1)
	if self._carriedconf then
		return
	end

	self._rushingForward = self._rushingForward or var_0_8.new()

	self._rushingForward:refresh(arg_7_1)
	self:finishForce()
	self:lockMove()
end

function FightCharacter:removeRushingForward()
	if self._rushingForward then
		self:setSpeed(0)
		self:unlockMove()
		self._rushingForward:finish()

		self._rushingForward = nil
	end
end

function FightCharacter:setCarriedConf(arg_9_1, arg_9_2)
	if self.statuspool:checkStatus("forceimmune") then
		return
	end

	self._carriedconf = var_0_9.new()

	self._carriedconf:attach(arg_9_1, arg_9_2)
	self:removeRushingForward()
	self:finishForce()
	self:lockMove()
end

function FightCharacter:removeCarriedConf()
	if self._carriedconf then
		self:setSpeed(0)
		self:unlockMove()

		self._carriedconf = nil
	end
end

function FightCharacter:getCarriedFix(arg_11_1, arg_11_2)
	if self._direction == 1 then
		if arg_11_2.left - arg_11_1.right < 0 then
			return -1 * (arg_11_2.left - arg_11_1.right) * 60
		else
			return 0
		end
	elseif arg_11_2.right - arg_11_1.left > 0 then
		return -1 * (arg_11_2.right - arg_11_1.left) * 60
	else
		return 0
	end
end

function FightCharacter:playForce(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if self.statuspool:checkStatus("forceimmune") then
		return false
	end

	if self._carriedconf then
		return false
	end

	if not arg_12_4 and self._rushingForward then
		return false
	end

	arg_12_1 = arg_12_1 - self:getAttribute("reforce")

	if arg_12_1 <= 0 then
		return false
	end

	self._fightforce = var_0_10.new()

	self._fightforce:refresh({
		distance = arg_12_1 * arg_12_2,
		time = arg_12_3
	})

	if arg_12_4 and not self.statuspool:checkStatus("antihitdown") then
		self:shutDown()
	end

	self:lockMove()

	return true
end

FightCharacter.playAttackForce = FightCharacter.playForce
FightCharacter.playXPForce = FightCharacter.playForce

function FightCharacter:finishForce()
	self._fightforce = nil

	self:setSpeed(0)
	self:unlockMove()
end

function FightCharacter.setTurnbackLimit(arg_14_0, arg_14_1)
	arg_14_0._turnbackLimit = arg_14_1
end

function FightCharacter:lockMove()
	self._lockmove = true

	self:stopMoving()
end

function FightCharacter.unlockMove(arg_16_0)
	arg_16_0._lockmove = false
end

function FightCharacter.setSpeed(arg_17_0, arg_17_1)
	arg_17_0._speed = arg_17_1
end

function FightCharacter:getSpeed()
	if self._globallock then
		return 0
	end

	if self.statuspool:checkStatus("confine") then
		return 0
	end

	if self._carriedconf and not self._carriedconf:isLock() then
		return self._carriedconf:getSpeed()
	elseif self._rushingForward and not self._rushingForward:isLock() then
		return self._rushingForward:getSpeed()
	elseif self._fightforce then
		return self._fightforce:getSpeed()
	elseif self._pause then
		return 0
	elseif FightManager.getFightState() == FIGHTSTATUS_WAIT and self:getState() == STATUS_SEARCHING then
		return 400
	else
		return self._speed * self._moveforcedir
	end
end

function FightCharacter:keepMoving(arg_19_1, arg_19_2)
	if self._lockmove then
		return
	end

	self._moveforcedir = arg_19_2 or 1

	if arg_19_1 then
		self:setSpeed(arg_19_1)
	else
		self:setSpeed(self:getAttribute("movingspeed") * self._direction * (1 + global_fight_speedup))
	end

	if not self._running then
		self._running = true
		self._distance = 0

		self.skeleton:setTimeScale(FightManager.getBossSpeedUp())

		if self._unitorder == 1 then
			self:play("fly")
		else
			self:play("run")
		end
	elseif self:needChangeRunAni() then
		self.skeleton:setTimeScale(FightManager.getBossSpeedUp())

		if self._unitorder == 1 then
			self:play("fly")
		else
			self:play("run")
		end
	end

	self:slaveKeepMoving()
end

function FightCharacter:needChangeRunAni()
	if self._unitorder == 1 then
		return self._lastAniName ~= "fly"
	else
		return self._lastAniName ~= "run"
	end
end

function FightCharacter:slaveKeepMoving()
	if not self._slaves then
		return
	end

	for iter_21_0, iter_21_1 in ipairs(self._slaves) do
		iter_21_1:keepMoving()
	end
end

function FightCharacter:stopMoving()
	if self._running then
		self._running = false
		self._distance = 0

		self:setSpeed(0)
	end

	self:slaveStopMoving()
end

function FightCharacter:slaveStopMoving()
	if not self._slaves then
		return
	end

	for iter_23_0, iter_23_1 in ipairs(self._slaves) do
		iter_23_1:stopMoving()
	end
end

function FightCharacter:move(arg_24_1, arg_24_2)
	local var_24_0, var_24_1 = self:getPosition()

	self:setPosition(cc.p(var_24_0 + arg_24_1, var_24_1 + arg_24_2))

	if self._blinkdistance then
		self._blinkdistance = self._blinkdistance + arg_24_1
	end
end

function FightCharacter:updatePositionOnGrabed()
	if not self._grabed then
		return
	end

	local var_25_0 = self._grabed.sourceindex
	local var_25_1 = FightManager.getCharacter(self._grabed.sourceindex)

	if not var_25_1 then
		self:removeGrabed(var_25_0)

		return
	end

	if not var_25_1:isGrabing() then
		self:removeGrabed(var_25_0)

		return
	end

	local var_25_2 = var_25_1:getBonePositionByName(self._grabed.bonename)

	if not var_25_2 then
		return
	end

	local var_25_3, var_25_4 = var_25_1:getPosition()

	self:setPosition(cc.p(var_25_3 + var_25_2.x * STANDARD_SCALE * var_25_1:getAttribute("model_scale") * var_25_1:getDirection(), var_25_4 + var_25_2.y * STANDARD_SCALE * var_25_1:getAttribute("model_scale") - self:getModelHeight() / 2))
end

function FightCharacter:updateMoveBehavior(arg_26_1)
	if self._grabed then
		self:stopMoving()
		self:updatePositionOnGrabed()
	elseif self._carriedconf and not self._carriedconf:isLock() then
		if self._carriedconf:isFinish() then
			self:removeCarriedConf()
		end
	elseif self._rushingForward and not self._rushingForward:isLock() then
		self._rushingForward:update(arg_26_1)

		if self._rushingForward:isFinish() then
			self:removeRushingForward()
		end
	elseif self._fightforce then
		self._fightforce:update(arg_26_1)

		if self._fightforce:isFinish() then
			self:finishForce()
		end
	elseif self.statuspool:getStatus("fear") and not self:isMiddleLevelSuppressNow() and not self.statuspool:checkStatus("forceimmune") then
		local var_26_0 = self._feardir or 1
		local var_26_1 = 100 * var_26_0

		self:switchDirection(var_26_0)
		self:keepMoving(var_26_1)
	end
end

function FightCharacter:updateGravity(arg_27_1)
	if not self._enablegravity then
		return
	end

	if self._fightforceY then
		self:setPositionY(self._fightforceY:update(arg_27_1))

		if self._fightforceY:isFinish() then
			self:removeFightForceY()
		end
	elseif self._gravity then
		self:setPositionY(self._gravity:update(arg_27_1))

		if self._gravity:isFinish() then
			self:removeGravity()
		end
	elseif var_0_5(self:getPositionY() - self._defaulty) > 5 then
		self:setGravity()
	end
end

function FightCharacter:playForceY(arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	if self.statuspool:checkStatus("forceimmune") then
		return false
	end

	self:removeGravity()

	self._fightforceY = self._fightforceY or var_0_11.new()

	self._fightforceY:refresh({
		distance = arg_28_1,
		time = arg_28_2,
		speed = arg_28_3,
		begin = self:getPositionY(),
		final = self._defaulty
	})

	if arg_28_4 then
		self:shutdown()
	end
end

function FightCharacter:removeFightForceY()
	if self._fightforceY then
		self._fightforceY = nil
	end
end

function FightCharacter:setGravity(arg_30_1, arg_30_2, arg_30_3, arg_30_4)
	arg_30_2 = arg_30_2 or 0.1
	self._gravity = self._gravity or var_0_12.new()

	self._gravity:refresh({
		time = arg_30_2,
		begin = self:getPositionY(),
		change = arg_30_1
	})

	if arg_30_4 then
		self:shutDown(arg_30_4)
	end
end

function FightCharacter:setGravity()
	self._gravity = self._gravity or var_0_12.new()

	self._gravity:refresh({
		begin = self:getPositionY(),
		final = self._defaulty
	})
end

function FightCharacter:removeGravity()
	if self._gravity then
		self._gravity = nil
	end
end

function FightCharacter:resetGravity()
	self:removeGravity()
	self:setPositionY(self._defaulty)
end

local var_0_13 = 1.2e-08

function var_0_8.new()
	return setmetatable({}, {
		__index = var_0_8
	})
end

function var_0_8.refresh(arg_35_0, arg_35_1)
	arg_35_0._elapse = 0
	arg_35_0._duration = arg_35_1.time
	arg_35_0._distance = arg_35_1.distance
	arg_35_0._path = 0
	arg_35_0._speed = 0
	arg_35_0._locked = false
	arg_35_0._attached = setmetatable({}, {
		__mode = "kv"
	})
end

function var_0_8:update(arg_36_1)
	self._elapse = self._elapse + arg_36_1

	local var_36_0 = self._distance * var_0_4(1, self._elapse / self._duration)

	self._speed = (var_36_0 - self._path) / var_0_3(arg_36_1, var_0_13)
	self._path = var_36_0

	for iter_36_0, iter_36_1 in ipairs(self._attached) do
		iter_36_1:update(self._speed)
	end
end

function var_0_8:getSpeed()
	if self._locked then
		return 0
	end

	return self._speed
end

function var_0_8:finish()
	self._speed = 0
	self._elapse = self._duration

	for iter_38_0, iter_38_1 in ipairs(self._attached) do
		iter_38_1:update(0)
	end
end

function var_0_8:isFinish()
	return self._elapse >= self._duration
end

function var_0_8:attach(arg_40_1)
	var_0_2.insert(self._attached, arg_40_1)
end

function var_0_8.lock(arg_41_0)
	arg_41_0._locked = true
end

function var_0_8.unlock(arg_42_0)
	arg_42_0._locked = false
end

function var_0_8:isLock()
	return self._locked
end

function var_0_9.new()
	return setmetatable({}, {
		__index = var_0_9
	})
end

function var_0_9.attach(arg_45_0, arg_45_1, arg_45_2)
	arg_45_1:attach(arg_45_0)

	arg_45_0._src = arg_45_1
	arg_45_0._speed = 0
	arg_45_0._locked = false
	arg_45_0._needfix = arg_45_2
end

function var_0_9.update(arg_46_0, arg_46_1)
	arg_46_0._speed = arg_46_1
end

function var_0_9:getSpeed()
	if self._locked then
		return 0
	end

	if self._needfix then
		self._needfix = nil

		return self._speed + self._needfix
	else
		return self._speed
	end
end

function var_0_9:isFinish()
	return self._src:isFinish()
end

function var_0_9.lock(arg_49_0)
	arg_49_0._locked = true
end

function var_0_9.unlock(arg_50_0)
	arg_50_0._locked = false
end

function var_0_9:isLock()
	return self._locked
end

function var_0_10.new()
	return setmetatable({}, {
		__index = var_0_10
	})
end

function var_0_10.refresh(arg_53_0, arg_53_1)
	arg_53_0._elapse = 0
	arg_53_0._duration = arg_53_1.time
	arg_53_0._distance = arg_53_1.distance
	arg_53_0._path = 0
	arg_53_0._speed = 0
end

function var_0_10:update(arg_54_1)
	if self._elapse <= self._duration / 3 then
		self._elapse = self._elapse + arg_54_1

		local var_54_0 = self._distance * 0.67 * var_0_4(1, self._elapse * 3 / self._duration)

		self._speed = (var_54_0 - self._path) / var_0_3(arg_54_1, var_0_13)
		self._path = var_54_0
	else
		self._elapse = self._elapse + arg_54_1

		local var_54_1 = self._distance * var_0_4(1, self._elapse / self._duration)

		self._speed = (var_54_1 - self._path) / var_0_3(arg_54_1, var_0_13)
		self._path = var_54_1
	end
end

function var_0_10:getSpeed()
	return self._speed
end

function var_0_10:isFinish()
	return self._elapse >= self._duration
end

local var_0_14 = 2000

function var_0_11.new()
	return setmetatable({}, {
		__index = var_0_11
	})
end

function var_0_11:refresh(arg_58_1)
	if arg_58_1.speed then
		self:initWithSpeed(arg_58_1.speed, arg_58_1.begin, arg_58_1.final)
	else
		self:initWithDistance(arg_58_1.distance, arg_58_1.time, arg_58_1.begin)
	end
end

function var_0_11:initWithSpeed(arg_59_1, arg_59_2, arg_59_3)
	self._elapse = 0
	self._begin = arg_59_2
	self._speed = arg_59_1

	if arg_59_1 > 0 then
		self._duration = arg_59_1 / var_0_14
		self._change = arg_59_1 * self._duration / 2
		self._accelerate = var_0_14
	else
		self._change = -var_0_5(arg_59_3 - arg_59_2)
		self._duration = self._change / self._speed
	end
end

function var_0_11:initWithDistance(arg_60_1, arg_60_2, arg_60_3)
	self._elapse = 0
	self._begin = arg_60_3
	self._duration = arg_60_2
	self._change = arg_60_1

	if arg_60_1 > 0 then
		self._accelerate = 2 * self._change / var_0_6(self._duration, 2)
		self._speed = self._accelerate * self._duration
	else
		self._speed = self._change / self._duration
	end
end

function var_0_11:update(arg_61_1)
	self._elapse = self._elapse + arg_61_1

	if self._elapse <= 0 then
		return self._begin
	elseif self._change < 0 then
		return self._begin + self._change * var_0_4(1, self._elapse / self._duration)
	elseif self._elapse >= self._duration then
		return self._begin + self._change
	else
		return self._begin + self._speed * self._elapse - self._accelerate / 2 * var_0_6(self._elapse, 2)
	end
end

function var_0_11:isFinish()
	return self._elapse >= self._duration
end

function var_0_12.new()
	return setmetatable({}, {
		__index = var_0_12
	})
end

function var_0_12:refresh(arg_64_1)
	self._elapse = 0
	self._begin = arg_64_1.begin
	self._change = arg_64_1.final - arg_64_1.begin
	self._duration = var_0_7(var_0_5(self._change) * 2 / var_0_14)
end

function var_0_12:update(arg_65_1)
	self._elapse = self._elapse + arg_65_1

	if self._elapse <= 0 then
		return self._begin
	elseif self._elapse >= self._duration then
		return self._begin + self._change
	else
		return self._begin - var_0_14 / 2 * var_0_6(self._elapse, 2)
	end
end

function var_0_12:isFinish()
	return self._elapse >= self._duration
end
