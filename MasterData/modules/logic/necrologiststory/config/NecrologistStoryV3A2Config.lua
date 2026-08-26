-- chunkname: @modules/logic/necrologiststory/config/NecrologistStoryV3A2Config.lua

module("modules.logic.necrologiststory.config.NecrologistStoryV3A2Config", package.seeall)

local NecrologistStoryV3A2Config = class("NecrologistStoryV3A2Config", NecrologistStoryVersionConfigBase)

function NecrologistStoryV3A2Config:ctor()
	return
end

function NecrologistStoryV3A2Config:reqConfigNames()
	return {
		"hero_story_mode_v3a2_item",
		"hero_story_mode_v3a2_base"
	}
end

function NecrologistStoryV3A2Config:onLoadhero_story_mode_v3a2_item(configTable)
	self._v3a2ItemConfig = configTable
end

function NecrologistStoryV3A2Config:onLoadhero_story_mode_v3a2_base(configTable)
	self._v3a2BaseConfig = configTable
end

function NecrologistStoryV3A2Config:getBaseList()
	local list = {}

	for _, v in pairs(self._v3a2BaseConfig.configDict) do
		table.insert(list, v)
	end

	table.sort(list, SortUtil.keyLower("id"))

	return list
end

function NecrologistStoryV3A2Config:getBaseConfig(id)
	return self._v3a2BaseConfig.configDict[id]
end

function NecrologistStoryV3A2Config:getItemConfig(id)
	return self._v3a2ItemConfig.configDict[id]
end

function NecrologistStoryV3A2Config:getItemList()
	return self._v3a2ItemConfig.configList
end

NecrologistStoryV3A2Config.instance = NecrologistStoryV3A2Config.New()

return NecrologistStoryV3A2Config
