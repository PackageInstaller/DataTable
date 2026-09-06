-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceMatchSuccPresentor.lua

module("logic.extensions.rankrace.view.RankRaceMatchSuccPresentor", package.seeall)

local RankRaceMatchSuccPresentor = class("RankRaceMatchSuccPresentor", ViewPresentor)

function RankRaceMatchSuccPresentor:ctor()
	RankRaceMatchSuccPresentor.super.ctor(self)
end

function RankRaceMatchSuccPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RankRaceMatchSuccPresentor:dependWhatResources()
	return {
		"ui/views/rankrace/rankracematchsuccview.prefab"
	}
end

function RankRaceMatchSuccPresentor:buildViews()
	return {
		RankRaceMatchSuccView.New()
	}
end

return RankRaceMatchSuccPresentor
