-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/cond/ArcadeSkillCondPerRound.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.cond.ArcadeSkillCondPerRound", package.seeall)

local ArcadeSkillCondPerRound = class("ArcadeSkillCondPerRound", ArcadeSkillCondBase)

function ArcadeSkillCondPerRound:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._perRoundFactor = tonumber(params[2])
end

function ArcadeSkillCondPerRound:getCondNeedCounter()
	return ArcadeGameEnum.GameCounter.RoundSinceAddSkill
end

function ArcadeSkillCondPerRound:onIsCondSuccess()
	if not self._perRoundFactor then
		return
	end

	local skillSetMO = self:getBelongSkillSetMO()

	if not skillSetMO then
		return
	end

	local skillId = self:getSkillId()
	local round = skillSetMO:getSkillCounterRecord(skillId, ArcadeGameEnum.GameCounter.RoundSinceAddSkill)
	local remainRound = round % self._perRoundFactor

	return round > 0 and remainRound == 0
end

return ArcadeSkillCondPerRound
