-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/action/UnitActionCloseToNpc.lua

module("logicscene.scene.unit.action.UnitActionCloseToNpc", package.seeall)

local UnitActionCloseToNpc = class("UnitActionCloseToNpc", UnitActionGotoUnit)

function UnitActionCloseToNpc:ctor(npcId)
	self._npcId = npcId

	local unitNpc = self:_getNpcUnit()

	UnitActionCloseToNpc.super.ctor(self, unitNpc)
end

function UnitActionCloseToNpc:start(unit)
	self._scene = SceneMgr.instance:getCurScene()
	self._toUnit = self._toUnit or self:_getNpcUnit()

	UnitActionCloseToNpc.super.start(self, unit)
end

function UnitActionCloseToNpc:update(deltaTime)
	UnitActionCloseToNpc.super.update(self, deltaTime)

	if self:isDone() and (not self._toUnit or not self._toUnit.isDestroyed) and self:_isValidPath() then
		self._unit:faceToUnit(self._toUnit)
	end
end

function UnitActionCloseToNpc:_isValidPath()
	local isEscort = SceneFacade.instance:isEscortNpc(self._npcId)

	if not isEscort then
		return true
	end

	if not self._toUnit then
		return true
	end

	local x, y = self._toUnit.transform:getPos()

	if not x or not y then
		return true
	end

	local dist = self._unit.transform:dist2D(x, y)

	return dist < 5
end

function UnitActionCloseToNpc:_getNpcUnit()
	local scene = SceneMgr.instance:getCurScene()

	return (scene.unitFactory:getUnit(UnitTag.Npc, self._npcId))
end

function UnitActionCloseToNpc:_findRandomNotBerrierAround(destX, destY)
	local hasPos, destPosX, destPosY = self._scene:findRandomNotBerrierAroundWithDistance(self._unit.sceneUnit, destX, destY, self._distLimit - 0.01, false)

	if hasPos then
		return hasPos, destPosX, destPosY
	end

	return UnitActionCloseToNpc.super._findRandomNotBerrierAround(self, destX, destY)
end

return UnitActionCloseToNpc
