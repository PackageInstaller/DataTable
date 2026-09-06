-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/view/YoungChampionKingGainCoinViewPresentor.lua

module("logic.extensions.youngchampionking.view.YoungChampionKingGainCoinViewPresentor", package.seeall)

local YoungChampionKingGainCoinViewPresentor = class("YoungChampionKingGainCoinViewPresentor", ViewPresentor)

function YoungChampionKingGainCoinViewPresentor:ctor()
	YoungChampionKingGainCoinViewPresentor.super.ctor(self)
end

function YoungChampionKingGainCoinViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YoungChampionKingGainCoinViewPresentor:dependWhatResources()
	return {
		"ui/views/youngchampionking/youngchampionkinggaincoinview.prefab"
	}
end

function YoungChampionKingGainCoinViewPresentor:buildViews()
	return {
		YoungChampionKingGainCoinView.New()
	}
end

return YoungChampionKingGainCoinViewPresentor
