-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/view/UltimateWarTowerRankPrizeViewPresentor.lua

module("logic.extensions.ultimatewar.view.UltimateWarTowerRankPrizeViewPresentor", package.seeall)

local UltimateWarTowerRankPrizeViewPresentor = class("UltimateWarTowerRankPrizeViewPresentor", ViewPresentor)

function UltimateWarTowerRankPrizeViewPresentor:ctor()
	UltimateWarTowerRankPrizeViewPresentor.super.ctor(self)
end

function UltimateWarTowerRankPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function UltimateWarTowerRankPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/ultimatewar/ultimatewartowerrankprizeview.prefab"
	}
end

function UltimateWarTowerRankPrizeViewPresentor:buildViews()
	return {
		UltimateWarTowerRankPrizeView.New()
	}
end

return UltimateWarTowerRankPrizeViewPresentor
