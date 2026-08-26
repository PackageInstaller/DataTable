-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/room/ArcadeBaseRoom.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.room.ArcadeBaseRoom", package.seeall)

local ArcadeBaseRoom = class("ArcadeBaseRoom")

function ArcadeBaseRoom:ctor(roomType, scene)
	self._roomType = roomType
	self._scene = scene
	self._entityOccupyGridDict = nil
	self._gridDict = nil

	self:onCtor()
end

function ArcadeBaseRoom:enter()
	self._entityOccupyGridDict = {}
	self._gridDict = {}
	self.id = ArcadeGameModel.instance:getCurRoomId()

	self:_initRoundFlow()
	self:_initRoomSkills()
	self:onEnter()
end

function ArcadeBaseRoom:_initRoundFlow()
	self:_disposeRoundFlow()

	self._roundFlow = FlowSequence.New()

	self._roundFlow:addWork(ArcadeRoundBeginWork.New())
	self._roundFlow:addWork(ArcadeCharacterWork.New())
	self._roundFlow:addWork(ArcadeEntityWork.New())
	self._roundFlow:registerDoneListener(self._onGameFlowDone, self)
end

function ArcadeBaseRoom:_onGameFlowDone(isSuccess)
	if not isSuccess then
		return
	end

	self._beginNewRound = true
end

function ArcadeBaseRoom:_disposeRoundFlow()
	if not self._roundFlow then
		return
	end

	self._roundFlow:unregisterDoneListener(self._onGameFlowDone, self)
	self._roundFlow:destroy()

	self._roundFlow = nil
end

function ArcadeBaseRoom:_initRoomSkills()
	local minCoordinate = ArcadeGameEnum.Const.RoomMinCoordinateValue
	local gridMO = ArcadeGameModel.instance:getGridMOByXY(minCoordinate, minCoordinate)
	local skillList = ArcadeConfig.instance:getRoomSkillList(self.id)

	if skillList then
		for _, skillId in ipairs(skillList) do
			gridMO:addSkillById(skillId)
		end
	end
end

function ArcadeBaseRoom:initEntities()
	self:onInitEntities()
end

function ArcadeBaseRoom:_initEntitiesFinished()
	local lastRoomCanNormEnd = ArcadeGameHelper.checkLastRoomCanNormalEnd()

	if not lastRoomCanNormEnd then
		ArcadeGameController.instance:endGame(ArcadeGameEnum.SettleType.Win, true)
	else
		self:_addInitFloor()
		ArcadeGameController.instance:changeRoomFinish()
		UpdateBeat:Add(self._onUpdate, self)
		self._roundFlow:start()
	end
end

function ArcadeBaseRoom:_addInitFloor()
	local initFloorList = ArcadeConfig.instance:getRoomInitFloorList(self.id)

	ArcadeGameFloorController.instance:tryAddFloorByList(initFloorList)
end

function ArcadeBaseRoom:_onUpdate()
	local isGamePause = ArcadeGameModel.instance:getIsPauseGame()
	local isGameEnd = ArcadeGameModel.instance:getIsEndGame()

	if isGamePause or isGameEnd then
		return
	end

	if self._roundFlow then
		if self._beginNewRound then
			self._beginNewRound = nil

			ArcadeGameModel.instance:triggerEntityTypeCounterRecord(nil, ArcadeGameEnum.GameCounter.RoundSinceAddSkill)
			self._roundFlow:start(self)
		end

		local workList = self._roundFlow:getWorkList()
		local curWork = workList[self._roundFlow._curIndex]

		if curWork and curWork.onUpdate then
			curWork:onUpdate()
		end
	end
end

function ArcadeBaseRoom:exit()
	self:onExit()

	self.id = nil
	self._entityOccupyGridDict = {}
	self._gridDict = {}
	self._beginNewRound = nil

	self:_disposeRoundFlow()
	UpdateBeat:Remove(self._onUpdate, self)
end

function ArcadeBaseRoom:clear()
	self:onClear()

	self.id = nil
	self._entityOccupyGridDict = nil
	self._gridDict = nil
	self._beginNewRound = nil

	self:_disposeRoundFlow()
	UpdateBeat:Remove(self._onUpdate, self)

	self._scene = nil
end

function ArcadeBaseRoom:tryAddEntityOccupyGrids(mo, canOverY)
	if not mo then
		return false
	end

	local entityType = mo:getEntityType()
	local gridX, gridY = mo:getGridPos()
	local sizeX, sizeY = mo:getSize()
	local uid = mo:getUid()
	local isCanPlace = self:_isCanPlaceEntity(entityType, uid, gridX, gridY, sizeX, sizeY, canOverY)

	if isCanPlace then
		self:_setOccupyGrids(entityType, uid, gridX, gridY, sizeX, sizeY)
	else
		logError(string.format("ArcadeBaseRoom:tryAddEntityOccupyGrids error, entity overlapping,roomId:%s entityId:%s x:%s y:%s sizeX:%s sizeY:%s", self.id, mo:getId(), gridX, gridY, sizeX, sizeY))
	end

	return isCanPlace
end

