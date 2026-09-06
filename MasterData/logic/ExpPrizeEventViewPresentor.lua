-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/view/ExpPrizeEventViewPresentor.lua

module("logic.extensions.expedition.view.ExpPrizeEventViewPresentor", package.seeall)

local ExpPrizeEventViewPresentor = class("ExpPrizeEventViewPresentor", ViewPresentor)

function ExpPrizeEventViewPresentor:ctor()
	ExpPrizeEventViewPresentor.super.ctor(self)
end

function ExpPrizeEventViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExpPrizeEventViewPresentor:dependWhatResources()
	return {
		"ui/views/expedition/prizeeventview.prefab"
	}
end

function ExpPrizeEventViewPresentor:buildViews()
	return {
		ExpPrizeEventView.New()
	}
end

return ExpPrizeEventViewPresentor
