-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timewheel/view/TimeWheelSelectViewPresentor.lua

module("logic.extensions.timewheel.view.TimeWheelSelectViewPresentor", package.seeall)

local TimeWheelSelectViewPresentor = class("TimeWheelSelectViewPresentor", ViewPresentor)

function TimeWheelSelectViewPresentor:ctor()
	TimeWheelSelectViewPresentor.super.ctor(self)
end

function TimeWheelSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TimeWheelSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/timewheel/timewheelselectview.prefab"
	}
end

function TimeWheelSelectViewPresentor:buildViews()
	return {
		TimeWheelSelectView.New()
	}
end

return TimeWheelSelectViewPresentor
