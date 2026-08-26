-- chunkname: @modules/logic/versionactivity2_2/eliminate/model/characterSkillMo/CharacterSkillAddDiamondMO.lua

module("modules.logic.versionactivity2_2.eliminate.model.characterSkillMo.CharacterSkillAddDiamondMO", package.seeall)

local CharacterSkillAddDiamondMO = class("CharacterSkillAddDiamondMO", CharacterSkillMOBase)

function CharacterSkillAddDiamondMO:getEffectRound()
	return EliminateEnum.RoundType.TeamChess
end

return CharacterSkillAddDiamondMO
