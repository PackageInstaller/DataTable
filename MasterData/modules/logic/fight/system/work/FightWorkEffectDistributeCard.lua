-- chunkname: @modules/logic/fight/system/work/FightWorkEffectDistributeCard.lua

module("modules.logic.fight.system.work.FightWorkEffectDistributeCard", package.seeall)

local FightWorkEffectDistributeCard = class("FightWorkEffectDistributeCard", FightEffectBase)

FightWorkEffectDistributeCard.handCardScale = 0.52
FightWorkEffectDistributeCard.handCardScaleTime = 0.25

function FightWorkEffectDistributeCard:onConstructor()
	self.skipAutoPlayData = true
end

function FightWorkEffectDistributeCard:onStart()
	self:com_registTimer(self._delayDone, 20)
	TaskDispatcher.runDelay(self._delayDistribute, self, 0.01)
end

function FightWorkEffectDistributeCard:_delayDistribute()
	local roundData = FightDataHelper.roundMgr:getRoundData()

	if not roundData then
		logError("回合数据不存在")
		self:onDone(false)

		return
	end

	if self.actEffectData.effectType == FightEnum.EffectType.DEALCARD2 then
		local beforeCards = FightDataHelper.handCardMgr.beforeCards2
		local teamAcards = FightDataHelper.handCardMgr.teamACards2

		if #beforeCards > 0 or #teamAcards > 0 then
			FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.DistributeCard)
			FightController.instance:registerCallback(FightEvent.OnDistributeCards, self._distributeDone, self)
			FightViewPartVisible.set(false, true, false, false, false)
			FightController.instance:dispatchEvent(FightEvent.DistributeCards, beforeCards, teamAcards)
		else
			self:_distributeDone()
		end
	else
		self:onDone(true)
	end
end

function FightWorkEffectDistributeCard:_distributeDone()
	FightController.instance:unregisterCallback(FightEvent.OnDistributeCards, self._distributeDone, self)

	local handCardContainer = FightViewHandCard.handCardContainer
	local enemyList = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide, true)
	local hasEnemySkill = self:_checkHasEnemySkill()

	if not gohelper.isNil(handCardContainer) and #enemyList > 0 and hasEnemySkill then
		FightViewPartVisible.set(false, true, false, true, false)

		local scale = FightWorkEffectDistributeCard.handCardScale
		local time = FightWorkEffectDistributeCard.getHandCardScaleTime()

		self.tweenId = ZProj.TweenHelper.DOScale(handCardContainer.transform, scale, scale, scale, time, self._onHandCardsShrink, self)
	else
		self:_onHandCardsShrink()
	end
end

function FightWorkEffectDistributeCard:_checkHasEnemySkill()
	local roundData = FightDataHelper.roundMgr:getRoundData()
	local beginCheck = false

	for _, step in ipairs(roundData.fightStep) do
		if not beginCheck and step.actType == FightEnum.ActType.EFFECT then
			for _, effect in ipairs(step.actEffect) do
				if effect.effectType == FightEnum.EffectType.DEALCARD2 then
					beginCheck = true

					break
				end
			end
		elseif beginCheck and step.actType == FightEnum.ActType.SKILL then
			local attacker = FightHelper.getEntity(step.fromId)

			if attacker and attacker:isEnemySide() then
				return true
			end
		end
	end

	return false
end

function FightWorkEffectDistributeCard:_onHandCardsShrink()
	self:onDone(true)
end

function FightWorkEffectDistributeCard.getHandCardScaleTime()
	return FightWorkEffectDistributeCard.handCardScaleTime / FightModel.instance:getUISpeed()
end

function FightWorkEffectDistributeCard:clearWork()
	FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.DistributeCard)

	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end

	TaskDispatcher.cancelTask(self._delayDistribute, self)
	FightController.instance:unregisterCallback(FightEvent.OnDistributeCards, self._distributeDone, self)
	FightController.instance:unregisterCallback(FightEvent.OnDissolveCombineEnd, self._onDissolveCombineEnd, self)
	TaskDispatcher.cancelTask(self._dissolveTimeout, self)
end

function FightWorkEffectDistributeCard:_delayDone()
	self:onDone(true)
end

return FightWorkEffectDistributeCard
