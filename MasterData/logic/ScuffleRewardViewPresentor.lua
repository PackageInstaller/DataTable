-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/view/ScuffleRewardViewPresentor.lua

module("logic.extensions.scuffle.view.ScuffleRewardViewPresentor", package.seeall)

local ScuffleRewardViewPresentor = class("ScuffleRewardViewPresentor", ViewPresentor)

function ScuffleRewardViewPresentor:ctor()
	ScuffleRewardViewPresentor.super.ctor(self)
end

function ScuffleRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ScuffleRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/scuffle/scufflerewardview.prefab"
	}
end

function ScuffleRewardViewPresentor:buildViews()
	return {
		ScuffleRewardView.New()
	}
end

return ScuffleRewardViewPresentor
