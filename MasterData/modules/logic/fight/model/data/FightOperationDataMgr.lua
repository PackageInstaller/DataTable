-- chunkname: @modules/logic/fight/model/data/FightOperationDataMgr.lua

module("modules.logic.fight.model.data.FightOperationDataMgr", package.seeall)

local FightOperationDataMgr = FightDataClass("FightOperationDataMgr", FightDataMgrBase)

function FightOperationDataMgr:onConstructor()
	self.actPoint = 0
	self.moveNum = 0
	self.extraMoveAct = 0
	self.operationList = {}
	self.extraMoveUsedCount = 0
	self.playerFinisherSkillUsedCount = nil
	self.curSelectEntityId = 0
	self.survivalTalentSkillUsedCount = 0
	self._begin_round_ops = {}
	self._extra_move_round_ops = {}
	self._all_recorded_ops = {}
end

function FightOperationDataMgr:getOpList()
	return self.operationList
end

function FightOperationDataMgr:dealCardInfoPush(cardInfoPush)
	self.actPoint = cardInfoPush.actPoint
	self.moveNum = cardInfoPush.moveNum
	self.extraMoveAct = cardInfoPush.extraMoveAct
end

function FightOperationDataMgr:isUnlimitMoveCard()
	return self.extraMoveAct == -1
end

function FightOperationDataMgr:clearClientSimulationData()
	tabletool.clear(self.operationList)

	self.extraMoveUsedCount = 0
	self.playerFinisherSkillUsedCount = nil
	self.survivalTalentSkillUsedCount = 0

	self:setLorenzRecordSkillDepend(nil)
	self:setLorenzRecordSkillId(nil)
end

function FightOperationDataMgr:onCancelOperation()
	self:clearClientSimulationData()

	local entityDataDic = FightDataHelper.entityMgr:getAllEntityData()

	for k, entityMO in pairs(entityDataDic) do
		entityMO:resetSimulateExPoint()
	end
end

function FightOperationDataMgr:onStageChanged(curStage)
	self:clearClientSimulationData()

	if curStage == FightStageMgr.StageType.Play then
		if not FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.ClothSkill) then
			self.extraMoveAct = 0
		end
	elseif curStage == FightStageMgr.StageType.Operate then
		self:buildCanRecordCardEffectTag()
	end
end

function FightOperationDataMgr:addOperation(op)
	table.insert(self.operationList, op)
end

function FightOperationDataMgr:newOperation()
	local op = FightOperationItemData.New()

	table.insert(self.operationList, op)

	return op
end

function FightOperationDataMgr:getEntityOps(entityId, cardOpType)
	local opList = {}

	for _, op in ipairs(self.operationList) do
		if op.belongToEntityId == entityId and (not cardOpType or op.operType == cardOpType) then
			table.insert(opList, op)
		end
	end

	return opList
end

function FightOperationDataMgr:getShowOpActList()
	local list = {}

	for _, op in ipairs(self.operationList) do
		if self:canShowOpAct(op) then
			table.insert(list, op)
		end
	end

	return list
end

function FightOperationDataMgr:canShowOpAct(op)
	if not op:isMoveUniversal() then
		local isUnlimitMoveCard = op:isMoveCard() and self:isUnlimitMoveCard()

		if not isUnlimitMoveCard or op:isPlayCard() then
			return true
		end
	end
end

function FightOperationDataMgr:getPlayCardOpList()
	local list = {}

	for _, op in ipairs(self.operationList) do
		if FightCardDataHelper.checkOpAsPlayCardHandle(op) then
			table.insert(list, op)
		end
	end

	return list
end

function FightOperationDataMgr:getPlayCardOpCount()
	local count = 0

	for _, op in ipairs(self.operationList) do
		if FightCardDataHelper.checkOpAsPlayCardHandle(op) then
			count = count + 1
		end
	end

	return count
end

function FightOperationDataMgr:getMoveCardOpList()
	local list = {}

	for _, op in ipairs(self.operationList) do
		if op:isMoveCard() then
			table.insert(list, op)
		end
	end

	return list
end

function FightOperationDataMgr:getMoveCardOpCostActList()
	local list = {}

	for _, op in ipairs(self.operationList) do
		if op:isMoveCard() then
			table.insert(list, op)
		end
	end

	return list
end

