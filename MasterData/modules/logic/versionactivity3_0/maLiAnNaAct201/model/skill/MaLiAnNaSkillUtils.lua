-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/model/skill/MaLiAnNaSkillUtils.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.skill.MaLiAnNaSkillUtils", package.seeall)

local MaLiAnNaSkillUtils = class("MaLiAnNaSkillUtils")
local index = 0

function MaLiAnNaSkillUtils.createSkill(configId)
	local skill
	local config = Activity201MaLiAnNaConfig.instance:getActiveSkillConfig(configId)

	if config == nil then
		config = Activity201MaLiAnNaConfig.instance:getPassiveSkillConfig(configId)
		skill = MaLiAnNaPassiveSkill.New()
	else
		skill = MaLiAnNaActiveSkill.New()
	end

	if skill ~= nil then
		skill:init(index, configId)

		index = index + 1
	end

	return skill
end

function MaLiAnNaSkillUtils.createSkillBySlotType(slotTypeStr)
	if string.nilorempty(slotTypeStr) then
		return nil
	end

	local allParams = string.splitToNumber(slotTypeStr, "#")

	if #allParams < 2 then
		return nil
	end

	local slotType = allParams[1]

	if slotType == Activity201MaLiAnNaEnum.SlotType.trench then
		local skill = MaLiAnNaSlotShieldPassiveSkill.New()

		allParams[1] = Activity201MaLiAnNaEnum.SkillAction.slotShield

		skill:init(index, allParams)

		index = index + 1

		return skill
	end

	if slotType == Activity201MaLiAnNaEnum.SlotType.bunker then
		local skill = MaLiAnNaSlotKillSoliderPassiveSkill.New()

		allParams[1] = Activity201MaLiAnNaEnum.SkillAction.killSolider

		skill:init(index, allParams)

		index = index + 1

		return skill
	end

	return nil
end

MaLiAnNaSkillUtils.instance = MaLiAnNaSkillUtils.New()

return MaLiAnNaSkillUtils
