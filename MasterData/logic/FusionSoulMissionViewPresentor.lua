-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fusionsoul/view/FusionSoulMissionViewPresentor.lua

module("logic.extensions.fusionsoul.view.FusionSoulMissionViewPresentor", package.seeall)

local FusionSoulMissionViewPresentor = class("FusionSoulMissionViewPresentor", ViewPresentor)

function FusionSoulMissionViewPresentor:ctor()
	FusionSoulMissionViewPresentor.super.ctor(self)
end

function FusionSoulMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FusionSoulMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/fusionsoul/fusionsoulmissionview.prefab"
	}
end

function FusionSoulMissionViewPresentor:buildViews()
	return {
		FusionSoulMissionView.New()
	}
end

return FusionSoulMissionViewPresentor
