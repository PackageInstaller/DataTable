-- chunkname: @modules/logic/necrologiststory/config/NecrologistStoryV3A4Config.lua

module("modules.logic.necrologiststory.config.NecrologistStoryV3A4Config", package.seeall)

local NecrologistStoryV3A4Config = class("NecrologistStoryV3A4Config", NecrologistStoryVersionConfigBase)

function NecrologistStoryV3A4Config:ctor()
	return
end

function NecrologistStoryV3A4Config:reqConfigNames()
	return {
		"hero_story_mode_v3a4_base",
		"hero_story_mode_v3a4_game",
		"hero_story_mode_v3a4_item"
	}
end

function NecrologistStoryV3A4Config:onLoadhero_story_mode_v3a4_base(configTable)
	self._v3a4BaseConfig = configTable
end

function NecrologistStoryV3A4Config:onLoadhero_story_mode_v3a4_game(configTable)
	self._v3a4GameConfig = configTable
end

function NecrologistStoryV3A4Config:onLoadhero_story_mode_v3a4_item(configTable)
	self._v3a4ItemConfig = configTable
end

function NecrologistStoryV3A4Config:getBaseList()
	local list = {}

	for _, v in pairs(self._v3a4BaseConfig.configDict) do
		table.insert(list, v)
	end

	table.sort(list, SortUtil.keyLower("id"))

	return list
end

function NecrologistStoryV3A4Config:getBaseConfig(id)
	return self._v3a4BaseConfig.configDict[id]
end

function NecrologistStoryV3A4Config:getItemConfig(id)
	return self._v3a4ItemConfig.configDict[id]
end

function NecrologistStoryV3A4Config:getItemList()
	return self._v3a4ItemConfig.configList
end

function NecrologistStoryV3A4Config:getGameNodeList(id)
	if not self._gameNodeList then
		self._gameNodeList = {}

		for _, v in pairs(self._v3a4GameConfig.configList) do
			self._gameNodeList[v.gameId] = self._gameNodeList[v.gameId] or {}

			table.insert(self._gameNodeList[v.gameId], v)
		end

		for _, v in pairs(self._gameNodeList) do
			table.sort(v, SortUtil.keyLower("nodeId"))
		end
	end

	return self._gameNodeList[id]
end

function NecrologistStoryV3A4Config:getGameNodeConfig(gameId, nodeId)
	local dict = self._v3a4GameConfig.configDict[gameId]

	return dict and dict[nodeId]
end

NecrologistStoryV3A4Config.instance = NecrologistStoryV3A4Config.New()

return NecrologistStoryV3A4Config
