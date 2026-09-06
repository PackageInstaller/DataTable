-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pinball/view/PinBallMainViewPresentor.lua

module("logic.extensions.pinball.view.PinBallMainViewPresentor", package.seeall)

local PinBallMainViewPresentor = class("PinBallMainViewPresentor", ViewPresentor)

function PinBallMainViewPresentor:ctor()
	PinBallMainViewPresentor.super.ctor(self)
end

function PinBallMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PinBallMainViewPresentor:dependWhatResources()
	return {
		"ui/views/pinball/pinballmainview.prefab"
	}
end

function PinBallMainViewPresentor:buildViews()
	return {
		PinBallMainView.New()
	}
end

return PinBallMainViewPresentor
