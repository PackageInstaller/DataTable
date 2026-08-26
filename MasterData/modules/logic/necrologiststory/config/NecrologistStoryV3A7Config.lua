-- chunkname: @modules/logic/necrologiststory/config/NecrologistStoryV3A7Config.lua

module("modules.logic.necrologiststory.config.NecrologistStoryV3A7Config", package.seeall)

local NecrologistStoryV3A7Config = class("NecrologistStoryV3A7Config", NecrologistStoryVersionConfigBase)

function NecrologistStoryV3A7Config:reqConfigNames()
	return {
		"hero_story_mode_v3a7_base"
	}
end

function NecrologistStoryV3A7Config:onLoadhero_story_mode_v3a7_base(configTable)
	self._v3a7BaseConfig = configTable
end

function NecrologistStoryV3A7Config:getBaseList()
	local list = {}

	for _, v in pairs(self._v3a7BaseConfig.configDict) do
		table.insert(list, v)
	end

	table.sort(list, SortUtil.keyLower("id"))

	return list
end

function NecrologistStoryV3A7Config:getBaseConfig(id)
	return self._v3a7BaseConfig.configDict[id]
end

NecrologistStoryV3A7Config.instance = NecrologistStoryV3A7Config.New()

return NecrologistStoryV3A7Config
