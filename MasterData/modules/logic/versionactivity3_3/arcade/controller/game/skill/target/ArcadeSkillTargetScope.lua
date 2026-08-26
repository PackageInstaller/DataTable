-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/target/ArcadeSkillTargetScope.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.target.ArcadeSkillTargetScope", package.seeall)

local ArcadeSkillTargetScope = class("ArcadeSkillTargetScope", ArcadeSkillTargetRect)

function ArcadeSkillTargetScope:onFindTarget()
	local gridX, gridY = ArcadeGameHelper.getFirsXYByDir(self.gridX, self.gridY, self.sizeX, self.sizeY, self.direction)
	local len = self:getSizeX()
	local dir = self.direction
	local minX, maxX, minY, maxY = self:_getLineXY(gridX, gridY, len, dir)

	self:findUnitMOByRectXY(minX, maxX, minY, maxY)
end

function ArcadeSkillTargetScope:_getLineXY(gridX, gridY, len, dir)
	local off1, off2 = ArcadeGameHelper.getRectOffsetVal(len - 1)

	if dir == ArcadeEnum.Direction.Up then
		return gridX - off1, gridX + off2, gridY, gridY
	elseif dir == ArcadeEnum.Direction.Down then
		return gridX - off1, gridX + off2, gridY, gridY
	elseif dir == ArcadeEnum.Direction.Left then
		return gridX - 1, gridX, gridY - off1, gridY + off2
	elseif dir == ArcadeEnum.Direction.Right then
		return gridX, gridX, gridY - off1, gridY + off2
	end

	return gridX, gridX, gridY, gridY
end

return ArcadeSkillTargetScope
