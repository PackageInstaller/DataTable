-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lailisi/view/diana/DianaScoreRankViewPresentor.lua

module("logic.extensions.lailisi.view.diana.DianaScoreRankViewPresentor", package.seeall)

local DianaScoreRankViewPresentor = class("DianaScoreRankViewPresentor", ViewPresentor)

function DianaScoreRankViewPresentor:ctor()
	DianaScoreRankViewPresentor.super.ctor(self)
end

function DianaScoreRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DianaScoreRankViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/diana/dianascorerankview.prefab"
	}
end

function DianaScoreRankViewPresentor:buildViews()
	return {
		DianaScoreRankView.New()
	}
end

return DianaScoreRankViewPresentor
