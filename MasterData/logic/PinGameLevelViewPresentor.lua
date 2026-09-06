-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pingame/view/PinGameLevelViewPresentor.lua

module("logic.extensions.pingame.view.PinGameLevelViewPresentor", package.seeall)

local PinGameLevelViewPresentor = class("PinGameLevelViewPresentor", ViewPresentor)

function PinGameLevelViewPresentor:ctor()
	PinGameLevelViewPresentor.super.ctor(self)
end

function PinGameLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PinGameLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/pingame/pingamelevelview.prefab"
	}
end

function PinGameLevelViewPresentor:buildViews()
	return {
		PinGameLevelView.New()
	}
end

return PinGameLevelViewPresentor
