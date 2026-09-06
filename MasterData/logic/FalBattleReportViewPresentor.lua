-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/landlords/view/FalBattleReportViewPresentor.lua

module("logic.extensions.landlords.view.FalBattleReportViewPresentor", package.seeall)

local FalBattleReportViewPresentor = class("FalBattleReportViewPresentor", ViewPresentor)

function FalBattleReportViewPresentor:ctor()
	FalBattleReportViewPresentor.super.ctor(self)
end

function FalBattleReportViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FalBattleReportViewPresentor:dependWhatResources()
	return {
		"ui/views/landlords/falbattlereportview.prefab"
	}
end

function FalBattleReportViewPresentor:buildViews()
	return {
		FalBattleReportView.New()
	}
end

return FalBattleReportViewPresentor
