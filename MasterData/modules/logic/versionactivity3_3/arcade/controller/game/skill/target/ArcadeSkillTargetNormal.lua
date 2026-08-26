-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/target/ArcadeSkillTargetNormal.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.target.ArcadeSkillTargetNormal", package.seeall)

local ArcadeSkillTargetNormal = class("ArcadeSkillTargetNormal", ArcadeSkillTargetBase)

function ArcadeSkillTargetNormal:onFindTarget()
	local gridX = self.gridX
	local gridY = self.gridY

	self:findUnitMOByRectXY(gridX, gridX, gridY, gridY)
end

return ArcadeSkillTargetNormal
