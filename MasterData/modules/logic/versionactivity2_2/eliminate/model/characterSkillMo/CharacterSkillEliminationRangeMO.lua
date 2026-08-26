-- chunkname: @modules/logic/versionactivity2_2/eliminate/model/characterSkillMo/CharacterSkillEliminationRangeMO.lua

module("modules.logic.versionactivity2_2.eliminate.model.characterSkillMo.CharacterSkillEliminationRangeMO", package.seeall)

local CharacterSkillEliminationRangeMO = class("CharacterSkillEliminationRangeMO", CharacterSkillMOBase)

function CharacterSkillEliminationRangeMO:init(skillId)
	CharacterSkillEliminationRangeMO.super.init(self, skillId)

	self._x = -1
	self._y = -1
end

function CharacterSkillEliminationRangeMO:getReleaseParam()
	self._releaseParam = string.format("%d_%d", self._x - 1, self._y - 1)

	return self._releaseParam
end

function CharacterSkillEliminationRangeMO:canRelease()
	return self._x ~= -1 and self._y ~= -1
end

function CharacterSkillEliminationRangeMO:playAction(cb, cbTarget)
	EliminateChessModel.instance:setRecordCurNeedShowEffectAndXY(self._x, self._y, EliminateEnum.EffectType.blockEliminate)
	CharacterSkillEliminationRangeMO.super.playAction(self, cb, cbTarget)
end

function CharacterSkillEliminationRangeMO:setSkillParam(...)
	local args = {
		...
	}

	self._x = args[1]
	self._y = args[2]
end

return CharacterSkillEliminationRangeMO
