-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timewheel/view/TimeWheelDetailViewPresentor.lua

module("logic.extensions.timewheel.view.TimeWheelDetailViewPresentor", package.seeall)

local TimeWheelDetailViewPresentor = class("TimeWheelDetailViewPresentor", ViewPresentor)

function TimeWheelDetailViewPresentor:ctor()
	TimeWheelDetailViewPresentor.super.ctor(self)
end

function TimeWheelDetailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TimeWheelDetailViewPresentor:dependWhatResources()
	return {
		"ui/views/timewheel/timewheeldetailview.prefab"
	}
end

function TimeWheelDetailViewPresentor:buildViews()
	return {
		TimeWheelDetailView.New()
	}
end

return TimeWheelDetailViewPresentor
