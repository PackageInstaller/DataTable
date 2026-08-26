-- chunkname: @modules/logic/fight/entity/mgr/FightSkillMgr.lua

module("modules.logic.fight.entity.mgr.FightSkillMgr", package.seeall)

local FightSkillMgr = class("FightSkillMgr")

function FightSkillMgr:ctor()
	self._playingEntityId2StepData = {}
	self._playingSkillCount = 0
end

function FightSkillMgr:init()
	return
end

function FightSkillMgr:dispose()
	self._playingEntityId2StepData = {}
	self._playingSkillCount = 0
end

function FightSkillMgr:beforeTimeline(entity, fightStepData)
	self._playingSkillCount = self._playingSkillCount + 1
	self._playingEntityId2StepData[entity.id] = fightStepData or 1

	entity:resetEntity()
	FightController.instance:dispatchEvent(FightEvent.BeforePlayTimeline, entity.id, fightStepData)

	if FightCardDataHelper.isBigSkill(fightStepData.actId) then
		FightController.instance:dispatchEvent(FightEvent.BeforePlayUniqueSkill, entity.id)
	end
end

function FightSkillMgr:afterTimeline(entity, fightStepData)
	self._playingSkillCount = self._playingSkillCount - 1

	if self._playingSkillCount < 0 then
		self._playingSkillCount = 0
	end

	self._playingEntityId2StepData[entity.id] = nil

	if fightStepData and FightCardDataHelper.isBigSkill(fightStepData.actId) then
		FightController.instance:dispatchEvent(FightEvent.AfterPlayUniqueSkill, entity.id)

		local all = FightHelper.getAllEntitys()

		for _, oneEntity in ipairs(all) do
			oneEntity:resetEntity()
		end
	else
		entity:resetEntity()
	end

	if not self:isPlayingAnyTimeline() then
		FightTLEventUIVisible.resetLatestStepUid()
	end
end

function FightSkillMgr:isEntityPlayingTimeline(entityId)
	return self._playingEntityId2StepData[entityId] ~= nil
end

function FightSkillMgr:isPlayingAnyTimeline()
	return self._playingSkillCount > 0
end

FightSkillMgr.instance = FightSkillMgr.New()

return FightSkillMgr
