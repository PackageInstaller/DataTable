-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/TimeLimitedEntranceViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.TimeLimitedEntranceViewPresentor", package.seeall)

local TimeLimitedEntranceViewPresentor = class("TimeLimitedEntranceViewPresentor", ViewPresentor)

function TimeLimitedEntranceViewPresentor:ctor()
	TimeLimitedEntranceViewPresentor.super.ctor(self)
end

function TimeLimitedEntranceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TimeLimitedEntranceViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/timelimitedentranceview.prefab"
	}
end

function TimeLimitedEntranceViewPresentor:buildViews()
	return {
		TimeLimitedEntranceView.New()
	}
end

return TimeLimitedEntranceViewPresentor
