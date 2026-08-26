-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/target/ArcadeSkillTargetCross.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.target.ArcadeSkillTargetCross", package.seeall)

local ArcadeSkillTargetCross = class("ArcadeSkillTargetCross", ArcadeSkillTargetRect)

function ArcadeSkillTargetCross:onFindTarget()
	local gridX = self.gridX
	local gridY = self.gridY
	local offX1, offX2 = ArcadeGameHelper.getRectOffsetVal(self:getSizeX() - 1)
	local offY1, offY2 = ArcadeGameHelper.getRectOffsetVal(self:getSizeY() - 1)

	self:findUnitMOByRectXY(gridX - offX1, gridX + offX2, gridY, gridY)
	self:findUnitMOByRectXY(gridX, gridX, gridY - offY1, gridY + offY2)
end

function ArcadeSkillTargetCross:getSizeX()
	return self._sizeX + self._radius * 2
end

function ArcadeSkillTargetCross:getSizeY()
	return self._sizeY + self._radius * 2
end

return ArcadeSkillTargetCross
