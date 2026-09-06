-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/zoo/UnitZooBuildingEggsMachine.lua

module("logicscene.scene.unit.impl.zoo.UnitZooBuildingEggsMachine", package.seeall)

local UnitZooBuildingEggsMachine = class("UnitZooBuildingEggsMachine", UnitZooBuildingBase)

function UnitZooBuildingEggsMachine:onUnitCreated(params)
	self.transform:setPos(params.pos.x, params.pos.y, 0)
end

function UnitZooBuildingEggsMachine:_updateBuilding()
	return
end

function UnitZooBuildingEggsMachine:_initComponents()
	UnitZooBuildingEggsMachine.super._initComponents(self)
	self:_addComponent("machineState", UnitCompZooEggMachineState)
	self:_addComponent("hud", UnitCompHudZooEggMachine)
end

function UnitZooBuildingEggsMachine:update(deltaTime)
	UnitZooBuildingEggsMachine.super.update(self, deltaTime)
	self.machineState:update(deltaTime)
	self.hud:update(deltaTime)
end

return UnitZooBuildingEggsMachine
