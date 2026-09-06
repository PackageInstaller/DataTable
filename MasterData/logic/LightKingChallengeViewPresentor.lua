-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lightking/LightKingChallengeViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.lightking.LightKingChallengeViewPresentor", package.seeall)

local LightKingChallengeViewPresentor = class("LightKingChallengeViewPresentor", ViewPresentor)

function LightKingChallengeViewPresentor:ctor()
	LightKingChallengeViewPresentor.super.ctor(self)
end

function LightKingChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LightKingChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/lightking/lightkingchallengeview.prefab",
		"ui/views/timelimitedchallenge/lightking/lightkingshengguangview.prefab",
		"ui/views/timelimitedchallenge/lightking/lightkingyaoshiview.prefab",
		"ui/views/timelimitedchallenge/lightking/lightkingjixianview.prefab"
	}
end

function LightKingChallengeViewPresentor:buildViews()
	return {
		LightKingChallengeView.New()
	}
end

return LightKingChallengeViewPresentor
