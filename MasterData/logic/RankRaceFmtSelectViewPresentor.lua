-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceFmtSelectViewPresentor.lua

module("logic.extensions.rankrace.view.RankRaceFmtSelectViewPresentor", package.seeall)

local RankRaceFmtSelectViewPresentor = class("RankRaceFmtSelectViewPresentor", ViewPresentor)

function RankRaceFmtSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RankRaceFmtSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/rankrace/rankraceformationselect.prefab"
	}
end

function RankRaceFmtSelectViewPresentor:buildViews()
	return {
		RankRaceFmtSelectView.New()
	}
end

return RankRaceFmtSelectViewPresentor
