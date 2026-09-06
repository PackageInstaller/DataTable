-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/competitionking/config/CompetitionKingConfig.lua

module("logic.extensions.competitionking.config.CompetitionKingConfig", package.seeall)

local CompetitionKingConfig = class("CompetitionKingConfig", BaseConfig)

function CompetitionKingConfig:onInit()
	CompetitionKingConfig.super.onInit(self)
end

function CompetitionKingConfig:getNames()
	return {
		"competition_king_activity",
		"competition_king_progress_prize",
		"competition_king_rank_prize"
	}
end

function CompetitionKingConfig:handleConfig(name, content)
	if name == "competition_king_activity" then
		self._comKingActCfg = content
	elseif name == "competition_king_progress_prize" then
		self._comKingProgressCfg = content
	elseif name == "competition_king_rank_prize" then
		self._comKingRankCfg = content
	end
end

function CompetitionKingConfig:getActCfgById(actId)
	return self._comKingActCfg[actId]
end

function CompetitionKingConfig:getProgressCfgById(actId)
	return self._comKingProgressCfg[actId]
end

function CompetitionKingConfig:getRankCfgById(actId)
	return self._comKingRankCfg[actId]
end

function CompetitionKingConfig:getPrizeByRank(actId, rank)
	local cfg = self:getRankCfgById(actId)

	for _, v in pairs(cfg) do
		local min = v.rankRange[1]
		local max = v.rankRange[#v.rankRange]

		if min <= rank and rank <= max then
			return v.prize
		end
	end

	return cfg[#cfg].prize
end

CompetitionKingConfig.instance = CompetitionKingConfig.New()

return CompetitionKingConfig
