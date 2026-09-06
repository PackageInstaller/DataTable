-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceRewardPresentor.lua

module("logic.extensions.rankrace.view.RankRaceRewardPresentor", package.seeall)

local RankRaceRewardPresentor = class("RankRaceRewardPresentor", ViewPresentor)

function RankRaceRewardPresentor:ctor()
	RankRaceRewardPresentor.super.ctor(self)
end

function RankRaceRewardPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RankRaceRewardPresentor:dependWhatResources()
	return {
		"ui/views/rankrace/rankracerewardview.prefab"
	}
end

function RankRaceRewardPresentor:buildViews()
	return {
		RankRaceRewardView.New()
	}
end

return RankRaceRewardPresentor
