-- chunkname: @modules/logic/versionactivity3_4/chg/config/ChgConfig.lua

module("modules.logic.versionactivity3_4.chg.config.ChgConfig", package.seeall)

local ChgConfig = class("ChgConfig", BaseConfig)

function ChgConfig:ctor()
	self.__activityId = false
end

function ChgConfig:reqConfigNames()
	return {
		"activity176_bubble",
		"activity176_episode",
		"activity176_dogtag"
	}
end

function ChgConfig:onConfigLoaded(configName, configTable)
	if configName == "activity176_episode" then
		self.__activityId = false
	end
end

function ChgConfig:actId()
	if self.__activityId then
		return self.__activityId
	end

	self.__activityId = ActivityConfig.instance:getConstAsNum(10, 13439)

	return self.__activityId
end

function ChgConfig:getStoryLevelList()
	return RoleActivityConfig.instance:getStoryLevelList(self:actId())
end

function ChgConfig:getElementCoByEpisodeId(episodeId)
	return Activity176Config.instance:getElementCo(self:actId(), episodeId)
end

function ChgConfig:getElementCo(elementId)
	return lua_chapter_map_element.configDict[elementId]
end

function ChgConfig:getEpisodeCO(episodeId)
	return DungeonConfig.instance:getEpisodeCO(episodeId)
end

ChgConfig.instance = ChgConfig.New()

return ChgConfig
