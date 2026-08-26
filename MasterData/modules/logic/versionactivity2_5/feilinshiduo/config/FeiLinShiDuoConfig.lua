-- chunkname: @modules/logic/versionactivity2_5/feilinshiduo/config/FeiLinShiDuoConfig.lua

module("modules.logic.versionactivity2_5.feilinshiduo.config.FeiLinShiDuoConfig", package.seeall)

local FeiLinShiDuoConfig = class("FeiLinShiDuoConfig", BaseConfig)

function FeiLinShiDuoConfig:ctor()
	self.taskDict = {}
end

function FeiLinShiDuoConfig:reqConfigNames()
	return {
		"activity185_episode",
		"activity185_task"
	}
end

function FeiLinShiDuoConfig:onConfigLoaded(configName, configTable)
	if configName == "activity185_episode" then
		self._episodeConfig = configTable

		self:buildStageMap()
	elseif configName == "activity185_task" then
		self._taskConfig = configTable
	end
end

function FeiLinShiDuoConfig:buildStageMap()
	self.stageMap = {}

	local curStageIndex = 0

	for index, episodeCo in ipairs(self._episodeConfig.configList) do
		if curStageIndex ~= episodeCo.stage then
			curStageIndex = episodeCo.stage
			self.stageMap[episodeCo.stage] = {}
		end

		self.stageMap[curStageIndex][episodeCo.episodeId] = episodeCo
	end
end

function FeiLinShiDuoConfig:getEpisodeConfig(activityId, episodeId)
	if not self._episodeConfig.configDict[activityId] and not self._episodeConfig.configDict[activityId][episodeId] then
		logError(activityId .. " 活动没有该关卡id信息: " .. episodeId)

		return nil
	end

	return self._episodeConfig.configDict[activityId][episodeId]
end

function FeiLinShiDuoConfig:getEpisodeConfigList()
	return self._episodeConfig.configList
end

function FeiLinShiDuoConfig:getNoGameEpisodeList(activityId)
	self.noGameEpisodeList = self.noGameEpisodeList or {}

	if not self.noGameEpisodeList[activityId] then
		self.noGameEpisodeList[activityId] = {}

		local episodeConfigList = self:getEpisodeConfigList(activityId) or {}

		for index, episodeCo in ipairs(episodeConfigList) do
			if episodeCo.storyId > 0 then
				table.insert(self.noGameEpisodeList[activityId], episodeCo)
			end
		end

		table.sort(self.noGameEpisodeList, self.sortEpisode)
	end

	return self.noGameEpisodeList[activityId]
end

function FeiLinShiDuoConfig.sortEpisode(a, b)
	return a.stage <= b.stage
end

function FeiLinShiDuoConfig:getGameEpisode(episodeId)
	local allConfigList = self:getEpisodeConfigList()

	for index, config in ipairs(allConfigList) do
		if config.preEpisodeId == episodeId and config.mapId > 0 then
			return config
		end
	end

	return nil
end

function FeiLinShiDuoConfig:getStageEpisodes(stage)
	if not self.stageMap[stage] then
		logError("当前关卡阶段的配置不存在，请检查" .. stage)

		return {}
	end

	return self.stageMap[stage]
end

function FeiLinShiDuoConfig:getTaskConfig(taskId)
	return self._taskConfig.configDict[taskId]
end

function FeiLinShiDuoConfig:getTaskByActId(activityId)
	local list = self.taskDict[activityId]

	if not list then
		list = {}

		for _, co in ipairs(lua_activity185_task.configList) do
			if co.activityId == activityId then
				table.insert(list, co)
			end
		end

		self.taskDict[activityId] = list
	end

	return list
end

function FeiLinShiDuoConfig:getNextEpisode(episodeId)
	local allConfigList = self:getEpisodeConfigList()

	for index, config in ipairs(allConfigList) do
		if config.preEpisodeId == episodeId then
			return config
		end
	end

	return nil
end

FeiLinShiDuoConfig.instance = FeiLinShiDuoConfig.New()

return FeiLinShiDuoConfig
