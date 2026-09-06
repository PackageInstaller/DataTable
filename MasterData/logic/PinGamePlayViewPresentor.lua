-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pingame/view/PinGamePlayViewPresentor.lua

module("logic.extensions.pingame.view.PinGamePlayViewPresentor", package.seeall)

local PinGamePlayViewPresentor = class("PinGamePlayViewPresentor", ViewPresentor)

function PinGamePlayViewPresentor:ctor()
	PinGamePlayViewPresentor.super.ctor(self)
end

function PinGamePlayViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PinGamePlayViewPresentor:dependWhatResources()
	return {
		"ui/views/pingame/pingameplayview.prefab"
	}
end

function PinGamePlayViewPresentor:buildViews()
	return {
		PinGamePlayView.New()
	}
end

return PinGamePlayViewPresentor
