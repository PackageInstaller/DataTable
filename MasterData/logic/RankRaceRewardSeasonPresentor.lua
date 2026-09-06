-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceRewardSeasonPresentor.lua

module("logic.extensions.rankrace.view.RankRaceRewardSeasonPresentor", package.seeall)

local RankRaceRewardSeasonPresentor = class("RankRaceRewardSeasonPresentor", ViewPresentor)

function RankRaceRewardSeasonPresentor:ctor()
	RankRaceRewardSeasonPresentor.super.ctor(self)
end

function RankRaceRewardSeasonPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RankRaceRewardSeasonPresentor:dependWhatResources()
	return {
		"ui/views/rankrace/rankracerewardseasonview.prefab"
	}
end

function RankRaceRewardSeasonPresentor:buildViews()
	return {
		RankRaceRewardSeasonView.New()
	}
end

return RankRaceRewardSeasonPresentor
