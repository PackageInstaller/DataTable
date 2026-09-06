-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonlords/view/DragonLimitChallengeViewPresentor.lua

module("logic.extensions.dragonlords.view.DragonLimitChallengeViewPresentor", package.seeall)

local DragonLimitChallengeViewPresentor = class("DragonLimitChallengeViewPresentor", ViewPresentor)

function DragonLimitChallengeViewPresentor:ctor()
	DragonLimitChallengeViewPresentor.super.ctor(self)
end

function DragonLimitChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonLimitChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/dragonlords/dragonlimitchallengeview.prefab"
	}
end

function DragonLimitChallengeViewPresentor:buildViews()
	return {
		DragonLimitChallengeView.New()
	}
end

return DragonLimitChallengeViewPresentor
