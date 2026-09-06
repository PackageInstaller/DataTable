-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/clearstargame/view/ClearStarGameViewPresentor.lua

module("logic.extensions.clearstargame.view.ClearStarGameViewPresentor", package.seeall)

local ClearStarGameViewPresentor = class("ClearStarGameViewPresentor", ViewPresentor)

function ClearStarGameViewPresentor:ctor()
	ClearStarGameViewPresentor.super.ctor(self)
end

function ClearStarGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ClearStarGameViewPresentor:dependWhatResources()
	return {
		"ui/views/clearstar/clearstargameview.prefab"
	}
end

function ClearStarGameViewPresentor:buildViews()
	return {
		ClearStarGameView.New()
	}
end

return ClearStarGameViewPresentor