function ArcadeBaseRoom:tryMoveEntity(entity, targetGridX, targetGridY, canOverY)
	if not entity then
		return
	end

	local mo = entity:getMO()

	if not mo then
		return
	end

	local buffSetMO = mo:getBuffSetMO()
	local haveStopMoveBuff = buffSetMO:hasEffectParamBuff(ArcadeGameEnum.BuffEffectName.StopMove)

	if haveStopMoveBuff then
		return
	end

	local entityType = mo:getEntityType()
	local uid = mo:getUid()
	local sizeX, sizeY = mo:getSize()
	local isCanPlace, occupyEntityType, occupyEntityUid = self:_isCanPlaceEntity(entityType, uid, targetGridX, targetGridY, sizeX, sizeY, canOverY)

	if isCanPlace then
		ArcadeGameTriggerController.instance:triggerTarget(ArcadeGameEnum.TriggerPoint.BeforeDoMove303, mo, {
			specTargetGridX = targetGridX,
			specTargetGridY = targetGridY
		})
		self:removeEntityOccupyGrids(mo)
		self:_setOccupyGrids(entityType, uid, targetGridX, targetGridY, sizeX, sizeY)
		mo:setGridPos(targetGridX, targetGridY)
		entity:refreshPosition(true)
		ArcadeGameController.instance:dispatchEvent(ArcadeEvent.OnEntityMove, mo)

		return true
	else
		return false, occupyEntityType, occupyEntityUid
	end
end

function ArcadeBaseRoom:removeEntityOccupyGrids(entityMO)
	if not entityMO then
		return
	end

	local uid = entityMO:getUid()
	local entityType = entityMO:getEntityType()
	local occupyGridList = self:getEntityOccupyGridList(entityType, uid)
	local entityLayer = ArcadeGameEnum.EntityType2Layer[entityType]
	local layerGridDict = ArcadeGameHelper.checkDictTable(self._gridDict, entityLayer)

	for _, gridId in pairs(occupyGridList) do
		layerGridDict[gridId] = nil
	end

	if entityType then
		::label_15_0::

		local var_15_0 = self._entityOccupyGridDict

		if self._entityOccupyGridDict then
			local typeDict = self._entityOccupyGridDict[entityType]

			if typeDict then
				typeDict[uid] = nil
			end
		end
	end
end

