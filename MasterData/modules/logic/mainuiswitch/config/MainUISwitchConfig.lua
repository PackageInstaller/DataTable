-- chunkname: @modules/logic/mainuiswitch/config/MainUISwitchConfig.lua

module("modules.logic.mainuiswitch.config.MainUISwitchConfig", package.seeall)

local MainUISwitchConfig = class("MainUISwitchConfig", BaseConfig)

function MainUISwitchConfig:reqConfigNames()
	return {
		"scene_ui",
		"scene_ui_reddot",
		"main_ui_skin",
		"main_ui_eagle",
		"scene_const"
	}
end

function MainUISwitchConfig:onInit()
	return
end

function MainUISwitchConfig:onConfigLoaded(configName, configTable)
	if configName == "scene_ui" then
		self:_initUISwitchConfig()
	elseif configName == "scene_ui_reddot" then
		self._uiReddotCo = configTable
	elseif configName == "main_ui_skin" then
		self._skinConfig = configTable

		self:_initMainUISkinCo()
	elseif configName == "main_ui_eagle" then
		self._eagleAnimConfig = configTable
	elseif configName == "scene_const" then
		self._constConfig = configTable
	end
end

function MainUISwitchConfig:_initUISwitchConfig()
	self.uiItem = {}
	self._itemSource = {}

	for _, co in ipairs(lua_scene_ui.configList) do
		self.uiItem[co.itemId] = co
	end
end

function MainUISwitchConfig:getUISwitchCoByItemId(itemId)
	return self.uiItem[itemId]
end

function MainUISwitchConfig:getUIReddotStyle(uiId, reddotId)
	local cos = self._uiReddotCo.configDict[uiId]

	return cos and cos[reddotId]
end

function MainUISwitchConfig:_initMainUISkinCo()
	self._mainUiCos = {}

	for _, co in ipairs(self._skinConfig.configList) do
		self._mainUiCos[co.skinId] = self._mainUiCos[co.skinId] or {}
		self._mainUiCos[co.skinId][co.id] = co
	end
end

function MainUISwitchConfig:getMainUISkinCosbySkinId(skinId)
	return self._mainUiCos[skinId]
end

function MainUISwitchConfig:getMainUISkinCo(id, skinId)
	if not self._skinConfig.configDict[id] then
		return
	end

	return self._skinConfig.configDict[id][skinId]
end

function MainUISwitchConfig:getEagleAnim(step)
	return self._eagleAnimConfig.configDict[step]
end

function MainUISwitchConfig:getItemSource(itemId)
	local t = self._itemSource[itemId]

	if not t then
		t = self:_collectSource(itemId)
		self._itemSource[itemId] = t
	end

	return t
end

function MainUISwitchConfig:_collectSource(itemId)
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

function MainUISwitchConfig:getConstValue(constId, isNumber)
	local co = self._constConfig.configDict[constId]
	local value = co.value

	if isNumber then
		value = tonumber(value)
	end

	return value
end

function MainUISwitchConfig:getConstValue2(constId, isNumber)
	local co = self._constConfig.configDict[constId]
	local value = co.value2

	if isNumber then
		value = tonumber(value)
	end

	return value
end

MainUISwitchConfig.instance = MainUISwitchConfig.New()

return MainUISwitchConfig
