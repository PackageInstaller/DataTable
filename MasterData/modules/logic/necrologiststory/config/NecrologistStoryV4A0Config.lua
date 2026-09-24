-- chunkname: @modules/logic/necrologiststory/config/NecrologistStoryV4A0Config.lua

module("modules.logic.necrologiststory.config.NecrologistStoryV4A0Config", package.seeall)

local NecrologistStoryV4A0Config = class("NecrologistStoryV4A0Config", NecrologistStoryVersionConfigBase)

function NecrologistStoryV4A0Config:ctor()
	return
end

function NecrologistStoryV4A0Config:reqConfigNames()
	return {
		"hero_story_mode_v4a0_base",
		"hero_story_mode_v4a0_question",
		"hero_story_mode_v4a0_option",
		"hero_story_mode_v4a0_result"
	}
end

function NecrologistStoryV4A0Config:onLoadhero_story_mode_v4a0_base(configTable)
	self._baseConfig = configTable
end

function NecrologistStoryV4A0Config:onLoadhero_story_mode_v4a0_question(configTable)
	self._questionConfig = configTable
end

function NecrologistStoryV4A0Config:onLoadhero_story_mode_v4a0_option(configTable)
	self._optionConfig = configTable
end

function NecrologistStoryV4A0Config:onLoadhero_story_mode_v4a0_result(configTable)
	self._resultConfig = configTable
end

function NecrologistStoryV4A0Config:getBaseList()
	return self._baseConfig.configList
end

function NecrologistStoryV4A0Config:getBaseConfig(id)
	return self._baseConfig.configDict[id]
end

function NecrologistStoryV4A0Config:getQuestionConfig(id)
	return self._questionConfig.configDict[id]
end

function NecrologistStoryV4A0Config:getOptionConfig(id)
	return self._optionConfig.configDict[id]
end

function NecrologistStoryV4A0Config:getResultList()
	return self._resultConfig.configList
end

NecrologistStoryV4A0Config.instance = NecrologistStoryV4A0Config.New()

return NecrologistStoryV4A0Config
