-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewroundreport/BattleRoundReportViewPresentor.lua

module("logic.extensions.battle.viewroundreport.BattleRoundReportViewPresentor", package.seeall)

local BattleRoundReportViewPresentor = class("BattleRoundReportViewPresentor", ViewPresentor)

BattleRoundReportViewPresentor.MainUrl = BattleResourceName.UIRoundReport

function BattleRoundReportViewPresentor:dependWhatResources()
	return {
		BattleRoundReportViewPresentor.MainUrl
	}
end

function BattleRoundReportViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BattleRoundReportViewPresentor:buildViews()
	local views = {}

	table.insert(views, BattleRoundReportView.New())

	return views
end

return BattleRoundReportViewPresentor
