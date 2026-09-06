-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/storysummary/view/StorySummaryPalaceViewPresentor.lua

module("logic.extensions.storysummary.view.ExchangeSelectViewPresentor", package.seeall)

local ExchangeSelectViewPresentor = class("ExchangeSelectViewPresentor", ViewPresentor)

function ExchangeSelectViewPresentor:ctor()
	ExchangeSelectViewPresentor.super.ctor(self)
end

function ExchangeSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExchangeSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/storysummary/storysummarypalaceview.prefab"
	}
end

function ExchangeSelectViewPresentor:buildViews()
	return {
		StorySummaryPalaceView.New()
	}
end

return ExchangeSelectViewPresentor
