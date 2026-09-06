-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weakpathfinding/view/WeakPathFindingViewPresentor.lua

module("logic.extensions.weakpathfinding.view.WeakPathFindingViewPresentor", package.seeall)

local WeakPathFindingViewPresentor = class("WeakPathFindingViewPresentor", ViewPresentor)

function WeakPathFindingViewPresentor:ctor()
	WeakPathFindingViewPresentor.super.ctor(self)
end

function WeakPathFindingViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WeakPathFindingViewPresentor:dependWhatResources()
	return {
		"ui/views/weakpathfinding/weakpathfindingview.prefab"
	}
end

function WeakPathFindingViewPresentor:buildViews()
	return {
		WeakPathFindingView.New()
	}
end

return WeakPathFindingViewPresentor
