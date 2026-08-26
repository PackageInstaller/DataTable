-- chunkname: @modules/logic/fight/system/work/FightWorkAddSpHandCard320.lua

module("modules.logic.fight.system.work.FightWorkAddSpHandCard320", package.seeall)

local FightWorkAddSpHandCard320 = class("FightWorkAddSpHandCard320", FightEffectBase)
local SKILL_ID = {
	DEVICE_ADD_CARD = 30010702
}

function FightWorkAddSpHandCard320:onConstructor()
	self.SAFETIME = 1.5
end

function FightWorkAddSpHandCard320:onStart()
	if not FightCardDataHelper.cardChangeIsMySide(self.actEffectData) then
		self:onDone(true)

		return
	end

	self._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	local skillId = self.actEffectData.effectNum1

	if skillId == SKILL_ID.DEVICE_ADD_CARD then
		FightController.instance:registerCallback(FightEvent.OnDevice_AddHandCardDone, self._delayAfterPerformance, self)
		FightController.instance:dispatchEvent(FightEvent.OnDevice_AddHandCard)
	else
		FightController.instance:dispatchEvent(FightEvent.SpCardAdd, #FightDataHelper.handCardMgr.handCard)
		self:com_registTimer(self._delayAfterPerformance, 0.7 / FightModel.instance:getUISpeed())
	end
end

function FightWorkAddSpHandCard320:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnDevice_AddHandCardDone, self._delayAfterPerformance, self)

	if self._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return FightWorkAddSpHandCard320
