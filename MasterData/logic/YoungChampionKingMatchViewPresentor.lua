-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/view/YoungChampionKingMatchViewPresentor.lua

module("logic.extensions.youngchampionking.view.YoungChampionKingMatchViewPresentor", package.seeall)

local YoungChampionKingMatchViewPresentor = class("YoungChampionKingMatchViewPresentor", ViewPresentor)

function YoungChampionKingMatchViewPresentor:ctor()
	YoungChampionKingMatchViewPresentor.super.ctor(self)
end

function YoungChampionKingMatchViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YoungChampionKingMatchViewPresentor:dependWhatResources()
	return {
		"ui/views/youngchampionking/youngchampionkingmatchview.prefab"
	}
end

function YoungChampionKingMatchViewPresentor:buildViews()
	return {
		YoungChampionKingMatchView.New()
	}
end

return YoungChampionKingMatchViewPresentor
