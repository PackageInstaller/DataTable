-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalking/view/SurvivalKingBattleLogViewPresentor.lua

module("logic.extensions.survivalking.view.SurvivalKingBattleLogViewPresentor", package.seeall)

local SurvivalKingBattleLogViewPresentor = class("SurvivalKingBattleLogViewPresentor", ViewPresentor)

function SurvivalKingBattleLogViewPresentor:ctor()
	SurvivalKingBattleLogViewPresentor.super.ctor(self)
end

function SurvivalKingBattleLogViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SurvivalKingBattleLogViewPresentor:dependWhatResources()
	return {
		"ui/views/survivalking/survivalkingbattlelogview.prefab"
	}
end

function SurvivalKingBattleLogViewPresentor:buildViews()
	return {
		SurvivalKingBattleLogView.New()
	}
end

return SurvivalKingBattleLogViewPresentor
