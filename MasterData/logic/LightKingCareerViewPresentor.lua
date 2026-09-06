-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lightking/LightKingCareerViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.lightking.LightKingCareerViewPresentor", package.seeall)

local LightKingCareerViewPresentor = class("LightKingCareerViewPresentor", ViewPresentor)

function LightKingCareerViewPresentor:ctor()
	LightKingCareerViewPresentor.super.ctor(self)
end

function LightKingCareerViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function LightKingCareerViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/lightking/lightkingcareerview.prefab"
	}
end

function LightKingCareerViewPresentor:buildViews()
	return {
		LightKingCareerView.New()
	}
end

return LightKingCareerViewPresentor
