-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/impl/UnitMainPlayer.lua

module("logic.scene.unit.impl.UnitMainPlayer", package.seeall)

local M = class("UnitMainPlayer", ReusableUnitBase)

function M:ctor(componetContainer)
	M.super.ctor(self, componetContainer)
end

function M:getTag()
	return UnitTag.MainPlayer
end

function M:getLayer()
	return SceneLayer.Unit_Value
end

function M:_initComponents()
	self:_addComponent("mountRoot", UnitCompMountRoot)
	self:_addComponent("meshModel", HouseUnitCompMeshModel)
	self:_addComponent("navMesh", UnitCompNavMesh)
	self:_addComponent("navMeshMover", UnitCompNavMeshMover)
	self:_addComponent("uiFollow", UnitCompUIFollow)
	self:_addComponent("controller", UnitCompPlayerController)
	self:_addComponent("model", UnitCompPlayerModel)
	self:_addComponent("material", UnitCompModelMaterial)
end

function M:Update()
	self.navMeshMover:update()
	self.controller:update()
	self.navMesh:update()
end

function M:getAgentPos()
	return self.navMesh:getNavMeshGoPos()
end

return M
