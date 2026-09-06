-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/TimelimitedeffectpreViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.TimelimitedeffectpreViewPresentor", package.seeall)

local TimelimitedeffectpreViewPresentor = class("TimelimitedeffectpreViewPresentor", ViewPresentor)

function TimelimitedeffectpreViewPresentor:ctor()
	TimelimitedeffectpreViewPresentor.super.ctor(self)
end

function TimelimitedeffectpreViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TimelimitedeffectpreViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/timelimitedeffectpreview.prefab"
	}
end

function TimelimitedeffectpreViewPresentor:buildViews()
	return {
		TimelimitedeffectpreView.New()
	}
end

return TimelimitedeffectpreViewPresentor
