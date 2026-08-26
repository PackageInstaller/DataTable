-- chunkname: @modules/logic/versionactivity1_3/jialabona/config/Activity120Config.lua

module("modules.logic.versionactivity1_3.jialabona.config.Activity120Config", package.seeall)

local Activity120Config = class("Activity120Config", BaseConfig)

function Activity120Config:ctor()
	self._act120Objects = nil
	self._act120Map = nil
	self._act120Episode = nil
	self._act120Task = nil
	self._act120StroyCfg = nil
	self._episodeListDict = {}
	self._chapterIdListDict = {}
	self._episodeStoryListDict = {}
	self._chapterEpisodeListDict = {}
end

function Activity120Config:reqConfigNames()
	return {
		"activity120_map",
		"activity120_interact_object",
		"activity120_episode",
		"activity120_task",
		"activity120_tips",
		"activity120_interact_effect",
		"activity120_story"
	}
end

function Activity120Config:onConfigLoaded(configName, configTable)
	if configName == "activity120_interact_object" then
		self._act120Objects = configTable
	elseif configName == "activity120_map" then
		self._act120Map = configTable
	elseif configName == "activity120_episode" then
		self._act120Episode = configTable
	elseif configName == "activity120_task" then
		self._act120Task = configTable
	elseif configName == "activity120_tips" then
		self._act120Tips = configTable
	elseif configName == "activity120_interact_effect" then
		self._act120EffectCfg = configTable
	elseif configName == "activity120_story" then
		self._act120StroyCfg = configTable

		self:_initStroyCfg()
	end
end

function Activity120Config:getTaskByActId(actId)
	local list = {}

	for _, co in ipairs(self._act120Task.configList) do
		if co.activityId == actId then
			table.insert(list, co)
		end
	end

	return list
end

function Activity120Config:getInteractObjectCo(actId, id)
	if self._act120Objects.configDict[actId] then
		return self._act120Objects.configDict[actId][id]
	end

	return nil
end

function Activity120Config:getMapCo(actId, id)
	if self._act120Map.configDict[actId] then
		return self._act120Map.configDict[actId][id]
	end

	return nil
end

function Activity120Config:getEpisodeCo(actId, id)
	if self._act120Episode.configDict[actId] then
		return self._act120Episode.configDict[actId][id]
	end

	return nil
end

function Activity120Config:getTipsCo(actId, id)
	if self._act120Tips.configDict[actId] then
		return self._act120Tips.configDict[actId][id]
	end

	return nil
end

function Activity120Config:getEffectCo(actId, id)
	return self._act120EffectCfg.configDict[id]
end

function Activity120Config:getChapterEpisodeId(actId)
	return JiaLaBoNaEnum.chapterId, JiaLaBoNaEnum.episodeId
end

function Activity120Config:getEpisodeList(actId)
	if self._episodeListDict[actId] then
		return self._episodeListDict[actId], self._chapterIdListDict[actId]
	end

	local episodeList = {}
	local chapterIdList = {}

	self._episodeListDict[actId] = episodeList
	self._chapterIdListDict[actId] = chapterIdList

	if self._act120Episode and self._act120Episode.configDict[actId] then
		for k, v in pairs(lua_activity120_episode.configDict[actId]) do
			table.insert(episodeList, v)

			if not tabletool.indexOf(chapterIdList, v.chapterId) and v.chapterId then
				table.insert(chapterIdList, v.chapterId)
			end
		end

		table.sort(episodeList, Activity120Config.sortEpisode)
		table.sort(chapterIdList, Activity120Config.sortChapter)
	end

	return episodeList, chapterIdList
end

function Activity120Config:getChapterEpisodeList(actId, chapterId)
	if self._chapterEpisodeListDict[actId] then
		return self._chapterEpisodeListDict[actId][chapterId]
	end

	local episodeCfgList = self:getEpisodeList(actId)

	if not episodeCfgList then
		return nil
	end

	local listDict = {}

	self._chapterEpisodeListDict[actId] = listDict

	local templist

	for i, episodeCfg in ipairs(episodeCfgList) do
		templist = listDict[episodeCfg.chapterId]

		if not listDict[episodeCfg.chapterId] then
			templist = {}
			listDict[episodeCfg.chapterId] = templist
		end

		table.insert(templist, episodeCfg)
	end

	return listDict[chapterId]
end

function Activity120Config.sortEpisode(item1, item2)
	if item1.chapterId ~= item2.chapterId then
		return item1.chapterId < item2.chapterId
	end

	if item1.id ~= item2.id then
		return item1.id < item2.id
	end
end

function Activity120Config.sortChapter(item1, item2)
	if item1 ~= item2 then
		return item1 < item2
	end
end

function Activity120Config.sortStoryCfg(a, b)
	if a.order ~= b.order then
		return a.order < b.order
	end
end

function Activity120Config:getTaskList()
	if self._task_list then
		return self._task_list
	end

	self._task_list = {}

	for k, v in pairs(lua_activity120_task.configDict) do
		if Activity120Model.instance:getCurActivityID() == v.activityId then
			table.insert(self._task_list, v)
		end
	end

	return self._task_list
end

function Activity120Config:getEpisodeStoryList(actId, episodeId)
	return self._episodeStoryListDict[actId] and self._episodeStoryListDict[actId][episodeId]
end

function Activity120Config:_initStroyCfg()
	self._episodeStoryListDict = {}

	local tempStroyList = {}

	for i, cfg in ipairs(self._act120StroyCfg.configList) do
		local tempActId = cfg.activityId
		local actDict = self._episodeStoryListDict[tempActId]

		if not actDict then
			actDict = {}
			self._episodeStoryListDict[tempActId] = actDict
		end

		local stroyList = actDict[cfg.episodeId]

		if not stroyList then
			stroyList = {}
			actDict[cfg.episodeId] = stroyList

			table.insert(tempStroyList, stroyList)
		end

		table.insert(stroyList, cfg)
	end

	for _, stroyCfgList in ipairs(tempStroyList) do
		table.sort(stroyCfgList, Activity120Config.sortStoryCfg)
	end
end

Activity120Config.instance = Activity120Config.New()

return Activity120Config
