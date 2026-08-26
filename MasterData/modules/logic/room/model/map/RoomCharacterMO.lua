-- chunkname: @modules/logic/room/model/map/RoomCharacterMO.lua

module("modules.logic.room.model.map.RoomCharacterMO", package.seeall)

local RoomCharacterMO = pureTable("RoomCharacterMO")

function RoomCharacterMO:init(info)
	self.id = info.heroId
	self.heroId = info.heroId
	self.currentFaith = info.currentFaith or 0
	self.currentMinute = info.currentMinute or 0
	self.nextRefreshTime = info.nextRefreshTime or 0
	self.skinId = info.skinId

	if (not self.skinId or self.skinId == 0) and (RoomController.instance:isObMode() or RoomController.instance:isEditMode()) then
		local heroMO = HeroModel.instance:getByHeroId(self.heroId)

		if heroMO then
			self.skinId = heroMO.skin or self.skinId
		end
	end

	if not self.skinId or self.skinId == 0 then
		local heroConfig = HeroConfig.instance:getHeroCO(self.heroId)

		self.skinId = heroConfig.skinId
	end

	self.currentPosition = info.currentPosition
	self.characterState = info.characterState
	self.heroConfig = HeroConfig.instance:getHeroCO(self.heroId)
	self.skinConfig = SkinConfig.instance:getSkinCo(self.skinId)
	self.roomCharacterConfig = RoomConfig.instance:getRoomCharacterConfig(self.skinId)
	self._nextPositions = info.nextPositions or {}
	self._movePoint = info.movePoint or 0
	self._moveValue = info.moveValue or 0
	self._moveState = info.moveState or RoomCharacterEnum.CharacterMoveState.Idle
	self.stateDuration = info.stateDuration or 0
	self._moveDir = info.moveDir or Vector2.zero
	self._preMovePositions = info.preMovePositions
	self.isAnimal = info.isAnimal or false
	self.isTouch = info.isTouch or false
	self.trainCritterUid = info.trainCritterUid or self.trainCritterUid or nil
	self.sourceState = info.sourceState or RoomCharacterEnum.SourceState.Place
	self._currentInteractionId = nil
	self._replaceIdleState = nil
	self._positionCodeId = self._positionCodeId or 0
	self.tranMoveRate = 0.8

	self:_updatePositionCodeId()

	local str = CritterConfig.instance:getCritterConstStr(CritterEnum.ConstId.HeroMoveRate)

	if not string.nilorempty(str) then
		self.tranMoveRate = tonumber(str) * 0.001
	end
end

function RoomCharacterMO:getCanWade()
	return self.skinConfig.canWade > 0
end

function RoomCharacterMO:getMoveSpeed()
	return (self.roomCharacterConfig or nil) and (self.roomCharacterConfig.moveSpeed or 1)
end

function RoomCharacterMO:getMoveInterval()
	return (self.roomCharacterConfig or nil) and (self.roomCharacterConfig.moveInterval or 5)
end

function RoomCharacterMO:getMoveRate()
	if self.trainCritterUid then
		return self.tranMoveRate
	end

	return (self.roomCharacterConfig or nil) and (self.roomCharacterConfig.moveRate / 1000 or 0.5)
end

function RoomCharacterMO:getSpecialRate()
	return (self.roomCharacterConfig or nil) and (self.roomCharacterConfig.specialRate / 1000 or 0.5)
end

function RoomCharacterMO:isHasSpecialIdle()
	return self.roomCharacterConfig.specialIdle > 0
end

function RoomCharacterMO:getMoveState()
	if self._replaceIdleState and self._moveState == RoomCharacterEnum.CharacterMoveState.Idle then
		return self._replaceIdleState
	end

	return self._moveState
end

function RoomCharacterMO:isPlaceSourceState()
	return self.sourceState ~= RoomCharacterEnum.SourceState.Train
end

function RoomCharacterMO:isTrainSourceState()
	return self.sourceState == RoomCharacterEnum.SourceState.Train
