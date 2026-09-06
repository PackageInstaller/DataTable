-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonlords/view/DragonNationalChallengeViewPresentor.lua

module("logic.extensions.dragonlords.view.DragonNationalChallengeViewPresentor", package.seeall)

local DragonNationalChallengeViewPresentor = class("DragonNationalChallengeViewPresentor", ViewPresentor)

function DragonNationalChallengeViewPresentor:ctor()
	DragonNationalChallengeViewPresentor.super.ctor(self)
end

function DragonNationalChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonNationalChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/dragonlords/dragonnationalchallengeview.prefab"
	}
end

function DragonNationalChallengeViewPresentor:buildViews()
	return {
		DragonNationalChallengeView.New()
	}
end

return DragonNationalChallengeViewPresentor
