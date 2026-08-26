-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitNormalMove.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitNormalMove", package.seeall)

local ArcadeSkillHitNormalMove = class("ArcadeSkillHitNormalMove", ArcadeSkillHitBase)

function ArcadeSkillHitNormalMove:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._dirStr = params[2]
	self._distance = tonumber(params[3])
end

function ArcadeSkillHitNormalMove:onHit()
	if self._context then
		local target = self._context.target

		if not target or not self._distance or self._distance <= 0 then
			return
		end

		local scene = ArcadeGameController.instance:getGameScene()
		local curRoom = ArcadeGameController.instance:getCurRoom()

		if not scene or not curRoom then
			return
		end

		self:addHiter(target)

		local dir
		local x, y = ArcadeSkillHitNormalMove.tryMoveGridXY(target, string.nilorempty(self._dirStr) and target:getDirection() or ArcadeGameHelper.getStr2Dir(self._dirStr), self._distance)

		if x and y then
			local entity = scene.entityMgr:getEntityWithType(target:getEntityType(), target:getUid())

			curRoom:tryMoveEntity(entity, x, y)
		end
	end
end

function ArcadeSkillHitNormalMove:onHitPrintLog()
	logNormal(string.format("%s ==> 移动方向：%s,距离：%s", self:getLogPrefixStr(), self._dirStr, self._distance))
end

function ArcadeSkillHitNormalMove.tryMoveGridXY(target, dir, dis)
	if not target or not dis or dis <= 0 then
		return
	end

	local gridX, gridY = target:getGridPos()
	local sizeX, sizeY = target:getSize()
	local unitMOList = ArcadeGameSummonController.instance:getRoomUnitMOList()

	tabletool.removeValue(unitMOList, target)

	if target == ArcadeGameModel.instance:getCharacterMO() then
		local unitMO

		for i = #unitMOList, 1, -1 do
			if unitMOList[i]:getIsDead() and unitMOList[i]:getEntityType() == ArcadeGameEnum.EntityType.Monster then
				table.remove(unitMOList, i)
			end
		end
	end

	local isMove

	for _ = 1, dis do
		local nextX, nextY = ArcadeGameHelper.getNextXYByDir(gridX, gridY, dir)

		if ArcadeGameSummonController.instance:checkSizeGridXY(nextX, nextY, sizeX, sizeY, unitMOList) then
			gridY = nextY
			gridX = nextX
			isMove = true
		else
			break
		end
	end

	if isMove then
		return gridX, gridY
	end
end

return ArcadeSkillHitNormalMove
