-- chunkname: @modules/logic/explore/controller/steps/ExploreStoryStep.lua

module("modules.logic.explore.controller.steps.ExploreStoryStep", package.seeall)

local ExploreStoryStep = class("ExploreStoryStep", ExploreStepBase)

function ExploreStoryStep:onStart()
	StoryController.instance:playStory(self._data.storyId, nil, self.onDone, self)
end

return ExploreStoryStep
