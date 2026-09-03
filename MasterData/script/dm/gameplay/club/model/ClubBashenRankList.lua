-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/model/ClubBashenRankList.lua

require("dm.gameplay.club.model.ClubBashenRankRecord")

ClubBashenRankList = class("ClubBashenRankList", objectlua.Object, _M)

ClubBashenRankList:has("_selfRecord", {
	is = "r"
})
ClubBashenRankList:has("_list", {
	is = "r"
})
ClubBashenRankList:has("_dataEnough", {
	is = "r"
})
ClubBashenRankList:has("_recordType", {
	is = "r"
})

function ClubBashenRankList:initialize()
	super.initialize(self)
	self:cleanUp()
end

function ClubBashenRankList:getRequestRankCountPerTime()
	return 20
end

function ClubBashenRankList:hasData()
	return #self._list > 0
end

function ClubBashenRankList:synchronize(data)
	if data then
		if type(data.pr) == "table" then
			self._selfRecord = ClubBashenRankRecord:new()

			self._selfRecord:synchronize(data.pr)
		end

		for _, rankData in pairs(data.lb) do
			local rank = rankData.rank

			self._list[rank] = self._list[rank] or ClubBashenRankRecord:new()

			self._list[rank]:synchronize(rankData)
		end

		self._dataEnough = #data.lb >= self:getRequestRankCountPerTime()
	end
end

function ClubBashenRankList:getRecordByRank(rank)
	if rank then
		return self._list[rank]
	end
end

function ClubBashenRankList:getRecordCount()
	return #self._list
end

function ClubBashenRankList:getMaxCount()
	return 30000
end

function ClubBashenRankList:cleanUp()
	self._list = {}
	self._lastSyncTime = 0
	self._selfRecord = nil
	self._dataEnough = true
end
