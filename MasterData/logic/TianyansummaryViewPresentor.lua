-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/TianyansummaryViewPresentor.lua

module("logic.extensions.operationsummary.view.TianyansummaryViewPresentor", package.seeall)

local TianyansummaryViewPresentor = class("TianyansummaryViewPresentor", ViewPresentor)

function TianyansummaryViewPresentor:ctor()
	TianyansummaryViewPresentor.super.ctor(self)
end

function TianyansummaryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TianyansummaryViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsummary/tianyansummaryview.prefab"
	}
end

function TianyansummaryViewPresentor:buildViews()
	return {
		TianyanSummaryView.New()
	}
end

return TianyansummaryViewPresentor
