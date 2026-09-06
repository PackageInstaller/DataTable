-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mahjongbattle/view/MahjongBattleDeskViewPresentor.lua

module("logic.extensions.mahjongbattle.view.MahjongBattleDeskViewPresentor", package.seeall)

local MahjongBattleDeskViewPresentor = class("MahjongBattleDeskViewPresentor", ViewPresentor)

function MahjongBattleDeskViewPresentor:ctor()
	MahjongBattleDeskViewPresentor.super.ctor(self)
end

function MahjongBattleDeskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MahjongBattleDeskViewPresentor:dependWhatResources()
	return {
		"ui/views/mahjongbattle/mahjongbattledeskview.prefab"
	}
end

function MahjongBattleDeskViewPresentor:buildViews()
	return {
		MahjongBattleDeskView.New()
	}
end

return MahjongBattleDeskViewPresentor
