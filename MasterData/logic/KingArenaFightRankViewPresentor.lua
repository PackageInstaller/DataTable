-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingarena/view/rank/KingArenaFightRankViewPresentor.lua

module("logic.extensions.kingarena.view.rank.KingArenaFightRankViewPresentor", package.seeall)

local KingArenaFightRankViewPresentor = class("KingArenaFightRankViewPresentor", ViewPresentor)

function KingArenaFightRankViewPresentor:ctor()
	KingArenaFightRankViewPresentor.super.ctor(self)
end

function KingArenaFightRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingArenaFightRankViewPresentor:dependWhatResources()
	return {
		"ui/views/kingarena/rank/kingarenafightrankview.prefab"
	}
end

function KingArenaFightRankViewPresentor:buildViews()
	return {
		KingArenaFightRankView.New()
	}
end

function KingArenaFightRankViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return KingArenaFightRankViewPresentor
