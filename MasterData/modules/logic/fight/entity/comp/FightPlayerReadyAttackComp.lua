-- chunkname: @modules/logic/fight/entity/comp/FightPlayerReadyAttackComp.lua

module("modules.logic.fight.entity.comp.FightPlayerReadyAttackComp", package.seeall)

local FightPlayerReadyAttackComp = class("FightPlayerReadyAttackComp", FightBaseClass)

function FightPlayerReadyAttackComp:onConstructor(entity)
	self.entity = entity

	self:com_registFightEvent(FightEvent.OnPlayHandCard, self._onPlayHandCard)
	self:com_registFightEvent(FightEvent.OnRevertCard, self._onRevertCard)
	self:com_registFightEvent(FightEvent.OnResetCard, self._onResetCard)
	self:com_registFightEvent(FightEvent.BeforePlaySkill, self._beforePlaySkill)
	self:com_registFightEvent(FightEvent.StageChanged, self._onStageChange)
end

function FightPlayerReadyAttackComp:onDestructor()
	self:_clearReadyAttackWork()
end

function FightPlayerReadyAttackComp:_onPlayHandCard(cardInfoMO)
	if cardInfoMO.uid ~= self.entity.id then
		return
	end

	local ops = FightDataHelper.operationDataMgr:getEntityOps(cardInfoMO.uid, FightEnum.CardOpType.PlayCard)

	if #ops > 0 and not self._readyAttackWork then
		local entityMO = FightDataHelper.entityMgr:getById(cardInfoMO.uid)

		if entityMO then
			::label_3_0::

			local allOps = FightDataHelper.operationDataMgr:getOpList()
			local buffList = allOps and FightBuffHelper.simulateBuffList(entityMO, allOps[#allOps])

			if FightViewHandCardItemLock.canUseCardSkill(cardInfoMO.uid, cardInfoMO.skillId, buffList) then
				self._readyAttackWork = FightReadyAttackWork.New()

				self._readyAttackWork:onStart(self.entity)
			end
		end
	end
end

function FightPlayerReadyAttackComp:_onRevertCard(cardOp)
	if cardOp.belongToEntityId ~= self.entity.id then
		return
	end

	if cardOp:isPlayCard() then
		local ops = FightDataHelper.operationDataMgr:getEntityOps(self.entity.id)

		if (not ops or #ops == 0) and self._readyAttackWork then
			self.entity:resetAnimState()
			self:_clearReadyAttackWork()
		end
	end
end

function FightPlayerReadyAttackComp:_onResetCard()
	if self._readyAttackWork then
		self.entity:resetAnimState()
		self:_clearReadyAttackWork()
	end
end

function FightPlayerReadyAttackComp:_beforePlaySkill(entity, skillId, fightStepData)
	if self.entity == entity then
		self:_clearReadyAttackWork()
	end
end

function FightPlayerReadyAttackComp:_onStageChange()
	self:_clearReadyAttackWork()

	for k, entity in pairs(FightGameMgr.entityMgr.entityDic) do
		local spine = entity.spine

		if spine and not gohelper.isNil(spine:getSpineGO()) and spine:getAnimState() == SpineAnimState.change then
			spine:play(SpineAnimState.posture, true, true)
		end
	end
end

function FightPlayerReadyAttackComp:_clearReadyAttackWork()
	if self._readyAttackWork then
		self._readyAttackWork:onStop()

		self._readyAttackWork = nil
	end
end

return FightPlayerReadyAttackComp
