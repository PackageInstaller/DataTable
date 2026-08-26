-- chunkname: @modules/logic/versionactivity2_2/eliminate/model/characterSkillMo/CharacterSkillEliminationCrossMO.lua

module("modules.logic.versionactivity2_2.eliminate.model.characterSkillMo.CharacterSkillEliminationCrossMO", package.seeall)

local CharacterSkillEliminationCrossMO = class("CharacterSkillEliminationCrossMO", CharacterSkillMOBase)

function CharacterSkillEliminationCrossMO:init(skillId)
	CharacterSkillEliminationCrossMO.super.init(self, skillId)

	self._x = -1
	self._y = -1
end

function CharacterSkillEliminationCrossMO:getReleaseParam()
	self._releaseParam = string.format("%d_%d", self._x - 1, self._y - 1)

	return self._releaseParam
end

function CharacterSkillEliminationCrossMO:canRelease()
	return self._x ~= -1 and self._y ~= -1
end

function CharacterSkillEliminationCrossMO:playAction(cb, cbTarget)
	EliminateChessModel.instance:setRecordCurNeedShowEffectAndXY(self._x, self._y, EliminateEnum.EffectType.crossEliminate)
	CharacterSkillEliminationCrossMO.super.playAction(self, cb, cbTarget)
end

function CharacterSkillEliminationCrossMO:setSkillParam(...)
	local args = {
		...
	}

	self._x = args[1]
	self._y = args[2]
end

return CharacterSkillEliminationCrossMO
