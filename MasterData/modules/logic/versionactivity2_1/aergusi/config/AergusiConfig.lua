-- chunkname: @modules/logic/versionactivity2_1/aergusi/config/AergusiConfig.lua

module("modules.logic.versionactivity2_1.aergusi.config.AergusiConfig", package.seeall)

local AergusiConfig = class("AergusiConfig", BaseConfig)

function AergusiConfig:ctor()
	self._episodeConfig = nil
	self._evidenceConfig = nil
	self._dialogConfig = nil
	self._bubbleConfig = nil
	self._clueConfig = nil
	self._taskConfig = nil
end

function AergusiConfig:reqConfigNames()
	return {
		"activity163_episode",
		"activity163_evidence",
		"activity163_dialog",
		"activity163_bubble",
		"activity163_clue",
		"activity163_task"
	}
end

function AergusiConfig:onConfigLoaded(configName, configTable)
	if configName == "activity163_episode" then
		self._episodeConfig = configTable
	elseif configName == "activity163_evidence" then
		self._evidenceConfig = configTable
	elseif configName == "activity163_dialog" then
		self._dialogConfig = configTable
	elseif configName == "activity163_bubble" then
		self._bubbleConfig = configTable
	elseif configName == "activity163_clue" then
		self._clueConfig = configTable
	elseif configName == "activity163_task" then
		self._taskConfig = configTable
	end
end

function AergusiConfig:getEpisodeConfigs(actId)
	actId = actId or VersionActivity2_1Enum.ActivityId.Aergusi

	return self._episodeConfig.configDict[actId]
end

function AergusiConfig:getEpisodeConfig(actId, episodeId)
	actId = actId or VersionActivity2_1Enum.ActivityId.Aergusi

	return self._episodeConfig.configDict[actId][episodeId]
end

function AergusiConfig:getEvidenceConfig(evidenceId)
	return self._evidenceConfig.configDict[evidenceId]
end

function AergusiConfig:getDialogConfigs(evidenceId)
	return self._dialogConfig.configDict[evidenceId]
end

function AergusiConfig:getDialogConfig(evidenceId, stepId)
	return self._dialogConfig.configDict[evidenceId][stepId]
end

function AergusiConfig:getEvidenceDialogConfigs(evidenceId)
	return self._dialogConfig.configDict[evidenceId]
end

function AergusiConfig:getBubbleConfigs(tipId)
	return self._bubbleConfig.configDict[tipId]
end

function AergusiConfig:getBubbleConfig(tipId, stepId)
	return self._bubbleConfig.configDict[tipId][stepId]
end

function AergusiConfig:getClueConfigs()
	return self._clueConfig.configDict
end

function AergusiConfig:getClueConfig(clueId)
	return self._clueConfig.configDict[clueId]
end

function AergusiConfig:getTaskConfig(taskId)
	return self._taskConfig.configDict[taskId]
end

function AergusiConfig:getTaskByActId(actId)
	local list = {}

	for _, co in pairs(self._taskConfig.configList) do
		if co.activityId == actId then
			table.insert(list, co)
		end
	end

	return list
end

AergusiConfig.instance = AergusiConfig.New()

return AergusiConfig
