-- chunkname: @modules/logic/versionactivity2_1/lanshoupa/config/Activity164Config.lua

module("modules.logic.versionactivity2_1.lanshoupa.config.Activity164Config", package.seeall)

local Activity164Config = class("Activity164Config", BaseConfig)

function Activity164Config:ctor()
	self._act164Episode = nil
	self._act164Task = nil
	self._episodeListDict = {}
	self._chapterIdListDict = {}
	self._chapterEpisodeListDict = {}
	self._bubbleListDict = {}
end

function Activity164Config:reqConfigNames()
	return {
		"activity164_episode",
		"activity164_task",
		"activity164_story",
		"activity164_tips",
		"activity164_bubble"
	}
end

function Activity164Config:onConfigLoaded(configName, configTable)
	if configName == "activity164_episode" then
		self._act164Episode = configTable

		self:_initEpisodeList()
	elseif configName == "activity164_task" then
		self._act164Task = configTable
	elseif configName == "activity164_story" then
		self._act164Story = configTable
	elseif configName == "activity164_tips" then
		self._act164Tips = configTable
	elseif configName == "activity164_bubble" then
		self._act164Bubble = configTable
	end
end

function Activity164Config:_initEpisodeList()
	for actId, coList in pairs(self._act164Episode.configDict) do
		self._episodeListDict[actId] = self._episodeListDict[actId] or {}

		for key, co in pairs(coList) do
			table.insert(self._episodeListDict[actId], co)
		end

		table.sort(self._episodeListDict[actId], Activity164Config.sortEpisode)
	end
end

function Activity164Config:getTaskByActId(actId)
	local list = {}

	for _, co in ipairs(self._act164Task.configList) do
		if co.activityId == actId then
			table.insert(list, co)
		end
	end

	return list
end

function Activity164Config:getEpisodeCo(actId, id)
	if self._act164Episode.configDict[actId] then
		return self._act164Episode.configDict[actId][id]
	end

	return nil
end

function Activity164Config:getEpisodeIndex(actId, id)
	local list = self._episodeListDict[actId]

	for index, co in ipairs(list) do
		if co.id == id then
			return index
		end
	end
end

function Activity164Config:getEpisodeCoDict(actId)
	return self._act164Episode.configDict[actId]
end

function Activity164Config:getEpisodeCoList(actId)
	return self._episodeListDict[actId]
end

function Activity164Config:getTipsCo(actId, id)
	if self._act164Tips.configDict[actId] then
		return self._act164Tips.configDict[actId][id]
	end

	return nil
end

function Activity164Config:getBubbleCo(actId, id)
	if self._act164Bubble.configDict[actId] then
		return self._act164Bubble.configDict[actId][id]
	end

	return nil
end

function Activity164Config:getBubbleCoByGroup(actId, groupId)
	return self._act164Bubble.configDict[actId][groupId]
end

function Activity164Config:_initBubbleConfig()
	for actId, coList in pairs(self._act164Bubble.configDict) do
		self._bubbleListDict[actId] = coList

		for groupId, config in ipairs(coList) do
			self._bubbleListDict[actId][groupId] = self._bubbleListDict[actId][groupId] or {}

			table.insert(self._bubbleListDict[actId][groupId], config)
		end
	end
end

function Activity164Config.sortEpisode(item1, item2)
	if item1.id ~= item2.id then
		return item1.id < item2.id
	end
end

function Activity164Config:getStoryList(activityId, id)
	local dict = lua_activity164_story.configDict[activityId]

	return dict and dict[id]
end

function Activity164Config:getTaskList()
	if self._task_list then
		return self._task_list
	end

	self._task_list = {}

	for k, v in pairs(lua_activity164_task.configDict) do
		if Activity164Model.instance:getCurActivityID() == v.activityId then
			table.insert(self._task_list, v)
		end
	end

	return self._task_list
end

Activity164Config.instance = Activity164Config.New()

return Activity164Config
