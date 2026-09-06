-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mahjongbattle/view/MahjongBattleMainViewPresentor.lua

module("logic.extensions.mahjongbattle.view.MahjongBattleMainViewPresentor", package.seeall)

local MahjongBattleMainViewPresentor = class("MahjongBattleMainViewPresentor", ViewPresentor)

function MahjongBattleMainViewPresentor:ctor()
	MahjongBattleMainViewPresentor.super.ctor(self)
end

function MahjongBattleMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MahjongBattleMainViewPresentor:dependWhatResources()
	return {
		"ui/views/mahjongbattle/mahjongbattlemainview.prefab"
	}
end

function MahjongBattleMainViewPresentor:buildViews()
	return {
		MahjongBattleMainView.New()
	}
end

return MahjongBattleMainViewPresentor
