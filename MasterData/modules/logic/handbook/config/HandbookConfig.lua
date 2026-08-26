-- chunkname: @modules/logic/handbook/config/HandbookConfig.lua

module("modules.logic.handbook.config.HandbookConfig", package.seeall)

local HandbookConfig = class("HandbookConfig", BaseConfig)

function HandbookConfig:ctor()
	self._cgConfig = nil
	self._cgList = nil
	self._chaptertypeConfig = nil
	self._chapter2Type = {}
	self._cgDict = {}
	self._chapterCGDict = {}
	self._storyGroupConfig = nil
	self._storyGroupList = nil
	self._storyChapterConfig = nil
	self._storyChapterList = nil
	self._skinThemeGroupCfg = nil
	self._skinThemeCfg = nil
end

function HandbookConfig:reqConfigNames()
	return {
		"cg",
		"handbook_story_group",
		"handbook_story_chapter",
		"handbook_character",
		"handbook_equip",
		"handbook_skin_high",
		"handbook_skin_low",
		"chapter_type"
	}
end

function HandbookConfig:onConfigLoaded(configName, configTable)
	if configName == "cg" then
		self._cgConfig = configTable
	elseif configName == "handbook_story_group" then
		self._storyGroupConfig = configTable
	elseif configName == "handbook_story_chapter" then
		self._storyChapterConfig = configTable
	elseif configName == "handbook_skin_high" then
		self._skinThemeGroupCfg = configTable
	elseif configName == "handbook_skin_low" then
		self._skinThemeCfg = configTable
		self._isInitSkinSuitFinish = false
	elseif configName == "chapter_type" then
		self._chaptertypeConfig = configTable
	end
end

function HandbookConfig:_initCGConfig()
	self._cgList = {}
	self._cgDungeonList = {}
	self._cgDungeonDict = {}
	self._cgRoleList = {}

	for id, config in pairs(self._cgConfig.configDict) do
		table.insert(self._cgList, config)
	end

	table.sort(self._cgList, function(x, y)
		if x.storyChapterId ~= y.storyChapterId then
			return self._sortBystoryChapterId(x.storyChapterId, y.storyChapterId)
		end

		if x.order ~= y.order then
			return x.order < y.order
		end

		return x.id < y.id
	end)
	self:_initCGDict()
end

function HandbookConfig:_initCGDict()
	for _, typeco in ipairs(self._chaptertypeConfig.configList) do
		local co = {}

		co.type = typeco.typeId
		co.cgTypeList = {}
		co.cgTypeDict = {}
		self._cgDict[typeco.typeId] = co
	end

	for _, storyChapterCo in ipairs(self._storyChapterConfig.configList) do
		self._chapter2Type[storyChapterCo.id] = storyChapterCo.type
	end

	for _, config in pairs(self._cgList) do
		local storyChapterId = config.storyChapterId
		local type = self._chapter2Type[storyChapterId]
		local co = self._cgDict[type]

		co.cgTypeDict[config.storyChapterId] = co.cgTypeDict[config.storyChapterId] or {}

		table.insert(co.cgTypeDict[config.storyChapterId], config)
		table.insert(co.cgTypeList, config)
	end
end

function HandbookConfig:getCGList(cgType)
	if not self._cgList then
		self:_initCGConfig()
	end

	if not cgType then
		return self._cgList
	end

	local co = self._cgDict[cgType]

	return co and co.cgTypeList
end

