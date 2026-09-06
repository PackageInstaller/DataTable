-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/youlie/YoulieMainViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.youlie.YoulieMainViewPresentor", package.seeall)

local YoulieMainViewPresentor = class("YoulieMainViewPresentor", ViewPresentor)

function YoulieMainViewPresentor:ctor()
	YoulieMainViewPresentor.super.ctor(self)
end

function YoulieMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YoulieMainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/youlie/youliemainview.prefab"
	}
end

function YoulieMainViewPresentor:buildViews()
	return {
		YoulieMainView.New()
	}
end

return YoulieMainViewPresentor
