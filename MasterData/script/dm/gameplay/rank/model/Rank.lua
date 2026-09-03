-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/rank/model/Rank.lua

require("dm.gameplay.rank.model.RankList")

Rank = class("Rank", objectlua.Object, _M)

Rank:has("_rankInfo", {
	rw = ""
})

function Rank:initialize()
	super.initialize(self)

	self._rankInfo = {}

	for k, v in pairs(RankType) do
		self._rankInfo[v] = RankList:new()
	end
end

function Rank:synchronize(data, rankType, lastSyncTime)
	if rankType and data then
		local record = RankClass[rankType]
		local rankInfo = self._rankInfo[rankType]

		rankInfo:synchronize(data, record, lastSyncTime)
	end
end

function Rank:resetAllRankListSyncTime()
	for k, v in pairs(self._rankInfo) do
		v._selfRecord = 0
	end
end

function Rank:cleanUpRankList(type)
	self._rankInfo[type]:cleanUp()
end