function FightOperationDataMgr:isCardOpEnd()
	local handCards = self.dataMgr.handCardMgr.handCard
	local cardCount = #handCards

	if cardCount == 0 then
		return true
	end

	local fieldMgr = self.dataMgr.fieldMgr
	local ops = self.operationList
	local costActPoint = 0
	local moveCount = 0

	for _, op in ipairs(ops) do
		if op:isPlayCard() then
			costActPoint = costActPoint + op.costActPoint
		elseif op:isMoveCard() then
			moveCount = moveCount + 1

			if not self:isUnlimitMoveCard() and moveCount > self.extraMoveAct then
				costActPoint = costActPoint + op.costActPoint
			end
		end
	end

	local canUsePoint = self.actPoint

	if fieldMgr:isSeason2() then
		canUsePoint = 1

		if #ops >= 1 then
			return true
		end
	end

	if canUsePoint <= costActPoint then
		return true
	end

	if FightCardDataHelper.allPlayCardCantUse(handCards) then
		return true
	end

	return false
end

function FightOperationDataMgr:getLeftExtraMoveCount()
	if self.extraMoveAct < 0 then
		return self.extraMoveAct
	end

	return self.extraMoveAct - self.extraMoveUsedCount
end

function FightOperationDataMgr:setCurSelectEntityId(entityId)
	self.curSelectEntityId = entityId
end

function FightOperationDataMgr:resetCurSelectEntityIdDefault()
	if FightDataHelper.stateMgr:getIsAuto() then
		if FightHelper.canSelectEnemyEntity(self.curSelectEntityId) then
			self:setCurSelectEntityId(self.curSelectEntityId)
		else
			self:setCurSelectEntityId(0)
		end
	else
		local curSelectEntityMO = FightDataHelper.entityMgr:getById(self.curSelectEntityId)

		if curSelectEntityMO and curSelectEntityMO:isStatusDead() then
			curSelectEntityMO = nil
		end

		if curSelectEntityMO and curSelectEntityMO.side == FightEnum.EntitySide.MySide then
			self.curSelectEntityId = 0
			curSelectEntityMO = nil
		end

		local notDead = curSelectEntityMO ~= nil
		local cantSelect1 = curSelectEntityMO and curSelectEntityMO:hasBuffFeature(FightEnum.BuffType_CantSelect)
		local cantSelect2 = curSelectEntityMO and curSelectEntityMO:hasBuffFeature(FightEnum.BuffType_CantSelectEx)

		if self.curSelectEntityId ~= 0 and notDead and not cantSelect1 and not cantSelect2 then
			return
		end

		local enemyList = FightDataHelper.entityMgr:getEnemyNormalList()

		for i = #enemyList, 1, -1 do
			local enemyMO = enemyList[i]

			if enemyMO:hasBuffFeature(FightEnum.BuffType_CantSelect) or enemyMO:hasBuffFeature(FightEnum.BuffType_CantSelectEx) then
				table.remove(enemyList, i)
			end
		end

		if #enemyList > 0 then
			table.sort(enemyList, function(enemyMO1, enemyMO2)
				return enemyMO1.position < enemyMO2.position
			end)
			self:setCurSelectEntityId(enemyList[1].id)
		end
	end
end

function FightOperationDataMgr:getSelectEnemyPosLOrR(LorR)
	local enemyList = FightDataHelper.entityMgr:getEnemyNormalList()

	for i = #enemyList, 1, -1 do
		local enemyMO = enemyList[i]

		if enemyMO:hasBuffFeature(FightEnum.BuffType_CantSelect) or enemyMO:hasBuffFeature(FightEnum.BuffType_CantSelectEx) then
			table.remove(enemyList, i)
		end
	end

	if #enemyList > 0 then
		table.sort(enemyList, function(enemyMO1, enemyMO2)
			local posX1, _, _ = FightHelper.getEntityStandPos(enemyMO1)
			local posX2, _, _ = FightHelper.getEntityStandPos(enemyMO2)

			return posX2 < posX1
		end)

		for i = 1, #enemyList do
			if enemyList[i].id == self.curSelectEntityId then
				if LorR == 1 and i < #enemyList then
					return enemyList[i + 1].id
				elseif LorR == 2 and i > 1 then
					return enemyList[i - 1].id
				end
			end
		end
	end
end

function FightOperationDataMgr:addSurvivalTalentSkillUsedCount(useCount)
	self.survivalTalentSkillUsedCount = self.survivalTalentSkillUsedCount + useCount
end

function FightOperationDataMgr:applyNextRoundActPoint()
	local curRoundData = self.dataMgr.roundMgr.curRoundData

	self.actPoint = curRoundData.actPoint or self.actPoint
end

