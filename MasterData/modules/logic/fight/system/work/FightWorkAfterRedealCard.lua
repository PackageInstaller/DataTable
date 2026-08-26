-- chunkname: @modules/logic/fight/system/work/FightWorkAfterRedealCard.lua

module("modules.logic.fight.system.work.FightWorkAfterRedealCard", package.seeall)

local FightWorkAfterRedealCard = class("FightWorkAfterRedealCard", FightEffectBase)

function FightWorkAfterRedealCard:beforePlayEffectData()
	self.oldCardList = FightDataUtil.copyData(FightDataHelper.handCardMgr.handCard)
end

function FightWorkAfterRedealCard:onStart()
	local version = FightModel.instance:getVersion()

	if version < 5 then
		self:onDone(true)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_shuffle_allcard)
	self:com_registTimer(self._delayAfterPerformance, 1.5 / FightModel.instance:getUISpeed())

	local oldCards = self.oldCardList
	local newCards = FightDataHelper.handCardMgr.handCard

	FightController.instance:dispatchEvent(FightEvent.PlayRedealCardEffect, oldCards, newCards)
end

return FightWorkAfterRedealCard
