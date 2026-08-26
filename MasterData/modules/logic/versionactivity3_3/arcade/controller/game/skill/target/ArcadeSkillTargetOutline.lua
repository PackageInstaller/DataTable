-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/target/ArcadeSkillTargetOutline.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.target.ArcadeSkillTargetOutline", package.seeall)

local ArcadeSkillTargetOutline = class("ArcadeSkillTargetOutline", ArcadeSkillTargetRect)

function ArcadeSkillTargetOutline:onFindTarget()
	local gridX = self.gridX
	local gridY = self.gridY
	local sizeX, sizeY = 1, 1

	if self._context and self._context.target then
		sizeX, sizeY = self._context.target:getSize()
	end

	local outLine = self:getSizeX()
	local offX1, offX2 = outLine, outLine + sizeX - 1
	local offY1, offY2 = outLine, outLine + sizeY - 1

	self:findUnitMOByRectXY(gridX - offX1, gridX + offX2, gridY - offY1, gridY + offY2)

	local unitMOList = self:getTargetList()
	local maxX = gridX - 1 + sizeX
	local maxY = gridY - 1 + sizeY

	for i = #unitMOList, 1, -1 do
		local unitMO = unitMOList[i]

		if unitMO then
			local bMinX, bMaxX, bMinY, bMaxY = self:getUnitMORectXY(unitMO)

			if ArcadeGameHelper.isRectXYInside(gridX, maxX, gridY, maxY, bMinX, bMaxX, bMinY, bMaxY) then
				table.remove(unitMOList, i)
			end
		end
	end
end

return ArcadeSkillTargetOutline
