-- chunkname: @modules/logic/matchgame/fight/view/skill/MatchGameSkillConditionHandler.lua

module("modules.logic.matchgame.fight.view.skill.MatchGameSkillConditionHandler", package.seeall)

local MatchGameSkillConditionHandler = class("MatchGameSkillConditionHandler")

function MatchGameSkillConditionHandler:checkConditionSatisfy(conditionId, conditionParams, params, viewContent)
	self.fightView = viewContent.fightView
	self.sceneView = viewContent.sceneView
	self.skillView = viewContent.skillView

	local skillConditionConfig = MatchGameFightConfig.instance:getSkillConditionConfig(conditionId)
	local conditionStr = skillConditionConfig.condition
	local func = self["checkCondition_" .. conditionStr]

	if func then
		return func(self, conditionParams, params)
	end
end

function MatchGameSkillConditionHandler:checkCondition_None(conditionParams, params)
	return true
end

function MatchGameSkillConditionHandler:checkCondition_OnSkillCast(conditionParams, params)
	local heroFightMo = params.heroFightMo

	if not heroFightMo or params.conditionId ~= MatchGameFightEnum.SkillConditionType.OnSkillCast then
		return false
	end

	local skillId = heroFightMo.config.activeSkillId
	local conditionSkillId = conditionParams[2]

	if conditionSkillId == 0 or tonumber(skillId) == conditionSkillId then
		return true
	end

	return false
end

function MatchGameSkillConditionHandler:checkCondition_OnMatchCountMoreThan(conditionParams, params)
	local elementId = conditionParams[2]
	local needMatchNum = conditionParams[3]
	local curMatchNum = MatchGameFightModel.instance:getSkillExcuteMatchElementNum(elementId)

	if needMatchNum <= curMatchNum then
		return true
	end

	return false
end

function MatchGameSkillConditionHandler:checkCondition_OnFeverEnter(conditionParams, params)
	return (MatchGameFightModel.instance:getisFeverState())
end

function MatchGameSkillConditionHandler:checkCondition_OnBattleStart(conditionParams, params)
	return params.conditionId == MatchGameFightEnum.SkillConditionType.OnBattleStart
end

function MatchGameSkillConditionHandler:checkCondition_OnTurnStart(conditionParams, params)
	return params.conditionId == MatchGameFightEnum.SkillConditionType.OnTurnStart
end

function MatchGameSkillConditionHandler:checkCondition_OnTurnEnd(conditionParams, params)
	return params.conditionId == MatchGameFightEnum.SkillConditionType.OnTurnEnd
end

MatchGameSkillConditionHandler.instance = MatchGameSkillConditionHandler.New()

return MatchGameSkillConditionHandler
