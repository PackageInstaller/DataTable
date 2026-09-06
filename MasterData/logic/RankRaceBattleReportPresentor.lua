-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceBattleReportPresentor.lua

module("logic.extensions.rankrace.view.RankRaceBattleReportPresentor", package.seeall)

local RankRaceBattleReportPresentor = class("RankRaceBattleReportPresentor", ViewPresentor)

function RankRaceBattleReportPresentor:ctor()
	RankRaceBattleReportPresentor.super.ctor(self)
end

function RankRaceBattleReportPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RankRaceBattleReportPresentor:dependWhatResources()
	return {
		"ui/views/rankrace/rankracebattlereportview.prefab"
	}
end

function RankRaceBattleReportPresentor:buildViews()
	return {
		RankRaceBattleReportView.New()
	}
end

return RankRaceBattleReportPresentor
