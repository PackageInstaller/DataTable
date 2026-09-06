-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/zoo/UnitZooBuildingBase.lua

module("logicscene.scene.unit.impl.zoo.UnitZooBuildingBase", package.seeall)

local UnitZooBuildingBase = class("UnitZooBuildingBase", SceneUnitBase)

function UnitZooBuildingBase:ctor(componetContainer)
	UnitZooBuildingBase.super.ctor(self, componetContainer)

	self._buildingMO = nil
end

function UnitZooBuildingBase:_initComponents()
	UnitZooBuildingBase.super._initComponents(self)
	self:_addComponent("hud", UnitCompHudZooBuildingBase)
end

function UnitZooBuildingBase:setBuildingMO(buildingMO)
	self._buildingMO = buildingMO

	self:_updateBuilding()

	if self.hud and self.hud.updateBuildingHud then
		self.hud:updateBuildingHud()
	end
end

function UnitZooBuildingBase:getBuildingMO()
	return self._buildingMO
end

function UnitZooBuildingBase:getTag()
	return UnitTag.SceneElement
end

function UnitZooBuildingBase:getLayer()
	return SceneLayer.Unit_Value
end

function UnitZooBuildingBase:getBuildingType()
	if self._buildingMO then
		self._buildingMO:getBuildingType()
	end

	return ZooBuildingType.None
end

function UnitZooBuildingBase:onUnitCreated(params)
	self.transform:setPos(params.pos.x, params.pos.y, 0)
end

function UnitZooBuildingBase:onUnitDestroyed()
	self.actions:stopAllActions()
	self:OnDestroy()
end

function UnitZooBuildingBase:onUnitVisible(go)
	UnitZooBuildingBase.super.onUnitVisible(self, go)
	Framework.GameObjectUtil.SetLayerRecursively(go, self:getLayer())
end

function UnitZooBuildingBase:_updateBuilding()
	return
end

return UnitZooBuildingBase
