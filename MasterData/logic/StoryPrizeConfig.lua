-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/storyprize/config/StoryPrizeConfig.lua

module("logic.extensions.storyprize.config.StoryPrizeConfig", package.seeall)

local StoryPrizeConfig = class("StoryPrizeConfig", BaseConfig)

function StoryPrizeConfig:getNames()
	return {
		"story_prize"
	}
end

function StoryPrizeConfig:handleConfig(name, content)
	if name == "story_prize" then
		self._story_prize = content
	end
end

function StoryPrizeConfig:getStoryPrizeCfg(storyId)
	return self._story_prize[storyId]
end

StoryPrizeConfig.instance = StoryPrizeConfig.New()

return StoryPrizeConfig
