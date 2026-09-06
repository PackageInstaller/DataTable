-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/config/TourArenaFightConfig.lua

module("logic.extensions.tourarena.config.TourArenaFightConfig", package.seeall)

local TourArenaFightConfig = class("TourArenaFightConfig", BaseConfig)

function TourArenaFightConfig:onInit()
	TourArenaFightConfig.super.onInit(self)
end

function TourArenaFightConfig:getNames()
	return {
		"tour_arena_fight_activity",
		"tour_arena_fight_client_common",
		"tour_arena_fight_type",
		"tour_arena_fight_prize",
		"tour_arena_fight_rank",
		"tour_arena_fight_period_prize",
		"tour_arena_fight_period_rank"
	}
end

function TourArenaFightConfig:handleConfig(name, content)
	if name == "tour_arena_fight_activity" then
		self._tafActCfg = content
	elseif name == "tour_arena_fight_client_common" then
		self._clientCommonCfg = content
	elseif name == "tour_arena_fight_type" then
		self._tafTypecfg = content
	elseif name == "tour_arena_fight_prize" then
		self._tafPrizeCfgs = content
	elseif name == "tour_arena_fight_rank" then
		self._tafRankCfgs = content
	elseif name == "tour_arena_fight_period_prize" then
		self._tour_arena_fight_period_prize = content
	elseif name == "tour_arena_fight_period_rank" then
		self._tour_arena_fight_period_rank = content
		self._tafPeriodRankDataList = {}
	end
end

function TourArenaFightConfig:getTafActData(activityId)
	return self._tafActCfg[activityId]
end

function TourArenaFightConfig:getTafActDataList()
	return self._tafActCfg.dataList
end

function TourArenaFightConfig:getClientCommonValue(activityId, key, isToNumber)
	local baseData = self:getTafActData(activityId)

	if baseData then
		if not baseData.comPlanId then
			local comPlanId = 0

			if self._clientCommonCfg[comPlanId] then
				local data = self._clientCommonCfg[comPlanId][key]
				local value

				if data then
					value = data.value

					if isToNumber then
						value = checknumber(value)
					end
				end

				return value
			end
		end
	end
end

function TourArenaFightConfig:getTafTypeCfg(activityId)
	return self._tafTypecfg[activityId]
end

function TourArenaFightConfig:getTafTypeData(activityId, typeId)
	if self._tafTypecfg[activityId] then
		return self._tafTypecfg[activityId][typeId]
	end
end

function TourArenaFightConfig:getTafPrizeCfg(activityId)
	return self._tafPrizeCfgs[activityId]
end

function TourArenaFightConfig:getTafPrizeData(activityId, prizeId)
	if self._tafPrizeCfgs[activityId] then
		return self._tafPrizeCfgs[activityId][prizeId]
	end
end

function TourArenaFightConfig:getTafRankCfg(activityId, zoneId)
	if self._tafRankCfgs[activityId] then
		return self._tafRankCfgs[activityId][zoneId]
	end
end

function TourArenaFightConfig:getTafRankData(activityId, zoneId, rankId)
	if self._tafRankCfgs[activityId] and self._tafRankCfgs[activityId][zoneId] then
		return self._tafRankCfgs[activityId][zoneId][rankId]
	end
end

function TourArenaFightConfig:getTafRankDataByRank(activityId, zoneId, rank)
	local result
	local cfg = self:getTafRankCfg(activityId, zoneId)

	if cfg then
		for _, data in ipairs(cfg) do
			if rank >= data.startRank and rank <= data.endRank then
				result = data

				break
			end
		end
	end

	return result
end

function TourArenaFightConfig:getTafPeriodPrizeCfg(periodId)
	return self._tour_arena_fight_period_prize[periodId]
end

function TourArenaFightConfig:getTafPeriodPrizeData(periodId, prizeId)
	if self._tour_arena_fight_period_prize[periodId] then
		return self._tour_arena_fight_period_prize[periodId][prizeId]
	end
end

function TourArenaFightConfig:getTafPeriodRankCfg(periodId)
	return self._tour_arena_fight_period_rank[periodId]
end

function TourArenaFightConfig:getTafPeriodRankDataByRank(periodId, rank)
	local dataList = self._tafPeriodRankDataList[periodId]

	if dataList == nil then
		dataList = {}

		local cfg = self:getTafPeriodRankCfg(periodId)

		if cfg then
			for _, data in pairs(cfg) do
				table.insert(dataList, data)
			end
		end

		table.sort(dataList, function(a, b)
			return a.index < b.index
		end)

		self._tafPeriodRankDataList[periodId] = dataList
	end

	return MmUtil.binarySearchInArrayKey(dataList, "rankRange", rank)
end

TourArenaFightConfig.instance = TourArenaFightConfig.New()

return TourArenaFightConfig
