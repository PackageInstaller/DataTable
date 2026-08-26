-- chunkname: @modules/logic/fight/system/work/FightWorkCardAConvertCardB.lua

module("modules.logic.fight.system.work.FightWorkCardAConvertCardB", package.seeall)

local FightWorkCardAConvertCardB = class("FightWorkCardAConvertCardB", FightEffectBase)

function FightWorkCardAConvertCardB:onStart()
	if not FightCardDataHelper.cardChangeIsMySide(self.actEffectData) then
		self:onDone(true)

		return
	end

	self._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)
	AudioMgr.instance:trigger(2000072)

	local version = FightModel.instance:getVersion()

	if version >= 4 then
		FightController.instance:dispatchEvent(FightEvent.CardAConvertCardB, self.actEffectData.effectNum, self.actEffectData)
		self:com_registTimer(self._delayAfterPerformance, FightEnum.PerformanceTime.CardAConvertCardB / FightModel.instance:getUISpeed())
	else
		FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
		self:onDone(true)
	end
end

function FightWorkCardAConvertCardB:clearWork()
	if self._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return FightWorkCardAConvertCardB
