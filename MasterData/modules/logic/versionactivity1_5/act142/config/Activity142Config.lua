-- chunkname: @modules/logic/versionactivity1_5/act142/config/Activity142Config.lua

module("modules.logic.versionactivity1_5.act142.config.Activity142Config", package.seeall)

local Activity142Config = class("Activity142Config", BaseConfig)

function Activity142Config:reqConfigNames()
	return {
		"activity142_chapter",
		"activity142_episode",
		"activity142_interact_effect",
		"activity142_interact_object",
		"activity142_collection",
		"activity142_map",
		"activity142_story",
		"activity142_task",
		"activity142_tips"
	}
end

function Activity142Config:onInit()
	return
end

function Activity142Config:onConfigLoaded(configName, configTable)
	local funcName = string.format("%sConfigLoaded", configName)
	local configLoadedFunc = self[funcName]

	if configLoadedFunc then
		configLoadedFunc(self, configTable)
	end
end

local function _sortEpisode(a, b)
	return a < b
end

local function _sortStory(a, b)
	return a.order < b.order
end

function Activity142Config:activity142_episodeConfigLoaded(configTable)
	self._episodeListDict = {}

	local tempAllEpisodeList = {}

	for _, episodeCfg in ipairs(configTable.configList) do
		local actId = episodeCfg.activityId
		local chapterId2EpisodesDict = self._episodeListDict[actId]

		if not chapterId2EpisodesDict then
			chapterId2EpisodesDict = {}
			self._episodeListDict[actId] = chapterId2EpisodesDict
		end

		local chapterId = episodeCfg.chapterId
		local episodeIdList = chapterId2EpisodesDict[chapterId]

		if not episodeIdList then
			episodeIdList = {}
			chapterId2EpisodesDict[chapterId] = episodeIdList

			table.insert(tempAllEpisodeList, episodeIdList)
		end

		table.insert(episodeIdList, episodeCfg.id)
	end

	for _, storyCfgList in ipairs(tempAllEpisodeList) do
		table.sort(storyCfgList, _sortEpisode)
	end
end

function Activity142Config:activity142_mapConfigLoaded(configTable)
	self._groundItemUrDict = {}

	for _, mapCo in ipairs(configTable.configList) do
		if mapCo and not string.nilorempty(mapCo.groundItems) then
			local actId = mapCo.activityId
			local mapId2PathsDict = self._groundItemUrDict[actId]

			if not mapId2PathsDict then
				mapId2PathsDict = {}
				self._groundItemUrDict[actId] = mapId2PathsDict
			end

			local mapId = mapCo.id
			local pathList = mapId2PathsDict[mapId]

			if not pathList then
				pathList = {}
				mapId2PathsDict[mapId] = pathList
			end

			local paths = string.split(mapCo.groundItems, "#") or {}

			for _, path in ipairs(paths) do
				if not string.nilorempty(path) then
					table.insert(pathList, string.format(Va3ChessEnum.SceneResPath.AvatarItemPath, path))
				end
			end
		end
	end
end

function Activity142Config:activity142_storyConfigLoaded(configTable)
	self._storyListDict = {}

	local tempAllStoryListRef = {}

	for _, storyCfg in ipairs(configTable.configList) do
		local actId = storyCfg.activityId
		local episode2StoriesDict = self._storyListDict[actId]

		if not episode2StoriesDict then
			episode2StoriesDict = {}
			self._storyListDict[actId] = episode2StoriesDict
		end

		local episodeStoryList = episode2StoriesDict[storyCfg.episodeId]

		if not episodeStoryList then
			episodeStoryList = {}
			episode2StoriesDict[storyCfg.episodeId] = episodeStoryList

			table.insert(tempAllStoryListRef, episodeStoryList)
		end

		table.insert(episodeStoryList, storyCfg)
	end

	for _, storyCfgList in ipairs(tempAllStoryListRef) do
		table.sort(storyCfgList, _sortStory)
	end
end

local function getChapterCfg(actId, chapterId, nilError)
	local cfg

	if lua_activity142_chapter and lua_activity142_chapter.configDict[actId] then
		cfg = lua_activity142_chapter.configDict[actId][chapterId]
	end

	if not cfg and nilError then
		logError(string.format("Activity142Config:getChapterCfg error, cfg is nil, actId:%s chapterId:%s", actId, chapterId))
	end

	return cfg
