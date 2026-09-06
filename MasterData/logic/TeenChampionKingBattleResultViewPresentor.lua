-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TeenChampionKingBattleResultViewPresentor.lua

module("logic.extensions.teenchampionking.view.TeenChampionKingBattleResultViewPresentor", package.seeall)

local TeenChampionKingBattleResultViewPresentor = class("TeenChampionKingBattleResultViewPresentor", ViewPresentor)

function TeenChampionKingBattleResultViewPresentor:ctor()
	TeenChampionKingBattleResultViewPresentor.super.ctor(self)
end

function TeenChampionKingBattleResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TeenChampionKingBattleResultViewPresentor:dependWhatResources()
	return {
		"ui/views/teenchampionking/teenchampionkingbattleresultview.prefab"
	}
end

function TeenChampionKingBattleResultViewPresentor:buildViews()
	return {
		TeenChampionKingBattleResultView.New()
	}
end

return TeenChampionKingBattleResultViewPresentor
