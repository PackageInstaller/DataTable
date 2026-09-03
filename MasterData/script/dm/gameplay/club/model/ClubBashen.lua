-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/model/ClubBashen.lua

require("dm.gameplay.club.model.ClubBashenRankList")

ClubBashen = class("ClubBashen", objectlua.Object, _M)

ClubBashen:has("_leaveCount", {
	is = "rw"
})
ClubBashen:has("_totalReopenCount", {
	is = "rw"
})
ClubBashen:has("_diamondReopenCount", {
	is = "rw"
})
ClubBashen:has("_freeReopenCountMax", {
	is = "rw"
})
ClubBashen:has("_announceList", {
	is = "rw"
})
ClubBashen:has("_bigRewardList", {
	is = "rw"
})
ClubBashen:has("_totalRecord", {
	is = "rw"
})
ClubBashen:has("_rankList", {
	is = "rw"
})
ClubBashen:has("_manualFinish", {
	is = "rw"
})

function ClubBashen:initialize()
	super.initialize(self)
	self:initData()
end

function ClubBashen:initData()
	self._leaveCount = 0
	self._totalReopenCount = 0
	self._diamondReopenCount = 0
	self._freeReopenCountMax = 0
	self._announceList = {}
	self._bigRewardList = {}
	self._totalRecord = {}
	self._manualFinish = false
	self._rankList = ClubBashenRankList:new()
end

function ClubBashen:syncRankData(data)
	self._rankList:synchronize(data)
end

function ClubBashen:synchronize(data)
	if data.dailyRetryTimes then
		self._totalReopenCount = data.dailyRetryTimes
	end

	if data.dailyBoughtExtraRetryTimes then
		self._diamondReopenCount = data.dailyBoughtExtraRetryTimes
	end

	if data.dailyFreeRetryTimesMax then
		self._freeReopenCountMax = data.dailyFreeRetryTimesMax
	end

	if data.drawPacks then
		for i, record in pairs(data.drawPacks) do
			self._totalRecord[i + 1] = record
		end
	end
end

function ClubBashen:synchronizeManualFinish(data)
	self._manualFinish = data
end

function ClubBashen:synchronizeBigPrize(data)
	self._bigRewardList = {}
	self._bigRewardList = data
end

function ClubBashen:syncDelateData(data)
	if data and data.drawPacks then
		for i, v in pairs(data.drawPacks) do
			self._totalRecord[i + 1] = nil
		end
	end
end

function ClubBashen:syncAnnounce(data)
	if data and data.announce then
		self._announceList = {}

		local tempAnnounceList = data.announce
		local index = 1

		for k, v in pairs(tempAnnounceList) do
			self._announceList[index] = v
			index = index + 1
		end

		table.sort(self._announceList, function(a, b)
			return a.timeStamp < b.timeStamp
		end)
	end
end

function ClubBashen:getLeaveOpenCount()
	local totalFreeCount = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BaShen_PackNumber", "content")

	totalFreeCount = totalFreeCount or 5

	local hasOpenCount = table.nums(self._totalRecord)

	return totalFreeCount - hasOpenCount
end

function ClubBashen:getFreeReopenCount()
	return self._freeReopenCountMax - self._totalReopenCount
end

function ClubBashen:getFreeReopenMaxCount()
	return self._freeReopenCountMax
end

function ClubBashen:getLeaveDiamondReopenCount()
	local costData = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BaShen_ResetPay", "content")

	if costData then
		return costData.payTimes - self._diamondReopenCount
	end

	return 0
end

function ClubBashen:getDiamondReopenCost()
	local leaveTimes = self:getLeaveDiamondReopenCount()

	if leaveTimes > 0 then
		local costData = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BaShen_ResetPay", "content")

		if costData then
			if costData.cost[self._diamondReopenCount + 1] then
				if not costData.cost[self._diamondReopenCount + 1] then
					return costData.cost[#costData.cost]
				end
			end
		end
	end

	return 0
end
