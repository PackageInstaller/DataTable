-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mahjongbattle/view/MahjongBattleSummonViewPresentor.lua

module("logic.extensions.mahjongbattle.view.MahjongBattleSummonViewPresentor", package.seeall)

local MahjongBattleSummonViewPresentor = class("MahjongBattleSummonViewPresentor", ViewWithGuidePresentor)

function MahjongBattleSummonViewPresentor:ctor()
	MahjongBattleSummonViewPresentor.super.ctor(self)
end

function MahjongBattleSummonViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MahjongBattleSummonViewPresentor:dependWhatResources()
	return {
		"ui/views/mahjongbattle/mahjongbattlesummonview.prefab"
	}
end

function MahjongBattleSummonViewPresentor:buildViews()
	return {
		MahjongBattleSummonView.New()
	}
end

return MahjongBattleSummonViewPresentor
