-- chunkname: @modules/logic/fight/system/work/FightWorkCrystalAddCard359.lua

module("modules.logic.fight.system.work.FightWorkCrystalAddCard359", package.seeall)

local FightWorkCrystalAddCard359 = class("FightWorkCrystalAddCard359", FightEffectBase)

function FightWorkCrystalAddCard359:onConstructor()
	self.SAFETIME = 20
end

function FightWorkCrystalAddCard359:onStart()
	if not FightCardDataHelper.cardChangeIsMySide(self.actEffectData) then
		return self:onDone(true)
	end

	local entity = FightHelper.getEntity(self.actEffectData.targetId)

	if not entity then
		return self:onDone(true)
	end

	self._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	local timeline = self:getTimeline()
	local work = entity.skill:registTimelineWork(timeline, self.fightStepData)

	if work then
		work:registFinishCallback(self.onPlayTimeDone, self)
		work:start()
	else
		self:onPlayTimeDone()
	end
end

function FightWorkCrystalAddCard359:onPlayTimeDone()
	FightController.instance:dispatchEvent(FightEvent.AddHandCard)
	self:com_registTimer(self._delayAfterPerformance, 0.5)
end

function FightWorkCrystalAddCard359:getTimeline()
	local cardInfo = self.actEffectData.cardInfo
	local co = FightHeroSpEffectConfig.instance:getSkill2CrystalCo(cardInfo.skillId)
	local crystal = co.crystal
	local crystalCo = FightHeroSpEffectConfig.instance:getBLECrystalCo(crystal)

	return crystalCo.cardTimeline
end

function FightWorkCrystalAddCard359:clearWork()
	if self._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return FightWorkCrystalAddCard359
