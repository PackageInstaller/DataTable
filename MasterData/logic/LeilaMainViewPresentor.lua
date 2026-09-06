-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/leila/LeilaMainViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.leila.LeilaMainViewPresentor", package.seeall)

local LeilaMainViewPresentor = class("LeilaMainViewPresentor", ViewPresentor)

function LeilaMainViewPresentor:ctor()
	LeilaMainViewPresentor.super.ctor(self)
end

function LeilaMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LeilaMainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/leila/leilamainview.prefab"
	}
end

function LeilaMainViewPresentor:buildViews()
	return {
		LeilaMainView.New()
	}
end

return LeilaMainViewPresentor
