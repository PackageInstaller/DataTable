-- chunkname: @modules/logic/fight/system/work/FightWorkPlayChangeRankFail.lua

module("modules.logic.fight.system.work.FightWorkPlayChangeRankFail", package.seeall)

local FightWorkPlayChangeRankFail = class("FightWorkPlayChangeRankFail", FightEffectBase)

function FightWorkPlayChangeRankFail:onStart()
	if not FightCardDataHelper.cardChangeIsMySide(self.actEffectData) then
		self:onDone(true)

		return
	end

	local index = self.actEffectData.effectNum

	self:com_sendFightEvent(FightEvent.PlayChangeRankFail, index, self.actEffectData.reserveStr)
	self:com_registTimer(self._delayAfterPerformance, FightEnum.PerformanceTime.CardLevelChange / FightModel.instance:getUISpeed())
end

function FightWorkPlayChangeRankFail:clearWork()
	return
end

return FightWorkPlayChangeRankFail
