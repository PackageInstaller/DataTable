-- chunkname: @modules/logic/versionactivity3_7/xruianyi/config/XRuiAnYiConfig.lua

module("modules.logic.versionactivity3_7.xruianyi.config.XRuiAnYiConfig", package.seeall)

local XRuiAnYiConfig = class("XRuiAnYiConfig", BaseConfig)

XRuiAnYiConfig.ActId = VersionActivity3_7Enum.ActivityId.XRuiAnYi

function XRuiAnYiConfig:reqConfigNames()
	return {
		"activity220_episode",
		"activity220_task",
		"activity220_const"
	}
end

function XRuiAnYiConfig:onInit()
	self._taskDict = {}
	self._episodeconfig = {}
end

function XRuiAnYiConfig:onConfigLoaded(configName, configTable)
	if configName == "activity220_episode" then
		self._episodeconfig = configTable
	end
end

function XRuiAnYiConfig:getEpisodeCoList(activityId)
	if not self._episodeDict then
		self._episodeDict = {}

		local dict = {}

		for _, v in ipairs(lua_activity220_episode.configList) do
			dict[v.activityId] = dict[v.activityId] or {}

			table.insert(dict[v.activityId], v)
		end

		self._episodeDict = dict[activityId]

		self:_initGameIdList()
	end

	return self._episodeDict or {}
end

function XRuiAnYiConfig:_initGameIdList()
	if next(self._episodeDict) then
		self._gameIdList = {}

		for key, value in pairs(self._episodeDict) do
			if value.gameId ~= 0 then
				table.insert(self._gameIdList, value.gameId)
			end
		end
	end
end

function XRuiAnYiConfig:getIndexInGameIdList(gameId)
	if not self._gameIdList or #self._gameIdList == 0 then
		return
	end

	return tabletool.indexOf(self._gameIdList, gameId)
end

function XRuiAnYiConfig:getEpisodeConfigById(activityId, episodeId)
	if episodeId and self._episodeconfig then
		return self._episodeconfig.configDict[activityId][episodeId]
	end
end

function XRuiAnYiConfig:getEpisodeCo(activityId, episodeId)
	local episodeCos = self:getEpisodeCoList(activityId)

	for _, v in pairs(episodeCos) do
		if v.episodeId == episodeId then
			return v
		end
	end
end

function XRuiAnYiConfig:getTaskByActId(activityId)
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

function XRuiAnYiConfig:getStoryBefore(actId, episodeId)
	local cfg = self:getEpisodeCo(actId, episodeId)

	return cfg and cfg.storyBefore
end

function XRuiAnYiConfig:getStoryClear(actId, episodeId)
	local cfg = self:getEpisodeCo(actId, episodeId)

	return cfg and cfg.storyClear
end

function XRuiAnYiConfig:getConstValueNumber(id)
	local activityId = VersionActivity3_7Enum.ActivityId.XRuiAnYi
	local activityConstConfig = lua_activity220_const.configDict[activityId]

	if activityConstConfig == nil then
		logError("activity220_const 没有找到对应的配置 activityId = " .. activityId)

		return nil
	end

	local constConfig = activityConstConfig[id]

	if constConfig == nil then
		logError("activity220_const 没有找到对应的配置 id = " .. id)

		return nil
	end

	return tonumber(constConfig.value)
end

function XRuiAnYiConfig:getConstValue(id)
	local activityId = VersionActivity3_7Enum.ActivityId.XRuiAnYi
	local activityConstConfig = lua_activity220_const.configDict[activityId]

	if activityConstConfig == nil then
		logError("activity220_const 没有找到对应的配置 id = " .. id)
	end

	local constConfig = activityConstConfig[id]

	return constConfig.value, constConfig.value2
end

XRuiAnYiConfig.instance = XRuiAnYiConfig.New()

return XRuiAnYiConfig
