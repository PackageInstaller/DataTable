-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/longnv/LongnvmainViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.longnv.LongnvmainViewPresentor", package.seeall)

local LongnvmainViewPresentor = class("LongnvmainViewPresentor", ViewPresentor)

function LongnvmainViewPresentor:ctor()
	LongnvmainViewPresentor.super.ctor(self)
end

function LongnvmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LongnvmainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/longnv/longnvmainview.prefab"
	}
end

function LongnvmainViewPresentor:buildViews()
	return {
		LongnvmainView.New()
	}
end

return LongnvmainViewPresentor
