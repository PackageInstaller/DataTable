-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mahjongbattle/view/MahjongBattleBuffViewPresentor.lua

module("logic.extensions.mahjongbattle.view.MahjongBattleBuffViewPresentor", package.seeall)

local MahjongBattleBuffViewPresentor = class("MahjongBattleBuffViewPresentor", ViewPresentor)

function MahjongBattleBuffViewPresentor:ctor()
	MahjongBattleBuffViewPresentor.super.ctor(self)
end

function MahjongBattleBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MahjongBattleBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/mahjongbattle/mahjongbattlebuffview.prefab"
	}
end

function MahjongBattleBuffViewPresentor:buildViews()
	return {
		MahjongBattleBuffView.New()
	}
end

return MahjongBattleBuffViewPresentor
