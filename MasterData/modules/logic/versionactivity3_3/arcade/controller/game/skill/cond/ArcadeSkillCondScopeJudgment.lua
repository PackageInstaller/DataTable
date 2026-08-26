-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/cond/ArcadeSkillCondScopeJudgment.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.cond.ArcadeSkillCondScopeJudgment", package.seeall)

local ArcadeSkillCondScopeJudgment = class("ArcadeSkillCondScopeJudgment", ArcadeSkillCondBase)

function ArcadeSkillCondScopeJudgment:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._skillTargetId = tonumber(params[2])
	self._skillTagetBase = ArcadeSkillFactory.instance:createSkillTargetById(self._skillTargetId)
end

function ArcadeSkillCondScopeJudgment:onIsCondSuccess()
	self._skillTagetBase:findByContext(self._context)

	local unitMOList = self._skillTagetBase:getTargetList()

	if unitMOList and #unitMOList > 0 then
		return true
	end

	return false
end

return ArcadeSkillCondScopeJudgment
