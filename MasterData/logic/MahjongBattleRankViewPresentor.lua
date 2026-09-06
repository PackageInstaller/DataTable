-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mahjongbattle/view/MahjongBattleRankViewPresentor.lua

module("logic.extensions.mahjongbattle.view.MahjongBattleRankViewPresentor", package.seeall)

local MahjongBattleRankViewPresentor = class("MahjongBattleRankViewPresentor", ViewPresentor)

function MahjongBattleRankViewPresentor:ctor()
	MahjongBattleRankViewPresentor.super.ctor(self)
end

function MahjongBattleRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MahjongBattleRankViewPresentor:dependWhatResources()
	return {
		"ui/views/mahjongbattle/mahjongbattlerankview.prefab"
	}
end

function MahjongBattleRankViewPresentor:buildViews()
	return {
		MahjongBattleRankView.New()
	}
end

return MahjongBattleRankViewPresentor
