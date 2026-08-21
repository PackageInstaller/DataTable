-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/SkillVSInfo.lua

module("logic.battle.skill.SkillVSInfo", package.seeall)

local SkillVSInfo = class("SkillVSInfo", AbstractGlobalReusable)

function SkillVSInfo:ctor()
	self._attacker = false
	self._victim = false
	self._skillId = false
	self._isStrengthening = false
	self._targetUnionIndex = false
	self._isReversePosition = false
	self._isForceSolo = false
	self._isHideUnrelated = false
	self._hasHideUnrelated = false
	self._preloadResPathList = {}
	self._multiRoundHoldDic = {}
end

function SkillVSInfo:reuse(...)
	return
end

function SkillVSInfo:reset()
	self._attacker = false
	self._victim = false
	self._skillId = false
	self._isStrengthening = false
	self._targetUnionIndex = false
	self._isReversePosition = false
	self._isForceSolo = false
	self._isHideUnrelated = false
	self._hasHideUnrelated = false

	BattleTableUtil.clearTable(self._preloadResPathList)
	BattleTableUtil.clearTable(self._multiRoundHoldDic)
end

function SkillVSInfo:destroy()
	self._attacker = nil
	self._victim = nil
	self._skillId = nil
	self._isStrengthening = nil
	self._targetUnionIndex = nil
	self._isReversePosition = nil
	self._isForceSolo = nil
	self._isHideUnrelated = false
	self._hasHideUnrelated = false
	self._preloadResPathList = nil
	self._multiRoundHoldDic = nil
end

function SkillVSInfo:clear()
	self._attacker = false
	self._victim = false
	self._skillId = false
	self._isStrengthening = false
	self._targetUnionIndex = false
	self._isReversePosition = false
	self._isForceSolo = false
	self._isHideUnrelated = false
	self._hasHideUnrelated = false

	BattleTableUtil.clearTable(self._preloadResPathList)
	BattleTableUtil.clearTable(self._multiRoundHoldDic)
end

function SkillVSInfo:copyFrom(skillVSInfo)
	self._attacker = skillVSInfo._attacker
	self._victim = skillVSInfo._victim
	self._skillId = skillVSInfo._skillId
	self._isStrengthening = skillVSInfo._isStrengthening
	self._targetUnionIndex = skillVSInfo._targetUnionIndex
	self._isReversePosition = skillVSInfo._isReversePosition
	self._isForceSolo = skillVSInfo._isForceSolo
	self._isHideUnrelated = skillVSInfo._isHideUnrelated
	self._hasHideUnrelated = skillVSInfo._hasHideUnrelated

	BattleTableUtil.insertto(self._preloadResPathList, skillVSInfo._preloadResPathList)

	for entityId, effectTimeline in pairs(skillVSInfo._multiRoundHoldDic) do
		self._multiRoundHoldDic[entityId] = effectTimeline
	end
end

function SkillVSInfo:setAttacker(attacker)
	self._attacker = attacker

	return self
end

function SkillVSInfo:setVictim(victim)
	self._victim = victim

	return self
end

function SkillVSInfo:setReversePosition(isReversePosition)
	self._isReversePosition = isReversePosition

	return self
end

function SkillVSInfo:setSkillId(skillId, isStrengthening)
	self._skillId = skillId
	self._isStrengthening = isStrengthening

	return self
end

function SkillVSInfo:setTargetUnionIndex(targetUnionIndex)
	self._targetUnionIndex = targetUnionIndex

	return self
end

function SkillVSInfo:getAttacker()
	return self._attacker
end

function SkillVSInfo:getVictim()
	return self._victim
end

function SkillVSInfo:getSkillId()
	return self._skillId
end

function SkillVSInfo:isStrengthening()
	return self._isStrengthening
end

function SkillVSInfo:getTargetUnionIndex()
	return self._targetUnionIndex
end

function SkillVSInfo:isReversePosition()
	return self._isReversePosition
end

function SkillVSInfo:setForceSolo(status)
	self._isForceSolo = status

	return self
end

function SkillVSInfo:isForceSolo()
	return self._isForceSolo
end

function SkillVSInfo:isHideUnrelated()
	return self._isHideUnrelated
end

function SkillVSInfo:setHideUnrelated(isHideUnrelated)
	self._isHideUnrelated = isHideUnrelated

	return self
end

function SkillVSInfo:setHasHideUnrelated()
	self._hasHideUnrelated = true
end

function SkillVSInfo:hasHideUnrelated()
	return self._hasHideUnrelated
end

function SkillVSInfo:setPreloadResPathList(preloadResPathList)
	BattleTableUtil.insertto(self._preloadResPathList, preloadResPathList)

	return self
end

function SkillVSInfo:getPreloadResPathList()
	return self._preloadResPathList
end

function SkillVSInfo:setMultiRoundHold(multiRoundHoldDic)
	for entityId, effectTimeline in pairs(multiRoundHoldDic) do
		self._multiRoundHoldDic[entityId] = effectTimeline
	end
end

function SkillVSInfo:getMultiRoundHold()
	return self._multiRoundHoldDic
end

return SkillVSInfo
