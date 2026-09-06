-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/storysummary/view/StorySummaryPartViewPresentor.lua

module("logic.extensions.storysummary.view.StorySummaryPartViewPresentor", package.seeall)

local StorySummaryPartViewPresentor = class("StorySummaryPartViewPresentor", ViewPresentor)

function StorySummaryPartViewPresentor:ctor()
	StorySummaryPartViewPresentor.super.ctor(self)
end

function StorySummaryPartViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StorySummaryPartViewPresentor:dependWhatResources()
	return {
		"ui/views/storysummary/storysummarypartview.prefab"
	}
end

function StorySummaryPartViewPresentor:buildViews()
	return {
		StorySummaryPartView.New()
	}
end

return StorySummaryPartViewPresentor
