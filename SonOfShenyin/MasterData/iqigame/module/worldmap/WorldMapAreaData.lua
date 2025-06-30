-- chunkname: @IQIGame\\Module\\WorldMap\\WorldMapAreaData.lua

local WorldMapAreaData = {}
local RoomDataClass = require("IQIGame/Module/WorldMap/WorldMapRoomData")

function WorldMapAreaData.New(cfgAreaData, areaPod, roomsPod, componentsPod, actionsPod)
	local o = Clone(WorldMapAreaData)

	o:Initialize(cfgAreaData, areaPod, roomsPod, componentsPod, actionsPod)

	return o
end

function WorldMapAreaData:Initialize(cfgAreaData, areaPod, roomsPod, componentsPod, actionsPod)
	self.cfgAreaData = cfgAreaData
	self.cid = cfgAreaData.Id
	self.status = 0
	self.currentRoomCid = 0
	self.lastResetTime = 0
	self.roomList = {}

	for i, v in pairs(CfgWorldMapRoomTable) do
		if v.AreaId == self.cid then
			self.roomList[i] = RoomDataClass.New(v, roomsPod[i] and roomsPod[i] or nil, componentsPod, actionsPod)
			WorldMapModule.roomDataList[i] = self.roomList[i]
		end
	end

	self:ReloadPodData(areaPod)
end

function WorldMapAreaData:GetCurrentRoomData()
	return self.roomList[self.currentRoomCid]
end

function WorldMapAreaData:GetCurrentRoomId()
	return self.currentRoomCid
end

function WorldMapAreaData:GetRoomDataWithID(id)
	if not self.roomList then
		return
	end

	return self.roomList[id]
end

function WorldMapAreaData:GetUnlockRoomArray()
	local array = {}

	for _, v in pairs(self.roomList) do
		if v:GetIsUnlock() then
			table.insert(array, v)
		end
	end

	return array
end

function WorldMapAreaData:GetCfg()
	return self.cfgAreaData
end

function WorldMapAreaData:GetRoomCount()
	if not self.roomList then
		return 0
	end

	return getTableLength(self.roomList)
end

function WorldMapAreaData:GetUnlock()
	if self.status and self.status ~= 0 then
		return self.status == Constant.WorldMapStatus.Show
	end

	return ConditionModule.CheckConditionIsAllPass(self.cfgAreaData.UnlockCondition)
end

function WorldMapAreaData:ReloadPodData(areaPod)
	if not areaPod then
		return
	end

	self.cid = areaPod.cid

	if areaPod.status and areaPod.status ~= 0 then
		self.status = areaPod.status
	end

	self.currentRoomCid = areaPod.currentRoomCid
	self.lastResetTime = areaPod.lastResetTime
	self.openCount = areaPod.openCount
end

return WorldMapAreaData
