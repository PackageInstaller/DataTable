-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/geargame/view/GearGameGameViewPresentor.lua

module("logic.extensions.geargame.view.GearGameGameViewPresentor", package.seeall)

local GearGameGameViewPresentor = class("GearGameGameViewPresentor", ViewPresentor)

function GearGameGameViewPresentor:ctor()
	GearGameGameViewPresentor.super.ctor(self)
end

function GearGameGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GearGameGameViewPresentor:dependWhatResources()
	return {
		"ui/views/geargame/geargamegameview.prefab"
	}
end

function GearGameGameViewPresentor:buildViews()
	return {
		GearGameGameView.New()
	}
end

return GearGameGameViewPresentor
