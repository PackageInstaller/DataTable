-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalking/view/SurvivalKingRankViewPresentor.lua

module("logic.extensions.survivalking.view.SurvivalKingRankViewPresentor", package.seeall)

local SurvivalKingRankViewPresentor = class("SurvivalKingRankViewPresentor", ViewPresentor)

function SurvivalKingRankViewPresentor:ctor()
	SurvivalKingRankViewPresentor.super.ctor(self)
end

function SurvivalKingRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SurvivalKingRankViewPresentor:dependWhatResources()
	return {
		"ui/views/survivalking/survivalkingrankview.prefab"
	}
end

function SurvivalKingRankViewPresentor:buildViews()
	return {
		SurvivalKingRankView.New()
	}
end

return SurvivalKingRankViewPresentor
