-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stagePractice/model/StagePracticeRankList.lua

StagePracticeRankList = class("StagePracticeRankList", objectlua.Object, _M)

StagePracticeRankList:has("_lastSyncTime", {
	is = "r"
})
StagePracticeRankList:has("_selfRecord", {
	is = "r"
})
StagePracticeRankList:has("_list", {
	is = "r"
})
StagePracticeRankList:has("_dataEnough", {
	is = "r"
})

function StagePracticeRankList:initialize()
	super.initialize(self)
	self:cleanUp()
end

function StagePracticeRankList:getRequestRankCountPerTime()
	return 20
end

function StagePracticeRankList:hasData()
	return #self._list > 0
end

function StagePracticeRankList:synchronize(data, lastSyncTime)
	if data then
		if type(data.pr) == "table" then
			self._selfRecord = StagePracticeRankRecord:new()

			self._selfRecord:synchronize(data.pr)
		end

		for _, data in pairs(data.lb) do
			local rank = data.rank

			self._list[rank] = self._list[rank] or StagePracticeRankRecord:new()

			self._list[rank]:synchronize(data)
		end

		self._dataEnough = #data.lb >= self:getRequestRankCountPerTime()
		self._lastSyncTime = lastSyncTime
	end
end

function StagePracticeRankList:getRecordByRank(rank)
	if rank then
		return self._list[rank]
	end
end

function StagePracticeRankList:getRecordCount()
	return #self._list
end

function StagePracticeRankList:getMaxCount()
	return 30000
end

function StagePracticeRankList:cleanUp()
	self._list = {}
	self._lastSyncTime = 0
	self._selfRecord = nil
	self._dataEnough = true
end

StagePracticeRankRecord = class("StagePracticeRankRecord", objectlua.Object, _M)

StagePracticeRankRecord:has("_playerName", {
	is = "rw"
})
StagePracticeRankRecord:has("_headImg", {
	is = "rw"
})
StagePracticeRankRecord:has("_level", {
	is = "rw"
})
StagePracticeRankRecord:has("_time", {
	is = "rw"
})
StagePracticeRankRecord:has("_rank", {
	is = "rw"
})
StagePracticeRankRecord:has("_vip", {
	is = "rw"
})

function StagePracticeRankRecord:initialize()
	super.initialize(self)

	self._playerName = ""
	self._headImg = ""
	self._level = 0
	self._time = 0
	self._rank = 0
	self._vip = 0
end

function StagePracticeRankRecord:synchronize(data)
	if data.nickname then
		self._playerName = data.nickname
	end

	if data.vip then
		self._vip = data.vip
	end

	if data.avatar then
		self._headImg = data.avatar
	end

	if data.level then
		self._level = data.level
	end

	if data.value then
		self._time = data.value
	end

	if data.rank then
		self._rank = data.rank
	end
end
