-- chunkname: @modules/logic/fight/system/work/FightWorkEffectCardLevelChange.lua

module("modules.logic.fight.system.work.FightWorkEffectCardLevelChange", package.seeall)

local FightWorkEffectCardLevelChange = class("FightWorkEffectCardLevelChange", FightEffectBase)

function FightWorkEffectCardLevelChange:beforePlayEffectData()
	local cards = FightDataHelper.handCardMgr.handCard

	self.cardIndex = tonumber(self.actEffectData.targetId)

	local cardInfo = cards[self.cardIndex]

	self.oldSkillId = cardInfo and cardInfo.skillId
end

function FightWorkEffectCardLevelChange:onStart()
	self:_startChangeCardEffect()
end

function FightWorkEffectCardLevelChange:_startChangeCardEffect()
	if not FightCardDataHelper.cardChangeIsMySide(self.actEffectData) then
		self:onDone(true)

		return
	end

	local version = FightModel.instance:getVersion()

	if version < 1 then
		local entityId = self.actEffectData.entity.id
		local entity = FightHelper.getEntity(entityId)

		if not entity then
			self:onDone(true)

			return
		end

		if not entity:isMySide() then
			self:onDone(true)

			return
		end
	end

	if not self.oldSkillId then
		self:onDone(true)

		return
	end

	self._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	local version = FightModel.instance:getVersion()

	if version >= 4 then
		FightController.instance:dispatchEvent(FightEvent.CardLevelChange, self.cardIndex, self.oldSkillId)
		self:com_registTimer(self._delayDone, FightEnum.PerformanceTime.CardLevelChange / FightModel.instance:getUISpeed())
	else
		FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
		self:onDone(true)
	end
end

function FightWorkEffectCardLevelChange:_delayDone()
	self:onDone(true)
end

function FightWorkEffectCardLevelChange:clearWork()
	if self._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return FightWorkEffectCardLevelChange
