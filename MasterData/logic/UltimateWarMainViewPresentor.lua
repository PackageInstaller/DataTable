-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/view/UltimateWarMainViewPresentor.lua

module("logic.extensions.ultimatewar.view.UltimateWarMainViewPresentor", package.seeall)

local UltimateWarMainViewPresentor = class("UltimateWarMainViewPresentor", ViewPresentor)

function UltimateWarMainViewPresentor:ctor()
	UltimateWarMainViewPresentor.super.ctor(self)
end

function UltimateWarMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function UltimateWarMainViewPresentor:dependWhatResources()
	return {
		"ui/views/ultimatewar/ultimatewarmainview.prefab"
	}
end

function UltimateWarMainViewPresentor:buildViews()
	return {
		UltimateWarMainView.New()
	}
end

return UltimateWarMainViewPresentor
