-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonlords/view/DragonChallengeViewPresentor.lua

module("logic.extensions.dragonlords.view.DragonChallengeViewPresentor", package.seeall)

local DragonChallengeViewPresentor = class("DragonChallengeViewPresentor", ViewPresentor)

function DragonChallengeViewPresentor:ctor()
	DragonChallengeViewPresentor.super.ctor(self)
end

function DragonChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/dragonlords/dragonchallengeview.prefab"
	}
end

function DragonChallengeViewPresentor:buildViews()
	return {
		DragonChallengeView.New()
	}
end

return DragonChallengeViewPresentor
