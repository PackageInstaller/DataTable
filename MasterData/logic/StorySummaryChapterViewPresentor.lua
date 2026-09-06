-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/storysummary/view/StorySummaryChapterViewPresentor.lua

module("logic.extensions.storysummary.view.StorySummaryChapterViewPresentor", package.seeall)

local StorySummaryChapterViewPresentor = class("StorySummaryChapterViewPresentor", ViewPresentor)

function StorySummaryChapterViewPresentor:ctor()
	StorySummaryChapterViewPresentor.super.ctor(self)
end

function StorySummaryChapterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StorySummaryChapterViewPresentor:dependWhatResources()
	return {
		"ui/views/storysummary/storysummarychapterview.prefab"
	}
end

function StorySummaryChapterViewPresentor:buildViews()
	return {
		StorySummaryChapterView.New()
	}
end

return StorySummaryChapterViewPresentor
