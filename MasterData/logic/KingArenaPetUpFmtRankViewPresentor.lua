-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingarena/view/rank/KingArenaPetUpFmtRankViewPresentor.lua

module("logic.extensions.kingarena.view.rank.KingArenaPetUpFmtRankViewPresentor", package.seeall)

local KingArenaPetUpFmtRankViewPresentor = class("KingArenaPetUpFmtRankViewPresentor", ViewPresentor)

function KingArenaPetUpFmtRankViewPresentor:ctor()
	KingArenaPetUpFmtRankViewPresentor.super.ctor(self)
end

function KingArenaPetUpFmtRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingArenaPetUpFmtRankViewPresentor:dependWhatResources()
	return {
		"ui/views/kingarena/rank/kingarenapetupfmtrankview.prefab"
	}
end

function KingArenaPetUpFmtRankViewPresentor:buildViews()
	return {
		KingArenaPetUpFmtRankView.New()
	}
end

function KingArenaPetUpFmtRankViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return KingArenaPetUpFmtRankViewPresentor
