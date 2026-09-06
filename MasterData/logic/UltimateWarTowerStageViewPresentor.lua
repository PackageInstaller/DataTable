-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/view/UltimateWarTowerStageViewPresentor.lua

module("logic.extensions.ultimatewar.view.UltimateWarTowerStageViewPresentor", package.seeall)

local UltimateWarTowerStageViewPresentor = class("UltimateWarTowerStageViewPresentor", ViewPresentor)

function UltimateWarTowerStageViewPresentor:ctor()
	UltimateWarTowerStageViewPresentor.super.ctor(self)
end

function UltimateWarTowerStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function UltimateWarTowerStageViewPresentor:dependWhatResources()
	return {
		"ui/views/ultimatewar/ultimatewartowerstageview.prefab"
	}
end

function UltimateWarTowerStageViewPresentor:buildViews()
	return {
		UltimateWarTowerStageView.New()
	}
end

return UltimateWarTowerStageViewPresentor
