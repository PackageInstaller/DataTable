-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ashechallenge/view/LuxifaMainViewPresentor.lua

module("logic.extensions.ashechallenge.view.LuxifaMainViewPresentor", package.seeall)

local LuxifaMainViewPresentor = class("LuxifaMainViewPresentor", ViewPresentor)

function LuxifaMainViewPresentor:ctor()
	LuxifaMainViewPresentor.super.ctor(self)
end

function LuxifaMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuxifaMainViewPresentor:dependWhatResources()
	return {
		"ui/views/ashechallenge/luxifamainview.prefab"
	}
end

function LuxifaMainViewPresentor:buildViews()
	return {
		LuxifaMainView.New()
	}
end

return LuxifaMainViewPresentor
