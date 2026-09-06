-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceRemindPresentor.lua

module("logic.extensions.rankrace.view.RankRaceRemindPresentor", package.seeall)

local RankRaceRemindPresentor = class("RankRaceRemindPresentor", ViewPresentor)

function RankRaceRemindPresentor:ctor()
	RankRaceRemindPresentor.super.ctor(self)
end

function RankRaceRemindPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RankRaceRemindPresentor:dependWhatResources()
	return {
		"ui/views/rankrace/rankraceremindview.prefab"
	}
end

function RankRaceRemindPresentor:buildViews()
	return {
		RankRaceRemindView.New()
	}
end

return RankRaceRemindPresentor
