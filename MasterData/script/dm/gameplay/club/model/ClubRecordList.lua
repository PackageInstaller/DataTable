-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/model/ClubRecordList.lua

ClubRecordList = class("ClubRecordList", objectlua.Object, _M)

ClubRecordList:has("_lastSyncTime", {
	is = "r"
})
ClubRecordList:has("_selfRecord", {
	is = "r"
})
ClubRecordList:has("_list", {
	is = "r"
})
ClubRecordList:has("_dataEnough", {
	is = "r"
})
ClubRecordList:has("_recordType", {
	is = "r"
})

function ClubRecordList:initialize(recordType)
	super.initialize(self)

	self._recordType = recordType

	self:cleanUp()
end

function ClubRecordList:getRequestRankCountPerTime()
	return 20
end

function ClubRecordList:hasData()
	return #self._list > 0
end

function ClubRecordList:synchronize(data, lastSyncTime)
	if data then
		local record = ClubRecordConfig.record[self._recordType]

		if type(data.pr) == "table" then
			self._selfRecord = record:new()

			self._selfRecord:synchronize(data.pr)
		end

		for _, clubData in pairs(data.lb) do
			local rank = clubData.rank

			self._list[rank] = self._list[rank] or record:new()

			self._list[rank]:synchronize(clubData)
		end

		self._dataEnough = #data.lb >= self:getRequestRankCountPerTime()
		self._lastSyncTime = lastSyncTime
	end
end

function ClubRecordList:getRecordByRank(rank)
	if rank then
		return self._list[rank]
	end
end

function ClubRecordList:getRecordCount()
	return #self._list
end

function ClubRecordList:getMaxCount()
	return 30000
end

function ClubRecordList:cleanUp()
	self._list = {}
	self._lastSyncTime = 0
	self._selfRecord = nil
	self._dataEnough = true
end

ClubApplyRecordList = class("ClubApplyRecordList", ClubRecordList, _M)

ClubApplyRecordList:has("_hasApplyCount", {
	is = "rw"
})

function ClubApplyRecordList:initialize(recordType)
	super.initialize(self, recordType)

	self._hasApplyCount = 0
end

function ClubApplyRecordList:synchronize(data, lastSyncTime)
	super.synchronize(self, data, lastSyncTime)

	if data.hasApplyCount then
		self._hasApplyCount = data.hasApplyCount
	end
end

ClubTechnology = class("ClubTechnology", objectlua.Object, _M)

ClubTechnology:has("_techPoints", {
	is = "rw"
})
ClubTechnology:has("_techPointMap", {
	is = "rw"
})
ClubTechnology:has("_id", {
	is = "rw"
})
ClubTechnology:has("_owner", {
	is = "rw"
})
ClubTechnology:has("_config", {
	is = "r"
})

function ClubTechnology:initialize(techId, owner)
	super.initialize(self)

	self._owner = owner
	self._id = techId
	self._config = ConfigReader:getRecordById("ClubTechnology", techId)
	self._techPoints = {}
	self._techPointMap = {}

	local pointIdList = self._config.TechPoint

	for i = 1, #pointIdList do
		local pointId = pointIdList[i]
		local techPoint = ClubTechPoint:new(pointId)

		self._techPoints[#self._techPoints + 1] = techPoint
		self._techPointMap[pointId] = techPoint
	end
end

function ClubTechnology:synchronize(data)
	if data.points then
		for id, v in pairs(data.points) do
			self._techPointMap[id]:synchronize(v)
		end

		self:updateClubNum()
		self:updateClubEliteNum()
	end
end

function ClubTechnology:updateClubNum()
	if self._techPointMap.Club_Contribute_1 then
		local point = self._techPointMap.Club_Contribute_1
		local pointLevel = point:getLevel()
		local curNum = point:getDescValue(1, pointLevel)
		local clubInfo = self._owner:getInfo()

		clubInfo:setMemberLimitCount(curNum)
	end
end

function ClubTechnology:updateClubEliteNum()
	if self._techPointMap.Club_Contribute_2 then
		local point = self._techPointMap.Club_Contribute_2
		local pointLevel = point:getLevel()
		local curNum = point:getDescValue(1, pointLevel)
		local clubInfo = self._owner:getInfo()

		clubInfo:setEliteLimitCount(curNum)
	end
end

function ClubTechnology:getPointById(id)
	return self._techPointMap[id]
end

function ClubTechnology:getName()
	return Strings:get(self._config.Name)
end

function ClubTechnology:getMainTechIcon()
	return self._config.MainTechIcon
end

function ClubTechnology:getSystemDesc()
	return Strings:get(self._config.SystemDesc)
end

function ClubTechnology:getUnlockCondition()
	return self._config.Unlock
end

function ClubTechnology:getOrder()
	return self._config.Order
end

ClubTechnologyList = class("ClubTechnologyList", objectlua.Object, _M)

ClubTechnologyList:has("_list", {
	is = "rw"
})
ClubTechnologyList:has("_map", {
	is = "rw"
})
ClubTechnologyList:has("_owner", {
	is = "rw"
})

function ClubTechnologyList:initialize(owner)
	super.initialize(self)

	self._list = {}
	self._map = {}
	self._owner = owner

	self:initTechBaseInfo(owner)
end

function ClubTechnologyList:getTechById(id)
	return self._map[id]
end

function ClubTechnologyList:initTechBaseInfo(owner)
	local techIdList = ConfigReader:getKeysOfTable("ClubTechnology")

	for i = 1, #techIdList do
		local techId = techIdList[i]
		local tech = ClubTechnology:new(techId, owner)

		self._list[#self._list + 1] = tech
		self._map[techId] = tech
	end

	table.sort(self._list, function(a, b)
		return a:getOrder() < b:getOrder()
	end)
end

function ClubTechnologyList:synchronize(data)
	self:initTechBaseInfo(self._owner)

	if data then
		for id, v in pairs(data) do
			self._map[id]:synchronize(v)
		end
	end
end

function ClubTechnologyList:cleanUp()
	self._list = {}
	self._map = {}
end