end

local function _sortChapter(a, b)
	return a < b
end

function Activity142Config:getChapterList(actId)
	local result = {}

	if not lua_activity142_chapter then
		return result
	end

	for _, co in ipairs(lua_activity142_chapter.configList) do
		if co.activityId == actId then
			table.insert(result, co.id)
		end
	end

	table.sort(result, _sortChapter)

	return result
end

function Activity142Config:getChapterEpisodeIdList(actId, chapterId)
	local result = {}

	result = self._episodeListDict and self._episodeListDict[actId] and self._episodeListDict[actId][chapterId] or result

	return result
end

local SP_CHAPTER_ID_BEGIN = 2

function Activity142Config:isSPChapter(chapterId)
	local result = false

	if chapterId then
		result = chapterId > SP_CHAPTER_ID_BEGIN
	else
		logError("Activity142Config:isSPChapter error chapterId is nil")
	end

	return result
end

function Activity142Config:getChapterName(actId, chapterId)
	local cfg = getChapterCfg(actId, chapterId, true)

	if cfg then
		return cfg.name
	end
end

function Activity142Config:getChapterCategoryTxtColor(actId, chapterId)
	local result
	local cfg = getChapterCfg(actId, chapterId, true)

	return (cfg or nil) and cfg.txtColor
end

function Activity142Config:getChapterCategoryNormalSP(actId, chapterId)
	local result
	local cfg = getChapterCfg(actId, chapterId, true)

	return (cfg or nil) and cfg.normalSprite
end

function Activity142Config:getChapterCategorySelectSP(actId, chapterId)
	local result
	local cfg = getChapterCfg(actId, chapterId, true)

	return (cfg or nil) and cfg.selectSprite
end

function Activity142Config:getChapterCategoryLockSP(actId, chapterId)
	local result
	local cfg = getChapterCfg(actId, chapterId, true)

	return (cfg or nil) and cfg.lockSprite
end

function Activity142Config:getEpisodeCo(actId, episodeId, nilError)
	local cfg

	if lua_activity142_episode and lua_activity142_episode.configDict[actId] then
		cfg = lua_activity142_episode.configDict[actId][episodeId]
	end

	if not cfg and nilError then
		logError(string.format("Activity142Config:getEpisodeCo error, cfg is nil, actId:%s episodeId:%s", actId, episodeId))
	end

	return cfg
end

function Activity142Config:getEpisodePreEpisode(actId, episodeId)
	local cfg = self:getEpisodeCo(actId, episodeId, true)

	if cfg then
		return cfg.preEpisode
	end
end

function Activity142Config:getEpisodeOrder(actId, episodeId)
	local cfg = self:getEpisodeCo(actId, episodeId, true)

	if cfg then
		return cfg.orderId
	end
end

function Activity142Config:getEpisodeName(actId, episodeId)
	local cfg = self:getEpisodeCo(actId, episodeId, true)

	if cfg then
		return cfg.name
	end
end

function Activity142Config:getEpisodeExtCondition(actId, episodeId)
	local cfg = self:getEpisodeCo(actId, episodeId, true)

	if cfg then
		return cfg.extStarCondition
	end
end

function Activity142Config:getEpisodeMaxStar(actId, episodeId)
	local result = Activity142Enum.DEFAULT_STAR_NUM
	local extCondition = self:getEpisodeExtCondition(actId, episodeId)

	if not string.nilorempty(extCondition) then
		result = result + 1
	end

	return result
end

function Activity142Config:getEpisodeOpenDay(actId, episodeId)
	local cfg = self:getEpisodeCo(actId, episodeId, true)

	if cfg then
		return cfg.openDay
	end
end

function Activity142Config:getEpisodeNormalSP(actId, episodeId)
	local result
	local cfg = self:getEpisodeCo(actId, episodeId, true)

	return (cfg or nil) and cfg.normalSprite
end

function Activity142Config:getEpisodeLockSP(actId, episodeId)
	local result
	local cfg = self:getEpisodeCo(actId, episodeId, true)

	return (cfg or nil) and cfg.lockSprite
end

function Activity142Config:isStoryEpisode(actId, episodeId)
	local cfg = self:getEpisodeCo(actId, episodeId, true)

	return (cfg or nil) and string.nilorempty(cfg.mapIds)
