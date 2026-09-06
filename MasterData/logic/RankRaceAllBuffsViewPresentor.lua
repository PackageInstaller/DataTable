-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceAllBuffsViewPresentor.lua

module("logic.extensions.rankrace.view.RankRaceAllBuffsViewPresentor", package.seeall)

local RankRaceAllBuffsViewPresentor = class("RankRaceAllBuffsViewPresentor", ViewPresentor)

function RankRaceAllBuffsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RankRaceAllBuffsViewPresentor:dependWhatResources()
	return {
		"ui/views/rankrace/rankraceallbuffs.prefab"
	}
end

function RankRaceAllBuffsViewPresentor:buildViews()
	return {
		RankRaceAllBuffsView.New()
	}
end

return RankRaceAllBuffsViewPresentor
