-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/config/YoungChampionKingConfig.lua

module("logic.extensions.youngchampionking.config.YoungChampionKingConfig", package.seeall)

local YoungChampionKingConfig = class("YoungChampionKingConfig", BaseConfig)

function YoungChampionKingConfig:getNames()
	return {
		"young_champion_king",
		"young_champion_king_common",
		"young_champion_king_qualify_rank_prize",
		"young_champion_king_knockout_rank_prize",
		"young_champion_king_step",
		"young_champion_king_round",
		"young_champion_king_qualify",
		"young_champion_king_qualifier_match",
		"young_champion_king_zone",
		"young_champion_king_knockout_game",
		"young_champion_king_guess"
	}
end

function YoungChampionKingConfig:handleConfig(name, content)
	if name == "young_champion_king" then
		self._actCfg = content
	elseif name == "young_champion_king_common" then
		self._commonCfgs = content
	elseif name == "young_champion_king_qualify_rank_prize" then
		self._qualifyRankPrizeMap = content
	elseif name == "young_champion_king_knockout_rank_prize" then
		self._knockoutRankPrizeCfgs = content
	elseif name == "young_champion_king_round" then
		self._roundCfgs = content
	elseif name == "young_champion_king_step" then
		self._stepCfgs = content
		self._stepCfgMapByRoundId = {}

		for _, cfg in ipairs(content.dataList) do
			local actId = cfg.activityId
			local roundId = cfg.roundId

			if not self._stepCfgMapByRoundId[actId] then
				if not self._stepCfgMapByRoundId[actId][roundId] then
					local cfgsByRoundId = {}

					table.insert(cfgsByRoundId, cfg)

					self._stepCfgMapByRoundId[actId][roundId] = cfgsByRoundId
					self._stepCfgMapByRoundId[actId] = self._stepCfgMapByRoundId[actId]
				end
			end
		end
	elseif name == "young_champion_king_qualify" then
		self._qualifyBaseCfgs = content
	elseif name == "young_champion_king_qualifier_match" then
		self._qualifyMatchCfgs = content
	elseif name == "young_champion_king_zone" then
		self._warZoneCfgs = content
	elseif name == "young_champion_king_guess" then
		self._young_champion_king_guess = content
	elseif name == "young_champion_king_knockout_game" then
		self._knockoutGameCfgs = content
	end
end

function YoungChampionKingConfig:getActCfg(actId)
	return self._actCfg[actId]
end

function YoungChampionKingConfig:getCommonValue(key)
	return self._commonCfgs[key].value
end

function YoungChampionKingConfig:getQualifyRankPrizeCfgs(actId)
	self._qualifyRankPrizeCfgs = self._qualifyRankPrizeCfgs or {}

	local cfgs = self._qualifyRankPrizeCfgs[actId]

	if not cfgs then
		if not self._qualifyRankPrizeMap[actId] then
			cfgs = {}

			for k, cfg in pairs(self._qualifyRankPrizeMap[actId]) do
				table.insert(cfgs, cfg)
			end

			table.sort(cfgs, function(a, b)
				return a.rankRange[1] < b.rankRange[1]
			end)

			self._qualifyRankPrizeCfgs[actId] = cfgs
		end
	end

	return cfgs
end

function YoungChampionKingConfig:getKnockoutRankPrizeCfgs(actId)
	return self._knockoutRankPrizeCfgs[actId] or {}
end

function YoungChampionKingConfig:getStepCfgs(actId)
	return self._stepCfgs[actId] or {}
end

function YoungChampionKingConfig:getStepCfgsByRoundId(actId, roundId)
	return (self._stepCfgMapByRoundId and self._stepCfgMapByRoundId[actId] or nil) and (self._stepCfgMapByRoundId[actId][roundId] or {})
end

function YoungChampionKingConfig:getStepCfg(actId, stepId)
	local cfgs = self:getStepCfgs(actId)

	return cfgs[stepId]
end

function YoungChampionKingConfig:getRoundCfgs(actId)
	return self._roundCfgs[actId] or {}
end

function YoungChampionKingConfig:getRoundCfg(actId, roundId)
	local cfgs = self:getRoundCfgs(actId)

	return cfgs[roundId]
end

function YoungChampionKingConfig:getQualifyBaseCfg(actId, stepId)
	return self._qualifyBaseCfgs[actId] and self._qualifyBaseCfgs[actId][stepId]
end

function YoungChampionKingConfig:getQualifyMatchCfgs(actId, stepId)
	local baseCfg = self:getQualifyBaseCfg(actId, stepId)

	if baseCfg then
		return self._qualifyMatchCfgs[baseCfg.quaMatchingPlanId] or {}
	end
end

function YoungChampionKingConfig:getQualifyMatchCfg(actId, stepId, matchId)
	local cfgs = self:getQualifyMatchCfgs(actId, stepId)

	return cfgs and cfgs[matchId]
end

function YoungChampionKingConfig:getWarZoneCfgs(actId)
	return self._warZoneCfgs[actId] or {}
end

function YoungChampionKingConfig:getWarZoneCfg(actId, areaId)
	local cfgs = self:getWarZoneCfgs(actId)

	for _, cfg in pairs(cfgs) do
		if areaId >= cfg.areaIds[1] and areaId <= cfg.areaIds[2] then
			return cfg
		end
	end
end

function YoungChampionKingConfig:getGuessCfg(gussPlanId)
	return self._young_champion_king_guess[gussPlanId]
end

function YoungChampionKingConfig:getKnockoutGameCfg(actId, roundId)
	return self._knockoutGameCfgs[actId] and self._knockoutGameCfgs[actId][roundId]
end

function YoungChampionKingConfig:getSeasonDataList()
	return self._actCfg.dataList
end

YoungChampionKingConfig.instance = YoungChampionKingConfig.New()

return YoungChampionKingConfig
