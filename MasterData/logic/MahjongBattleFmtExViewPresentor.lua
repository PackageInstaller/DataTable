-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mahjongbattle/view/MahjongBattleFmtExViewPresentor.lua

module("logic.extensions.mahjongbattle.view.MahjongBattleFmtExViewPresentor", package.seeall)

local MahjongBattleFmtExViewPresentor = class("MahjongBattleFmtExViewPresentor", ViewPresentor)

function MahjongBattleFmtExViewPresentor:ctor()
	MahjongBattleFmtExViewPresentor.super.ctor(self)
end

function MahjongBattleFmtExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MahjongBattleFmtExViewPresentor:dependWhatResources()
	return {
		"ui/views/mahjongbattle/mahjongbattlefmtexview.prefab"
	}
end

function MahjongBattleFmtExViewPresentor:buildViews()
	return {
		MahjongBattleFmtExView.New()
	}
end

return MahjongBattleFmtExViewPresentor
