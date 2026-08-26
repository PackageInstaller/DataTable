-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/work/ArcadeCharacterWork.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.work.ArcadeCharacterWork", package.seeall)

local ArcadeCharacterWork = class("ArcadeCharacterWork", BaseWork)

function ArcadeCharacterWork:ctor()
	self._actHandleFuncDict = {
		[ArcadeGameEnum.PlayerActType.Move] = self._onMove,
		[ArcadeGameEnum.PlayerActType.Attack] = self._onAttack,
		[ArcadeGameEnum.PlayerActType.UseSkill] = self._onUseSkill,
		[ArcadeGameEnum.PlayerActType.UseBomb] = self._onUseBomb
	}
	self._attackTargetSelector = ArcadeSkillTargetLinkColor.New()

	self._attackTargetSelector:setOwner(ArcadeGameEnum.EntityType.Character)
end

function ArcadeCharacterWork:onStart(room)
	self._isNeedWait = false

	TaskDispatcher.cancelTask(self._delayDone, self)
	ArcadeGameTriggerController.instance:triggerTargetList(ArcadeGameEnum.TriggerPoint.Character801, ArcadeGameModel.instance:getCharacterMO())

	local masterMOList = ArcadeGameModel.instance:getMonsterList()

	ArcadeGameTriggerController.instance:triggerTargetList(ArcadeGameEnum.TriggerPoint.Monster802, masterMOList)
	ArcadeGameController.instance:beginPlayerTurn()

	self._passTime = 0

	local difficulty = ArcadeGameModel.instance:getDifficulty()

	self._turnTime = ArcadeConfig.instance:getCharacterTurnTime(difficulty)

	ArcadeGameController.instance:registerCallback(ArcadeEvent.PlayerTryDoAction, self._onPlayerTryDoAction, self)
	self:setPlayerActType(ArcadeGameEnum.PlayerActType.None)
end

function ArcadeCharacterWork:onUpdate()
	if not self._passTime or not self._turnTime then
		self:_endCharacterWork(true)
	else
		self._passTime = self._passTime + Time.deltaTime

		if self._passTime > self._turnTime then
			self:_endCharacterWork(true)
		end
	end
end

function ArcadeCharacterWork:_onPlayerTryDoAction(actType, actParam)
	if self._actHandleFuncDict then
		if not self._actHandleFuncDict then
			logError(string.format("ArcadeCharacterWork:_onPlayerDoAction error, no handle func, actType:%s", actType))

			return
		end

		self:setPlayerActType(actType)
		ArcadeGameController.instance:unregisterCallback(ArcadeEvent.PlayerTryDoAction, self._onPlayerTryDoAction, self)
		self:_actHandleFuncDict(actParam)
	end
end

function ArcadeCharacterWork:setPlayerActType(actType)
	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	if characterMO then
		characterMO:setPlayerActType(actType)
	end
end

function ArcadeCharacterWork:_onMove(actParam)
	local scene = ArcadeGameController.instance:getGameScene()
	local curRoom = ArcadeGameController.instance:getCurRoom()
	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local preBorderList = {}

	if curRoom and actParam then
		if characterMO then
			characterMO:setDirection(actParam.direction)

			preBorderList = characterMO:getBorderGridList()
		end

		if scene then
			::label_6_0::

			local characterEntity = scene.entityMgr:getCharacterEntity()

			if characterEntity then
				characterEntity:refreshDirection()

				local result, occupyEntityType, occupyEntityUid = curRoom:tryMoveEntity(characterEntity, actParam.targetGridX, actParam.targetGridY)

				if not result then
					local occupyEntityMO = ArcadeGameModel.instance:getMOWithType(occupyEntityType, occupyEntityUid)

					if occupyEntityMO and occupyEntityMO.getEventOptionList then
						ArcadeGameController.instance:changeNearEventEntity(occupyEntityType, occupyEntityUid)
					end
				end
			end
		end
	end

	for _, gridData in ipairs(preBorderList) do
		local borderGridX = gridData.gridX
		local borderGridY = gridData.gridY
		local adjEntityData = curRoom:getEntityDataInTargetGrid(borderGridX, borderGridY)
		local adjEntityType = adjEntityData and adjEntityData.entityType
		local adjUid = adjEntityData and adjEntityData.uid

		if scene then
			::label_6_1::

			local entity = scene.entityMgr:getEntityWithType(adjEntityType, adjUid)

			if entity then
				entity:refreshShowHpBar()
			end
		end
	end

	ArcadeGameTriggerController.instance:triggerTarget(ArcadeGameEnum.TriggerPoint.MoveEnd, characterMO)
	ArcadeGameController.instance:checkCharacterNearUnit(true)
	self:_actionFinish(true)
