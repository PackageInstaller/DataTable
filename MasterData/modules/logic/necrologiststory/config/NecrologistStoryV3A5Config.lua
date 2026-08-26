-- chunkname: @modules/logic/necrologiststory/config/NecrologistStoryV3A5Config.lua

module("modules.logic.necrologiststory.config.NecrologistStoryV3A5Config", package.seeall)

local NecrologistStoryV3A5Config = class("NecrologistStoryV3A5Config", NecrologistStoryVersionConfigBase)

function NecrologistStoryV3A5Config:ctor()
	return
end

function NecrologistStoryV3A5Config:reqConfigNames()
	return {
		"hero_story_mode_v3a5_base"
	}
end

function NecrologistStoryV3A5Config:onLoadhero_story_mode_v3a5_base(configTable)
	self._v3a5BaseConfig = configTable
end

function NecrologistStoryV3A5Config:getBaseList()
	local list = {}

	for _, v in pairs(self._v3a5BaseConfig.configDict) do
		table.insert(list, v)
	end

	table.sort(list, SortUtil.keyLower("id"))

	return list
end

function NecrologistStoryV3A5Config:getBaseConfig(id)
	return self._v3a5BaseConfig.configDict[id]
end

NecrologistStoryV3A5Config.instance = NecrologistStoryV3A5Config.New()

return NecrologistStoryV3A5Config
