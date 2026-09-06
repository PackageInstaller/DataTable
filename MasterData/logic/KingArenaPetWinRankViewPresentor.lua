-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingarena/view/rank/KingArenaPetWinRankViewPresentor.lua

module("logic.extensions.kingarena.view.rank.KingArenaPetWinRankViewPresentor", package.seeall)

local KingArenaPetWinRankViewPresentor = class("KingArenaPetWinRankViewPresentor", ViewPresentor)

function KingArenaPetWinRankViewPresentor:ctor()
	KingArenaPetWinRankViewPresentor.super.ctor(self)
end

function KingArenaPetWinRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingArenaPetWinRankViewPresentor:dependWhatResources()
	return {
		"ui/views/kingarena/rank/kingarenapetwinrankview.prefab"
	}
end

function KingArenaPetWinRankViewPresentor:buildViews()
	return {
		KingArenaPetWinRankView.New()
	}
end

function KingArenaPetWinRankViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return KingArenaPetWinRankViewPresentor
