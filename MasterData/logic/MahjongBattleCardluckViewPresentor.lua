-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mahjongbattle/view/MahjongBattleCardluckViewPresentor.lua

module("logic.extensions.mahjongbattle.view.MahjongBattleCardluckViewPresentor", package.seeall)

local MahjongBattleCardluckViewPresentor = class("MahjongBattleCardluckViewPresentor", ViewPresentor)

function MahjongBattleCardluckViewPresentor:ctor()
	MahjongBattleCardluckViewPresentor.super.ctor(self)
end

function MahjongBattleCardluckViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MahjongBattleCardluckViewPresentor:dependWhatResources()
	return {
		"ui/views/mahjongbattle/mahjongbattlecardluckview.prefab"
	}
end

function MahjongBattleCardluckViewPresentor:buildViews()
	return {
		MahjongBattleCardluckView.New()
	}
end

return MahjongBattleCardluckViewPresentor
