-- chunkname: @modules/logic/fight/view/FightViewExPoint.lua

module("modules.logic.fight.view.FightViewExPoint", package.seeall)

local FightViewExPoint = class("FightViewExPoint", BaseView)

function FightViewExPoint:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.OnStartSequenceFinish, self._onStartSequenceFinish, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnRoundSequenceFinish, self._onRoundSequenceFinish, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnMoveHandCard, self._onMoveHandCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnCombineOneCard, self._onCombineOneCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnPlayHandCard, self._onPlayHandCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnRevertCard, self._onRevertCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.CancelOperation, self._onCancelOperation, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnResetCard, self._onResetCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.RespBeginRound, self._respBeginRound, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnSkillPlayStart, self._onSkillPlayStart, self)
	self.addEventCb(self, FightController.instance, FightEvent.StageChanged, self.onStageChange, self)
end

function FightViewExPoint:removeEvents()
	self.removeEventCb(self, FightController.instance, FightEvent.OnStartSequenceFinish, self._onStartSequenceFinish, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnRoundSequenceFinish, self._onRoundSequenceFinish, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnMoveHandCard, self._onMoveHandCard, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnCombineOneCard, self._onCombineOneCard, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnPlayHandCard, self._onPlayHandCard, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnRevertCard, self._onRevertCard, self)
	self.removeEventCb(self, FightController.instance, FightEvent.CancelOperation, self._onCancelOperation, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnResetCard, self._onResetCard, self)
	self.removeEventCb(self, FightController.instance, FightEvent.RespBeginRound, self._respBeginRound, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnSkillPlayStart, self._onSkillPlayStart, self)
	self.removeEventCb(self, FightController.instance, FightEvent.StageChanged, self.onStageChange, self)
end

function FightViewExPoint:_onStartSequenceFinish()
	return
end

function FightViewExPoint:_onRoundSequenceFinish()
	FightDataHelper.operationDataMgr:applyNextRoundActPoint()
end

function FightViewExPoint:_onMoveHandCard(operation, cardInfoMO)
	if not operation.moveCanAddExpoint then
		return
	end

	local extraMoveAct = FightDataHelper.operationDataMgr.extraMoveAct

	if extraMoveAct > 0 then
		local ops = FightDataHelper.operationDataMgr:getMoveCardOpCostActList()

		if extraMoveAct < #ops then
			self:_onMoveOrCombine(cardInfoMO.uid, true)
		end
	else
		self:_onMoveOrCombine(cardInfoMO.uid, true)
	end
end

function FightViewExPoint:_onCombineOneCard(cardInfoMO, isUniversalCombine)
	if not cardInfoMO then
		return
	end

	if not cardInfoMO.combineCanAddExpoint then
		return
	end

	if not isUniversalCombine then
		self:_onMoveOrCombine(cardInfoMO.uid, false)
	end
end

function FightViewExPoint:_onMoveOrCombine(entityId, isMove)
	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		return
	end

	local entityMO = FightDataHelper.entityMgr:getById(entityId)

	if not entityMO then
		return
	end

	local moveCardAddExPoint = entityMO:getMoveCardAddExPoint()

	if moveCardAddExPoint < 1 then
		return
	end

	local addExPointUid = FightBuffHelper.getTransferExPointUid(entityMO)

	if addExPointUid then
		local transferEntityMo = FightDataHelper.entityMgr:getById(addExPointUid)
		local sameType = transferEntityMo and transferEntityMo.exPointType == entityMO.exPointType

		if transferEntityMo and sameType then
			transferEntityMo:onMoveCardExPoint(isMove)
			FightController.instance:dispatchEvent(FightEvent.UpdateExPoint, addExPointUid)
		else
			entityMO:onMoveCardExPoint(isMove)
			FightController.instance:dispatchEvent(FightEvent.UpdateExPoint, entityId)
		end
	else
		entityMO:onMoveCardExPoint(isMove)
		FightController.instance:dispatchEvent(FightEvent.UpdateExPoint, entityId)
	end
end

function FightViewExPoint:_onPlayHandCard(cardInfoMO)
	if not cardInfoMO.playCanAddExpoint then
		return
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		return
	end

	local entityMO = FightDataHelper.entityMgr:getById(cardInfoMO.uid)

	if not entityMO then
		return
	end

	if FightCardDataHelper.hadNotAddExPointEnchant(cardInfoMO) then
		return
	end

	local playCardAddExPoint = entityMO:getPlayCardAddExPoint()

	if playCardAddExPoint < 1 then
		return
	end

	local addExPointUid = FightBuffHelper.getTransferExPointUid(entityMO)

	if addExPointUid then
		local transferEntityMo = FightDataHelper.entityMgr:getById(addExPointUid)
		local sameType = transferEntityMo and transferEntityMo.exPointType == entityMO.exPointType

		if transferEntityMo and sameType then
			transferEntityMo:onPlayCardExPoint(cardInfoMO.skillId)
			FightController.instance:dispatchEvent(FightEvent.AddPlayCardClientExPoint, addExPointUid)
		else
			entityMO:onPlayCardExPoint(cardInfoMO.skillId)
			FightController.instance:dispatchEvent(FightEvent.AddPlayCardClientExPoint, cardInfoMO.uid)
		end
	else
		entityMO:onPlayCardExPoint(cardInfoMO.skillId)
		FightController.instance:dispatchEvent(FightEvent.AddPlayCardClientExPoint, cardInfoMO.uid)
	end
end

function FightViewExPoint:_onRevertCard(cardOp)
	return
end

function FightViewExPoint:_onCancelOperation()
	self.last_move_point = {}

	local entityList = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide)

	for _, entity in ipairs(entityList) do
		local entity_mo = entity:getMO()

		if entity_mo then
			self.last_move_point[entity_mo.uid] = entity_mo.moveCardExPoint
		end
	end
end

function FightViewExPoint:_onResetCard()
	local entityDataDic = FightDataHelper.entityMgr:getAllEntityData()

	for k, entityMO in pairs(entityDataDic) do
		FightController.instance:dispatchEvent(FightEvent.UpdateExPoint, entityMO.id)
	end
end

function FightViewExPoint:_respBeginRound()
	local entityList = FightDataHelper.entityMgr:getMyNormalList()

	for _, entityMO in ipairs(entityList) do
		entityMO:applyMoveCardExPoint()
	end

	entityList = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, false)

	for _, entity in ipairs(entityList) do
		FightController.instance:dispatchEvent(FightEvent.UpdateExPoint, entity.id)
	end
end

function FightViewExPoint:_onSkillPlayStart(entity, skillId, fightStepData)
	return
end

function FightViewExPoint:onStageChange(stage)
	return
end

return FightViewExPoint
