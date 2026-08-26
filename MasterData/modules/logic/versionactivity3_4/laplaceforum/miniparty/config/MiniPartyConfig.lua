-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/miniparty/config/MiniPartyConfig.lua

module("modules.logic.versionactivity3_4.laplaceforum.miniparty.config.MiniPartyConfig", package.seeall)

local MiniPartyConfig = class("MiniPartyConfig", BaseConfig)

function MiniPartyConfig:ctor()
	self._constConfig = nil
	self._taskConfig = nil
end

function MiniPartyConfig:reqConfigNames()
	return {
		"activity223_const",
		"activity223_task"
	}
end

function MiniPartyConfig:onConfigLoaded(configName, configTable)
	if configName == "activity223_const" then
		self._constConfig = configTable
	elseif configName == "activity223_task" then
		self._taskConfig = configTable
	end
end

function MiniPartyConfig:getConstCO(constId, actId)
	actId = actId or VersionActivity3_4Enum.ActivityId.LaplaceMiniParty

	return self._constConfig.configDict[actId][constId]
end

function MiniPartyConfig:getTaskCo(taskId)
	return self._taskConfig.configDict[taskId]
end

function MiniPartyConfig:getTaskCosByTaskType(typeId)
	local taskCos = {}

	for _, taskCo in pairs(self._taskConfig.configDict) do
		if taskCo.teamType == typeId then
			table.insert(taskCos, taskCo)
		end
	end

	return taskCos
end

MiniPartyConfig.instance = MiniPartyConfig.New()

return MiniPartyConfig
