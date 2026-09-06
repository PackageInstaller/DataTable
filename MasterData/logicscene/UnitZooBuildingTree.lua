-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/zoo/UnitZooBuildingTree.lua

module("logicscene.scene.unit.impl.zoo.UnitZooBuildingTree", package.seeall)

local UnitZooBuildingTree = class("UnitZooBuildingTree", UnitZooBuildingBase)

function UnitZooBuildingTree:onUnitCreated(params)
	self.transform:setPos(params.pos.x, params.pos.y, 0)
end

function UnitZooBuildingTree:_updateBuilding()
	return
end

function UnitZooBuildingTree:_initComponents()
	UnitZooBuildingBase.super._initComponents(self)
	self:_addComponent("hud", UnitCompHudZooTree)
end

function UnitZooBuildingTree:update(deltaTime)
	UnitZooBuildingTree.super.update(self)
	self.hud:update(deltaTime)
end

return UnitZooBuildingTree
