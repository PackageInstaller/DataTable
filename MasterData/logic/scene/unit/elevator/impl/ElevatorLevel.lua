-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/elevator/impl/ElevatorLevel.lua

module("logic.scene.unit.elevator.impl.ElevatorLevel", package.seeall)

local M = class("ElevatorLevel", UnitBase)

function M:setConfig(co)
	self._co = co
end

function M:getElevatorId()
	return self._co.id
end

function M:getLevelNum()
	return self._co.ringType
end

function M:getPos()
	return Astral.TransformUtil.GetPos(self.go.transform, 0, 0, 0)
end

function M:getTag()
	return UnitTag.ElevatorNpc
end

function M:getLobbyId()
	local list = self._co.levelId

	return list[1]
end

function M:getLobbyUnit()
	return HouseSceneUtil.getElevatorUnit(self:getLobbyId())
end

function M:isTop()
	local lobbyUnit = self:getLobbyUnit()
	local topLevelUnit = lobbyUnit:getTopLevelUnit()

	return self:getLevelNum() == topLevelUnit:getLevelNum()
end

function M:isBottom()
	local lobbyUnit = self:getLobbyUnit()
	local bottomLevelUnit = lobbyUnit:getBottomLevelUnit()

	return self:getLevelNum() == bottomLevelUnit:getLevelNum()
end

function M:_initComponents()
	self:_addComponent("anim", ElevatorAnim)
	self:_addComponent("status", ElevatorStatus)
	self:_addComponent("lineMgr", ElevatorLineMgr)
end

function M:clear()
	local len = #self._compList

	for i = 1, len do
		self._compList[i]:clear()
	end

	self._co = nil
end

return M