end

function ArcadeCharacterWork:_onAttack(actParam)
	if not actParam then
		return
	end

	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	if characterMO then
		characterMO:setDirection(actParam and actParam.direction)
	end

	local entityType = actParam.entityType
	local uid = actParam.uid
	local entityMO = ArcadeGameModel.instance:getMOWithType(entityType, uid)

	if entityMO then
		local gridX, gridY = entityMO:getGridPos()

		self._attackTargetSelector:findTarget(gridX, gridY)

		local targetMOList = self._attackTargetSelector:getTargetList()
		local targetCount = targetMOList and #targetMOList

		if targetCount and targetCount > 0 then
			self._isNeedWait = true

			if targetCount > 1 then
				if not ArcadeGameEnum.AttackType.Link then
					local attackType = ArcadeGameEnum.AttackType.Normal

					ArcadeGameController.instance:enterAttackFlow(attackType, characterMO, targetMOList, actParam.direction)
				end
			end
		end
	end

	self:_actionFinish()
end

function ArcadeCharacterWork:_onUseSkill(actParam)
	if not actParam then
		return
	end

	local targetMOList
	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local direction = characterMO and characterMO:getDirection() or ArcadeGameEnum.Const.DefaultEntityDirection
	local characterId = characterMO and characterMO:getId()
	local skillId = ArcadeConfig.instance:getCharacterSkill(characterId)
	local targetId = ArcadeConfig.instance:getActiveSkillTarget(skillId)
	local targetSelector = ArcadeSkillFactory.instance:createSkillTargetById(targetId)

	if targetSelector then
		targetSelector:findTarget(actParam.targetGridX, actParam.targetGridY, direction)

		targetMOList = targetSelector:getTargetList()
	end

	self._isNeedWait = true

	ArcadeGameController.instance:enterAttackFlow(ArcadeGameEnum.AttackType.Skill, characterMO, targetMOList, direction, skillId)
	ArcadeStatHelper.instance:AddUseUltimateTimes()
	self:_actionFinish()
end

function ArcadeCharacterWork:_onUseBomb(actParam)
	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	if not actParam or not characterMO then
		return
	end

	local characterId = characterMO:getId()
	local bombId = ArcadeConfig.instance:getCharacterBomb(characterId)
	local direction = characterMO:getDirection()

	ArcadeGameController.instance:playerPlaceBomb(bombId, actParam.targetGridX, actParam.targetGridY, {
		isCharacterBomb = true,
		direction = direction
	})
	ArcadeStatHelper.instance:AddUseBoomTimes()
	self:_actionFinish()
end

function ArcadeCharacterWork:_actionFinish(isNegativeAct)
	self:_endCharacterWork(isNegativeAct)
end

function ArcadeCharacterWork:_endCharacterWork(isNegativeAct)
	ArcadeGameController.instance:endPlayerTurn()
	ArcadeGameTriggerController.instance:triggerTarget(ArcadeGameEnum.TriggerPoint.Character803, ArcadeGameModel.instance:getCharacterMO())

	local masterMOList = ArcadeGameModel.instance:getMonsterList()

	ArcadeGameTriggerController.instance:triggerTargetList(ArcadeGameEnum.TriggerPoint.Monster804, masterMOList)

	if isNegativeAct then
		ArcadeGameModel.instance:addNegativeOperationRound()
	else
		ArcadeGameModel.instance:resetNegativeOperationRound()
	end

	local waitTime = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.CharacterTurnWaitTime, true) or 0

	if self._isNeedWait and waitTime > 0 then
		TaskDispatcher.cancelTask(self._delayDone, self)
		TaskDispatcher.runDelay(self._delayDone, self, waitTime or 0)
	else
		self:_delayDone()
	end

	self._isNeedWait = false
end

function ArcadeCharacterWork:_delayDone()
	TaskDispatcher.cancelTask(self._delayDone, self)
	self:onDone(true)
end

function ArcadeCharacterWork:clearWork()
	self._isNeedWait = false

	TaskDispatcher.cancelTask(self._delayDone, self)

	self._passTime = nil

	ArcadeGameController.instance:unregisterCallback(ArcadeEvent.PlayerTryDoAction, self._onPlayerTryDoAction, self)
end

return ArcadeCharacterWork
