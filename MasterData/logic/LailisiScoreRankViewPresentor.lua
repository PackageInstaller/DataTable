-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lailisi/view/LailisiScoreRankViewPresentor.lua

module("logic.extensions.lailisi.view.LailisiScoreRankViewPresentor", package.seeall)

local LailisiScoreRankViewPresentor = class("LailisiScoreRankViewPresentor", ViewPresentor)

function LailisiScoreRankViewPresentor:ctor()
	LailisiScoreRankViewPresentor.super.ctor(self)
end

function LailisiScoreRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LailisiScoreRankViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/lailisi/lailisiscorerankview.prefab"
	}
end

function LailisiScoreRankViewPresentor:buildViews()
	return {
		LailisiScoreRankView.New()
	}
end

return LailisiScoreRankViewPresentor
