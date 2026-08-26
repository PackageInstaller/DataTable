-- chunkname: @modules/logic/story/view/StorySceneViewContainer.lua

module("modules.logic.story.view.StorySceneViewContainer", package.seeall)

local StorySceneViewContainer = class("StorySceneViewContainer", BaseViewContainer)

function StorySceneViewContainer:buildViews()
	local views = {}

	self._storyMainSceneView = StoryMainSceneView.New()

	table.insert(views, self._storyMainSceneView)
	table.insert(views, StorySceneView.New())

	return views
end

function StorySceneViewContainer:getStoryMainSceneView()
	return self._storyMainSceneView
end

return StorySceneViewContainer
