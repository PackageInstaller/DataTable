-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pinball/view/PinBallGameViewPresentor.lua

module("logic.extensions.pinball.view.PinBallGameViewPresentor", package.seeall)

local PinBallGameViewPresentor = class("PinBallGameViewPresentor", ViewPresentor)

function PinBallGameViewPresentor:ctor()
	PinBallGameViewPresentor.super.ctor(self)
end

function PinBallGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PinBallGameViewPresentor:dependWhatResources()
	return {
		"ui/views/pinball/pinballgameview.prefab"
	}
end

function PinBallGameViewPresentor:buildViews()
	return {
		PinBallGameView.New()
	}
end

return PinBallGameViewPresentor
