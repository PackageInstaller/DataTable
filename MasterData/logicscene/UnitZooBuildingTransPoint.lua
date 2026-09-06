-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/zoo/UnitZooBuildingTransPoint.lua

module("logicscene.scene.unit.impl.zoo.UnitZooBuildingTransPoint", package.seeall)

local UnitZooBuildingTransPoint = class("UnitZooBuildingTransPoint", UnitZooBuildingBase)

function UnitZooBuildingTransPoint:onUnitCreated(params)
	self.transform:setPos(params.pos.x, params.pos.y, 0)
	self.scene.stage.wholeScene:CreateTrigger(self.scene:getSceneId(), TilingSceneConfig.ExitranceTriggerId, Vector2.New(params.pos.x, params.pos.y), Vector2.New(2, 2))
end

function UnitZooBuildingTransPoint:_updateBuilding()
	return
end

function UnitZooBuildingTransPoint:onUnitDestroyed()
	self.scene.stage.wholeScene:RemoveTrigger(self.scene:getSceneId(), TilingSceneConfig.ExitranceTriggerId)
	UnitZooBuildingTransPoint.super.onUnitDestroyed(self)
end

return UnitZooBuildingTransPoint
