-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/zoo/UnitZooBuildingTransDoor.lua

module("logicscene.scene.unit.impl.zoo.UnitZooBuildingTransDoor", package.seeall)

local UnitZooBuildingTransDoor = class("UnitZooBuildingTransDoor", UnitZooBuildingBase)

function UnitZooBuildingTransDoor:onUnitCreated(params)
	self.transform:setPos(params.pos.x, params.pos.y, 0)
end

function UnitZooBuildingTransDoor:_updateBuilding()
	return
end

function UnitZooBuildingTransDoor:onUnitDestroyed()
	UnitZooBuildingTransDoor.super.onUnitDestroyed(self)
end

return UnitZooBuildingTransDoor
