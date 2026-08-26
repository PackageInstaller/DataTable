-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/cond/ArcadeSkillCondIfInjured.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.cond.ArcadeSkillCondIfInjured", package.seeall)

local ArcadeSkillCondIfInjured = class("ArcadeSkillCondIfInjured", ArcadeSkillCondBase)

function ArcadeSkillCondIfInjured:onCtor()
	local params = self._params

	self._changeName = params[1]
end

function ArcadeSkillCondIfInjured:onIsCondSuccess()
	local atkType = self._context.attackType
	local atker = self._context.atker
	local target = self._context.target
	local hiterList = self._context.hiterList

	if atkType and atker and target and tabletool.indexOf(hiterList, target) then
		return true
	end

	return false
end

function ArcadeSkillCondIfInjured:_checkAtkType(atkType)
	if not atkType then
		return false
	end
end

return ArcadeSkillCondIfInjured
