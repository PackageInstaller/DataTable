-- chunkname: @modules/logic/endofdream/config/EndOfDreamConfig.lua

module("modules.logic.endofdream.config.EndOfDreamConfig", package.seeall)

local EndOfDreamConfig = class("EndOfDreamConfig", BaseConfig)

function EndOfDreamConfig:ctor()
	self._levelConfig = nil
	self._episodeConfig = nil
end

function EndOfDreamConfig:reqConfigNames()
	return
end

function EndOfDreamConfig:onConfigLoaded(configName, configTable)
	return
end

function EndOfDreamConfig:getLevelConfig(levelId)
	return self._levelConfig.configDict[levelId]
end

function EndOfDreamConfig:getLevelConfigList()
	return self._levelConfig.configList
end

function EndOfDreamConfig:getLevelConfigByEpisodeId(episodeId)
	local levelConfigList = self:getLevelConfigList()

	for i, levelConfig in ipairs(levelConfigList) do
		if levelConfig.episodeId == episodeId then
			return levelConfig, false
		elseif levelConfig.hardEpisodeId == episodeId then
			return levelConfig, true
		end
	end
end

function EndOfDreamConfig:getFirstLevelConfig()
	local levelConfigList = self:getLevelConfigList()

	return levelConfigList[1]
end

function EndOfDreamConfig:getEpisodeConfig(episodeId)
	return
end

function EndOfDreamConfig:getEpisodeConfigByLevelId(levelId, isHard)
	local levelConfig = self:getLevelConfig(levelId)

	return levelConfig and levelConfig.hardEpisodeId
end

EndOfDreamConfig.instance = EndOfDreamConfig.New()

return EndOfDreamConfig
