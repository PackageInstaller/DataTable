-- chunkname: @modules/logic/matchgame/fight/view/skill/skilleffect/MatchGameSkillEffectHandler.lua

module("modules.logic.matchgame.fight.view.skill.skilleffect.MatchGameSkillEffectHandler", package.seeall)

local MatchGameSkillEffectHandler = class("MatchGameSkillEffectHandler")

function MatchGameSkillEffectHandler:handleSkillEffect(effectCoData, targetInfoList, skillData, viewContent)
	local effectId = effectCoData[1]
	local skillEffectConfig = MatchGameFightConfig.instance:getSkillEffectConfig(effectId)
	local effectType = skillEffectConfig.type
	local cls = _G[string.format("MatchGameSkillEffect_%s", effectType)]

	if cls then
		local skillEffectHandler = cls.New()

		skillEffectHandler:init(viewContent)

		local func = skillEffectHandler["progressEffect_" .. effectId]

		if func then
			return func(skillEffectHandler, effectCoData, targetInfoList, skillData)
		end
	end
end

function MatchGameSkillEffectHandler:getTargetObjList(targetInfo)
	local targetObjList = {}
	local targetId = targetInfo and targetInfo.targetId
	local targetData = targetInfo and targetInfo.targetData

	if not targetId or not targetData then
		return targetObjList
	end

	if targetId == MatchGameFightEnum.SkillTargetType.CharacterSingle or targetId == MatchGameFightEnum.SkillTargetType.CharacterAll or targetId == MatchGameFightEnum.SkillTargetType.MonsterSingle then
		for _, fightMo in ipairs(targetData) do
			table.insert(targetObjList, fightMo)
		end
	elseif targetId == MatchGameFightEnum.SkillTargetType.DropRate or targetId == MatchGameFightEnum.SkillTargetType.RoundTime or targetId == MatchGameFightEnum.SkillTargetType.FeverCost then
		table.insert(targetObjList, targetData)
	else
		for posXIndex, elementMap in pairs(targetData) do
			if type(elementMap) == "table" then
				for posYIndex, elementItem in pairs(elementMap) do
					if elementItem and elementItem.comp then
						table.insert(targetObjList, elementItem.comp)
					end
				end
			end
		end
	end

	return targetObjList
end

MatchGameSkillEffectHandler.instance = MatchGameSkillEffectHandler.New()

return MatchGameSkillEffectHandler
