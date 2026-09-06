-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doubleeleven/view/DayrechargeViewPresentor.lua

module("logic.extensions.doubleeleven.view.DayrechargeViewPresentor", package.seeall)

local DayrechargeViewPresentor = class("DayrechargeViewPresentor", ViewPresentor)

function DayrechargeViewPresentor:ctor()
	DayrechargeViewPresentor.super.ctor(self)
end

function DayrechargeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DayrechargeViewPresentor:dependWhatResources()
	return {
		"ui/views/doubleeleven/dayrechargeview.prefab"
	}
end

function DayrechargeViewPresentor:buildViews()
	return {
		DayrechargeView.New()
	}
end

return DayrechargeViewPresentor
