-- chunkname: @modules/logic/versionactivity1_3/chess/config/Activity122Config.lua

module("modules.logic.versionactivity1_3.chess.config.Activity122Config", package.seeall)

local Activity122Config = class("Activity122Config", BaseConfig)

function Activity122Config:ctor()
	self._act122Objects = nil
	self._act122Map = nil
	self._act122Episode = nil
	self._act122Task = nil
	self._act122StroyCfg = nil
	self._act122Tips = nil
	self._act122EffectCfg = nil
	self._episodeListDict = {}
	self._chapterIdListDict = {}
	self._chapterEpisodeListDict = {}
	self._mapStoryListDict = {}
	self._chapterEpisodeListDict = {}
end

function Activity122Config:reqConfigNames()
	return {
		"activity122_map",
		"activity122_interact",
		"activity122_episode",
		"activity122_task",
		"activity122_tips",
		"activity122_interact_effect",
		"activity122_story"
	}
end

function Activity122Config:onConfigLoaded(configName, configTable)
	if configName == "activity122_interact" then
		self._act122Objects = configTable
	elseif configName == "activity122_map" then
		self._act122Map = configTable
	elseif configName == "activity122_episode" then
		self._act122Episode = configTable
	elseif configName == "activity122_task" then
		self._act122Task = configTable
	elseif configName == "activity122_tips" then
		self._act122Tips = configTable
	elseif configName == "activity122_interact_effect" then
		self._act122EffectCfg = configTable
	elseif configName == "activity122_story" then
		self._act122StroyCfg = configTable
	end
end

function Activity122Config:getTaskByActId(actId)
	local list = {}

	for _, co in ipairs(self._act122Task.configList) do
		if co.activityId == actId then
			table.insert(list, co)
		end
	end

	return list
end

function Activity122Config:getInteractObjectCo(actId, id)
	if self._act122Objects.configDict[actId] then
		return self._act122Objects.configDict[actId][id]
	end

	return nil
end

function Activity122Config:getMapCo(actId, id)
	if self._act122Map.configDict[actId] then
		return self._act122Map.configDict[actId][id]
	end

	return nil
end

function Activity122Config:getEpisodeCo(actId, id)
	if self._act122Episode.configDict[actId] then
		return self._act122Episode.configDict[actId][id]
	end

	return nil
end

function Activity122Config:getChapterEpisodeList(actId, chapterId)
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

function Activity122Config:getEffectCo(actId, id)
	return self._act122EffectCfg and self._act122EffectCfg.configDict[id]
end

function Activity122Config:getTipsCfg(actId, id)
	if self._act122Tips.configDict[actId] then
		return self._act122Tips.configDict[actId][id]
	end

	return nil
end

function Activity122Config:getChapterEpisodeId(actId)
	return Activity1_3ChessEnum.chapterId, Activity1_3ChessEnum.episodeId
end

function Activity122Config:getEpisodeList(actId)
	if self._episodeListDict[actId] then
		return self._episodeListDict[actId], self._chapterIdListDict[actId]
	end

	local episodeList = {}
	local chapterIdList = {}

	self._episodeListDict[actId] = episodeList
	self._chapterIdListDict[actId] = chapterIdList

	if self._act122Episode and self._act122Episode.configDict[actId] then
		for k, v in pairs(self._act122Episode.configDict[actId]) do
			episodeList[#episodeList + 1] = v

			if not tabletool.indexOf(chapterIdList, v.chapterId) and v.chapterId then
				chapterIdList[#chapterIdList + 1] = v.chapterId
			end
		end

		table.sort(episodeList, Activity122Config.sortEpisode)
		table.sort(chapterIdList, Activity122Config.sortChapter)
	end

	return episodeList, chapterIdList
end

function Activity122Config.sortEpisode(item1, item2)
	if item1.id ~= item2.id then
		return item1.id < item2.id
	end
end

function Activity122Config.sortChapter(item1, item2)
	if item1 ~= item2 then
		return item1 < item2
	end
end

function Activity122Config:getTaskList()
	if self._task_list then
		return self._task_list
	end

	self._task_list = {}

	for k, v in pairs(lua_activity122_task.configDict) do
		if Activity122Model.instance:getCurActivityID() == v.activityId then
			table.insert(self._task_list, v)
		end
	end

	return self._task_list
end

function Activity122Config:_createStoryCo(storyId, cfg, typeId)
	return {
		storyId = storyId,
		typeId = typeId,
		config = cfg
	}
end

function Activity122Config:_isChessTipsCfg(storyId)
	local actId = VersionActivity1_3Enum.ActivityId.Act304

	return self:getTipsCfg(actId, storyId) ~= nil
end

function Activity122Config:getEpisodeStoryList(actId, episodeId)
	if not self._episodeStoryListDict then
		self:_initStroyCfg()
	end

	return self._episodeStoryListDict[actId] and self._episodeStoryListDict[actId][episodeId]
end

function Activity122Config:_initStroyCfg()
	self._episodeStoryListDict = {}

	local tempStroyList = {}

	for i, cfg in ipairs(self._act122StroyCfg.configList) do
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
			tempStroyList[#tempStroyList + 1] = stroyList
		end

		table.insert(stroyList, cfg)
	end

	for _, stroyCfgList in ipairs(tempStroyList) do
		table.sort(stroyCfgList, Activity122Config.sortStory)
	end
end

function Activity122Config.sortStory(a, b)
	if a.order ~= b.order then
		return a.order < b.order
	end
end

Activity122Config.instance = Activity122Config.New()

return Activity122Config
