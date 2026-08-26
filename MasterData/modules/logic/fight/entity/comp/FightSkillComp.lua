-- chunkname: @modules/logic/fight/entity/comp/FightSkillComp.lua

module("modules.logic.fight.entity.comp.FightSkillComp", package.seeall)

local FightSkillComp = class("FightSkillComp", FightBaseClass)

FightSkillComp.FrameEventHandlerCls = {
	[0] = FightTLEventMove,
	FightTLEventTargetEffect,
	FightTLEventAtkSpineLookDir,
	FightTLEventDefHit,
	FightTLEventDefFreeze,
	FightTLEventAtkEffect,
	FightTLEventAtkFlyEffect,
	FightTLEventAtkFullEffect,
	FightTLEventDefEffect,
	FightTLEventAtkAction,
	FightTLEventPlayAudio,
	FightTLEventCreateSpine,
	FightTLEventCameraShake,
	FightTLEventEntityVisible,
	FightTLEventSceneMask,
	FightTLEventCameraTrace,
	FightTLEventPlayVideo,
	FightTLEventEntityScale,
	FightTLEventRefreshRenderOrder,
	FightTLEventCameraRotate,
	FightTLEventUIVisible,
	FightTLEventEntityRenderOrder,
	FightTLEventEntityRotate,
	FightTLEventSpineMaterial,
	FightTLEventBloomMaterial,
	FightTLEventDisableSpineRotate,
	FightTLEventHideScene,
	FightTLEventSpeed,
	FightTLEventDefEffect,
	FightTLEventDefHeal,
	FightTLEventUniqueCameraNew,
	FightTLEventEntityAnim,
	FightTLEventEntityTexture,
	FightTLEventJoinSameSkillStart,
	FightTLEventPlayNextSkill,
	FightTLEventSameSkillJump,
	FightTLEventCameraDistance,
	FightTLEventInvokeEntityDead,
	FightTLEventSetSceneObjVisible,
	FightTLEventSetSpinePos,
	FightTLEventSetTimelineTime,
	FightTLEventPlaySceneAnimator,
	FightTLEventPlayServerEffect,
	FightTLEventChangeScene,
	FightTLEventMarkSceneDefaultRoot,
	FightTLEventSceneMove,
	FightTLEventCatapult,
	FightTLEventStressTrigger,
	FightTLEventFloatBuffBySkillEffect,
	FightTLEventLYSpecialSpinePlayAniName,
	FightTLEventInvokeSummon,
	FightTLEventInvokeLookBack,
	FightTLEventSetFightViewPartVisible,
	FightTLEventALFCardEffect,
	FightTLEventPlayEffectByOperation,
	FightTLEventEffectVisible,
	FightTLEvent500MMonsterRefreshHeadIcon,
	FightTLEventAddEffectByBuffActId,
	FightTLAnAnRecycleEffect,
	FightTLEventChangeSceneByEffect,
	FightTLYXASFDEffect,
	FightTLAddEffectByEffectType,
	FightTLPlayActionByEffectType,
	FightTLExecuteEffectType,
	FightTLSetEffectTexture,
	FightTLUnnamedEffect,
	FightTLDeviceCardTriggerPowerEffect,
	[1001] = FightTLEventObjFly,
	[1002] = FightTLEventSetSign,
	[2001] = FightScreenTextByTimeline
}

function FightSkillComp:onConstructor(entity)
	self.entity = entity
	self.timeScale = 1
	self.workComp = self:addComponent(FightWorkComponent)
	self.sameSkillParam = {}
	self.sameSkillStartParam = {}
end

function FightSkillComp:playTimeline(timelineName, fightStepData)
	local work = self:registTimelineWork(timelineName, fightStepData)

	if not work then
		return
	end

	work:start()
end

function FightSkillComp:registTimelineWork(timelineName, fightStepData)
	return self.workComp:registWork(FightWorkTimelineItem, self.entity, timelineName, fightStepData)
end

function FightSkillComp:registPlaySkillWork(skillId, fightStepData)
	FightHelper.logForPCSkillEditor("++++++++++++++++ entityId_ " .. self.entity.id .. " play skill_" .. skillId)

	if fightStepData == nil then
		logError("找不到fightStepData, 请检查代码")

		return
	end

	local skillCO = lua_skill.configDict[skillId]

	if not skillCO then
		logError("技能表找不到id:" .. skillId)

		return
	end

	local entityMO = self.entity:getMO()
	local timeline = FightHelper.detectReplaceTimeline(FightConfig.instance:getSkinSkillTimeline((fightStepData and entityMO and fightStepData.fromId == entityMO.id or nil) and FightHelper.processSkinByStepData(fightStepData, entityMO), skillId), fightStepData)

	return (self:registTimelineWork(timeline, fightStepData))
end

