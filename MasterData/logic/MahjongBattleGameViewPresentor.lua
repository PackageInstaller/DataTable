-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mahjongbattle/view/MahjongBattleGameViewPresentor.lua

module("logic.extensions.mahjongbattle.view.MahjongBattleGameViewPresentor", package.seeall)

local MahjongBattleGameViewPresentor = class("MahjongBattleGameViewPresentor", ViewWithGuidePresentor)

MahjongBattleGameViewPresentor.DrawAniSpine = "character/majiang/majiang_06/majiang_06-ui_p.prefab"
MahjongBattleGameViewPresentor.DiHuAniSpine = "character/majiang/majiang_01/majiang_01-ui_p.prefab"

function MahjongBattleGameViewPresentor:ctor()
	MahjongBattleGameViewPresentor.super.ctor(self)
end

function MahjongBattleGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MahjongBattleGameViewPresentor:dependWhatResources()
	return {
		"ui/views/mahjongbattle/mahjongbattlegameview.prefab",
		MahjongBattleGameViewPresentor.DrawAniSpine,
		MahjongBattleGameViewPresentor.DiHuAniSpine
	}
end

function MahjongBattleGameViewPresentor:buildViews()
	return {
		MahjongBattleGameView.New()
	}
end

return MahjongBattleGameViewPresentor
