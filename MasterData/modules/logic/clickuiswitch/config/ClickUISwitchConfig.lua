-- chunkname: @modules/logic/clickuiswitch/config/ClickUISwitchConfig.lua

module("modules.logic.clickuiswitch.config.ClickUISwitchConfig", package.seeall)

local ClickUISwitchConfig = class("ClickUISwitchConfig", BaseConfig)

function ClickUISwitchConfig:reqConfigNames()
	return {
		"scene_click"
	}
end

function ClickUISwitchConfig:onInit()
	return
end

function ClickUISwitchConfig:onConfigLoaded(configName, configTable)
	if configName == "scene_click" then
		self:_initClickUIConfig()
	end
end

function ClickUISwitchConfig:_initClickUIConfig()
	self.uiItem = {}
	self._itemSource = {}

	for _, co in ipairs(lua_scene_click.configList) do
		self.uiItem[co.itemId] = co
	end

	ClickUISwitchModel.instance:initConfig()
end

function ClickUISwitchConfig:getClickUICoByItemId(itemId)
	return self.uiItem[itemId]
end

function ClickUISwitchConfig:getItemSource(itemId)
	local t = self._itemSource[itemId]

	if not t then
		t = self:_collectSource(itemId)
		self._itemSource[itemId] = t
	end

	return t
end

function ClickUISwitchConfig:_collectSource(itemId)
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

ClickUISwitchConfig.instance = ClickUISwitchConfig.New()

return ClickUISwitchConfig
