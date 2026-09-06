-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/config/TourArenaGameConfig.lua

module("logic.extensions.tourarena.config.TourArenaGameConfig", package.seeall)

local TourArenaGameConfig = class("TourArenaGameConfig", BaseConfig)

function TourArenaGameConfig:onInit()
	TourArenaGameConfig.super.onInit(self)
end

function TourArenaGameConfig:getNames()
	return {
		"tour_arena_game_activity",
		"tour_arena_game_client_common",
		"tour_arena_game_prize",
		"tour_arena_game",
		"tour_arena_game_stage",
		"tour_arena_game_progress",
		"tour_arena_game_total_rank",
		"tour_arena_game_rank_prize"
	}
end

function TourArenaGameConfig:handleConfig(name, content)
	if name == "tour_arena_game_activity" then
		self._tagActCfg = content
	elseif name == "tour_arena_game_client_common" then
		self._clientCommonCfg = content
	elseif name == "tour_arena_game_prize" then
		self._tagPrizeCfgs = content
	elseif name == "tour_arena_game" then
		self._tagGameCfgs = content
	elseif name == "tour_arena_game_stage" then
		self._tagStageCfgss = content
	elseif name == "tour_arena_game_progress" then
		self._tagProgressCfgs = content
	elseif name == "tour_arena_game_total_rank" then
		self._tagTotalRankCfgs = content
	elseif name == "tour_arena_game_rank_prize" then
		self._tagRankPrizeCfgs = content
	end
end

function TourArenaGameConfig:getTagActData(activityId)
	return self._tagActCfg[activityId]
end

function TourArenaGameConfig:getClientCommonValue(activityId, key, isToNumber)
	local baseData = self:getTagActData(activityId)

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

function TourArenaGameConfig:getTagPrizeCfg(activityId)
	return self._tagPrizeCfgs[activityId]
end

function TourArenaGameConfig:getTagPrizeData(activityId, prizeId)
	if self._tagPrizeCfgs[activityId] then
		return self._tagPrizeCfgs[activityId][prizeId]
	end
end

function TourArenaGameConfig:getTagGameCfg(activityId)
	return self._tagGameCfgs[activityId]
end

function TourArenaGameConfig:getTagGameData(activityId, gameId)
	if self._tagGameCfgs[activityId] then
		return self._tagGameCfgs[activityId][gameId]
	end
end

function TourArenaGameConfig:getTagStageCfgs(activityId)
	return self._tagStageCfgss[activityId]
end

function TourArenaGameConfig:getTagStageCfg(activityId, gameId)
	if self._tagStageCfgss[activityId] then
		return self._tagStageCfgss[activityId][gameId]
	end
end

function TourArenaGameConfig:getTagStageData(activityId, gameId, stageId)
	if self._tagStageCfgss[activityId] and self._tagStageCfgss[activityId][gameId] then
		return self._tagStageCfgss[activityId][gameId][stageId]
	end
end

function TourArenaGameConfig:getTagProgressDataByScore(progressPlanId, gameScore)
	local result
	local cfg = self:getTagProgressCfg(progressPlanId)

	if cfg then
		local leftData, rightData = cfg[1], cfg[#cfg]
		local leftScore, rightScore = leftData.gameScore, rightData.gameScore

		if leftScore < rightScore then
			if gameScore < leftScore then
				result = leftData
			elseif rightScore < gameScore then
				result = rightData
			end
		elseif rightScore < leftScore then
			if leftScore < gameScore then
				result = leftData
			elseif gameScore < rightScore then
				result = rightData
			end
		else
			result = leftData
		end

		if result == nil then
			local last, next = 0, 0
			local length = #cfg

			for i = 1, length do
				local lastData = cfg[i]
				local nextData = cfg[Mathf.Min(i + 1, length)]

				if lastData.gameScore < gameScore and gameScore < nextData.gameScore or gameScore < lastData.gameScore and nextData.gameScore < gameScore then
					result = lastData

					break
				elseif lastData.gameScore == gameScore then
					result = lastData

					break
				elseif nextData.gameScore == gameScore then
					result = nextData

					break
				end
			end
		end
	end

	return result
end

function TourArenaGameConfig:getTagProgressCfg(progressPlanId)
	return self._tagProgressCfgs[progressPlanId]
end

function TourArenaGameConfig:getTagProgressData(progressPlanId, progressIdx)
	if self._tagProgressCfgs[progressPlanId] then
		return self._tagProgressCfgs[progressPlanId][progressIdx]
	end
end

function TourArenaGameConfig:getTagTotalRankCfg(activityId, zoneId)
	if self._tagTotalRankCfgs[activityId] then
		return self._tagTotalRankCfgs[activityId][zoneId]
	end
end

function TourArenaGameConfig:getTagTotalRankData(activityId, zoneId, rankId)
	if self._tagTotalRankCfgs[activityId] and self._tagTotalRankCfgs[activityId][zoneId] then
		return self._tagTotalRankCfgs[activityId][zoneId][rankId]
	end
end

function TourArenaGameConfig:getTagTotalRankDataByRank(activityId, zoneId, rank)
	local result
	local cfg = self:getTagTotalRankCfg(activityId, zoneId)

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

function TourArenaGameConfig:getTagRankPrizeCfg(activityId)
	return self._tagRankPrizeCfgs[activityId]
end

function TourArenaGameConfig:getTagRankPrizeData(activityId, rankId)
	if self._tagRankPrizeCfgs[activityId] then
		return self._tagRankPrizeCfgs[activityId][rankId]
	end
end

function TourArenaGameConfig:getTagRankPrizeDataByRank(activityId, rank)
	local result
	local cfg = self:getTagRankPrizeCfg(activityId)

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

TourArenaGameConfig.instance = TourArenaGameConfig.New()

return TourArenaGameConfig
