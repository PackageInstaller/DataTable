-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mahjongbattle/view/MahjongBattleSelectTeamViewPresentor.lua

module("logic.extensions.mahjongbattle.view.MahjongBattleSelectTeamViewPresentor", package.seeall)

local MahjongBattleSelectTeamViewPresentor = class("MahjongBattleSelectTeamViewPresentor", ViewWithGuidePresentor)

function MahjongBattleSelectTeamViewPresentor:ctor()
	MahjongBattleSelectTeamViewPresentor.super.ctor(self)
end

function MahjongBattleSelectTeamViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MahjongBattleSelectTeamViewPresentor:dependWhatResources()
	return {
		"ui/views/mahjongbattle/mahjongbattleselectteamview.prefab"
	}
end

function MahjongBattleSelectTeamViewPresentor:buildViews()
	return {
		MahjongBattleSelectTeamView.New()
	}
end

return MahjongBattleSelectTeamViewPresentor
