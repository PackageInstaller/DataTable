-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/target/AracdeSkillTargetFloorGrid.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.target.AracdeSkillTargetFloorGrid", package.seeall)

local AracdeSkillTargetFloorGrid = class("AracdeSkillTargetFloorGrid", ArcadeSkillTargetBase)

function AracdeSkillTargetFloorGrid:onFindTarget()
	if self._context and self._context.target then
		local gridX, gridY = self._context.target:getGridPos()
		local sizeX, sizeY = self._context.target:getSize()

		if not sizeX or sizeX < 1 then
			sizeX = 1
		end

		if not sizeY or sizeY < 1 then
			sizeY = 1
		end

		local xNum = math.min(gridX + sizeX - 1, ArcadeGameEnum.Const.RoomSize)
		local yNum = math.min(gridY + sizeY - 1, ArcadeGameEnum.Const.RoomSize)

		for x = gridX, xNum do
			for y = gridY, yNum do
				local gridMO = ArcadeGameModel.instance:getGridMOByXY(x, y)

				self:addTarget(gridMO)
			end
		end
	end
end

return AracdeSkillTargetFloorGrid
