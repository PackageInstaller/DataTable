-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/reviveelizabeth/view/ReviveElizabethStoryViewPresentor.lua

module("logic.extensions.reviveelizabeth.view.ReviveElizabethStoryViewPresentor", package.seeall)

local ReviveElizabethStoryViewPresentor = class("ReviveElizabethStoryViewPresentor", ViewPresentor)

function ReviveElizabethStoryViewPresentor:ctor()
	ReviveElizabethStoryViewPresentor.super.ctor(self)
end

function ReviveElizabethStoryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ReviveElizabethStoryViewPresentor:dependWhatResources()
	return {
		"ui/views/reviveelizabeth/reviveelizabethstoryview.prefab"
	}
end

function ReviveElizabethStoryViewPresentor:buildViews()
	return {
		ReviveElizabethStoryView.New()
	}
end

return ReviveElizabethStoryViewPresentor
