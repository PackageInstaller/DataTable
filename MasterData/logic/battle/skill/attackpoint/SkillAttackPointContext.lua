-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/attackpoint/SkillAttackPointContext.lua

module("logic.battle.skill.attackpoint.SkillAttackPointContext", package.seeall)

local SkillAttackPointContext = class("SkillAttackPointContext")

SkillAttackPointContext.TotalWeight = "TotalWeight"
SkillAttackPointContext.HasDeadPoint = "HasDeadPoint"
SkillAttackPointContext.DeadType = "DeadType"

function SkillAttackPointContext:ctor()
	self._attackInfo = false
	self._isSoloPerformance = false
	self._isSkipPerformance = false
	self._goTimeline = false
	self._paramTable = {}
	self._pointTimeList = {}
end

function SkillAttackPointContext:clear()
	self._attackInfo = false
	self._goTimeline = false

	BattleTableUtil.clearTable(self._paramTable)
	BattleTableUtil.clearTable(self._pointTimeList)
end

function SkillAttackPointContext:setTimelineGameObject(go)
	self._goTimeline = go
end

function SkillAttackPointContext:getTimelineGameObject()
	return self._goTimeline
end

function SkillAttackPointContext:setAttackInfo(attackInfo)
	self._attackInfo = attackInfo
end

function SkillAttackPointContext:getAttackInfo()
	return self._attackInfo
end

function SkillAttackPointContext:setSoloPerformance(isSoloPerformance)
	self._isSoloPerformance = isSoloPerformance
end

function SkillAttackPointContext:isSoloPerformance()
	return self._isSoloPerformance
end

function SkillAttackPointContext:setSkipPerformance(isSkipPerformance)
	self._isSkipPerformance = isSkipPerformance
end

function SkillAttackPointContext:isSkipPerformance()
	return self._isSkipPerformance
end

function SkillAttackPointContext:setParam(key, value)
	self._paramTable[key] = value
end

function SkillAttackPointContext:getParam(key)
	return self._paramTable[key]
end

function SkillAttackPointContext:setPointTimeStr(timeStr)
	BattleTableUtil.clearTable(self._pointTimeList)

	if not string.nilorempty(timeStr) then
		local strList = string.split(timeStr, "_")

		for i, v in ipairs(strList) do
			table.insert(self._pointTimeList, checknumber(v))
		end
	end
end

function SkillAttackPointContext:getPointTimeList()
	return self._pointTimeList
end

function SkillAttackPointContext:getDeadEntityIds()
	return self._attackInfo:getDeadEntityIds()
end

return SkillAttackPointContext
