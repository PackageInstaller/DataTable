-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/longnv/LongnvtowerViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.longnv.LongnvtowerViewPresentor", package.seeall)

local LongnvtowerViewPresentor = class("LongnvtowerViewPresentor", ViewPresentor)

function LongnvtowerViewPresentor:ctor()
	LongnvtowerViewPresentor.super.ctor(self)
end

function LongnvtowerViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LongnvtowerViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/longnv/longnvtowerview.prefab"
	}
end

function LongnvtowerViewPresentor:buildViews()
	return {
		LongnvtowerView.New()
	}
end

return LongnvtowerViewPresentor
