-- chunkname: @modules/logic/fight/system/work/FightWorkPlaySetGray.lua

module("modules.logic.fight.system.work.FightWorkPlaySetGray", package.seeall)

local FightWorkPlaySetGray = class("FightWorkPlaySetGray", FightEffectBase)

function FightWorkPlaySetGray:onStart()
	if not FightCardDataHelper.cardChangeIsMySide(self.actEffectData) then
		self:onDone(true)

		return
	end

	local index = self.actEffectData.effectNum
	local usedCards = FightPlayCardModel.instance:getUsedCards()
	local usedCard = usedCards[index]

	if usedCard then
		FightDataUtil.coverData(self.actEffectData.cardInfo, usedCard)
		FightController.instance:dispatchEvent(FightEvent.PlayCardAroundSetGray, index)
	end

	self:onDone(true)
end

function FightWorkPlaySetGray:clearWork()
	return
end

return FightWorkPlaySetGray
