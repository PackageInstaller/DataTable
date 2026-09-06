-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunwukongchallenge/view/SunWuKongChallengeRewardViewPresentor.lua

module("logic.extensions.sunwukongchallenge.view.SunWuKongChallengeRewardViewPresentor", package.seeall)

local SunWuKongChallengeRewardViewPresentor = class("SunWuKongChallengeRewardViewPresentor", ViewPresentor)

function SunWuKongChallengeRewardViewPresentor:ctor()
	SunWuKongChallengeRewardViewPresentor.super.ctor(self)
end

function SunWuKongChallengeRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SunWuKongChallengeRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/sunwukongchallenge/sunwukongchallengerewardview.prefab"
	}
end

function SunWuKongChallengeRewardViewPresentor:buildViews()
	return {
		SunWuKongChallengeRewardView.New()
	}
end

return SunWuKongChallengeRewardViewPresentor
