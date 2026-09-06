-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weakpathfinding/view/WeakPathFindingSearchViewPresentor.lua

module("logic.extensions.weakpathfinding.view.WeakPathFindingSearchViewPresentor", package.seeall)

local WeakPathFindingSearchViewPresentor = class("WeakPathFindingSearchViewPresentor", ViewPresentor)

function WeakPathFindingSearchViewPresentor:ctor()
	WeakPathFindingSearchViewPresentor.super.ctor(self)
end

function WeakPathFindingSearchViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WeakPathFindingSearchViewPresentor:dependWhatResources()
	return {
		"ui/views/weakpathfinding/weakpathfindingsearchview.prefab"
	}
end

function WeakPathFindingSearchViewPresentor:buildViews()
	return {
		WeakPathFindingSearchView.New()
	}
end

return WeakPathFindingSearchViewPresentor
