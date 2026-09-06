-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceHistoryPresentor.lua

module("logic.extensions.rankrace.view.RankRaceHistoryPresentor", package.seeall)

local RankRaceHistoryPresentor = class("RankRaceHistoryPresentor", ViewPresentor)

function RankRaceHistoryPresentor:ctor()
	RankRaceHistoryPresentor.super.ctor(self)
end

function RankRaceHistoryPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RankRaceHistoryPresentor:dependWhatResources()
	return {
		"ui/views/rankrace/rankracehistoryview.prefab"
	}
end

function RankRaceHistoryPresentor:buildViews()
	return {
		RankRaceHistoryView.New()
	}
end

return RankRaceHistoryPresentor
