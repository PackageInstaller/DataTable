-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/view/RankRewardViewPresentor.lua

module("logic.extensions.rank.view.RankRewardViewPresentor", package.seeall)

local RankRewardViewPresentor = class("RankRewardViewPresentor", ViewPresentor)

function RankRewardViewPresentor:ctor()
	RankRewardViewPresentor.super.ctor(self)
end

function RankRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RankRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/rank/rankrewardview.prefab"
	}
end

function RankRewardViewPresentor:buildViews()
	return {
		RankRewardView.New()
	}
end

return RankRewardViewPresentor
