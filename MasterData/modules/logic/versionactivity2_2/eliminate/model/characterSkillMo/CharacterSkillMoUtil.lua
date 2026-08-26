-- chunkname: @modules/logic/versionactivity2_2/eliminate/model/characterSkillMo/CharacterSkillMoUtil.lua

module("modules.logic.versionactivity2_2.eliminate.model.characterSkillMo.CharacterSkillMoUtil", package.seeall)

local CharacterSkillMoUtil = class("CharacterSkillMoUtil")

function CharacterSkillMoUtil.createMO(effectName)
	local mo

	if effectName == "AddDiamond" then
		mo = CharacterSkillAddDiamondMO.New()
	end

	if effectName == "EliminationCross" then
		mo = CharacterSkillEliminationCrossMO.New()
	end

	if effectName == "EliminationRange" then
		mo = CharacterSkillEliminationRangeMO.New()
	end

	if effectName == "EliminationSpecificColor" then
		mo = CharacterSkillEliminationSpecificColorMO.New()
	end

	if effectName == "EliminationSwap" then
		mo = CharacterSkillEliminationSwapMO.New()
	end

	if mo == nil then
		logError("CharacterSkillMoUtil:createMO" .. effectName .. " is not exist!")

		mo = CharacterSkillMOBase.New()
	end

	return mo
end

return CharacterSkillMoUtil
