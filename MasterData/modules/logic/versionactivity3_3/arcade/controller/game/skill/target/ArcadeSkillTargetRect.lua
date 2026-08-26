-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/target/ArcadeSkillTargetRect.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.target.ArcadeSkillTargetRect", package.seeall)

local ArcadeSkillTargetRect = class("ArcadeSkillTargetRect", ArcadeSkillTargetBase)

function ArcadeSkillTargetRect:onCtor()
	self._radius = 0
	self._sizeX = self._sizeX or 1
	self._sizeY = self._sizeX or 1
end

function ArcadeSkillTargetRect:onConfigParams()
	if self._effectParams then
		local params = self._effectParams

		self._sizeX = math.max(1, tonumber(params[1]))
		self._sizeY = math.max(1, tonumber(params[2] or self._sizeY))
	end
end

function ArcadeSkillTargetRect:onFindTarget()
	local gridX = self.gridX
	local gridY = self.gridY
	local offX1, offX2 = ArcadeGameHelper.getRectOffsetVal(self:getSizeX() + self._radius - 1)
	local offY1, offY2 = ArcadeGameHelper.getRectOffsetVal(self:getSizeY() + self._radius - 1)

	self:findUnitMOByRectXY(gridX - offX1, gridX + offX2, gridY - offY1, gridY + offY2)
end

function ArcadeSkillTargetRect:getSizeX()
	return self._sizeX + self._radius
end

function ArcadeSkillTargetRect:getSizeY()
	return self._sizeY + self._radius
end

function ArcadeSkillTargetRect:setRadius(radius)
	self._radius = radius and tonumber(radius) or 0
end

return ArcadeSkillTargetRect
