-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/rank/model/RankList.lua

require("dm.gameplay.rank.model.RankRecord")

RankList = class("RankList", objectlua.Object, _M)

RankList:has("_lastSyncTime", {
	is = "r"
})
RankList:has("_selfRecord", {
	is = "r"
})
RankList:has("_rankList", {
	is = "r"
})
RankList:has("_dataEnough", {
	is = "r"
})

function RankList:initialize()
	super.initialize(self)
	self:cleanUp()
end

function RankList:getRequestRankCountPerTime()
	return 20
end

function RankList:hasData()
	return #self._rankList > 0
end

function RankList:synchronize(data, record, lastSyncTime)
	if data and next(data) and record then
		if type(data.pr) == "table" then
			self._selfRecord = record:new()

			self._selfRecord:synchronize(data.pr)
		end

		for index, rankData in pairs(data.lb) do
			local record = record:new()

			record:synchronize(rankData)

			local rank = record:getRank()

			rank = rank > 0 and rank or index
			self._rankList[rank] = record
		end

		self._dataEnough = #data.lb >= self:getRequestRankCountPerTime()
		self._lastSyncTime = lastSyncTime
	end
end

function RankList:getRecordByRank(rank)
	if rank then
		return self._rankList[rank]
	end
end

function RankList:getRecordCount()
	return #self._rankList
end

function RankList:cleanUp()
	self._rankList = {}
	self._lastSyncTime = 0
	self._selfRecord = nil
	self._dataEnough = true
end
