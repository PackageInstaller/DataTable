-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timewheel/view/TimeWheelWhiteListViewPresentor.lua

module("logic.extensions.timewheel.view.TimeWheelWhiteListViewPresentor", package.seeall)

local TimeWheelWhiteListViewPresentor = class("TimeWheelWhiteListViewPresentor", ViewPresentor)

function TimeWheelWhiteListViewPresentor:ctor()
	TimeWheelWhiteListViewPresentor.super.ctor(self)
end

function TimeWheelWhiteListViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function TimeWheelWhiteListViewPresentor:dependWhatResources()
	return {
		"ui/views/timewheel/timewheelwhitelistview.prefab"
	}
end

function TimeWheelWhiteListViewPresentor:buildViews()
	return {
		TimeWheelWhiteListView.New()
	}
end

return TimeWheelWhiteListViewPresentor
