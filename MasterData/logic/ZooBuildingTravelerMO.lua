-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/model/building/ZooBuildingTravelerMO.lua

module("logic.extensions.zoo.model.building.ZooBuildingTravelerMO", package.seeall)

local ZooBuildingTravelerMO = class("ZooBuildingTravelerMO", ZooBuildingMO)

function ZooBuildingTravelerMO:ctor()
	ZooBuildingTravelerMO.super.ctor(self)

	self.travelEndTime = 0
end

function ZooBuildingTravelerMO:onSelected()
	if not self.zooMo:isMyZoo() then
		return
	end

	local travelManEndTime = self.travelEndTime

	if travelManEndTime > 0 and travelManEndTime <= ServerTime.now() then
		ZooAgent.instance:sendPM_ZooGetEggFromTravelManReq()
	else
		FloatWordMgr.instance:show(lang("petzoo_traveler_noback"))
	end
end

function ZooBuildingTravelerMO:isTravelerUnlocked()
	local zooLv = self.zooMo:getMainBuildingLevel()

	if zooLv == 0 then
		return false
	end

	local travelManEndEggLottery = ZooConfig.instance:getZooTravelManEgglottery()
	local unlockLv = travelManEndEggLottery[1].level

	return unlockLv <= zooLv
end

function ZooBuildingTravelerMO:getTravelEndTime()
	local travelManEndTime = self.travelEndTime

	if travelManEndTime == 0 then
		return
	else
		local now = ServerTime.now()

		if now < travelManEndTime then
			return travelManEndTime - now
		else
			return 0
		end
	end
end

return ZooBuildingTravelerMO
