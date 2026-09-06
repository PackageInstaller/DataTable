-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonawaken/view/DragonAwakenFinalChallengeViewPresentor.lua

module("logic.extensions.dragonawaken.view.DragonAwakenFinalChallengeViewPresentor", package.seeall)

local DragonAwakenFinalChallengeViewPresentor = class("DragonAwakenFinalChallengeViewPresentor", ViewPresentor)

function DragonAwakenFinalChallengeViewPresentor:ctor()
	DragonAwakenFinalChallengeViewPresentor.super.ctor(self)
end

function DragonAwakenFinalChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonAwakenFinalChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonawaken/dragonawakenfinalchallengeview.prefab"
	}
end

function DragonAwakenFinalChallengeViewPresentor:buildViews()
	return {
		DragonAwakenFinalChallengeView.New()
	}
end

return DragonAwakenFinalChallengeViewPresentor
