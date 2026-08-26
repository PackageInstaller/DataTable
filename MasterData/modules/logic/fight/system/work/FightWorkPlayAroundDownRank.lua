-- chunkname: @modules/logic/fight/system/work/FightWorkPlayAroundDownRank.lua

module("modules.logic.fight.system.work.FightWorkPlayAroundDownRank", package.seeall)

local FightWorkPlayAroundDownRank = class("FightWorkPlayAroundDownRank", FightEffectBase)

function FightWorkPlayAroundDownRank:onStart()
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
		self:com_sendFightEvent(FightEvent.PlayCardAroundDownRank, index, oldSkillId)
	end

	self:com_registTimer(self._delayAfterPerformance, FightEnum.PerformanceTime.CardLevelChange / FightModel.instance:getUISpeed())
end

function FightWorkPlayAroundDownRank:clearWork()
	return
end

return FightWorkPlayAroundDownRank
