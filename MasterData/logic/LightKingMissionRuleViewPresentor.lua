-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lightking/LightKingMissionRuleViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.lightking.LightKingMissionRuleViewPresentor", package.seeall)

local LightKingMissionRuleViewPresentor = class("LightKingMissionRuleViewPresentor", ViewPresentor)

function LightKingMissionRuleViewPresentor:ctor()
	LightKingMissionRuleViewPresentor.super.ctor(self)
end

function LightKingMissionRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LightKingMissionRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/lightking/lightkingruleview.prefab"
	}
end

function LightKingMissionRuleViewPresentor:buildViews()
	return {
		LightKingMissionRuleView.New()
	}
end

return LightKingMissionRuleViewPresentor
