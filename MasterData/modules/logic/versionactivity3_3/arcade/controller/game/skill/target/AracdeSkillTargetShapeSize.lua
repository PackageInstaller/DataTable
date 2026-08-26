-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/target/AracdeSkillTargetShapeSize.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.target.AracdeSkillTargetShapeSize", package.seeall)

local AracdeSkillTargetShapeSize = class("AracdeSkillTargetShapeSize", ArcadeSkillTargetBase)

function AracdeSkillTargetShapeSize:onCtor()
	return
end

function AracdeSkillTargetShapeSize:onFindTarget()
	local gridX = self.gridX
	local gridY = self.gridY
	local sizeX, sizeY

	if self._context and self._context.target then
		sizeX, sizeY = self._context.target:getSize()
	end

	sizeX = math.max(sizeX or 1, 1)
	sizeY = math.max(sizeY or 1, 1)

	self:findUnitMOByRectXY(gridX, gridX + sizeX - 1, gridY, gridY + sizeY - 1)
end

return AracdeSkillTargetShapeSize
