-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/view/UltimateWarTowerStagePrizeViewPresentor.lua

module("logic.extensions.ultimatewar.view.UltimateWarTowerStagePrizeViewPresentor", package.seeall)

local UltimateWarTowerStagePrizeViewPresentor = class("UltimateWarTowerStagePrizeViewPresentor", ViewPresentor)

function UltimateWarTowerStagePrizeViewPresentor:ctor()
	UltimateWarTowerStagePrizeViewPresentor.super.ctor(self)
end

function UltimateWarTowerStagePrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function UltimateWarTowerStagePrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/ultimatewar/ultimatewartowerstageprizeview.prefab"
	}
end

function UltimateWarTowerStagePrizeViewPresentor:buildViews()
	return {
		UltimateWarTowerStagePrizeView.New()
	}
end

return UltimateWarTowerStagePrizeViewPresentor
