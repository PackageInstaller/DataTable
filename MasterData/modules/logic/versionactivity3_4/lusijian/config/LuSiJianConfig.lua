-- chunkname: @modules/logic/versionactivity3_4/lusijian/config/LuSiJianConfig.lua

module("modules.logic.versionactivity3_4.lusijian.config.LuSiJianConfig", package.seeall)

local LuSiJianConfig = class("LuSiJianConfig", BaseConfig)

LuSiJianConfig._ActivityDataName = "T_lua_YeShuMei_ActivityData"
LuSiJianConfig.ActId = VersionActivity3_4Enum.ActivityId.LuSiJian

function LuSiJianConfig:reqConfigNames()
	return {
		"activity220_episode",
		"activity220_task",
		"activity220_const",
		"activity220_lsj_game",
		"activity220_lsj_const"
	}
end

function LuSiJianConfig:onInit()
	self._taskDict = {}
	self._gameconfig = {}
	self._episodeconfig = {}
end

function LuSiJianConfig:onConfigLoaded(configName, configTable)
	if configName == "activity220_lsj_game" then
		self._gameconfig = configTable
	elseif configName == "activity220_episode" then
		self._episodeconfig = configTable
	end
end

function LuSiJianConfig:getEpisodeCoList(activityId)
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

function LuSiJianConfig:_initGameIdList()
	if next(self._episodeDict) then
		self._gameIdList = {}

		for key, value in pairs(self._episodeDict) do
			if value.gameId ~= 0 then
				table.insert(self._gameIdList, value.gameId)
			end
		end
	end
end

function LuSiJianConfig:getIndexInGameIdList(gameId)
	if not self._gameIdList or #self._gameIdList == 0 then
		return
	end

	return tabletool.indexOf(self._gameIdList, gameId)
end

function LuSiJianConfig:getLuSiJianEpisodeConfigById(activityId, episodeId)
	if episodeId and self._episodeconfig then
		return self._episodeconfig.configDict[activityId][episodeId]
	end
end

function LuSiJianConfig:getLuSiJianGameConfigById(gameId)
	if gameId and self._gameconfig then
		return self._gameconfig.configDict[gameId]
	end
end

function LuSiJianConfig:getLuSiJianGameConfigByIdAndLevelId(gameId, levelId)
	if gameId and self._gameconfig then
		return self._gameconfig.configDict[gameId][levelId]
	end
end

function LuSiJianConfig:getEpisodeCo(activityId, episodeId)
	local episodeCos = self:getEpisodeCoList(activityId)

	for _, v in pairs(episodeCos) do
		if v.episodeId == episodeId then
			return v
		end
	end
end

function LuSiJianConfig:getTaskByActId(activityId)
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

function LuSiJianConfig:getStoryBefore(actId, episodeId)
	local cfg = self:getEpisodeCo(actId, episodeId)

	return cfg and cfg.storyBefore
end

function LuSiJianConfig:getStoryClear(actId, episodeId)
	local cfg = self:getEpisodeCo(actId, episodeId)

	return cfg and cfg.storyClear
end

function LuSiJianConfig:getConstValueNumber(id)
	local activityId = LuSiJianConfig.ActId
	local activityConstConfig = activity220_lsj_const.configDict[activityId]

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

function LuSiJianConfig:getConstValue(id)
	local activityId = LuSiJianConfig.ActId
	local activityConstConfig = activity220_lsj_const.configDict[activityId]

	if activityConstConfig == nil then
		logError("activity220_const 没有找到对应的配置 id = " .. id)
	end

	local constConfig = activityConstConfig[id]

	return constConfig.value, constConfig.value2
end

function LuSiJianConfig:getPlaceRange()
	return self:getConstValueNumber(LuSiJianEnum.ConnectRange)
end

function LuSiJianConfig:_initLuSiJianLevelData()
	self._luSiJianLevelData = {}

	if _G[self._ActivityDataName] == nil then
		return
	end

	for i = 1, #T_lua_YeShuMei_ActivityData do
		local data = _G[self._ActivityDataName][i]
		local levelDataMo = LuSiJianLevelMo.New()

		levelDataMo:init(data)

		self._luSiJianLevelData[data.id] = levelDataMo
	end
end

function LuSiJianConfig:getLuSiJianLevelData()
	if self._luSiJianLevelData == nil then
		self:_initLuSiJianLevelData()
	end

	return self._luSiJianLevelData
end

function LuSiJianConfig:getLuSiJianLevelDataByLevelId(id)
	if self._luSiJianLevelData == nil then
		self:_initLuSiJianLevelData()
	end

	return self._luSiJianLevelData[id]
end

LuSiJianConfig.instance = LuSiJianConfig.New()

return LuSiJianConfig
