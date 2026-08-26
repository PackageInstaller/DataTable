-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventUIVisible.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventUIVisible", package.seeall)

local FightTLEventUIVisible = class("FightTLEventUIVisible", FightTimelineTrackItem)
local latestStepUid
local filterEffectType = {
	[FightEnum.EffectType.DAMAGEFROMABSORB] = true,
	[FightEnum.EffectType.STORAGEINJURY] = true,
	[FightEnum.EffectType.SHIELDVALUECHANGE] = true,
	[FightEnum.EffectType.SHAREHURT] = true
}

function FightTLEventUIVisible.resetLatestStepUid()
	latestStepUid = nil
end

function FightTLEventUIVisible:onTrackStart(fightStepData, duration, paramsArr)
	if latestStepUid and fightStepData.stepUid < latestStepUid then
		return
	end

	latestStepUid = fightStepData.stepUid
	self.fightStepData = fightStepData
	self._isShowUI = paramsArr[1] == "1"
	self._isShowFloat = paramsArr[2] == "1"
	self._isShowNameUI = paramsArr[3] == "1"
	self._showNameUITarget = paramsArr[4] and tonumber(paramsArr[4]) or 0

	local attacker = FightHelper.getEntity(fightStepData.fromId)
	local defender = FightHelper.getEntity(fightStepData.toId)

	self._entitys = nil

	if self._showNameUITarget == 0 then
		self._entitys = FightHelper.getAllEntitys()
	elseif self._showNameUITarget == 1 then
		self._entitys = {}

		table.insert(self._entitys, attacker)
	elseif self._showNameUITarget == 2 then
		self._entitys = FightHelper.getSkillTargetEntitys(fightStepData, filterEffectType)
	elseif self._showNameUITarget == 3 then
		if attacker then
			self._entitys = FightHelper.getSideEntitys(attacker:getSide(), true)
		end
	elseif self._showNameUITarget == 4 and defender then
		self._entitys = FightHelper.getSideEntitys(defender:getSide(), true)
	end

	self:_setShowUI()
	TaskDispatcher.runRepeat(self._setShowUI, self, 0.5)
	FightController.instance:registerCallback(FightEvent.ParallelPlayNextSkillDoneThis, self._onDoneThis, self)
	FightController.instance:registerCallback(FightEvent.ForceEndSkillStep, self._onDoneThis, self)
end

function FightTLEventUIVisible:onTrackEnd()
	self:_removeEvent()
end

function FightTLEventUIVisible:_setShowUI()
	FightController.instance:dispatchEvent(FightEvent.SetIsShowUI, self._isShowUI)
	FightController.instance:dispatchEvent(FightEvent.SetIsShowFloat, self._isShowFloat)

	if self._entitys then
		for _, entity in ipairs(self._entitys) do
			FightController.instance:dispatchEvent(FightEvent.SetNameUIVisibleByTimeline, entity, self.fightStepData, self._isShowNameUI)
		end
	end
end

function FightTLEventUIVisible:_onDoneThis(fightStepData)
	if fightStepData == self.fightStepData then
		self:_removeEvent()
	end
end

function FightTLEventUIVisible:_removeEvent()
	TaskDispatcher.cancelTask(self._setShowUI, self)
	FightController.instance:unregisterCallback(FightEvent.ParallelPlayNextSkillDoneThis, self._onDoneThis, self)
	FightController.instance:unregisterCallback(FightEvent.ForceEndSkillStep, self._onDoneThis, self)
end

function FightTLEventUIVisible:onDestructor()
	self._entitys = nil

	self:_removeEvent()
end

return FightTLEventUIVisible
