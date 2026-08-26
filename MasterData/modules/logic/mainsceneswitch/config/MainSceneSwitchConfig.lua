-- chunkname: @modules/logic/mainsceneswitch/config/MainSceneSwitchConfig.lua

module("modules.logic.mainsceneswitch.config.MainSceneSwitchConfig", package.seeall)

local MainSceneSwitchConfig = class("MainSceneSwitchConfig", BaseConfig)

function MainSceneSwitchConfig:reqConfigNames()
	return {
		"scene_switch",
		"scene_settings",
		"scene_effect_settings"
	}
end

function MainSceneSwitchConfig:onInit()
	return
end

function MainSceneSwitchConfig:onConfigLoaded(configName, configTable)
	if configName == "scene_switch" then
		self:_initSceneSwitchConfig()
	end
end

function MainSceneSwitchConfig:_initSceneSwitchConfig()
	self._itemMap = {}
	self._itemLockList = {}
	self._itemSource = {}
	self._defaultSceneId = nil

	for i, v in ipairs(lua_scene_switch.configList) do
		self._itemMap[v.itemId] = v

		if v.defaultUnlock == 1 then
			if self._defaultSceneId ~= nil then
				logError("MainSceneSwitchConfig:_initSceneSwitchConfig has more than one default scene")
			end

			self._defaultSceneId = v.id
		else
			table.insert(self._itemLockList, v.itemId)
		end
	end

	if not self._defaultSceneId then
		logError("MainSceneSwitchConfig:_initSceneSwitchConfig has no default scene")
	end
end

function MainSceneSwitchConfig:getItemSource(itemId)
	local t = self._itemSource[itemId]

	if not t then
		t = self:_collectSource(itemId)
		self._itemSource[itemId] = t
	end

	return t
end

function MainSceneSwitchConfig:_collectSource(itemId)
	local itemConfig = lua_item.configDict[itemId]
	local sourcesStr = itemConfig.sources
	local sourceTables = {}

	if not string.nilorempty(sourcesStr) then
		local sources = string.split(sourcesStr, "|")

		for i, source in ipairs(sources) do
			local sourceParam = string.splitToNumber(source, "#")
			local sourceTable = {}

			sourceTable.sourceId = sourceParam[1]
			sourceTable.probability = sourceParam[2]
			sourceTable.episodeId = JumpConfig.instance:getJumpEpisodeId(sourceTable.sourceId)

			if sourceTable.probability ~= MaterialEnum.JumpProbability.Normal or not DungeonModel.instance:hasPassLevel(sourceTable.episodeId) then
				table.insert(sourceTables, sourceTable)
			end
		end
	end

	return sourceTables
end

function MainSceneSwitchConfig:getItemLockList()
	return self._itemLockList
end

function MainSceneSwitchConfig:getConfigByItemId(itemId)
	return self._itemMap[itemId]
end

function MainSceneSwitchConfig:getDefaultSceneId()
	return self._defaultSceneId
end

function MainSceneSwitchConfig:getSceneEffect(sceneId, tag)
	local configs = lua_scene_effect_settings.configDict[sceneId]

	if configs then
		for i, v in ipairs(configs) do
			if v.tag == tag then
				return v
			end
		end
	end
end

MainSceneSwitchConfig.instance = MainSceneSwitchConfig.New()

return MainSceneSwitchConfig
