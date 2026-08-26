-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitFlop.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitFlop", package.seeall)

local ArcadeSkillHitFlop = class("ArcadeSkillHitFlop", ArcadeSkillHitNormalMove)

function ArcadeSkillHitFlop:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._gridFlopFlagDict = {}
end

function ArcadeSkillHitFlop:onHit()
	self._isMoveFlag = false

	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	if self._context and self._context.target and characterMO and characterMO:getPlayerActType() == ArcadeGameEnum.PlayerActType.Move then
		local target = self._context.target
		local gridX, gridY = characterMO:getGridPos()
		local fx, fy = target:getGridPos()
		local fsx, fsy = target:getSize()

		if not ArcadeGameHelper.isRectXYIntersect(fx, fx + fsx - 1, fy, fy + fsy - 1, gridX, gridX, gridY, gridY) then
			return
		end

		local floorMOList = ArcadeGameModel.instance:getEntityMOList(ArcadeGameEnum.EntityType.Floor)

		if not floorMOList or #floorMOList < 1 then
			return
		end

		self._isMoveFlag = true

		for key, v in pairs(self._gridFlopFlagDict) do
			self._gridFlopFlagDict[key] = false
		end

		for _, floorMO in ipairs(floorMOList) do
			if floorMO.id == ArcadeGameEnum.FloorIceID then
				local gx, gy = floorMO:getGridPos()

				self._gridFlopFlagDict[ArcadeGameHelper.getGridId(gx, gy)] = true
			end
		end

		local dir = characterMO:getDirection()
		local dis = self:_getDistance(gridX, gridY, dir)
		local scene = ArcadeGameController.instance:getGameScene()
		local curRoom = ArcadeGameController.instance:getCurRoom()

		if dis and dis > 0 and scene and curRoom then
			local tx, ty = ArcadeSkillHitNormalMove.tryMoveGridXY(characterMO, dir, dis)

			if tx and ty then
				self:addHiter(characterMO)

				local entity = scene.entityMgr:getEntityWithType(characterMO:getEntityType(), characterMO:getUid())

				curRoom:tryMoveEntity(entity, tx, ty)
			end
		end
	end
end

function ArcadeSkillHitFlop:_getDistance(gridX, gridY, dir)
	if not self._gridFlopFlagDict[ArcadeGameHelper.getGridId(gridX, gridY)] then
		return 0
	end

	local dis = 0
	local gx, gy = gridX, gridY

	for i = 1, ArcadeGameEnum.Const.RoomSize do
		local nx, ny = ArcadeGameHelper.getNextXYByDir(gx, gy, dir)
		local isFlag = self._gridFlopFlagDict[ArcadeGameHelper.getGridId(nx, ny)]

		if (nx ~= gx or ny ~= gy) and isFlag then
			gy = ny
			gx = nx
			dis = dis + 1
		else
			break
		end
	end

	return dis
end

function ArcadeSkillHitFlop:onHitPrintLog()
	if self._isMoveFlag then
		local gx, gy = self._context.target:getGridPos()

		logNormal(string.format("%s ==> (%s,%s) to (%s,%s)", self:getLogPrefixStr(), self._gridX, self._gridY, gx, gy))
	end
end

return ArcadeSkillHitFlop
