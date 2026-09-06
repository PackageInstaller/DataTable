-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingarena/config/KingArenaConfig.lua

module("logic.extensions.kingarena.config.KingArenaConfig", package.seeall)

local KingArenaConfig = class("KingArenaConfig", BaseConfig)

function KingArenaConfig:onInit()
	KingArenaConfig.super.onInit(self)
end

function KingArenaConfig:getNames()
	return {
		"king_arena_season",
		"king_arena_common",
		"king_arena_period",
		"king_arena_zone",
		"king_arena_select_cost",
		"king_arena_op_range",
		"king_arena_creeps_master",
		"king_arena_creeps",
		"king_arena_buy_fight_times",
		"king_arena_rank_prize",
		"king_arena_best_rank_prize",
		"king_arena_zdl_ratio"
	}
end

function KingArenaConfig:handleConfig(name, content)
	if name == "king_arena_season" then
		self._king_arena_season = content
	elseif name == "king_arena_common" then
		self._king_arena_common = content
	elseif name == "king_arena_period" then
		self._king_arena_period = content
	elseif name == "king_arena_zone" then
		self._king_arena_zone = content
	elseif name == "king_arena_select_cost" then
		self._king_arena_select_cost = content
	elseif name == "king_arena_op_range" then
		self._king_arena_op_range = content
	elseif name == "king_arena_creeps_master" then
		self._king_arena_creeps_master = content
	elseif name == "king_arena_creeps" then
		self._king_arena_creeps = content
	elseif name == "king_arena_buy_fight_times" then
		self._king_arena_buy_fight_times = content
	elseif name == "king_arena_rank_prize" then
		self._king_arena_rank_prize = content
	elseif name == "king_arena_best_rank_prize" then
		self._king_arena_best_rank_prize = content
	elseif name == "king_arena_zdl_ratio" then
		self._king_arena_zdl_ratio = content
	end
end

function KingArenaConfig:getSeasonDataList()
	return self._king_arena_season.dataList
end

function KingArenaConfig:getSeasonData(seasonId)
	return self._king_arena_season[seasonId]
end

function KingArenaConfig:getCommonValue(key, isToNumber)
	local data = self._king_arena_common[key]
	local value = data and data.value

	return isToNumber and checknumber(value) or value
end

function KingArenaConfig:getPeriodCfg(seasonId)
	return self._king_arena_period[seasonId]
end

function KingArenaConfig:getPeriodData(seasonId, periodId)
	if self._king_arena_period[seasonId] then
		return self._king_arena_period[seasonId][periodId]
	end
end

function KingArenaConfig:getZoneCfg(seasonId)
	local seasonData = self:getSeasonData(seasonId)

	if seasonData then
		if not seasonData.zonePlanId then
			local zonePlanId = 0

			return self._king_arena_zone[zonePlanId]
		end
	end
end

function KingArenaConfig:getZoneData(seasonId, zoneId)
	local cfg = self:getZoneCfg(seasonId)

	return cfg and cfg[zoneId]
end

function KingArenaConfig:getSelectCostCfg(seasonId)
	local data = self:getSeasonData(seasonId)

	if data then
		if not data.selectCostPlanId then
			local selectCostPlanId = 0

			return self._king_arena_select_cost[selectCostPlanId]
		end
	end
end

function KingArenaConfig:getSelectCostData(seasonId, times)
	local data
	local cfg = self:getSelectCostCfg(seasonId)

	if cfg then
		for i, v in ipairs(cfg) do
			if times >= v.times then
				data = v
			else
				break
			end
		end
	end

	return data
end

