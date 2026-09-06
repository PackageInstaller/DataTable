-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ashechallenge/view/LuxifaEnterViewPresentor.lua

module("logic.extensions.ashechallenge.view.LuxifaEnterViewPresentor", package.seeall)

local LuxifaEnterViewPresentor = class("LuxifaEnterViewPresentor", ViewPresentor)

function LuxifaEnterViewPresentor:ctor()
	LuxifaEnterViewPresentor.super.ctor(self)
end

function LuxifaEnterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuxifaEnterViewPresentor:dependWhatResources()
	return {
		"ui/views/ashechallenge/luxifaenterview.prefab"
	}
end

function LuxifaEnterViewPresentor:buildViews()
	return {
		LuxifaEnterView.New()
	}
end

return LuxifaEnterViewPresentor
