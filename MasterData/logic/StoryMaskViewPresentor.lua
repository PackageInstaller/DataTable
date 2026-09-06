-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/StoryMaskViewPresentor.lua

module("logic.extensions.story.view.StoryMaskViewPresentor", package.seeall)

local StoryMaskViewPresentor = class("StoryMaskViewPresentor", ViewPresentor)

function StoryMaskViewPresentor:ctor()
	StoryMaskViewPresentor.super.ctor(self)

	self.priority = ViewPriorityMgr.StoryMaskViewPriority
end

function StoryMaskViewPresentor:attachToWhichRoot()
	return nil
end

function StoryMaskViewPresentor:dependWhatResources()
	return {
		"ui/views/story/story_mask.prefab"
	}
end

function StoryMaskViewPresentor:buildViews()
	local views = {}
	local storyMaskView = StoryMaskView.New()

	table.insert(views, storyMaskView)

	return views
end

function StoryMaskViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return StoryMaskViewPresentor
