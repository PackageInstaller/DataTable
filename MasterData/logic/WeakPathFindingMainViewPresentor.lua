-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weakpathfinding/view/WeakPathFindingMainViewPresentor.lua

module("logic.extensions.weakpathfinding.view.WeakPathFindingMainViewPresentor", package.seeall)

local WeakPathFindingMainViewPresentor = class("WeakPathFindingMainViewPresentor", ViewPresentor)

function WeakPathFindingMainViewPresentor:ctor()
	WeakPathFindingMainViewPresentor.super.ctor(self)
end

function WeakPathFindingMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WeakPathFindingMainViewPresentor:dependWhatResources()
	return {
		"ui/views/weakpathfinding/weakpathfindingmainview.prefab"
	}
end

function WeakPathFindingMainViewPresentor:buildViews()
	return {
		WeakPathFindingMainView.New()
	}
end

return WeakPathFindingMainViewPresentor
