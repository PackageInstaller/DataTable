-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summarytabstory/view/SummaryTabStoryViewPresentor.lua

module("logic.extensions.summarytabstory.view.SummaryTabStoryViewPresentor", package.seeall)

local SummaryTabStoryViewPresentor = class("SummaryTabStoryViewPresentor", ViewPresentor)

function SummaryTabStoryViewPresentor:ctor()
	SummaryTabStoryViewPresentor.super.ctor(self)
end

function SummaryTabStoryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SummaryTabStoryViewPresentor:dependWhatResources()
	return {
		"ui/views/storytabsummary/summarytabstoryview.prefab"
	}
end

function SummaryTabStoryViewPresentor:buildViews()
	return {
		SummaryTabStoryView.New()
	}
end

return SummaryTabStoryViewPresentor
