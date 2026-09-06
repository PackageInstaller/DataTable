-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolammgame/view/DuoLaMMGameViewPresentor.lua

module("logic.extensions.duolammgame.view.DuoLaMMGameViewPresentor", package.seeall)

local DuoLaMMGameViewPresentor = class("DuoLaMMGameViewPresentor", ViewPresentor)

function DuoLaMMGameViewPresentor:ctor()
	DuoLaMMGameViewPresentor.super.ctor(self)
end

function DuoLaMMGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DuoLaMMGameViewPresentor:dependWhatResources()
	return {
		"ui/views/duolammgame/duolammgameview.prefab"
	}
end

function DuoLaMMGameViewPresentor:buildViews()
	return {
		DuoLaMMGameView.New()
	}
end

return DuoLaMMGameViewPresentor