function KingArenaConfig:getMaxSelectCostTimes(seasonId)
	local cfg = self:getSelectCostCfg(seasonId)
	local maxData = cfg and cfg[#cfg]

	return (maxData or nil) and (maxData.times or 0)
end

function KingArenaConfig:getOpRangeCfg(seasonId)
	local data = self:getSeasonData(seasonId)

	if data then
		if not data.opRangePlanId then
			local opRangePlanId = 0

			return self._king_arena_op_range[opRangePlanId]
		end
	end
end

function KingArenaConfig:getOpRangeData(seasonId, rank)
	local data
	local cfg = self:getOpRangeCfg(seasonId)

	if cfg then
		for i, v in ipairs(cfg) do
			if rank >= v.rank[1] and rank <= v.rank[2] then
				data = v

				break
			end
		end
	end

	return data
end

function KingArenaConfig:getMasterData(creepsMasterId)
	return self._king_arena_creeps_master[creepsMasterId]
end

function KingArenaConfig:getCreepsCfg(creepsMasterId)
	return self._king_arena_creeps[creepsMasterId]
end

function KingArenaConfig:getCreepsData(creepsMasterId, creepsId)
	if self._king_arena_creeps[creepsMasterId] then
		return self._king_arena_creeps[creepsMasterId][creepsId]
	end
end

function KingArenaConfig:getBuyFightTimesCfg(seasonId)
	local seasonData = self:getSeasonData(seasonId)

	if seasonData then
		if not seasonData.buyFightTimePlanId then
			local buyFightTimePlanId = 0

			return self._king_arena_buy_fight_times[buyFightTimePlanId]
		end
	end
end

function KingArenaConfig:getBuyFightTimesData(seasonId, times)
	local data
	local cfg = self:getBuyFightTimesCfg(seasonId)

	if cfg then
		for i, v in ipairs(cfg) do
			if times >= v.times then
				data = v
			else
				break
			end
		end
	end

	return data
end

function KingArenaConfig:getMaxBuyFightTimes(seasonId)
	local cfg = self:getBuyFightTimesCfg(seasonId)
	local maxData = cfg and cfg[#cfg]

	return (maxData or nil) and (maxData.times or 0)
end

function KingArenaConfig:getCostMatsWithBuyTimes(seasonId, startTimes, endTimes)
	local matArray = {}
	local cfg = self:getBuyFightTimesCfg(seasonId)

	if cfg then
		for i, v in ipairs(cfg) do
			if startTimes <= v.times and endTimes >= v.times then
				local matStr = v.cost
				local matType, matId, matNum = MaterialMgr.getMatParams(matStr)
				local matKey = string.format("%s:%s", matType, matId)

				matArray[matKey] = (matArray[matKey] or 0) + matNum
			end
		end
	end

	return matArray
end

function KingArenaConfig:getRankPrizeCfg(seasonId, zoneId)
	local data = self:getZoneData(seasonId, zoneId)

	if data then
		if not data.rankPrizePlanId then
			local rankPrizePlanId = 0

			return self._king_arena_rank_prize[rankPrizePlanId]
		end
	end
end

function KingArenaConfig:getRankPrizeData(seasonId, zoneId, rank)
	local data
	local cfg = self:getRankPrizeCfg(seasonId, zoneId)

	if cfg then
		for i, v in ipairs(cfg) do
			if rank >= v.range[1] and rank <= v.range[2] then
				data = v

				break
			end
		end
	end

	return data
end

function KingArenaConfig:getBestRankPrizeCfg(seasonId)
	local data = self:getSeasonData(seasonId)

	if data then
		if not data.bestRankPrizePlanId then
			local bestRankPrizePlanId = 0

			return self._king_arena_best_rank_prize[bestRankPrizePlanId]
		end
	end
end

function KingArenaConfig:getBestRankPrizeDataById(seasonId, rankPrizeId)
	local cfg = self:getBestRankPrizeCfg(seasonId)

	return cfg and cfg[rankPrizeId]
end

function KingArenaConfig:getBestRankPrizeData(seasonId, rank)
	local data
	local cfg = self:getBestRankPrizeCfg(seasonId)

	if cfg then
		for i, v in ipairs(cfg) do
			if rank >= v.range[1] and rank <= v.range[2] then
				data = v

				break
			end
		end
	end

	return data
end

function KingArenaConfig:getZdlRatioData(myRank)
	local data
	local cfg = self._king_arena_zdl_ratio.dataList

	if cfg then
		for i, v in ipairs(cfg) do
			if myRank >= v.beginRank then
				data = v
			else
				break
			end
		end
	end

	return data
end

KingArenaConfig.instance = KingArenaConfig.New()

return KingArenaConfig
