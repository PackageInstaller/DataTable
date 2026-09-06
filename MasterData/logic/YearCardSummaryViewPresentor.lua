-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/YearCardSummaryViewPresentor.lua

module("logic.extensions.yearcard.view.YearCardSummaryViewPresentor", package.seeall)

local YearCardSummaryViewPresentor = class("YearCardSummaryViewPresentor", ViewPresentor)

function YearCardSummaryViewPresentor:ctor()
	YearCardSummaryViewPresentor.super.ctor(self)
end

function YearCardSummaryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardSummaryViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard/yearcardsummaryview.prefab"
	}
end

function YearCardSummaryViewPresentor:buildViews()
	return {
		YearCardSummaryView.New()
	}
end

return YearCardSummaryViewPresentor
