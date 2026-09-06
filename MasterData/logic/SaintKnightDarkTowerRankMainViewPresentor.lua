-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/waterdraktower/view/saintknight/SaintKnightDarkTowerRankMainViewPresentor.lua

module("logic.extensions.waterdraktower.view.saintknight.SaintKnightDarkTowerRankMainViewPresentor", package.seeall)

local SaintKnightDarkTowerRankMainViewPresentor = class("SaintKnightDarkTowerRankMainViewPresentor", ViewPresentor)

function SaintKnightDarkTowerRankMainViewPresentor:ctor()
	SaintKnightDarkTowerRankMainViewPresentor.super.ctor(self)
end

function SaintKnightDarkTowerRankMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SaintKnightDarkTowerRankMainViewPresentor:dependWhatResources()
	return {
		"ui/views/waterdraktower/saintknighttask/saintknightdarktowerrankmainview.prefab"
	}
end

function SaintKnightDarkTowerRankMainViewPresentor:buildViews()
	return {
		SaintKnightDarkTowerRankMainView.New()
	}
end

function SaintKnightDarkTowerRankMainViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return SaintKnightDarkTowerRankMainViewPresentor
