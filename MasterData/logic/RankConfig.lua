-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/config/RankConfig.lua

module("logic.extensions.rank.config.RankConfig", package.seeall)

local RankConfig = class("RankConfig", BaseConfig)

RankConfig.RankType = {
	MaxFightPowerRank = 1
}

function RankConfig:onInit()
	RankConfig.super.onInit(self)

	self._bigRankPrize = nil
end

function RankConfig:getNames()
	return {
		"big_rank_prize",
		"big_rank_sort"
	}
end

function RankConfig:handleConfig(name, content)
	if name == "big_rank_prize" then
		self._bigRankPrize = content
	elseif name == "big_rank_sort" then
		self._big_rank_sort = content

		self:_handleBigRankSort(content)
	end
end

function RankConfig:_handleBigRankSort(content)
	self._sortRanks = {}

	if content then
		for i, data in ipairs(content.dataList) do
			self._sortRanks[data.rankTypeString] = data
		end
	end
end

function RankConfig:getSortRankIndex(rankType)
	rankType = tostring(rankType)

	if self._sortRanks[rankType] then
		return self._sortRanks[rankType].sortId
	end

	return 9999
end

RankConfig.instance = RankConfig.New()

return RankConfig
