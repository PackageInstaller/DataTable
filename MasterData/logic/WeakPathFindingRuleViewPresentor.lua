-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weakpathfinding/view/WeakPathFindingRuleViewPresentor.lua

module("logic.extensions.weakpathfinding.view.WeakPathFindingRuleViewPresentor", package.seeall)

local WeakPathFindingRuleViewPresentor = class("WeakPathFindingRuleViewPresentor", ViewPresentor)

function WeakPathFindingRuleViewPresentor:ctor()
	WeakPathFindingRuleViewPresentor.super.ctor(self)
end

function WeakPathFindingRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WeakPathFindingRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/weakpathfinding/weakpathfindingruleview.prefab"
	}
end

function WeakPathFindingRuleViewPresentor:buildViews()
	return {
		WeakPathFindingRuleView.New()
	}
end

return WeakPathFindingRuleViewPresentor
