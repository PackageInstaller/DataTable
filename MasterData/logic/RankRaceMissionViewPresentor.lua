-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceMissionViewPresentor.lua

module("logic.extensions.rankrace.view.RankRaceMissionViewPresentor", package.seeall)

local RankRaceMissionViewPresentor = class("RankRaceMissionViewPresentor", MissionViewPresentor)

function RankRaceMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RankRaceMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		"ui/views/rankrace/rankracemissionview.prefab",
		self:_addCommonRes()
	}
end

function RankRaceMissionViewPresentor:buildViews()
	return {
		RankRaceFormationLeftView.New(),
		RankRaceFormationRightView.New(),
		RankRaceMissionFmtView.New(),
		RankRaceMissionView.New()
	}
end

function RankRaceMissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return RankRaceMissionViewPresentor
