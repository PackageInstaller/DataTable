-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/model/entity/EnemyActionData.lua

module("modules.logic.versionactivity2_7.lengzhou6.model.entity.EnemyActionData", package.seeall)

local EnemyActionData = class("EnemyActionData")

function EnemyActionData:ctor()
	self._round = 0
	self._curBehaviorId = 1
	self._loopIndex = 1
	self._behaviorData = {}
end

function EnemyActionData:init(enemyId)
	self._config = LengZhou6Config.instance:getEliminateBattleEnemyBehavior(enemyId)
	self._curBehaviorId = 1

	if self._behaviorData == nil then
		self._behaviorData = {}
	end

	for i = 1, #self._config do
		local behavior = self._config[i]
		local actionData = EnemyBehaviorData.New()

		actionData:init(behavior)
		table.insert(self._behaviorData, actionData)
	end
end

function EnemyActionData:initLoopIndex(startIndex, endIndex)
	self._startIndex = startIndex
	self._endIndex = endIndex
end

function EnemyActionData:_haveNeedActionSkill()
	self._round = self._round + 1

	local residueCd = self:calCurResidueCd()

	if residueCd and residueCd == 0 then
		return true
	end

	return false
end

function EnemyActionData:calCurResidueCd()
	local curBehaviorCd = self:getCurBehaviorCd()

	return math.max(curBehaviorCd - self._round, 0)
end

function EnemyActionData:getCurBehaviorCd()
	local curBehavior = self._behaviorData[self._curBehaviorId]

	if curBehavior then
		return curBehavior:cd()
	end

	return 0
end

function EnemyActionData:updateCurBehaviorId()
	if self._curBehaviorId == ((self._endIndex ~= nil and self._loopIndex > 1 or nil) and self._endIndex) then
		self._loopIndex = self._loopIndex + 1
		self._curBehaviorId = self._startIndex == nil and 1 or self._startIndex
	else
		self._curBehaviorId = self._curBehaviorId + 1
	end
end

function EnemyActionData:setCurBehaviorId(index)
	self._curBehaviorId = index
end

function EnemyActionData:getCurBehaviorId()
	return self._curBehaviorId
end

function EnemyActionData:getCurRound()
	return self._round
end

function EnemyActionData:setCurRound(round)
	self._round = round
end

function EnemyActionData:getCurBehavior()
	local curBehavior = self._behaviorData[self._curBehaviorId]

	return curBehavior or nil
end

function EnemyActionData:getSkillList()
	local canUse = self:_haveNeedActionSkill()

	if canUse then
		local curBehavior = self:getCurBehavior()

		if curBehavior == nil then
			logError("curBehavior is nil: index " .. self._curBehaviorId)

			return nil
		end

		local skillList = curBehavior:getSkillList(true)

		self._round = self._round - curBehavior:cd()

		self:updateCurBehaviorId()

		return skillList
	end

	return nil
end

return EnemyActionData
