-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/component/meshmodel/UnitCompCollider.lua

module("logic.scene.unit.component.meshmodel.UnitCompCollider", package.seeall)

local M = class("UnitCompCollider", UnitComponentBase)
local DEFAULT_CENTER = {
	z = 0,
	x = 0,
	y = 0.8
}
local DEFAULT_SIZE = {
	z = 0.24,
	x = 0.4,
	y = 1.6
}

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._colliderCenter = nil
	self._colliderSize = nil
end

function M:onInit()
	self._colliderCenter = Vector3.New(DEFAULT_CENTER.x, DEFAULT_CENTER.y, DEFAULT_CENTER.z)
	self._colliderSize = Vector3.New(DEFAULT_SIZE.x, DEFAULT_SIZE.y, DEFAULT_SIZE.z)

	self._unit:addInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)
end

function M:onReset()
	return
end

function M:onDestroy()
	self._unit:removeInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)

	self._colliderCenter = false
	self._colliderSize = false
end

function M:setColliderCenter(x, y, z)
	self._colliderCenter:Set(x, y, z)
	self:_updateCollider()
end

function M:setColliderSize(x, y, z)
	self._colliderSize:Set(x, y, z)
	self:_updateCollider()
end

function M:getCompCollider()
	local meshGO = self._unit.meshModel:getInst()

	if meshGO then
		return meshGO:GetComponent(ComponentType.BoxCollider)
	end
end

function M:_updateCollider()
	local collider = self:getCompCollider()

	if collider then
		collider.center = self._colliderCenter
		collider.size = self._colliderSize
	end
end

function M:_onMeshModelLoaded()
	local meshGO = self._unit.meshModel:getInst()

	if meshGO then
		goutil.addComponentOnce(meshGO, ComponentType.BoxCollider)
		self:_updateCollider()
	end
end

return M