function FightOperationDataMgr:setOpIsFlying(op, isFlying)
	self.op2FlyItemDict = self.op2FlyItemDict or {}
	self.op2FlyItemDict[op] = isFlying
end

function FightOperationDataMgr:checkOpIsFlying(op)
	if not self.op2FlyItemDict then
		return false
	end

	return self.op2FlyItemDict[op]
end

function FightOperationDataMgr:setLorenzRecordSkillDepend(roundOp)
	self.lorenz_dependRoundOp = roundOp
end

function FightOperationDataMgr:getLorenzRecordSkillDepend()
	return self.lorenz_dependRoundOp
end

function FightOperationDataMgr:setLorenzRecordSkillId(skillId)
	self.lorenz_skillId = tonumber(skillId)
end

function FightOperationDataMgr:getLorenzRecordSkillId()
	return self.lorenz_skillId
end

function FightOperationDataMgr:getShowIndex(roundOp)
	local refresh_index = tabletool.indexOf(self._begin_round_ops, roundOp)

	if refresh_index then
		for i = 1, refresh_index - 1 do
			local op = self._begin_round_ops[i]

			if op:needCopyCard() then
				refresh_index = refresh_index + 1
			end
		end
	end

	return refresh_index
end

function FightOperationDataMgr:getBeginRoundOpList()
	return self._begin_round_ops
end

function FightOperationDataMgr:addBeginRoundOp(roundOp)
	table.insert(self._begin_round_ops, roundOp)
end

function FightOperationDataMgr:getExtraMoveRoundOpList()
	return self._extra_move_round_ops
end

function FightOperationDataMgr:addExtraMoveRoundOp(roundOp)
	table.insert(self._extra_move_round_ops, roundOp)
end

function FightOperationDataMgr:getAllRecordOpList()
	return self._all_recorded_ops
end

function FightOperationDataMgr:addAllRecordRoundOp(roundOp)
	table.insert(self._all_recorded_ops, roundOp)
end

function FightOperationDataMgr:removeAllRecordRoundOp(roundOp)
	return self:removeListValue(self._all_recorded_ops, roundOp)
end

function FightOperationDataMgr:clearAllRecordRoundData()
	tabletool.clear(self._all_recorded_ops)
end

function FightOperationDataMgr:clearBeginRoundData()
	tabletool.clear(self._begin_round_ops)
	tabletool.clear(self._extra_move_round_ops)
	tabletool.clear(self._all_recorded_ops)
	self:setLorenzRecordSkillId(nil)
	self:setLorenzRecordSkillDepend(nil)
end

function FightOperationDataMgr:removeListValue(list, value)
	if not list then
		return
	end

	for i, v in ipairs(list) do
		if v == value then
			table.remove(list, i)

			return i
		end
	end
end

function FightOperationDataMgr:buildCanRecordCardEffectTag()
	self.entityRecordDict = self.entityRecordDict or {}

	for _, list in pairs(self.entityRecordDict) do
		tabletool.clear(list)
	end

	local entityList = FightDataHelper.entityMgr:getMyNormalList()

	for _, entityMo in ipairs(entityList) do
		local buffDict = entityMo:getBuffDic()

		for _, buffMo in pairs(buffDict) do
			local buffActInfoList = buffMo.actInfo

			for _, buffActInfo in ipairs(buffActInfoList) do
				if buffActInfo.actId == FightEnum.BuffActId.ButterflyRecordSkill then
					local list = self.entityRecordDict[entityMo.uid]

					if not list then
						list = {}
						self.entityRecordDict[entityMo.uid] = list
					end

					tabletool.addValues(list, buffActInfo.param)
				end
			end
		end
	end
end

function FightOperationDataMgr:canRecordCard(cardInfoMo, entityId)
	local skillId = cardInfoMo and cardInfoMo.skillId

	if FightCardDataHelper.isBigSkill(skillId) then
		return
	end

	local skillCo = skillId and lua_skill.configDict[skillId]

	if not skillCo then
		return
	end

	if not entityId then
		local dependOp = self.lorenz_dependRoundOp
		local cardInfo = dependOp and dependOp.cardInfoMO

		entityId = cardInfo and cardInfo.uid
	end

	if not entityId then
		return
	end

	if self.entityRecordDict then
		local canRecordTagList = self.entityRecordDict[entityId]

		if not canRecordTagList then
			return
		end

		local effectTag = skillCo.effectTag

		if tabletool.indexOf(canRecordTagList, effectTag) then
			return true
		end
	end
end

return FightOperationDataMgr
