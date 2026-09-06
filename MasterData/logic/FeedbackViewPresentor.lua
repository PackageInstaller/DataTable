-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/feedback/view/FeedbackViewPresentor.lua

module("logic.extensions.feedback.view.FeedbackViewPresentor", package.seeall)

local FeedbackViewPresentor = class("FeedbackViewPresentor", ViewPresentor)

function FeedbackViewPresentor:ctor()
	FeedbackViewPresentor.super.ctor(self)
end

function FeedbackViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FeedbackViewPresentor:dependWhatResources()
	return {
		"ui/views/feedback/feedbackview.prefab"
	}
end

function FeedbackViewPresentor:buildViews()
	return {
		FeedbackView.New()
	}
end

return FeedbackViewPresentor
