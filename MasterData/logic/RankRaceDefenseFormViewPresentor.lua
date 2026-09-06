-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceDefenseFormViewPresentor.lua

module("logic.extensions.rankrace.view.RankRaceDefenseFormViewPresentor", package.seeall)

local RankRaceDefenseFormViewPresentor = class("RankRaceDefenseFormViewPresentor", ViewPresentor)

function RankRaceDefenseFormViewPresentor:ctor()
	RankRaceDefenseFormViewPresentor.super.ctor(self)
end

function RankRaceDefenseFormViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RankRaceDefenseFormViewPresentor:dependWhatResources()
	return {
		"ui/views/formation/formationview.prefab",
		"ui/views/rankrace/rankracefmtbuffs.prefab"
	}
end

function RankRaceDefenseFormViewPresentor:buildViews()
	return {
		RankRaceDefenseFormFmtLeftView.New(),
		RankRaceDefenseFmtRightView.New(),
		RankRaceDefenseFormView.New(true)
	}
end

return RankRaceDefenseFormViewPresentor
