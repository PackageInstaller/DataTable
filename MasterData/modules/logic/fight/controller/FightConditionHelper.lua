-- chunkname: @modules/logic/fight/controller/FightConditionHelper.lua

module("modules.logic.fight.controller.FightConditionHelper", package.seeall)

local FightConditionHelper = _M

function FightConditionHelper.initConditionHandle()
	FightConditionHelper.ConditionHandle = FightConditionHelper.ConditionHandle or {
		[FightEnum.ConditionType.HasBuffId] = FightConditionHelper.checkHasBuffId
	}
end

function FightConditionHelper.checkCondition(condition, conditionTarget, useSkillEntityId, targetEntityId)
	FightConditionHelper.initConditionHandle()

	local conditionArr = FightStrUtil.splitToNumber(condition, "#")
	local conditionCo = lua_skill_behavior_condition.configDict[tonumber(conditionArr[1])]

	if not conditionCo then
		return true
	end

	local handle = FightConditionHelper.ConditionHandle[conditionCo.type]

	if handle then
		return handle(conditionArr, conditionTarget, useSkillEntityId, targetEntityId)
	end

	return true
end

function FightConditionHelper.checkHasBuffId(conditionArr, conditionTarget, useSkillEntityId, targetEntityId)
	targetEntityId = FightConditionTargetHelper.getTarget(conditionTarget, useSkillEntityId, targetEntityId)

	if not targetEntityId then
		return false
	end

	local entityMo = FightDataHelper.entityMgr:getById(targetEntityId)

	if not entityMo then
		return false
	end

	for i = 2, #conditionArr do
		if entityMo:hasBuffId(tonumber(conditionArr[i])) then
			return true
		end
	end

	return false
end

return FightConditionHelper
