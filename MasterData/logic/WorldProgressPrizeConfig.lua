-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldprogressprize/config/WorldProgressPrizeConfig.lua

module("logic.extensions.worldprogressprize.config.WorldProgressPrizeConfig", package.seeall)

local WorldProgressPrizeConfig = class("WorldProgressPrizeConfig", BaseConfig)

function WorldProgressPrizeConfig:onInit()
	WorldProgressPrizeConfig.super.onInit(self)
end

function WorldProgressPrizeConfig:getNames()
	return {
		"world_progress_activity",
		"world_progress_tab",
		"world_progress_prize"
	}
end

function WorldProgressPrizeConfig:handleConfig(name, content)
	if name == "world_progress_activity" then
		self._world_progress_activity = content
	elseif name == "world_progress_tab" then
		self._world_progress_tab = content
	elseif name == "world_progress_prize" then
		self._world_progress_prize = content
	end
end

function WorldProgressPrizeConfig:getActData(activityId)
	return self._world_progress_activity[activityId]
end

function WorldProgressPrizeConfig:getTabCfg(activityId)
	return self._world_progress_tab[activityId]
end

function WorldProgressPrizeConfig:getTabData(activityId, progressId)
	if self._world_progress_tab[activityId] then
		return self._world_progress_tab[activityId][progressId]
	end
end

function WorldProgressPrizeConfig:getPrizeCfg(activityId, progressId)
	local data = self:getTabData(activityId, progressId)

	if data then
		if not data.prizePlanId then
			local prizePlanId = 0

			return self._world_progress_prize[prizePlanId]
		end
	end
end

function WorldProgressPrizeConfig:getPrizeData(activityId, progressId, prizeId)
	local cfg = self:getPrizeCfg(activityId, progressId)

	if cfg then
		return cfg[prizeId]
	end
end

function WorldProgressPrizeConfig:getPrizeDataByProgress(activityId, progressId, progress)
	local result
	local cfg = self:getPrizeCfg(activityId, progressId)

	if cfg then
		local low, high = 1, #cfg

		while low <= high do
			local mid = math.floor((low + high) / 2)

			if progress >= checknumber(cfg[mid].needProgress) then
				result = cfg[mid]
				low = mid + 1
			else
				high = mid - 1
			end
		end
	end

	return result
end

WorldProgressPrizeConfig.instance = WorldProgressPrizeConfig.New()

return WorldProgressPrizeConfig
