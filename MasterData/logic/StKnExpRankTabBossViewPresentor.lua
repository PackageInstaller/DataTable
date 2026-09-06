-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stknexp/view/StKnExpRankTabBossViewPresentor.lua

module("logic.extensions.stknexp.view.StKnExpRankTabBossViewPresentor", package.seeall)

local StKnExpRankTabBossViewPresentor = class("StKnExpRankTabBossViewPresentor", ViewPresentor)

function StKnExpRankTabBossViewPresentor:ctor()
	StKnExpRankTabBossViewPresentor.super.ctor(self)
end

function StKnExpRankTabBossViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StKnExpRankTabBossViewPresentor:dependWhatResources()
	return {
		"ui/views/stknexp/stknexpranktabbossview.prefab"
	}
end

function StKnExpRankTabBossViewPresentor:buildViews()
	return {
		StKnExpRankTabBossView.New()
	}
end

function StKnExpRankTabBossViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return StKnExpRankTabBossViewPresentor
