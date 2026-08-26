-- chunkname: @modules/logic/versionactivity3_5/lorentz/config/LorentzConfig.lua

module("modules.logic.versionactivity3_5.lorentz.config.LorentzConfig", package.seeall)

local LorentzConfig = class("LorentzConfig", BaseConfig)

LorentzConfig.ActId = VersionActivity3_5Enum.ActivityId.Lorentz

function LorentzConfig:reqConfigNames()
	return {
		"activity220_puzzlegame",
		"activity220_puzzleinfo",
		"activity220_episode",
		"activity220_task",
		"activity220_const"
	}
end

function LorentzConfig:onInit()
	self._taskDict = {}
	self._gameconfig = {}
	self._episodeconfig = {}
end

function LorentzConfig:onConfigLoaded(configName, configTable)
	if configName == "activity220_puzzlegame" then
		self._gameconfig = configTable
	elseif configName == "activity220_episode" then
		self._episodeconfig = configTable
	end
end

function LorentzConfig:getEpisodeCoList(activityId)
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

function LorentzConfig:_initGameIdList()
	if next(self._episodeDict) then
		self._gameIdList = {}

		for key, value in pairs(self._episodeDict) do
			if value.gameId ~= 0 then
				table.insert(self._gameIdList, value.gameId)
			end
		end
	end
end

function LorentzConfig:getIndexInGameIdList(gameId)
	if not self._gameIdList or #self._gameIdList == 0 then
		return
	end

	return tabletool.indexOf(self._gameIdList, gameId)
end

function LorentzConfig:getLorentzEpisodeConfigById(activityId, episodeId)
	if episodeId and self._episodeconfig then
		return self._episodeconfig.configDict[activityId][episodeId]
	end
end

function LorentzConfig:getLorentzGameConfigById(gameId)
	if gameId and self._gameconfig then
		return self._gameconfig.configDict[gameId]
	end
end

function LorentzConfig:getLorentzGameConfigByIdAndLevelId(gameId, levelId)
	if gameId and self._gameconfig then
		return self._gameconfig.configDict[gameId][levelId]
	end
end

function LorentzConfig:getEpisodeCo(activityId, episodeId)
	local episodeCos = self:getEpisodeCoList(activityId)

	for _, v in pairs(episodeCos) do
		if v.episodeId == episodeId then
			return v
		end
	end
end

function LorentzConfig:getTaskByActId(activityId)
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

function LorentzConfig:getStoryBefore(actId, episodeId)
	local cfg = self:getEpisodeCo(actId, episodeId)

	return cfg and cfg.storyBefore
end

function LorentzConfig:getStoryClear(actId, episodeId)
	local cfg = self:getEpisodeCo(actId, episodeId)

	return cfg and cfg.storyClear
end

function LorentzConfig:getConstValueNumber(id)
	local activityId = VersionActivity3_5Enum.ActivityId.Lorentz
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

function LorentzConfig:getConstValue(id)
	local activityId = VersionActivity3_5Enum.ActivityId.Lorentz
	local activityConstConfig = lua_activity220_const.configDict[activityId]

	if activityConstConfig == nil then
		logError("activity220_const 没有找到对应的配置 id = " .. id)
	end

	local constConfig = activityConstConfig[id]

	return constConfig.value, constConfig.value2
end

function LorentzConfig:getPlaceRange()
	return self:getConstValueNumber(LorentzEnum.PlaceRange)
end

function LorentzConfig:getTipRange()
	return self:getConstValueNumber(LorentzEnum.TipRange)
end

function LorentzConfig:getPuzzleConfigById(id)
	return activity220_puzzleinfo.configDict[id]
end

LorentzConfig.instance = LorentzConfig.New()

return LorentzConfig
