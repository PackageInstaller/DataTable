-- chunkname: @modules/logic/fight/system/work/FightWorkAddUseCard.lua

module("modules.logic.fight.system.work.FightWorkAddUseCard", package.seeall)

local FightWorkAddUseCard = class("FightWorkAddUseCard", FightEffectBase)

function FightWorkAddUseCard:onStart()
	if not FightCardDataHelper.cardChangeIsMySide(self.actEffectData) then
		self:onDone(true)

		return
	end

	local index = self.actEffectData.effectNum
	local curUsedCards = FightPlayCardModel.instance:getUsedCards()

	if index - 1 > #curUsedCards then
		index = #curUsedCards + 1
	end

	FightViewPartVisible.set(false, false, false, false, true)
	FightPlayCardModel.instance:addUseCard(index, self.actEffectData.cardInfo, self.actEffectData.effectNum1)

	local behaviourId = tonumber(self.actEffectData.reserveId)

	FightController.instance:dispatchEvent(FightEvent.AddUseCard, {
		index
	}, {
		behaviourId
	})

	local waitTime = self:getWaitTime()

	self:com_registTimer(self._delayAfterPerformance, waitTime / FightModel.instance:getUISpeed())
end

function FightWorkAddUseCard:getWaitTime()
	if FightHeroALFComp.ALFSkillDict[self.actEffectData.effectNum1] then
		return 1.8
	end

	local behaviourId = tonumber(self.actEffectData.reserveId)

	if behaviourId == FightEnum.SkillBehaviourId.UseCardCopy then
		return 1.8
	end

	return 0.5
end

function FightWorkAddUseCard:clearWork()
	return
end

return FightWorkAddUseCard
