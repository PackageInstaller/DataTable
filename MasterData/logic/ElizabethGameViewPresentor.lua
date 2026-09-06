-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/elizabeth/ElizabethGameViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.elizabeth.ElizabethGameViewPresentor", package.seeall)

local ElizabethGameViewPresentor = class("ElizabethGameViewPresentor", ViewPresentor)

function ElizabethGameViewPresentor:ctor()
	ElizabethGameViewPresentor.super.ctor(self)
end

function ElizabethGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElizabethGameViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/elizabeth/elizabethgameview.prefab"
	}
end

function ElizabethGameViewPresentor:buildViews()
	return {
		ElizabethGameView.New()
	}
end

return ElizabethGameViewPresentor
