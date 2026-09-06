-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timewheel/view/TimeWheelViewPresentor.lua

module("logic.extensions.timewheel.view.TimeWheelViewPresentor", package.seeall)

local TimeWheelViewPresentor = class("TimeWheelViewPresentor", ViewWithGuidePresentor)

function TimeWheelViewPresentor:ctor()
	TimeWheelViewPresentor.super.ctor(self)
end

function TimeWheelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TimeWheelViewPresentor:dependWhatResources()
	return {
		"ui/views/timewheel/timewheelview.prefab"
	}
end

function TimeWheelViewPresentor:buildViews()
	return {
		TimeWheelView.New()
	}
end

return TimeWheelViewPresentor
