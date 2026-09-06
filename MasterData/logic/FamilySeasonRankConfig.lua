-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/config/FamilySeasonRankConfig.lua

module("logic.extensions.newfamily.config.FamilySeasonRankConfig", package.seeall)

local FamilySeasonRankConfig = class("FamilySeasonRankConfig", BaseConfig)

function FamilySeasonRankConfig:onInit()
	FamilySeasonRankConfig.super.onInit(self)
end

function FamilySeasonRankConfig:getNames()
	return {
		"new_family_season",
		"new_family_season_rank",
		"new_family_season_rank_score_prize",
		"new_family_season_rank_prize"
	}
end

function FamilySeasonRankConfig:handleConfig(name, content)
	if name == "new_family_season" then
		self._nfsCfg = content
	elseif name == "new_family_season_rank" then
		self._nfsRankCfgs = content
	elseif name == "new_family_season_rank_score_prize" then
		self._nfsRankScoreCfgs = content
	elseif name == "new_family_season_rank_prize" then
		self._nfsRankPrizeCfgs = content
	end
end

function FamilySeasonRankConfig:getNfsSeasonDataList()
	return self._nfsCfg.dataList
end

function FamilySeasonRankConfig:getNfsSeasonData(seasonId)
	return self._nfsCfg[seasonId]
end

function FamilySeasonRankConfig:getNfsRankCfg(seasonId)
	return self._nfsRankCfgs[seasonId]
end

function FamilySeasonRankConfig:getNfsRankData(seasonId, rankType)
	if self._nfsRankCfgs[seasonId] then
		return self._nfsRankCfgs[seasonId][rankType]
	end
end

function FamilySeasonRankConfig:getNfsRankScoreCfg(seasonId)
	local data = self:getNfsSeasonData(seasonId)

	if data then
		return self._nfsRankScoreCfgs[data.scorePrizePlanId]
	end
end

function FamilySeasonRankConfig:getNfsRankScoreData(seasonId, id)
	local cfg = self:getNfsRankScoreCfg(seasonId)

	if cfg then
		return cfg[id]
	end
end

function FamilySeasonRankConfig:getNfsRankPrizeCfg(seasonId)
	local data = self:getNfsSeasonData(seasonId)

	if data then
		return self._nfsRankPrizeCfgs[data.rankPrizePlanId]
	end
end

function FamilySeasonRankConfig:getNfsRankPrizeData(seasonId, id)
	local cfg = self:getNfsRankPrizeCfg(seasonId)

	if cfg then
		return cfg[id]
	end
end

FamilySeasonRankConfig.instance = FamilySeasonRankConfig.New()

return FamilySeasonRankConfig
