-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/zoo/UnitZooBuildingAmusementPark.lua

module("logicscene.scene.unit.impl.zoo.UnitZooBuildingAmusementPark", package.seeall)

local UnitZooBuildingAmusementPark = class("UnitZooBuildingAmusementPark", UnitZooBuildingBase)

function UnitZooBuildingAmusementPark:onUnitCreated(params)
	self.transform:setPos(params.pos.x, params.pos.y, 0)
end

function UnitZooBuildingAmusementPark:_initComponents()
	UnitZooBuildingAmusementPark.super._initComponents(self)
	self:_addComponent("hud_working", UnitCompHudZooWorkingBuilding)
end

function UnitZooBuildingAmusementPark:update(deltaTime)
	UnitZooBuildingAmusementPark.super.update(self, deltaTime)
	self.hud_working:update(deltaTime)
end

function UnitZooBuildingAmusementPark:_updateBuilding()
	return
end

return UnitZooBuildingAmusementPark
