-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/target/ArcadeSkillTargetOwner.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.target.ArcadeSkillTargetOwner", package.seeall)

local ArcadeSkillTargetOwner = class("ArcadeSkillTargetOwner", ArcadeSkillTargetBase)

function ArcadeSkillTargetOwner:onFindTarget()
	if self._context and self._context.target then
		self:addTarget(self._context.target)
	end
end

return ArcadeSkillTargetOwner
