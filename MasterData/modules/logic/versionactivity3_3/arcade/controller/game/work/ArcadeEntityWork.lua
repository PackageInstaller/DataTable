-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/work/ArcadeEntityWork.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.work.ArcadeEntityWork", package.seeall)

local ArcadeEntityWork = class("ArcadeEntityWork", BaseWork)

function ArcadeEntityWork:onStart(room)
	self._isNeedWait = false

	TaskDispatcher.cancelTask(self._delayDone, self)
	ArcadeGameTriggerController.instance:triggerTargetList(ArcadeGameEnum.TriggerPoint.Charact811, ArcadeGameModel.instance:getCharacterMO())

	local masterMOList = ArcadeGameModel.instance:getMonsterList()

	ArcadeGameTriggerController.instance:triggerTargetList(ArcadeGameEnum.TriggerPoint.Monster812, masterMOList)
	ArcadeGameTriggerController.instance:triggerTargetList(ArcadeGameEnum.TriggerPoint.Monster805, masterMOList)
	self:moveAllEntities()
end

function ArcadeEntityWork:moveAllEntities()
	local curRoom = ArcadeGameController.instance:getCurRoom()

	if curRoom then
		local allYList = {}
		local y2EntityDict = {}

		self:_fillYDict(ArcadeGameEnum.EntityType.Monster, y2EntityDict, allYList)
		self:_fillYDict(ArcadeGameEnum.EntityType.Portal, y2EntityDict, allYList)

		for _, y in ipairs(allYList) do
			local entityList = y2EntityDict[y]

			for _, entity in ipairs(entityList) do
				local mo = entity:getMO()
				local lockRound = mo:getLockRound()

				if lockRound and lockRound > 0 then
					mo:setLockRound(lockRound - 1)
				else
					local willMove = true
					local curGridX, curGridY = mo:getGridPos()
					local entityType = mo:getEntityType()
					local id = mo:getId()

					if entityType == ArcadeGameEnum.EntityType.Monster then
						local isDead = mo:getIsDead()
						local moveType = ArcadeConfig.instance:getMonsterMoveType(id)

						if isDead or moveType ~= ArcadeGameEnum.MoveType.NormalDrop then
							willMove = false
						end
					elseif entityType == ArcadeGameEnum.EntityType.Portal then
						local roomType = curRoom:getRoomType()

						if roomType == ArcadeGameEnum.RoomType.Store or roomType == ArcadeGameEnum.RoomType.Event or roomType == ArcadeGameEnum.RoomType.Rest or roomType == ArcadeGameEnum.RoomType.Boss then
							willMove = false
						end
					end

					if willMove then
						self._isNeedWait = true

						local targetGridY = curGridY + (ArcadeEnum.DirChangeGridY[ArcadeEnum.Direction.Down] or 0)

						curRoom:tryMoveEntity(entity, curGridX, targetGridY, true)
					end
				end
			end
		end
	end

	local masterMOList = ArcadeGameModel.instance:getMonsterList()

	ArcadeGameTriggerController.instance:triggerTargetList(ArcadeGameEnum.TriggerPoint.MoveEnd, masterMOList)
	ArcadeGameController.instance:checkCharacterNearUnit()

	if curRoom and curRoom.loadNextWaveMonster then
		local isAllIn = self:_checkIsAllMonsterDropInPlayground()

		if isAllIn then
			curRoom:loadNextWaveMonster()
		end
	end

	self:_endEntityWork()
end

function ArcadeEntityWork:_fillYDict(entityType, refYDict, refYList)
	local scene = ArcadeGameController.instance:getGameScene()

	if scene then
		::label_3_0::

		local entityDict = scene.entityMgr:getEntityDictWithType(entityType)

		if not entityDict then
			return
		end

		for _, entity in pairs(entityDict) do
			local entityMO = entity:getMO()
			local _, y = entityMO:getGridPos()
			local entityList = refYDict[y]

			if not entityList then
				entityList = {}
				refYDict[y] = entityList
				refYList[#refYList + 1] = y
			end

			entityList[#entityList + 1] = entity
		end

		table.sort(refYList, function(a, b)
			return a < b
		end)
	end
end

function ArcadeEntityWork:_checkIsAllMonsterDropInPlayground()
	local result = true
	local monsterList = ArcadeGameModel.instance:getMonsterList()

	for _, entityMO in ipairs(monsterList) do
		local _, y = entityMO:getGridPos()
		local _, sizeY = entityMO:getSize()

		if y + sizeY - 1 > ArcadeGameEnum.Const.RoomSize then
			result = false

			break
		end
	end

	return result
end

function ArcadeEntityWork:_endEntityWork()
	ArcadeGameTriggerController.instance:triggerTargetList(ArcadeGameEnum.TriggerPoint.Character813, ArcadeGameModel.instance:getCharacterMO())

	local masterMOList = ArcadeGameModel.instance:getMonsterList()

	ArcadeGameTriggerController.instance:triggerTargetList(ArcadeGameEnum.TriggerPoint.Monster814, masterMOList)

	local floorMOList = ArcadeGameModel.instance:getEntityMOList(ArcadeGameEnum.EntityType.Floor)

	ArcadeGameTriggerController.instance:triggerTargetList(ArcadeGameEnum.TriggerPoint.MoveEnd302, floorMOList)

	local gridMOList = ArcadeGameModel.instance:getGridMOList()

	ArcadeGameTriggerController.instance:triggerTargetList(ArcadeGameEnum.TriggerPoint.MoveEnd302, gridMOList)

	local gameScene = ArcadeGameController.instance:getGameScene()

	if gameScene then
		gameScene.effectMgr:tryCheckEffectRound()
	end

	if self._isNeedWait then
		local waitTime = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.EntityTurnWaitTime, true)

		TaskDispatcher.cancelTask(self._delayDone, self)
		TaskDispatcher.runDelay(self._delayDone, self, waitTime or 0)
	else
		self:_delayDone()
	end

	self._isNeedWait = false
end

function ArcadeEntityWork:_delayDone()
	TaskDispatcher.cancelTask(self._delayDone, self)
	self:onDone(true)
end

function ArcadeEntityWork:clearWork()
	self._isNeedWait = false

	TaskDispatcher.cancelTask(self._delayDone, self)
end

return ArcadeEntityWork
