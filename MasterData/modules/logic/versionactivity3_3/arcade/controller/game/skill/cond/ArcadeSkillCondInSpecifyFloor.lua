-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/cond/ArcadeSkillCondInSpecifyFloor.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.cond.ArcadeSkillCondInSpecifyFloor", package.seeall)

local ArcadeSkillCondInSpecifyFloor = class("ArcadeSkillCondInSpecifyFloor", ArcadeSkillCondBase)

function ArcadeSkillCondInSpecifyFloor:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._floorId = tonumber(params[2])
end

function ArcadeSkillCondInSpecifyFloor:_checkOnSpecifyFloor(targetSizeX, targetSizeY, checkGridX, checkGridY)
	for i = checkGridX, checkGridX + targetSizeX - 1 do
		for j = checkGridY, checkGridY + targetSizeY - 1 do
			local floorMO = ArcadeGameFloorController.instance:getFloorMOInGrid(i, j)
			local floorId = floorMO and floorMO:getId()

			if floorId == self._floorId then
				return true, i, j
			end
		end
	end
end

function ArcadeSkillCondInSpecifyFloor:onIsCondSuccess()
	if not self._context.specTargetEntityMO then
		local target = self._context.target

		if not target then
			return
		end

		local sizeX, sizeY = target:getSize()
		local gridX, gridY = target:getGridPos()

		if not self._context.specTargetGridX then
			local checkGridX = gridX

			if not self._context.specTargetGridY then
				local checkGridY = gridY
				local isOnFloor, hitGridX, hitGridY = self:_checkOnSpecifyFloor(sizeX, sizeY, checkGridX, checkGridY)

				if isOnFloor then
					logNormal(string.format("%s:isCondSuccess() == > 处于指定地块：true floorId=%s target={entityType:%s,uid:%s,pos:(%s,%s),size:(%s,%s)} hitGrid=(%s,%s)", self.__cname, self._floorId, target:getEntityType(), target:getUid(), checkGridX, checkGridY, sizeX, sizeY, hitGridX, hitGridY))
				else
					logNormal(string.format("%s:isCondSuccess() == > 处于指定地块：false floorId=%s target={entityType:%s,uid:%s,pos:(%s,%s),size:(%s,%s)}", self.__cname, self._floorId, target:getEntityType(), target:getUid(), checkGridX, checkGridY, sizeX, sizeY))
				end

				return isOnFloor
			end
		end
	end
end

return ArcadeSkillCondInSpecifyFloor
