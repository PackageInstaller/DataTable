-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/competitionking/view/CompetitionkingRankPrizePopWinViewPresentor.lua

module("logic.extensions.competitionking.view.CompetitionkingRankPrizePopWinViewPresentor", package.seeall)

local CompetitionkingRankPrizePopWinViewPresentor = class("CompetitionkingRankPrizePopWinViewPresentor", ViewPresentor)

function CompetitionkingRankPrizePopWinViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function CompetitionkingRankPrizePopWinViewPresentor:dependWhatResources()
	return {
		"ui/views/competitionking/competitionkingrankprizepopwinview.prefab"
	}
end

function CompetitionkingRankPrizePopWinViewPresentor:buildViews()
	return {
		CompetitionkingRankPrizePopWinView.New()
	}
end

return CompetitionkingRankPrizePopWinViewPresentor
