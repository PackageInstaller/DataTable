-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mahjongbattle/view/MahjongBattleMatchViewPresentor.lua

module("logic.extensions.mahjongbattle.view.MahjongBattleMatchViewPresentor", package.seeall)

local MahjongBattleMatchViewPresentor = class("MahjongBattleMatchViewPresentor", ViewPresentor)

MahjongBattleMatchViewPresentor.AniSpine = "character/majiang/majiang_04/majiang_04-ui_p.prefab"

function MahjongBattleMatchViewPresentor:ctor()
	MahjongBattleMatchViewPresentor.super.ctor(self)
end

function MahjongBattleMatchViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MahjongBattleMatchViewPresentor:dependWhatResources()
	return {
		"ui/views/mahjongbattle/mahjongbattlematchview.prefab",
		MahjongBattleMatchViewPresentor.AniSpine
	}
end

function MahjongBattleMatchViewPresentor:buildViews()
	return {
		MahjongBattleMatchView.New()
	}
end

return MahjongBattleMatchViewPresentor
