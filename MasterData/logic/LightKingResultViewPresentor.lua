-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lightking/LightKingResultViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.lightking.LightKingResultViewPresentor", package.seeall)

local LightKingResultViewPresentor = class("LightKingResultViewPresentor", ViewPresentor)

function LightKingResultViewPresentor:ctor()
	LightKingResultViewPresentor.super.ctor(self)
end

function LightKingResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function LightKingResultViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/lightking/lightresultview.prefab"
	}
end

function LightKingResultViewPresentor:buildViews()
	return {
		LightKingResultView.New()
	}
end

return LightKingResultViewPresentor
