-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/cutepet/UnitCutePetBuildingBase.lua

module("logicscene.scene.unit.impl.cutepet.UnitCutePetBuildingBase", package.seeall)

local UnitCutePetBuildingBase = class("UnitCutePetBuildingBase", SceneUnitBase)

function UnitCutePetBuildingBase:ctor(componetContainer)
	UnitCutePetBuildingBase.super.ctor(self, componetContainer)

	self._buildingMO = nil
	self.type = CutePetBuildingType.Zone
end

function UnitCutePetBuildingBase:_initComponents()
	UnitCutePetBuildingBase.super._initComponents(self)
	self:_addComponent("hud", UnitCompHudCutePetBuilding)
end

function UnitCutePetBuildingBase:setBuildingMO(buildingMO)
	self._buildingMO = buildingMO

	self:_updateBuilding()

	if self.hud and self.hud.updateBuildingHud then
		self.hud:updateBuildingHud()
	end
end

function UnitCutePetBuildingBase:getBuildingMO()
	return self._buildingMO
end

function UnitCutePetBuildingBase:getTag()
	return UnitTag.SceneElement
end

function UnitCutePetBuildingBase:getLayer()
	return SceneLayer.Unit_Value
end

function UnitCutePetBuildingBase:getBuildingType()
	if self._buildingMO then
		self._buildingMO:getBuildingType()
	end

	return CutePetBuildingType.None
end

function UnitCutePetBuildingBase:onUnitCreated(params)
	local boxCollider = self.go:GetComponent(ComponentType.BoxCollider)

	boxCollider.size = Vector3(20, 20, 2)
	boxCollider.center = Vector3(0, 10, 0)

	self.transform:setPos(params.transform.position.x, params.transform.position.y, params.transform.position.z)
end

function UnitCutePetBuildingBase:onUnitDestroyed()
	self:OnDestroy()
end

function UnitCutePetBuildingBase:onUnitVisible()
	UnitCutePetBuildingBase.super.onUnitVisible(self, self.go)
	Framework.GameObjectUtil.SetLayerRecursively(self.go, self:getLayer())
end

function UnitCutePetBuildingBase:_updateBuilding()
	return
end

return UnitCutePetBuildingBase
