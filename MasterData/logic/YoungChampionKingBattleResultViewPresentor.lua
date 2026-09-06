-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/view/YoungChampionKingBattleResultViewPresentor.lua

module("logic.extensions.youngchampionking.view.YoungChampionKingBattleResultViewPresentor", package.seeall)

local YoungChampionKingBattleResultViewPresentor = class("YoungChampionKingBattleResultViewPresentor", ViewPresentor)

function YoungChampionKingBattleResultViewPresentor:ctor()
	YoungChampionKingBattleResultViewPresentor.super.ctor(self)
end

function YoungChampionKingBattleResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YoungChampionKingBattleResultViewPresentor:dependWhatResources()
	return {
		"ui/views/youngchampionking/youngchampionkingbattleresultview.prefab"
	}
end

function YoungChampionKingBattleResultViewPresentor:buildViews()
	return {
		YoungChampionKingBattleResultView.New()
	}
end

return YoungChampionKingBattleResultViewPresentor
