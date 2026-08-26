-- chunkname: @modules/logic/fight/system/work/FightWorkEffectUniversalCard.lua

module("modules.logic.fight.system.work.FightWorkEffectUniversalCard", package.seeall)

local FightWorkEffectUniversalCard = class("FightWorkEffectUniversalCard", FightEffectBase)

function FightWorkEffectUniversalCard:onStart()
	if not FightCardDataHelper.cardChangeIsMySide(self.actEffectData) then
		self:onDone(true)

		return
	end

	FightController.instance:dispatchEvent(FightEvent.PushCardInfo)
	FightController.instance:dispatchEvent(FightEvent.UniversalAppear)
	self:com_registTimer(self._delayDone, 1.3 / FightModel.instance:getUISpeed())
	AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_add_universalcard)
end

function FightWorkEffectUniversalCard:_delayDone()
	self:onDone(true)
end

function FightWorkEffectUniversalCard:clearWork()
	return
end

return FightWorkEffectUniversalCard
