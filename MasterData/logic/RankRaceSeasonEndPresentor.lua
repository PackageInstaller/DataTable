-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceSeasonEndPresentor.lua

module("logic.extensions.rankrace.view.RankRaceSeasonEndPresentor", package.seeall)

local RankRaceSeasonEndPresentor = class("RankRaceSeasonEndPresentor", ViewPresentor)

function RankRaceSeasonEndPresentor:ctor()
	RankRaceSeasonEndPresentor.super.ctor(self)
end

function RankRaceSeasonEndPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RankRaceSeasonEndPresentor:dependWhatResources()
	return {
		"ui/views/rankrace/rankraceseasonendview.prefab"
	}
end

function RankRaceSeasonEndPresentor:buildViews()
	return {
		RankRaceSeasonEndView.New()
	}
end

return RankRaceSeasonEndPresentor
