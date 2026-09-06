-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lailisi/view/xingluo/XingluoScoreRankViewPresentor.lua

module("logic.extensions.lailisi.view.xingluo.XingluoScoreRankViewPresentor", package.seeall)

local XingluoScoreRankViewPresentor = class("XingluoScoreRankViewPresentor", ViewPresentor)

function XingluoScoreRankViewPresentor:ctor()
	XingluoScoreRankViewPresentor.super.ctor(self)
end

function XingluoScoreRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XingluoScoreRankViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/xingluo/xingluoscorerankview.prefab"
	}
end

function XingluoScoreRankViewPresentor:buildViews()
	return {
		XingluoScoreRankView.New()
	}
end

return XingluoScoreRankViewPresentor
