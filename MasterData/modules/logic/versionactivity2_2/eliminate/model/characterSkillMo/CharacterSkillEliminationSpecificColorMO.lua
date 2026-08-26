-- chunkname: @modules/logic/versionactivity2_2/eliminate/model/characterSkillMo/CharacterSkillEliminationSpecificColorMO.lua

module("modules.logic.versionactivity2_2.eliminate.model.characterSkillMo.CharacterSkillEliminationSpecificColorMO", package.seeall)

local CharacterSkillEliminationSpecificColorMO = class("CharacterSkillEliminationSpecificColorMO", CharacterSkillMOBase)

function CharacterSkillEliminationSpecificColorMO:init(skillId)
	CharacterSkillEliminationSpecificColorMO.super.init(self, skillId)

	self._x = -1
	self._y = -1
end

function CharacterSkillEliminationSpecificColorMO:getReleaseParam()
	self._releaseParam = string.format("%d_%d", self._x - 1, self._y - 1)

	return self._releaseParam
end

function CharacterSkillEliminationSpecificColorMO:canRelease()
	return self._x ~= -1 and self._y ~= -1
end

function CharacterSkillEliminationSpecificColorMO:setSkillParam(...)
	local args = {
		...
	}

	self._x = args[1]
	self._y = args[2]
end

return CharacterSkillEliminationSpecificColorMO
