-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/view/UltimatewarFinalStartViewPresentor.lua

module("logic.extensions.ultimatewar.view.UltimatewarFinalStartViewPresentor", package.seeall)

local UltimatewarFinalStartViewPresentor = class("UltimatewarFinalStartViewPresentor", ViewPresentor)

function UltimatewarFinalStartViewPresentor:ctor()
	UltimatewarFinalStartViewPresentor.super.ctor(self)
end

function UltimatewarFinalStartViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function UltimatewarFinalStartViewPresentor:dependWhatResources()
	return {
		"ui/views/ultimatewar/ultimatewarfinalstartview.prefab"
	}
end

function UltimatewarFinalStartViewPresentor:buildViews()
	return {
		UltimatewarFinalStartView.New()
	}
end

return UltimatewarFinalStartViewPresentor
