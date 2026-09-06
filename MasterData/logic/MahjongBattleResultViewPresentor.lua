-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mahjongbattle/view/MahjongBattleResultViewPresentor.lua

module("logic.extensions.mahjongbattle.view.MahjongBattleResultViewPresentor", package.seeall)

local MahjongBattleResultViewPresentor = class("MahjongBattleResultViewPresentor", ViewPresentor)

function MahjongBattleResultViewPresentor:ctor()
	MahjongBattleResultViewPresentor.super.ctor(self)
end

function MahjongBattleResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MahjongBattleResultViewPresentor:dependWhatResources()
	return {
		"ui/views/mahjongbattle/mahjongbattleresultview.prefab"
	}
end

function MahjongBattleResultViewPresentor:buildViews()
	return {
		MahjongBattleResultView.New()
	}
end

return MahjongBattleResultViewPresentor
