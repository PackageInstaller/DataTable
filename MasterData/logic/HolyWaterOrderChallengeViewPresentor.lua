-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holywaterorder/view/HolyWaterOrderChallengeViewPresentor.lua

module("logic.extensions.holywaterorder.view.HolyWaterOrderChallengeViewPresentor", package.seeall)

local HolyWaterOrderChallengeViewPresentor = class("HolyWaterOrderChallengeViewPresentor", ViewPresentor)

function HolyWaterOrderChallengeViewPresentor:ctor()
	HolyWaterOrderChallengeViewPresentor.super.ctor(self)
end

function HolyWaterOrderChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyWaterOrderChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/holywaterorder/holywaterorderchallengeview.prefab"
	}
end

function HolyWaterOrderChallengeViewPresentor:buildViews()
	return {
		HolyWaterOrderChallengeView.New()
	}
end

return HolyWaterOrderChallengeViewPresentor
