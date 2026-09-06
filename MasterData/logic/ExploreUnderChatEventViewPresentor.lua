-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exploreunder/view/ExploreUnderChatEventViewPresentor.lua

module("logic.extensions.exploreunder.view.ExploreUnderChatEventViewPresentor", package.seeall)

local ExploreUnderChatEventViewPresentor = class("ExploreUnderChatEventViewPresentor", ViewPresentor)

function ExploreUnderChatEventViewPresentor:ctor()
	ExploreUnderChatEventViewPresentor.super.ctor(self)
end

function ExploreUnderChatEventViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ExploreUnderChatEventViewPresentor:dependWhatResources()
	return {
		"ui/views/exploreunder/exploreunderchateventview.prefab"
	}
end

function ExploreUnderChatEventViewPresentor:buildViews()
	return {
		ExploreUnderChatEventView.New()
	}
end

return ExploreUnderChatEventViewPresentor
