-- chunkname: @modules/logic/versionactivity3_7/wmz/config/Activity220SimpleBaseConfig.lua

module("modules.logic.versionactivity3_7.wmz.config.Activity220SimpleBaseConfig", package.seeall)

local Activity220SimpleBaseConfig = class("Activity220SimpleBaseConfig", BaseConfig)

function Activity220SimpleBaseConfig:ctor()
	self.__activityId = false
end

function Activity220SimpleBaseConfig:actId()
	assert(false, "please override this function")
end

function Activity220SimpleBaseConfig:taskType()
	return TaskEnum.TaskType.Activity220
end

function Activity220SimpleBaseConfig:reqConfigNames()
	return {
		"activity220_const",
		"activity220_episode",
		"activity220_task"
	}
end

function Activity220SimpleBaseConfig:onConfigLoaded(configName, configTable)
	if configName == "activity220_episode" then
		self.__activityId = false
	end
end

function Activity220SimpleBaseConfig:getEpisodeConfig(episodeId)
	return Activity220Config.instance:getEpisodeConfig(self:actId(), episodeId)
end

function Activity220SimpleBaseConfig:getAllEpisodeConfigMap()
	return Activity220Config.instance:getAllEpisodeConfigMap(self:actId())
end

function Activity220SimpleBaseConfig:getEpisodeConfigList()
	return Activity220Config.instance:getEpisodeConfigList(self:actId())
end

function Activity220SimpleBaseConfig:getEpisodeIndex(episodeId)
	return Activity220Config.instance:getEpisodeIndex(self:actId(), episodeId)
end

function Activity220SimpleBaseConfig:getAllActivityTaskConfigList()
	return Activity220Config.instance:getAllActivityTaskConfigList(self:actId())
end

function Activity220SimpleBaseConfig:bHasGame(episodeId)
	local gameId = self:getEpisodeCO_gameId(episodeId)

	return gameId ~= 0
end

function Activity220SimpleBaseConfig:getEpisodeCO_gameId(episodeId)
	local CO = self:getEpisodeConfig(episodeId)

	return (CO or nil) and (CO.gameId or 0)
end

function Activity220SimpleBaseConfig:getPreStoryId(episodeId)
	local CO = self:getEpisodeConfig(episodeId)

	return (CO or nil) and (CO.storyBefore or 0)
end

function Activity220SimpleBaseConfig:getPostStoryId(episodeId)
	local CO = self:getEpisodeConfig(episodeId)

	return (CO or nil) and (CO.storyClear or 0)
end

function Activity220SimpleBaseConfig:getStoryIdPrePost(episodeId)
	local CO = self:getEpisodeConfig(episodeId)

	if not CO then
		return 0, 0
	end

	return CO.storyBefore, CO.storyClear
end

return Activity220SimpleBaseConfig