end

function RoomCharacterMO:isCanPlaceByResId(resId)
	if resId == RoomResourceEnum.ResourceId.Empty or resId == RoomResourceEnum.ResourceId.None or resId == RoomResourceEnum.ResourceId.Flag or resId == RoomResourceEnum.ResourceId.River and self:getCanWade() then
		return true
	end

	return false
end

function RoomCharacterMO:isTraining()
	if self.trainCritterUid and self.trainCritterUid ~= 0 then
		return true
	end

	return false
end

function RoomCharacterMO:getMovingDir()
	return self._moveDir
end

function RoomCharacterMO:getPositionCodeId()
	return self._positionCodeId
end

function RoomCharacterMO:_updatePositionCodeId()
	self._positionCodeId = self._positionCodeId + 1
end

function RoomCharacterMO:getSpecialIdleWaterDistance()
	return (self.roomCharacterConfig or nil) and (self.roomCharacterConfig.waterDistance / 1000 or 0.5)
end

function RoomCharacterMO:setPosition(pos)
	self.currentPosition = pos

	self:_updatePositionCodeId()
end

function RoomCharacterMO:setPositionXYZ(x, y, z)
	self.currentPosition:Set(x, y, z)
	self:_updatePositionCodeId()
end

function RoomCharacterMO:getMoveTargetPosition()
	return (self._nextPositions and #self._nextPositions > 0 or nil) and self._nextPositions[#self._nextPositions]
end

function RoomCharacterMO:getMoveTargetPoint()
	local position = self:getMoveTargetPosition()

	return RoomCharacterHelper.positionRoundToPoint(position)
end

function RoomCharacterMO:getNearestPoint()
	local position = self.currentPosition

	return RoomCharacterHelper.positionRoundToPoint(position)
end

function RoomCharacterMO:setPreMove(preMovePositions)
	self._preMovePositions = preMovePositions

	self:_tryNextMovePosition()
end

function RoomCharacterMO:_tryNextMovePosition()
	local scene = GameSceneMgr.instance:getCurScene()

	scene.path:stopGetPath(self)

	local entity = scene.charactermgr:getCharacterEntity(self.id)

	if not entity then
		return
	end

	local seeker = entity.charactermove:getSeeker()

	if not seeker then
		return
	end

	while self._preMovePositions and #self._preMovePositions > 0 do
		local preMovePosition = self._preMovePositions[#self._preMovePositions]

		table.remove(self._preMovePositions, #self._preMovePositions)

		if ZProj.AStarPathBridge.HasPossiblePath(self.currentPosition, preMovePosition, seeker:GetTag()) then
			scene.path:tryGetPath(self, self.currentPosition, preMovePosition, self.onPathCall, self)

			return
		end
	end
end

function RoomCharacterMO:setMove(nextPositions)
	if not nextPositions or #nextPositions <= 0 then
		return
	end

	self._moveState = RoomCharacterEnum.CharacterMoveState.Move
	self._moveStartPosition = self.currentPosition

	self:clearPath()
	tabletool.addValues(self._nextPositions, nextPositions)

	self._movePoint = 0
	self.stateDuration = 0

	local scene = GameSceneMgr.instance:getCurScene()

	scene.path:stopGetPath(self)

	self._preMovePositions = nil
end

function RoomCharacterMO:getRemainMovePositions()
	local remainMovePositions = {}

	if self._moveState ~= RoomCharacterEnum.CharacterMoveState.Move then
		return remainMovePositions
	end

	if not self._nextPositions or #self._nextPositions <= 0 then
		return remainMovePositions
	end

	table.insert(remainMovePositions, self.currentPosition)

	for i = self._movePoint + 1, #self._nextPositions do
		table.insert(remainMovePositions, self._nextPositions[i])
	end

	return remainMovePositions
end

function RoomCharacterMO:endMove(isNotMoveToEndPoint)
	if self._moveState == RoomCharacterEnum.CharacterMoveState.Move then
		if not isNotMoveToEndPoint and self:_hasNextPosition() then
			local endPos = self._nextPositions[#self._nextPositions]

			self:setPositionXYZ(endPos.x, endPos.y, endPos.z)
		end

		self:_moveEnd()
	end
end

function RoomCharacterMO:canMove()
	if self.isAnimal then
		return false
	end

	if self.isTouch then
		return false
	end

	if self._currentInteractionId then
		return false
	end

	if self._isHasLockTime then
		self._isHasLockTime = self._nextUnLockTime > Time.time

		return false
	end

	local playingInteractionParam = RoomCharacterController.instance:getPlayingInteractionParam()

	if playingInteractionParam and (playingInteractionParam.heroId == self.heroId or playingInteractionParam.relateHeroId == self.heroId) then
		return false
	end

	return true
end

function RoomCharacterMO:setLockTime(lockTime)
	self._isHasLockTime = true
	self._nextUnLockTime = Time.time + lockTime

	if self._moveState == RoomCharacterEnum.CharacterMoveState.Move then
		self._moveState = RoomCharacterEnum.CharacterMoveState.Idle
	end
end

function RoomCharacterMO:_tryMoveNeighbor()
	if RoomCharacterController.instance:isCharacterListShow() then
		return
	end

	if not self:canMove() then
		return
	end

	local moveRate = self:getMoveRate()

	if moveRate <= math.random() then
		RoomCharacterController.instance:tryPlaySpecialIdle(self.heroId)

		return
	end

	self:moveNeighbor()
end

function RoomCharacterMO:moveNeighbor()
	local pointParams = {}
	local currentPoint = self:getMoveTargetPoint()
	local hexPoint = currentPoint.hexPoint
	local ranges = hexPoint:getInRanges(2)
	local currentPosition = RoomCharacterHelper.getCharacterPosition(currentPoint)

	for _, range in ipairs(ranges) do
		for direction = 0, 6 do
			local resourcePoint = ResourcePoint(range, direction)

			if resourcePoint ~= currentPoint then
				local position = RoomCharacterHelper.getCharacterPosition(resourcePoint)
				local distance = Vector2.Distance(position, currentPosition)

				table.insert(pointParams, {
					resourcePoint = resourcePoint,
					distance = distance
				})
			end
		end
	end

	pointParams = GameUtil.randomTable(pointParams)

	table.sort(pointParams, function(x, y)
		if math.abs(x.distance - y.distance) > 0.001 then
			return x.distance < y.distance
		end

		return false
	end)

	local bridgePositions = RoomCharacterHelper.getBridgePositions(self.currentPosition)
	local index

	if math.random() < 0.4 and (not self._preBridge or self._preBridge < 2) then
		index = 1
	else
		self._preBridge = 0
	end

	for _, bridgePosition in ipairs(bridgePositions) do
		local pointParam = {
			isBridge = true,
			position = bridgePosition
		}

		if index then
			table.insert(pointParams, index, pointParam)
		else
			table.insert(pointParams, pointParam)
		end
	end

	local scene = GameSceneMgr.instance:getCurScene()
	local entity = scene.charactermgr:getCharacterEntity(self.id)

	if entity ~= nil then
		local preMovePositions = {}

		for _, pointParam in ipairs(pointParams) do
			if not pointParam.position then
				local position = RoomCharacterHelper.getCharacterPosition3D(pointParam.resourcePoint, false)

				if RoomCharacterHelper.checkMoveStraightRule(self.currentPosition, position, self.heroId, entity, pointParam.isBridge) then
					self._preBridge = (self._preBridge or 0) + (pointParam.isBridge and 1 or 0)

					table.insert(preMovePositions, position)
				end
			end
		end

		self:setPreMove(preMovePositions)
	end
end

function RoomCharacterMO:onPathCall(param, pathList, isError, errorMsg)
	if not isError then
		local list = RoomVectorPool.instance:packPosList(pathList)
		local targetPosition = list[#list]

		if RoomCharacterHelper.isMoveCameraWalkable(list) and not RoomCharacterHelper.isOtherCharacter(targetPosition, self.heroId) then
			self:setMove(list)

			return
		end
	else
		logNormal("Room pathfinding Error : " .. tostring(errorMsg))
	end

	self:_tryNextMovePosition()
end

function RoomCharacterMO:_moveEnd(moveOver)
	self._moveState = RoomCharacterEnum.CharacterMoveState.Idle

	self:clearPath()

	self._movePoint = 0
	self._moveValue = 0
	self.stateDuration = 0

	local scene = GameSceneMgr.instance:getCurScene()

	scene.path:stopGetPath(self)

	self._preMovePositions = nil

	if moveOver then
		RoomCharacterController.instance:tryPlaySpecialIdle(self.heroId)
	end
end

function RoomCharacterMO:replaceIdleState(animState)
	self._replaceIdleState = animState
end

function RoomCharacterMO:clearPath()
	if #self._nextPositions > 0 then
		for i = #self._nextPositions, 1, -1 do
			RoomVectorPool.instance:recycle(self._nextPositions[i])
			table.remove(self._nextPositions, i)
		end
	end
end

function RoomCharacterMO:updateMove(deltaTime)
	if self.characterState ~= RoomCharacterEnum.CharacterState.Map then
		return
	end

	if RoomCharacterController.instance:isCharacterListShow() then
		return
	end

	if not self:canMove() then
		return
	end

	self.stateDuration = self.stateDuration + deltaTime

	local moveInterval = self:getMoveInterval()

	if moveInterval < self.stateDuration and self._moveState ~= RoomCharacterEnum.CharacterMoveState.Move then
		self:_tryMoveNeighbor()

		self.stateDuration = 0
	end

	if self._moveState == RoomCharacterEnum.CharacterMoveState.Move then
		local moveSpeed = self:getMoveSpeed()
		local moveDistance = deltaTime * moveSpeed * 0.2

		self:_move(moveDistance)
	end
end

function RoomCharacterMO:_move(moveDistance)
	if not self:_hasNextPosition() then
		self:_moveEnd()

		return
	end

	if moveDistance <= 0 then
		return
	end

	local waitMoveDistance = moveDistance
	local prePosition = self.currentPosition
	local nextPosition = self:_getNextPosition()
	local distance = Vector3.Distance(prePosition, nextPosition)

	while distance < waitMoveDistance do
		waitMoveDistance = waitMoveDistance - distance
		prePosition = nextPosition

		self:_moveToNextPosition()

		if self:_hasNextPosition() then
			nextPosition = self:_getNextPosition()
			distance = Vector3.Distance(prePosition, nextPosition)
		else
			distance = 0

			break
		end
	end

	if distance > 0 then
		self:setPosition(Vector3.Lerp(prePosition, nextPosition, waitMoveDistance / distance))

		local toDir = Vector2(nextPosition.x - prePosition.x, nextPosition.z - prePosition.z)

		self._moveDir = toDir:SetNormalize()
	else
		self:setPositionXYZ(prePosition.x, prePosition.y, prePosition.z)
	end

	if not self:_hasNextPosition() then
		self:_moveEnd(true)
	end
end

function RoomCharacterMO:_hasNextPosition()
	return #self._nextPositions > self._movePoint
end

function RoomCharacterMO:_getNextPosition()
	return self._nextPositions[self._movePoint + 1]
end

function RoomCharacterMO:_moveToNextPosition()
	self._movePoint = self._movePoint + 1
end

function RoomCharacterMO:setCurrentInteractionId(interactionId)
	self._currentInteractionId = interactionId
end

function RoomCharacterMO:getCurrentInteractionId()
	return self._currentInteractionId
end

function RoomCharacterMO:setIsFreeze(isFreeze)
	self._freeze = isFreeze
end

function RoomCharacterMO:getIsFreeze()
	return self._freeze
end

return RoomCharacterMO
