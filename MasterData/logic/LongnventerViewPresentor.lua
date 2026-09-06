-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/longnv/LongnventerViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.longnv.LongnventerViewPresentor", package.seeall)

local LongnventerViewPresentor = class("LongnventerViewPresentor", ViewPresentor)

function LongnventerViewPresentor:ctor()
	LongnventerViewPresentor.super.ctor(self)
end

function LongnventerViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LongnventerViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/longnv/longnventerview.prefab"
	}
end

function LongnventerViewPresentor:buildViews()
	return {
		LongnventerView.New()
	}
end

return LongnventerViewPresentor
