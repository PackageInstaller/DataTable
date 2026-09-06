-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stknexp/view/StKnExpRankTabStageViewPresentor.lua

module("logic.extensions.stknexp.view.StKnExpRankTabStageViewPresentor", package.seeall)

local StKnExpRankTabStageViewPresentor = class("StKnExpRankTabStageViewPresentor", ViewPresentor)

function StKnExpRankTabStageViewPresentor:ctor()
	StKnExpRankTabStageViewPresentor.super.ctor(self)
end

function StKnExpRankTabStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StKnExpRankTabStageViewPresentor:dependWhatResources()
	return {
		"ui/views/stknexp/stknexpranktabstageview.prefab"
	}
end

function StKnExpRankTabStageViewPresentor:buildViews()
	return {
		StKnExpRankTabStageView.New()
	}
end

function StKnExpRankTabStageViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return StKnExpRankTabStageViewPresentor
