-- chunkname: @modules/logic/fight/system/work/FightWorkMasterAddHandCard.lua

module("modules.logic.fight.system.work.FightWorkMasterAddHandCard", package.seeall)

local FightWorkMasterAddHandCard = class("FightWorkMasterAddHandCard", FightEffectBase)

function FightWorkMasterAddHandCard:onStart()
	if not FightCardDataHelper.cardChangeIsMySide(self.actEffectData) then
		self:onDone(true)

		return
	end

	self._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)
	AudioMgr.instance:trigger(20190019)

	local version = FightModel.instance:getVersion()

	if version >= 4 then
		FightController.instance:dispatchEvent(FightEvent.MasterAddHandCard)
		self:com_registTimer(self._delayAfterPerformance, 1 / FightModel.instance:getUISpeed())
	else
		FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
		self:onDone(true)
	end
end

function FightWorkMasterAddHandCard:_delayAfterPerformance()
	self:onDone(true)
end

function FightWorkMasterAddHandCard:clearWork()
	if self._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return FightWorkMasterAddHandCard
