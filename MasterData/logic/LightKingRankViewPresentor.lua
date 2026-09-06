-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lightking/LightKingRankViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.lightking.LightKingRankViewPresentor", package.seeall)

local LightKingRankViewPresentor = class("LightKingRankViewPresentor", ViewPresentor)

function LightKingRankViewPresentor:ctor()
	LightKingRankViewPresentor.super.ctor(self)
end

function LightKingRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LightKingRankViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/lightking/lightkingrankview.prefab"
	}
end

function LightKingRankViewPresentor:buildViews()
	return {
		LightKingRankView.New()
	}
end

return LightKingRankViewPresentor
