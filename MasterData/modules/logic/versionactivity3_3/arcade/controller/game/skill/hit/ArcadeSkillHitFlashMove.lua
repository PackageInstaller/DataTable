-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitFlashMove.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitFlashMove", package.seeall)

local ArcadeSkillHitFlashMove = class("ArcadeSkillHitFlashMove", ArcadeSkillHitBase)

function ArcadeSkillHitFlashMove:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._radius = tonumber(params[2])
end

function ArcadeSkillHitFlashMove:onHit()
	if not self._radius or self._radius <= 0 then
		return
	end

	local scene = ArcadeGameController.instance:getGameScene()
	local curRoom = ArcadeGameController.instance:getCurRoom()

	if scene and self._context and self._context.target then
		local target = self._context.target

		self:addHiter(target)

		local x, y = self:_tryGetGridXY(target, self._radius)

		if x and y then
			local entity = scene.entityMgr:getEntityWithType(target:getEntityType(), target:getUid())

			if entity.bezierComp then
				local bex, bey = target:getGridPos()

				curRoom:tryMoveEntity(entity, x, y)
				entity.bezierComp:beginGridXY(bex, bey)
			else
				curRoom:tryMoveEntity(entity, x, y)
			end
		end
	end
end

function ArcadeSkillHitFlashMove:_tryGetGridXY(target, radius)
	if target and radius and radius > 0 then
		local gridX, gridY = target:getGridPos()
		local sizeX, sizeY = target:getSize()
		local tArcadeGameSummonController = ArcadeGameSummonController.instance
		local unitMOList = tArcadeGameSummonController:getRoomUnitMOList()

		tabletool.removeValue(unitMOList, target)

		local gridList = tArcadeGameSummonController:getGridList()

		RoomHelper.randomArray(gridList)

		for _, grid in ipairs(gridList) do
			local x = grid.x
			local y = grid.y

			if (grid.x ~= gridX or grid.y ~= gridY) and radius >= math.abs(x - gridX) and radius >= math.abs(y - gridY) and tArcadeGameSummonController:checkSizeGridXY(x, y, sizeX, sizeY, unitMOList) then
				return x, y
			end
		end
	end

	return nil, nil
end

function ArcadeSkillHitFlashMove:onHitPrintLog()
	logNormal(string.format("%s ==> 半径距离：%s", self:getLogPrefixStr(), self._radius))
end

return ArcadeSkillHitFlashMove
