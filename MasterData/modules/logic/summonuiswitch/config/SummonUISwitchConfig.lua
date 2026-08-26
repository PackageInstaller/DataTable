-- chunkname: @modules/logic/summonuiswitch/config/SummonUISwitchConfig.lua

module("modules.logic.summonuiswitch.config.SummonUISwitchConfig", package.seeall)

local SummonUISwitchConfig = class("SummonUISwitchConfig", BaseConfig)

function SummonUISwitchConfig:reqConfigNames()
	return {
		"summon_switch"
	}
end

function SummonUISwitchConfig:onInit()
	self._itemSource = {}
	self._summonSwitchIdDic = {}
end

function SummonUISwitchConfig:onConfigLoaded(configName, configTable)
	if configName == "summon_switch" then
		self._summonSwitchConfig = configTable

		self:initSummonSwitchConfig()
	end
end

function SummonUISwitchConfig:initSummonSwitchConfig()
	if self._summonSwitchConfig and self._summonSwitchConfig.configList then
		for _, config in ipairs(self._summonSwitchConfig.configList) do
			self._summonSwitchIdDic[config.itemId] = self._summonSwitchIdDic[config.itemId] or config.id
		end
	end
end

function SummonUISwitchConfig:getSummonSwitchConfig(id)
	if id == nil then
		return self._summonSwitchConfig
	end

	return self._summonSwitchConfig.configDict[id]
end

function SummonUISwitchConfig:getSummonSwitchConfigList()
	if not self._summonSwitchConfig then
		return nil
	end

	return self._summonSwitchConfig.configList
end

function SummonUISwitchConfig:getSummonSwitchConfigByItemId(itemId)
	if not self._summonSwitchIdDic then
		return nil
	end

	local id = self._summonSwitchIdDic[itemId]

	if id then
		return self:getSummonSwitchConfig(id)
	end

	return nil
end

function SummonUISwitchConfig:getItemSource(itemId)
	local t = self._itemSource[itemId]

	if not t then
		t = self:_collectSource(itemId)
		self._itemSource[itemId] = t
	end

	return t
end

function SummonUISwitchConfig:_collectSource(itemId)
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

SummonUISwitchConfig.instance = SummonUISwitchConfig.New()

return SummonUISwitchConfig
