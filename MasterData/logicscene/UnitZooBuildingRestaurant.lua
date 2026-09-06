-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/zoo/UnitZooBuildingRestaurant.lua

module("logicscene.scene.unit.impl.zoo.UnitZooBuildingRestaurant", package.seeall)

local UnitZooBuildingRestaurant = class("UnitZooBuildingRestaurant", UnitZooBuildingBase)

function UnitZooBuildingRestaurant:onUnitCreated(params)
	self.transform:setPos(params.pos.x, params.pos.y, 0)
end

function UnitZooBuildingRestaurant:_initComponents()
	UnitZooBuildingRestaurant.super._initComponents(self)
	self:_addComponent("hud_working", UnitCompHudZooWorkingBuilding)
end

function UnitZooBuildingRestaurant:update(deltaTime)
	UnitZooBuildingRestaurant.super.update(self, deltaTime)
	self.hud_working:update(deltaTime)
end

function UnitZooBuildingRestaurant:_updateBuilding()
	return
end

return UnitZooBuildingRestaurant
