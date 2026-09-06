-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/zoo/UnitZooBuildingShop.lua

module("logicscene.scene.unit.impl.zoo.UnitZooBuildingShop", package.seeall)

local UnitZooBuildingShop = class("UnitZooBuildingShop", UnitZooBuildingBase)

function UnitZooBuildingShop:onUnitCreated(params)
	self.transform:setPos(params.pos.x, params.pos.y, 0)
end

function UnitZooBuildingShop:_updateBuilding()
	return
end

return UnitZooBuildingShop
