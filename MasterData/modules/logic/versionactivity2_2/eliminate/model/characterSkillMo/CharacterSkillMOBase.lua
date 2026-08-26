-- chunkname: @modules/logic/versionactivity2_2/eliminate/model/characterSkillMo/CharacterSkillMOBase.lua

module("modules.logic.versionactivity2_2.eliminate.model.characterSkillMo.CharacterSkillMOBase", package.seeall)

local CharacterSkillMOBase = class("CharacterSkillMOBase")

function CharacterSkillMOBase:init(skillId)
	self._skillId = skillId
	self._releaseParam = ""
end

function CharacterSkillMOBase:getSkillConfig()
	return lua_character_skill.configDict[self._skillId]
end

function CharacterSkillMOBase:getCost()
	local skillConfig = self:getSkillConfig()

	return skillConfig.cost
end

function CharacterSkillMOBase:getReleaseParam()
	return self._releaseParam
end

function CharacterSkillMOBase:setSkillParam(...)
	return
end

function CharacterSkillMOBase:playAction(cb, cbTarget)
	if cb then
		cb(cbTarget)
	end
end

function CharacterSkillMOBase:cancelRelease()
	return
end

function CharacterSkillMOBase:getEffectRound()
	return EliminateEnum.RoundType.Match3Chess
end

function CharacterSkillMOBase:canRelease()
	return true
end

return CharacterSkillMOBase
