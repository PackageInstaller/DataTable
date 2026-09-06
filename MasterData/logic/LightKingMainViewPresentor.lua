-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lightking/LightKingMainViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.lightking.LightKingMainViewPresentor", package.seeall)

local LightKingMainViewPresentor = class("LightKingMainViewPresentor", ViewPresentor)

function LightKingMainViewPresentor:ctor()
	LightKingMainViewPresentor.super.ctor(self)
end

function LightKingMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LightKingMainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/lightking/lightkingmainview.prefab"
	}
end

function LightKingMainViewPresentor:buildViews()
	return {
		LightKingMainView.New()
	}
end

return LightKingMainViewPresentor
