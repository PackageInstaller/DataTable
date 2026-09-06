-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/view/UltimateWarTowerBossViewPresentor.lua

module("logic.extensions.ultimatewar.view.UltimateWarTowerBossViewPresentor", package.seeall)

local UltimateWarTowerBossViewPresentor = class("UltimateWarTowerBossViewPresentor", ViewPresentor)

function UltimateWarTowerBossViewPresentor:ctor()
	UltimateWarTowerBossViewPresentor.super.ctor(self)
end

function UltimateWarTowerBossViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function UltimateWarTowerBossViewPresentor:dependWhatResources()
	return {
		"ui/views/ultimatewar/ultimatewartowerbossview.prefab"
	}
end

function UltimateWarTowerBossViewPresentor:buildViews()
	return {
		UltimateWarTowerBossView.New()
	}
end

return UltimateWarTowerBossViewPresentor
