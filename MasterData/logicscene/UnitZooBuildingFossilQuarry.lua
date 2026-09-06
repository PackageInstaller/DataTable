-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/zoo/UnitZooBuildingFossilQuarry.lua

module("logicscene.scene.unit.impl.zoo.UnitZooBuildingFossilQuarry", package.seeall)

local UnitZooBuildingFossilQuarry = class("UnitZooBuildingFossilQuarry", UnitZooBuildingBase)

function UnitZooBuildingFossilQuarry:onUnitCreated(params)
	self.transform:setPos(params.pos.x, params.pos.y, 0)
end

function UnitZooBuildingFossilQuarry:_initComponents()
	UnitZooBuildingFossilQuarry.super._initComponents(self)
	self:_addComponent("hud_working", UnitCompHudZooWorkingBuilding)
end

function UnitZooBuildingFossilQuarry:update(deltaTime)
	UnitZooBuildingFossilQuarry.super.update(self, deltaTime)
	self.hud_working:update(deltaTime)
end

function UnitZooBuildingFossilQuarry:_updateBuilding()
	return
end

return UnitZooBuildingFossilQuarry
