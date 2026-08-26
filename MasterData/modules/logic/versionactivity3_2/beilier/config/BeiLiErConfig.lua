-- chunkname: @modules/logic/versionactivity3_2/beilier/config/BeiLiErConfig.lua

module("modules.logic.versionactivity3_2.beilier.config.BeiLiErConfig", package.seeall)

local BeiLiErConfig = class("BeiLiErConfig", BaseConfig)

BeiLiErConfig.ActId = VersionActivity3_2Enum.ActivityId.BeiLiEr

function BeiLiErConfig:reqConfigNames()
	return {
		"activity220_puzzlegame",
		"activity220_puzzleinfo",
		"activity220_episode",
		"activity220_task",
		"activity220_const"
	}
end

function BeiLiErConfig:onInit()
	self._taskDict = {}
	self._gameconfig = {}
	self._episodeconfig = {}
end

function BeiLiErConfig:onConfigLoaded(configName, configTable)
	if configName == "activity220_puzzlegame" then
		self._gameconfig = configTable
	elseif configName == "activity220_episode" then
		self._episodeconfig = configTable
	end
end

function BeiLiErConfig:getEpisodeCoList(activityId)
	if not self._episodeDict then
		self._episodeDict = {}

		for _, v in ipairs(lua_activity220_episode.configList) do
			self._episodeDict[v.activityId] = self._episodeDict[v.activityId] or {}

			table.insert(self._episodeDict[v.activityId], v)
		end
	end

	return self._episodeDict[activityId] or {}
end

function BeiLiErConfig:getBeiLiErEpisodeConfigById(activityId, episodeId)
	if episodeId and self._episodeconfig then
		return self._episodeconfig.configDict[activityId][episodeId]
	end
end

function BeiLiErConfig:getBeiLiErGameConfigById(gameId)
	if gameId and self._gameconfig then
		return self._gameconfig.configDict[gameId]
	end
end

function BeiLiErConfig:getBeiLiErGameConfigByIdAndLevelId(gameId, levelId)
	if gameId and self._gameconfig then
		return self._gameconfig.configDict[gameId][levelId]
	end
end

function BeiLiErConfig:getEpisodeCo(activityId, episodeId)
	local episodeCos = self:getEpisodeCoList(activityId)

	for _, v in pairs(episodeCos) do
		if v.episodeId == episodeId then
			return v
		end
	end
end

function BeiLiErConfig:getTaskByActId(activityId)
	local list = self._taskDict[activityId]

	if not list then
		list = {}

		for _, co in ipairs(lua_activity220_task.configList) do
			if co.activityId == activityId then
				table.insert(list, co)
			end
		end

		self._taskDict[activityId] = list
	end

	return list
end

function BeiLiErConfig:getStoryBefore(actId, episodeId)
	local cfg = self:getEpisodeCo(actId, episodeId)

	return cfg and cfg.storyBefore
end

function BeiLiErConfig:getStoryClear(actId, episodeId)
	local cfg = self:getEpisodeCo(actId, episodeId)

	return cfg and cfg.storyClear
end

function BeiLiErConfig:getConstValueNumber(id)
	local activityId = VersionActivity3_2Enum.ActivityId.BeiLiEr
	local activityConstConfig = lua_activity220_const.configDict[activityId]

	if activityConstConfig == nil then
		logError("activity211_const 没有找到对应的配置 activityId = " .. activityId)

		return nil
	end

	local constConfig = activityConstConfig[id]

	if constConfig == nil then
		logError("activity211_const 没有找到对应的配置 id = " .. id)

		return nil
	end

	return tonumber(constConfig.value)
end

function BeiLiErConfig:getConstValue(id)
	local activityId = VersionActivity3_2Enum.ActivityId.BeiLiEr
	local activityConstConfig = lua_activity220_const.configDict[activityId]

	if activityConstConfig == nil then
		logError("activity220_const 没有找到对应的配置 id = " .. id)
	end

	local constConfig = activityConstConfig[id]

	return constConfig.value, constConfig.value2
end

function BeiLiErConfig:getPlaceRange()
	return self:getConstValueNumber(BeiLiErEnum.PlaceRange)
end

function BeiLiErConfig:getTipRange()
	return self:getConstValueNumber(BeiLiErEnum.TipRange)
end

function BeiLiErConfig:getPuzzleConfigById(id)
	return activity220_puzzleinfo.configDict[id]
end

BeiLiErConfig.instance = BeiLiErConfig.New()

return BeiLiErConfig
