-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonking/view/DragonkingchallengeViewPresentor.lua

module("logic.extensions.dragonking.view.DragonkingchallengeViewPresentor", package.seeall)

local DragonkingchallengeViewPresentor = class("DragonkingchallengeViewPresentor", ViewPresentor)

function DragonkingchallengeViewPresentor:ctor()
	DragonkingchallengeViewPresentor.super.ctor(self)
end

function DragonkingchallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonkingchallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/dragonking/dragonkingchallengeview.prefab"
	}
end

function DragonkingchallengeViewPresentor:buildViews()
	return {
		DragonkingchallengeView.New()
	}
end

return DragonkingchallengeViewPresentor
