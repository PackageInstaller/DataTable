-- chunkname: @modules/logic/explore/config/ExploreConfig.lua

module("modules.logic.explore.config.ExploreConfig", package.seeall)

local ExploreConfig = class("ExploreConfig", BaseConfig)

function ExploreConfig:reqConfigNames()
	return {
		"explore_scene",
		"explore_dialogue",
		"explore_item",
		"explore_item_type",
		"explore_unit",
		"explore_unit_effect",
		"explore_hero_effect",
		"task_explore",
		"explore_story",
		"explore_chest",
		"explore_bubble",
		"explore_signs"
	}
end

function ExploreConfig:onInit()
	self._chapterToMapIds = {}
	self._taskCos = {}
	self._rewardCos = {}
end

function ExploreConfig:onConfigLoaded(configName, configTable)
	if configName == "explore_scene" then
		self.sceneConfig = configTable
		self.mapIdConfig = {}

		for i, v in ipairs(self.sceneConfig.configList) do
			self.mapIdConfig[v.id] = v
			self._chapterToMapIds[v.chapterId] = self._chapterToMapIds[v.chapterId] or {}

			table.insert(self._chapterToMapIds[v.chapterId], v.id)
		end
	elseif configName == "explore_item" then
		self.itemConfig = configTable
	elseif configName == "explore_item_type" then
		self.itemTypeConfig = configTable
	elseif configName == "explore_unit" then
		self.unitConfig = configTable
	elseif configName == "explore_dialogue" then
		self.dialogueConfig = configTable
	elseif configName == "explore_unit_effect" then
		self.unitEffectConfig = configTable
	elseif configName == "task_explore" then
		self:_buildTaskConfig()
	elseif configName == "explore_chest" then
		self:_buildRewardConfig()
	end
end

function ExploreConfig:loadExploreConfig(mapId)
	self._mapConfig = addGlobalModule("modules.configs.explore.lua_explore_map_" .. tostring(mapId), "lua_explore_map_" .. tostring(mapId))
end

local function sorttaskFunc(a, b)
	return a.maxProgress < b.maxProgress
end

local function sortrewardFunc(a, b)
	return a.id < b.id
end

function ExploreConfig:_buildRewardConfig()
	for id, co in ipairs(lua_explore_chest.configList) do
		self._rewardCos[co.chapterId] = self._rewardCos[co.chapterId] or {}
		self._rewardCos[co.chapterId][co.episodeId] = self._rewardCos[co.chapterId][co.episodeId] or {}

		if co.isCount == 1 then
			table.insert(self._rewardCos[co.chapterId][co.episodeId], co)
		end
	end

	for chapterId, dict in pairs(self._rewardCos) do
		for episodeId, arr in pairs(dict) do
			table.sort(arr, sortrewardFunc)
		end
	end
end

function ExploreConfig:getRewardConfig(chapterId, episodeId)
	if not self._rewardCos[chapterId] then
		return {}
	end

	return self._rewardCos[chapterId][episodeId] or {}
end

function ExploreConfig:_buildTaskConfig()
	for i, v in ipairs(lua_task_explore.configList) do
		local arr = string.splitToNumber(v.listenerParam, "#")

		self._taskCos[arr[1]] = self._taskCos[arr[1]] or {}
		self._taskCos[arr[1]][arr[2]] = self._taskCos[arr[1]][arr[2]] or {}

		table.insert(self._taskCos[arr[1]][arr[2]], v)
	end

	for chapterId, dict in pairs(self._taskCos) do
		for coinType, list in pairs(dict) do
			table.sort(list, sorttaskFunc)
		end
	end
end

function ExploreConfig:getTaskList(chapterId, coinType)
	if not self._taskCos[chapterId] or not self._taskCos[chapterId][coinType] then
		return {}
	end

	return self._taskCos[chapterId][coinType]
end

function ExploreConfig:getMapConfig()
	return self._mapConfig
end

function ExploreConfig:getSceneId(id)
	return self.mapIdConfig[id].sceneId
end

function ExploreConfig:getMapIdsByChapter(chapterId)
	return self._chapterToMapIds[chapterId] or {}
end

function ExploreConfig:getAnimLength(goName, animName)
	local co = lua_explore_anim_length[goName]

	if not co then
		return
	end

	return co[animName]
end

function ExploreConfig:getMapIdConfig(id)
	return self.mapIdConfig[id]
end

function ExploreConfig:getEpisodeId(mapId)
	return self.mapIdConfig[mapId].episodeId
end

function ExploreConfig:getDialogueConfig(id)
	return self.dialogueConfig.configDict[id]
end

function ExploreConfig:getItemCo(itemId)
	return self.itemConfig.configDict[itemId]
end

function ExploreConfig:isStackableItem(itemId)
	local conifg = self.itemConfig.configDict[itemId]

	return (conifg or nil) and (conifg.isClientStackable or false)
end

function ExploreConfig:isActiveTypeItem(type)
	local co = self.itemTypeConfig.configDict[type]

	return (co or nil) and (co.isActiveType or false)
end

function ExploreConfig:getUnitName(type)
	if self.unitConfig.configDict[type] then
		return self.unitConfig.configDict[type].name
	end

	return type
end

function ExploreConfig:getUnitNeedShowName(type)
	if self.unitConfig.configDict[type] then
		return self.unitConfig.configDict[type].isShow
	end

	return false
end

function ExploreConfig:getUnitEffectConfig(prefabPath, animName)
	if not prefabPath then
		return
	end

	local name = string.match(prefabPath, "/([0-9a-zA-Z_]+)%.prefab$")
	local config = self.unitEffectConfig.configDict[name]

	if config and config[animName] then
		return config[animName].effectPath, config[animName].isOnce == 1, config[animName].audioId, config[animName].isBindGo == 1, config[animName].isLoopAudio == 1
	end
end

function ExploreConfig:getAssetNeedAkGo(prefabPath)
	if not prefabPath then
		return false
	end

	self._pathNeedAkDict = self._pathNeedAkDict or {}

	if self._pathNeedAkDict[prefabPath] ~= nil then
		return self._pathNeedAkDict[prefabPath]
	end

	local needAk = false
	local name = string.match(prefabPath, "/([0-9a-zA-Z_]+)%.prefab$")
	local config = self.unitEffectConfig.configDict[name]

	if config then
		for _, co in pairs(config) do
			if co.isBindGo then
				needAk = true

				break
			end
		end
	end

	self._pathNeedAkDict[prefabPath] = needAk

	return needAk
end

function ExploreConfig:getArchiveTotalCount(chapterId)
	if not self._archiveCountDict then
		self._archiveCountDict = {}

		for chapter, dict in pairs(lua_explore_story.configDict) do
			self._archiveCountDict[chapter] = tabletool.len(dict)
		end
	end

	return self._archiveCountDict[chapterId] or 0
end

ExploreConfig.instance = ExploreConfig.New()

return ExploreConfig
