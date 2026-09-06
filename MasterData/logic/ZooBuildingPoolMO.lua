-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/model/building/ZooBuildingPoolMO.lua

module("logic.extensions.zoo.model.building.ZooBuildingPoolMO", package.seeall)

local ZooBuildingPoolMO = class("ZooBuildingPoolMO", ZooBuildingMO)

function ZooBuildingPoolMO:onSelected()
	if self.zooMo:isMyZoo() then
		ViewMgr.instance:open(ViewName.ZooFriendListView)
	end
end

return ZooBuildingPoolMO