end

function Activity142Config:getMapCo(actId, mapId, nilError)
	local cfg

	if lua_activity142_map and lua_activity142_map.configDict[actId] then
		cfg = lua_activity142_map.configDict[actId][mapId]
	end

	if not cfg and nilError then
		logError(string.format("Activity142Config:getMapCo error, cfg is nil, actId:%s mapId:%s", actId, mapId))
	end

	return cfg
end

function Activity142Config:getGroundItemUrlList(actId, mapId)
	local result

	if self._groundItemUrDict and self._groundItemUrDict[actId] and self._groundItemUrDict[actId][mapId] then
		result = self._groundItemUrDict[actId][mapId]
	end

	if not result then
		result = {
			Va3ChessEnum.SceneResPath.GroundItem
		}

		logError(string.format("Activity142Config:getGroundItemUrlList error, can't find groundItemUrls, actId:%s mapId:%s", actId, mapId))
	end

	return result
end

function Activity142Config:getAct142StoryCfg(actId, storyId, nilError)
	local cfg

	if lua_activity142_story and lua_activity142_story.configDict[actId] then
		cfg = lua_activity142_story.configDict[actId][storyId]
	end

	if not cfg and nilError then
		logError(string.format("Activity142Config:getAct142StoryCfg error, cfg is nil, actId:%s storyId:%s", actId, storyId))
	end

	return cfg
end

function Activity142Config:getEpisodeStoryList(actId, episodeId)
	local result = {}

	result = self._storyListDict and self._storyListDict[actId] and self._storyListDict[actId][episodeId] or result

	return result
end

function Activity142Config:getCollectionCfg(actId, collectId, nilError)
	local cfg

	if lua_activity142_collection and lua_activity142_collection.configDict[actId] then
		cfg = lua_activity142_collection.configDict[actId][collectId]
	end

	if not cfg and nilError then
		logError(string.format("Activity142Config:getCollectionCfg error, cfg is nil, actId:%s collectId:%s", actId, collectId))
	end

	return cfg
end

function Activity142Config:getCollectionName(actId, collectId)
	local cfg = self:getCollectionCfg(actId, collectId, true)

	return (cfg or nil) and cfg.name
end

function Activity142Config:getCollectionList(actId)
	local list = {}

	if not actId then
		logError("Activity142Config:getCollectionList error, actId is nil")

		return list
	end

	for _, co in ipairs(lua_activity142_collection.configList) do
		if co.activityId == actId then
			table.insert(list, co.id)
		end
	end

	return list
end

function Activity142Config:getInteractObjectCo(actId, interactObjId, nilError)
	local cfg

	if lua_activity142_interact_object and lua_activity142_interact_object.configDict[actId] then
		cfg = lua_activity142_interact_object.configDict[actId][interactObjId]
	end

	if not cfg and nilError then
		logError(string.format("Activity142Config:getInteractObjectCo error, cfg is nil, actId:%s interactObjId:%s", actId, interactObjId))
	end

	return cfg
end

function Activity142Config:getTipsCfg(actId, tipId, nilError)
	local cfg

	if lua_activity142_tips and lua_activity142_tips.configDict[actId] then
		cfg = lua_activity142_tips.configDict[actId][tipId]
	end

	if not cfg and nilError then
		logError(string.format("Activity142Config:getTipsCfg error, cfg is nil, actId:%s tipId:%s", actId, tipId))
	end

	return cfg
end

function Activity142Config:getTaskByActId(actId)
	local list = {}

	if not actId then
		logError("Activity142Config:getTaskByActId error, actId is nil")

		return list
	end

	for _, co in ipairs(lua_activity142_task.configList) do
		if co.activityId == actId then
			table.insert(list, co)
		end
	end

	return list
end

function Activity142Config:getEffectCo(actId, effectId)
	local cfg

	if lua_activity142_interact_effect and lua_activity142_interact_effect.configDict[effectId] then
		cfg = lua_activity142_interact_effect.configDict[effectId]
	end

	if effectId ~= 0 and not cfg then
		logError(string.format("Activity142Config:getEffectCo error, cfg is nil, effectId:%s", effectId))
	end

	return cfg
end

function Activity142Config:getChapterEpisodeId(_)
	return
end

Activity142Config.instance = Activity142Config.New()

return Activity142Config
