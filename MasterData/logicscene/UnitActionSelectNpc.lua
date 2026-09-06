-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/action/UnitActionSelectNpc.lua

module("logicscene.scene.unit.action.UnitActionSelectNpc", package.seeall)

local UnitActionSelectNpc = class("UnitActionSelectNpc", UnitActionGotoUnit)

function UnitActionSelectNpc:ctor(npcId)
	self._npcId = npcId

	local unitNpc = self:_getNpcUnit()

	UnitActionSelectNpc.super.ctor(self, unitNpc)
end

function UnitActionSelectNpc:start(unit)
	self._scene = SceneMgr.instance:getCurScene()
	self._toUnit = self._toUnit or self:_getNpcUnit()

	UnitActionSelectNpc.super.start(self, unit)
end

function UnitActionSelectNpc:update(deltaTime)
	UnitActionSelectNpc.super.update(self, deltaTime)

	if self:isDone() and (not self._toUnit or not self._toUnit.isDestroyed) and self:_isValidPath() then
		self._unit:faceToUnit(self._toUnit)
		GlobalDispatcher:dispatch(GlobalNotify.SelectNPC, self._npcId)
	end
end

function UnitActionSelectNpc:_isValidPath()
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

function UnitActionSelectNpc:_getNpcUnit()
	local scene = SceneMgr.instance:getCurScene()

	return (scene.unitFactory:getUnit(UnitTag.Npc, self._npcId))
end

function UnitActionSelectNpc:_findRandomNotBerrierAround(destX, destY)
	local hasPos, destPosX, destPosY = self._scene:findRandomNotBerrierAroundWithDistance(self._unit.sceneUnit, destX, destY, self._distLimit - 0.01, false)

	if hasPos then
		return hasPos, destPosX, destPosY
	end

	return UnitActionSelectNpc.super._findRandomNotBerrierAround(self, destX, destY)
end

return UnitActionSelectNpc
