-- chunkname: @modules/logic/explore/controller/trigger/ExploreTriggerStory.lua

module("modules.logic.explore.controller.trigger.ExploreTriggerStory", package.seeall)

local ExploreTriggerStory = class("ExploreTriggerStory", ExploreTriggerBase)

function ExploreTriggerStory:handle(id)
	id = tonumber(id)

	logNormal("触发剧情：" .. id)
	StoryController.instance:playStory(id, nil, self.playStoryEnd, self)
end

function ExploreTriggerStory:playStoryEnd()
	self:onDone(true)
end

return ExploreTriggerStory
