-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timewheel/view/TimeWheelExchangeViewPresentor.lua

module("logic.extensions.timewheel.view.TimeWheelExchangeViewPresentor", package.seeall)

local TimeWheelExchangeViewPresentor = class("TimeWheelExchangeViewPresentor", ViewPresentor)

function TimeWheelExchangeViewPresentor:ctor()
	TimeWheelExchangeViewPresentor.super.ctor(self)
end

function TimeWheelExchangeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TimeWheelExchangeViewPresentor:dependWhatResources()
	return {
		"ui/views/timewheel/timewheelexchangeview.prefab"
	}
end

function TimeWheelExchangeViewPresentor:buildViews()
	return {
		TimeWheelExchangeView.New()
	}
end

return TimeWheelExchangeViewPresentor
