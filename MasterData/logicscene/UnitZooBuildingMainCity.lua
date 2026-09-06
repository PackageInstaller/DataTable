-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/zoo/UnitZooBuildingMainCity.lua

module("logicscene.scene.unit.impl.zoo.UnitZooBuildingMainCity", package.seeall)

local UnitZooBuildingMainCity = class("UnitZooBuildingMainCity", UnitZooBuildingBase)

function UnitZooBuildingMainCity:onUnitCreated(params)
	self.transform:setPos(params.pos.x, params.pos.y, 0)
end

function UnitZooBuildingMainCity:_updateBuilding()
	return
end

return UnitZooBuildingMainCity
