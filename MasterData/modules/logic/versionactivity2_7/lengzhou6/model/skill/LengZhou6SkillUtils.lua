-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/model/skill/LengZhou6SkillUtils.lua

module("modules.logic.versionactivity2_7.lengzhou6.model.skill.LengZhou6SkillUtils", package.seeall)

local LengZhou6SkillUtils = class("LengZhou6SkillUtils")
local skillIdToSkill = {}
local index = 0

function LengZhou6SkillUtils.createSkill(configId)
	local skillConfig = LengZhou6Config.instance:getEliminateBattleSkill(configId)

	if skillConfig == nil then
		logError("skillConfig is nil, configId = " .. configId)

		return nil
	end

	local skill

	if skillIdToSkill[configId] == nil then
		if skillConfig.type == LengZhou6Enum.SkillType.enemyActive then
			skill = EnemyGeneralSkill.New()
		end

		if skillConfig.type == LengZhou6Enum.SkillType.active then
			skill = PlayerActiveSkill.New()
		end

		if skillConfig.type == LengZhou6Enum.SkillType.passive then
			skill = GeneralSkill.New()
		end
	else
		skill = skillIdToSkill[configId].New()
	end

	skill:init(index, configId)

	index = index + 1

	return skill
end

LengZhou6SkillUtils.instance = LengZhou6SkillUtils.New()

return LengZhou6SkillUtils
