-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/view/UltimateWarTowerBossResultPopViewPresentor.lua

module("logic.extensions.ultimatewar.view.UltimateWarTowerBossResultPopViewPresentor", package.seeall)

local UltimateWarTowerBossResultPopViewPresentor = class("UltimateWarTowerBossResultPopViewPresentor", ViewPresentor)

function UltimateWarTowerBossResultPopViewPresentor:ctor()
	UltimateWarTowerBossResultPopViewPresentor.super.ctor(self)
end

function UltimateWarTowerBossResultPopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function UltimateWarTowerBossResultPopViewPresentor:dependWhatResources()
	return {
		"ui/views/ultimatewar/ultimatewartowerbossresultpopview.prefab"
	}
end

function UltimateWarTowerBossResultPopViewPresentor:buildViews()
	return {
		UltimateWarTowerBossResultPopView.New()
	}
end

return UltimateWarTowerBossResultPopViewPresentor
