-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/cond/ArcadeSkillCondPerAttack.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.cond.ArcadeSkillCondPerAttack", package.seeall)

local ArcadeSkillCondPerAttack = class("ArcadeSkillCondPerAttack", ArcadeSkillCondBase)

function ArcadeSkillCondPerAttack:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._perAttackFactor = tonumber(params[2])
end

function ArcadeSkillCondPerAttack:getCondNeedCounter()
	return ArcadeGameEnum.GameCounter.AttackTimesSinceAddSkill
end

function ArcadeSkillCondPerAttack:onIsCondSuccess()
	if not self._perAttackFactor then
		return
	end

	local skillSetMO = self:getBelongSkillSetMO()

	if not skillSetMO then
		return
	end

	local skillId = self:getSkillId()
	local attackTimes = skillSetMO:getSkillCounterRecord(skillId, ArcadeGameEnum.GameCounter.AttackTimesSinceAddSkill)
	local remainAttackTimes = attackTimes % self._perAttackFactor

	return attackTimes > 0 and remainAttackTimes == 0
end

return ArcadeSkillCondPerAttack
