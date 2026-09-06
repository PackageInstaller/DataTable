-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mahjongbattle/view/MahjongBattleReportViewPresentor.lua

module("logic.extensions.mahjongbattle.view.MahjongBattleReportViewPresentor", package.seeall)

local MahjongBattleReportViewPresentor = class("MahjongBattleReportViewPresentor", ViewPresentor)

function MahjongBattleReportViewPresentor:ctor()
	MahjongBattleReportViewPresentor.super.ctor(self)
end

function MahjongBattleReportViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MahjongBattleReportViewPresentor:dependWhatResources()
	return {
		"ui/views/mahjongbattle/mahjongbattlereportview.prefab"
	}
end

function MahjongBattleReportViewPresentor:buildViews()
	return {
		MahjongBattleReportView.New()
	}
end

return MahjongBattleReportViewPresentor
