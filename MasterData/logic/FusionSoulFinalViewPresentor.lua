-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fusionsoul/view/FusionSoulFinalViewPresentor.lua

module("logic.extensions.fusionsoul.view.FusionSoulFinalViewPresentor", package.seeall)

local FusionSoulFinalViewPresentor = class("FusionSoulFinalViewPresentor", ViewPresentor)

function FusionSoulFinalViewPresentor:ctor()
	FusionSoulFinalViewPresentor.super.ctor(self)
end

function FusionSoulFinalViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FusionSoulFinalViewPresentor:dependWhatResources()
	return {
		"ui/views/fusionsoul/fusionsoulfinalview.prefab"
	}
end

function FusionSoulFinalViewPresentor:buildViews()
	return {
		FusionSoulFinalView.New()
	}
end

return FusionSoulFinalViewPresentor
