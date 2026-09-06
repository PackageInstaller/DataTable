-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/zoo/UnitZooBuildingPool.lua

module("logicscene.scene.unit.impl.zoo.UnitZooBuildingPool", package.seeall)

local UnitZooBuildingPool = class("UnitZooBuildingPool", UnitZooBuildingBase)

function UnitZooBuildingPool:onUnitCreated(params)
	self.transform:setPos(params.pos.x, params.pos.y, 0)
end

function UnitZooBuildingPool:_updateBuilding()
	return
end

function UnitZooBuildingPool:_initComponents()
	UnitZooBuildingBase.super._initComponents(self)
	self:_addComponent("hud", UnitCompHudZooPool)
end

function UnitZooBuildingPool:onUnitVisible(go)
	UnitZooBuildingPool.super.onUnitVisible(self, go)
	GoUtil.PlaySpineAnim(go, "1", true, true)
end

function UnitZooBuildingPool:update(deltaTime)
	UnitZooBuildingPool.super.update(self, deltaTime)
	self.hud:update(deltaTime)
end

return UnitZooBuildingPool
