-- chunkname: @modules/logic/versionactivity3_7/towerv3a7/model/TowerV3a7ChessMO.lua

module("modules.logic.versionactivity3_7.towerv3a7.model.TowerV3a7ChessMO", package.seeall)

local TowerV3a7ChessMO = pureTable("TowerV3a7ChessMO")

function TowerV3a7ChessMO:init(chessConfig)
	self.id = chessConfig.id
	self.chessConfig = chessConfig
	self.health = chessConfig.defaultHealth
	self.maxHealth = chessConfig.health
	self._location = chessConfig.location
	self._tempLocation = 0

	local skillParams = string.splitToNumber(chessConfig.skill1, "#")

	self.skillType = skillParams[1]
	self.skillParam = skillParams[2]
	self.skillType2 = chessConfig.skill2
	self._state = TowerV3a7Enum.ChessState.Normal
	self.time = TowerV3a7Model.instance:getTime()
	self.pathfindingTime = 0
	self.attackTime = 0
	self.hurtList = {}
	self.tempHealth = 0
	self.targetRoomId = 0
end

function TowerV3a7ChessMO:setTargetRoomId(id)
	self.targetRoomId = id
end

function TowerV3a7ChessMO:getTargetRoomId()
	return self.targetRoomId
end

function TowerV3a7ChessMO:prepareFight()
	tabletool.clear(self.hurtList)

	self.tempHealth = self.health
end

function TowerV3a7ChessMO:endFight()
	if #self.hurtList > 0 then
		self.health = self.tempHealth
		self.isAfterBattle = true
	end
end

function TowerV3a7ChessMO:kill()
	self._isKill = true
end

function TowerV3a7ChessMO:addHurt(value)
	if self.tempHealth <= 0 then
		return
	end

	if value > 0 then
		local value = math.min(value, self.maxHealth - self.tempHealth)

		if value > 0 then
			table.insert(self.hurtList, value)
		end
	else
		if self._isKill then
			table.insert(self.hurtList, -self.tempHealth)

			self.tempHealth = 0

			return
		end

		if self.skillType == TowerV3a7Enum.SkillType.Type2 and math.random(0, 1000) < self.skillParam then
			return
		end

		if self.skillType2 == TowerV3a7Enum.PassiveSkillType.Type1 then
			local curHealth = self.tempHealth
			local hp = 6

			if curHealth < hp then
				local num = hp - curHealth
				local prob = 200 * num
				local randomProb = math.random(0, 1000)

				if randomProb <= prob then
					return
				end
			end
		end

		local hurtValue = math.min(math.abs(value), self.tempHealth)

		table.insert(self.hurtList, -hurtValue)
	end

	self.tempHealth = self.tempHealth + value

	if self.tempHealth > self.maxHealth then
		self.tempHealth = self.maxHealth
	end
end

function TowerV3a7ChessMO:setLocation(location)
	self._location = location
end

function TowerV3a7ChessMO:getLocation()
	return self._location
end

function TowerV3a7ChessMO:setTempLocation(location)
	if self._tempLocation ~= 0 and location ~= 0 then
		logError(string.format("id:%s tempLocation:%s is not 0 location:%s", self.id, self._tempLocation, location))
	end

	self._tempLocation = location
end

function TowerV3a7ChessMO:getTempLocation()
	return self._tempLocation
end

function TowerV3a7ChessMO:moveFinish()
	self:setState(TowerV3a7Enum.ChessState.Normal)
	self:setLocation(self._tempLocation)
	self:setTempLocation(0)
end

function TowerV3a7ChessMO:setState(state)
	self._state = state

	if self._state == TowerV3a7Enum.ChessState.Moving then
		self.time = TowerV3a7Model.instance:getTime()
	end
end

function TowerV3a7ChessMO:getState(roomId)
	if roomId and self._state == TowerV3a7Enum.ChessState.Moving then
		if roomId == self._location then
			return TowerV3a7Enum.ChessState.SrcMoving
		elseif roomId == self._tempLocation then
			return TowerV3a7Enum.ChessState.DstMoving
		end
	end

	return self._state
end

function TowerV3a7ChessMO:isDead()
	return self.health <= 0
end

function TowerV3a7ChessMO:deadInFight()
	return self.tempHealth <= 0
end

function TowerV3a7ChessMO:getDstMovingProgress()
	if self.chessConfig.move <= 0 then
		return 0
	end

	local deltaTime = TowerV3a7Model.instance:getTime() - self.time
	local progress = deltaTime / self.chessConfig.move
	local value = 1 - progress

	if value < 0 then
		value = 0
	end

	return value
end

return TowerV3a7ChessMO
