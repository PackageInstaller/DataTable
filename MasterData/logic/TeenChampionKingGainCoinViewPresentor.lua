-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TeenChampionKingGainCoinViewPresentor.lua

module("logic.extensions.teenchampionking.view.TeenChampionKingGainCoinViewPresentor", package.seeall)

local TeenChampionKingGainCoinViewPresentor = class("TeenChampionKingGainCoinViewPresentor", ViewPresentor)

function TeenChampionKingGainCoinViewPresentor:ctor()
	TeenChampionKingGainCoinViewPresentor.super.ctor(self)
end

function TeenChampionKingGainCoinViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TeenChampionKingGainCoinViewPresentor:dependWhatResources()
	return {
		"ui/views/teenchampionking/teenchampionkinggaincoinview.prefab"
	}
end

function TeenChampionKingGainCoinViewPresentor:buildViews()
	return {
		TeenChampionKingGainCoinView.New()
	}
end

return TeenChampionKingGainCoinViewPresentor
