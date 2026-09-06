-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/model/ZooBuildingAttrDescMO.lua

module("logic.extensions.petzoo.model.ZooBuildingAttrDescMO", package.seeall)

local ZooBuildingAttrDescMO = class("ZooBuildingAttrDescMO")

function ZooBuildingAttrDescMO:ctor()
	self.attrName = nil
	self.attrDesc = nil
end

return ZooBuildingAttrDescMO
