-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceBattleResultViewPresentor.lua

module("logic.extensions.rankrace.view.RankRaceBattleResultViewPresentor", package.seeall)

local RankRaceBattleResultViewPresentor = class("RankRaceBattleResultViewPresentor", ViewPresentor)

function RankRaceBattleResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RankRaceBattleResultViewPresentor:dependWhatResources()
	return {
		"ui/views/rankrace/rankracebattleresult.prefab"
	}
end

function RankRaceBattleResultViewPresentor:buildViews()
	return {
		RankRaceBattleResultView.New()
	}
end

return RankRaceBattleResultViewPresentor
