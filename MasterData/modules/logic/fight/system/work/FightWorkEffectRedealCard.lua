-- chunkname: @modules/logic/fight/system/work/FightWorkEffectRedealCard.lua

module("modules.logic.fight.system.work.FightWorkEffectRedealCard", package.seeall)

local FightWorkEffectRedealCard = class("FightWorkEffectRedealCard", FightEffectBase)

function FightWorkEffectRedealCard:beforePlayEffectData()
	self.oldHandCard = FightDataUtil.copyData(FightDataHelper.handCardMgr.handCard)
end

function FightWorkEffectRedealCard:onStart()
	FightController.instance:dispatchEvent(FightEvent.PushCardInfo)
	self:_playRedealCardEffect()
end

function FightWorkEffectRedealCard:_playRedealCardEffect()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_shuffle_allcard)

	local oldCards = self.oldHandCard
	local newCards = FightDataHelper.handCardMgr.handCard

	self:com_registTimer(self._delayAfterPerformance, 1.5 / FightModel.instance:getUISpeed())
	FightController.instance:dispatchEvent(FightEvent.PlayRedealCardEffect, oldCards, newCards)
end

function FightWorkEffectRedealCard:clearWork()
	return
end

return FightWorkEffectRedealCard
