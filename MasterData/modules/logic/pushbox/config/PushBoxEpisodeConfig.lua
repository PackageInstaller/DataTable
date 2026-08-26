-- chunkname: @modules/logic/pushbox/config/PushBoxEpisodeConfig.lua

module("modules.logic.pushbox.config.PushBoxEpisodeConfig", package.seeall)

local PushBoxEpisodeConfig = class("PushBoxEpisodeConfig", BaseConfig)

function PushBoxEpisodeConfig:ctor()
	return
end

function PushBoxEpisodeConfig:reqConfigNames()
	return {
		"push_box_episode",
		"push_box_activity",
		"push_box_task"
	}
end

function PushBoxEpisodeConfig:onConfigLoaded(configName, configTable)
	if configName == "push_box_episode" then
		-- block empty
	end
end

function PushBoxEpisodeConfig:getConfig(id)
	return lua_push_box_episode.configDict[id]
end

function PushBoxEpisodeConfig:getEpisodeList()
	if self._episode_list then
		return self._episode_list
	end

	local tab = {}

	for index, value in pairs(lua_push_box_activity.configDict[PushBoxModel.instance:getCurActivityID()]) do
		table.insert(tab, value)
	end

	table.sort(tab, function(item1, item2)
		return item1.stageId < item2.stageId
	end)

	self._episode_list = {}
	self._episode2stageID = {}

	for i, v in ipairs(tab) do
		for index, id in ipairs(v.episodeIds) do
			local episode_config = self:getConfig(id)

			table.insert(self._episode_list, episode_config)

			self._episode2stageID[id] = v.stageId
		end
	end

	return self._episode_list
end

function PushBoxEpisodeConfig:getStageIDByEpisodeID(id)
	return self._episode2stageID[id]
end

function PushBoxEpisodeConfig:getStageConfig(stageId)
	return lua_push_box_activity.configDict[PushBoxModel.instance:getCurActivityID()][stageId]
end

function PushBoxEpisodeConfig:getTaskList()
	if self._task_list then
		return self._task_list
	end

	self._task_list = {}

	for k, v in pairs(lua_push_box_task.configDict[PushBoxModel.instance:getCurActivityID()]) do
		table.insert(self._task_list, v)
	end

	return self._task_list
end

PushBoxEpisodeConfig.instance = PushBoxEpisodeConfig.New()

return PushBoxEpisodeConfig
