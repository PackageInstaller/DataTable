-- chunkname: @modules/logic/fight/system/work/FightWorkSpCardAdd.lua

module("modules.logic.fight.system.work.FightWorkSpCardAdd", package.seeall)

local FightWorkSpCardAdd = class("FightWorkSpCardAdd", FightEffectBase)

function FightWorkSpCardAdd:onStart()
	if not FightCardDataHelper.cardChangeIsMySide(self.actEffectData) then
		self:onDone(true)

		return
	end

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	local cards = FightDataHelper.handCardMgr.handCard

	self._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_add_universalcard)
	FightController.instance:dispatchEvent(FightEvent.SpCardAdd, #cards)
	self:com_registTimer(self._delayAfterPerformance, 0.7 / FightModel.instance:getUISpeed())
end

function FightWorkSpCardAdd:clearWork()
	if self._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return FightWorkSpCardAdd
