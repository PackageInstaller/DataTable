-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/StoryViewPresentor.lua

module("logic.extensions.story.view.StoryViewPresentor", package.seeall)

local StoryViewPresentor = class("StoryViewPresentor", ViewPresentor)

function StoryViewPresentor:ctor()
	StoryViewPresentor.super.ctor(self)

	self.priority = ViewPriorityMgr.StoryViewPriority
end

function StoryViewPresentor:attachToWhichRoot()
	return nil
end

function StoryViewPresentor:dependWhatResources()
	return {
		"ui/views/story/story.prefab",
		CommonResPath.UIStoryBkg
	}
end

function StoryViewPresentor:buildViews()
	local views = {}
	local storyView = StoryView.New()
	local interactiveView = StoryInteractiveView.New()

	table.insert(views, interactiveView)
	table.insert(views, storyView)

	return views
end

function StoryViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return StoryViewPresentor
