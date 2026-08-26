-- chunkname: @modules/logic/activity/config/Activity109Config.lua

module("modules.logic.activity.config.Activity109Config", package.seeall)

local Activity109Config = class("Activity109Config", BaseConfig)

function Activity109Config:ctor()
	self._act109Objects = nil
	self._act109Map = nil
	self._act109Episode = nil
end

function Activity109Config:reqConfigNames()
	return {
		"activity109_map",
		"activity109_interact_object",
		"activity109_episode",
		"activity109_task"
	}
end

function Activity109Config:onConfigLoaded(configName, configTable)
	if configName == "activity109_interact_object" then
		self._act109Objects = configTable
	elseif configName == "activity109_map" then
		self._act109Map = configTable
	elseif configName == "activity109_episode" then
		self._act109Episode = configTable
	end
end

function Activity109Config:getInteractObjectCo(actId, id)
	if self._act109Objects.configDict[actId] then
		return self._act109Objects.configDict[actId][id]
	end

	return nil
end

function Activity109Config:getMapCo(actId, id)
	if self._act109Map.configDict[actId] then
		return self._act109Map.configDict[actId][id]
	end

	return nil
end

function Activity109Config:getEpisodeCo(actId, id)
	if self._act109Episode.configDict[actId] then
		return self._act109Episode.configDict[actId][id]
	end

	return nil
end

function Activity109Config:getEpisodeList(act_id)
	if self._episode_list then
		return self._episode_list, self._chapter_id_list
	end

	self._episode_list = {}
	self._chapter_id_list = {}

	for k, v in pairs(lua_activity109_episode.configDict[act_id]) do
		table.insert(self._episode_list, v)

		if not tabletool.indexOf(self._chapter_id_list, v.chapterId) and v.chapterId then
			table.insert(self._chapter_id_list, v.chapterId)
		end
	end

	table.sort(self._episode_list, Activity109Config.sortEpisode)
	table.sort(self._chapter_id_list, Activity109Config.sortChapter)

	return self._episode_list, self._chapter_id_list
end

function Activity109Config.sortEpisode(item1, item2)
	return item1.id < item2.id
end

function Activity109Config.sortChapter(item1, item2)
	return item1 < item2
end

function Activity109Config:getTaskList()
	if self._task_list then
		return self._task_list
	end

	self._task_list = {}

	for k, v in pairs(lua_activity109_task.configDict) do
		if Activity109Model.instance:getCurActivityID() == v.activityId then
			table.insert(self._task_list, v)
		end
	end

	return self._task_list
end

Activity109Config.instance = Activity109Config.New()

return Activity109Config
