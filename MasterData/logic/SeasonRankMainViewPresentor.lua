-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonRankMainViewPresentor.lua

module("logic.extensions.season.view.SeasonRankMainViewPresentor", package.seeall)

local SeasonRankMainViewPresentor = class("SeasonRankMainViewPresentor", ViewPresentor)

function SeasonRankMainViewPresentor:ctor()
	SeasonRankMainViewPresentor.super.ctor(self)
end

function SeasonRankMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonRankMainViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonrankmainview.prefab"
	}
end

function SeasonRankMainViewPresentor:buildViews()
	return {
		SeasonRankMainView.New()
	}
end

return SeasonRankMainViewPresentor
