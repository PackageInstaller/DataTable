-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stknexp/view/StKnExpRankPrizeWinViewPresentor.lua

module("logic.extensions.stknexp.view.StKnExpRankPrizeWinViewPresentor", package.seeall)

local StKnExpRankPrizeWinViewPresentor = class("StKnExpRankPrizeWinViewPresentor", ViewPresentor)

function StKnExpRankPrizeWinViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StKnExpRankPrizeWinViewPresentor:dependWhatResources()
	return {
		"ui/views/stknexp/stknexprankprizewinview.prefab"
	}
end

function StKnExpRankPrizeWinViewPresentor:buildViews()
	return {
		StKnExpRankPrizeWinView.New()
	}
end

return StKnExpRankPrizeWinViewPresentor
