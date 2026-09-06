-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/view/UltimateWarTowerViewPresentor.lua

module("logic.extensions.ultimatewar.view.UltimateWarTowerViewPresentor", package.seeall)

local UltimateWarTowerViewPresentor = class("UltimateWarTowerViewPresentor", ViewPresentor)

function UltimateWarTowerViewPresentor:ctor()
	UltimateWarTowerViewPresentor.super.ctor(self)
end

function UltimateWarTowerViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function UltimateWarTowerViewPresentor:dependWhatResources()
	return {
		"ui/views/ultimatewar/ultimatewartowerview.prefab"
	}
end

function UltimateWarTowerViewPresentor:buildViews()
	return {
		UltimateWarTowerView.New()
	}
end

return UltimateWarTowerViewPresentor