function ArcadeBaseRoom:filterCanPlaceEntityList(dataList, canOverY)
	if not dataList or not self._scene then
		return
	end

	local canPlaceList = {}
	local tempOccupyGridDict = {}

	for _, data in ipairs(dataList) do
		local x = data.x
		local y = data.y
		local sizeX = data.sizeX
		local sizeY = data.sizeY
		local isCanPlace = self:_isCanPlaceEntity(data.entityType, nil, x, y, sizeX, sizeY, canOverY, tempOccupyGridDict, true, data.id)

		if isCanPlace then
			canPlaceList[#canPlaceList + 1] = data
		end
	end

	return canPlaceList
end

function ArcadeBaseRoom:_isCanPlaceEntity(entityType, entityUid, x, y, sizeX, sizeY, canOverY, tempOccupyGridDict, isLog, logEntityId)
	local entityMO = ArcadeGameModel.instance:getMOWithType(entityType, entityUid)
	local entityId = entityMO and entityMO:getId() or logEntityId

	if not x or not x or not sizeX or not sizeY then
		if isLog then
			logWarn(string.format("ArcadeBaseRoom:_isCanPlaceEntity warn, need params have nil, roomId:%s entityType:%s entityId:%s x:%s y:%s sizeX:%s sizeY:%s", self.id, entityType, entityId, x, y, sizeX, sizeY))
		end

		return false
	end

	if x < ArcadeGameEnum.Const.RoomMinCoordinateValue or x + sizeX - 1 > ArcadeGameEnum.Const.RoomSize then
		if isLog then
			logWarn(string.format("ArcadeBaseRoom:_isCanPlaceEntity warn, over X, roomId:%s entityType:%s entityId:%s x:%s y:%s sizeX:%s sizeY:%s", self.id, entityType, entityId, x, y, sizeX, sizeY))
		end

		return false
	end

	if y < ArcadeGameEnum.Const.RoomMinCoordinateValue then
		if isLog then
			logWarn(string.format("ArcadeBaseRoom:_isCanPlaceEntity warn, over Min Y, roomId:%s entityType:%s entityId:%s x:%s y:%s sizeX:%s sizeY:%s", self.id, entityType, entityId, x, y, sizeX, sizeY))
		end

		return false
	end

	if not canOverY and y + sizeY - 1 > ArcadeGameEnum.Const.RoomSize then
		if isLog then
			logWarn(string.format("ArcadeBaseRoom:_isCanPlaceEntity warn, over Max Y, roomId:%s entityType:%s entityId:%s x:%s y:%s sizeX:%s sizeY:%s", self.id, entityType, entityId, x, y, sizeX, sizeY))
		end

		return false
	end

	local isBomb = entityType == ArcadeGameEnum.EntityType.Bomb
	local entityLayer = ArcadeGameEnum.EntityType2Layer[entityType]
	local isNormalLayer = entityLayer == ArcadeGameEnum.EntityLayer.Normal
	local occupyGridList = {}

	for i = x, x + sizeX - 1 do
		for j = y, y + sizeY - 1 do
			local gridId = ArcadeGameHelper.getGridId(i, j)
			local tempOccupyData = tempOccupyGridDict and tempOccupyGridDict[gridId]

			if tempOccupyData then
				local tempOccupyEntityType = tempOccupyData.entityType
				local tempOccupyEntityUid = tempOccupyData.uid

				logWarn(string.format("ArcadeBaseRoom:_isCanPlaceEntity warn, have tempOccupy, roomId:%s entityType:%s entityId:%s x:%s y:%s sizeX:%s sizeY:%s, gridId:%s has entity, entityType:%s entityId:%s", self.id, entityType, entityId, x, y, sizeX, sizeY, gridId, tempOccupyEntityType, tempOccupyData.id))

				return false, tempOccupyEntityType, tempOccupyEntityUid
			end

			local occupyEntityData = self:getEntityDataInTargetGrid(i, j, entityLayer)

			if not occupyEntityData and isNormalLayer then
				occupyEntityData = self:getEntityDataInTargetGrid(i, j, ArcadeGameEnum.EntityLayer.Bomb)
			end

			local occupyEntityType = occupyEntityData and occupyEntityData.entityType
			local occupyEntityUid = occupyEntityData and occupyEntityData.uid

			if occupyEntityType and occupyEntityUid then
				local isSelf = entityType == occupyEntityType and entityUid == occupyEntityData.uid

				if not ((isBomb or nil) and (occupyEntityType == ArcadeGameEnum.EntityType.Character or occupyEntityType == ArcadeGameEnum.EntityType.Bomb)) and not isSelf then
					local occupyMO = ArcadeGameModel.instance:getMOWithType(occupyEntityType, occupyEntityUid)
					local occupyId = occupyMO and occupyMO:getId()

					if isLog then
						logWarn(string.format("ArcadeBaseRoom:_isCanPlaceEntity warn, have occupy, roomId:%s entityType:%s entityId:%s x:%s y:%s sizeX:%s sizeY:%s, gridId:%s has entity, entityType:%s entityId:%s", self.id, entityType, entityId, x, y, sizeX, sizeY, gridId, occupyEntityType, occupyId))
					end

					return false, occupyEntityType, occupyEntityUid
				end
			end

			occupyGridList[#occupyGridList + 1] = gridId
		end
	end

	if tempOccupyGridDict then
		local occupyData = {
			entityType = entityType,
			uid = entityUid,
			id = entityId
		}

		for _, gridId in ipairs(occupyGridList) do
			tempOccupyGridDict[gridId] = occupyData
		end
	end

	return true
end

function ArcadeBaseRoom:_setOccupyGrids(entityType, uid, gridX, gridY, sizeX, sizeY)
	local occupyGridDict = {}
	local occupyData = {
		entityType = entityType,
		uid = uid
	}

	for i = gridX, gridX + sizeX - 1 do
		for j = gridY, gridY + sizeY - 1 do
			local occupyGridId = ArcadeGameHelper.getGridId(i, j)

			occupyGridDict[occupyGridId] = true

			local entityLayer = ArcadeGameEnum.EntityType2Layer[entityType]
			local layerGridDict = ArcadeGameHelper.checkDictTable(self._gridDict, entityLayer)

			layerGridDict[occupyGridId] = occupyData
		end
	end

	if self._entityOccupyGridDict then
		local entityDict = ArcadeGameHelper.checkDictTable(self._entityOccupyGridDict, entityType)

		entityDict[uid] = occupyGridDict
	end
end

function ArcadeBaseRoom:getRoomType()
	return self._roomType
end

function ArcadeBaseRoom:getEntityDataInTargetGrid(gridX, gridY, entityLayer)
	if not gridX or not gridY then
		return
	end

	entityLayer = entityLayer or ArcadeGameEnum.EntityLayer.Normal

	local gridId = ArcadeGameHelper.getGridId(gridX, gridY)

	if self._gridDict then
		local layerGridDict = self._gridDict[entityLayer]
		local entityData = layerGridDict and layerGridDict[gridId]

		if entityData then
			return entityData
		end
	end
end

function ArcadeBaseRoom:getEntityOccupyGridList(entityType, uid)
	local result = {}

	if entityType then
		::label_21_0::

		local var_21_0 = self._entityOccupyGridDict

		if self._entityOccupyGridDict then
			local typeDict = self._entityOccupyGridDict[entityType]
			local gridDict = typeDict and typeDict[uid]

			if gridDict then
				for gridId, _ in pairs(gridDict) do
					result[#result + 1] = gridId
				end
			end

			return result
		end
	end
end

function ArcadeBaseRoom:onCtor()
	return
end

function ArcadeBaseRoom:onEnter()
	return
end

function ArcadeBaseRoom:onInitEntities()
	self:_initEntitiesFinished()
end

function ArcadeBaseRoom:onExit()
	return
end

function ArcadeBaseRoom:onClear()
	return
end

return ArcadeBaseRoom
