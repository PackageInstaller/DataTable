-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/component/meshmodel/UnitCompModelMountBinder.lua

module("logic.scene.unit.component.meshmodel.UnitCompModelMountBinder", package.seeall)

local M = class("UnitCompModelMountBinder", UnitComponentBase)

function M:ctor(unit)
	M.super.ctor(self, unit)
end

function M:onInit()
	self._dictMountGO = {}

	self._unit:addInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)
end

function M:onReset()
	table.clear(self._dictMountGO)
end

function M:onDestroy()
	self._unit:removeInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)
	self:onReset()

	self._dictMountGO = nil
end

function M:bindGameObject(mountName, go)
	local mount = self._dictMountGO[mountName]

	if mount then
		goutil.addChildToParent(go, mount)
	end
end

function M:unbindMount(mountName)
	local mount = self._dictMountGO[mountName]

	if mount then
		goutil.clearChildren(mount)
	end
end

function M:unbindAll()
	for _, mountName in pairs(MeshModelMount) do
		self:unbindMount(mountName)
	end
end

function M:_onMeshModelLoaded()
	table.clear(self._dictMountGO)

	local goInst = self._unit.meshModel:getInst()

	if goInst then
		for _, mountName in pairs(MeshModelMount) do
			self._dictMountGO[mountName] = goutil.findChild(goInst, mountName)
		end
	end
end

return M
