-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/unit/herounit/AirWorkBuildingUnitCompMeshModel.lua

module("logic.extensions.airworkshop.flow.defflow.unit.herounit.AirWorkBuildingUnitCompMeshModel", package.seeall)

local M = class("AirWorkBuildingUnitCompMeshModel", UnitComponentBase)

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._prefabLoader = PrefabLoader.Get(unit.go)
	self._lookAtDirection = Vector3.New()
	self._size = Vector3.New()
	self._originalSizey = 0
	self._animationPlayer = nil
	self._url = nil
	self._scale = 1
end

function M:onInit()
	self._mover = self._unit.mover
	self._goAvatar = self._unit.mountRoot:getAvatarRoot()
	self._prefabLoader._go = self._goAvatar
end

function M:lookAt(x, y, z)
	local cx, cz = self._mover:getPos()

	self:lookAtDir(x - cx, 0, z - cz)
end

function M:lookAtVec3(point)
	self:lookAt(point.x, point.y, point.z)
end

function M:lookAtDir(dx, dy, dz)
	self._lookAtDirection:Set(dx, dy, dz)

	if self._animationPlayer then
		self._animationPlayer:LookAtDirection(dx, dz)
	end
end

function M:lookAtDirVec3(direction)
	self:lookAtDir(direction.x, direction.y, direction.z)
end

function M:getLookAtDir()
	return self._lookAtDirection:Get()
end

function M:getLookAtDirInVec3(point)
	point.x = self._lookAtDirection.x
	point.y = self._lookAtDirection.y
	point.z = self._lookAtDirection.z
end

function M:setBody(url)
	if self._url == url then
		return
	end

	self:clear()

	if not url then
		return
	end

	self._url = url

	self._prefabLoader:load(url, self._onBodyLoaded, self, true)
end

function M:getInst()
	return self._prefabLoader:getInst()
end

function M:getStandardRoot()
	return self._goStandardRoot
end

function M:getAnimationPlayer()
	return self._animationPlayer
end

function M:_onBodyLoaded(loader)
	local roleGo = self._prefabLoader:getInst()
	local x, y, z = 1, 1, 1

	self._originalSizey = y
	y = math.min(3, y)

	self._size:Set(x, y, z)
	self:_onBeforeDispatchMeshModelLoaded()
	self._unit:dispatchInnerEvent(UnitActionType.MeshModelLoaded)
end

function M:_onBeforeDispatchMeshModelLoaded()
	return
end

function M:getBodySize()
	return self._size
end

function M:getOriginalBodySizeY()
	return self._originalSizey
end

function M:clear()
	if self._prefabLoader then
		self._prefabLoader:clear()
	end

	self._url = nil
end

function M:onDestroy()
	self._prefabLoader = nil
	self._url = nil
end

return M
