-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timecapsule/view/TimecapsuleViewPresentor.lua

module("logic.extensions.timecapsule.view.TimecapsuleViewPresentor", package.seeall)

local TimecapsuleViewPresentor = class("TimecapsuleViewPresentor", ViewPresentor)

function TimecapsuleViewPresentor:ctor()
	TimecapsuleViewPresentor.super.ctor(self)
end

function TimecapsuleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TimecapsuleViewPresentor:dependWhatResources()
	return {
		"ui/views/timecapsule/timecapsuleview.prefab"
	}
end

function TimecapsuleViewPresentor:buildViews()
	return {
		TimeCapsuleView.New()
	}
end

return TimecapsuleViewPresentor
