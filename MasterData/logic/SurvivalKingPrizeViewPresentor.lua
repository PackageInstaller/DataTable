-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalking/view/SurvivalKingPrizeViewPresentor.lua

module("logic.extensions.survivalking.view.SurvivalKingPrizeViewPresentor", package.seeall)

local SurvivalKingPrizeViewPresentor = class("SurvivalKingPrizeViewPresentor", ViewPresentor)

function SurvivalKingPrizeViewPresentor:ctor()
	SurvivalKingPrizeViewPresentor.super.ctor(self)
end

function SurvivalKingPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SurvivalKingPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/survivalking/survivalkingprizeview.prefab"
	}
end

function SurvivalKingPrizeViewPresentor:buildViews()
	return {
		SurvivalKingPrizeView.New()
	}
end

return SurvivalKingPrizeViewPresentor
