-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceDeclarePresentor.lua

module("logic.extensions.rankrace.view.RankRaceDeclarePresentor", package.seeall)

local RankRaceDeclarePresentor = class("RankRaceDeclarePresentor", ViewPresentor)

function RankRaceDeclarePresentor:ctor()
	RankRaceDeclarePresentor.super.ctor(self)
end

function RankRaceDeclarePresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RankRaceDeclarePresentor:dependWhatResources()
	return {
		"ui/views/rankrace/rankracedeclareview.prefab"
	}
end

function RankRaceDeclarePresentor:buildViews()
	return {
		RankRaceDeclareView.New()
	}
end

return RankRaceDeclarePresentor
