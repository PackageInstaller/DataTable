-- chunkname: @modules/logic/fight/system/work/FightWorkUpdateCardData377.lua

module("modules.logic.fight.system.work.FightWorkUpdateCardData377", package.seeall)

local FightWorkUpdateCardData377 = class("FightWorkUpdateCardData377", FightEffectBase)

FightWorkUpdateCardData377.UnnamedTypeAnimDuration = 0.667

local UpdateAreaType = {
	PlayedCard = 1,
	HandCard = 0
}

function FightWorkUpdateCardData377:onStart()
	local cardIndex = self.actEffectData.effectNum
	local areaType = self.actEffectData.effectNum1

	if areaType == UpdateAreaType.HandCard then
		FightController.instance:dispatchEvent(FightEvent.UpdateOneHandCard, cardIndex, FightEnum.UpdateCardItemFromType.ActEffectUpdateCard)
	elseif areaType == UpdateAreaType.PlayedCard then
		local cardList = FightPlayCardModel.instance:getUsedCards()

		cardList[cardIndex] = FightCardInfoData.New(self.actEffectData.cardInfo)

		FightController.instance:dispatchEvent(FightEvent.UpdateOnePlayedCard, cardIndex, FightEnum.UpdateCardItemFromType.ActEffectUpdateCard)
	end

	local cardData = self.actEffectData.cardInfo

	if cardData and cardData:checkIsUnnamedCard() then
		self:cancelFightWorkSafeTimer()
		self:com_registTimer(self._delayDone, FightWorkUpdateCardData377.UnnamedTypeAnimDuration)

		return
	end

	return self:onDone(true)
end

return FightWorkUpdateCardData377
