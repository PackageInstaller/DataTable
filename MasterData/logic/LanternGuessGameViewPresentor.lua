-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lanternriddle/view/LanternGuessGameViewPresentor.lua

module("logic.extensions.lanternriddle.view.LanternGuessGameViewPresentor", package.seeall)

local LanternGuessGameViewPresentor = class("LanternGuessGameViewPresentor", ViewPresentor)

function LanternGuessGameViewPresentor:ctor()
	LanternGuessGameViewPresentor.super.ctor(self)
end

function LanternGuessGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LanternGuessGameViewPresentor:dependWhatResources()
	return {
		"ui/views/guesslantern/guesslanternanswerview.prefab"
	}
end

function LanternGuessGameViewPresentor:buildViews()
	return {
		LanternGuessGameView.New()
	}
end

return LanternGuessGameViewPresentor
