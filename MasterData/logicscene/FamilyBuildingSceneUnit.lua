-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/family/FamilyBuildingSceneUnit.lua

module("logicscene.scene.unit.impl.family.FamilyBuildingSceneUnit", package.seeall)

local FamilyBuildingSceneUnit = class("FamilyBuildingSceneUnit", SceneUnitBase)

function FamilyBuildingSceneUnit:ctor(componentContainer)
	FamilyBuildingSceneUnit.super.ctor(self, componentContainer)

	self._buildingMo = nil
	self.type = FamilyBuildingType.None
	self._sizeVec = Vector3.New(20, 20, 2)
	self._centerVec = Vector3.New(0, 0, 0)
end

function FamilyBuildingSceneUnit:_initComponents()
	FamilyBuildingSceneUnit.super._initComponents(self)
	self:_addComponent("hud", UnitCompHudFamilyBuilding)
end

function FamilyBuildingSceneUnit:setBuildingMO(buildingMo)
	self._buildingMo = buildingMo

	self:_updateBuilding()

	if self.hud and self.hud.updateBuildingHud then
		self.hud:updateBuildingHud()
	end
end

function FamilyBuildingSceneUnit:getBuildingMO()
	return self._buildingMO
end

function FamilyBuildingSceneUnit:getTag()
	return UnitTag.SceneElement
end

function FamilyBuildingSceneUnit:getLayer()
	return SceneLayer.Unit_Value
end

function FamilyBuildingSceneUnit:getBuildingType()
	if self._buildingMO then
		self._buildingMO:getBuildingType()
	end

	return FamilyBuildingType.None
end

function FamilyBuildingSceneUnit:onUnitCreated(params)
	local boxCollider = self.go:GetComponent(ComponentType.BoxCollider)

	boxCollider.size = self._sizeVec
	boxCollider.center = self._centerVec

	self.transform:setPos(params.transform.position.x, params.transform.position.y, params.transform.position.z)
end

function FamilyBuildingSceneUnit:onUnitDestroyed()
	self:OnDestroy()
end

function FamilyBuildingSceneUnit:onUnitVisible()
	FamilyBuildingSceneUnit.super.onUnitVisible(self, self.go)
	Framework.GameObjectUtil.SetLayerRecursively(self.go, self:getLayer())
end

function FamilyBuildingSceneUnit:_updateBuilding()
	return
end

function FamilyBuildingSceneUnit:setBoxColliderParam(size, center)
	self._sizeVec = size
	self._centerVec = center
end

return FamilyBuildingSceneUnit
