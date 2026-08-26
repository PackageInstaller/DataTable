-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/target/ArcadeSkillTargetAttacker.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.target.ArcadeSkillTargetAttacker", package.seeall)

local ArcadeSkillTargetAttacker = class("ArcadeSkillTargetAttacker", ArcadeSkillTargetBase)

function ArcadeSkillTargetAttacker:onFindTarget()
	if self._context and self._context.atker then
		local target = self._context.target
		local atker = self._context.atker

		if target ~= atker then
			self:addTarget(atker)
		end
	end
end

return ArcadeSkillTargetAttacker