function FightSkillComp:playSkill(skillId, fightStepData)
	local work = self:registPlaySkillWork(skillId, fightStepData)

	if not work then
		return
	end

	work:start()
end

function FightSkillComp:skipSkill()
	local workList = self.workComp.workList

	for i, work in ipairs(workList) do
		if work:isAlive() then
			work:skipSkill()
		end
	end
end

function FightSkillComp:stopSkill()
	local workList = self.workComp.workList

	if not workList then
		return
	end

	for i, work in ipairs(workList) do
		work:disposeSelf()
	end
end

function FightSkillComp:isLastWork(work)
	return work == self:getLastWork()
end

function FightSkillComp:getLastWork()
	local workList = self.workComp.workList

	for i = #workList, 1, -1 do
		local work = workList[i]

		if work:isAlive() then
			return work
		end
	end
end

function FightSkillComp:getBinder()
	local work = self:getLastWork()

	if not work then
		return
	end

	return (work:getBinder())
end

function FightSkillComp:getCurTimelineDuration()
	local binder = self:getBinder()

	return binder and binder:GetDuration() or 0
end

function FightSkillComp:getCurFrameFloat()
	local binder = self:getBinder()

	if not binder then
		return
	end

	return binder.CurFrameFloat
end

function FightSkillComp:getFrameFloatByTime(time)
	local binder = self:getBinder()

	if not binder then
		return
	end

	return binder:GetFrameFloatByTime(time)
end

function FightSkillComp:setTimeScale(timeScale)
	self.timeScale = timeScale

	local workList = self.workComp.workList

	for i, work in ipairs(workList) do
		if work:isAlive() then
			work:setTimeScale(timeScale)
		end
	end
end

function FightSkillComp:recordSameSkillStartParam(fightStepData, param)
	self.sameSkillStartParam[fightStepData.stepUid] = param
end

function FightSkillComp:recordFilterAtkEffect(str, fightStepData)
	local tab = self.sameSkillParam[fightStepData.stepUid]

	if not tab then
		tab = {}
		self.sameSkillParam[fightStepData.stepUid] = tab
	end

	tab.filter_atk_effects = {}

	local arr = string.split(str, "#")

	for i, v in ipairs(arr) do
		tab.filter_atk_effects[v] = true
	end
end

function FightSkillComp:atkEffectNeedFilter(name, fightStepData)
	local tab = self.sameSkillParam[fightStepData.stepUid]

	if not tab then
		return
	end

	if tab.filter_atk_effects and tab.filter_atk_effects[name] then
		return true
	end

	return false
end

function FightSkillComp:recordFilterFlyEffect(str, fightStepData)
	local tab = self.sameSkillParam[fightStepData.stepUid]

	if not tab then
		tab = {}
		self.sameSkillParam[fightStepData.stepUid] = tab
	end

	tab.filter_fly_effects = {}

	local arr = string.split(str, "#")

	for i, v in ipairs(arr) do
		tab.filter_fly_effects[v] = true
	end
end

function FightSkillComp:flyEffectNeedFilter(name, fightStepData)
	local tab = self.sameSkillParam[fightStepData.stepUid]

	if not tab then
		return
	end

	if tab.filter_fly_effects and tab.filter_fly_effects[name] then
		return true
	end

	return false
end

function FightSkillComp:clearSameSkillParam(lastFightStepData)
	local tab = self.sameSkillParam[lastFightStepData.stepUid]

	if not tab then
		return
	end

	local preStepData = tab.preStepData

	while preStepData do
		local stepData = preStepData

		preStepData = self.sameSkillParam[stepData.stepUid] and self.sameSkillParam[stepData.stepUid].preStepData
		self.sameSkillStartParam[stepData.stepUid] = nil
		self.sameSkillParam[stepData.stepUid] = nil

		local workList = self.workComp.workList

		for i, work in ipairs(workList) do
			if work:isAlive() and work.fightStepData == stepData then
				work:onDone(true)
			end
		end
	end

	self.sameSkillParam[lastFightStepData.stepUid] = nil
end

function FightSkillComp:stopCurTimelineWaitPlaySameSkill(jump_type, act_ani_state, audio_id, fightStepData, nextStepData)
	local work = self:getLastWork()

	if not work then
		return
	end

	local tab = self.sameSkillParam[nextStepData.stepUid]

	if not tab then
		tab = {}
		self.sameSkillParam[nextStepData.stepUid] = tab
	end

	tab.curAnimState = act_ani_state
	tab.audio_id = audio_id
	tab.preStepData = fightStepData
	tab.startParam = self.sameSkillStartParam[fightStepData.stepUid]

	work.timelineItem:stopCurTimelineWaitPlaySameSkill(jump_type, act_ani_state)
end

function FightSkillComp:sameSkillPlaying()
	return tabletool.len(self.sameSkillParam) > 0
end

return FightSkillComp
