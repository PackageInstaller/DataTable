-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonRankRewardViewPresentor.lua

module("logic.extensions.season.view.SeasonRankRewardViewPresentor", package.seeall)

local SeasonRankRewardViewPresentor = class("SeasonRankRewardViewPresentor", ViewPresentor)

function SeasonRankRewardViewPresentor:ctor()
	SeasonRankRewardViewPresentor.super.ctor(self)
end

function SeasonRankRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonRankRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonrankrewardview.prefab"
	}
end

function SeasonRankRewardViewPresentor:buildViews()
	return {
		SeasonRankRewardView.New()
	}
end

function SeasonRankRewardViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return SeasonRankRewardViewPresentor
