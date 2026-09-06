-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lordnoah/LordNoahMainViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.lordnoah.LordNoahMainViewPresentor", package.seeall)

local LordNoahMainViewPresentor = class("LordNoahMainViewPresentor", ViewPresentor)

function LordNoahMainViewPresentor:ctor()
	LordNoahMainViewPresentor.super.ctor(self)
end

function LordNoahMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LordNoahMainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/lordnoah/lordnoahmainview.prefab"
	}
end

function LordNoahMainViewPresentor:buildViews()
	return {
		LordNoahMainView.New()
	}
end

return LordNoahMainViewPresentor
