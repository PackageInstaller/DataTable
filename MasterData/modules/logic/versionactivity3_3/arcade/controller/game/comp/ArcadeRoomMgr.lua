-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/comp/ArcadeRoomMgr.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.comp.ArcadeRoomMgr", package.seeall)

local ArcadeRoomMgr = class("ArcadeRoomMgr", ArcadeBaseSceneComp)

function ArcadeRoomMgr:onInit()
	self._curRoom = nil
	self._roomDict = {}

	for _, roomType in pairs(ArcadeGameEnum.RoomType) do
		local clsDefine = ArcadeGameEnum.RoomTypeCls[roomType]

		if clsDefine then
			self._roomDict[roomType] = clsDefine.New(roomType, self._scene)
		else
			logError(string.format("ArcadeRoomMgr:onInit error, roomType:%s no cls define", roomType))
		end
	end
end

function ArcadeRoomMgr:addEventListeners()
	return
end

function ArcadeRoomMgr:removeEventListeners()
	return
end

function ArcadeRoomMgr:switchRoom()
	self:_exitRoom()

	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	if characterMO then
		characterMO:resetGridPos()
	end

	ArcadeGameController.instance:saveGame()

	local roomId = ArcadeGameModel.instance:getCurRoomId()
	local roomType = ArcadeConfig.instance:getRoomType(roomId)
	local room = self:_getRoom(roomType)

	if room then
		self._curRoom = room

		room:enter()
		ArcadeGameTriggerController.instance:triggerTarget(ArcadeGameEnum.TriggerPoint.EnterRoom, characterMO)
		room:tryAddEntityOccupyGrids(characterMO)

		local characterEntity = self._scene.entityMgr:getCharacterEntity()

		characterEntity:refreshPosition()
		characterEntity:removeAllEffect()
		room:initEntities()
		characterEntity:playActionShow(ArcadeGameEnum.ActionShowId.Born)
		ArcadeStatHelper.instance:onEnterRoom()
	end
end

function ArcadeRoomMgr:_exitRoom()
	if self._curRoom then
		self._curRoom:exit()
	end

	local removeBuffIdList = {}
	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	if characterMO then
		local curScore = characterMO:getResourceCount(ArcadeGameEnum.CharacterResource.Score) or 0

		ArcadeGameController.instance:changeResCount(ArcadeGameEnum.CharacterResource.Score, -curScore)

		local buffSetMO = characterMO:getBuffSetMO()
		local buffList = buffSetMO and buffSetMO:getBuffList()

		if buffList then
			for i, buffMO in ipairs(buffList) do
				removeBuffIdList[i] = buffMO:getId()
			end
		end

		local skillSetMO = characterMO:getSkillSetMO()

		if skillSetMO then
			skillSetMO:clearSkillCounterRecordOnExitRoom()
		end
	end

	ArcadeGameController.instance:removeEntityBuffs(removeBuffIdList, ArcadeGameEnum.EntityType.Character)
	self._scene.entityMgr:clearAllEntity()
	self._scene.effectMgr:removeAllEffect()
	ArcadeGameModel.instance:clearAllEntityMO()
	ArcadeGameModel.instance:resetNegativeOperationRound()
	ArcadeGameModel.instance:setNearEventEntity()

	local gridMOList = ArcadeGameModel.instance:getGridMOList()

	if gridMOList then
		for _, gridMO in ipairs(gridMOList) do
			gridMO:reset()
		end
	end

	self._curRoom = nil

	ArcadeGameController.instance:dispatchEvent(ArcadeEvent.OnArcadeRoomExit)
end

function ArcadeRoomMgr:_getRoom(roomType)
	return self._roomDict[roomType]
end

function ArcadeRoomMgr:getCurRoom()
	return self._curRoom
end

function ArcadeRoomMgr:onClear()
	self._curRoom = nil

	for _, room in pairs(self._roomDict) do
		room:clear()
	end
end

return ArcadeRoomMgr
