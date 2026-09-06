-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/zoo/UnitZooBuildingTraveler.lua

module("logicscene.scene.unit.impl.zoo.UnitZooBuildingTraveler", package.seeall)

local UnitZooBuildingTraveler = class("UnitZooBuildingTraveler", UnitZooBuildingBase)

function UnitZooBuildingTraveler:onUnitCreated(params)
	self.transform:setPos(params.pos.x, params.pos.y, 0)
end

function UnitZooBuildingTraveler:_initComponents()
	UnitZooBuildingBase.super._initComponents(self)
	self:_addComponent("hud", UnitCompHudZooTraveler)
end

function UnitZooBuildingTraveler:_updateBuilding()
	return
end

function UnitZooBuildingTraveler:update(deltaTime)
	UnitZooBuildingTraveler.super.update(self, deltaTime)
	self.hud:update(deltaTime)
end

function UnitZooBuildingTraveler:onUnitVisible(go)
	UnitZooBuildingTraveler.super.onUnitVisible(self, go)
	GoUtil.PlaySpineAnim(go, "idle", true, true)
end

return UnitZooBuildingTraveler
