-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceMyInfoPresentor.lua

module("logic.extensions.rankrace.view.RankRaceMyInfoPresentor", package.seeall)

local RankRaceMyInfoPresentor = class("RankRaceMyInfoPresentor", ViewPresentor)

function RankRaceMyInfoPresentor:ctor()
	RankRaceMyInfoPresentor.super.ctor(self)
end

function RankRaceMyInfoPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RankRaceMyInfoPresentor:dependWhatResources()
	return {
		"ui/views/rankrace/rankracemyinfoview.prefab"
	}
end

function RankRaceMyInfoPresentor:buildViews()
	return {
		RankRaceMyInfoView.New()
	}
end

return RankRaceMyInfoPresentor