function HandbookConfig:getCGCount()
	if not self._cgList then
		self:_initCGConfig()
	end

	return (self._cgList or nil) and (#self._cgList or 0)
end

function HandbookConfig:getCGConfig(cgId)
	return self._cgConfig.configDict[cgId]
end

function HandbookConfig:getCGIndex(cgId, cgType)
	local list = self:getCGList(cgType)

	for i, config in ipairs(list) do
		if config.id == cgId then
			return i
		end
	end

	return 0
end

function HandbookConfig:getCGDictByChapter(chapterId, type)
	local typeDict = self._cgDict[type]

	if not typeDict then
		self:_initCGConfig()
	end

	typeDict = self._cgDict[type].cgTypeDict

	return self._cgDict[type].cgTypeDict[chapterId]
end

function HandbookConfig:getCGDict(type)
	local typeDict = self._cgDict[type]

	if not typeDict then
		self:_initCGConfig()
	end

	typeDict = self._cgDict[type].cgTypeDict

	return self._cgDict[type].cgTypeDict
end

function HandbookConfig:_initStoryGroupList()
	self._storyGroupList = {}

	for id, config in pairs(self._storyGroupConfig.configDict) do
		table.insert(self._storyGroupList, config)
	end

	table.sort(self._storyGroupList, function(x, y)
		if x.storyChapterId ~= y.storyChapterId then
			return self._sortBystoryChapterId(x.storyChapterId, y.storyChapterId)
		end

		if x.order ~= y.order then
			return x.order < y.order
		end

		return x.id < y.id
	end)
end

function HandbookConfig:getStoryGroupList()
	if not self._storyGroupList then
		self:_initStoryGroupList()
	end

	return self._storyGroupList
end

function HandbookConfig:getStoryGroupConfig(storyGroupId)
	return self._storyGroupConfig.configDict[storyGroupId]
end

function HandbookConfig:_initStoryChapterList()
	self._storyChapterList = {}

	for id, config in pairs(self._storyChapterConfig.configDict) do
		table.insert(self._storyChapterList, config)
	end

	table.sort(self._storyChapterList, function(x, y)
		if x.order ~= y.order then
			return x.order < y.order
		end

		return x.id < y.id
	end)
end

function HandbookConfig:getStoryChapterList()
	if not self._storyChapterList then
		self:_initStoryChapterList()
	end

	return self._storyChapterList
end

function HandbookConfig:getStoryChapterConfig(storyChapterId)
	local config = self._storyChapterConfig.configDict[storyChapterId]

	if not config then
		logError("章节不存在, ID: " .. tostring(storyChapterId))
	end

	return config
end

function HandbookConfig._sortBystoryChapterId(x, y)
	local xConfig = HandbookConfig.instance:getStoryChapterConfig(x)
	local yConfig = HandbookConfig.instance:getStoryChapterConfig(y)

	if xConfig.order ~= yConfig.order then
		return xConfig.order < yConfig.order
	end

	return xConfig.id < yConfig.id
end

function HandbookConfig:getDialogByFragment(fragmentId)
	for _, config in pairs(lua_chapter_map_element.configDict) do
		if config.fragment == fragmentId and not string.nilorempty(config.param) then
			return tonumber(config.param)
		end
	end
end

function HandbookConfig:getSkinThemeGroupCfgs(onlyShow, sort)
	local result = {}

	if onlyShow then
		for _, cfg in ipairs(self._skinThemeGroupCfg.configList) do
			if cfg.show then
				table.insert(result, cfg)
			end
		end
	else
		result = self._skinThemeGroupCfg.configList
	end

	if sort then
		table.sort(result, function(x, y)
			if x.order ~= y.order then
				return x.order < y.order
			end

			return x.id < y.id
		end)
	end

	return result
end

function HandbookConfig:getSkinThemeGroupCfg(id)
	return self._skinThemeGroupCfg.configDict[id]
end

function HandbookConfig:getSkinSuitCfgListInGroup(groupId, onlyShow)
	local result = {}

	for suitId, suitCfg in pairs(self._skinThemeCfg.configDict) do
		if suitCfg.highId == groupId then
			if onlyShow then
				if suitCfg.show and suitCfg.show == 1 then
					result[#result + 1] = suitCfg
				end
			else
				result[#result + 1] = suitCfg
			end
		end
	end

	return result
end

function HandbookConfig:getSkinSuitCfg(id)
	return self._skinThemeCfg.configDict[id]
end

function HandbookConfig:getSkinSuitIdBySkinId(skinId)
	self:_initSkinSuitParam()

	return self._skinId2suitIdDict and self._skinId2suitIdDict[skinId]
end

function HandbookConfig:getSkinIdListBySuitId(suitId)
	self:_initSkinSuitParam()

	return self._skinThemeIdListDict and self._skinThemeIdListDict[suitId]
end

function HandbookConfig:_initSkinSuitParam()
	if self._isInitSkinSuitFinish or not self._skinThemeCfg then
		return
	end

	self._isInitSkinSuitFinish = true
	self._skinThemeIdListDict = {}
	self._skinId2suitIdDict = {}
	self._highId2suitCfgListDict = {}

	local suitCfgList = self._skinThemeCfg.configList

	for i = 1, #suitCfgList do
		local suitCfg = suitCfgList[i]

		if suitCfg.show == 1 and not string.nilorempty(suitCfg.skinContain) then
			local suitId = suitCfg.id
			local skinIdArray = string.splitToNumber(suitCfg.skinContain, "|") or {}

			self._skinThemeIdListDict[suitId] = skinIdArray

			for _, skinId in ipairs(skinIdArray) do
				self._skinId2suitIdDict[skinId] = suitId
			end

			self._highId2suitCfgListDict[suitCfg.highId] = self._highId2suitCfgListDict[suitCfg.highId] or {}

			table.insert(self._highId2suitCfgListDict[suitCfg.highId], suitCfg)
		end
	end
end

function HandbookConfig:getChapterTypeConfigList()
	return self._chaptertypeConfig.configList
end

HandbookConfig.instance = HandbookConfig.New()

return HandbookConfig
