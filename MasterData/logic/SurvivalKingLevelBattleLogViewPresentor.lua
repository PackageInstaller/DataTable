-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalking/view/SurvivalKingLevelBattleLogViewPresentor.lua

module("logic.extensions.survivalking.view.SurvivalKingLevelBattleLogViewPresentor", package.seeall)

local SurvivalKingLevelBattleLogViewPresentor = class("SurvivalKingLevelBattleLogViewPresentor", ViewPresentor)

function SurvivalKingLevelBattleLogViewPresentor:ctor()
	SurvivalKingLevelBattleLogViewPresentor.super.ctor(self)
end

function SurvivalKingLevelBattleLogViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SurvivalKingLevelBattleLogViewPresentor:dependWhatResources()
	return {
		"ui/views/survivalking/survivalkingbattlelogview.prefab"
	}
end

function SurvivalKingLevelBattleLogViewPresentor:buildViews()
	return {
		SurvivalKingLevelBattleLogView.New()
	}
end

return SurvivalKingLevelBattleLogViewPresentor
