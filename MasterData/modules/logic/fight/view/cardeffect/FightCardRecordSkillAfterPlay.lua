-- chunkname: @modules/logic/fight/view/cardeffect/FightCardRecordSkillAfterPlay.lua

module("modules.logic.fight.view.cardeffect.FightCardRecordSkillAfterPlay", package.seeall)

local FightCardRecordSkillAfterPlay = class("FightCardRecordSkillAfterPlay", BaseWork)

function FightCardRecordSkillAfterPlay:onStart(context)
	if FightDataHelper.stateMgr:getIsAuto() or FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.AutoCardPlaying) then
		self:tryRefreshRecordedSkill()

		return self:onDone(true)
	end

	if FightDataHelper.stateMgr.isReplay then
		self:tryRefreshRecordedSkill()

		return self:onDone(true)
	end

	return self:handleNormal()
end

function FightCardRecordSkillAfterPlay:tryRefreshRecordedSkill()
	local dependOp = FightDataHelper.operationDataMgr:getLorenzRecordSkillDepend()

	if dependOp then
		FightController.instance:dispatchEvent(FightEvent.RefreshRecordSkill)
	end
end

function FightCardRecordSkillAfterPlay:handleNormal()
	if not self.context.canEnterLorentzRecordSkill then
		return self:onDone(true)
	end

	FightController.instance:dispatchEvent(FightEvent.RefreshRecordSkill)
	FightController.instance:dispatchEvent(FightEvent.SetBlockCardOperate, false)
	FightDataHelper.stageMgr:enterOperateState(FightStageMgr.OperateStateType.RecordSkill)
	FightController.instance:registerCallback(FightEvent.SelectRecordSkill, self.onSelectRecordSkill, self)
end

function FightCardRecordSkillAfterPlay:onSelectRecordSkill(cardIndex)
	local cards = self.context.cards

	self.context.view:_updateHandCards(cards)

	local cardInfoMo = cards and cards[cardIndex]

	if not cardInfoMo then
		self:recordSkillDone()

		return
	end

	local roundOp = self.context.fightBeginRoundOp

	roundOp:setCardParam1(cardInfoMo.skillId, cardInfoMo.uid)
	FightDataHelper.operationDataMgr:setLorenzRecordSkillId(cardInfoMo.skillId)
	FightController.instance:dispatchEvent(FightEvent.RefreshRecordSkill)
	self:recordSkillDone()
end

function FightCardRecordSkillAfterPlay:recordSkillDone()
	FightController.instance:unregisterCallback(FightEvent.SelectRecordSkill, self.onSelectRecordSkill, self)
	FightDataHelper.stageMgr:exitOperateState(FightStageMgr.OperateStateType.RecordSkill)
	self:onDone(true)
end

function FightCardRecordSkillAfterPlay:clearWork()
	FightDataHelper.stageMgr:exitOperateState(FightStageMgr.OperateStateType.RecordSkill)
	FightController.instance:unregisterCallback(FightEvent.SelectRecordSkill, self.onSelectRecordSkill, self)
end

return FightCardRecordSkillAfterPlay
