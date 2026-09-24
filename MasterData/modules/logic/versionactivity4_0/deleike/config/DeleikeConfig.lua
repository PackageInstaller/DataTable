-- chunkname: @modules/logic/versionactivity4_0/deleike/config/DeleikeConfig.lua

module("modules.logic.versionactivity4_0.deleike.config.DeleikeConfig", package.seeall)

local DeleikeConfig = class("DeleikeConfig", BaseConfig)

function DeleikeConfig:reqConfigNames()
	return {
		"activity220_deleike"
	}
end

function DeleikeConfig:onConfigLoaded(configName, configTable)
	if configName == "activity220_deleike" then
		self.gameCfgTbl = configTable
		self.mapCoDict = {}

		for _, v in ipairs(self.gameCfgTbl.configList) do
			local mapData = cjson.decode(v.mapJson)
			local mapCo = DeleikeMapCo.New()

			mapCo:init(mapData)

			self.mapCoDict[mapCo.id] = mapCo
		end
	end
end

function DeleikeConfig:getGameConfig(gameId)
	local gameCfg = self.gameCfgTbl.configDict[gameId]
	local mapCfg = self.mapCoDict[gameId]

	if gameCfg and mapCfg then
		return gameCfg, mapCfg
	else
		logError("Deleike游戏配置错误 gameId: " .. gameId)
	end
end

function DeleikeConfig:getEpisodeConfig(episodeId)
	local actId = DeleikeController.instance:getActId()

	return Activity220Config.instance:getEpisodeConfig(actId, episodeId)
end

function DeleikeConfig:getEpisodeConfigList()
	local actId = DeleikeController.instance:getActId()

	return Activity220Config.instance:getEpisodeConfigList(actId)
end

function DeleikeConfig:getEpisodeIndex(episodeId)
	local actId = DeleikeController.instance:getActId()

	return Activity220Config.instance:getEpisodeIndex(actId, episodeId)
end

function DeleikeConfig:getEpisodeIdByGameId(gameId)
	local actId = DeleikeController.instance:getActId()
	local configList = Activity220Config.instance:getEpisodeConfigList(actId)

	for _, v in ipairs(configList) do
		if v.gameId == gameId then
			return v.episodeId
		end
	end
end

DeleikeConfig.instance = DeleikeConfig.New()

return DeleikeConfig
