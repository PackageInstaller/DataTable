-- chunkname: @modules/logic/versionactivity3_1/yeshumei/config/YeShuMeiConfig.lua

module("modules.logic.versionactivity3_1.yeshumei.config.YeShuMeiConfig", package.seeall)

local YeShuMeiConfig = class("YeShuMeiConfig", BaseConfig)

YeShuMeiConfig._ActivityDataName = "T_lua_YeShuMei_ActivityData"

function YeShuMeiConfig:reqConfigNames()
	return {
		"activity211_game",
		"activity211_episode",
		"activity211_task",
		"activity211_const"
	}
end

function YeShuMeiConfig:onInit()
	self._taskDict = {}
	self._gameconfig = {}
	self._episodeconfig = {}
end

function YeShuMeiConfig:onConfigLoaded(configName, configTable)
	if configName == "activity211_game" then
		self._gameconfig = configTable
	elseif configName == "activity211_episode" then
		self._episodeconfig = configTable
	end
end

function YeShuMeiConfig:_initYeShuMeiLevelData()
	self._yeShuMeiLevelData = {}

	if _G[self._ActivityDataName] == nil then
		return
	end

	for i = 1, #T_lua_YeShuMei_ActivityData do
		local data = _G[self._ActivityDataName][i]
		local levelDataMo = YeShuMeiLevelMo.New()

		levelDataMo:init(data)

		self._yeShuMeiLevelData[data.id] = levelDataMo
	end
end

function YeShuMeiConfig:getYeShuMeiLevelData()
	if self._yeShuMeiLevelData == nil then
		self:_initYeShuMeiLevelData()
	end

	return self._yeShuMeiLevelData
end

function YeShuMeiConfig:getYeShuMeiLevelDataByLevelId(id)
	if self._yeShuMeiLevelData == nil then
		self:_initYeShuMeiLevelData()
	end

	return self._yeShuMeiLevelData[id]
end

function YeShuMeiConfig:getEpisodeCoList(activityId)
	if not self._episodeDict then
		self._episodeDict = {}

		for _, v in ipairs(lua_activity211_episode.configList) do
			self._episodeDict[v.activityId] = self._episodeDict[v.activityId] or {}

			table.insert(self._episodeDict[v.activityId], v)
		end
	end

	return self._episodeDict[activityId] or {}
end

function YeShuMeiConfig:getYeShuMeiEpisodeConfigById(activityId, episodeId)
	if episodeId and self._episodeconfig then
		return self._episodeconfig.configDict[activityId][episodeId]
	end
end

function YeShuMeiConfig:getYeShuMeiGameConfigById(gameId)
	if gameId and self._gameconfig then
		return self._gameconfig.configDict[gameId]
	end
end

function YeShuMeiConfig:getEpisodeCo(activityId, episodeId)
	local episodeCos = self:getEpisodeCoList(activityId)

	for _, v in pairs(episodeCos) do
		if v.episodeId == episodeId then
			return v
		end
	end
end

function YeShuMeiConfig:getTaskByActId(activityId)
	local list = self._taskDict[activityId]

	if not list then
		list = {}

		for _, co in ipairs(lua_activity211_task.configList) do
			if co.activityId == activityId then
				table.insert(list, co)
			end
		end

		self._taskDict[activityId] = list
	end

	return list
end

function YeShuMeiConfig:getStoryBefore(actId, episodeId)
	local cfg = self:getEpisodeCo(actId, episodeId)

	return cfg and cfg.storyBefore
end

function YeShuMeiConfig:getStoryClear(actId, episodeId)
	local cfg = self:getEpisodeCo(actId, episodeId)

	return cfg and cfg.storyClear
end

function YeShuMeiConfig:getConstValueNumber(id)
	local activityId = VersionActivity3_1Enum.ActivityId.YeShuMei
	local activityConstConfig = lua_activity211_const.configDict[activityId]

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

function YeShuMeiConfig:getConstValue(id)
	local activityId = VersionActivity3_1Enum.ActivityId.YeShuMei
	local activityConstConfig = lua_activity211_const.configDict[activityId]

	if activityConstConfig == nil then
		logError("activity211_const 没有找到对应的配置 id = " .. id)
	end

	local constConfig = activityConstConfig[id]

	return constConfig.value, constConfig.value2
end

function YeShuMeiConfig:getDragSureRange()
	return 50
end

YeShuMeiConfig.instance = YeShuMeiConfig.New()

return YeShuMeiConfig
