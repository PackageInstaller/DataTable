-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weakpathfinding/view/WeakPathFindingGameViewPresentor.lua

module("logic.extensions.weakpathfinding.view.WeakPathFindingGameViewPresentor", package.seeall)

local WeakPathFindingGameViewPresentor = class("WeakPathFindingGameViewPresentor", ViewPresentor)

function WeakPathFindingGameViewPresentor:ctor()
	WeakPathFindingGameViewPresentor.super.ctor(self)
end

function WeakPathFindingGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WeakPathFindingGameViewPresentor:dependWhatResources()
	return {
		"ui/views/weakpathfinding/weakpathfindinggameview.prefab"
	}
end

function WeakPathFindingGameViewPresentor:buildViews()
	return {
		WeakPathFindingGameView.New()
	}
end

return WeakPathFindingGameViewPresentor
