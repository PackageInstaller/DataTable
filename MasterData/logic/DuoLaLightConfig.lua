-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolalight/config/DuoLaLightConfig.lua

module("logic.extensions.duolalight.config.DuoLaLightConfig", package.seeall)

local DuoLaLightConfig = class("DuoLaLightConfig", BaseConfig)

function DuoLaLightConfig:onInit()
	DuoLaLightConfig.super.onInit(self)
end

function DuoLaLightConfig:getNames()
	return {
		"duola_game_activity",
		"duola_game_difficulty",
		"duola_game_stage",
		"duola_game_map",
		"duola_game_buy_times",
		"duola_game_common"
	}
end

function DuoLaLightConfig:handleConfig(name, content)
	if name == "duola_game_activity" then
		self._dlBaseCfg = content
	elseif name == "duola_game_difficulty" then
		self._dlDiffCfgs = content
	elseif name == "duola_game_stage" then
		self._dlStageCfgs = content
	elseif name == "duola_game_map" then
		self._dlMapCfg = content
	elseif name == "duola_game_buy_times" then
		self._dlBuyCfgs = content
	elseif name == "duola_game_common" then
		self._dlCommonCfg = content
	end
end

function DuoLaLightConfig:getDlBaseData(activityId)
	return self._dlBaseCfg[activityId]
end

function DuoLaLightConfig:getDlDiffCfg(activityId)
	return self._dlDiffCfgs[activityId]
end

function DuoLaLightConfig:getDlDiffData(activityId, difficultyId)
	return self._dlDiffCfgs[activityId][difficultyId]
end

function DuoLaLightConfig:getDlStageCfg(activityId, difficultyId)
	return self._dlStageCfgs[activityId][difficultyId]
end

function DuoLaLightConfig:getDlStageData(activityId, difficultyId, gameId)
	return self._dlStageCfgs[activityId][difficultyId][gameId]
end

function DuoLaLightConfig:getDlMapCfg()
	return self._dlMapCfg
end

function DuoLaLightConfig:getDlMapData(mapId)
	return self._dlMapCfg[mapId]
end

function DuoLaLightConfig:getDlBuyCfg(activityId)
	return self._dlBuyCfgs[activityId]
end

function DuoLaLightConfig:getDlBuyData(activityId, times)
	return self._dlBuyCfgs[activityId][times]
end

function DuoLaLightConfig:getMaxDlBuyTimes(activityId)
	local maxTimes = 0
	local cfg = self:getDlBuyCfg(activityId)

	for _, data in ipairs(cfg) do
		if maxTimes < data.times then
			maxTimes = data.times
		end
	end

	return maxTimes
end

function DuoLaLightConfig:getDlCommonValue(activityId, key, isToNumber)
	local baseData = self:getDlBaseData(activityId)

	if baseData then
		if not baseData.comPlanId then
			local comPlanId = 0
			local data

			if self._dlCommonCfg[comPlanId] then
				data = self._dlCommonCfg[comPlanId][key]
			end

			local value = data and data.value

			if isToNumber then
				value = checknumber(value)
			end

			return value
		end
	end
end

DuoLaLightConfig.instance = DuoLaLightConfig.New()

return DuoLaLightConfig
