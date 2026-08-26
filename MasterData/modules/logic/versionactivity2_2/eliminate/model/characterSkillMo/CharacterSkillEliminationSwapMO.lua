-- chunkname: @modules/logic/versionactivity2_2/eliminate/model/characterSkillMo/CharacterSkillEliminationSwapMO.lua

module("modules.logic.versionactivity2_2.eliminate.model.characterSkillMo.CharacterSkillEliminationSwapMO", package.seeall)

local CharacterSkillEliminationSwapMO = class("CharacterSkillEliminationSwapMO", CharacterSkillMOBase)

function CharacterSkillEliminationSwapMO:init(skillId)
	CharacterSkillEliminationSwapMO.super.init(self, skillId)

	self._x1 = -1
	self._x2 = -1
	self._y1 = -1
	self._y2 = -1
end

function CharacterSkillEliminationSwapMO:getReleaseParam()
	self._releaseParam = string.format("%d_%d_%d_%d", self._x1 - 1, self._y1 - 1, self._x2 - 1, self._y2 - 1)

	return self._releaseParam
end

function CharacterSkillEliminationSwapMO:canRelease()
	return self._x1 ~= -1 and self._y1 ~= -1 and self._x2 ~= -1 and self._y2 ~= -1
end

function CharacterSkillEliminationSwapMO:playAction(cb, cbTarget)
	self._cb = cb
	self._cbTarget = cbTarget

	local item1 = EliminateChessItemController.instance:getChessItem(self._x1, self._y1)
	local item2 = EliminateChessItemController.instance:getChessItem(self._x2, self._y2)
	local wordX_1, worldY_1 = item1:getGoPos()
	local wordX_2, worldY_2 = item2:getGoPos()

	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.PlayEliminateEffect, EliminateEnum.EffectType.exchange_1, self._x1, self._y1, wordX_1, worldY_1, true, nil, nil)
	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.PlayEliminateEffect, EliminateEnum.EffectType.exchange_2, self._x2, self._y2, wordX_2, worldY_2, true, self.playActionEnd, self)
end

function CharacterSkillEliminationSwapMO:playActionEnd()
	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.PlayEliminateEffect, EliminateEnum.EffectType.exchange_1, nil, nil, nil, nil, false, nil, nil)
	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.PlayEliminateEffect, EliminateEnum.EffectType.exchange_2, nil, nil, nil, nil, false, nil, nil)
	EliminateChessController.instance:exchangeCellShow(self._x1, self._y1, self._x2, self._y2, 0)

	if self._cb ~= nil then
		self._cb(self._cbTarget)
	else
		EliminateChessController.instance:exchangeCellShow(self._x2, self._y2, self._x1, self._y1, 0)
		EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.WarChessCharacterSkillCancel, false)
	end

	self._cb = nil
end

function CharacterSkillEliminationSwapMO:cancelRelease()
	self._cb = nil
end

function CharacterSkillEliminationSwapMO:setSkillParam(...)
	local args = {
		...
	}

	if self._x1 == -1 then
		self._x1 = args[1]
		self._y1 = args[2]
	else
		self._x2 = args[1]
		self._y2 = args[2]
	end
end

return CharacterSkillEliminationSwapMO
