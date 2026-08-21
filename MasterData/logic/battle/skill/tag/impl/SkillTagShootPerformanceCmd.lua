-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/tag/impl/SkillTagShootPerformanceCmd.lua

module("logic.battle.skill.tag.impl.SkillTagShootPerformanceCmd", package.seeall)

local M = class("SkillTagShootPerformanceCmd", SkillTagPerformanceCmd)
local kDuration = 0.35

function M:onInit()
	M.super.onInit(self)

	self._fromEntityIdList = {}
	self._toEntityIdList = {}
	self._ifPlayCast = true
end

function M:onClear()
	M.super.onClear(self)
	BattleTableUtil.clearTable(self._fromEntityIdList)
	BattleTableUtil.clearTable(self._toEntityIdList)

	self._ifPlayCast = true
end

function M:addFromAndToEntityId(fromEntityId, toEntityId)
	table.insert(self._fromEntityIdList, fromEntityId)
	table.insert(self._toEntityIdList, toEntityId)
end

function M:setParabolaUpStatus(status)
	self._parabolaUpStatus = status
end

function M:setPlayCast(status)
	self._ifPlayCast = status
end

function M:execute()
	self._timelineTask:clear()

	if self._ifPlayCast then
		self._timelineTask:addTask(0, self._playCast, self)
		self._timelineTask:addTask(0.5)
	end

	local duration = BattleTime.getScaledTime(kDuration)

	self._timelineTask:addTask(0, self._playEffect, self)
	self._timelineTask:addTask(duration, self._executeCmd, self)
	self._timelineTask:addTask(0.2)
	self._timelineTask:setTimeScale(BattleTime.timeScale)
	self._timelineTask:addFinishListener(self._onTimelineFinished, self)
	self._timelineTask:start()
end

function M:_playEffect()
	local unitMgr = BattleMgr.instance:getUnitMgr()

	for i, v in ipairs(self._fromEntityIdList) do
		local fromEntityId = self._fromEntityIdList[i]
		local toEntityId = self._toEntityIdList[i]

		if fromEntityId ~= toEntityId then
			local fromUnit = unitMgr:getUnit(self._fromEntityIdList[i])
			local toUnit = unitMgr:getUnit(self._toEntityIdList[i])
			local goTimeline = goutil.clone(self._goSourceTimeline)
			local transformTimeline = goTimeline.transform

			BattleGameObjectRootUtil.addToEffectRoot(goTimeline)

			local fx, fy, fz = self:_getUnitBodyCenterPos(fromUnit)

			Astral.TransformUtil.SetLocalScale(transformTimeline, self._effectScale, 1, self._effectScale)
			Astral.TransformUtil.SetLocalPos(transformTimeline, fx, fy, fz)
			goutil.setActive(goTimeline, true)

			local tx, ty, tz = self:_getUnitBodyCenterPos(toUnit)
			local toVec3 = BattleMathUtil.tempVec3
			local duration = BattleTime.getScaledTime(kDuration)

			toVec3:Set(tx, ty, tz)
			transformTimeline:DOLocalMove(toVec3, duration)
			table.insert(self._goTimelineList, goTimeline)
		end
	end
end

function M:_getUnitBodyCenterPos(unit)
	if not unit then
		return -99, 0, 0
	end

	return BattleUnitUtil.getUnitCenterPos(unit)
end

function M:_onTimelineFinished()
	self._cmdHandler:tryNextCommand()
end

function M:_executeCmd()
	BattleSideHintViewFacade.instance:showTagHint(self._tagId, self._continuousIndex)
	SkillTagUtils.shake(self._attackerId, self._tagId, self._range)

	local command = self._effectCommand
	local cmdExecuter = BattleMgr.instance:getCmdExecuter()

	cmdExecuter:executeCommand(command, self)
end

function M:onCommandFinish(cmd, success)
	self._effectCommand = false

	self:finish(true)
end

function M:toString()
	return string.format("[SkillTagShootPerformanceCmd attacker = %s]", self._attackerId)
end

return M
