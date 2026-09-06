-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/zoo/UnitZooBuildingCafe.lua

module("logicscene.scene.unit.impl.zoo.UnitZooBuildingCafe", package.seeall)

local UnitZooBuildingCafe = class("UnitZooBuildingCafe", UnitZooBuildingBase)

function UnitZooBuildingCafe:onUnitCreated(params)
	self.transform:setPos(params.pos.x, params.pos.y, 0)
end

function UnitZooBuildingCafe:_initComponents()
	UnitZooBuildingCafe.super._initComponents(self)
	self:_addComponent("hud_working", UnitCompHudZooWorkingBuilding)
end

function UnitZooBuildingCafe:update(deltaTime)
	UnitZooBuildingCafe.super.update(self, deltaTime)
	self.hud_working:update(deltaTime)
end

function UnitZooBuildingCafe:_updateBuilding()
	return
end

return UnitZooBuildingCafe
