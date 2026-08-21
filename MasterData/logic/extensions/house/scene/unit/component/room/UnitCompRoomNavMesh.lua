-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/unit/component/room/UnitCompRoomNavMesh.lua

module("logic.extensions.house.scene.unit.component.room.UnitCompRoomNavMesh", package.seeall)

local M = class("UnitCompRoomNavMesh", UnitComponentBase)

function M:ctor(unit)
	M.super.ctor(self, unit)
end

function M:onInit()
	self._dictModifierVolumeComp = {}

	self:_resetData()
end

function M:_resetData()
	self._surfaceGO = nil
	self._surfaceComp = nil
	self._modifierVolumeGO = nil
end

function M:onReuse()
	return
end

function M:onReset()
	table.clear(self._dictModifierVolumeComp)

	if self._modifierVolumeGO then
		goutil.destroy(self._modifierVolumeGO)
	end

	self:_resetData()
end

function M:onDestroy()
	self:onReset()

	self._dictModifierVolumeComp = nil
end

function M:setSurfaceGO(go)
	self._surfaceGO = go
	self._surfaceComp = go:GetComponent(ComponentType.NavMeshSurface)
	self._modifierVolumeGO = goutil.create("modifierVolume", false)
	self._modifierVolumeGO.layer = SceneLayer.NavMesh_Value

	goutil.addChildToParent(self._modifierVolumeGO, self._surfaceGO)
end

function M:setModifierVolumePos(x, y, z)
	if self._modifierVolumeGO then
		Astral.TransformUtil.SetPos(self._modifierVolumeGO.transform, x, y, z)
	end
end

function M:rebuildSurface()
	self._surfaceComp:BuildNavMesh()
end

function M:setModifierVolumeDatas(datas)
	for _, data in ipairs(datas) do
		local comp = self:_getModifierVolumeComp()

		comp.size = data.size
		comp.center = data.center
		comp.area = data.area or SceneEnum.NavMeshAreas.NotWalkable
	end

	self:rebuildSurface()
	self:_returnAllModifierVolumeComp()
end

function M:_getModifierVolumeComp()
	for comp, hasUse in pairs(self._dictModifierVolumeComp) do
		if hasUse == false then
			self._dictModifierVolumeComp[comp] = true
			comp.enabled = true

			return comp
		end
	end

	local volumeComp = self._modifierVolumeGO:AddComponent(ComponentType.NavMeshModifierVolume)

	self._dictModifierVolumeComp[volumeComp] = true

	return volumeComp
end

function M:_returnAllModifierVolumeComp()
	for comp, hasUse in pairs(self._dictModifierVolumeComp) do
		self._dictModifierVolumeComp[comp] = false
		comp.enabled = false
	end
end

return M
