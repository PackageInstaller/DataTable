-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/TimelinitedcheatsViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.TimelinitedcheatsViewPresentor", package.seeall)

local TimelinitedcheatsViewPresentor = class("TimelinitedcheatsViewPresentor", ViewPresentor)

function TimelinitedcheatsViewPresentor:ctor()
	TimelinitedcheatsViewPresentor.super.ctor(self)
end

function TimelinitedcheatsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TimelinitedcheatsViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/timelinitedcheatsview.prefab"
	}
end

function TimelinitedcheatsViewPresentor:buildViews()
	return {
		TimelinitedcheatsView.New()
	}
end

return TimelinitedcheatsViewPresentor
