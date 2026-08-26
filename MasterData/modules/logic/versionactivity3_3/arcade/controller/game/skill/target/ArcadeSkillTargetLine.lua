-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/target/ArcadeSkillTargetLine.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.target.ArcadeSkillTargetLine", package.seeall)

local ArcadeSkillTargetLine = class("ArcadeSkillTargetLine", ArcadeSkillTargetRect)

function ArcadeSkillTargetLine:onFindTarget()
	local gridX = self.gridX
	local gridY = self.gridY
	local len = self:getSizeX()
	local dir = self.direction
	local sizeX, sizeY = 1, 1

	if self._context and self._context.target then
		sizeX, sizeY = self._context.target:getSize()
	end

	local minX, maxX, minY, maxY = self:_getLineXY(gridX, gridY, sizeX - 1, sizeY - 1, len - 1, dir)

	self:findUnitMOByRectXY(minX, maxX, minY, maxY)
end

function ArcadeSkillTargetLine:_getLineXY(gridX, gridY, ofsX, ofsY, oflen, dir)
	if dir == ArcadeEnum.Direction.Up then
		return gridX, gridX + ofsX, gridY + ofsY + 1, gridY + ofsY + oflen + 1
	elseif dir == ArcadeEnum.Direction.Down then
		return gridX, gridX + ofsX, gridY - oflen - 1, gridY - 1
	elseif dir == ArcadeEnum.Direction.Left then
		return gridX - oflen - 1, gridX - 1, gridY, gridY + ofsY
	elseif dir == ArcadeEnum.Direction.Right then
		return gridX + ofsX + 1, gridX + ofsX + oflen + 1, gridY, gridY + ofsY
	end

	return gridX, gridX, gridY, gridY
end

return ArcadeSkillTargetLine
