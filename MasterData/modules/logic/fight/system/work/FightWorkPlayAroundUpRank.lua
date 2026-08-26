-- chunkname: @modules/logic/fight/system/work/FightWorkPlayAroundUpRank.lua

module("modules.logic.fight.system.work.FightWorkPlayAroundUpRank", package.seeall)

local FightWorkPlayAroundUpRank = class("FightWorkPlayAroundUpRank", FightEffectBase)

function FightWorkPlayAroundUpRank:onStart()
	if not FightCardDataHelper.cardChangeIsMySide(self.actEffectData) then
		self:onDone(true)

		return
	end

	local index = self.actEffectData.effectNum
	local usedCards = FightPlayCardModel.instance:getUsedCards()
	local usedCard = usedCards[index]

	if usedCard then
		local oldSkillId = usedCard.skillId

		FightDataUtil.coverData(self.actEffectData.cardInfo, usedCard)

		if self.actEffectData.effectNum1 == 1 then
			self:com_sendFightEvent(FightEvent.PlayCardAroundUpRank_Lorentz, index, usedCard)
		else
			self:com_sendFightEvent(FightEvent.PlayCardAroundUpRank, index, oldSkillId)
		end
	end

	self:com_registTimer(self._delayAfterPerformance, FightEnum.PerformanceTime.CardLevelChange / FightModel.instance:getUISpeed() + 0.1)
end

function FightWorkPlayAroundUpRank:clearWork()
	return
end

return FightWorkPlayAroundUpRank
