-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingarena/view/rank/KingArenaFightRankTimesViewPresentor.lua

module("logic.extensions.kingarena.view.rank.KingArenaFightRankTimesViewPresentor", package.seeall)

local KingArenaFightRankTimesViewPresentor = class("KingArenaFightRankTimesViewPresentor", ViewPresentor)

function KingArenaFightRankTimesViewPresentor:ctor()
	KingArenaFightRankTimesViewPresentor.super.ctor(self)
end

function KingArenaFightRankTimesViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingArenaFightRankTimesViewPresentor:dependWhatResources()
	return {
		"ui/views/kingarena/rank/kingarenafightranktimesview.prefab"
	}
end

function KingArenaFightRankTimesViewPresentor:buildViews()
	return {
		KingArenaFightRankTimesView.New()
	}
end

function KingArenaFightRankTimesViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return KingArenaFightRankTimesViewPresentor
