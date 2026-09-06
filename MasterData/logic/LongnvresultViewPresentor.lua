-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/longnv/LongnvresultViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.longnv.LongnvresultViewPresentor", package.seeall)

local LongnvresultViewPresentor = class("LongnvresultViewPresentor", ViewPresentor)

function LongnvresultViewPresentor:ctor()
	LongnvresultViewPresentor.super.ctor(self)
end

function LongnvresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LongnvresultViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/longnv/longnvresultview.prefab"
	}
end

function LongnvresultViewPresentor:buildViews()
	return {
		LongnvresultView.New()
	}
end

return LongnvresultViewPresentor
