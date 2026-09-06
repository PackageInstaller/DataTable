-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/model/building/ZooBuildingTransPointMO.lua

module("logic.extensions.zoo.model.building.ZooBuildingTransPointMO", package.seeall)

local ZooBuildingTransPointMO = class("ZooBuildingTransPointMO", ZooBuildingMO)

function ZooBuildingTransPointMO:ctor()
	ZooBuildingTransPointMO.super.ctor(self)
end

function ZooBuildingTransPointMO:onSelected()
	return
end

return ZooBuildingTransPointMO
