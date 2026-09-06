-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceResultViewPresentor.lua

module("logic.extensions.rankrace.view.RankRaceResultViewPresentor", package.seeall)

local RankRaceResultViewPresentor = class("RankRaceResultViewPresentor", ViewPresentor)

function RankRaceResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RankRaceResultViewPresentor:dependWhatResources()
	return {
		"ui/views/rankrace/rankraceresult.prefab"
	}
end

function RankRaceResultViewPresentor:buildViews()
	return {
		RankRaceResultView.New()
	}
end

return RankRaceResultViewPresentor
